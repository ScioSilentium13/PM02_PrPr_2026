using Microsoft.AspNetCore.Mvc;
using CityAppealsApi.Data;
using CityAppealsApi.Models;
using CityAppealsApi.Models.Dto;
using System.Linq;
using System.Security.Cryptography;
using System.Text;

namespace CityAppealsApi.Controllers
{
    public class UsersController : BaseApiController
    {
        [HttpGet]
        public IActionResult GetAll([FromQuery] string? search, [FromQuery] string? role)
        {
            var user = AuthorizeAndGetUser(new[] { "Администратор", "Оператор" });
            if (user == null) return Unauthorized();

            using var db = new AppDbContext();
            var query = db.ApplicationUsers.AsQueryable();
            if (!string.IsNullOrWhiteSpace(role))
                query = query.Where(u => u.Role == role);
            if (!string.IsNullOrWhiteSpace(search))
                query = query.Where(u => u.Login.Contains(search) || u.FullName.Contains(search));

            var users = query.OrderBy(u => u.Role).ThenBy(u => u.FullName)
                .Select(u => new
                {
                    u.UserID,
                    u.Login,
                    u.FullName,
                    u.Role,
                    u.Email,
                    u.Phone,
                    u.Address,
                    u.Department,
                    u.Position,
                    u.IsActive,
                    u.CreatedAt
                })
                .ToList();

            return Ok(users);
        }

        [HttpPost]
        public IActionResult Create([FromBody] CreateUserRequest request)
        {
            var user = AuthorizeAndGetUser(new[] { "Администратор" });
            if (user == null) return Unauthorized();

            if (string.IsNullOrWhiteSpace(request.Login) || string.IsNullOrWhiteSpace(request.Password) || string.IsNullOrWhiteSpace(request.FullName))
                return BadRequest("Логин, пароль и ФИО обязательны.");

            using var db = new AppDbContext();
            if (db.ApplicationUsers.Any(u => u.Login == request.Login))
                return BadRequest("Пользователь с таким логином уже существует.");

            var newUser = new ApplicationUser
            {
                Login = request.Login,
                PasswordHash = Convert.ToHexString(SHA256.HashData(Encoding.UTF8.GetBytes(request.Password))).ToLower(),
                FullName = request.FullName,
                Role = request.Role,
                Department = request.Department,
                Position = request.Position,
                IsActive = true,
                CreatedAt = DateTime.Now
            };
            db.ApplicationUsers.Add(newUser);
            db.SaveChanges();
            return Ok(new { newUser.UserID, newUser.Login, newUser.FullName, newUser.Role });
        }

        [HttpPut("{id}/toggleactive")]
        public IActionResult ToggleActive(int id)
        {
            var user = AuthorizeAndGetUser(new[] { "Администратор" });
            if (user == null) return Unauthorized();

            using var db = new AppDbContext();
            var dbUser = db.ApplicationUsers.Find(id);
            if (dbUser == null) return NotFound();
            dbUser.IsActive = !dbUser.IsActive;
            db.SaveChanges();
            return Ok(new { dbUser.UserID, dbUser.IsActive });
        }
    }
}