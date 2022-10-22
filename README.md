# KODE-ios-app
Swift iOS exercise application (reference: KODE-Android)

Моё первое iOS приложение

- подтягивает данные о сотрудниках с сервера в UITableView
- фильтрация сотрудников
- поиск сотрудников в таблице
- сортировка по имени и дню рождения через модальное окно (реализован паттерн Delegate)
- просмотр детальной информации о каждом сотруднике
- есть проверка наличия Интернет-соединения через NWPathMonitor

Технологии, использованные в проекте:
- UIKit, вёрстка кодом
- URLSession.dataTask для получения данных с сервера
- Codable, JSONDecoder для парсинга 
- UIGraphics для изменения размера UIImage
- Plural Localization для возраста (слов "лет, года, год") через NSStringLocalizedFormatKey
- кодогенерация ресурсов с помощью RSwift
- CocoaPods, чтобы подтянуть FloatingPanel (модальное окно) и RSwift


[noInternetView.webm](https://user-images.githubusercontent.com/60381965/197362237-692af7cd-faac-43f6-9833-11262fae006f.webm)

[loadingAnimation.webm](https://user-images.githubusercontent.com/60381965/197362257-ff49983c-3c08-44ea-b003-c843ad8ed903.webm)

[filterByProfession.webm](https://user-images.githubusercontent.com/60381965/197362326-b286b9b5-ea9b-4679-b3aa-6b49b7c04064.webm)

[searching.webm](https://user-images.githubusercontent.com/60381965/197362273-3809f932-24e5-42c6-b999-1630b794c05a.webm)

[detailsScreen.webm](https://user-images.githubusercontent.com/60381965/197359502-8b8d3523-25a4-4e03-bf2f-8059f361f932.webm)

[sortByName.webm](https://user-images.githubusercontent.com/60381965/197359726-990b808e-7243-4531-810b-cef133aa08e9.webm)
