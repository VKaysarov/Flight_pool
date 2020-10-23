<?php

namespace app\modules\api\controllers;

use Yii;
use yii\rest\ActiveController;

class FlightController extends ActiveController
{
    public $modelClass = 'app\models\Flight';

    public function actions()
    {
        $actions = parent::actions();
        unset($actions['index']);
        return $actions;
    }

    public function actionIndex()
    {




        $request = Yii::$app->request;
        $from = $request->get('from');
        $to = $request->get('to');
        $date1 = $request->get('date1');
        $date2 = $request->get('date2');
        $passengers = $request->get('passengers');

        $errors = [];

        if (empty($from)) {
            array_push($errors, 'Поле from не должно быть пустым');
        }

        if (empty($to)) {
            array_push($errors, 'Поле to не должно быть пустым');
        }

        if (empty($date1)) {
            array_push($errors, 'Поле date1 не должно быть пустым');
        }

        if (empty($passengers)) {
            array_push($errors, 'Поле passengers не должно быть пустым');
        }

        if ($errors == []) {

            $flight_to = (new \yii\db\Query())->select(['*'])
            ->from('flight')
            ->leftJoin('airport AS airport_from', 'flight.airport_from_id = airport_from.id')
            ->leftJoin('airport AS airport_to', 'flight.airport_to_id = airport_to.id')
            ->where(['airport_from.iata' => $from, 'airport_to.iata' => $to])
            ->all();

            $airport_from = (new \yii\db\Query())->select(['sity', 'iata', 'name'])
            ->from('flight')
            ->leftJoin('airport', 'flight.airport_from_id = airport.id')
            ->where(['iata' => $from])
            ->all();
    
            $airport_to = (new \yii\db\Query())->select(['sity', 'iata', 'name'])
            ->from('flight')
            ->leftJoin('airport', 'flight.airport_to_id = airport.id')
            ->where(['iata' => $to])
            ->all();

            return ['flight_to' => $flight_to];
        }

        return $errors;
    }
}


?>