using CityAppealsApp.Services;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Input;

namespace CityAppealsApp.ViewModels
{
    public class RegistrationViewModel : ViewModelBase
    {
        private readonly ApiService _api = new ApiService();

        private string _login = string.Empty;
        public string Login { get => _login; set { _login = value; OnPropertyChanged(); } }

        private string _password = string.Empty;
        public string Password { get => _password; set { _password = value; OnPropertyChanged(); } }

        private string _confirmPassword = string.Empty;
        public string ConfirmPassword { get => _confirmPassword; set { _confirmPassword = value; OnPropertyChanged(); } }

        private string _email = string.Empty;
        public string Email { get => _email; set { _email = value; OnPropertyChanged(); } }

        private string _phone = string.Empty;
        public string Phone { get => _phone; set { _phone = value; OnPropertyChanged(); } }

        private string _fullName = string.Empty;
        public string FullName { get => _fullName; set { _fullName = value; OnPropertyChanged(); } }

        private string _address = string.Empty;
        public string Address { get => _address; set { _address = value; OnPropertyChanged(); } }

        public ICommand RegisterCommand { get; }

        public RegistrationViewModel()
        {
            RegisterCommand = new AsyncRelayCommand(async _ => await Register());
        }

        private async Task Register()
        {
            if (string.IsNullOrWhiteSpace(Login) || string.IsNullOrWhiteSpace(Password) || string.IsNullOrWhiteSpace(FullName))
            {
                MessageBox.Show("Логин, пароль и ФИО обязательны.", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }
            if (Login.Length > 50 || Password.Length > 50 || FullName.Length > 100)
            {
                MessageBox.Show("Превышена допустимая длина.", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }
            if (Password != ConfirmPassword)
            {
                MessageBox.Show("Пароли не совпадают.", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }
            if (!string.IsNullOrEmpty(Email) && !Regex.IsMatch(Email, @"^[^@\s]+@[^@\s]+\.[^@\s]+$"))
            {
                MessageBox.Show("Некорректный формат email.", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }
            if (!string.IsNullOrEmpty(Phone) && !Regex.IsMatch(Phone, @"^\+?\d{1,3}?[-.\s]?\(?\d{1,4}?\)?[-.\s]?\d{1,4}[-.\s]?\d{1,9}$"))
            {
                MessageBox.Show("Некорректный формат телефона.", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }

            var response = await _api.PostAsync<object>("api/auth/register", new
            {
                Login,
                Password,
                ConfirmPassword,
                Email,
                Phone,
                FullName,
                Address
            });

            if (!response.Success)
            {
                MessageBox.Show(response.Message ?? "Ошибка регистрации.", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }

            MessageBox.Show("Регистрация успешна. Теперь войдите.", "Успех", MessageBoxButton.OK, MessageBoxImage.Information);
            Application.Current.Windows.OfType<Views.RegistrationWindow>().FirstOrDefault()?.Close();
        }
    }
}