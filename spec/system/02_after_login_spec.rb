require 'rails_helper'

describe '[STEP2] ユーザログイン後のテスト' do
  let(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:dive) { create(:dive, user: user) }
  let!(:other_dive) { create(:dive, user: other_user) }

  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
  end

  describe '投稿一覧画面のテスト' do
    before do
      visit dives_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/dives'
      end
      it '「All Adventures🤿」と表示される' do
        expect(page).to have_content 'All Adventures 🤿'
      end
      it '投稿検索ボタンが表示される' do
        expect(page).to have_button '検索'
      end
      it '自分と他人の画像のリンク先が正しい' do
        expect(page).to have_link '', href: user_path(dive.user)
        expect(page).to have_link '', href: user_path(other_dive.user)
      end

      context '投稿がある場合' do
        let!(:dive) { create(:dive, user: user) }
      end

      it '自分の投稿と他人の投稿の投稿日が表示される' do
        expect(page).to have_content dive.created_at.strftime('%Y/%m/%d')
        expect(page).to have_content other_dive.created_at.strftime('%Y/%m/%d')
      end
      it '投稿者名が表示される' do
        expect(page).to have_content dive.user.name
        expect(page).to have_content other_dive.user.name
      end
      it '自分の投稿と他人の投稿のタイトルが表示される' do
        expect(page).to have_content dive.title
        expect(page).to have_content other_dive.title
      end
      it '自分の投稿と他人の投稿のいいね数が表示される' do
        expect(page).to have_content dive.favorites.count
        expect(page).to have_content other_dive.favorites.count
      end
      it '自分の投稿と他人の投稿のコメント数が表示される' do
        expect(page).to have_content dive.dive_comments.count
        expect(page).to have_content other_dive.dive_comments.count
      end
    end
  end

  describe '投稿詳細画面のテスト' do
    before do
      visit dive_path(dive.id)
    end

    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/dives/' + dive.id.to_s
      end
      it '「Marine Adventure🤿」と表示される' do
        expect(page).to have_content 'Marine Adventure 🤿'
      end
      it '投稿日が表示される' do
        dive.created_at.strftime('%Y/%m/%d')
      end
      it 'ユーザーネームが表示される' do
        expect(page).to have_content dive.user.name
      end
      it 'ポイント名が表示される' do
        expect(page).to have_content dive.dive_point
      end
      it '内容が表示される' do
        expect(page).to have_content dive.body
      end
      it '水温が表示される' do
        expect(page).to have_content dive.water_temperature
      end
      it '潜水深度が表示される' do
        expect(page).to have_content dive.maximum_depth
      end
      it '時期が表示される' do
        expect(page).to have_content dive.season
      end
      it '利用したショップが表示される' do
        expect(page).to have_content dive.dive_shop
      end
      it 'いいね数が表示される' do
        expect(page).to have_content dive.favorites.count
      end
      it 'コメント数が表示される' do
        expect(page).to have_content dive.dive_comments.count
      end
      it 'PV数が表示される' do
        expect(page).to have_content dive.impressionist_count
      end
      it 'いいねボタンのリンクが正しい' do
        expect(page).not_to have_link '', href: dive_favorites_path(user)
      end
      it 'ブックマークボタンのリンクが正しい' do
        expect(page).not_to have_link '', href: dive_bookmarks_path(user)
      end
      it 'コメント投稿フォームがある' do
        expect(page).to have_field 'dive_comment[comment]'
      end
      it 'コメント送信ボタンがある' do
        expect(page).to have_button '送信する'
      end
    end
  end

  describe '新規投稿画面のテスト' do
    before do
      visit new_dive_path
    end

    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/dives/new'
      end
      it '画像投稿フォームがある' do
        expect(page).to have_field 'dive[image]'
      end
      it 'ポイント名投稿フォームがある' do
        expect(page).to have_field 'dive[dive_point]'
      end
      it 'タイトル投稿フォームがある' do
        expect(page).to have_field 'dive[title]'
      end
      it '内容投稿フォームがある' do
        expect(page).to have_field 'dive[body]'
      end
      it '水温投稿フォームがある' do
        expect(page).to have_field 'dive[water_temperature]'
      end
      it '潜水深度投稿フォームがある' do
        expect(page).to have_field 'dive[maximum_depth]'
      end
      it '時期投稿フォームがある' do
        expect(page).to have_field 'dive[season]'
      end
      it '利用したショップ投稿フォームがある' do
        expect(page).to have_field 'dive[dive_shop]'
      end
    end
  end

  describe '自分の投稿編集画面のテスト' do
    before do
      visit edit_dive_path(dive)
    end

    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/dives/' + dive.id.to_s + '/edit'
      end
      it '「Edit Adventure」と表示される' do
        expect(page).to have_content 'Edit Adventure 🤿'
      end
      it 'ポイント名編集フォームが表示される' do
        expect(page).to have_field 'dive[dive_point]', with: dive.dive_point
      end
      it 'タイトル編集フォームが表示される' do
        expect(page).to have_field 'dive[title]', with: dive.title
      end
      it '内容編集フォームが表示される' do
        expect(page).to have_field 'dive[body]', with: dive.body
      end
      it '水温編集フォームが表示される' do
        expect(page).to have_field 'dive[water_temperature]'
      end
      it '潜水深度編集フォームが表示される' do
        expect(page).to have_field 'dive[maximum_depth]'
      end
      it '時期編集フォームが表示される' do
        expect(page).to have_field 'dive[season]'
      end
      it '利用したショップ編集フォームが表示される' do
        expect(page).to have_field 'dive[dive_shop]', with: dive.dive_shop
      end
      it '更新ボタンが表示される' do
        expect(page).to have_button '更新'
      end
      it '削除ボタンのリンクが正しい' do
        expect(page).to have_link '削除', href: dive_path(dive)
      end
    end
  end

  describe '自分のユーザ詳細画面のテスト' do
    before do
      visit user_path(user)
    end

    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/' + user.id.to_s
      end
      it 'プロフィール画像が表示される' do
        expect(page).to have_content user.profile_image
      end
      it 'ユーザーネームが表示される' do
        expect(page).to have_content user.name
      end
      it '紹介文が表示される' do
        expect(page).to have_content user.profile
      end
      it 'ダイバーズランクが表示される' do
        expect(page).to have_content user.diver_rank
      end
      it '投稿数が表示される' do
        expect(page).to have_content user.dives.count
      end
      it 'フォロー数が表示される' do
        expect(page).to have_content user.followings.count
      end
      it 'フォロワー数が表示される' do
        expect(page).to have_content user.followers.count
      end
      it 'フォロー一覧へのリンクが正しい' do
        expect(page).to have_link user.followings.count, href: user_followings_path(user)
      end
      it 'フォロワー一覧へのリンクが正しい' do
        expect(page).to have_link user.followers.count, href: user_followers_path(user)
      end
      it 'マイページ編集画面へのリンクが正しい' do
        expect(page).to have_link '編集する', href: edit_user_path(user)
      end
      it 'ブックマーク一覧画面へのリンクが正しい' do
        expect(page).to have_link 'ブックマーク一覧', href: bookmarks_path
      end
      it '自分の各投稿へのリンクが正しい' do
        expect(page).to have_link dive.image, href: dive_path(dive)
      end
      it '他人の投稿は表示されない' do
        expect(page).not_to have_link '', href: user_path(other_user)
        expect(page).not_to have_content other_dive
      end
    end
  end

  describe '自分のユーザ情報編集画面のテスト' do
    before do
      visit edit_user_path(user)
    end

    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/' + user.id.to_s + '/edit'
      end
      it '「Edit Profile」と表示される' do
        expect(page).to have_content 'Edit Profile'
      end
      it 'ユーザーネーム編集フォームに自分のユーザーネームが表示される' do
        expect(page).to have_field 'user[name]', with: user.name
      end
      it '紹介文編集フォームに自分の紹介文が表示される' do
        expect(page).to have_field 'user[profile]'
      end
      it 'ダイバーズランク編集フォームに自分のダイバーズランクが表示される' do
        expect(page).to have_field 'user[diver_rank]'
      end
      it '更新ボタンが表示される' do
        expect(page).to have_button '更新'
      end
    end
  end

  describe '他のユーザ詳細画面のテスト' do
    before do
      visit user_path(other_user)
    end

    context '表示の確認' do
      it 'フォローボタンのリンクが正しい' do
        expect(page).not_to have_link 'フォローする', href: user_relationships_path(user)
      end
      it 'DMのリンクが正しい' do
        expect(page).not_to have_link 'ダイレクトメッセージへ', href: chat_path(user)
      end
    end
  end

  describe '退会画面のテスト' do
    before do
      visit quit_user_path(user)
    end

    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/' + user.id.to_s + '/quit'
      end
      it '「本当に退会しますか？」と表示される' do
        expect(page).to have_content '本当に退会しますか？'
      end
      it '退会しないボタンが表示される' do
        expect(page).not_to have_button '退会しない'
      end
      it '退会するボタンが表示される' do
        expect(page).not_to have_button '退会する'
      end
    end
  end

  describe '通知一覧画面のテスト' do
    before do
      visit notifications_path
    end

    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/notifications'
      end
      it '「通知はありません。」と表示される' do
        expect(page).to have_content '通知はありません。'
      end
    end
  end

  describe 'ランキング画面のテスト' do
    before do
      visit ranks_path
    end

    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/ranks'
      end
      it '「毎日更新」と表示される' do
        expect(page).to have_content '毎日更新'
      end
    end
  end

  describe 'ブックマーク一覧画面のテスト' do
    before do
      visit bookmarks_path
    end

    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/bookmarks'
      end
      it '「ブックマーク一覧」と表示される' do
        expect(page).to have_content 'ブックマーク一覧 🔖'
      end
    end
  end

  describe 'マップ画面のテスト' do
    before do
      visit map_path
    end

    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/map'
      end
      it '「ポイント・ショップ検索」と表示される' do
        expect(page).to have_content 'ポイント・ショップ検索'
      end
    end
  end
end
