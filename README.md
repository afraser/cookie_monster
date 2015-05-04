# Cookie Monster
Get and set cookies without worrying about types.
Uses $.cookie.

### Numbers
    CookieMonster.set('my_cookie', 100)
    CookieMonster.get('my_cookie')
    > 100

### Booleans
    CookieMonster.set('my_cookie', true)
    CookieMonster.get('my_cookie')
    > true

### Objects
    CookieMonster.set('my_cookie', {item: 'value'})
    CookieMonster.get('my_cookie')
    > {item: 'value'}
    
### Arrays
    CookieMonster.set('my_cookie', [1,2,3])
    CookieMonster.get('my_cookie')
    > [1,2,3]
    
### Null
    CookieMonster.set('my_cookie', null)
    CookieMonster.get('my_cookie')
    > null
    
### Undefined (returns null)
    CookieMonster.set('my_cookie', undefined)
    CookieMonster.get('my_cookie')
    > null
    
### Strings
    CookieMonster.set('my_cookie', 'duh')
    CookieMonster.get('my_cookie')
    > 'duh'
    
### Getting unset cookies
    CookieMonster.get('asdf')
    > undefined
    
### Deleting cookies
    CookieMonster.delete('my_cookie')
    CookieMonster.get('my_cookie')
    > undefined
