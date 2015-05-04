CookieMonster ||= {}

CookieMonster.DEFAULTS =
  domain: ''
  path: '/'
  expires: 180

$.cookie.defaults = CookieMonster.DEFAULTS

CookieMonster.get = (key) ->
  value = $.cookie(key)
  try
    JSON.parse(value)
  catch
    value

CookieMonster.set = (key, val, params={}) ->
  val = null unless val?
  val = JSON.stringify(val) if val? and typeof(val) == 'object'
  params = _.extend({}, CookieMonster.DEFAULTS, params)
  $.cookie key, val, params

CookieMonster.delete = (key) ->
  $.removeCookie key

CookieMonster.all = ->
  $.cookie()

# Utility function to clean up any cookies that were previously set with
# specific paths since they override cookies at the root path.
# 1. Get the current cookie value.
# 2. Delete any cookie that may be stored at this path.
# 3. If there's still a cookie stored with this name (should be the at '/') return it
# 4. Otherwise return the original cookie and set it's path to '/'
CookieMonster._get_value_from_root_cookie = (key) ->
  old_val = $.cookie(key)
  return old_val if !old_val
  $.removeCookie(key, {path: window.location.pathname})
  new_val = $.cookie(key)
  value = new_val || old_val
  $.cookie(key, value, CookieMonster.DEFAULTS)
  value