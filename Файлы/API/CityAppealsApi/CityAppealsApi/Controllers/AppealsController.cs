using Microsoft.AspNetCore.Mvc;
using CityAppealsApi.Data;
using CityAppealsApi.Models;
using CityAppealsApi.Models.Dto;
using Microsoft.EntityFrameworkCore;
using System;
using System.Linq;

namespace CityAppealsApi.Controllers
{
    public class AppealsController : BaseApiController
    {
        // GET /api/appeals?search=...
        [HttpGet]
        public IActionResult GetAll([FromQuery] string? search)
        {
            var user = AuthorizeAndGetUser(new[] { "Гражданин", "Оператор", "Исполнитель", "Администратор" });
            if (user == null) return Unauthorized();

            using var db = new AppDbContext();
            IQueryable<Appeal> query = db.Appeals
                .Include(a => a.Author)
                .Include(a => a.Category)
                .Include(a => a.Status)
                .Include(a => a.AssignedTo);

            if (user.Role == "Гражданин")
                query = query.Where(a => a.AuthorID == user.UserID);
            else if (user.Role == "Исполнитель")
                query = query.Where(a => a.AssignedToID == user.UserID);

            if (!string.IsNullOrWhiteSpace(search))
                query = query.Where(a => a.Title.Contains(search) || a.Description.Contains(search));

            var appeals = query.OrderByDescending(a => a.CreatedAt).Select(a => new
            {
                a.AppealID,
                a.Title,
                a.Description,
                a.CreatedAt,
                a.UpdatedAt,
                a.DueDate,
                a.StatusID,
                a.AssignedToID,
                Author = a.Author == null ? null : new
                {
                    a.Author.UserID,
                    a.Author.FullName,
                    a.Author.Login,
                    a.Author.Role
                },
                Category = a.Category == null ? null : new
                {
                    a.Category.CategoryID,
                    a.Category.Name
                },
                Status = a.Status == null ? null : new
                {
                    a.Status.StatusID,
                    a.Status.Name,
                    a.Status.IsFinal
                },
                AssignedTo = a.AssignedTo == null ? null : new
                {
                    a.AssignedTo.UserID,
                    a.AssignedTo.FullName,
                    a.AssignedTo.Login
                }
            }).ToList();

            return Ok(appeals);
        }

        // GET /api/appeals/{id}
        [HttpGet("{id}")]
        public IActionResult GetById(int id)
        {
            var user = AuthorizeAndGetUser(new[] { "Гражданин", "Оператор", "Исполнитель", "Администратор" });
            if (user == null) return Unauthorized();

            using var db = new AppDbContext();
            var appeal = db.Appeals
                .Include(a => a.Author)
                .Include(a => a.Category)
                .Include(a => a.Status)
                .Include(a => a.AssignedTo)
                .Include(a => a.Attachments)
                .Include(a => a.Histories)
                .FirstOrDefault(a => a.AppealID == id);

            if (appeal == null) return NotFound();

            if (user.Role == "Гражданин" && appeal.AuthorID != user.UserID)
                return Unauthorized("Доступ запрещён.");
            if (user.Role == "Исполнитель" && appeal.AssignedToID != user.UserID)
                return Unauthorized("Доступ запрещён.");

            var result = new
            {
                appeal.AppealID,
                appeal.Title,
                appeal.Description,
                appeal.CreatedAt,
                appeal.UpdatedAt,
                appeal.DueDate,
                appeal.StatusID,
                appeal.AssignedToID,
                Author = appeal.Author == null ? null : new
                {
                    appeal.Author.UserID,
                    appeal.Author.FullName,
                    appeal.Author.Login,
                    appeal.Author.Role
                },
                Category = appeal.Category == null ? null : new
                {
                    appeal.Category.CategoryID,
                    appeal.Category.Name
                },
                Status = appeal.Status == null ? null : new
                {
                    appeal.Status.StatusID,
                    appeal.Status.Name,
                    appeal.Status.IsFinal
                },
                AssignedTo = appeal.AssignedTo == null ? null : new
                {
                    appeal.AssignedTo.UserID,
                    appeal.AssignedTo.FullName
                },
                Attachments = appeal.Attachments.Select(at => new
                {
                    at.AttachmentID,
                    at.FileName,
                    at.FilePath,
                    at.UploadedAt
                }).ToList(),
                Histories = appeal.Histories.OrderBy(h => h.ActionDate).Select(h => new
                {
                    h.HistoryID,
                    h.Action,
                    h.Comment,
                    h.ActionDate,
                    User = h.User == null ? null : new
                    {
                        h.User.UserID,
                        h.User.FullName
                    }
                }).ToList()
            };

            return Ok(result);
        }

