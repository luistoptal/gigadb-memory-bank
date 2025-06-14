# FAQ Contact Form to User Creation Redirect

## User story description
When a user submits a question through the FAQ contact form, they should be redirected to the user creation page with their name and email pre-filled. A thank you message should be displayed on the user creation page, encouraging them to create an account and subscribe to the GigaDB mailing list.

## User story completion requirements
- Modify the FAQ contact form submission process to redirect to the user creation page
- Pass the user's name and email from the FAQ form to the user creation page
- Display a thank you message on the user creation page when coming from the FAQ form
- Pre-fill the name and email fields in the user creation form
- Maintain all current validation behaviors for both forms

## Tasks

- [ ] Modify SiteController::actionFaq in protected/controllers/SiteController.php

  - [ ] Store the user's name and email in session flash data
  - [ ] Replace the existing flash message and refresh with a redirect to the user creation page
  - [ ] Implementation details:
    - [ ] Inside the `if ($model->validate())` block after sending the email
    - [ ] Add `Yii::app()->user->setFlash('faqName', $model->name);`
    - [ ] Add `Yii::app()->user->setFlash('faqEmail', $model->email);`
    - [ ] Remove the existing `Yii::app()->user->setFlash('submit-question', ...)` and `$this->refresh();`
    - [ ] Add `$this->redirect(['user/create', 'fromFaq' => 1]);`
  - [ ] Test by submitting the FAQ form and confirming redirection to the user creation page

- [ ] Modify UserController::actionCreate in protected/controllers/UserController.php

  - Add code to check for the fromFaq parameter and retrieve flash data
  - Pre-fill the form fields if coming from FAQ
  - Implementation details:
    - At the beginning of the action, add a check for `isset($_GET['fromFaq'])`
    - If true, retrieve flash data: `$name = Yii::app()->user->getFlash('faqName'); $email = Yii::app()->user->getFlash('faqEmail');`
    - Check if values exist and set model attributes: `$user->email = $email; $user->first_name = $name;`
    - Create a variable to pass to the view: `$showFaqThankYou = !empty($name) && !empty($email);`
    - Initialize as false if not from FAQ
    - Pass the variable to the view in render call
  - Test by verifying form fields are pre-filled when redirected from FAQ form

- [ ] Modify protected/views/user/create.php

  - Add conditional block to display thank you message
  - Implementation details:
    - Before the form partial, add:
    ```php
    <?php if (isset($showFaqThankYou) && $showFaqThankYou): ?>
        <div class="alert alert-info">
            Thank you for submitting your question, someone will get back to you as soon as possible.
            <br>
            Why not create an account and subscribe to the GigaDB mailing list?
        </div>
    <?php endif; ?>
    ```
    - Ensure the variable is properly passed from the controller
  - Test by checking the message appears when coming from FAQ form and doesn't appear when accessing directly

- [ ] Handle edge cases and validation

  - Ensure the FAQ form validation still works correctly
  - Make sure direct access to the user creation page works normally
  - Implementation details:
    - Test submitting invalid data in the FAQ form to ensure it doesn't redirect
    - Test accessing the user creation page directly to ensure no flash message appears
    - Test submitting the FAQ form with valid data but then navigating elsewhere before going to the user creation page

- [ ] Write acceptance tests

  - Create acceptance tests to verify the new functionality
  - Implementation details:
    - Test successful submission of FAQ form and redirection
    - Test pre-filled fields on user creation page
    - Test thank you message appears when redirected from FAQ
    - Test normal behavior of user creation page when accessed directly
