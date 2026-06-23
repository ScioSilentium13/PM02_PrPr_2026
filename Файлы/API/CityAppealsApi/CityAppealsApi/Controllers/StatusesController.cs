using Microsoft.AspNetCore.Mvc;
using CityAppealsApi.Data;
using System.Linq;

namespace CityAppealsApi.Controllers
{
    public class StatusesController : BaseApiController
    {
        [HttpGet]
        public IActionResult GetAll()
        {
            var user = AuthorizeAndGetUser(new[] { "Гражданин", "Оператор", "Исполнитель", "Администратор" });
            if (user == null) return Unauthorized();

            using var db = new AppDbContext();
            var statuses = db.Statuses.Select(s => new
            {
                s.StatusID,
                s.Name,
                s.IsFinal
            }).ToList();

            return Ok(statuses);
        }
    }
}