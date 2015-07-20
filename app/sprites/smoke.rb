class Smoke < SKSpriteNode
  SMOKE = 0x1 << 0

  def init(position)
    self.initWithImageNamed("bird_one.png")
    self.position = position
    self.scale = 1
    self.name = 'smoke'
    self.runAction puff
    self
  end

  def puff
    animations = [].tap do |array|
      24.times do |i|
        array << SKTexture.textureWithImageNamed("puff/whitePuff#{i + 1}.png")
      end
    end
    animation_action = SKAction.animateWithTextures(animations, timePerFrame: 0.05)
    remove_action = SKAction.removeFromParent

    sequence = SKAction.sequence([animation_action, remove_action])
    SKAction.repeatAction(sequence, count: 1)
  end

end
