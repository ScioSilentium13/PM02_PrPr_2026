namespace CityAppealsApp.Models
{
    public class Attachment
    {
        public int AttachmentID { get; set; }
        public int AppealID { get; set; }
        public string FileName { get; set; } = null!;
        public string FilePath { get; set; } = null!;
        public DateTime UploadedAt { get; set; }

        public Appeal Appeal { get; set; } = null!;
    }
}