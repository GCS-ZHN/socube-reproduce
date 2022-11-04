#!/bin/bash
$SEED=2010
$datasets = @(
    "hm-12k"
    "hm-6k"
    "pbmc-ch"
    "cline-ch"
    "HEK-HMEC-MULTI"
    "J293t-dm"
    "mkidney-ch"
    "nuc-MULTI"
    "pbmc-1A-dm"
    "pbmc-1B-dm"
    "pbmc-1C-dm"
    "pbmc-2ctrl-dm"
    "pbmc-2stim-dm"
    "pdx-MULTI"
    "HMEC-orig-MULTI"
    "HMEC-rep-MULTI"
)

foreach ($dataset in $datasets) {
    conda activate solo
    if ((Test-Path "outputs/solo_result/${dataset}_${SEED}")) {
        Remove-Item -Recurse -Force "outputs/solo_result/${dataset}_${SEED}"
    }
    solo -p -a -g `
            -r 2 `
            --set-reproducible-seed $SEED `
            -o "internal_outputs/solo_result/${dataset}_${SEED}" `
            -j solo_params.json `
            -d "internal_datasets/${dataset}/${dataset}[csc_sparse_matrix].h5ad"
    conda deactivate
}