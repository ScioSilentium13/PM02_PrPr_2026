using CityAppealsApi;
using CityAppealsApi.Data;
using CityAppealsApi.Models;
using CityAppealsApi.Models.Dto;
using Microsoft.AspNetCore.Mvc.Testing;
using Microsoft.AspNetCore.TestHost;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.DependencyInjection.Extensions;
using NUnit.Framework;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Text.Json;
using System.Threading.Tasks;

namespace IntegrationTests
{
    [TestFixture]
    public class AppealsIntegrationTests
    {
        private WebApplicationFactory<Program> _factory;
        private HttpClient _client;

        [SetUp]
        public void Setup()
        {
            _factory = new WebApplicationFactory<Program>().WithWebHostBuilder(builder =>
            {
                // ВОТ ЭТОТ КЛЮЧЕВОЙ МОМЕНТ: ConfigureTestServices вместо ConfigureServices
                builder.ConfigureTestServices(services =>
                {
                    // Удаляем существующую регистрацию DbContext
                    var descriptor = services.SingleOrDefault(
                        d => d.ServiceType == typeof(DbContextOptions<AppDbContext>));
                    if (descriptor != null)
                        services.Remove(descriptor);

                    // На всякий случай удаляем и сам DbContext, если он зарегистрирован отдельно
                    var dbContextDescriptor = services.SingleOrDefault(
                        d => d.ServiceType == typeof(AppDbContext));
                    if (dbContextDescriptor != null)
                        services.Remove(dbContextDescriptor);

                    // Регистрируем InMemoryDatabase заново
                    services.AddDbContext<AppDbContext>(options =>
                    {
                        options.UseInMemoryDatabase("IntegrationTestDb_" + Guid.NewGuid().ToString()); // Уникальное имя, чтобы тесты не мешали друг другу
                    });
                });
            });

            // Инициализируем базу тестовыми данными ПОСЛЕ создания фабрики
            using (var scope = _factory.Services.CreateScope())
            {
                var db = scope.ServiceProvider.GetRequiredService<AppDbContext>();
                db.Database.EnsureCreated();
                SeedDatabase(db);
            }

            _client = _factory.CreateClient();
        }

        [TearDown]
        public void TearDown()
        {
            _client?.Dispose();
            _factory?.Dispose();
        }

        private void SeedDatabase(AppDbContext db)
        {
            // Добавляем тестовых пользователей
            var admin = new ApplicationUser
            {
                Login = "admin",
                PasswordHash = Convert.ToHexString(System.Security.Cryptography.SHA256.HashData(Encoding.UTF8.GetBytes("admin"))).ToLower(),
                FullName = "Администратор",
                Role = "Администратор",
                IsActive = true,
                CreatedAt = DateTime.Now
            };
            var citizen = new ApplicationUser
            {
                Login = "citizen",
                PasswordHash = Convert.ToHexString(System.Security.Cryptography.SHA256.HashData(Encoding.UTF8.GetBytes("citizen"))).ToLower(),
                FullName = "Гражданин Тестов",
                Role = "Гражданин",
                IsActive = true,
                CreatedAt = DateTime.Now
            };
            var operatorUser = new ApplicationUser
            {
                Login = "operator",
                PasswordHash = Convert.ToHexString(System.Security.Cryptography.SHA256.HashData(Encoding.UTF8.GetBytes("operator"))).ToLower(),
                FullName = "Оператор Тестов",
                Role = "Оператор",
                IsActive = true,
                CreatedAt = DateTime.Now
            };
            db.ApplicationUsers.AddRange(admin, citizen, operatorUser);

            // Добавляем категории и статусы
            db.Categories.AddRange(
                new Category { Name = "ЖКХ", Description = "ЖКХ" },
                new Category { Name = "Благоустройство", Description = "Благоустройство" });
            db.Statuses.AddRange(
                new Status { Name = "Новое", IsFinal = false },
                new Status { Name = "В работе", IsFinal = false },
                new Status { Name = "Закрыто", IsFinal = true });

            db.SaveChanges();
        }

