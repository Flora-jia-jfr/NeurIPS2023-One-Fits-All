export CUDA_VISIBLE_DEVICES=0

seq_len=336
model=GPT4TS_prompt

for percent in 100
do
for pred_len in 720 #96 192 336 720
do

python main.py \
    --root_path ./datasets/ETT-small/ \
    --data_path ETTh2.csv \
    --model_id ETTh2_$model'_'$gpt_layer'_'$seq_len'_'$pred_len'_'$percent \
    --data ett_h \
    --seq_len $seq_len \
    --label_len 168 \
    --pred_len $pred_len \
    --batch_size 256 \
    --decay_fac 0.5 \
    --learning_rate 0.001 \
    --train_epochs 10 \
    --d_model 768 \
    --n_heads 4 \
    --d_ff 768 \
    --dropout 1 \
    --enc_in 7 \
    --c_out 7 \
    --freq 0 \
    --patch_size 16 \
    --stride 8 \
    --percent $percent \
    --gpt_layer 6 \
    --itr 3 \
    --model $model \
    --cos 1 \
    --tmax 20 \
    --pretrain 1 \
    --is_gpt 1 \
    --from_trained './checkpoints/ETTh1_GPT4TS_prompt__336_'$pred_len'_100_sl336_ll168_pl'$pred_len'_dm768_nh4_el3_gl6_df768_ebtimeF_itr0' \
    --additional_setting 'layernorm_transfer' \
    > ETTh2_layernorm_transfer_$model'_'$gpt_layer'_'$seq_len'_'$pred_len'_'$percent.log
done
done
