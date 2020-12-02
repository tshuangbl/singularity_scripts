#!/bin/bash
__conda_setup="$('/code/dnapipe/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/code/dnapipe/etc/profile.d/conda.sh" ]; then
        . "/code/dnapipe/etc/profile.d/conda.sh"
    else
        export PATH="/code/dnapipe/bin:$PATH"
    fi
fi
unset __conda_setup

set +e

eval "$(/code/dnapipe/bin/conda shell.bash hook)"

MISC_ARGS="--qc --part1-only --n-cores 12 ${OTHER_ARGS}"

set -exuo pipefail

cd ${OUTDIR}


tapestri dna run --output-folder ${OUTDIR}/${MB_SAMPNAME} --output-prefix ${MB_SAMPNAME} \
  --r1 /data/input/Read1.fq.gz --r2 /data/input/Read2.fq.gz  \
  --config ${CONFDIR}/conf.yaml ${MISC_ARGS}
