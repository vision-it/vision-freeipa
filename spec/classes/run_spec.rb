require 'spec_helper'
require 'hiera'

require 'spec_helper'
require 'hiera'

describe 'vision_freeipa::images' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      context 'compile' do
        it { is_expected.to compile.with_all_deps }
      end

      context 'contains' do
        it { is_expected.to contain_docker__image('freeipa').with_ensure('present') }
        it { is_expected.to contain_docker__image('freeipa').with_image('freeipa/freeipa-server') }
      end
    end
  end
end

describe 'vision_freeipa::run' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      let(:params) do
        {
          environment: ['test']
        }
      end

      context 'compile' do
        it { is_expected.to compile.with_all_deps }
      end

      context 'contains' do
        it { is_expected.to contain_docker__run('freeipa') }
      end
    end
  end
end
