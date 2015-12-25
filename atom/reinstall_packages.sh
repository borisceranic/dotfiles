#!/usr/bin/env bash

package_list=$(find ~/.atom/packages -type d -mindepth 1 -maxdepth 1)

for package in $package_list
do
  cd $package
  package_name=$(basename $package)
  echo "> Package: $package_name"
  apm install
done
