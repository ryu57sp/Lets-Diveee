require 'rails_helper'

describe '[STEP1] ユーザログイン前のテスト' do
  describe 'トップ画面のテスト' do
    before do
      visit root_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/'
      end
      it 'サイト名が左上に表示される' do
        home_link = find_all('a')[0].native.inner_text
        expect(home_link).to match(/Let's Diveee!!!/)
      end
      it 'Aboutが表示される：１番目である' do
        about_link = find_all('a')[1].native.inner_text
        expect(about_link).to match(/About/)
      end
      it 'ランキングが表示される：２番目である' do
        ranks_link = find_all('a')[2].native.inner_text
        expect(ranks_link).to match(/ランキング/)
      end
      it '投稿一覧が表示される：３番目である' do
        dives_link = find_all('a')[3].native.inner_text
        expect(dives_link).to match(/投稿一覧/)
      end
      it '新規登録が表示される：４番目である' do
        signup_link = find_all('a')[4].native.inner_text
        expect(signup_link).to match(/新規登録/)
      end
      it 'ログインが表示される：５番目である' do
        signin_link = find_all('a')[5].native.inner_text
        expect(signin_link).to match(/ログイン/)
      end
    end
  end

  describe 'アバウト画面のテスト' do
    before do
      visit '/about'
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/about'
      end
    end
  end

  describe 'ヘッダーのテスト(ログイン前)' do
    before do
      visit root_path
    end

    context 'リンクの内容を確認' do
      subject { current_path }

      it 'Aboutを押すと、アバウト画面に遷移する' do
        about_link = find_all('a')[1].native.inner_text
        about_link = about_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link about_link
        is_expected.to eq '/about'
      end
      it 'ランキングを押すと、いいねランキング画面に遷移する' do
        ranks_link = find_all('a')[2].native.inner_text
        ranks_link = ranks_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link ranks_link, match: :first
        is_expected.to eq '/ranks'
      end
      it '投稿一覧を押すと、投稿一覧画面に遷移する' do
        dives_link = find_all('a')[3].native.inner_text
        dives_link = dives_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link dives_link, match: :first
        is_expected.to eq '/dives'
      end
      it '新規登録を押すと、新規登録画面に遷移する' do
        signup_link = find_all('a')[4].native.inner_text
        signup_link = signup_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link signup_link, match: :first
        is_expected.to eq '/users/sign_up'
      end
      it 'ログインを押すと、ログイン画面に遷移する' do
        signin_link = find_all('a')[5].native.inner_text
        signin_link = signin_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link signin_link, match: :first
        is_expected.to eq '/users/sign_in'
      end
    end
  end

  describe 'ユーザ新規登録のテスト' do
    before do
      visit new_user_registration_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/sign_up'
      end
      it '「新規会員登録」と表示される' do
        expect(page).to have_content '新規会員登録'
      end
      it 'nameフォームが表示される' do
        expect(page).to have_field 'user[name]'
      end
      it 'emailフォームが表示される' do
        expect(page).to have_field 'user[email]'
      end
      it 'passwordフォームが表示される' do
        expect(page).to have_field 'user[password]'
      end
      it 'password_confirmationフォームが表示される' do
        expect(page).to have_field 'user[password_confirmation]'
      end
      it '会員登録ボタンが表示される' do
        expect(page).to have_button '会員登録する'
      end
    end

    context '新規登録成功のテスト' do
      before do
        fill_in 'user[name]', with: Faker::Lorem.characters(number: 5)
        fill_in 'user[email]', with: Faker::Internet.email
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
      end

      it '正しく新規登録される' do
        expect { click_button '会員登録する' }.to change(User.all, :count).by(1)
      end
      it '新規登録後のリダイレクト先が、新規登録できたユーザの編集画面になっている' do
        click_button '会員登録する'
        expect(current_path).to eq '/users/' + User.last.id.to_s + '/edit'
      end

      context '新規登録失敗のテスト' do
        before do
          fill_in 'user[name]', with: ''
          fill_in 'user[email]', with: ''
          fill_in 'user[password]', with: ''
          fill_in 'user[password_confirmation]', with: ''
          click_button '会員登録する'
        end

        it '新規登録に失敗し、新規登録画面にリダイレクトされる' do
          expect(current_path).to eq '/users/sign_up'
        end
      end
    end
  end

  describe 'ユーザログインのテスト' do
    let(:user) { create(:user) }

    before do
      visit new_user_session_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/sign_in'
      end
      it '「ログイン」と表示される' do
        expect(page).to have_content 'ログイン'
      end
      it 'nameフォームが表示される' do
        expect(page).to have_field 'user[email]'
      end
      it 'passwordフォームが表示される' do
        expect(page).to have_field 'user[password]'
      end
      it 'ログインボタンが表示される' do
        expect(page).to have_button 'ログイン'
      end
    end

    context 'ログイン成功のテスト' do
      before do
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        click_button 'ログイン'
      end

      it 'ログイン後のリダイレクト先が、トップページになっている' do
        expect(current_path).to eq '/'
      end
    end

    context 'ログイン失敗のテスト' do
      before do
        fill_in 'user[email]', with: ''
        fill_in 'user[password]', with: ''
        click_button 'ログイン'
      end

      it 'ログインに失敗し、ログイン画面にリダイレクトされる' do
        expect(current_path).to eq '/users/sign_in'
      end
    end
  end

  describe 'ヘッダーのテスト: ログインしている場合' do
    let(:user) { create(:user) }

    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'ログイン'
    end

    context 'ヘッダーの表示を確認' do
      it '通知マークが表示される' do
        n_link = find_all('a')[1].native.inner_text
        expect(n_link).to match(//)
      end
      it 'マイページが表示される' do
        mypage_link = find_all('a')[3].native.inner_text
        expect(mypage_link).to match(/マイページ/)
      end
      it '新規投稿が表示されるる' do
        new_dive_link = find_all('a')[5].native.inner_text
        expect(new_dive_link).to match(/新規投稿/)
      end
      it 'ログアウトが表示される' do
        signout_link = find_all('a')[7].native.inner_text
        expect(signout_link).to match(/ログアウト/)
      end
    end
  end

  describe 'ユーザログアウトのテスト' do
    let(:user) { create(:user) }

    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'ログイン'
      signout_link = find_all('a')[7].native.inner_text
      signout_link = signout_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
      click_link signout_link, match: :first
    end

    context 'ログアウト機能のテスト' do
      it '正しくログアウトできている: ログアウト後のリダイレクト先においてAbout画面へのリンクが存在する' do
        expect(page).to have_link '', href: '/about'
      end
      it 'ログアウト後のリダイレクト先が、トップページになっている' do
        expect(current_path).to eq '/'
      end
    end
  end
end
