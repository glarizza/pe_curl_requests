#!/bin/bash
#
# This shell script makes it easy to see what nodes are applying a class, given
# on the command line.  For instance, to see what nodes have profile::base
#
#      ./list_nodes_with_class.sh 'Profile::Base'

SET_SERVER=$(puppet config print server)
PUPPETDB="${PUPPETDB:-$SET_SERVER}"
CLASS_NAME=$1

curl -X GET \
  --tlsv1 \
  --stderr /dev/null \
  --data-urlencode "query=[\"and\",[\"=\",\"type\",\"Class\"],[\"=\",\"title\",\"${CLASS_NAME}\"]]" \
  --cert   $(puppet config print hostcert) \
  --key    $(puppet config print hostprivkey) \
  --cacert $(puppet config print localcacert) \
  https://"${PUPPETDB}":8081/pdb/query/v4/resources | python -m json.tool \
  | grep 'certname'
