class ListsController < ApplicationController
  def new
    #Viewへ渡すためのインスタンス変数に空のModelオブジェクトを生成する。
    @list = List.new
  end

# redirect_to はHTTPメソッドとURLをルーティングに渡し、ルーターはどのコントローラのどのアクションを実行するか決める。
# 一方で、renderは表示させてるHTMLが入れ替わるのみ。
# 違いは「新たにアクションを実行するか否か」
# この場合、createアクション内のrender :new によってnewアクションが呼び出されることはないということ
# 逆に、redirect_to "lists/new"にしてしまうと,インスタンス変数の情報がなくなってしまう。
  def create
    # 1. データを受け取り、受け取ったデータを元にインスタンスを作成する。
    @list = List.new(list_params)
    # 2. データをデータベースに保存するためのsaveメソッド実行
    if @list.save
      redirect_to list_path(@list.id)
    # 3. トップ画面へのリダイレクト
    else
      ## ビュー内のインスタンス変数は、そのビューを呼び出したアクション内で用意されたインスタンス変数を参照します。
      ## だからrender :indexじゃ@listsの変数がないよってエラーが出る,なぜなら、createアクション内に@lists変数がないため。
      ## エラーメッセージを扱う際にはrender、それ以外はredirect_toを使う
      # render :index
      render :new
      ## 下記のようにnewアクションをredirect_to でしてしまうとnewアクション内で再度@list=List.newが実行されエラーログがインスタンス変数からない状態になってしまう。
      #redirect_to "/lists/new"
    end
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

# show や edit ではparams[:id]とやってるのは指定しているから。
# createやupdateでlist_paramsにしているのは、受け取るのは全部のデータだから、悪意のあるデータも受け取ってしまう。
# だから、全部のデータを受け取るものに関してはprivate でまとめて指定している。

  def show
     @list = List.find(params[:id])
  end

  def edit
    @list = List.find(params[:id])
  end

  def update
    list = List.find(params[:id])
    list.update(list_params)
    redirect_to list_path(list.id)
  end

  def destroy
    list = List.find(params[:id])
    list.destroy
    redirect_to '/lists'
  end

  private
  # ストロングパラメータ
  # privateより後に定義されたメソッドは、アクションとして認識されなくなり、URLと対応できなくなります。
  def list_params
    params.require(:list).permit(:title, :body, :image)
  end
end
