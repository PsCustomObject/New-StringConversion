function New-StringConversion
{
<#
	.SYNOPSIS
		A brief description of the New-StringConversion function.
	
	.DESCRIPTION
		A detailed description of the New-StringConversion function.
	
	.PARAMETER StringToConvert
		A description of the StringToConvert parameter.
	
	.PARAMETER UnicodeHashTable
		Specify a custom hash of characters to replace
	
	.PARAMETER IgnoreSpaces
		A description of the IgnoreSpaces parameter.
	
	.PARAMETER ReplaceSpace
		A description of the ReplaceSpace parameter.
	
	.PARAMETER RemoveSpaces
		A description of the RemoveSpaces parameter.
	
	.PARAMETER UnknownCharacter
		A description of the UnknownCharacter parameter.
	
	.EXAMPLE
		PS C:\> New-StringConversion
	
	.OUTPUTS
		string, string, string
	
	.NOTES
		Additional information about the function.
#>
	
	[OutputType([string], ParameterSetName = 'IgnoreSpaces')]
	[OutputType([string], ParameterSetName = 'ReplaceSpaces')]
	[OutputType([string], ParameterSetName = 'RemoveSpaces')]
	[OutputType([string])]
	param
	(
		[Parameter(ParameterSetName = 'IgnoreSpaces')]
		[Parameter(ParameterSetName = 'RemoveSpaces')]
		[Parameter(ParameterSetName = 'ReplaceSpaces',
				   Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[string]
		$StringToConvert,
		[Parameter(ParameterSetName = 'IgnoreSpaces')]
		[Parameter(ParameterSetName = 'RemoveSpaces')]
		[Parameter(ParameterSetName = 'ReplaceSpaces')]
		[ValidateNotNullOrEmpty()]
		[object]
		$UnicodeHashTable = $unicodeHashTable,
		[Parameter(ParameterSetName = 'IgnoreSpaces',
				   Mandatory = $true)]
		[switch]
		$IgnoreSpaces,
		[Parameter(ParameterSetName = 'ReplaceSpaces',
				   Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[string]
		$ReplaceSpace,
		[Parameter(ParameterSetName = 'RemoveSpaces',
				   Mandatory = $true)]
		[switch]
		$RemoveSpaces,
		[Parameter(ParameterSetName = 'IgnoreSpaces')]
		[Parameter(ParameterSetName = 'RemoveSpaces')]
		[Parameter(ParameterSetName = 'ReplaceSpaces')]
		[string]
		$UnknownCharacter = '?'
	)
	
	# Set default unicode Hash
	if ($UnicodeHashTable -eq $null)
	{
		# HashTable contaning special characters to replace
		[hashtable]$unicodeHashTable = @{
			
			# a
			'æ' = 'a'
			'à' = 'a'
			'â' = 'a'
			'ã' = 'a'
			'å' = 'a'
			'ā' = 'a'
			'ă' = 'a'
			'ą' = 'a'
			'ä' = 'a'
			'á' = 'a'
			
			# b
			'ƀ' = 'b'
			'ƃ' = 'b'
			
			# Tone six
			'ƅ' = 'b'
			
			# c
			'ç' = 'c'
			'ć' = 'c'
			'ĉ' = 'c'
			'ċ' = 'c'
			'č' = 'c'
			'ƈ' = 'c'
			
			# d
			'ď' = 'd'
			'đ' = 'd'
			'ƌ' = 'd'
			
			# e
			'è' = 'e'
			'é' = 'e'
			'ê' = 'e'
			'ë' = 'e'
			'ē' = 'e'
			'ĕ' = 'e'
			'ė' = 'e'
			'ę' = 'e'
			'ě' = 'e'
			
			# g
			'ĝ' = 'e'
			'ğ' = 'e'
			'ġ' = 'e'
			'ģ' = 'e'
			
			# h
			'ĥ' = 'h'
			'ħ' = 'h'
			
			# i
			'ì' = 'i'
			'í' = 'i'
			'î' = 'i'
			'ï' = 'i'
			'ĩ' = 'i'
			'ī' = 'i'
			'ĭ' = 'i'
			'į' = 'i'
			'ı' = 'i'
			
			# j
			'ĳ' = 'j'
			'ĵ' = 'j'
			
			# k
			'ķ' = 'k'
			'ĸ' = 'k'
			
			# l
			'ĺ' = 'l'
			'ļ' = 'l'
			'ľ' = 'l'
			'ŀ' = 'l'
			'ł' = 'l'
			
			# n
			'ñ' = 'n'
			'ń' = 'n'
			'ņ' = 'n'
			'ň' = 'n'
			'ŉ' = 'n'
			'ŋ' = 'n'
			
			# o
			'ð' = 'o'
			'ó' = 'o'
			'õ' = 'o'
			'ô' = 'o'
			'ö' = 'o'
			'ø' = 'o'
			'ō' = 'o'
			'ŏ' = 'o'
			'ő' = 'o'
			'œ' = 'o'
			
			# r
			'ŕ' = 'r'
			'ŗ' = 'r'
			'ř' = 'r'
			
			# s
			'ś' = 's'
			'ŝ' = 's'
			'ş' = 's'
			'š' = 's'
			'ß' = 'ss'
			'ſ' = 's'
			
			# t
			'ţ' = 't'
			'ť' = 't'
			'ŧ' = 't'
			
			# u
			'ù' = 'u'
			'ú' = 'u'
			'û' = 'u'
			'ü' = 'u'
			'ũ' = 'u'
			'ū' = 'u'
			'ŭ' = 'u'
			'ů' = 'u'
			'ű' = 'u'
			'ų' = 'u'
			
			# w
			'ŵ' = 'w'
			
			# y
			'ý' = 'y'
			'ÿ' = 'y'
			'ŷ' = 'y'
			
			# z
			'ź' = 'z'
			'ż' = 'z'
			'ž' = 'z'
		}
	}
	
	# Check if we have a custom regex
	if ([string]::IsNullOrEmpty($RegExCharacters) -eq $true)
	{
		# Set a regex for additional special characters
		[string]$unicodeRegExString = "^([0-9a-zA-Z!#$@.'^_`~-])*$"
		
		$RegExCharacters = $unicodeRegExString
	}
	
	# Handle white spaces
	if ($IgnoreSpaces)
	{
		$UnicodeHashTable.Add(' ', ' ')
	}
	elseif ($ReplaceSpace)
	{
		$UnicodeHashTable.Add(' ', $ReplaceSpace)
	}
	elseif ($RemoveSpaces)
	{
		$StringToConvert = $StringToConvert.Replace(' ', '')
	}
	else
	{
		$UnicodeHashTable.Add(' ', '-')
	}
	
	# Check if user wants custom special char
	if ([string]::IsNullOrEmpty($UnknownCharacter) -eq $false)
	{
		$UnknownCharacter = $UnknownCharacter
	}
	
	# Check if we have special characters
	if (!($StringToConvert -match $RegExCharacters))
	{
		$CharArray = $StringToConvert.ToCharArray()
		
		# Declare new character array
		[array]$NewCharArray = @()
		
		# Parse the string
		foreach ($Char in $CharArray)
		{
			[bool]$ToUpper = $False
			
			# Set Char ref with current value
			$CharCurrent = $Char.ToString()
			$CharLower = $Char.ToString().ToLower()
			
			# Run a compare to check character case 
			[int]$CharComp = $CharCurrent.CompareTo($CharLower)
			
			# Upper character for rendering
			if ($CharComp -eq 1)
			{
				$ToUpper = $True
			}
			
			# Check we have a match
			if (!($Char.ToString() -match $RegExCharacters))
			{
				if ($UnicodeHashTable.ContainsKey($Char.ToString().ToLower()) -eq $true)
				{
					$Char = $UnicodeHashTable["$($Char)"]
					if ($ToUpper)
					{
						$Char = $Char.ToString().ToUpper()
					}
					
					$NewCharArray += $Char
				}
				else
				{
					$NewCharArray += $UnknownCharacter
				}
			}
			else
			{
				if ($ToUpper)
				{
					$Char = $Char.ToString().ToUpper()
				}
				
				$NewCharArray += $Char
			}
		}
		$unicodeString = -join [char[]]$NewCharArray
	}
	else
	{
		$unicodeString = $StringToConvert
	}
	return $unicodeString
}