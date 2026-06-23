using CityAppealsApp.Models;
using CityAppealsApp.Services;
using System.Collections.ObjectModel;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Input;

namespace CityAppealsApp.ViewModels
{
    public class AppealDetailViewModel : ViewModelBase
    {
        private readonly ApiService _api = CurrentUser.ApiService!;
        private readonly int _appealId;
        private readonly string _currentUserRole;

        public Appeal Appeal { get; private set; } = null!;

        public ObservableCollection<Status> AllStatuses { get; } = new();
        public ObservableCollection<ApplicationUser> Executors { get; } = new();
        public ObservableCollection<AppealHistory> Histories { get; } = new();
        public ObservableCollection<Attachment> Attachments { get; } = new();

        private Status? _selectedStatus;
        public Status? SelectedStatus { get => _selectedStatus; set { _selectedStatus = value; OnPropertyChanged(); } }

        private ApplicationUser? _selectedExecutor;
        public ApplicationUser? SelectedExecutor { get => _selectedExecutor; set { _selectedExecutor = value; OnPropertyChanged(); } }

        private string _newComment = string.Empty;
        public string NewComment { get => _newComment; set { _newComment = value; OnPropertyChanged(); } }

        // Видимость полей
        public Visibility StatusEditorVisibility =>
            (_currentUserRole == "Оператор" || _currentUserRole == "Исполнитель" || _currentUserRole == "Администратор") ? Visibility.Visible : Visibility.Collapsed;
        public Visibility StatusTextViewerVisibility => _currentUserRole == "Гражданин" ? Visibility.Visible : Visibility.Collapsed;
        public Visibility ExecutorEditorVisibility =>
            (_currentUserRole == "Оператор" || _currentUserRole == "Администратор") ? Visibility.Visible : Visibility.Collapsed;
        public Visibility ExecutorTextViewerVisibility =>
            (_currentUserRole != "Оператор" && _currentUserRole != "Администратор") ? Visibility.Visible : Visibility.Collapsed;
        public Visibility CommentEditorVisibility =>
            (_currentUserRole == "Оператор" || _currentUserRole == "Исполнитель" || _currentUserRole == "Администратор") ? Visibility.Visible : Visibility.Collapsed;
        public Visibility HistoryVisibility => _currentUserRole != "Гражданин" ? Visibility.Visible : Visibility.Collapsed;
        public Visibility SaveButtonVisibility => _currentUserRole != "Гражданин" ? Visibility.Visible : Visibility.Collapsed;

        public ICommand SaveCommand { get; }
        public ICommand AddCommentCommand { get; }
        public ICommand OpenAttachmentCommand { get; }

        public AppealDetailViewModel(int appealId)
        {
            _appealId = appealId;
            _currentUserRole = CurrentUser.Role;
            SaveCommand = new AsyncRelayCommand(async _ => await SaveChanges());
            AddCommentCommand = new AsyncRelayCommand(async _ => await AddComment());
            OpenAttachmentCommand = new RelayCommand(param => OpenAttachment(param));
            _ = LoadDataAsync();
        }

        private async Task LoadDataAsync()
        {
            var response = await _api.GetAsync<Appeal>($"api/appeals/{_appealId}");
            if (!response.Success)
            {
                MessageBox.Show(response.Message, "Ошибка", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }
            Appeal = response.Data!;
            OnPropertyChanged(nameof(Appeal));

            // Загружаем справочники
            var statusesResponse = await _api.GetAsync<List<Status>>("api/statuses");
            if (statusesResponse.Success)
            {
                AllStatuses.Clear();
                foreach (var s in statusesResponse.Data!) AllStatuses.Add(s);
                SelectedStatus = AllStatuses.FirstOrDefault(s => s.StatusID == Appeal.StatusID);
            }

            if (_currentUserRole == "Оператор" || _currentUserRole == "Администратор")
            {
                var executorsResponse = await _api.GetAsync<List<ApplicationUser>>("api/users?role=Исполнитель"); // упрощённо
                if (executorsResponse.Success)
                {
                    Executors.Clear();
                    foreach (var u in executorsResponse.Data!.Where(u => u.Role == "Исполнитель" && u.IsActive))
                        Executors.Add(u);
                    SelectedExecutor = Executors.FirstOrDefault(e => e.UserID == Appeal.AssignedToID);
                }
            }

            Histories.Clear();
            if (_currentUserRole != "Гражданин")
            {
                // История приходит в объекте Appeal, если включена Include на сервере
                if (Appeal.Histories != null)
                    foreach (var h in Appeal.Histories.OrderBy(h => h.ActionDate)) Histories.Add(h);
            }

            Attachments.Clear();
            if (Appeal.Attachments != null)
                foreach (var a in Appeal.Attachments) Attachments.Add(a);
        }

        private async Task SaveChanges()
        {
            var update = new
            {
                StatusId = SelectedStatus?.StatusID != Appeal.StatusID ? SelectedStatus?.StatusID : null,
                AssignedToId = SelectedExecutor?.UserID != Appeal.AssignedToID ? SelectedExecutor?.UserID : null,
                Comment = (string?)null // Комментарий добавляется отдельно
            };

            var response = await _api.PutAsync<Appeal>($"api/appeals/{_appealId}", update);
            if (!response.Success)
            {
                MessageBox.Show(response.Message, "Ошибка сохранения", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }
            Application.Current.Windows.OfType<Views.AppealDetailWindow>().FirstOrDefault()?.Close();
        }

        private async Task AddComment()
        {
            if (string.IsNullOrWhiteSpace(NewComment)) return;
            var update = new { StatusId = (int?)null, AssignedToId = (int?)null, Comment = NewComment };
            var response = await _api.PutAsync<Appeal>($"api/appeals/{_appealId}", update);
            if (!response.Success)
            {
                MessageBox.Show(response.Message, "Ошибка добавления комментария", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }
            NewComment = string.Empty;
            await LoadDataAsync();
        }

        private void OpenAttachment(object? param)
        {
            if (param is not Attachment attachment) return;
            // Скачиваем файл через API и открываем
            var temp = Path.GetTempPath();
            var filePath = Path.Combine(temp, attachment.FileName);
            // Простая реализация: предполагаем, что можем скачать по url api/attachments/{id}/download
            // Но проще: открыть с использованием пути из модели, если он абсолютный?
            // Используем API для скачивания
            _ = DownloadAndOpen(attachment);
        }

        private async Task DownloadAndOpen(Attachment attachment)
        {
            var response = await _api.GetAsync<byte[]>($"api/attachments/{attachment.AttachmentID}/download");
            if (!response.Success || response.Data == null)
            {
                MessageBox.Show("Не удалось открыть файл.", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }
            string tempDir = Path.GetTempPath();
            string filePath = Path.Combine(tempDir, attachment.FileName);
            File.WriteAllBytes(filePath, response.Data);
            try
            {
                Process.Start(new ProcessStartInfo(filePath) { UseShellExecute = true });
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Не удалось открыть файл: {ex.Message}", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }
    }
}