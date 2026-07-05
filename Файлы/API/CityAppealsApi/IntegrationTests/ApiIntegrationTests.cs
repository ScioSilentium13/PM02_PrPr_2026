using CityAppealsApi;
using CityAppealsApi.Data;
using Microsoft.AspNetCore.Mvc.Testing;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using System.Net;

namespace IntegrationTests
{
    [TestFixture]
    public class ApiIntegrationTests
    {
        private WebApplicationFactory<Program> _factory;
        private HttpClient _client;

        [SetUp]
        public void Setup()
        {
            _factory = new WebApplicationFactory<Program>()
                .WithWebHostBuilder(builder =>
                {
                    builder.ConfigureServices(services =>
                    {
                        // Заменяем реальный DbContext на InMemory для каждого теста
                        var descriptor = services.SingleOrDefault(
                            d => d.ServiceType == typeof(DbContextOptions<AppDbContext>));
                        if (descriptor != null)
                            services.Remove(descriptor);

                        string dbName = "IntegrationTests_" + Guid.NewGuid();
                        services.AddDbContext<AppDbContext>(options =>
                            options.UseInMemoryDatabase(dbName));
                    });
                });
            _client = _factory.CreateClient();
        }

        [TearDown]
        public void TearDown()
        {
            _client.Dispose();
            _factory.Dispose();
        }

        private void ClearAuthHeaders()
        {
            _client.DefaultRequestHeaders.Remove("X-Login");
            _client.DefaultRequestHeaders.Remove("X-Password");
        }

        // ===================== ТЕСТЫ =====================

        [Test]
        public async Task Unauthorized_Access_Appeals_Denied()
        {
            ClearAuthHeaders();
            var response = await _client.GetAsync("/api/appeals");
            Assert.That(response.StatusCode, Is.EqualTo(HttpStatusCode.Unauthorized));
        }
        [Test]
        public async Task Unauthorized_Access_Users_Denied()
        {
            ClearAuthHeaders();
            var response = await _client.GetAsync("/api/users");
            Assert.That(response.StatusCode, Is.EqualTo(HttpStatusCode.Unauthorized));
        }
        [Test]
        public async Task Unauthorized_Access_Statuses_Denied()
        {
            ClearAuthHeaders();
            var response = await _client.GetAsync("/api/statuses");
            Assert.That(response.StatusCode, Is.EqualTo(HttpStatusCode.Unauthorized));
        }
        [Test]
        public async Task Unauthorized_Access_Categories_Denied()
        {
            ClearAuthHeaders();
            var response = await _client.GetAsync("/api/categories");
            Assert.That(response.StatusCode, Is.EqualTo(HttpStatusCode.Unauthorized));
        }
    }
}