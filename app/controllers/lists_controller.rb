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
    redirect_to '/top'
  end
  
  def index
  end

  def show
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
