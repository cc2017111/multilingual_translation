#!/usr/bin/env bash
PROJECT_ROOT=/home/being/PycharmProjects/mRASP-master
TRAIN_CONFIG_YML=/home/being/PycharmProjects/mRASP-master/experiments/example/configs/preprocess/train_en2zh.yml
TEST_CONFIG_YML=/home/being/PycharmProjects/mRASP-master/experiments/example/configs/preprocess/test_en2zh.yml
bash ${PROJECT_ROOT}/preprocess/multilingual_preprocess_main.sh ${TRAIN_CONFIG_YML}
bash ${PROJECT_ROOT}/preprocess/multilingual_preprocess_main.sh ${TEST_CONFIG_YML}

num_cpus=2
subword_bpe_merge_ops=32000
# preprocess fine-tune train data
fairseq-preprocess \
        --source-lang en --target-lang zh \
        --srcdict ${PROJECT_ROOT}/experiments/example/data/toy/vocab/vocab.bpe.${subword_bpe_merge_ops} \
        --tgtdict ${PROJECT_ROOT}/experiments/example/data/toy/vocab/vocab.bpe.${subword_bpe_merge_ops} \
        --trainpref ${PROJECT_ROOT}/experiments/example/data/toy/merged_data/en2zh/train \
        --validpref ${PROJECT_ROOT}/experiments/example/data/toy/test_data/en2zh/dev \
        --destdir ${PROJECT_ROOT}/experiments/example/data/toy/data/fine-tune/en2zh \
        --workers ${num_cpus}

# preprocess fine-tune test data
fairseq-preprocess \
        --source-lang en --target-lang zh \
        --srcdict ${PROJECT_ROOT}/experiments/example/data/toy/vocab/vocab.bpe.${subword_bpe_merge_ops} \
        --tgtdict ${PROJECT_ROOT}/experiments/example/data/toy/vocab/vocab.bpe.${subword_bpe_merge_ops} \
        --testpref ${PROJECT_ROOT}/experiments/example/data/toy/test_data/en2zh/dev \
        --destdir ${PROJECT_ROOT}/experiments/example/data/toy/data/test/en2zh/wmt14_head100/bin \
        --workers ${num_cpus}

mkdir -p ${PROJECT_ROOT}/experiments/example/data/toy/data/test/en2zh/wmt14_head100/raw
mkdir -p ${PROJECT_ROOT}/experiments/example/data/toy/data/raw/test/en2zh
cp ${PROJECT_ROOT}/experiments/example/data/raw/test/en2zh/* ${PROJECT_ROOT}/experiments/example/data/toy/data/test/en2zh/wmt14_head100/raw/
cp ${PROJECT_ROOT}/experiments/example/data/raw/test/en2zh/* ${PROJECT_ROOT}/experiments/example/data/toy/data/raw/test/en2zh/

