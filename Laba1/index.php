<?php
try {
	//Считаем ответ, на будущее  =)
	$fpWinner = fopen('D:/DOWNLOADS/AI/3_kurs/2_semestr/Intaro/Lern/WEB/regtur/regtur/test/A/008.ans', 'rt');
	$win = explode(" ",  trim(fgets($fpWinner)));
	$win = intval($win[0]);
	fclose($fpWinner);
	//
	$fp = fopen('D:/DOWNLOADS/AI/3_kurs/2_semestr/Intaro/Lern/WEB/regtur/regtur/test/A/008.dat', 'rt');
	//$fp = fopen('input.txt', 'rt');
	if(!$fp)
		throw new Exception ("Файл не найден.");
	//Считываем количество ставок и сами ставки
	$n = explode(" ",  trim(fgets($fp)));
	$n = intval($n[0]);
	$proba = 0;
	if($n < 1 or $n>pow(10,4))
		throw new Exception("Число n=$n не удовлетворяет заданым условиям");
	for ($i = 0; $i < $n; $i++) {
		list($a[], $s[], $command[]) = explode(" ", trim(fgets($fp)));
		$a[$i] = intval($a[$i]);
		$s[$i] = intval($s[$i]);
		$proba +=$s[$i];
		if ($a[$i] < 1 or $a[$i] > pow(10, 5)){
			throw new Exception("Число a=$a[$i] не удовлетворяет заданым условиям");
		}
		if($s[$i] < 1 or $s[$i] >1000)
			throw new Exception("Число s=$s[$i] не удовлетворяет заданым условиям");
		if(
			(strcasecmp($command[$i], "L") != 0) && 
			(strcasecmp($command[$i], "R") != 0) && 
			(strcasecmp($command[$i], "D") != 0)
		)
		{
			throw new Exception("Такой команды нет.");
		}
	}
	//Считываем количество игр и сами игры
	$m = explode(" ",  trim(fgets($fp)));
	$m = intval($m[0]);
	if ($m < $n or $m > pow(10, 5))
		throw new Exception("Число m=$m не удовлетворяет заданым условиям");
	for ($i = 0; $i < $m; $i++) {
		list($b[], $l[], $r[], $d[], $winner[]) = explode(" ", trim(fgets($fp)));
		$b[$i] = intval($b[$i]);
		$l[$i] = floatval($l[$i]);
		$d[$i] = floatval($d[$i]);
		$r[$i] = floatval($r[$i]);
		if ($b[$i] < 1 or $b[$i] > pow(10, 5))
			throw new Exception("Число b=$b[$i] не удовлетворяет заданым условиям");
		if (($l[$i] < 1 or $l[$i] > pow(10, 5)) && 
		($r[$i] < 1 or $r[$i] > pow(10, 5)) && 
		($d[$i] < 1 or $d[$i] > pow(10, 5)))
			throw new Exception("Число не удовлетворяет заданым условиям");
		if (
			(strcasecmp($winner[$i], "L") != 0) &&
			(strcasecmp($winner[$i], "R") != 0) &&
			(strcasecmp($winner[$i], "D") != 0)
		) {
			echo var_dump($winner);
			throw new Exception("Такой команды нет.");
		}
	}
	fclose($fp); //закрыли наш файлик
	//Логистика пошла
	$total = 0.0;
	$inkrement=0;
	foreach ($a as $val) {
		$i = $val-1;
		switch ($winner[$i]) {
			case "L":
				if (strcasecmp($winner[$i], $command[$inkrement]) == 0){
					$total += $s[$inkrement] * $l[$i];
				}
				break;
			case "R":
				if (strcasecmp($winner[$i], $command[$inkrement]) == 0){
					$total += $s[$inkrement] * $r[$i];
				}
				break;
			case "D":
				if (strcasecmp($winner[$i], $command[$inkrement]) == 0){
					$total += $s[$inkrement] * $d[$i];
				}
				break;
		}
		$inkrement++;
	}
	$total = $total-$proba;
	echo "<br>$total";
	$total = intval($total);
	if($total == $win)
		echo "<br>YES";
	else
		echo "<br>NO";
	$fp = fopen("output.txt", "w");
	fwrite($fp, $total);
	fclose($fp);
} 
catch (Exception $e) {
	echo 'Выброшено исключение: ',  $e->getMessage(), "\n";
}