        private void AddAuthHeaders(string login, string password)
        {
            _client.DefaultRequestHeaders.Remove("X-Login");
            _client.DefaultRequestHeaders.Remove("X-Password");
            _client.DefaultRequestHeaders.Add("X-Login", login);
            _client.DefaultRequestHeaders.Add("X-Password", password);
        }

        [Test]
        public async Task RegisterAndLogin_NewUser_CanAccessAuthorizedEndpoint()
        {
            // Регистрация (пароль теперь длиннее и со спецсимволом)
            var registerBody = new StringContent(JsonSerializer.Serialize(new RegisterRequest
            {
                Login = "newuser",
                Password = "Password123!",
                ConfirmPassword = "Password123!",
                FullName = "New User"
            }), Encoding.UTF8, "application/json");
            var regResponse = await _client.PostAsync("/api/auth/register", registerBody);
            Assert.That(regResponse.StatusCode, Is.EqualTo(System.Net.HttpStatusCode.OK));

            // Логин
            var loginBody = new StringContent(JsonSerializer.Serialize(new LoginRequest
            {
                Login = "newuser",
                Password = "Password123!"
            }), Encoding.UTF8, "application/json");
            var loginResponse = await _client.PostAsync("/api/auth/login", loginBody);
            Assert.That(loginResponse.StatusCode, Is.EqualTo(System.Net.HttpStatusCode.OK));

            // Получение категорий (авторизованный эндпоинт)
            AddAuthHeaders("newuser", "Password123!");
            var categoriesResponse = await _client.GetAsync("/api/categories");
            Assert.That(categoriesResponse.StatusCode, Is.EqualTo(System.Net.HttpStatusCode.OK));
            var categories = JsonSerializer.Deserialize<List<JsonElement>>(await categoriesResponse.Content.ReadAsStringAsync());
            Assert.That(categories, Is.Not.Empty);
        }

        [Test]
        public async Task CitizenCanCreateAppeal_AndViewIt()
        {
            AddAuthHeaders("citizen", "citizen");

            // Создаём обращение
            var createBody = new StringContent(JsonSerializer.Serialize(new CreateAppealRequest
            {
                Title = "Тестовое обращение",
                CategoryId = 1
            }), Encoding.UTF8, "application/json");
            var createResponse = await _client.PostAsync("/api/appeals", createBody);
            Assert.That(createResponse.StatusCode, Is.EqualTo(System.Net.HttpStatusCode.Created));
            var created = JsonSerializer.Deserialize<JsonElement>(await createResponse.Content.ReadAsStringAsync());
            int appealId = created.GetProperty("appealID").GetInt32();

            // Получаем список обращений (должно быть только своё)
            var listResponse = await _client.GetAsync("/api/appeals");
            Assert.That(listResponse.StatusCode, Is.EqualTo(System.Net.HttpStatusCode.OK));
            var list = JsonSerializer.Deserialize<List<JsonElement>>(await listResponse.Content.ReadAsStringAsync());
            Assert.That(list.Count, Is.EqualTo(1));
            Assert.That(list[0].GetProperty("appealID").GetInt32(), Is.EqualTo(appealId));
        }

        [Test]
        public async Task OperatorCanAssignExecutorAndChangeStatus()
        {
            // Сначала гражданин создаёт обращение
            AddAuthHeaders("citizen", "citizen");
            var createBody = new StringContent(JsonSerializer.Serialize(new CreateAppealRequest
            {
                Title = "Обращение для назначения",
                CategoryId = 1
            }), Encoding.UTF8, "application/json");
            var createResponse = await _client.PostAsync("/api/appeals", createBody);
            Assert.That(createResponse.StatusCode, Is.EqualTo(System.Net.HttpStatusCode.Created));
            int appealId = JsonSerializer.Deserialize<JsonElement>(await createResponse.Content.ReadAsStringAsync()).GetProperty("appealID").GetInt32();

            // Оператор назначает исполнителя и меняет статус
            AddAuthHeaders("operator", "operator");
            var updateBody = new StringContent(JsonSerializer.Serialize(new UpdateAppealRequest
            {
                StatusId = 2, // "В работе"
                AssignedToId = 3, // оператор (UserID=3 в seed, но точный ID зависит от автоинкремента; в seed они идут: 1-admin, 2-citizen, 3-operator). Используем 3.
                Comment = "Назначено"
            }), Encoding.UTF8, "application/json");
            var updateResponse = await _client.PutAsync($"/api/appeals/{appealId}", updateBody);
            Assert.That(updateResponse.StatusCode, Is.EqualTo(System.Net.HttpStatusCode.OK));

            // Проверяем детали – статус и исполнитель
            AddAuthHeaders("operator", "operator");
            var detailResponse = await _client.GetAsync($"/api/appeals/{appealId}");
            Assert.That(detailResponse.StatusCode, Is.EqualTo(System.Net.HttpStatusCode.OK));
            var detail = JsonSerializer.Deserialize<JsonElement>(await detailResponse.Content.ReadAsStringAsync());
            Assert.That(detail.GetProperty("statusID").GetInt32(), Is.EqualTo(2));
            Assert.That(detail.GetProperty("assignedToID").GetInt32(), Is.EqualTo(3));
        }

