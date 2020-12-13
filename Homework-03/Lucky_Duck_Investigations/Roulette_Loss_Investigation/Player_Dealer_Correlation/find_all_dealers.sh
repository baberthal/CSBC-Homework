#!/usr/bin/env bash

#
# Finds all dealers who were working when losses occured.
#

output_file="Dealers_working_during_losses"


#===  FUNCTION  ================================================================
#         NAME:  find_dealer_for_day
#  DESCRIPTION:  Finds a roulette dealer, given a date and time they worked.
#===============================================================================
function find_dealer_for_day() {
  dealer_result=$(grep "${2} ${3}" "${1}_Dealer_schedule" |
    awk -F" " '{ print $1,$2,$5,$6 }')
  echo "${1} ${dealer_result}"
}    # ---------- end of function find_dealer_for_day ----------


# Times losses occured on 03/10
find_dealer_for_day 0310 05:00:00 AM >> $output_file
find_dealer_for_day 0310 08:00:00 AM >> $output_file
find_dealer_for_day 0310 02:00:00 PM >> $output_file
find_dealer_for_day 0310 08:00:00 PM >> $output_file
find_dealer_for_day 0310 11:00:00 PM >> $output_file

# Times losses occured on 03/12
find_dealer_for_day 0312 05:00:00 AM >> $output_file
find_dealer_for_day 0312 08:00:00 AM >> $output_file
find_dealer_for_day 0312 02:00:00 PM >> $output_file
find_dealer_for_day 0312 08:00:00 PM >> $output_file
find_dealer_for_day 0312 11:00:00 PM >> $output_file

# Times losses occured on 03/15
find_dealer_for_day 0315 05:00:00 AM >> $output_file
find_dealer_for_day 0315 08:00:00 AM >> $output_file
find_dealer_for_day 0315 02:00:00 PM >> $output_file
