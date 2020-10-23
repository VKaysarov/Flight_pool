<?php

namespace app\modules\api\models;

class Passenger extends \yii\db\ActiveRecord
{

    public static function tableName()
    {
        return 'passenger';
    }

    public function rules()
    {
	    return [
	        // username, email и password требуются в сценарии "register"
	        [['first_name', 'last_name', 'birth_date', 'document_number', 'booking_id'], 'required'],
	    ];
    }

}
