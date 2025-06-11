-- Random view request params
math.randomseed(os.time())

request = function()
  local user_id = math.random(1, 100)
  local post_id = math.random(1, 50000)
  local path = string.format("/api/view.php?user_id=%d&post_id=%d", user_id, post_id)
  return wrk.format("GET", path)
end
