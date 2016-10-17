#!/usr/bin/env bash

package_paths=$(find ~/.atom/packages -type d -mindepth 1 -maxdepth 1)
package_names=""

for package in $package_paths
do
  cd $package
  package_name=$(basename $package)
  package_names="$package_names $package_name"
done

apm install --production $package_names
