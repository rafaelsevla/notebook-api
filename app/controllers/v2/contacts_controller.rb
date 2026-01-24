
module V2
  class ContactsController < ApplicationController
    before_action :set_contact, only: %i[ show update destroy ]
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    # GET /contacts
    def index
      @contacts = Contact.last(5)

      render json: @contacts, include: [ :phones, :address ]
    end

    # GET /contacts/1
    def show
      render json: @contact, include: [ :kind, :address, :phone ]
    end

    # POST /contacts
    def create
      @contact = Contact.new(contact_params)

      if @contact.save
        render json: @contact, include: [ :phones, :address ], status: :created, location: @contact
      else
        render json: @contact.errors, status: :unprocessable_content
      end
    end

    # PATCH/PUT /contacts/1
    def update
      if @contact.update(contact_params)
        render json: @contact, include: [ :phones, :address ]
      else
        render json: @contact.errors, status: :unprocessable_content
      end
    end

    # DELETE /contacts/1
    def destroy
      @contact.destroy!
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_contact
        @contact = Contact.find(params.expect(:id))
      end

      # Only allow a list of trusted parameters through.
      def contact_params
        ActiveModelSerializers::Deserialization.jsonapi_parse(params)
      end

      def record_not_found
        render json: { error: "Contato não encontrado" }, status: :not_found
      end
  end
end
