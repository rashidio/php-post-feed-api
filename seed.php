<?php
require 'config.php';

$pdo = getPdo();

//$pdo->exec("TRUNCATE TABLE posts");

$total = 5000000;
$batchSize = 10000;
$batches = ceil($total / $batchSize);

for ($b = 0; $b < $batches; $b++) {
    $values = [];
    $params = [];

    for ($i = 0; $i < $batchSize && ($b * $batchSize + $i) < $total; $i++) {
        $createdAt = date('Y-m-d H:i:s', time() - rand(0, 365 * 24 * 3600));
        $title = "Post #" . ($b * $batchSize + $i + 1);
        $content = "Content for post #" . ($b * $batchSize + $i + 1);
        $hotness = rand(0, 100000);

        $values[] = "(?, ?, ?, ?)";
        array_push($params, $createdAt, $title, $content, $hotness);
    }

    $sql = "INSERT INTO posts (created_at, title, content, hotness) VALUES " . implode(', ', $values);
    $stmt = $pdo->prepare($sql);
    $stmt->execute($params);

    echo "Batch " . ($b+1) . " inserted\n";
}

echo "Seed complete!\n";
