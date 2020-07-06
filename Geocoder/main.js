$( document ).ready(function() {
    // Ваш api ключ
    var apiKey = 'ТУТ ВАШ API КЛЮЧ';
    $('#ajax_form').submit(function (e) {
        e.preventDefault();
        var adress = $(this).find($('#inputAdress')).val();
        $.ajax({
            url: "https://geocode-maps.yandex.ru/1.x/?apikey=" + apiKey +"&format=json&geocode=" + adress,
            success: function (response) {
                // Структурированный адрес
                var adress = response.response.GeoObjectCollection.featureMember[0].GeoObject.metaDataProperty.GeocoderMetaData.text;
                $('#adress').html(
                    adress
                );
                //Добавляем точку
                var points = response.response.GeoObjectCollection.featureMember[0].GeoObject.Point.pos;
                $('#point').html(
                    points
                );
                //Ближайшее метро
                $.ajax({
                    url: "https://geocode-maps.yandex.ru/1.x/?apikey=" + apiKey +"&format=json&kind=metro&geocode=" + points,
                    success: function (resp) {
                        var metro = resp.response.GeoObjectCollection.featureMember[0].GeoObject.metaDataProperty.GeocoderMetaData.text;
                        var metroPoint = resp.response.GeoObjectCollection.featureMember[0].GeoObject.Point.pos;
                        $('#metro').html(
                            metro+'; '+metroPoint
                        );
                    }
                });
            }
        })
    });
});