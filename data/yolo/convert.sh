#!/usr/bin/env sh

CAFFE_ROOT=../..
ROOT_DIR=./
LABEL_FILE=$CAFFE_ROOT/data/yolo/label_map.txt
mkdir lmdb
rm -r lmdb/trainval_lmdb
rm -r lmdb/test2007_lmdb
rm -r lmdb/test2012_lmdb

# 2007 + 2012 trainval
LIST_FILE=$CAFFE_ROOT/data/yolo/trainval.txt
LMDB_DIR=./lmdb/trainval_lmdb
SHUFFLE=true

RESIZE_W=416
RESIZE_H=416

$CAFFE_ROOT/build/tools/convert_box_data --resize_width=$RESIZE_W --resize_height=$RESIZE_H \
  --label_file=$LABEL_FILE $ROOT_DIR $LIST_FILE $LMDB_DIR --encoded=true --encode_type=jpg --shuffle=$SHUFFLE
 
# 2012 test
LIST_FILE=$CAFFE_ROOT/data/yolo/test_2012.txt
LMDB_DIR=./lmdb/test2012_lmdb
SHUFFLE=false

$CAFFE_ROOT/build/tools/convert_box_data --resize_width=$RESIZE_W --resize_height=$RESIZE_H \
  --label_file=$LABEL_FILE $ROOT_DIR $LIST_FILE $LMDB_DIR --encoded=true --encode_type=jpg --shuffle=$SHUFFLE

# 2007 test
LIST_FILE=$CAFFE_ROOT/data/yolo/test_2007.txt
LMDB_DIR=./lmdb/test2007_lmdb
SHUFFLE=false

$CAFFE_ROOT/build/tools/convert_box_data --resize_width=$RESIZE_W --resize_height=$RESIZE_H \
  --label_file=$LABEL_FILE $ROOT_DIR $LIST_FILE $LMDB_DIR --encoded=true --encode_type=jpg --shuffle=$SHUFFLE

