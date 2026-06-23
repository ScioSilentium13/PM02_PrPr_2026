using System.Windows.Controls;
using System.Windows.Input;
using CityAppealsApp.ViewModels;

namespace CityAppealsApp.Views
{
    public partial class OperatorView : UserControl
    {
        public OperatorView()
        {
            InitializeComponent();
        }

        private void Row_DoubleClick(object sender, MouseButtonEventArgs e)
        {
            if (DataContext is OperatorViewModel vm && vm.OpenDetailCommand.CanExecute(null))
            {
                vm.OpenDetailCommand.Execute(null);
            }
        }
    }
}