using System.Windows.Controls;
using System.Windows.Input;
using CityAppealsApp.ViewModels;

namespace CityAppealsApp.Views
{
    public partial class CitizenView : UserControl
    {
        public CitizenView()
        {
            InitializeComponent();
        }

        private void Row_DoubleClick(object sender, MouseButtonEventArgs e)
        {
            if (DataContext is CitizenViewModel vm && vm.OpenDetailCommand.CanExecute(null))
            {
                vm.OpenDetailCommand.Execute(null);
            }
        }
    }
}