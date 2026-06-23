using Microsoft.AspNetCore.Mvc;
using CityAppealsApi.Data;
using System.Linq;

namespace CityAppealsApi.Controllers
{
    public class CategoriesController : BaseApiController
    {
        [HttpGet]
        public IActionResult GetAll()
        {
            var user = AuthorizeAndGetUser(new[] { "Гражданин", "Оператор", "Исполнитель", "Администратор" });
            if (user == null) return Unauthorized();

            using var db = new AppDbContext();
            var categories = db.Categories.Select(c => new
            {
                c.CategoryID,
                c.Name,
                c.Description
            }).ToList();

            return Ok(categories);
        }
    }
}