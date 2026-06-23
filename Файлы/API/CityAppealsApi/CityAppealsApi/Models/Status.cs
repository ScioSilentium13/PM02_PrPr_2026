namespace CityAppealsApi.Models
{
    public class Status
    {
        public int StatusID { get; set; }
        public string Name { get; set; } = null!;
        public bool IsFinal { get; set; }

        public ICollection<Appeal> Appeals { get; set; } = new List<Appeal>();
    }
}