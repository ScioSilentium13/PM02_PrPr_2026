using CityAppealsApi.Data;
using CityAppealsApi.Models;
using CityAppealsApi.Models.Dto;
using Microsoft.AspNetCore.Mvc;
using System.Security.Cryptography;
using System.Text;

namespace CityAppealsApi.Controllers
{
    public class AuthController : ControllerBase
    {
        [HttpPost("/api/auth/login")]
        public IActionResult Login([FromBody] LoginRequest request)
        {
            if (string.IsNullOrWhiteSpace(request.Login) || string.IsNullOrWhiteSpace(request.Password))
                return BadRequest("Логин и пароль обязательны.");

            string hash = ComputeSha256Hash(request.Password);
            using var db = new AppDbContext();
            var user = db.ApplicationUsers.FirstOrDefault(u => u.Login == request.Login && u.PasswordHash == hash && u.IsActive);
            if (user == null)
                return Unauthorized("Неверный логин или пароль.");

            return Ok(new LoginResponse
            {
                UserId = user.UserID,
                FullName = user.FullName,
                Role = user.Role
            });
        }

        [HttpPost("/api/auth/register")]
        public IActionResult Register([FromBody] RegisterRequest request)
        {
            // Валидация обязательных полей
            if (string.IsNullOrWhiteSpace(request.Login) || string.IsNullOrWhiteSpace(request.Password) || string.IsNullOrWhiteSpace(request.FullName))
                return BadRequest("Логин, пароль и ФИО обязательны.");

            if (request.Password != request.ConfirmPassword)
                return BadRequest("Пароли не совпадают.");

            if (request.Login.Length > 50)
                return BadRequest("Логин слишком длинный (макс. 50).");
            if (request.Password.Length > 50)
                return BadRequest("Пароль слишком длинный (макс. 50).");
            if (request.FullName.Length > 100)
                return BadRequest("ФИО слишком длинное (макс. 100).");

            // Простейшая проверка формата email/телефона (опционально)
            if (!string.IsNullOrEmpty(request.Email) && !IsValidEmail(request.Email))
                return BadRequest("Некорректный формат email.");
            if (!string.IsNullOrEmpty(request.Phone) && !IsValidPhone(request.Phone))
                return BadRequest("Некорректный формат телефона.");

            using var db = new AppDbContext();
            if (db.ApplicationUsers.Any(u => u.Login == request.Login))
                return BadRequest("Пользователь с таким логином уже существует.");

            var newUser = new ApplicationUser
            {
                Login = request.Login,
                PasswordHash = ComputeSha256Hash(request.Password),
                FullName = request.FullName,
                Role = "Гражданин",
                Email = request.Email,
                Phone = request.Phone,
                Address = request.Address,
                IsActive = true,
                CreatedAt = DateTime.Now
            };

            db.ApplicationUsers.Add(newUser);
            db.SaveChanges();

            return Ok(new { newUser.UserID, newUser.Login, newUser.FullName, newUser.Role });
        }

        private string ComputeSha256Hash(string rawData)
        {
            using SHA256 sha256 = SHA256.Create();
            byte[] bytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(rawData));
            StringBuilder builder = new StringBuilder();
            foreach (byte b in bytes)
                builder.Append(b.ToString("x2"));
            return builder.ToString();
        }

        private bool IsValidEmail(string email)
        {
            try
            {
                var addr = new System.Net.Mail.MailAddress(email);
                return addr.Address == email;
            }
            catch { return false; }
        }

        private bool IsValidPhone(string phone)
        {
            return System.Text.RegularExpressions.Regex.IsMatch(phone, @"^\+?\d{1,3}?[-.\s]?\(?\d{1,4}?\)?[-.\s]?\d{1,4}[-.\s]?\d{1,9}$");
        }
    }
}