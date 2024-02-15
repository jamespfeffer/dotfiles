$env.PATH = ($env.PATH | split row (char esep) | prepend "/Users/james/Library/Application Support/carapace/bin")

def --env get-env [name] { $env | get $name }
def --env set-env [name, value] { load-env { $name: $value } }
def --env unset-env [name] { hide-env $name }

let carapace_completer = {|spans|
  # if the current command is an alias, get it's expansion
  let expanded_alias = (scope aliases | where name == $spans.0 | get -i 0 | get -i expansion)

  # overwrite
  let spans = (if $expanded_alias != null  {
    # put the first word of the expanded alias first in the span
    $spans | skip 1 | prepend ($expanded_alias | split row " " | take 1)
  } else {
    $spans
  })

  carapace $spans.0 nushell ...$spans
  | from json
}

let  current = (($env | default {} config).config | default {} completions)
#$current.completions = ($current.completions | default {} external)
#$current.completions.external = ($current.completions.external
#| default true enable
#| default $carapace_completer completer)

# $env.config = $current

#carapace-bridge _carapace nushell '' zsh ...nvim ~/.loc |from json|each {|x|let cols = $x|columns;  let col = $cols.0; let y = $x|get $col | str trim; {$col: $y}}

#let zsh_completer = {|spans|
# carapace-bridge _carapace nushell '' zsh ...$spans | from json
#}


let zsh_completer = {|spans|
 			carapace-bridge _carapace nushell '' zsh ...$spans 
			|from json 
			| uniq 
			|each {|x|let cols = $x|columns;  
				let col = $cols.0; 
				let y = $x|get $col | str trim; 
				{$col: $y}
				}
}

#let fish_completer = {|spans|
#    $"Input is(char newline)"|save --raw --append output.txt
#    #$spans|each {|x|$x|str replace --all "`" "'"}|save --raw --append output.txt
#    $spans|save --raw --append output.txt
#    echo $"Completion will be:(char newline)"|save --raw --append output.txt
#    
#    let completion_string = $'complete --do-complete "($spans| str join " ")"'
#    $"completion string is ($completion_string)"|save --raw --append output.txt 
#    fish --command $completion_string
#    | $"value(char tab)description(char newline)" + $in
#    | from tsv --flexible --no-infer
#}

#let fish_completer = {|spans2|
#	
#	let spans = [chezmoi, edit,  "~/Library/Application Support/nu"]
#
#
#	carapace-bridge _carapace nushell '' fish ...$spans | from json|table|save --raw --append output.txt
#}

#let fish_completer = {|spans2|
#	
#	
#	#let completion_string = $'complete --do-complete "($spans2 | str join " ")"' 
#	#$"completion string is ($completion_string)"|save --raw --append output.txt
#	let completion_string2  = "complete --do-complete 'chezmoi edit ~/Library/Application\ Support/nu'"
#
#	$"completion string2 is ($completion_string2)"|save --raw --append output.txt
#	#fish --command="complete --do-complete 'chezmoi edit ~/Library/Application\ Support/nu'"
#	fish --command=$completion_string2
#	| $"value(char tab)description(char newline)" + $in
#    	| from tsv --flexible --no-infer|table|save --raw --append output.txt
#
#
#}



let fish_completer = {|spans|

carapace-bridge _carapace nushell '' fish ...$spans | from json

}




let multiple_completers = {|spans|
    match $spans.0 {
	git => $carapace_completer
	brew => $zsh_completer
	flac => $zsh_completer
	chezmoi => $zsh_completer
	nvim => $zsh_completer
	eza => $zsh_completer
	_  => $current
    } | do $in $spans
}


$env.config = {
  completions: {
    external: {
      enable: true
      completer: $multiple_completers    }
  }
}
