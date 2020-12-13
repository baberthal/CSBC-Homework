#!/usr/bin/env bash

__ScriptVersion="0.1.0"

#===  FUNCTION  ================================================================
#         NAME:  usage
#  DESCRIPTION:  Display usage information.
#===============================================================================
function usage() {
  echo "Usage: $0 [options] [--] DATE TIME

  Options:
    -h|help       Display this message
    -v|version    Display script version
    -d|search-dir Set the directory to search schedules in (default '.')

  Arguments:
    DATE          4-digit representation of the date to search (i.e. 0310 for 3/10)
    TIME          Time to search (e.g. 05:00:00 AM)

  Examples:
    $0 0310 05:00:00 AM
    $0 -d /path/to/a/directory 0312 08:00:00 AM"

}    # ----------  end of function usage  ----------

#-------------------------------------------------------------------------------
#  Set up default values for options
#-------------------------------------------------------------------------------

searchdir="."


#-------------------------------------------------------------------------------
#  Handle command line arguments
#-------------------------------------------------------------------------------

while getopts ":d:hv" opt; do
  case $opt in

  h|help)
    usage
    exit 0
    ;;

  v|version)
    echo "$0 -- Version $__ScriptVersion"
    exit 0
    ;;

  d|search-dir)
    searchdir=$OPTARG
    ;;

  \?)
    echo "Invalid option: -$OPTARG" >&2
    usage
    exit 1
    ;;

#   *)
#     echo -e "\n  Option does not exist : $OPTARG\n"
#     usage
#     exit 1
#     ;;

  esac    # --- end of case ---
done
shift $(($OPTIND-1))

# Fail if we don't get 2 arguments
if [[ $# -lt 2 ]]; then
  usage
  exit 1
fi

# Set up named variables
searchdate=$1 # The date of the schedule for which we are searching
searchtime=$2 # The time for which we are searching
searchampm=${3:-AM} # Are we searching for AM or PM? Default: AM
schedule_filename="${1}_Dealer_schedule" # The name of the schedule file to find

#===  FUNCTION  ================================================================
#         NAME:  echoerr
#  DESCRIPTION:  Echos a message to stderr
#===============================================================================
function echoerr() {
  echo $@ >&2
}    # ---------- end of function echoerr ----------


#===  FUNCTION  ================================================================
#         NAME:  find_schedule
#  DESCRIPTION:  Finds the dealer schedule associated with the date given.
#===============================================================================
function find_schedule() {
  find $searchdir -type f -iname $schedule_filename
}    # ---------- end of function find_schedule ----------


#===  FUNCTION  ================================================================
#         NAME:  extract_dealer
#  DESCRIPTION:  Extracts a roulette dealer's first and last name from the grep
#                output.
#===============================================================================
function extract_dealer() {
  awk -F" " '{ print $5,$6 }'
}    # ---------- end of function extract_dealer ----------


found_schedule=$(find_schedule)

# Make sure the file we are looking for exists. If it doesn't, fail and give
# a nice error message.
if [[ ! -f $found_schedule ]]; then
  echoerr "Could not find schedule for date $searchdate. Does the file exist?"
  echoerr "Searched in: $(realpath $searchdir)"
  exit 1
fi

grep "${searchtime} ${searchampm}" $found_schedule | extract_dealer

# vim: set ts=8 sw=2 tw=80 ft=sh et :
