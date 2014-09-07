<?php

// This file is a simple proxy to pass HTTP requests out to Electric Imp from my domain
$type = preg_replace('/[^a-z\d ]/i', '', $_GET['type']);
$target = preg_replace('/[^a-z\d ]/i', '', $_GET['target']);

$curl_handle=curl_init();
curl_setopt($curl_handle, CURLOPT_URL,"http://agent.electricimp.com/6tQKRkEqAyA5?type=$type&target=$target");
curl_setopt($curl_handle, CURLOPT_CONNECTTIMEOUT, 2);
curl_setopt($curl_handle, CURLOPT_RETURNTRANSFER, 1);
$query = curl_exec($curl_handle);
curl_close($curl_handle);

echo $query;
