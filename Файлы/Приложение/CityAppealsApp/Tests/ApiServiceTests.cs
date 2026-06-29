using CityAppealsApp.Models;
using CityAppealsApp.Services;
using Moq;
using Moq.Protected;
using NUnit.Framework;
using System.Net;
using System.Net.Http;
using System.Net.NetworkInformation;
using System.Text;
using System.Text.Json;
using System.Threading;
using System.Threading.Tasks;
using System.Timers;

namespace Tests
{
    [TestFixture]
    public class ApiServiceTests
    {
        private Mock<HttpMessageHandler> _handlerMock;
        private HttpClient _httpClient;
        private ApiService _apiService;

        [SetUp]
        public void Setup()
        {
            _handlerMock = new Mock<HttpMessageHandler>();
            _httpClient = new HttpClient(_handlerMock.Object) { BaseAddress = new System.Uri("http://localhost:5000/") };
            _apiService = new ApiService(_httpClient);
        }

        [TearDown]
        public void TearDown()
        {
            _httpClient.Dispose();
        }

        [Test]
        public async Task PostAsync_ValidRequest_ReturnsDeserializedObject()
        {
            // Arrange
            var expectedUser = new ApplicationUser { UserID = 1, Login = "test", FullName = "Test User", Role = "Гражданин" };
            var responseMessage = new HttpResponseMessage(HttpStatusCode.OK)
            {
                Content = new StringContent(JsonSerializer.Serialize(expectedUser), Encoding.UTF8, "application/json")
            };
            _handlerMock.Protected()
                .Setup<Task<HttpResponseMessage>>("SendAsync", ItExpr.IsAny<HttpRequestMessage>(), ItExpr.IsAny<CancellationToken>())
                .ReturnsAsync(responseMessage);

            // Act
            var result = await _apiService.PostAsync<ApplicationUser>("api/auth/login", new { Login = "test", Password = "pass" });

            // Assert
            Assert.That(result.Success, Is.True);
            Assert.That(result.Data.Login, Is.EqualTo("test"));
            Assert.That(result.Data.Role, Is.EqualTo("Гражданин"));
        }

        [Test]
        public async Task PostAsync_Unauthorized_ReturnsFailureWithMessage()
        {
            // Arrange
            var responseMessage = new HttpResponseMessage(HttpStatusCode.Unauthorized)
            {
                Content = new StringContent("Неверный логин или пароль.", Encoding.UTF8, "application/json")
            };
            _handlerMock.Protected()
                .Setup<Task<HttpResponseMessage>>("SendAsync", ItExpr.IsAny<HttpRequestMessage>(), ItExpr.IsAny<CancellationToken>())
                .ReturnsAsync(responseMessage);

            // Act
            var result = await _apiService.PostAsync<ApplicationUser>("api/auth/login", new { Login = "x", Password = "y" });

            // Assert
            Assert.That(result.Success, Is.False);
            Assert.That(result.Message, Does.Contain("Неверный логин или пароль"));
        }

        [Test]
        public async Task GetAsync_Success_ReturnsList()
        {
            // Arrange
            var statuses = new[] { new { StatusID = 1, Name = "Новое", IsFinal = false } };
            var responseMessage = new HttpResponseMessage(HttpStatusCode.OK)
            {
                Content = new StringContent(JsonSerializer.Serialize(statuses), Encoding.UTF8, "application/json")
            };
            _handlerMock.Protected()
                .Setup<Task<HttpResponseMessage>>("SendAsync", ItExpr.IsAny<HttpRequestMessage>(), ItExpr.IsAny<CancellationToken>())
                .ReturnsAsync(responseMessage);

            // Act
            var result = await _apiService.GetAsync<System.Collections.Generic.List<Status>>("api/statuses");

            // Assert
            Assert.That(result.Success, Is.True);
            Assert.That(result.Data.Count, Is.EqualTo(1));
            Assert.That(result.Data[0].Name, Is.EqualTo("Новое"));
        }

        [Test]
        public async Task GetAsync_NetworkError_ReturnsFailureWithErrorMessage()
        {
            // Arrange
            _handlerMock.Protected()
                .Setup<Task<HttpResponseMessage>>("SendAsync", ItExpr.IsAny<HttpRequestMessage>(), ItExpr.IsAny<CancellationToken>())
                .ThrowsAsync(new HttpRequestException("Network error"));

            // Act
            var result = await _apiService.GetAsync<object>("api/appeals");

            // Assert
            Assert.That(result.Success, Is.False);
            Assert.That(result.Message, Does.Contain("Ошибка соединения"));
        }

        [Test]
        public void SetCredentials_AddsAuthHeaders()
        {
            // Arrange
            _apiService.SetCredentials("user", "pass");

            // Act & Assert
            Assert.That(async () => await _apiService.GetAsync<object>("api/test"), Throws.Nothing);

            // Проверим, что заголовки были добавлены, можно через перехват запроса
            _handlerMock.Protected().Verify(
                "SendAsync",
                Times.AtLeastOnce(),
                ItExpr.Is<HttpRequestMessage>(req =>
                    req.Headers.Contains("X-Login") && req.Headers.Contains("X-Password")),
                ItExpr.IsAny<CancellationToken>());
        }
    }
}