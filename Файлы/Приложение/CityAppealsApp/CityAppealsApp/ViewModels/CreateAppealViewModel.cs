using CityAppealsApp.Models;
using CityAppealsApp.Services;
using System.Collections.ObjectModel;
using System.IO;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Input;

namespace CityAppealsApp.ViewModels
{
    public class CreateAppealViewModel : ViewModelBase
    {
        private readonly ApiService _api = CurrentUser.ApiService!;
        public ObservableCollection<Category> Categories { get; set; } = new();
        private Category? _selectedCategory;
        public Category? SelectedCategory { get => _selectedCategory; set { _selectedCategory = value; OnPropertyChanged(); } }

        private string _title = string.Empty;
        public string Title { get => _title; set { _title = value; OnPropertyChanged(); } }

        private string _description = string.Empty;
        public string Description { get => _description; set { _description = value; OnPropertyChanged(); } }

        public ObservableCollection<string> TempFiles { get; } = new();

        public ICommand CreateCommand { get; }
        public ICommand AddFileCommand { get; }

        public CreateAppealViewModel()
        {
            CreateCommand = new AsyncRelayCommand(async _ => await Create());
            AddFileCommand = new RelayCommand(_ => AddFile());
            _ = LoadCategories();
        }

        private async Task LoadCategories()
        {
            var response = await _api.GetAsync<List<Category>>("api/categories");
            if (response.Success)
            {
                Categories.Clear();
                foreach (var c in response.Data!) Categories.Add(c);
            }
            else
            {
                MessageBox.Show(response.Message, "Ошибка загрузки категорий", MessageBoxButton.OK, MessageBoxImage.Warning);
            }
        }

        private void AddFile()
        {
            var dlg = new Microsoft.Win32.OpenFileDialog
            {
                Title = "Выберите файл для вложения",
                Filter = "Все файлы (*.*)|*.*"
            };
            if (dlg.ShowDialog() == true)
            {
                TempFiles.Add(dlg.FileName);
            }
        }

        private async Task Create()
        {
            if (SelectedCategory == null)
            {
                MessageBox.Show("Выберите категорию.", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }
            if (string.IsNullOrWhiteSpace(Title))
            {
                MessageBox.Show("Заголовок обязателен.", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }
            if (Title.Length > 200)
            {
                MessageBox.Show("Заголовок слишком длинный.", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }

            var response = await _api.PostAsync<Appeal>("api/appeals", new
            {
                Title,
                Description,
                CategoryId = SelectedCategory.CategoryID
            });

            if (!response.Success)
            {
                MessageBox.Show(response.Message, "Ошибка создания обращения", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }

            int appealId = response.Data!.AppealID;
            // Загрузка вложений
            foreach (string filePath in TempFiles)
            {
                byte[] fileBytes = File.ReadAllBytes(filePath);
                var fileResponse = await _api.PostFileAsync<Attachment>($"api/appeals/{appealId}/attachments", fileBytes, Path.GetFileName(filePath));
                if (!fileResponse.Success)
                {
                    MessageBox.Show(fileResponse.Message, "Ошибка загрузки файла", MessageBoxButton.OK, MessageBoxImage.Warning);
                }
            }

            MessageBox.Show("Обращение создано.", "Успех", MessageBoxButton.OK, MessageBoxImage.Information);
            Application.Current.Windows.OfType<Views.CreateAppealWindow>().FirstOrDefault()?.Close();
        }
    }
}