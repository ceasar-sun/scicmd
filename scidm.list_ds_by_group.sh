#!/bin/bash

####
# Author : Ceasar Sun , Power by SciDM project
# Goal : Get package form group ID via conditions 
# Usage: $0 [-a [api-key] -r [ckan-site] <dataset-id-1>
#        $0 sp-covid-19		# default by using scidm.nchc.org.tw
#        $0 -a [api-key] -r https://aidm.nchc.org.tw priv-free-ds01

APIKEY_HEADER=""
dump_log=".$0.log"

ckan_site="https://scidm.nchc.org.tw"
api_key=""
dump_dir="$(pwd)"
dataset_list=""
include_private=false

# get parameter form command
while getopts a:r:p option
do
  case "${option}"
  in
    a) [ ! -z "${OPTARG}" ] && api_key=${OPTARG} ;;
    r) [ ! -z "${OPTARG}" ] && ckan_site=${OPTARG};;
    p)  include_private=true;;
  esac
done

shift $(($OPTIND - 1))
group_list=$@

>&2 echo "'$ckan_site' , '$api_key' ,'$group_list'"

# Check required parameters
[ -z "$group_list" ] && echo "No [group] assigned' , exit !!" && exit;
[ ! -z "$api_key" ] && APIKEY_HEADER="--header 'Authorization: $api_key'"

for gid in $group_list ; do

  >&2 echo "Group : $gid"

  total_c=0

  ## deal with value with space , such as : {"name": "clipper 投影片 2019.09.05","url": "https://aaa"}
  SAVEIFS=$IFS
  IFS=$(echo -en "\n\b")


  ## 其他 jq 參考
  # jq '.result.packages[] | select(.private==false and num_resources > 2)   | {"name","title","update_frequency", "private", "num_resources" } '
  # jq '.result.packages[] | select(.private==false )   | {"name","title","update_frequency", "private", "num_resources" } '

  $include_private && jq_query='.result.packages[] | {"name","title"} ' || jq_query='.result.packages[] | select(.private==false )   | {"name","title"} '

  for entry in ` curl -s ${ckan_site}/api/3/action/group_show?id=${gid}\&include_datasets=true ${APIKEY_HEADER} | jq -c "${jq_query}" `; do
      >&2 echo "entry = '$entry'"
      eval "$(echo $entry |jq -r ' to_entries | .[] | .key + "=\"" + .value + "\""' )"
      package_name="$name"
      package_title="$title"
      #is_private="$private"
      total_c=`expr $total_c + 1`

      echo "$name"
      #tread
    done

    IFS=$SAVEIFS
     >&2  echo "Total=$total_c"
  cd ..
done





