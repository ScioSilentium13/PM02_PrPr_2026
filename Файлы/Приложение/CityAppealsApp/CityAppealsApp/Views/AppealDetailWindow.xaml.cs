using System.Windows;

namespace CityAppealsApp.Views
{
    public partial class AppealDetailWindow : Window
    {
        public AppealDetailWindow(int appealId)
        {
            InitializeComponent();
            DataContext = new ViewModels.AppealDetailViewModel(appealId);
        }
    }
}