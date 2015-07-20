class GameBounds < CustomSKNode
  def init
    super.tap do
      self.zPosition = -5
      self.name = 'game_bound'

      self.position = CGPointMake(max_x / 2, max_y / 2)
      self.physicsBody = SKPhysicsBody.bodyWithRectangleOfSize(CGSizeMake(max_x, max_y))
      self.physicsBody.dynamic = false

      self
    end
  end
end


