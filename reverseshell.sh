#!/bin/bash
pids=$(lsof -i | grep bash |awk '{print $2}')
echo $pids
