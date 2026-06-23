using CityAppealsApi.Data;
using CityAppealsApi.Models;
using Microsoft.AspNetCore.Mvc;
using System.Security.Cryptography;
using System.Text;

namespace CityAppealsApi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public abstract class BaseApiController : ControllerBase
    {
        protected ApplicationUser? AuthorizeAndGetUser(string[] allowedRoles)
        {
            var login = Request.Headers["X-Login"].FirstOrDefault();
            var password = Request.Headers["X-Password"].FirstOrDefault();

            if (string.IsNullOrEmpty(login) || string.IsNullOrEmpty(password))
            {
                HttpContext.Response.StatusCode = 401;
                return null;
            }

            string hash = ComputeSha256Hash(password);

            using var db = new AppDbContext();
            var user = db.ApplicationUsers.FirstOrDefault(u => u.Login == login && u.PasswordHash == hash && u.IsActive);
            if (user == null || !allowedRoles.Contains(user.Role))
            {
                HttpContext.Response.StatusCode = 401;
                return null;
            }
            return user;
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