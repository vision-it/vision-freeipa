require 'spec_helper'
require 'hiera'

describe 'vision_freeipa' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      context 'include replica' do
        let(:pre_condition) { 'include vision_docker' }

        let :params do
          {
            type: 'replica'

          }
        end
        context 'compile' do
          it { is_expected.to compile.with_all_deps }
        end

        context 'contains' do
          it { is_expected.to contain_class('vision_freeipa::replica') }
        end
      end

      context 'include master' do
        let(:pre_condition) { 'include vision_docker' }

        let :params do
          {
            type: 'master'

          }
        end
        context 'compile' do
          it { is_expected.to compile.with_all_deps }
        end

        context 'contains' do
          it { is_expected.to contain_class('vision_freeipa::master') }
        end
      end
    end
  end
end
