# KODE-ios-app
Swift iOS exercise application (reference: KODE-Android)

Моё первое iOS приложение

- подгружает данные о сотрудниках с сервера в UITableView
- фильтрация сотрудников
- поиск сотрудников в таблице
- сортировка по имени и дню рождения через модальное окно (реализован паттерн Delegate)
- просмотр детальной информации о каждом сотруднике
- есть проверка наличия Интернет-соединения через NWPathMonitor


![noInternetView](https://user-images.githubusercontent.com/60381965/197357166-c532a11e-d68f-490e-aace-30d795f43045.gif)

![loadingView](https://user-images.githubusercontent.com/60381965/197357169-ca4de01e-2722-4027-9007-f66b843c03be.gif)

![filterByProfession](https://user-images.githubusercontent.com/60381965/197357180-3cdb90b9-136e-4838-826a-716179eb19e2.gif)

![searching](https://user-images.githubusercontent.com/60381965/197357183-992a9dca-5ff4-48a7-8a19-47093a0fa232.gif)

[detailsScreen.webm](https://user-images.githubusercontent.com/60381965/197359502-8b8d3523-25a4-4e03-bf2f-8059f361f932.webm)

[sortByName.webm](https://user-images.githubusercontent.com/60381965/197359726-990b808e-7243-4531-810b-cef133aa08e9.webm)

Технологии, использованные в проекте:
- UIKit, вёрстка кодом
- URLSession.dataTask для получения данных с сервера
- Codable, JSONDecoder для парсинга 
- UIGraphics для изменения размера UIImage
- Plural Localization для возраста (слов "лет, года, год") через NSStringLocalizedFormatKey
- кодогенерация ресурсов с помощью RSwift
- CocoaPods, чтобы подтянуть FloatingPanel (модальное окно) и RSwift
