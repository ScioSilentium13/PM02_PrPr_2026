namespace CityAppealsApi.Models
{
    public class AppealHistory
    {
        public int HistoryID { get; set; }
        public int AppealID { get; set; }
        public int UserID { get; set; }
        public string Action { get; set; } = null!;
        public string? Comment { get; set; }
        public DateTime ActionDate { get; set; }

        public Appeal Appeal { get; set; } = null!;
        public ApplicationUser User { get; set; } = null!;
    }
}