module ErrorHandling
  def processing_runtime_error
    yield
  rescue RuntimeError => error
      puts error
      retry
  end
end