        [Test]
        public async Task UnauthorizedAccess_Returns401()
        {
            // Без заголовков
            _client.DefaultRequestHeaders.Remove("X-Login");
            _client.DefaultRequestHeaders.Remove("X-Password");
            var response = await _client.GetAsync("/api/appeals");
            Assert.That(response.StatusCode, Is.EqualTo(System.Net.HttpStatusCode.Unauthorized));
        }

        [Test]
        public async Task AdminCanManageUsers()
        {
            AddAuthHeaders("admin", "admin");

            // Получение списка пользователей
            var usersResponse = await _client.GetAsync("/api/users");
            Assert.That(usersResponse.StatusCode, Is.EqualTo(System.Net.HttpStatusCode.OK));
            var users = JsonSerializer.Deserialize<List<JsonElement>>(await usersResponse.Content.ReadAsStringAsync());
            Assert.That(users.Count, Is.GreaterThanOrEqualTo(3));

            // Создание нового пользователя
            var createUserBody = new StringContent(JsonSerializer.Serialize(new CreateUserRequest
            {
                Login = "newoperator",
                Password = "op123",
                FullName = "Новый Оператор",
                Role = "Оператор"
            }), Encoding.UTF8, "application/json");
            var createUserResponse = await _client.PostAsync("/api/users", createUserBody);
            Assert.That(createUserResponse.StatusCode, Is.EqualTo(System.Net.HttpStatusCode.OK));

            // Переключение активности
            int userId = users.First(u => u.GetProperty("login").GetString() == "citizen").GetProperty("userID").GetInt32();
            var toggleResponse = await _client.PutAsync($"/api/users/{userId}/toggleactive", null);
            Assert.That(toggleResponse.StatusCode, Is.EqualTo(System.Net.HttpStatusCode.OK));
        }

        [Test]
        public async Task DeletingAppeal_InNonNewStatus_ReturnsBadRequest()
        {
            // Создадим обращение как гражданин, затем сменим статус как оператор, затем попробуем удалить
            AddAuthHeaders("citizen", "citizen");
            var createBody = new StringContent(JsonSerializer.Serialize(new CreateAppealRequest { Title = "Тест удаления", CategoryId = 1 }), Encoding.UTF8, "application/json");
            var createResp = await _client.PostAsync("/api/appeals", createBody);
            int appealId = JsonSerializer.Deserialize<JsonElement>(await createResp.Content.ReadAsStringAsync()).GetProperty("appealID").GetInt32();

            AddAuthHeaders("operator", "operator");
            var updateBody = new StringContent(JsonSerializer.Serialize(new UpdateAppealRequest { StatusId = 2 }), Encoding.UTF8, "application/json");
            await _client.PutAsync($"/api/appeals/{appealId}", updateBody);

            // Пробуем удалить как гражданин
            AddAuthHeaders("citizen", "citizen");
            var deleteResp = await _client.DeleteAsync($"/api/appeals/{appealId}");
            Assert.That(deleteResp.StatusCode, Is.EqualTo(System.Net.HttpStatusCode.BadRequest));
        }
    }
}