#!/bin/bash
# byr (Birth Year) - four digits; at least 1920 and at most 2002.
# iyr (Issue Year) - four digits; at least 2010 and at most 2020.
# eyr (Expiration Year) - four digits; at least 2020 and at most 2030.
# hgt (Height) - a number followed by either cm or in:
# If cm, the number must be at least 150 and at most 193.
# If in, the number must be at least 59 and at most 76.
# hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
# ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
# pid (Passport ID) - a nine-digit number, including leading zeroes.
# cid (Country ID) - ignored, missing or not.

IFS= readarray -d '' passports <  <(awk -v RS= -v ORS='\0' '1' input)

validhgt () {
  if [[ $1 =~ ^[0-9]{3}cm$ ]] && (( ${1%cm} >= 150 )) && (( ${1%cm} <= 193 ))
  then
    return 0
  elif [[ $1 =~ ^[0-9]{2}in$ ]] && (( ${1%in} >= 59 )) && (( ${1%in} <= 76 ))
  then
    return 0
  else
    return 1
  fi
}

validatePassport(){
    local passport=$1
    for field in ${passport[@]}; do
        case ${field%:*} in
            byr) local byr=${field#*:} ;;
            iyr) local iyr=${field#*:} ;;
            eyr) local eyr=${field#*:} ;;
            hgt) local hgt=${field#*:} ;;
            hcl) local hcl=${field#*:} ;;
            ecl) local ecl=${field#*:} ;;
            pid) local pid=${field#*:} ;;
            #cid) local cid=${field#*:} ;;
         esac
    done

  if [[ $byr =~ ^[0-9]{4}$ ]] && (( $byr >= 1920 )) && (( $byr <= 2002 )) && \
     [[ $iyr =~ ^[0-9]{4}$ ]] && (( $iyr >= 2010 )) && (( $iyr <= 2020 )) && \
     [[ $eyr =~ ^[0-9]{4}$ ]] && (( $eyr >= 2020 )) && (( $eyr <= 2030 )) && \
     validhgt $hgt && \
     [[ $hcl =~ ^#[0-9a-f]{6} ]] && \
     [[ $ecl =~ ^amb|blu|brn|gry|grn|hzl|oth$ ]] && \
     [[ $pid =~ ^[0-9]{9}$ ]]
  then
    validPassports=$((validPassports + 1))
    fi
}

validPassports=0

for p in "${passports[@]}"; do
    validatePassport "$p"
done

echo $validPassports