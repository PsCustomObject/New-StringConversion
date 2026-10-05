# New-StringConversion

`New-StringConversion` converts selected non-ASCII characters into ASCII-friendly equivalents while preserving the rest of the input. It is useful when a string must be normalized for usernames, account names, filenames, identifiers, URLs or other systems with restricted character sets.

The function includes a default conversion table for commonly used accented and special characters. You can supply your own table when the default mapping does not match your naming policy.

## Requirements

- Windows PowerShell 5.1 or PowerShell 7+
- The `New-StringConversion.ps1` function, or the module version containing it

Load the function directly from a clone:

```powershell
. ./New-StringConversion.ps1
```

If the repository provides a module manifest, import that manifest instead:

```powershell
Import-Module ./New-StringConversion.psd1
```

## Basic usage

```powershell
New-StringConversion -StringToConvert 'Die große Lösung und die lästigen Formalien'
```

```text
Die-grosse-Loesung-und-die-laestigen-Formalien
```

By default, the function:

- converts characters found in the default translation table;
- replaces whitespace with `-`;
- replaces characters that are not in the table with `?`.

The function returns the converted string, so it can be assigned, piped to another command or used directly in a larger script.

```powershell
$normalized = New-StringConversion -StringToConvert 'Müller & Söhne'
New-ADUser -Name $normalized
```

## Whitespace handling

Choose one whitespace behavior for each call.

### Keep whitespace

Use `-IgnoreSpaces` when spaces should remain unchanged:

```powershell
New-StringConversion `
    -StringToConvert 'Die große Lösung und die lästigen Formalien' `
    -IgnoreSpaces
```

```text
Die grosse Loesung und die laestigen Formalien
```

### Replace whitespace

Use `-ReplaceSpaces` to replace whitespace with a specific string:

```powershell
New-StringConversion `
    -StringToConvert 'Die große Lösung und die lästigen Formalien' `
    -ReplaceSpaces '__'
```

```text
Die__grosse__Loesung__und__die__laestigen__Formalien
```

The replacement is applied to whitespace runs according to the function's conversion rules. Use a single character when the result must remain compatible with systems that accept only one-character separators.

### Remove whitespace

Use `-RemoveSpaces` to remove whitespace completely:

```powershell
New-StringConversion `
    -StringToConvert 'Die große Lösung und die lästigen Formalien' `
    -RemoveSpaces
```

```text
DiegrosseLoesungunddielaestigenFormalien
```

`-IgnoreSpaces`, `-ReplaceSpaces` and `-RemoveSpaces` represent different policies and should not be combined in the same call.

## Unknown characters

A character that is not present in the active conversion table is replaced with `?` by default. Select a different fallback with `-UnknownCharacter`:

```powershell
New-StringConversion `
    -StringToConvert 'Name • test' `
    -UnknownCharacter '_'
```

```text
Name___test
```

Choose a fallback deliberately. A replacement character can make two different source strings produce the same result.

## Custom conversion tables

Pass a hashtable through `-UnicodeHashTable` when you need a project-specific mapping:

```powershell
$map = @{
    'ä' = 'ae'
    'ö' = 'oe'
    'ü' = 'ue'
    'ß' = 'ss'
    '€' = 'EUR'
}

New-StringConversion `
    -StringToConvert 'Märchenstraße €' `
    -UnicodeHashTable $map `
    -IgnoreSpaces
```

A custom table replaces or extends the default mapping according to the implementation version used by the repository. Inspect the function's comment-based help for the exact precedence rules when combining a custom table with the defaults.

## Pipeline usage

The function accepts strings from the pipeline, which makes it suitable for bulk normalization:

```powershell
'Jürgen', 'François', 'Łukasz' |
    New-StringConversion
```

For CSV or object data, select the property explicitly and keep the original value available for auditing:

```powershell
$users | Select-Object *, @{Name='SamAccountName'; Expression={
    New-StringConversion -StringToConvert $_.DisplayName -RemoveSpaces
}}
```

## Important behavior

This function performs deterministic character conversion. It does not validate that the resulting string is unique, available in Active Directory, safe as a filename, or acceptable to a particular external system. Validate length, uniqueness and target-system rules before creating accounts or renaming files.

Conversion is not the same as translation. Characters without a mapping use the configured fallback, and the result may lose distinctions present in the original text. Keep the original value whenever the normalized value is used as a key or identifier.

For repeatable automation, define the conversion policy explicitly:

```powershell
$conversionParameters = @{
    StringToConvert = $displayName
    RemoveSpaces    = $true
    UnknownCharacter = '_'
}

$accountName = New-StringConversion @conversionParameters
```

## Help

The function contains comment-based help:

```powershell
Get-Help New-StringConversion -Full
Get-Help New-StringConversion -Examples
Get-Command New-StringConversion -Syntax
```

## License

See [LICENSE](./LICENSE) for the repository license.
