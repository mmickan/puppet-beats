require 'spec_helper'

describe 'beats::filebeat::prospector', :type => :define do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let (:facts) do
          facts
        end

        let(:title) { 'syslog' }

        describe 'with defaults' do
          let(:params) do
            {
              :paths => ['/var/log/syslog'],
            }
          end

          it { should compile.with_all_deps }
          it { should contain_file('/etc/filebeat/conf.d').with_ensure('directory') }
          it { should contain_file('/etc/filebeat/conf.d/syslog.yml').with_content(/- \/var\/log\/syslog/) }
        end
      end
    end
  end
end
