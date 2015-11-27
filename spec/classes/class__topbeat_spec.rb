require 'spec_helper'

describe 'beats::topbeat', :type => :class do
  context 'on supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let (:facts) do
          facts
        end

        context 'without any parameters' do
          it { should compile.with_all_deps }
          it { should contain_class('beats::topbeat') }
          it { should contain_package('topbeat') }
          it { should contain_file('/etc/topbeat/topbeat.yml').with_content(/system: true/) }
          it { should contain_file('/etc/topbeat/topbeat.yml').with_content(/output:/) }
        end
      end
    end
  end
end
