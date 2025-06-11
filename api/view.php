<?php
require '../config.php';

header('Content-Type: application/json');

$userId = isset($_POST['user_id']) ? (int)$_POST['user_id'] : 0;
$postId = isset($_POST['post_id']) ? (int)$_POST['post_id'] : 0;

if (!$userId || !$postId) {
    http_response_code(400);
    echo json_encode(['error' => 'Missing user_id or post_id']);
    exit;
}

$pdo = getPdo();

$pdo->beginTransaction();

$stmt = $pdo->prepare("INSERT IGNORE INTO user_views (user_id, post_id) VALUES (?, ?)");
$stmt->execute([$userId, $postId]);

$stmt = $pdo->prepare("UPDATE posts SET views_count = views_count + 1 WHERE id = ?");
$stmt->execute([$postId]);

$pdo->commit();

echo json_encode(['status' => 'ok']);
