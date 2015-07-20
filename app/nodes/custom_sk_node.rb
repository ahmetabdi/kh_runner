class CustomSKNode < SKNode
  def init
    super
  end

  def screen
    @screen ||= UIScreen.mainScreen.bounds
  end

  def min_x
    CGRectGetMinX(screen)
  end

  def min_y
    CGRectGetMinY(screen)
  end

  def mid_x
    CGRectGetMidX(screen)
  end

  def mid_y
    CGRectGetMidY(screen)
  end

  def max_x
    CGRectGetMaxX(screen)
  end

  def max_y
    CGRectGetMaxY(screen)
  end
end
