class PagesController < ApplicationController
  def index
    if user_signed_in?
      redirect_to user_path(current_user)
    else
      # Aquí renderizamos la vista de bienvenida con los botones de registro e inicio de sesión.
      # Asegúrate de tener la vista "welcome" creada en la carpeta app/views/pages.
      render 'welcome'
    end
  end
end
