class Notifier < ActionMailer::Base
  default :from => "Neha <neha.email1@gmail.com>"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.order_received.subject
  #
  def order_received(order)
    @order = order

    mail :to => order.email, :subject => "Your aesthetic order confirmation"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.order_shipped.subject
  #
  def order_shipped(order)
    @order = order

    mail :to => order.email, :subject => "Your aesthetic order has been shipped"
  end
end
