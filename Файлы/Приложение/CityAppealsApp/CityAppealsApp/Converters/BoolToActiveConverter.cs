using System;
using System.Globalization;
using System.Windows.Data;

namespace CityAppealsApp.Converters
{
    public class BoolToActiveConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            if (value is bool isActive)
                return isActive ? "Активен" : "Не активен";
            return "Не активен";
        }

        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
        {
            throw new NotImplementedException();
        }
    }
}