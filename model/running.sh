## 변경사항: 법률 데이터 미포함, 데이터셋 비율 50%, 정리를 위한 wandb project 변경

## Pretraining using Infilling
## 학습 파라미터 : epoch, weight decay, learning rate, warmup steps

########## pretraining #################
# --output_dir checkpoint/longformerbart_44_512_no_teacehr_no_doctype_no_noam\
# python pretrain.py \
# --do_train \
# --is_pretrain \
# --num_train_epochs 5 \
# --output_dir chekcpoint/test \
# --overwrite_output_dir \
# --logging_steps 2000 \
# --save_strategy epoch \
# --evaluation_strategy no \
# --max_source_length 2048 \
# --max_target_length 2048 \
# # --project_name longformerbart \
# --per_device_train_batch_size 4 \
# --gradient_accumulation_steps 4 \
# # --wandb_unique_tag longformerBart_pretraining_V1_512_no_noam \
# --hidden_size 512 \
# --encoder_layer_size 4 \
# --decoder_layer_size 4 \
# --attention_head_size 4 \
# --attention_window_size 64 \
# --dropout 0.1 \
# --learning_rate 1e-4 \
# --warmup_steps 10000 \
# --weight_decay 1e-4 \
# --adam_beta1  0.9 \
# --adam_beta2  0.98 \
# --adam_epsilon 1e-06 \
# --use_doc_type_ids True



# Distilbart
python train.py \
--do_train \
--output_dir model/distilbart \
--num_train_epochs 5 \
--learning_rate 3e-05 \
--max_source_length 510 \
--max_target_length 128 \
--metric_for_best_model rougeLsum \
--relative_eval_steps 5 \
--es_patience 3 \
--load_best_model_at_end True \
--project_name optimization \
--save_total_limit 2 \
--is_part true \
--use_model distilbart \
--overwrite_output_dir \
--wandb_unique_tag distilbart




# 1. h_dim 128/256 => 논문 => 128 / 256
# 2. layer depth 3/1 6/3 => 논문 => 3/3
# +a window_size, head = 32 / 64 => (4)
# 3. dropout 70/50/30 => 선택 => 50/70
# 4. weight decay 1e-2 / 1e-5 => fix
# 5. warmup => 
# 5. teacher forcing -> lr 형태로 100 -> 0 => (구현 필요) -> 해야죠 => fine_tuning => 내일
# 6. LR scheduler => noam => (구현) -> 끝
# 7. LR : +-1e-4

## Train
## 시도해볼 부분: epoch 수정해보기
## 변경 필요한 arguments: output_dir

# python train.py \
# --do_train \
# --output_dir checkpoint/rdroptest_nolabelsmoothed \
# --num_train_epochs 100 \
# --learning_rate 3e-05 \
# --max_source_length 1024 \
# --max_target_length 128 \
# --metric_for_best_model rougeLsum \
# --relative_eval_steps 10 \
# --es_patience 3 \
# --load_best_model_at_end True \
# --project_name baseV1.0_Kobart \
# --wandb_unique_tag rdroptest_nolabelsmoothed \
# --save_total_limit 3 \
# --num_samples 10 \
# --overwrite_output_dir \
# --use_rdrop True
# --label_smoothing_factor 0.1 # BART rdrop 사용시 필수

# python train.py \
# --do_train \
# --output_dir model/baseV1.0_Kobart \
# --dataset_name paper,news,magazine \
# --num_train_epochs 3 \
# --learning_rate 3e-05 \
# --max_source_length 1024 \
# --max_target_length 128 \
# --metric_for_best_model rougeLsum \
# --relative_eval_steps 10 \
# --es_patience 3 \
# --load_best_model_at_end True \
# --relative_sample_ratio 0.5 \
# --project_name baseV1.0_Kobart \
# --wandb_unique_tag kobartV1_ep2_lr3e05_len1024_R50

## Eval
# ## 시도해볼 부분: num_beams
# ## 변경 필요한 model_name_or_path: output_dir
# python train.py \
# --do_eval \
# --model_name_or_path model/baseV1.0_Kobart \
# --dataset_name paper,news,magazine \
# --output_dir evaluation/kobart_eval \
# --num_beams 3 \
# --relative_sample_ratio 1 \
# --project_name baseV1.0_Kobart \
# --wandb_unique_tag Eval_kobartV1_ep2_lr3e05_len1024_R50

# ## Predict
# python predict.py \
# --model_name_or_path model/baseV1.0_Kobart_ep2_1210 \
# --num_beams 3


######### bigbirdbart ##########

# python train.py \
# --model_name_or_path monologg/kobigbird-bert-base \
# --use_model bigbart \
# --do_train \
# --output_dir checkpoint/kobigbirdbart_ep3_bs2_noam \
# --overwrite_output_dir \
# --num_train_epochs 3 \
# --learning_rate 0.15 \
# --max_source_length 4096 \
# --max_target_length 128 \
# --metric_for_best_model rougeLsum \
# --relative_eval_steps 10 \
# --es_patience 3 \
# --load_best_model_at_end True \
# --project_name kobigbirdbart \
# --wandb_unique_tag kobigbirdbart_ep3_bs2_noam \
# --per_device_train_batch_size 2 \
# --per_device_eval_batch_size 8 \
# --is_part True \
# --is_noam True \
# --warmup_steps 2000

# python predict.py \
# --model_name_or_path checkpoint/baseV1.0_Kobart \
# --num_beams 3
# --use_model bigbart
