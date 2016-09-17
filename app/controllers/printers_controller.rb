class PrintersController < ApplicationController

  def index
    @printers = @google_client.printers.all
  end

  def show
    @printer = @google_client.printers.find(params[:id])
  end

end
