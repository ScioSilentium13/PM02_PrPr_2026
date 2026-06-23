using System.Windows;
using System.Windows.Input;

namespace CityAppealsApp.ViewModels
{
    public class MainViewModel : ViewModelBase
    {
        public string UserInfo => $"{CurrentUser.FullName} ({CurrentUser.Role})";

        public ICommand LogoutCommand { get; }

        public MainViewModel()
        {
            LogoutCommand = new RelayCommand(_ => Logout());
        }

        private void Logout()
        {
            new Views.LoginWindow().Show();
            Application.Current.Windows.OfType<Views.MainWindow>().FirstOrDefault()?.Close();
        }
    }
}