<?php
require '../config.php';

header('Content-Type: application/json');

$userId = isset($_GET['user_id']) ? (int)$_GET['user_id'] : 0;
$postId = isset($_GET['post_id']) ? (int)$_GET['post_id'] : 0;

if (!$userId || !$postId) {
    http_response_code(400);
    echo json_encode(['error' => 'Missing user_id or post_id']);
    exit;
}

$pdo = getPdo();

$pdo->beginTransaction();

// запись в user_views
$stmt = $pdo->prepare("INSERT IGNORE INTO user_views (user_id, post_id) VALUES (?, ?)");
$stmt->execute([$userId, $postId]);

// увеличение views_count
$stmt = $pdo->prepare("UPDATE posts SET views_count = views_count + 1 WHERE id = ?");
$stmt->execute([$postId]);

$pdo->commit();

echo json_encode(['status' => 'ok']);
