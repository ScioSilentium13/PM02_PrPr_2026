using CityAppealsApp.Services;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Input;

namespace CityAppealsApp.ViewModels
{
    public class LoginViewModel : ViewModelBase
    {
        private readonly ApiService _api = new ApiService();

        private string _login = string.Empty;
        public string Login
        {
            get => _login;
            set { _login = value; OnPropertyChanged(); }
        }

        private string _password = string.Empty;
        public string Password
        {
            get => _password;
            set { _password = value; OnPropertyChanged(); }
        }

        public ICommand LoginCommand { get; }
        public ICommand RegisterCommand { get; }

        public LoginViewModel()
        {
            LoginCommand = new AsyncRelayCommand(async _ => await Authenticate());
            RegisterCommand = new RelayCommand(_ => OpenRegistration());
        }

        private async Task Authenticate()
        {
            if (string.IsNullOrWhiteSpace(Login))
            {
                MessageBox.Show("Логин обязателен.", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }
            if (string.IsNullOrWhiteSpace(Password))
            {
                MessageBox.Show("Пароль обязателен.", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }
            if (Login.Length > 50 || Password.Length > 50)
            {
                MessageBox.Show("Превышена допустимая длина.", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }

            var response = await _api.PostAsync<Models.ApplicationUser>("api/auth/login", new { Login, Password });
            if (!response.Success)
            {
                MessageBox.Show(response.Message ?? "Ошибка входа.", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }

            var user = response.Data!;
            _api.SetCredentials(Login, Password); // сохраняем для последующих запросов

            CurrentUser.UserID = user.UserID;
            CurrentUser.FullName = user.FullName;
            CurrentUser.Role = user.Role;
            CurrentUser.ApiService = _api; // передаём сервис другим ViewModels

            var mainWindow = new Views.MainWindow();
            mainWindow.Show();
            Application.Current.Windows.OfType<Views.LoginWindow>().FirstOrDefault()?.Close();
        }

        private void OpenRegistration()
        {
            var regWindow = new Views.RegistrationWindow();
            regWindow.ShowDialog();
        }
    }
}