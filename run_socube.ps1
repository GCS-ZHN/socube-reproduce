conda activate sographrtp
$datasets = @(
    "pbmc-ch"
    "cline-ch"
    "HEK-HMEC-MULTI"
    "pbmc-1B-dm"
    "pbmc-1C-dm"
    "pbmc-2ctrl-dm"
    "pbmc-2stim-dm"
    "pdx-MULTI"
    "HMEC-orig-MULTI"
    "HMEC-rep-MULTI"
    "hm-12k"
    "hm-6k"
    "J293t-dm"
    "mkidney-ch"
    "nuc-MULTI"
    "pbmc-1A-dm"

)

foreach ($dataset in $datasets) {
    socube `
    -i "internal_datasets/PMID33338399/real_datasets_sparse/$dataset[csc_sparse_matrix].h5ad" `
    -o "internal_result/reproduce/$dataset/" `
    --k 5 `
    --dim 10 `
    --learning-rate 0.001 `
    --gpu-ids 0 `
    --enable-validation `
    --enable-ensemble `
    -gm "heterotypic"
}