# KODE-ios-app
Swift iOS exercise application (reference: KODE-Android)

Моё первое iOS приложение

- подгружает данные о сотрудниках с сервера в UITableView
- фильтрация сотрудников
- поиск сотрудников в таблице
- сортировка по имени и дню рождения через модальное окно (реализован паттерн Delegate)
- просмотр детальной информации о каждом сотруднике
- есть проверка наличия Интернет-соединения через NWPathMonitor

![noInternetView](https://user-images.githubusercontent.com/60381965/197360815-c8ce66fa-606c-4258-a181-27a57712e082.gif)

![loadingView](https://user-images.githubusercontent.com/60381965/197360817-a1c994ea-faa2-4beb-bc01-aa51baf66c01.gif)

![filterByProfession](https://user-images.githubusercontent.com/60381965/197360821-aa5efc41-614a-4139-8050-1d69c5bc380b.gif)

![searching](https://user-images.githubusercontent.com/60381965/197360824-63fc2071-7af8-47b4-9d8c-ed5eb1dbae26.gif)

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
