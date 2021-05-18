#!/bin/env bash

export BATCH_SIZE=${BATCH_SIZE:-4}
export VOXEL_SIZE=${VOXEL_SIZE:-0.01}
export POSITIVE_PAIR_SEARCH_VOXEL_SIZE_MULTIPLIER=${POSITIVE_PAIR_SEARCH_VOXEL_SIZE_MULTIPLIER:-4}
export CONV1_KERNEL_SIZE=${CONV1_KERNEL_SIZE:-7}
export MAX_EPOCH=${MAX_EPOCH:-10000}
export CUBE_SIZE=${CUBE_SIZE:-4}
export INTERVAL=${INVERVAL:-2}
export TIME=$(date +"%Y-%m-%d_%H-%M-%S")
export OUT_DIR=/kuacc/users/nkoprucu16/outputs/London3d-v${VOXEL_SIZE}-c${CONV1_KERNEL_SIZE}-s${CUBE_SIZE}-i${INTERVAL}/${TIME}

export PYTHONUNBUFFERED="True"

echo $OUT_DIR

mkdir -m 755 -p $OUT_DIR
LOG=${OUT_DIR}/log_${TIME}.txt

echo "Host: " $(hostname) | tee -a $LOG
echo "Conda " $(which conda) | tee -a $LOG
echo $(pwd) | tee -a $LOG
echo "Version: " $VERSION | tee -a $LOG
# echo "Git diff" | tee -a $LOG
# echo "" | tee -a $LOG
# git diff | tee -a $LOG
# echo "" | tee -a $LOG
nvidia-smi | tee -a $LOG

python train.py --threed_match_dir /userfiles/nkoprucu16/London3d \
                --out_dir ${OUT_DIR} \
                --dataset London3dDataset \
                --batch_size ${BATCH_SIZE} \
                --voxel_size ${VOXEL_SIZE} \
                --positive_pair_search_voxel_size_multiplier ${POSITIVE_PAIR_SEARCH_VOXEL_SIZE_MULTIPLIER} \
                --conv1_kernel_size ${CONV1_KERNEL_SIZE} \
                --london3d-cube-size ${CUBE_SIZE} \
                --london3d-interval ${INTERVAL} \
                --london3d-min-percent 0.3 \
                --london3d-max-percent 0.9 \
                --train_num_thread 4 \
                --max_epoch ${MAX_EPOCH} \
