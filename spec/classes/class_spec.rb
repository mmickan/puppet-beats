require 'spec_helper'

describe 'beats', :type => :class do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let (:facts) do
          facts
        end

        context 'without any parameters' do
          it { should compile.with_all_deps }
          it { should contain_class('beats') }
          it { should contain_class('beats::params') }
          it { should contain_class('beats::repo') }
        end
      end
    end
  end

  context 'unsupported operating system' do
    describe 'beats class without any parameters on Foo/Bar' do
      let(:facts) do
        {
          :osfamily => 'Foo',
          :operatingsystem => 'Bar',
        }
      end

      it { expect { should raise_error(Puppet::Error) } }
    end
  end
end
