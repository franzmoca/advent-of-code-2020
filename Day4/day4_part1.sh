#!/bin/bash
IFS= readarray -d '' passports <  <(awk -v RS= -v ORS='\0' '1' input)
required=("byr" "iyr" "eyr" "hgt" "hcl" "ecl" "pid")

validPassports=0
for p in "${passports[@]}"; do
    valid=0
    for r in "${required[@]}"; do
        if grep -q "$r" <<< "$p"; then
            valid=1
        else
            valid=0
            break;
        fi
    done
    validPassports=$((validPassports + valid))
done
echo $validPassports