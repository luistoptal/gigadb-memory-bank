**Task Outline: FAQ Contact Form to User Creation Redirect**

1.  **Modify `SiteController::actionFaq` (`protected/controllers/SiteController.php`):**
    *   Locate the section within `if ($model->validate()) { ... }` after the email has been successfully sent (i.e., after the `Yii::app()->mailService->sendEmail(...)` call and before the `Yii::app()->user->setFlash(...)` and `$this->refresh()`).
    *   Store the submitted `$model->name` and `$model->email` into the user's session flash data. Using flash data ensures it's available only for the next request.
        *   `Yii::app()->user->setFlash('faqName', $model->name);`
        *   `Yii::app()->user->setFlash('faqEmail', $model->email);`
    *   Remove the existing `Yii::app()->user->setFlash('submit-question', ...)` and `$this->refresh();` lines within this block.
    *   Redirect the user to the user creation page: `$this->redirect(['user/create', 'fromFaq' => 1]);`.

2.  **Modify `UserController::actionCreate` (`protected/controllers/UserController.php`):**
    *   At the beginning of the action, check if the request contains the `fromFaq` parameter: `isset($_GET['fromFaq'])`.
    *   If `fromFaq` is set:
        *   Retrieve the name and email from the flash data:
            *   `$name = Yii::app()->user->getFlash('faqName');`
            *   `$email = Yii::app()->user->getFlash('faqEmail');`
        *   Check if `$name` and `$email` are not empty/null.
        *   If they exist, populate the `$model` (the user model instance used for the form) attributes:
            *   `$model->email = $email;`
            *   `$model->first_name = $name;`
        *   Set a variable to pass to the view indicating the message should be shown: `$showFaqThankYou = true;`.
    *   Ensure `$showFaqThankYou` is initialized to `false` if `fromFaq` is not set or flash data is missing.
    *   Pass `$showFaqThankYou` to the `render` call: `$this->render('create', ['model' => $model, 'showFaqThankYou' => $showFaqThankYou]);` (Adjust parameters as needed based on existing render call).

3.  **Modify `protected/views/user/create.php`:**
    *   At an appropriate location near the top of the view (e.g., before the main form content), add a conditional block:
        ```php
        <?php if (isset($showFaqThankYou) && $showFaqThankYou): ?>
            <div class="alert alert-info"> <?php // Or other appropriate styling ?>
                Thank you for submitting your question, someone will get back to you as soon as possible.
                <br>
                Why not create an account and subscribe to the GigaDB mailing list?
            </div>
        <?php endif; ?>
        ```
    *   The user creation form fields for `email` and `first_name` should now be pre-filled automatically because their corresponding model attributes were set in the controller.

4.  **Verification:**
    *   The attribute name `first_name` has been confirmed in the `User` model (`protected/models/User.php`).
    *   Confirm how the mailing list subscription is handled in the `create.php` view and ensure it's presented clearly alongside the pre-filled form.

5.  **Testing:**
    *   Test submitting the FAQ form successfully: Verify redirection to `user/create`, the presence of the thank-you message, and correct pre-filling of email and name.
    *   Test submitting the FAQ form with validation errors: Verify it stays on the FAQ page and shows errors.
    *   Test accessing the `/user/create` page directly: Verify no thank-you message appears and fields are not pre-filled.
