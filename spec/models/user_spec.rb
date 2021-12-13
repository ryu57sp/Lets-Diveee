require 'rails_helper'
RSpec.describe 'Userモデルのテスト', type: :model do

  describe 'バリデーションのテスト' do
    subject { user.valid? }

    let!(:other_user) { create(:user) }
    let(:user) { build(:user) }

    context 'nameカラム' do
      it '空欄でないこと' do
        user.name = ''
        is_expected.to eq false
      end
      it '2文字以上であること: 1文字は×' do
        user.name = Faker::Lorem.characters(number: 1)
        is_expected.to eq false
      end
      it '2文字以上であること: 2文字は〇' do
        user.name = Faker::Lorem.characters(number: 2)
        is_expected.to eq true
      end
      it '8文字以下であること: 8文字は〇' do
        user.name = Faker::Lorem.characters(number: 8)
        is_expected.to eq true
      end
      it '8文字以下であること: 9文字は×' do
        user.name = Faker::Lorem.characters(number: 9)
        is_expected.to eq false
      end
      it '一意性があること' do
        user.name = other_user.name
        is_expected.to eq false
      end
    end
  end

   describe 'アソシエーションのテスト' do
    context 'Diveモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:dives).macro).to eq :has_many
      end
    end
  end

  describe 'メソッドの確認' do
    describe '退会機能の確認' do
      let(:user) { FactoryBot.create(:user) }
      before do
        user.update(is_deleted: true)
      end
      it '退会後にログインすることは不可能か' do
        expect(user.active_for_authentication?).to eq false
      end
    end

    describe 'フォロー・フォロワー機能の確認' do
      let(:user) { FactoryBot.create(:user) }
      let(:other_user) { FactoryBot.create(:user) }

      context 'フォローの動作の確認' do
        before do
          user.follow(other_user.id)
        end
        it 'フォローをちゃんとできているか' do
          expect(user.following?(other_user)).to be_truthy
        end
      end

      context 'フォロー解除の動作確認' do
        before do
          user.follow(other_user.id)
        end

        it 'フォロー解除がちゃんとできるか' do
          user.unfollow(other_user.id)
          expect(user.following?(other_user)).to be_falsy
        end
      end

      context 'フォローに対する通知機能の確認' do
        before do
          user.follow(other_user.id)
        end

        it 'フォローに対する通知がちゃんと作成されるか' do
          expect(other_user.create_notification_follow!(user)).to eq true
        end
      end
    end
  end

end