#!/usr/bin/env bash
PROJECT_ROOT=/home/being/PycharmProjects/mRASP-master
num_cpus=2
subword_bpe_merge_ops=32000

# preprocess pre-train train data
fairseq-preprocess \
        --source-lang src --target-lang trg \
        --srcdict ${PROJECT_ROOT}/experiments/example/data/toy/vocab/vocab.bpe.${subword_bpe_merge_ops} \
        --tgtdict ${PROJECT_ROOT}/experiments/example/data/toy/vocab/vocab.bpe.${subword_bpe_merge_ops} \
        --trainpref ${PROJECT_ROOT}/experiments/example/data/toy/data/pre-train/pre_test/train/train \
        --validpref ${PROJECT_ROOT}/experiments/example/data/toy/data/pre-train/pre_test/valid/dev \
        --destdir /media/being/_dev_dva/test1 \
        --workers ${num_cpus}
