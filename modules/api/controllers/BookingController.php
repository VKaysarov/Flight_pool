<?php

namespace app\modules\api\controllers;


use Yii;
use yii\rest\ActiveController;

class BookingController extends ActiveController
{
    public $modelClass = 'app\modules\api\models\Booking';

    public function actions()
    {
        $actions = parent::actions();
        unset($actions['view'], $actions['create']);
        return $actions;
    }

    public function actionView()
    {
        $params = Yii::$app->request->queryParams;
        $code = $params['code'];
        // $models = new $this->modelClass();
        // $booking = $models::find()->where(['code' => $code])->one();
        $booking = (new \yii\db\Query())->select(['*'])
            ->from('booking')
            ->leftJoin('flight', 'flight.id = booking.flight_id')
            // ->leftJoin('passenger', 'passenger.booking_id = booking.id')
            ->where(['booking.code' => $code])
            ->all();

        $booking_passengers = (new \yii\db\Query())->select(['*'])
            ->from('booking')
            ->leftJoin('passenger', 'passenger.booking_id = booking.id')
            ->where(['booking.code' => $code])
            ->all();
        // $booking += ['passengers' => $booking_passengers];
        array_push( $booking, ['passengers' => $booking_passengers] );
        return ['data' => $booking];
    }

    public function actionCreate()
    {
    	$post = Yii::$app->request->post();
        $flight_from = $post['flight_from'];
        $modelBooking = new $this->modelClass();
        $booking_code = Yii::$app->security->generateRandomString(5);
        $booking_data = ['flight_id' => $flight_from['id'], 'code' => $booking_code];

        if ( $modelBooking->load($booking_data, '') ) {
            $modelBooking->save();
            $booking_id = $modelBooking->id;
        }

        $passengers = $post['passengers'];
        foreach ($passengers as $passenger) {
            $passenger += ['booking_id' => $booking_id];
            $models = new \app\modules\api\models\Passenger();
            if ( $models->load($passenger, '') ) {
                $models->save();
            }
        }


        return ["code" => $booking_code];
    }
}

?>