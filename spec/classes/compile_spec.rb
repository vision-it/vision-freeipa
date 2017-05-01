require 'spec_helper'
require 'hiera'

describe 'vision_freeipa' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      context 'compile' do
        it { is_expected.to compile.with_all_deps }
      end

      context 'contains' do
        it { is_expected.to contain_class('vision_docker') }
        it { is_expected.to contain_class('vision_freeipa::images') }
        it { is_expected.to contain_class('vision_freeipa::run') }
        it { is_expected.to contain_class('vision_freeipa::config') }
      end
    end
  end
end
