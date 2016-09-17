class PrintJobsController < ApplicationController

  before_action :find_printer

  def create
    response = @printer.client.connection.send(:post, '/submit', :printerid => @printer.id, title: "Test #{Time.now.to_i}", :content => params[:content], :contentType => "text/html")
    redirect_to printer_print_job_path(params[:printer_id], response["job"]["id"])
  end

  def show
    @print_job = @google_client.print_jobs.find(params[:id])
  end

  def find_printer
    @printer = @google_client.printers.find(params[:printer_id])
  end

end
