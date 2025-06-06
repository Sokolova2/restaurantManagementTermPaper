require 'stripe'
Rails.configuration.stripe = {
  :publishable_key => ENV['STRIPE_PUBLISHABLE_KEY'] || Rails.application.credentials.stripe_publishable_key,
  :secret_key      => ENV['STRIPE_SECRET_KEY'] || Rails.application.credentials.stripe_secret_key
}
Stripe.api_key = Rails.configuration.stripe[:secret_key]
