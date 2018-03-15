require "yandex_kassa/version"
require "yandex_kassa/configuration"
require "yandex_kassa/requests"
require "yandex_kassa/api"
require "yandex_kassa/signed_response_parser"
require "yandex_kassa/request_signer"
require "yandex_kassa/store_card"
require "openssl"
require "rest-client"

module YandexKassa
  extend self
  def create(url, cert_file, key_file, deposit_cert_file)
    Api.new(url: url,
            cert_file: cert_file,
            key_file: key_file,
            response_parser: pkcs7_response_parser(cert_file, deposit_cert_file),
            request_signer: request_signer(cert_file, key_file))
  end

  def pkcs7_response_parser(cert_file, deposit_cert_file)
    @pkcs7_response_parser ||= SignedResponseParser.new(
      deposit_cert_file: deposit_cert_file,
      cert_file: cert_file)
  end

  def request_signer(cert_file, key_file)
    @request_signer ||= RequestSigner.new(cert_file: cert_file, key_file: key_file)
  end
end
