class UsersController < ApplicationController
  def index
    users = User.all

    if users.size > 0
      render json: users
    else
      render json: { error: 'no users here' }
    end
  end

  def show
    user = User.find_by(id: params[:id])

    if user
      render json: user
    else
      render json: { error: 'no such user' }
    end
  end

  def create
    user = User.find_by(email: params[:email])

    if user
      render json: { error: 'user already exists' }
    else
      render json: User.create(first_name: params[:first_name], last_name: params[:last_name], avatar_url: params[:avatar_url], email: params[:email], password: params[:password])
    end
  end

  def update
    user = User.find_by(id: params[:id])

    byebug

    if user
      user.update(avatar_url: params[:avatar_url])
      user.save
      render json: user.save
    else
      render json: { error: 'user not found' }
    end
  end

  def signin
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      render json: { id: user.id }
    else
      render json: { error: 'login failed'}, status: 400
    end
  end

  def validate
    id = request.headers['Authorization']
    user = User.find_by(id: id)

    if user
      render json: { userEmail: user.email, userId: user.id }
    else
      render json: { error: 'something bad persistence' }, status: 404
    end
  end

  def rate_movie
    user = User.find_by(id: params[:userId])
    movie = Movie.find_by(id: params[:movieId])
    rating = params[:rating]

    if user && movie
      movie_watch = MovieWatch.create_or_update(user.id, movie.id, rating)
      render json: user
    else
      render json: { error: "either user or movie not found" }
    end
  end

  def forget_movie
    movie_watch = MovieWatch.find_by(user_id: params[:userId], movie_id: params[:movieId])
    if movie_watch
      render json: movie_watch.destroy
    else
      render json: { error: "either user or movie not found" }
    end
  end

  def add_friend
    requester = User.find_by(id: params[:requesterId])
    receiver = User.find_by(id: params[:receiverId])

    if requester && receiver
      requester.request_friendship(receiver)
      render json: Friendship.last
    else
      render json: { error: "problems with people involved" }
    end    
  end

  def delete_friend
    friendship = Friendship.find_by(requester_id: params[:requesterId], receiver_id: params[:receiverId])

    if friendship
      render json: friendship.destroy
    else
      render json: { error: "something bad went down" }
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :avatar_url, :password)
  end

end
