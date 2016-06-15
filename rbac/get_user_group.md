# Run from console server
CERT=$(/usr/local/bin/puppet config print hostcert)
CACERT=$(/usr/local/bin/puppet config print localcacert)
PRVKEY=$(/usr/local/bin/puppet config print hostprivkey)
OPTIONS="--cert ${CERT} --cacert ${CACERT} --key ${PRVKEY}"
HOST=$(puppet agent --configprint certname)

# GET user groups
curl -s -X GET $OPTIONS https://$HOST:4433/rbac-api/v1/groups | python -m json.tool
