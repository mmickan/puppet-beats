require 'spec_helper'

describe 'beats::repo', :type => :class do
  context 'directly instantiating private class' do
    it { should_not compile.and_raise_error(Puppet::Error) }
  end
end

describe 'beats', :type => :class do
  context 'beats::repo class on supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let (:facts) do
          facts
        end

        context 'without any parameters' do
          it { should compile.with_all_deps }
          case os
          when /^ubuntu/
            it { should contain_class('beats::repo::apt') }
          end
        end
      end
    end
  end
end
