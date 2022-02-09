#!/usr/bin/env bash
PROJECT_ROOT=/home/being/PycharmProjects/mRASP-master
FILE_ROOT=${PROJECT_ROOT}/experiments/example/data/toy/models/fine-tune/transformer_big/zh2en/results/checkpoint1
SCRIPTS=~/PycharmProjects/en_ja_translation/mosesdecoder/scripts
DETOKENIZER=${SCRIPTS}/tokenizer/detokenizer.perl
MULTI_BLEU=${SCRIPTS}/generic/multi-bleu.perl
MTEVAL_V14=${SCRIPTS}/generic/mteval-v14.pl

FILE=${FILE_ROOT}/zh2en__wmt14_head100.txt
echo $FILE
mkdir -p ${FILE_ROOT}/result
# 把译文和正确答案单独抽取出来，其中predict是译文，answer是正确答案
grep ^H ${FILE} | cut -f3- > ${FILE_ROOT}/result/predict.bpe.en
grep ^T ${FILE} | cut -f2- > ${FILE_ROOT}/result/answer.bpe.en
grep ^S ${FILE} | cut -f2- > ${FILE_ROOT}/result/answer.bpe.zh

# 有两种方法可以去除bpe符号，第一种是在解码时添加--remove-bpe参数，第二种是使用sed指令
sed -r -e 's/(@@ )| (@@ ?$)//g' -e 's/LANG_TOK_EN//g' -e 's#\，#\,#g' -e 's#\？#\?#g' < ${FILE_ROOT}/result/predict.bpe.en > ${FILE_ROOT}/result/predict.tok.en
sed -r -e 's/(@@ )| (@@ ?$)//g' -e 's/LANG_TOK_EN//g' -e 's#\，#\,#g' -e 's#\？#\?#g' < ${FILE_ROOT}/result/answer.bpe.en > ${FILE_ROOT}/result/answer.tok.en
sed -r -e 's/(@@ )| (@@ ?$)//g' -e 's/LANG_TOK_ZH//g' -e 's#\，#\,#g' -e 's#\？#\?#g' < ${FILE_ROOT}/result/answer.bpe.zh > ${FILE_ROOT}/result/answer.tok.zh

# detokenizing
${DETOKENIZER} -l en < ${FILE_ROOT}/result/predict.tok.en > ${FILE_ROOT}/result/predict.en
${DETOKENIZER} -l en < ${FILE_ROOT}/result/answer.tok.en > ${FILE_ROOT}/result/answer.en
${DETOKENIZER} -l zh < ${FILE_ROOT}/result/answer.tok.zh > ${FILE_ROOT}/result/answer.zh

# scoring
${MULTI_BLEU} -lc ${FILE_ROOT}/result/predict.en < ${FILE_ROOT}/result/answer.en

sacrebleu ${FILE_ROOT}/result/predict.en -i ${FILE_ROOT}/result/answer.en -m bleu -b -w 1
