<?php

namespace app\models;

class Airport extends \yii\db\ActiveRecord
{

    public static function tableName()
    {
        return 'airport';
    }

    public function fields()
    {
        return ['name', 'iata'];
    }


}
