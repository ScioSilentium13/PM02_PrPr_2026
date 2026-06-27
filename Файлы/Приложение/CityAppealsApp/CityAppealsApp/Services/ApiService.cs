using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Net.Http.Json;
using System.Threading.Tasks;
using CityAppealsApp.Models;

namespace CityAppealsApp.Services
{
    public class ApiService
    {
        private readonly HttpClient _client;
        private string _login = string.Empty;
        private string _password = string.Empty;

        public ApiService(string baseUrl = "http://localhost:5146/")
        {
            _client = new HttpClient { BaseAddress = new Uri(baseUrl) };
            _client.DefaultRequestHeaders.Accept.Clear();
            _client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
        }

        public void SetCredentials(string login, string password)
        {
            _login = login;
            _password = password;
        }

        private void AddAuthHeaders()
        {
            _client.DefaultRequestHeaders.Remove("X-Login");
            _client.DefaultRequestHeaders.Remove("X-Password");
            if (!string.IsNullOrEmpty(_login))
            {
                _client.DefaultRequestHeaders.Add("X-Login", _login);
                _client.DefaultRequestHeaders.Add("X-Password", _password);
            }
        }

        public async Task<ApiResponse<T>> GetAsync<T>(string url)
        {
            try
            {
                AddAuthHeaders();
                var response = await _client.GetAsync(url);
                if (response.IsSuccessStatusCode)
                {
                    if (typeof(T) == typeof(byte[]))
                    {
                        var data = await response.Content.ReadAsByteArrayAsync();
                        return new ApiResponse<T> { Success = true, Data = (T)(object)data };
                    }
                    else
                    {
                        var data = await response.Content.ReadFromJsonAsync<T>();
                        return new ApiResponse<T> { Success = true, Data = data };
                    }
                }
                else
                {
                    var error = await response.Content.ReadAsStringAsync();
                    return new ApiResponse<T> { Success = false, Message = ParseErrorMessage(response.StatusCode, error) };
                }
            }
            catch (Exception ex)
            {
                return new ApiResponse<T> { Success = false, Message = $"Ошибка соединения: {ex.Message}" };
            }
        }

        public async Task<ApiResponse<T>> PostAsync<T>(string url, object? body = null)
        {
            try
            {
                AddAuthHeaders();
                var response = await _client.PostAsJsonAsync(url, body);
                if (response.IsSuccessStatusCode)
                {
                    var data = await response.Content.ReadFromJsonAsync<T>();
                    return new ApiResponse<T> { Success = true, Data = data };
                }
                else
                {
                    var error = await response.Content.ReadAsStringAsync();
                    return new ApiResponse<T> { Success = false, Message = ParseErrorMessage(response.StatusCode, error) };
                }
            }
            catch (Exception ex)
            {
                return new ApiResponse<T> { Success = false, Message = $"Ошибка соединения: {ex.Message}" };
            }
        }

        public async Task<ApiResponse<T>> PutAsync<T>(string url, object? body = null)
        {
            try
            {
                AddAuthHeaders();
                var response = await _client.PutAsJsonAsync(url, body);
                if (response.IsSuccessStatusCode)
                {
                    var data = await response.Content.ReadFromJsonAsync<T>();
                    return new ApiResponse<T> { Success = true, Data = data };
                }
                else
                {
                    var error = await response.Content.ReadAsStringAsync();
                    return new ApiResponse<T> { Success = false, Message = ParseErrorMessage(response.StatusCode, error) };
                }
            }
            catch (Exception ex)
            {
                return new ApiResponse<T> { Success = false, Message = $"Ошибка соединения: {ex.Message}" };
            }
        }

        public async Task<ApiResponse<T>> DeleteAsync<T>(string url)
        {
            try
            {
                AddAuthHeaders();
                var response = await _client.DeleteAsync(url);
                if (response.IsSuccessStatusCode)
                {
                    var data = response.Content.Headers.ContentLength == 0
                        ? default
                        : await response.Content.ReadFromJsonAsync<T>();
                    return new ApiResponse<T> { Success = true, Data = data };
                }
                else
                {
                    var error = await response.Content.ReadAsStringAsync();
                    return new ApiResponse<T> { Success = false, Message = ParseErrorMessage(response.StatusCode, error) };
                }
            }
            catch (Exception ex)
            {
                return new ApiResponse<T> { Success = false, Message = $"Ошибка соединения: {ex.Message}" };
            }
        }

        public async Task<ApiResponse<T>> PostFileAsync<T>(string url, byte[] fileBytes, string fileName)
        {
            try
            {
                AddAuthHeaders();
                using var content = new MultipartFormDataContent();
                var fileContent = new ByteArrayContent(fileBytes);
                fileContent.Headers.ContentType = new MediaTypeHeaderValue("application/octet-stream");
                content.Add(fileContent, "file", fileName);

                var response = await _client.PostAsync(url, content);
                if (response.IsSuccessStatusCode)
                {
                    var data = await response.Content.ReadFromJsonAsync<T>();
                    return new ApiResponse<T> { Success = true, Data = data };
                }
                else
                {
                    var error = await response.Content.ReadAsStringAsync();
                    return new ApiResponse<T> { Success = false, Message = ParseErrorMessage(response.StatusCode, error) };
                }
            }
            catch (Exception ex)
            {
                return new ApiResponse<T> { Success = false, Message = $"Ошибка соединения: {ex.Message}" };
            }
        }

        private string ParseErrorMessage(System.Net.HttpStatusCode statusCode, string serverError)
        {
            if (!string.IsNullOrWhiteSpace(serverError) && serverError.StartsWith("\"") && serverError.Length > 2)
                serverError = serverError.Trim('"'); // Убираем кавычки

            return statusCode switch
            {
                System.Net.HttpStatusCode.BadRequest => string.IsNullOrEmpty(serverError) ? "Некорректный запрос." : serverError,
                System.Net.HttpStatusCode.Unauthorized => "Неверный логин или пароль, либо недостаточно прав.",
                System.Net.HttpStatusCode.Forbidden => "Доступ запрещён.",
                System.Net.HttpStatusCode.NotFound => "Запрашиваемый объект не найден.",
                System.Net.HttpStatusCode.InternalServerError => "Внутренняя ошибка сервера.",
                _ => serverError ?? $"Неизвестная ошибка (код {(int)statusCode})."
            };
        }
    }

    public class ApiResponse<T>
    {
        public bool Success { get; set; }
        public string? Message { get; set; }
        public T? Data { get; set; }
    }
}