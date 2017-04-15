defmodule Manager.UserMailer do
  import Bamboo.Email

  @from "imoca@yopmail.com"

  def welcome(url, user) do
    new_email()
    |> to(user.email)
    |> from(@from)
    |> subject("Welcome!")
    |> html_body(~s(Welcome! Login with <a href="#{url}">this link</a>.))
    |> text_body("Welcome! Login with #{url}")
  end

  def login(url, user) do
    new_email()
    |> to(user.email)
    |> from(@from)
    |> subject("Sign In!")
    |> html_body(~s(Welcome back! Login with <a href="#{url}">this link</a>.))
    |> text_body("Welcome back! Login with #{url}")
  end
end