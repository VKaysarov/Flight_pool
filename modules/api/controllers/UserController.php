<?php

// namespace app\modules\api\controllers;

// use app\modules\api\models\LoginForm;
// use app\modules\api\models\RegisterForm;
// use app\modules\api\resources\UserResource;
// use Yii;
// use yii\filters\Cors;
// use yii\rest\Controller;
// use yii\web\UnauthorizedHttpException;

// /**
//  * Class DefaultController
//  */
// class UserController extends Controller
// {
	
// 	public function actionLogin()
// 	{
//         // if (!Yii::$app->user->isGuest) {
//         //     return $this->goHome();
//         // }

//         $model = new LoginForm();
//         if ($model->load(Yii::$app->request->post(), '') && $model->login()) {
//             return $this->goBack();
//         }

//         Yii:$app->response->statusCode = 422;
//         return [
//             'errors' => $model->errors
//         ];
// 	}
// }


namespace app\modules\api\controllers;

use Yii;
use yii\rest\Controller;
use yii\filters\ContentNegotiator;
use yii\filters\auth\HttpBasicAuth;
use yii\filters\auth\HttpBearerAuth;
use yii\web\Response;

class UserController extends Controller
{
    public $modelClass = 'app\models\User';
	
	public function behaviors()
	{
		$model = new $this->modelClass;
		$behaviors = parent::behaviors();
		$behaviors['authenticator']['class'] = HttpBearerAuth::className();
		$behaviors['authenticator']['except'] = ['login', 'register'];

		return $behaviors;
	}

    /**
     * Аутентифицирует пользователя.
     *
     * @return array Токен доступа или ошибки валидации
     */
    public function actionLogin()
    {
		$model = new \app\modules\api\models\LoginForm();
		$model->load(\Yii::$app->request->post(), '');

		if ($model->validate()) {
			// $user = $model->getUser();
			$request = Yii::$app->request;
            $phone = $request->post('phone'); 
			$user = \app\models\User::find()->where(['phone' => $phone])->one();
			$token = \Yii::$app->security->generateRandomString();
			$user->access_token = $token;
			$user->save();
			// $user->renewToken();

			return ['token' => $token];
			// return ['token' => $token];
		}

		$errors = $model->getFirstErrors();
		$code = isset($errors['login']) ? 404 : 422;
		\Yii::$app->response->setStatusCode($code);

		return $errors;
    }

    /**
     * Создает пользователя.
     *
     * @return array ID созданного пользователя или ошибки валидации
     * @throws \yii\web\ServerErrorHttpException при ошибке сохранения
     */
    public function actionRegister()
    {
    	$request = Yii::$app->request;
        $model = new $this->modelClass;
        $model->first_name = $request->post('first_name');
        $model->last_name = $request->post('last_name');
        $model->document_number = $request->post('document_number');
        $model->phone = $request->post('phone');
        $model->password = $request->post('password');
        $model->save();

        \Yii::$app->response->setStatusCode($statusCode);


        // return $this->saveModel($model, ['first_name', 'last_name', 'phone', 'document_number'], 201);
    }

    /**
     * Разлогинивает пользователя.
     *
     * @return bool
     */
    public function actionLogout()
    {
        $user = \Yii::$app->user->identity;
        $user->renewToken(false);

        return true;
    }

    public function actionViewBooking()
    {
        return "ok";
    }


    protected function saveModel($model, $attrs, $statusCode = 200)
    {
        $model->load(\Yii::$app->request->post(), '');

        if ($model->save()) {
            \Yii::$app->response->setStatusCode($statusCode);
            return $model->getAttributes($attrs);
        }

        if ($model->hasErrors()) {
            \Yii::$app->response->setStatusCode(422);
            return $model->getFirstErrors();
        }

        throw new \yii\web\ServerErrorHttpException();
    }

}


?>