describe "CookieMonster", ->

  beforeEach ->
    @spy = sinon.spy($, 'cookie')

  afterEach ->
    $.cookie.restore()
    $.removeCookie 'test'

  it "should set $.cookie.defaults to it's own defaults", ->
    expect($.cookie.defaults).toEqual CookieMonster.DEFAULTS

  it "set should use the default parameters", ->
    CookieMonster.set('test', 'test')
    expect(@spy).toHaveBeenCalledWith 'test', 'test', CookieMonster.DEFAULTS

  it "set should allow extending the default parameters", ->
    CookieMonster.set('test', 'test', {expires: 1})
    expect(@spy).toHaveBeenCalledWith 'test', 'test', _.extend({}, CookieMonster.DEFAULTS, {expires: 1})

  it "objects should be stringified and parsed automatically", ->
    raw_data =
      words: 'damn'
      numbers: [1,2,3]
      booleans: [true, false]
    CookieMonster.set('test', raw_data, {expires: 1})
    result = CookieMonster.get('test')
    expect(result.words).toEqual 'damn'
    expect(result.numbers).toEqual [1,2,3]
    expect(result.booleans).toEqual [true, false]

  it "arrays should be stringified and parsed automatically", ->
    raw_data = [1, 2, 'ten']
    CookieMonster.set('test', raw_data, {expires: 1})
    expect(CookieMonster.get('test')).toEqual raw_data

  it "nulls should go in and come out null", ->
    CookieMonster.set('test', null, {expires: 1})
    expect(CookieMonster.get('test')).toEqual null

  it "setting a cookie with an undefined value should set and return null", ->
    CookieMonster.set('test', undefined, {expires: 1})
    expect(CookieMonster.get('test')).toEqual null

  it "should return booleans", ->
    CookieMonster.set('test', 'true')
    expect(CookieMonster.get('test')).toBe true
    CookieMonster.set('test', 'false')
    expect(CookieMonster.get('test')).toBe false

  it "should set default domain and path", ->
    expect(CookieMonster.DEFAULTS.domain).toEqual CookieMonster.DEFAULTS.domain
    expect(CookieMonster.DEFAULTS.path).toEqual '/'

  it "get_value_from_root_cookie should remove cookies at the current path and return the value at the root path", ->
    $.cookie('test', 'A', {path: window.location.pathname})
    $.cookie('test', 'B', {path: '/'})
    expect($.cookie('test')).toEqual 'A'
    expect(CookieMonster._get_value_from_root_cookie('test')).toEqual 'B'

  it "get_value_from_root_cookie should automatically move cookies at the current path to '/'", ->
    $.cookie('test', 'A', {path: window.location.pathname})
    expect(CookieMonster._get_value_from_root_cookie('test')).toEqual 'A'

  it "get_value_from_root_cookie should not try to fix cookie paths for cookies that aren't set", ->
    expect(CookieMonster._get_value_from_root_cookie('test')).toBe undefined
