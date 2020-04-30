<?php
// считываем из файла наш текст
$text = file_get_contents('input.txt');
// наше регулярное выражение, ищим число в кавычках
$pattern = '/\'[0-9]+\'/';
$text = preg_replace_callback($pattern, function ($items) {
    preg_match('/[0-9]/', $items[0], $item);
    return '\'' . $item[0] * 2 . '\'';
}, $text);
echo $text;
// выводим полученный текст в файл
$fp = fopen("output.txt", "w");
fwrite($fp, $text);
fclose($fp);