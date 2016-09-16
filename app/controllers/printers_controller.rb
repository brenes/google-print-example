class PrintersController < ApplicationController

  def index
    @printers = @google_client.printers.all
  end

end
