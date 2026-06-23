using Microsoft.AspNetCore.Mvc;
using CityAppealsApi.Data;
using CityAppealsApi.Models;
using System;
using System.IO;
using System.Linq;

namespace CityAppealsApi.Controllers
{
    public class AttachmentsController : BaseApiController
    {
        [HttpPost("/api/appeals/{appealId}/attachments")]
        public IActionResult Upload(int appealId, IFormFile file)
        {
            var user = AuthorizeAndGetUser(new[] { "Гражданин" });
            if (user == null) return Unauthorized();

            if (file == null || file.Length == 0)
                return BadRequest("Файл не выбран.");

            using var db = new AppDbContext();
            var appeal = db.Appeals.Find(appealId);
            if (appeal == null) return NotFound();
            if (appeal.AuthorID != user.UserID)
                return Unauthorized("Вы не являетесь автором обращения.");

            string attachmentsFolder = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "Attachments");
            Directory.CreateDirectory(attachmentsFolder);

            string uniqueName = Guid.NewGuid().ToString() + Path.GetExtension(file.FileName);
            string filePath = Path.Combine(attachmentsFolder, uniqueName);
            using var stream = new FileStream(filePath, FileMode.Create);
            file.CopyTo(stream);

            var attachment = new Attachment
            {
                AppealID = appealId,
                FileName = file.FileName,
                FilePath = Path.Combine("Attachments", uniqueName),
                UploadedAt = DateTime.Now
            };
            db.Attachments.Add(attachment);
            db.SaveChanges();

            return Ok(new { attachment.AttachmentID, attachment.FileName, attachment.FilePath });
        }

        [HttpGet("{id}/download")]
        public IActionResult Download(int id)
        {
            var user = AuthorizeAndGetUser(new[] { "Гражданин", "Оператор", "Исполнитель", "Администратор" });
            if (user == null) return Unauthorized();

            using var db = new AppDbContext();
            var attachment = db.Attachments.Find(id);
            if (attachment == null) return NotFound();

            var appeal = db.Appeals.Find(attachment.AppealID);
            if (appeal == null) return NotFound();
            if (user.Role == "Гражданин" && appeal.AuthorID != user.UserID)
                return Unauthorized();
            if (user.Role == "Исполнитель" && appeal.AssignedToID != user.UserID)
                return Unauthorized();

            string fullPath = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, attachment.FilePath);
            if (!System.IO.File.Exists(fullPath))
                return NotFound("Файл не найден на сервере.");

            var bytes = System.IO.File.ReadAllBytes(fullPath);
            return File(bytes, "application/octet-stream", attachment.FileName);
        }
    }
}