using CityAppealsApp.Models;
using CityAppealsApp.Services;
using System.Collections.ObjectModel;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Input;

namespace CityAppealsApp.ViewModels
{
    public class AdminViewModel : ViewModelBase
    {
        private readonly ApiService _api = CurrentUser.ApiService!;
        public ObservableCollection<ApplicationUser> Users { get; set; } = new();

        private string _searchText = string.Empty;
        public string SearchText { get => _searchText; set { _searchText = value; OnPropertyChanged(); } }

        private string _newLogin = string.Empty;
        public string NewLogin { get => _newLogin; set { _newLogin = value; OnPropertyChanged(); } }
        private string _newPassword = string.Empty;
        public string NewPassword { get => _newPassword; set { _newPassword = value; OnPropertyChanged(); } }
        private string _newFullName = string.Empty;
        public string NewFullName { get => _newFullName; set { _newFullName = value; OnPropertyChanged(); } }
        private string _newRole = "Оператор";
        public string NewRole { get => _newRole; set { _newRole = value; OnPropertyChanged(); } }
        public List<string> Roles { get; } = new() { "Оператор", "Исполнитель", "Администратор" };
        private string _newDepartment = string.Empty;
        public string NewDepartment { get => _newDepartment; set { _newDepartment = value; OnPropertyChanged(); } }
        private string _newPosition = string.Empty;
        public string NewPosition { get => _newPosition; set { _newPosition = value; OnPropertyChanged(); } }

        public ICommand RefreshUsersCommand { get; }
        public ICommand RegisterUserCommand { get; }
        public ICommand ToggleActiveCommand { get; }
        public ICommand SearchCommand { get; }

        public AdminViewModel()
        {
            RefreshUsersCommand = new AsyncRelayCommand(async _ => await LoadUsers());
            RegisterUserCommand = new AsyncRelayCommand(async _ => await RegisterUser());
            ToggleActiveCommand = new AsyncRelayCommand(async param => await ToggleActive(param));
            SearchCommand = new AsyncRelayCommand(async _ => await LoadUsers());
            _ = LoadUsers();
        }

        private async Task LoadUsers()
        {
            string url = "api/users";
            if (!string.IsNullOrWhiteSpace(_searchText))
                url += $"?search={Uri.EscapeDataString(_searchText)}";
            var response = await _api.GetAsync<List<ApplicationUser>>(url);
            if (!response.Success)
            {
                MessageBox.Show(response.Message, "Ошибка загрузки пользователей", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }
            Users.Clear();
            foreach (var u in response.Data ?? new List<ApplicationUser>()) Users.Add(u);
        }

        private async Task RegisterUser()
        {
            if (string.IsNullOrWhiteSpace(NewLogin) || string.IsNullOrWhiteSpace(NewPassword) || string.IsNullOrWhiteSpace(NewFullName))
            {
                MessageBox.Show("Заполните логин, пароль и ФИО.", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }
            if (NewLogin.Length > 50 || NewPassword.Length > 50 || NewFullName.Length > 100)
            {
                MessageBox.Show("Превышена допустимая длина.", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }

            var response = await _api.PostAsync<ApplicationUser>("api/users", new
            {
                Login = NewLogin,
                Password = NewPassword,
                FullName = NewFullName,
                Role = NewRole,
                Department = NewDepartment,
                Position = NewPosition
            });

            if (!response.Success)
            {
                MessageBox.Show(response.Message, "Ошибка регистрации", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }

            MessageBox.Show("Пользователь зарегистрирован.", "Успех", MessageBoxButton.OK, MessageBoxImage.Information);
            NewLogin = NewPassword = NewFullName = NewDepartment = NewPosition = string.Empty;
            await LoadUsers();
        }

        private async Task ToggleActive(object? param)
        {
            if (param is not ApplicationUser user) return;
            string action = user.IsActive ? "деактивировать" : "активировать";
            if (MessageBox.Show($"Вы уверены, что хотите {action} пользователя {user.FullName}?", "Подтверждение", MessageBoxButton.YesNo, MessageBoxImage.Question) != MessageBoxResult.Yes)
                return;

            var response = await _api.PutAsync<ApplicationUser>($"api/users/{user.UserID}/toggleactive");
            if (!response.Success)
                MessageBox.Show(response.Message, "Ошибка", MessageBoxButton.OK, MessageBoxImage.Warning);
            else
                await LoadUsers();
        }
    }
}