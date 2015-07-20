class PhysicalGround < SKNode
  def init
    super

    screen = UIScreen.mainScreen.bounds

    self.position = CGPointMake(screen.size.width / 2, 38)
    self.physicsBody = SKPhysicsBody.bodyWithRectangleOfSize(CGSizeMake(screen.size.width, 112))
    self.physicsBody.categoryBitMask = MainScene::WORLD
    self.physicsBody.dynamic = false
    self
  end
end
