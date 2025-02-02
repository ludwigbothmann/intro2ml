library(mlr3)
library(mlr3viz)

pima_task <-  tsk("pima")
pima_task$filter(rows = which(complete.cases(pima_task$data())))
learner <- lrn("classif.log_reg", predict_type = "prob")
learner$train(task = pima_task)
model_prediction <- learner$predict(task = pima_task)
autoplot(model_prediction, "roc")
model_prediction$score(list(msr("classif.auc"), msr("classif.ce")))
model_prediction$set_threshold(0.2)
model_prediction$score(list(msr("classif.auc"), msr("classif.ce")))