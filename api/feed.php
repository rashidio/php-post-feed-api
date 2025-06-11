<?php
require '../config.php';

header('Content-Type: application/json');

$userId = isset($_GET['user_id']) ? (int)$_GET['user_id'] : 0;
if (!$userId) {
    http_response_code(400);
    echo json_encode(['error' => 'Missing user_id']);
    exit;
}

$lastHotness = isset($_GET['last_hotness']) ? (int)$_GET['last_hotness'] : null;
$lastId = isset($_GET['last_id']) ? (int)$_GET['last_id'] : null;
$limit = 50;

$pdo = getPdo();

$params = [$userId, 1000];

$sql = "
    SELECT p.id, p.created_at, p.title, p.content, p.hotness, p.views_count
    FROM posts p
    WHERE p.views_count <= ?
      AND NOT EXISTS (
          SELECT 1 FROM user_views uv WHERE uv.user_id = ? AND uv.post_id = p.id
      )
";

// keyset pagination
if ($lastHotness !== null && $lastId !== null) {
    $sql .= " AND (p.hotness < ? OR (p.hotness = ? AND p.id < ?)) ";
    $params = array_merge($params, [$lastHotness, $lastHotness, $lastId]);
}

$sql .= " ORDER BY p.hotness DESC, p.id DESC LIMIT $limit";


$stmt = $pdo->prepare($sql);
$stmt->execute($params);
$posts = $stmt->fetchAll();

echo json_encode($posts);
