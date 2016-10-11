class PhysicalGround < SKNode
  HEIGHT = 112.0

  def init
    super
    screen = UIScreen.mainScreen.bounds

    self.position = CGPointMake(screen.size.width / 2, 38)
    self.physicsBody = SKPhysicsBody.bodyWithRectangleOfSize(CGSizeMake(screen.size.width, HEIGHT))
    self.physicsBody.categoryBitMask = MainScene::WORLD
    self.physicsBody.dynamic = false
    self
  end

  def collisionWithPlayer(player)
    player.physicsBody.dynamic = false
  end
end
