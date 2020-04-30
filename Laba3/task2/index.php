<?php
// подключение к БД
require('connect.php');

// подгружаем данные из бд
global $pdo;
$sql = 'SELECT * FROM news';
$request = $pdo->prepare($sql);
$request->execute();
$data = $request->fetchAll();

// регулярное выражени по которому будем искать нашу ссылку
$pattern = '/(http:\/\/asozd\.duma\.gov\.ru\/main\.nsf\/\(Spravka\)\?OpenAgent&RN=)((\d+)-(\d+))&(\d+)/';
for ($i=0;$i<count($data);$i++) {
    // проверяем, действительно ли в этой записи есть значние, удовлетворяющее нашему регулярному выражению
    if (preg_match($pattern, $data[$i]['item'])) {
        $data[$i]['item'] = preg_replace_callback($pattern, function ($texts) {
            preg_match('/((\d+)-(\d+))/', $texts[0], $text);
            return 'http://sozd.parlament.gov.ru/bill/' . $text[0];
        }, $data[$i]['item']);
                echo $data[$i]['item'];
        // обновим данные
        global $pdo;
        $sql = 'UPDATE news SET item=:item WHERE id_news=:id';
        $request = $pdo->prepare($sql);
        $params = [
        ':id' => $data[$i]['id_news'],
        ':item' => $data[$i]['item']
        ];
        $request->execute($params);
    }
}