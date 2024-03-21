## Тестовое задание Flutter для [pyShop](https://jl.pyshop.ru/tasks/flutter-dev/)

**Минимальная версия Android SDK 21** (требования плагина camera)

> Мобильное приложение состоит из одного экрана, с элементами UI:
> 1. Preview изображения с камеры
> 2. Поле ввода текста для пользовательского комментария
> 3. Кнопка, при нажатии на котороую отправляется запрос на сервер.
> При нажатии на кнопку, приложение должно определять координаты места в котором находится камера, захватывать изображение с камеры, забирать комментарий из текстового поля и отправлять это запросом на сервер.
Пример запроса:\
`curl  -H "Content-Type: application/javascript" -X POST https://flutter-sandbox.free.beeceptor.com/upload_photo/ -F comment="A photo from the phone camera." -F latitude=38.897675 -F longitude=-77.036547 -F photo=@test.png`