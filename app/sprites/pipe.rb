class Pipe < SKSpriteNode
  def init(texture)
    self.initWithImageNamed(texture)
    self.physicsBody = SKPhysicsBody.bodyWithRectangleOfSize(size)
    self.physicsBody.categoryBitMask = MainScene::WORLD
    self.physicsBody.collisionBitMask = 0
    self.physicsBody.friction = 0.0
    self.physicsBody.dynamic = false
    self
  end
end
