#!/bin/sh

awk -F'\t' '{print $1, $2, $3, $4, $5, $6}' OFS='\t' ./US.txt > us_columns_filtered.txt

