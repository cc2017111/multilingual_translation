"""Jieba command line interface."""
import sys
import MeCab

mecab = MeCab.Tagger ("-Owakati")
for line in sys.stdin.readlines():
    # sys.stdout.write(str([ord(i) for i in line]))
    # line = line.rstrip()

    result = mecab.parse(line).rstrip()
    # sys.stdout.write(str([ord(i) for i in result]))
    sys.stdout.write(result+"\n")
