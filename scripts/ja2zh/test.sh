#!/usr/bin/env bash
test_path=/home/being/PycharmProjects/mRASP-master/experiments/example/data/toy/data/test/ja2zh/wmt14_head100/bin
ckpts=/home/being/PycharmProjects/mRASP-master/experiments/example/data/toy/models/fine-tune/transformer_big/ja2zh/checkpoint_best.pt
final_res_file=/home/being/PycharmProjects/mRASP-master/experiments/example/data/toy/models/fine-tune/transformer_big/ja2zh/results/checkpoint1/ja2zh__wmt14_head100.txt
command="
CUDA_VISIBLE_DEVICES=0,1,2 lightseq-generate ${test_path} \
    -s ja \
    -t zh \
    --skip-invalid-size-inputs-valid-test \
    --path ${ckpts} \
    --batch-size 16 \
    --beam 8 \
    --nbest 1 \
    --lenpen 0.5 \
    --max-len-a 0 \
    --max-len-b 256 \
    --max-source-positions 256 \
    --max-target-positions 256 > ${final_res_file}
"
echo $command >&2
eval $command