<?php
// HTTP
define('HTTP_SERVER', 'http://#nome_da_loja#.#dominio_loja#/admin/');
define('HTTP_CATALOG', 'http://#nome_da_loja#.#dominio_loja#/');

// HTTPS
define('HTTPS_SERVER', 'http://#nome_da_loja#.#dominio_loja#/admin/');
define('HTTPS_CATALOG', 'http://#nome_da_loja#.#dominio_loja#/');

// DIR
//define('DIR_APPLICATION', realpath('./') . '\\');
//define('DIR_SYSTEM', realpath('../system/') . '\\');
//define('DIR_LANGUAGE', realpath('language/') . '\\');
//define('DIR_TEMPLATE', realpath('view/template/') . '\\');
//define('DIR_CONFIG', realpath('../system/config/') . '\\');
//define('DIR_IMAGE', realpath('../image/') . '\\');
//define('DIR_CACHE', realpath('../system/storage/cache/') . '\\');
//define('DIR_DOWNLOAD', realpath('../system/storage/download/') . '\\');
//define('DIR_LOGS', realpath('../system/storage/logs/') . '\\');
//define('DIR_MODIFICATION', realpath('../system/storage/modification/') . '\\');
//define('DIR_UPLOAD', realpath('../system/storage/upload/') . '\\');
//define('DIR_CATALOG', realpath('../catalog/') . '\\');

// DIR Linux
define('DIR_APPLICATION', realpath('./') . '/');
define('DIR_SYSTEM', realpath('../system/') . '/');
define('DIR_LANGUAGE', realpath('language/') . '/');
define('DIR_TEMPLATE', realpath('view/template/') . '/');
define('DIR_CONFIG', realpath('../system/config/') . '/');
define('DIR_IMAGE', realpath('../image/') . '/');
define('DIR_CACHE', realpath('../system/storage/cache/') . '/');
define('DIR_DOWNLOAD', realpath('../system/storage/download/') . '/');
define('DIR_LOGS', realpath('../system/storage/logs/') . '/');
define('DIR_MODIFICATION', realpath('../system/storage/modification/') . '/');
define('DIR_UPLOAD', realpath('../system/storage/upload/') . '/');
define('DIR_CATALOG', realpath('../catalog/') . '/');

// DB
define('DB_DRIVER', 'mysqli');
define('DB_HOSTNAME', 'localhost');
define('DB_USERNAME', 'root');
define('DB_PASSWORD', 'R1D2C3ommerce');
define('DB_DATABASE', '#nome_da_loja#');
define('DB_PORT', '3306');
define('DB_PREFIX', 'oc_');
