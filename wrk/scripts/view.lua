-- Random view request params
math.randomseed(os.time())

request = function()
  local user_id = math.random(1, 100)
  local post_id = math.random(1, 50000)
  local body = string.format("user_id=%d&post_id=%d", user_id, post_id)
  local headers = {}
  headers["Content-Type"] = "application/x-www-form-urlencoded"
  return wrk.format("POST", "/api/view.php", headers, body)
end