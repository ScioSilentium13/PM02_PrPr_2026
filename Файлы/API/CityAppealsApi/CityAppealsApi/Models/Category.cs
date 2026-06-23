namespace CityAppealsApi.Models
{
    public class Category
    {
        public int CategoryID { get; set; }
        public string Name { get; set; } = null!;
        public string? Description { get; set; }

        public ICollection<Appeal> Appeals { get; set; } = new List<Appeal>();
    }
}