class Pipe < SKSpriteNode
  def init(texture)
    self.initWithImageNamed(texture)
    self.physicsBody = SKPhysicsBody.bodyWithRectangleOfSize(size)
    self.physicsBody.collisionBitMask = 0
    self.physicsBody.friction = 0.0
    self.physicsBody.dynamic = false
    self
  end

  def collisionWithPlayer(player)
    # Only stop the player if he's falling onto the block
    # if (player.physicsBody.velocity.dy < 0)
    #   puts 'Should be falling!'
    #   player.physicsBody.dynamic = false
    # else

    # end
  end
end
