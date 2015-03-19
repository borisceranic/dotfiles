#!/usr/bin/env bash

function color {
	local fg=
	case $1 in
		reset)
			echo "[0m"
			return 0
			;;
		black)
			fg=30
			;;
		blue)
			fg=34
			;;
		green)
			fg=32
			;;
		cyan)
			fg=36
			;;
		red)
			fg=31
			;;
		purple)
			fg=35
			;;
		yellow)
			fg=33
			;;
		white)
			fg=37
			;;
		*)
			echo "Usage: <red|blue|...>"
			return 1
			;;
	esac

	local variant=0
	case $2 in
		bright)
			variant=1
			;;
		dim)
			;;
		*)
			;;
	esac

	echo "[${variant};${fg}m"
	return 0
}

function info {
	local hig=$(color cyan bright)
	local reg=$(color white)
	local rst=$(color reset)

	echo "${hig}[>>>]${rst} ${reg}${1}$rst"
}

function success {
	local hig=$(color green bright)
	local reg=$(color green)
	local rst=$(color reset)

	echo "${hig}[>>>]${rst} ${reg}${1}$rst"
}

function warn {
	local hig=$(color yellow bright)
	local reg=$(color yellow)
	local rst=$(color reset)

	echo "${hig}[>>>]${rst} ${reg}${1}$rst"
}

function error {
	local hig=$(color red bright)
	local reg=$(color red)
	local rst=$(color reset)

	echo "${hig}[>>>]${rst} ${reg}${1}$rst"
}

function set_plist_val {
	local plist=$1
	local key=$2
	local keytype=$3
	local value=$4
	local create=$5

	local pb=$PB
	if [[ "x$pb" = "x" ]]; then
		pb=/usr/libexec/PlistBuddy
	fi

	local prefs=$PREFS
	if [[ "x$prefs" = "x" ]]; then
		prefs=~/Library/Preferences
	fi

	local plistfile=$(find $prefs -type f -name $plist\.plist 2>&1)
	res=$(plist_exists $plistfile)
	if [[ $? -eq 1 ]]; then
		error "plist file does not exist: $plist"
		return 1
	fi

	data=$($pb -c "Set :$key $value" $plistfile 2>&1)
	if [[ $? -ne 0 ]]; then
		if [[ "x$create" = "x" ]]; then
			warn "Key $key does not exist in $plist, skipping"
			return 2
		else
			warn "Key $key does not exist in $plist, adding"
			data2=$($pb -c "Add :$key $keytype $value" $plistfile 2>&1)
			if [[ $? -ne 0 ]]; then
				error "Unable to add $key ($keytype) to $plist, error: $data2"
				return 4
			fi
		fi
	fi

	return 0
}

function add_plist_val {
	set_plist_val "$@" 1
	return $?
}

function get_plist_val {
	local plist=$1
	local key=$2

	local pb=$PB
	if [[ "x$pb" = "x" ]]; then
		pb=/usr/libexec/PlistBuddy
	fi

	local prefs=$PREFS
	if [[ "x$prefs" = "x" ]]; then
		prefs=~/Library/Preferences
	fi

	local plistfile=$(find $prefs -type f -name $plist\.plist)
	res=$(plist_exists $plistfile)
	if [[ $? -eq 1 ]]; then
		error "Plist file does not exist: $plist"
		return 1
	fi

	data=$($pb -c "Print :$key" $plistfile 2>&1)
	if [[ $? -ne 0 ]]; then
		error "Key $key does not exist in $plist"
		return 1
	else
		echo -n $data
		return 0
	fi
}

function plist_exists {
	local plist=$1
	if [[ -f $plist ]]; then
		return 0
	else
		return 1
	fi
}
