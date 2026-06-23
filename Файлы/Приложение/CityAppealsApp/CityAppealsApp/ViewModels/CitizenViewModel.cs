using CityAppealsApp.Models;
using CityAppealsApp.Services;
using System.Collections.ObjectModel;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Input;

namespace CityAppealsApp.ViewModels
{
    public class CitizenViewModel : ViewModelBase
    {
        private readonly ApiService _api = CurrentUser.ApiService!;
        public ObservableCollection<Appeal> Appeals { get; set; } = new();
        private Appeal? _selectedAppeal;
        public Appeal? SelectedAppeal
        {
            get => _selectedAppeal;
            set { _selectedAppeal = value; OnPropertyChanged(); }
        }

        private string _searchText = string.Empty;
        public string SearchText
        {
            get => _searchText;
            set { _searchText = value; OnPropertyChanged(); }
        }

        public ICommand RefreshCommand { get; }
        public ICommand CreateAppealCommand { get; }
        public ICommand DeleteAppealCommand { get; }
        public ICommand OpenDetailCommand { get; }
        public ICommand SearchCommand { get; }

        public CitizenViewModel()
        {
            RefreshCommand = new AsyncRelayCommand(async _ => await LoadAppeals());
            CreateAppealCommand = new AsyncRelayCommand(async _ => await OpenCreateWindow());
            DeleteAppealCommand = new AsyncRelayCommand(async param => await DeleteAppeal(param));
            OpenDetailCommand = new AsyncRelayCommand(async _ => await OpenDetail());
            SearchCommand = new AsyncRelayCommand(async _ => await LoadAppeals());
            _ = LoadAppeals();
        }

        private async Task LoadAppeals()
        {
            string url = "api/appeals";
            if (!string.IsNullOrWhiteSpace(_searchText))
                url += $"?search={Uri.EscapeDataString(_searchText)}";
            var response = await _api.GetAsync<List<Appeal>>(url);
            if (!response.Success)
            {
                MessageBox.Show(response.Message, "Ошибка загрузки", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }
            Appeals.Clear();
            foreach (var a in response.Data ?? new List<Appeal>()) Appeals.Add(a);
        }

        private async Task OpenCreateWindow()
        {
            var window = new Views.CreateAppealWindow();
            window.ShowDialog();
            await LoadAppeals();
        }

        private async Task OpenDetail()
        {
            if (SelectedAppeal == null) return;
            var detailWindow = new Views.AppealDetailWindow(SelectedAppeal.AppealID);
            detailWindow.ShowDialog();
            await LoadAppeals();
        }

        private async Task DeleteAppeal(object? param)
        {
            if (param is not Appeal appeal) return;
            if (appeal.StatusID != 1)
            {
                MessageBox.Show("Можно удалить только обращение в статусе «Новое».", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }
            var result = MessageBox.Show($"Удалить обращение «{appeal.Title}»?", "Подтверждение", MessageBoxButton.YesNo, MessageBoxImage.Question);
            if (result != MessageBoxResult.Yes) return;

            var response = await _api.DeleteAsync<object>($"api/appeals/{appeal.AppealID}");
            if (!response.Success)
                MessageBox.Show(response.Message, "Ошибка удаления", MessageBoxButton.OK, MessageBoxImage.Warning);
            else
                await LoadAppeals();
        }
    }
}