using System.Collections.Generic;

namespace CityAppealsApi.Models
{
    public class ApplicationUser
    {
        public int UserID { get; set; }
        public string Login { get; set; } = null!;
        public string PasswordHash { get; set; } = null!;
        public string? Email { get; set; }
        public string? Phone { get; set; }
        public string FullName { get; set; } = null!;
        public string Role { get; set; } = null!; // "Гражданин", "Оператор", "Исполнитель", "Администратор"
        public string? Address { get; set; }
        public string? Department { get; set; }
        public string? Position { get; set; }
        public DateTime CreatedAt { get; set; }
        public bool IsActive { get; set; }

        public ICollection<Appeal> AuthoredAppeals { get; set; } = new List<Appeal>();
        public ICollection<Appeal> AssignedAppeals { get; set; } = new List<Appeal>();
        public ICollection<AppealHistory> AppealHistories { get; set; } = new List<AppealHistory>();
    }
}