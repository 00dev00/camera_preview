## Тестовое задание Flutter для [pyShop](https://jl.pyshop.ru/tasks/flutter-dev/)

> Мобильное приложение состоит из одного экрана, с элементами UI:
> - [x] Preview изображения с камеры
> - [x] Поле ввода текста для пользовательского комментария
> - [x] Кнопка, при нажатии на которую отправляется запрос на сервер.
> При нажатии на кнопку, приложение должно определять координаты места в котором находится камера, захватывать изображение с камеры, забирать комментарий из текстового поля и отправлять это запросом на сервер.

Для выполнения запроса был создан новый эндпоинт.
Пример запроса:\
```curl  -X POST https://pyshop-flutter-test.free.beeceptor.com -F comment="Random comment" -F latitude=38.897675 -F longitude=-77.036547 -F photo=@1.jpg```

Пермишены, необходимые для доступа к камере, геолокации и сети:
1. android.permission.ACCESS_FINE_LOCATION
2. android.permission.ACCESS_COARSE_LOCATION
3. android.permission.INTERNET