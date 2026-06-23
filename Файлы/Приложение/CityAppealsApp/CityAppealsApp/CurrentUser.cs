using CityAppealsApp.Services;

namespace CityAppealsApp
{
    public static class CurrentUser
    {
        public static int UserID { get; set; }
        public static string FullName { get; set; } = string.Empty;
        public static string Role { get; set; } = string.Empty;
        public static ApiService? ApiService { get; set; }
    }
}