        // POST /api/appeals
        [HttpPost]
        public IActionResult Create([FromBody] CreateAppealRequest request)
        {
            var user = AuthorizeAndGetUser(new[] { "Гражданин" });
            if (user == null) return Unauthorized();

            if (string.IsNullOrWhiteSpace(request.Title))
                return BadRequest("Заголовок обязателен.");

            using var db = new AppDbContext();
            var appeal = new Appeal
            {
                AuthorID = user.UserID,
                Title = request.Title,
                Description = request.Description,
                CategoryID = request.CategoryId,
                StatusID = 1,
                CreatedAt = DateTime.Now,
                UpdatedAt = DateTime.Now
            };
            db.Appeals.Add(appeal);
            db.AppealHistories.Add(new AppealHistory
            {
                Appeal = appeal,
                UserID = user.UserID,
                Action = "Создано",
                Comment = "Обращение подано гражданином",
                ActionDate = DateTime.Now
            });
            db.SaveChanges();
            return CreatedAtAction(nameof(GetById), new { id = appeal.AppealID }, new { appeal.AppealID });
        }

        // PUT /api/appeals/{id}
        [HttpPut("{id}")]
        public IActionResult Update(int id, [FromBody] UpdateAppealRequest request)
        {
            var user = AuthorizeAndGetUser(new[] { "Оператор", "Исполнитель", "Администратор" });
            if (user == null) return Unauthorized();

            using var db = new AppDbContext();
            var appeal = db.Appeals.Find(id);
            if (appeal == null) return NotFound();

            if (user.Role == "Исполнитель" && appeal.AssignedToID != user.UserID)
                return Unauthorized("Исполнитель может обновлять только свои обращения.");

            bool changed = false;

            if (request.StatusId.HasValue && (user.Role == "Оператор" || user.Role == "Исполнитель" || user.Role == "Администратор"))
            {
                if (appeal.StatusID != request.StatusId.Value)
                {
                    appeal.StatusID = request.StatusId.Value;
                    changed = true;
                    db.AppealHistories.Add(new AppealHistory
                    {
                        AppealID = appeal.AppealID,
                        UserID = user.UserID,
                        Action = "Изменён статус",
                        Comment = $"Статус изменён на «{db.Statuses.Find(request.StatusId.Value)?.Name}»",
                        ActionDate = DateTime.Now
                    });
                }
            }

            if (request.AssignedToId.HasValue && (user.Role == "Оператор" || user.Role == "Администратор"))
            {
                if (appeal.AssignedToID != request.AssignedToId.Value)
                {
                    appeal.AssignedToID = request.AssignedToId.Value;
                    changed = true;
                    db.AppealHistories.Add(new AppealHistory
                    {
                        AppealID = appeal.AppealID,
                        UserID = user.UserID,
                        Action = "Назначен исполнитель",
                        Comment = $"Назначен исполнитель ID={request.AssignedToId.Value}",
                        ActionDate = DateTime.Now
                    });
                }
            }

            if (!string.IsNullOrWhiteSpace(request.Comment))
            {
                db.AppealHistories.Add(new AppealHistory
                {
                    AppealID = appeal.AppealID,
                    UserID = user.UserID,
                    Action = "Добавлен комментарий",
                    Comment = request.Comment,
                    ActionDate = DateTime.Now
                });
                changed = true;
            }

            if (changed)
            {
                appeal.UpdatedAt = DateTime.Now;
                db.SaveChanges();
            }

            return Ok(new { appeal.AppealID, appeal.StatusID, appeal.AssignedToID });
        }

        // DELETE /api/appeals/{id}
        [HttpDelete("{id}")]
        public IActionResult Delete(int id)
        {
            var user = AuthorizeAndGetUser(new[] { "Гражданин" });
            if (user == null) return Unauthorized();

            using var db = new AppDbContext();
            var appeal = db.Appeals.Find(id);
            if (appeal == null) return NotFound();
            if (appeal.AuthorID != user.UserID)
                return Unauthorized("Можно удалить только своё обращение.");
            if (appeal.StatusID != 1)
                return BadRequest("Можно удалить только обращение в статусе «Новое».");

            db.Appeals.Remove(appeal);
            db.SaveChanges();
            return NoContent();
        }
    }
}