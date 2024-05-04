# frozen_string_literal: true

class SyncFile < ApplicationRecord
  include SyncFilesHelper

  UNRANSACKABLE_ATTRIBUTES = %w[
    quantity
    is_promotion
    price_before_tax
    price
    %CK/DH
    %CK/SP
    ckdh
    cksp
    tt_tt
    tt_chua_vat_da_tru_ck
    tien_vat
    tt_vat
    tong_tt_truoc_vat
    tong_ck
    tong_tt_chua_vat_da_tru_ck
    tong_tien_vat
    tong_tt_vat
  ].freeze

  validates :order_date, presence: true
  validate :order_date_is_date
  validates :customer_phone, format: { with: /\A\d+\z/, message: I18n.t("errors.messages.not_a_number") },
    allow_nil: true

  class << self
    def ransackable_attributes(auth_object = nil)
      (column_names - UNRANSACKABLE_ATTRIBUTES) + _ransackers.keys
    end

    def ransackable_associations(auth_object = nil)
      []
    end
  end

  private

    def order_date_is_date
      errors.add(:base, I18n.t("errors.messages.invalid_date")) unless order_date.is_a?(Date)
    end
end
