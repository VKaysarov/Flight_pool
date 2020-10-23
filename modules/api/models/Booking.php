<?php

namespace app\modules\api\models;

// use app\modules\api\models\Passenger;

class Booking extends \yii\db\ActiveRecord
{

    public static function tableName()
    {
        return 'booking';
    }

    public function rules()
    {
	    return [
	        // username, email и password требуются в сценарии "register"
	        [['flight_id', 'code'], 'required'],
	    ];
    }

}
