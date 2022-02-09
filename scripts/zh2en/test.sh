#!/usr/bin/env bash
test_path=/home/being/PycharmProjects/mRASP-master/experiments/example/data/toy/data/test/zh2en/wmt14_head100/bin
ckpts=/home/being/PycharmProjects/mRASP-master/experiments/example/data/toy/models/fine-tune/transformer_big/zh2en/checkpoint_best.pt
final_res_file=/home/being/PycharmProjects/mRASP-master/experiments/example/data/toy/models/fine-tune/transformer_big/zh2en/results/checkpoint1/zh2en__wmt14_head100.txt
command="
CUDA_VISIBLE_DEVICES=0,1,2 lightseq-generate ${test_path} \
    -s zh \
    -t en \
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