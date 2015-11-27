require 'spec_helper'

describe 'beats::debug', :type => :class do
  context 'directly instantiating private class' do
    it { should_not compile.and_raise_error(Puppet::Error) }
  end
end

describe 'beats', :type => :class do
  context 'beats::debug class on supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let (:facts) do
          facts
        end

        context 'with debug enabled' do
          let(:params) do
            {
              :debug => true,
            }
          end

          it { should compile.with_all_deps }
          it { should contain_class('beats::debug') }
          it { should contain_file('/var/lib/puppet/debug').with_ensure('directory') }
          it { should contain_file('/var/lib/puppet/debug/beats') }
        end

        context 'with custom debug directory' do
          let(:params) do
            {
              :debug     => true,
              :debug_dir => '/tmp',
            }
          end

          it { should compile.with_all_deps }
          it { should contain_file('/tmp').with_ensure('directory') }
          it { should contain_file('/tmp/beats') }
          it { should_not contain_file('/var/lib/puppet/debug') }
        end

        context 'with debug disabled' do
          it { should compile.with_all_deps }
          it { should_not contain_class('beats::debug') }
          it { should_not contain_file('/var/lib/puppet/debug') }
          it { should_not contain_file('/var/lib/puppet/debug/beats') }
        end
      end
    end
  end
end
