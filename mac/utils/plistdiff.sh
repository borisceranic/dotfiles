#!/usr/bin/env bash

name=$1
operation=$2

tmp=$TMPDIR

if [[ -z $name ]]; then
	echo "Usage: <name> <before|after>"
	exit 1
fi

if [[ $operation = "before" ]] || [[ -z $operation ]]; then
	operation=before
elif [[ $operation = "clean" ]]; then
	operation=clean
else
	operation=after
fi

safename=$(echo $name | sed s/\ /_/g)
dirname="${tmp}plist-diff-$safename"
dirname2="${dirname}--new"

my_uuid=$(system_profiler SPHardwareDataType | awk '/UUID/{sub(/^[ \t]+/, "")}; NR == 17 {print}'|cut -d" " -f3)

case $operation in
	before)
		if [[ -d $dirname ]]; then
			echo ">>> Name $name is already in use, exiting..."
			exit 4
		fi

		echo ">>> Working directory: $dirname"
		mkdir -p $dirname
		cd $dirname

		domains=$(defaults domains | sed s/,//g)
		domains_host=$(defaults -currentHost domains | sed s/,//g)
		skipped=

		defaults read -globalDomain > "dot-GlobalPreferences" 2>/dev/null

		for dom in $domains; do
			defaults read $dom > $dom 2>/dev/null
			#defaults export $dom - > $dom
			if [[ $? -ne 0 ]]; then
				skipped="$skipped $dom"
				#echo ">>> Skipping $dom, no defaults found"
			fi
		done

		defaults -currentHost read -globalDomain > "byhost-.GlobalPreferences" 2>/dev/null

		for dom in $domains_host; do
			defaults -currentHost read $dom > "byhost-${dom}" 2>/dev/null
			#defaults -currentHost export $dom - > $dom
			if [[ $? -ne 0 ]]; then
				skipped="$skipped $dom"
				echo ">>> Skipping $dom, no defaults found for current host"
			fi
		done

		count=$(ls | wc -l)
		skip_count=$(echo $skipped | wc -w)

		echo ">>> Indexed $count domains, skipped: $skip_count. Run following command to perform diff:"
		echo "      $0 $name after"
		;;
	after)
		mkdir -p $dirname2
		echo ">>> Working directory: $dirname2"
		cd $dirname2

		domains=$(defaults domains | sed s/,//g)
		domains_host=$(defaults -currentHost domains | sed s/,//g)
		skipped=

		defaults read -globalDomain > "dot-GlobalPreferences" 2>/dev/null

		for dom in $domains; do
			defaults read $dom > $dom 2>/dev/null
			#defaults export $dom - > $dom
			if [[ $? -ne 0 ]]; then
				skipped="$skipped $dom"
				#echo ">>> Skipping $dom, no defaults found"
			fi
		done

		defaults -currentHost read -globalDomain > "byhost-.GlobalPreferences" 2>/dev/null

		for dom in $domains_host; do
			defaults -currentHost read $dom > "byhost-${dom}" 2>/dev/null
			#defaults -currentHost export $dom - > $dom
			if [[ $? -ne 0 ]]; then
				skipped="$skipped $dom"
				#echo ">>> Skipping $dom, no defaults found for current host"
			fi
		done

		count=$(ls | wc -l)
		skip_count=$(echo $skipped | wc -w)

		echo ">>> Done indexing $count domains, skipped $skip_count. Performing diff now..."

		diff -u --unified=5 -r $dirname $dirname2 | perl -p -e "s|^[-+]{3} ${tmp}/([^\\t]+)\\t.+$|\\1|"

		echo ">>> Diff done. Cleaning..."
		if [[ -d $dirname ]]; then
			rm -r $dirname
		fi
		if [[ -d $dirname2 ]]; then
			rm -r $dirname2
		fi

		echo ">>> All done!"
		;;
	clean)
		echo "Doing nothing... 'after' already cleans everything!"
		;;
esac

