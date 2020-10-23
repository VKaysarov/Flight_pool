<?php

namespace app\modules\api\controllers;


use Yii;
use yii\rest\ActiveController;

class AirportController extends ActiveController
{
    public $modelClass = 'app\models\Airport';
    // public $serializer = [
    //     'class' => 'yii\rest\Serializer',
    //     'collectionEnvelope' => 'items',
    // ];

    public function actions()
    {
        $actions = parent::actions();
        unset($actions['index']);
        return $actions;
    }

    public function actionIndex()
    {
    	$params = Yii::$app->request->queryParams;
    	$query = $params['query'];

        if (!isset($query)) {
             throw new \yii\web\ForbiddenHttpException('Пропущен обязательный параметр "query" ');
        }

        $model = 'app\models\Airport'::find()
		    ->where(['iata' => $query])
		    ->one();

        return $model;
    }
}

?>