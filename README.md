# KODE-ios-app
Swift iOS exercise application (reference: KODE-Android)

Моё первое iOS приложение. В качестве архитектуры - Cocoa MVC.

- подтягивает данные о сотрудниках с сервера в UITableView
- фильтрация сотрудников
- поиск сотрудников в таблице
- сортировка по имени и дню рождения через модальное окно (реализован паттерн Delegate)
- просмотр детальной информации о каждом сотруднике

Технологии, использованные в проекте:
- UIKit, вёрстка кодом
- CABasicAnimation для создания shimmer loading view
- URLSession.dataTask для получения данных с сервера
- Codable, JSONDecoder для парсинга 
- UIGraphics для изменения размера UIImage
- Plural Localization для возраста (слов "лет, года, год") через NSStringLocalizedFormatKey
- кодогенерация ресурсов с помощью RSwift
- CocoaPods, чтобы подтянуть FloatingPanel (модальное окно) и RSwift


![noInternetConection (1)](https://user-images.githubusercontent.com/60381965/197363625-d66a62ab-63a5-49db-94c8-1d58ce0771d5.gif)
![loadingAnimation](https://user-images.githubusercontent.com/60381965/197363500-7fc17a05-18aa-4349-b488-4a0e9abea7a7.gif)

![Searching](https://user-images.githubusercontent.com/60381965/197363758-e67d29a2-32a1-42a0-a9a4-e63172f713eb.gif)
![fillterByProfession](https://user-images.githubusercontent.com/60381965/197363766-ef0d1e3a-3a5e-4474-aca5-b231658b9a4b.gif)

![SortingByName](https://user-images.githubusercontent.com/60381965/197363333-f68f5f72-e330-4705-8b6a-80897fc290b1.gif)
![detailsScreen](https://user-images.githubusercontent.com/60381965/197363431-6794f52d-a4e3-4951-a03d-37a378d96980.gif)
