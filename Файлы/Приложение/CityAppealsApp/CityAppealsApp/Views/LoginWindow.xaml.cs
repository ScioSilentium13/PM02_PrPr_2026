using System.Windows;
using System.Windows.Controls;

namespace CityAppealsApp.Views
{
    public partial class LoginWindow : Window
    {
        public LoginWindow()
        {
            InitializeComponent();
        }

        private void LoginButton_Click(object sender, RoutedEventArgs e)
        {
            // Передаём пароль из PasswordBox во ViewModel
            if (DataContext is ViewModels.LoginViewModel vm)
            {
                vm.Password = PasswordBox.Password;
            }
        }
    }
}