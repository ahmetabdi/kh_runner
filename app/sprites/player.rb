class Player < SKSpriteNode
  PLAYER = 0x1 << 0

  def init
    self.initWithImageNamed("sora/run_0.png")
    self.physicsBody = physics_body
    self.position = CGPointMake(80, 400)
    self.scale = 1.25
    self.name = 'player'
    self.runAction run
    self
  end

  ['run', 'intro', 'attack_1', 'attack_2', 'attack_3'].each do |action|
    define_method(action) do
      animations = [].tap do |array|
        frame_lookup(action).times do |i|
          array << SKTexture.textureWithImageNamed("sora/#{action}_#{i}.png")
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

  def frame_lookup(action)
    case action
    when 'run' then 8
    when 'intro' then 17
    when 'attack_1' then 4
    when 'attack_2'then 5
    when 'attack_3' then 7
    else raise "Unknown frame_lookup for action: #{action}"
    end
  end

  def physics_body
    @physics_body ||= SKPhysicsBody.bodyWithRectangleOfSize([size.width / 2, size.height]).tap do |body|
      body.friction = 0.0
      body.angularDamping = 0.0
      body.linearDamping = 0.0
      # body.restitution = 1.0
      body.categoryBitMask = PLAYER
      body.contactTestBitMask = MainScene::WORLD
      body.usesPreciseCollisionDetection = true
      # body.collisionBitMask = 0 # Simulate any collisions ourself
      body.allowsRotation = false # Default: true
      body.dynamic = true
    end
  end
end
