SVG=$1
LEVEL_DATA=$2

if [ "${LEVEL_DATA}" == "" ]
then
	LEVEL_DATA=`basename ${SVG} .svg`.data
fi

cat ${SVG} | ocaml mk_level_data.ml > ${LEVEL_DATA}

