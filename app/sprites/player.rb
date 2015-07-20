class Player < SKSpriteNode
  PLAYER = 0x1 << 0

  def init
    self.initWithImageNamed("bird_one.png")
    self.physicsBody = physics_body
    self.position = CGPointMake(80, 400)
    self.scale = 2.5
    self.name = 'player'
    self.runAction run
    self
  end

  #['idle', 'jump', 'run'].each do |action|
  ['run'].each do |action|
    define_method(action) do
      animations = [].tap do |array|
        8.times do |i|
          array << SKTexture.textureWithImageNamed("sora/#{action}_#{i + 1}.png")
        end
      end
      animation = SKAction.animateWithTextures(animations, timePerFrame: 0.10)
      if action == 'run'
        SKAction.repeatActionForever(animation)
      else
        SKAction.repeatAction(animation, count: 1)
      end
    end
  end

  def physics_body
    @physics_body ||= SKPhysicsBody.bodyWithRectangleOfSize(size).tap do |body|
      body.friction = 0.0
      body.categoryBitMask = PLAYER
      body.contactTestBitMask = MainScene::WORLD
      body.usesPreciseCollisionDetection = true
    end
  end
end
