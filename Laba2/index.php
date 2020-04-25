<?php
// подключение к БД
require('connect.php');

// путь до нашего .xml файла
$path = 'unemploymentRate.xml';
try {
    // считываем весь файл в переменную xml_string и проверяем на соответствие формат .xml
    $temp = file_get_contents($path);
    if (file_exists($path)) {
        $xml_string = simplexml_load_file($path);
        if (!@simplexml_load_string($temp))
            throw new Exception('Файл не соответствует стандарту xml.');
    } else {
        throw new Exception('Не удалось открыть файл.');
    }
    
    // проходим по каждой "unemployment"
    foreach ($xml_string as $xml) {
        global $pdo;
        // формируем запрос
        $sql = 'INSERT INTO unemployments(country, period, values, unit, previous_values) 
        VALUES(:country, :period, :values, :unit, :previous_values)';
        // передаем наши параметры из xml
        $params = [
            ':country' => $xml->contry,
            ':period' => $xml->period,
            ':values' => $xml->values,
            ':unit' => $xml->unit,
            ':previous_values' => $xml->previousValues
        ];
        $stmt = $pdo->prepare($sql);
        $stmt->execute($params);
    }
    echo 'Данные успешно добавлены!';
} catch (Exception $e) {
    echo $e->getMessage();
    die();
}