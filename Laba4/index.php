<?php
// подключение к БД
require('connect.php');

// подгружаем данные из бд
global $pdo;
$sql = 'SELECT * FROM news';
$request = $pdo->prepare($sql);
$request->execute();
$data = $request->fetchAll();
//И выведем данные на страницу
for( $i = 0; $i < count($data); $i++ ){
    echo '<div class=\'data\'>
    <p style="font-size: 25px;">id_news:' . $data[$i]["id_news"]. '</p>
    <p style="font-size: 25px;">item:</p>
    '. $data[$i]["item"].'
    </div>';
}
echo "<h1>Решение:</h1>";

//Запросы
$sqlRequest1 = '%Владимир Жириновский%; DROP TABLE news';
$sqlRequest2 = '3 OR 1=1';
$sql1 = 'select * from news WHERE item LIKE :param;';
$sql2 = 'select * from news WHERE id_news=:param';
//Вызываем функцию для проверки sql-инъекций
echo testSqlInjections($sql1, $sqlRequest1) . '<br>';
echo testSqlInjections($sql2, $sqlRequest2);
function testSqlInjections(string $sql, string $param)
{
    try {
        global $pdo;
        $request = $pdo->prepare($sql);
        $params = [
            ':param' => $param,
        ];
        $request->execute($params);
        $datas = $request->fetchAll();
        if($datas)
            return true;
        else
            return 'SQL-инъекция не прошла.';
    }
    catch (Exception $e)
    {
        return $e->getMessage();
    }
}
