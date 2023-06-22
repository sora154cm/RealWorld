module Api
  class ArticlesController < ApplicationController

    def create
      @article = Article.new(article_params)
      # slugの値をtitleの値をURL形式に変換
      @article.slug = @article.title.parameterize
      # 処理結果によりrenderでレスポンスの内容を設定
      if @article.save 
        #テーブルにある情報(カラム)はid以外全て返す
        render json: { article: @article.slice(:slug, :title, :description, :body, :created_at, :updated_at)}
      else
        # errorsのキーに対して、@article.errors.full_messagesの内容を配列で設定
        # バリデーションエラーを示すようなステータスコードを設定
        render json: { errors: @article.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def show
      @article = Article.find_by_slug(params[:slug])
      if @article
        render json: { article: @article.slice(:slug, :title, :description, :body, :created_at, :updated_at)}
      else
        # エラーメッセージと共に404ステータスコードを返す
        render json: { error: "Article not found" }, status: :not_found
      end
      
    end

    def update
      @article = Article.find_by_slug(params[:slug])
      if @article.update(article_params)
        render json: { article: @article.slice(:slug, :title, :description, :body, :created_at, :updated_at)}
      else
        render json: { errors: @article.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def destroy
      @article = Article.find_by_slug(params[:slug])
      # nil(指定したslugに対応する記事が存在しない場合）であった時はステータスコード404と共にエラーメッセージを返す
      if @article.nil?
        render json: { error: "Article not found" }, status: :not_found
      # 記事が存在する場合には記事の削除
      elsif @article.destroy
        # 削除したデータを返すようなレンダリングは行わない
        head :no_content
      else
        # 削除操作の失敗を通知するためのメッセージとステータスコードを設定
        render json: { error: "Failed to delete article" }, status: :unprocessable_entity
      end
    end
    
    private
  
    def article_params
      params.require(:article).permit(:slug, :title, :description, :body)
    end
  
  end
end

