class Jekyll::Post

  def titleized_slug
    self.slug.split(/[_-]/).join(' ')
  end
end
