require 'spec_helper'

describe 'beats::filebeat', :type => :class do
  context 'on supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let (:facts) do
          facts
        end

        context 'without any parameters' do
          it { should compile.with_all_deps }
          it { should contain_class('beats::filebeat') }
          it { should contain_package('filebeat') }
          it { should contain_file('/etc/filebeat/filebeat.yml').with_content(/config_dir: \/etc\/filebeat\/conf\.d/) }
          it { should contain_file('/etc/filebeat/filebeat.yml').with_content(/output:/) }
        end

        context 'with tls certificate and key' do
          let (:params) do
            {
              :tls_certificate     => '/tmp/cert.pem',
              :tls_certificate_key => '/tmp/key.pem',
            }
          end

          it { should compile.with_all_deps }
          it { should contain_file('/etc/filebeat/filebeat.yml').with_content(/certificate: \/tmp\/cert.pem/) }
          it { should contain_file('/etc/filebeat/filebeat.yml').with_content(/certificate_key: \/tmp\/key.pem/) }
        end
      end
    end
  end
end
