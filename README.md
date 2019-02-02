# New-StringConversion
**New-StringConversion** is a flexible yet powerful PowerShell function aimed to help Systems Administrators *sanitise* any string containing non unicode characters replacing them with unicode ones. 



**New-StringConversion** can be used, for example, to normalise usernames for Active Directory users that are using special characters. 



Function implements a default *translation table* containing all commonly used non unicode characters but also allows a user to specify a custom table at runtime via the **UnicodeHashTable** parameter.



By default all white spaces are replaced by a *dash* (-) symbol but user can specify any custom character to use via the **ReplaceSpace** parameter.



White spaces in the string can also be ignored, **IgnoreSpaces** parameter, or removed completely, **RemoveSpaces** parameter.



If a special character not defined in the conversion table is encountered in the string it will be replaced, by default, with a *question mark* (?) but any other character can be used via the **UnknownCharacter** parameter.



## Sample Usage

While online help is available directly in the function some sample usage scenarios are described below. 



### Normalize String Only

Default usage, normalize a string containing special characters



```powershell
New-StringConversion -StringToConvert 'Die große Lösung und die lästigen Formalien'
```



Will print

> Die-grosse-Losung-und-die-lastigen-Formalien

### Normalize String and Ignore White Spaces

Normalize string without removing any white space

```powershell
New-StringConversion -StringToConvert 'Die große Lösung und die lästigen Formalien' -IgnoreSpaces
```

Will print

> Die grosse Losung und die lastenden Formalien

### Normalize String and Replace White Spaces

Normalize string replacing white spaces with the character specified by the user

```powershell
New-StringConversion -StringToConvert 'Die große Lösung und die lästigen Formalien' -ReplaceSpaces '..'
```

Will print

>Die..grosse..Losung..und..die..lastenden..Formalien