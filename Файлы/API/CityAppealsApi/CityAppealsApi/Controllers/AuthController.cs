using Microsoft.AspNetCore.Mvc;
using CityAppealsApi.Data;
using CityAppealsApi.Models.Dto;
using System.Security.Cryptography;
using System.Text;

namespace CityAppealsApi.Controllers
{
    public class AuthController : ControllerBase
    {
        [HttpPost("api/auth/login")]
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

        private string ComputeSha256Hash(string rawData)
        {
            using SHA256 sha256 = SHA256.Create();
            byte[] bytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(rawData));
            StringBuilder builder = new StringBuilder();
            foreach (byte b in bytes)
                builder.Append(b.ToString("x2"));
            return builder.ToString();
        }
    }
}