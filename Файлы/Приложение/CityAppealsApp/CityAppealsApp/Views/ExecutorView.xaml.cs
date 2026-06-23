using System.Windows.Controls;
using System.Windows.Input;
using CityAppealsApp.ViewModels;

namespace CityAppealsApp.Views
{
    public partial class ExecutorView : UserControl
    {
        public ExecutorView()
        {
            InitializeComponent();
        }

        private void Row_DoubleClick(object sender, MouseButtonEventArgs e)
        {
            if (DataContext is ExecutorViewModel vm && vm.OpenDetailCommand.CanExecute(null))
            {
                vm.OpenDetailCommand.Execute(null);
            }
        }
    }
}