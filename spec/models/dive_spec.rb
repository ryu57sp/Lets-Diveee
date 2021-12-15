require 'rails_helper'

RSpec.describe 'Diveモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { dive.valid? }

    let(:user) { create(:user) }
    let!(:dive) { build(:dive, user_id: user.id) }

    context 'titleカラム' do
      it '空欄でないこと' do
        dive.title = ''
        is_expected.to eq false
      end
    end

    context 'bodyカラム' do
      it '空欄でないこと' do
        dive.body = ''
        is_expected.to eq false
      end
    end

    context 'dive_pointカラム' do
      it '空欄でないこと' do
        dive.dive_point = ''
        is_expected.to eq false
      end
    end

    context 'water_temperatureカラム' do
      it '空欄でないこと' do
        dive.water_temperature = ''
        is_expected.to eq false
      end
    end

    context 'maximum_depthカラム' do
      it '空欄でないこと' do
        dive.maximum_depth = ''
        is_expected.to eq false
      end
    end

    context 'seasonカラム' do
      it '空欄でないこと' do
        dive.season = ''
        is_expected.to eq false
      end
    end

    context 'dive_shopカラム' do
      it '空欄でないこと' do
        dive.dive_shop = ''
        is_expected.to eq false
      end
    end

    context 'titleカラム' do
      it '17文字以下であること: 18文字は×' do
        dive.title = Faker::Lorem.characters(number: 18)
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Dive.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end

  describe 'メソッドの確認' do
    describe 'いいね機能のテスト' do
      context 'いいねのデータ確認' do
        let(:user) { FactoryBot.create(:user) }
        let(:dive) { FactoryBot.create(:dive, user: user) }

        before do
          user.favorites.create(dive_id: dive.id)
        end

        it 'Favoriteモデルにユーザーのデータが存在する場合' do
          expect(dive.favorited_by?(user)).to eq true
        end
        it 'Favoriteモデルにユーザーのデータが存在しない場合' do
          user.favorites.find_by(dive_id: dive.id).destroy
          expect(dive.favorited_by?(user)).to eq false
        end
      end

      context 'いいねに対するの通知機能の確認' do
        let(:user) { FactoryBot.create(:user) }
        let!(:other_user) { FactoryBot.create(:user) }
        let!(:other_dive) { FactoryBot.create(:dive, user: other_user) }

        before do
          user.favorites.create(dive_id: other_dive.id)
        end

        it 'いいねに対して通知がちゃんと作成されるか' do
          expect(other_dive.create_notification_favorite!(user)).to eq true
        end
      end
    end

    describe 'ブックマーク機能のテスト' do
      let(:user) { FactoryBot.create(:user) }
      let(:dive) { FactoryBot.create(:dive, user: user) }

      before do
        user.bookmarks.create(dive_id: dive.id)
      end

      it 'Bookmarkモデルにユーザーのデータが存在する場合' do
        expect(dive.bookmarked_by?(user)).to eq true
      end
      it 'Bookmarkモデルにユーザーのデータが存在しない場合' do
        user.bookmarks.find_by(dive_id: dive.id).destroy
        expect(dive.bookmarked_by?(user)).to eq false
      end
    end

    describe 'コメントに対する通知機能のテスト' do
      let(:user) { FactoryBot.create(:user) }
      let!(:other_user) { FactoryBot.create(:user) }
      let!(:other_dive) { FactoryBot.create(:dive, user: other_user) }

      before do
        other_dive.dive_comments.create(dive_id: other_dive.id, user_id: user.id, comment: 'RspecTest')
      end

      it 'コメントに対して通知がちゃんと作成されるか' do
        expect(other_dive.create_notification_comment!(user, user.dive_comments)).to eq true
      end
    end
  end
end
