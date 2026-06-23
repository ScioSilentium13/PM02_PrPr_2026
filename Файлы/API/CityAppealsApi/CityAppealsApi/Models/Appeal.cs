using System.Collections.Generic;
using System.Net.Mail;

namespace CityAppealsApi.Models
{
    public class Appeal
    {
        public int AppealID { get; set; }
        public int AuthorID { get; set; }
        public string Title { get; set; } = null!;
        public string? Description { get; set; }
        public int CategoryID { get; set; }
        public int StatusID { get; set; }
        public int? AssignedToID { get; set; }
        public DateTime CreatedAt { get; set; }
        public DateTime UpdatedAt { get; set; }
        public DateOnly? DueDate { get; set; }

        public ApplicationUser Author { get; set; } = null!;
        public Category Category { get; set; } = null!;
        public Status Status { get; set; } = null!;
        public ApplicationUser? AssignedTo { get; set; }
        public ICollection<AppealHistory> Histories { get; set; } = new List<AppealHistory>();
        public ICollection<Attachment> Attachments { get; set; } = new List<Attachment>();
    }
}