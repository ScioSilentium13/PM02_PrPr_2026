namespace CityAppealsApi.Models.Dto
{
    public class LoginRequest
    {
        public string Login { get; set; } = string.Empty;
        public string Password { get; set; } = string.Empty;
    }

    public class RegisterRequest
    {
        public string Login { get; set; } = string.Empty;
        public string Password { get; set; } = string.Empty;
        public string ConfirmPassword { get; set; } = string.Empty;
        public string? Email { get; set; }
        public string? Phone { get; set; }
        public string FullName { get; set; } = string.Empty;
        public string? Address { get; set; }
    }

    public class LoginResponse
    {
        public int UserId { get; set; }
        public string FullName { get; set; } = string.Empty;
        public string Role { get; set; } = string.Empty;
    }

    public class CreateAppealRequest
    {
        public string Title { get; set; } = string.Empty;
        public string? Description { get; set; }
        public int CategoryId { get; set; }
    }

    public class UpdateAppealRequest
    {
        public int? StatusId { get; set; }
        public int? AssignedToId { get; set; }
        public string? Comment { get; set; }
    }

    public class CreateUserRequest
    {
        public string Login { get; set; } = string.Empty;
        public string Password { get; set; } = string.Empty;
        public string FullName { get; set; } = string.Empty;
        public string Role { get; set; } = string.Empty;
        public string? Department { get; set; }
        public string? Position { get; set; }
    }
}