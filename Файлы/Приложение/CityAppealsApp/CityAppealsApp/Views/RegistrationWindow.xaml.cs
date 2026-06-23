using System.Windows;
using System.Windows.Controls;

namespace CityAppealsApp.Views
{
    public partial class RegistrationWindow : Window
    {
        public RegistrationWindow()
        {
            InitializeComponent();
        }

        private void RegisterButton_Click(object sender, RoutedEventArgs e)
        {
            if (DataContext is ViewModels.RegistrationViewModel vm)
            {
                vm.Password = PasswordBox.Password;
                vm.ConfirmPassword = ConfirmPasswordBox.Password;
            }
        }
    }
}