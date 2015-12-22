#!/usr/bin/env bash
green="\033[32m"
red="\033[31m"
reset="\033[0m"

script_dir=$(dirname $0)

# programatically define stage_dir
if [ "$#" -ge 1 ]; then stage_dir=$1; else stage_dir=stage; fi

# defines the tests
run_gets() {
  run_get "elec_fuel" "http://www.mocky.io/v2/56787e5a0f0000e82f500870" "http://www.mocky.io/v2/56787e7c0f00000730500871"
  run_get "gas_fuel"  "http://www.mocky.io/v2/56787e8f0f00000d30500872" "http://www.mocky.io/v2/56787e5a0f0000e82f500870"
}

# individual test run recorder
run_get() {
  local desc=$1
  local exp_url=$2
  local act_url=$3
  curl -s -w "\n%{http_code}" $exp_url | tee $stage_dir/exp/raw/$desc | $script_dir/normalize_json.py > $stage_dir/exp/norm/$desc
  curl -s -w "\n%{http_code}" $act_url | tee $stage_dir/act/raw/$desc | $script_dir/normalize_json.py > $stage_dir/act/norm/$desc
}

# recreate clean stage dir
rm -rf $stage_dir
mkdir -p $stage_dir/exp/raw
mkdir -p $stage_dir/exp/norm
mkdir -p $stage_dir/act/raw
mkdir -p $stage_dir/act/norm
set -e
# run tests, recording raw and normalized
run_gets
# print diff on the normalized dir
printf "${red}"
diff $stage_dir/exp/norm $stage_dir/act/norm
if [ "$?" = "0" ]; then printf "${green}Ok\n"; fi
printf "${reset}"
