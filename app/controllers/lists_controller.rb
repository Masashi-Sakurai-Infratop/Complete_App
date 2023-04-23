class ListsController < ApplicationController
  def new
    #Viewへ渡すためのインスタンス変数に空のModelオブジェクトを生成する。
    @list = List.new
  end

  def create
    # 1. データを受け取り、受け取ったデータを元にインスタンスを作成する。
    list = List.new(list_params)
    # 2. データをデータベースに保存するためのsaveメソッド実行
    list.save
    # 3. トップ画面へのリダイレクト
    redirect_to list_path(list.id)
  end

  def index
    # あらかじめControllerのアクションでインスタンス変数を指定しておくことで、viewファイル上でインスタンス変数に格納された情報を表示させることができます。
    # コントローラーとモデルとデータベースの関係を思いだして、データベースをいじるのはモデルだからここでList.all(モデル名.all)としている。
    # コントローラーがモデルの操作をするときは、モデル名.all にする。決してモデル名にｓをつけたりしない。上のcreateやnewでも同様。
    # モデルからインスタンスを生成した時のインスタンス名は時と場合による。小文字始まりは絶対。クラスは大文字始まり。インスタンスは小文字始まり。
    # 複数形のｓをつけるか否かはそのインスタンス（オブジェクト）が単体か複数かで考える。
    # 上のcreateアクションの場合は単体だからlistになってる。一方でこのindexアクションではレコードが複数だからlistsになってる。
    @lists = List.all
  end

  def show
    @list = List.find(params[:id])
  end

  def edit
  end

  private
  # ストロングパラメータ
  # privateより後に定義されたメソッドは、アクションとして認識されなくなり、URLと対応できなくなります。
  def list_params
    params.require(:list).permit(:title, :body)
  end
end
