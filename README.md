![logo3](https://user-images.githubusercontent.com/24189833/37561035-99591946-2a44-11e8-8914-1e52c0d6c6ec.png)
Proxy предназначен главным образом для тех, у кого часто буферят каналы.
HLS в отличие от HTTP позволяет скачивать в несколько потоков. Этим пользуется прокси и старается восполнить буфер вне зависимости от реализации плеера.
Вы не должны замечать присутствие прокси, так как поток отдается плееру сразу при достижении 20 секунд воспроизведения. (Настраивается) Этого обычно достаточно, чтобы продолжать наполнять буфер незаметно для клиента. В идеале у Вас почти минута кешированного потока.
Последняя версия также поддерживает AceMediaServer в формате HLS. Так что, серверный прокси не обязателен.

В качестве бонуса можно кешировать телепрограмму (EPG) в формате xmltv.gz
Отличительная особенность - соединение двух отрезков телепрограммы в один. Например, за прошлую неделю и за настоящую. Таким образм, получается телепрограмма без разрывов.


# Установка
    
    Например, вы собираетесь запустить HLS прокси на компьютере с адресом 192.168.1.1 на порту 8080
    Конфигурация должна быть описана следующим образом:

    "SERVER": {
		"protocol": "http",
		"address": "192.168.1.1",
		"port": 8080
	}


    Плейлист доступен по адресу http://192.168.1.1:8080/playlist.m3u8
    Видеть страницу состояния сервера можно здесь http://192.168.1.1:8080/status
   ![hls33](https://user-images.githubusercontent.com/24189833/39640855-a0a83b2a-4fcc-11e8-810d-a23298466af8.png)

    Главный адрес http://192.168.1.1:8080 теперь используется для двух разных целей:
    Первое, для того, чтобы получить плейлист с различных медиаустройств и плееров. Этот же плейлист можно получить по адресу
    /playlist.m3u8 (Вы можете настроить это из конфигурационного файла. Смотрите значение "playlistPath")

    Второе. Если вы просматриваете страницу из обычного браузера, вы попадаете на страницу каналов.
    Там же вы можете видеть телепрограмму начиная с версии 4.5.0. Поле телепрограммы имеет горизонтальную прокрутку вперёд.
    С этой страницы на компьютере или с сотового телефона вы можете просматривать каналы и вести их запись.
    Записи доступны для просмотра по адресу: http://192.168.1.1:8080/rec
    
![hls4](https://user-images.githubusercontent.com/24189833/37560295-e04b9eaa-2a35-11e8-9e68-f43f82336d33.png)
![img_0212](https://user-images.githubusercontent.com/24189833/37560296-e06c7580-2a35-11e8-9522-05f900afabcd.PNG)


# Телепрограмма

    Начиная с версии 3.0.0 поддерживается EPG ТВ-программа в формате xml.gz (пока только он).
    Настройки телепрограммы в файле конфигурации.
    Самое главное достоинство - объединение двух недель телепрограммы в один список.
    Теперь ваша ТВ-программа не будет иметь пропусков.
    Адрес страницы - http://192.168.1.1:8080/epg
    Обратите внимание, что ТВ-программа не доступна несколько минут при самом первом запуске сервера,
    так как сначала она загружается из интернета.

    По-умолчанию, EPG выключен. Для включения откройте параметр tvGuideUrl в конфигурационном файле.
    Параметр tvGuideUrl может быть массивом ссылок

    Обратите внимание, что сервер не защищен паролем, так как предназначен для домашнего использования. Поэтому,
    не рекомендуется его держать в открытых сетях.
