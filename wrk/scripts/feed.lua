-- Random feed request params
math.randomseed(os.time())

request = function()
  local user_id = math.random(1, 10000)
  local last_hotness = math.random(1000, 100000)
  local last_id = math.random(1, 50000)
  local path = string.format("/api/feed.php?user_id=%d&last_hotness=%d&last_id=%d", user_id, last_hotness, last_id)
  return wrk.format("GET", path)
end
