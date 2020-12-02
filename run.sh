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

set -exuo pipefail

cd ${OUTDIR}

tapestri dna run --input ${CONFDIR}/${MB_DNA_CONF} \
  --dir-yaml ${CONFDIR}/${MB_DNA_YAML} --dir-info ${CONFDIR}/${MB_DNA_info} \
  --output-folder ${OUTDIR}/${MB_SAMPNAME} --qc --no-overwrite

