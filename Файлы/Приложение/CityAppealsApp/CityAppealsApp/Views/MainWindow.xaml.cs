using System.Windows;
using System.Windows.Controls;

namespace CityAppealsApp.Views
{
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
            LoadRoleSpecificView();
        }

        private void LoadRoleSpecificView()
        {
            UserControl view = CurrentUser.Role switch
            {
                "Гражданин" => new CitizenView(),
                "Оператор" => new OperatorView(),
                "Исполнитель" => new ExecutorView(),
                "Администратор" => new AdminView(),
                _ => new UserControl()
            };
            ActiveControl.Content = view;
        }
    }
}