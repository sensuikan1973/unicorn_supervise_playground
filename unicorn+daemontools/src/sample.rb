class Sample
  def call(env)
     [
      200,
      { 'Content-Type' => 'text/html' },
      ['ok'],
    ]
  end
end
