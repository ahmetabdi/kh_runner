class PipePair < SKNode
  def init
    super

    self.position = CGPointMake(400, 0)
    self.zPosition = -10
    self.name = 'pipes'
    self.addChild(top)
    # self.addChild(bottom)
    self.runAction(move_and_remove)
    self
  end

  def top
    pipe_up = Pipe.alloc.init('platform.png')
    pipe_up.position = CGPointMake(0, max_x - random_y)
    pipe_up
  end

  # def bottom
  #   pipe_down = Pipe.alloc.init('platform.png')
  #   pipe_down.position = CGPointMake(0, random_y)
  #   pipe_down
  # end

  def random_y
    @y ||= Random.new.rand (min_y + 150)..(max_y - 150)
  end

  def min_y
    CGRectGetMinY(self.frame)
  end

  def max_x
    CGRectGetMaxX(self.frame)
  end

  def move_and_remove
    distance = 520
    move_pipes = SKAction.moveByX(-distance, y: 0, duration: 0.02 * distance)
    remove_pipes = SKAction.removeFromParent

    SKAction.sequence([move_pipes, remove_pipes])
  end
end
