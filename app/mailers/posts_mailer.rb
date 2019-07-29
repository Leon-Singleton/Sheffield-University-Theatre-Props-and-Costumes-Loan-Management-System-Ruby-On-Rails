class PostsMailer < ApplicationMailer

  def notify_user_loan(loan, user)
    @loan = loan
    @user = user
    mail(to: @user.email, subject: 'Your Loan Was Successful')
  end

  def notify_user_extension(loan, user)
    @loan = loan
    @user = user
    mail(to: @user.email, subject: 'Your Loan Extension Was Successful')
  end

  def notify_user_soon_due(loan)
    @loan = loan
    @user = @loan.user
    mail(to: @user.email, subject: 'Your Item Is Almost Due')
  end

  def notify_user_return_request(loans, user)
    @loans = loans
    @user = user
    mail(to: @user.email, subject: 'Your Return Request Was Submitted')
  end

  def notify_user_overdue(loan)
    @loan = loan
    @user = @loan.user
    mail(to: @user.email, subject: 'Overdue Loan')
  end

  def notify_user_cancel_reserved(loan, user)
    @loan = loan
    @user = user
    mail(to: @user.email, subject: 'Your Cancellation Request Has Been Submitted')
  end

  def notify_user_return(loans)
    @loans = loans
    @user = @loans.first.user
    mail(to: @user.email, subject: 'Your Return Was Approved')
  end

  def notify_reserved_is_available(loan)
    @loan = loan
    @user = @loan.user
    mail(to: @user.email, subject: 'Your Reservation Is Available Now')
  end

  def notify_admin_add_item(item, admin)
    @item = item
    @admin = admin
    mail(to: 'theatreworkshopsheffield@gmail.com', subject: 'Item Succesfully Created')
  end

  def notify_admin_csv_upload(item, admin)
    @item = item
    @admin = admin
    mail(to: 'theatreworkshopsheffield@gmail.com', subject: 'File Succesfully Uploaded')
  end

  def notify_admin_loan(loan, user)
    @loan = loan
    @user = user
    mail(to: 'theatreworkshopsheffield@gmail.com', subject: 'New Loan Taken Out')
  end

  def notify_admin_return_request(loans, user)
    @loans = loans
    @user = user
    mail(to: 'theatreworkshopsheffield@gmail.com', subject: 'New Loan Return Request Submitted')
  end

  def notify_admin_overdue(loan, admin)
    @loan = loan
    @admin = admin
    @user = @loan.user
    mail(to: 'theatreworkshopsheffield@gmail.com', subject: 'A students loan is overdue')
  end

  def notify_admin_cancel_reserved(loan, user)
    @loan = loan
    @user = user
    mail(to: 'theatreworkshopsheffield@gmail.com', subject: 'New Cancellation Request Submitted')
  end

end
