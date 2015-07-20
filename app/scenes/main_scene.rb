class MainScene < SKScene
  WORLD = 0x1 << 1
  SUPER_JUMPS = 3
  PLAYER_DEFAULT_JUMP_HEIGHT = 15

  def didMoveToView(view)
    super

    physicsWorld.gravity = CGVectorMake(0.0, -5.0)
    physicsWorld.contactDelegate = self

    # add_skyline
    # addChild(emitter(mid_x, max_y))
    # addChild GameBounds.alloc.init

    add_ground
    add_player

    addChild pauseLabel
    addChild obstacleLabel
    # begin_spawning_pipes
  end

  def pauseLabel
    @pauseLabel ||= SKLabelNode.labelNodeWithFontNamed('Chalkduster').tap do |label|
      label.text = 'Pause'
      label.position = CGPointMake(80, 500)
      label.name = 'pause'
    end
  end

  def add_skyline
    texture = SKTexture.textureWithImageNamed 'skyline.png'

    2.times do |i|
      x_position = mid_x + (i * mid_x * 2)
      skyline = SKSpriteNode.spriteNodeWithTexture(texture)
      skyline.position = CGPointMake(x_position, mid_y)
      skyline.name = "skyline"
      skyline.zPosition = -20
      # skyline.runAction scroll_action(mid_x, 0.1)

      addChild skyline
    end
  end

  def move_background
    self.enumerateChildNodesWithName "skyline", usingBlock: -> (node, stop) {
      velocity = CGPointMake(-20, 0)
      movement_amount = CGPointMake(velocity.x * @delta, velocity.y * @delta)
      node.position = CGPointMake(node.position.x + movement_amount.x, node.position.y + movement_amount.y)

      if node.position.x <= -node.size.width / 2
        node.position = CGPointMake((node.position.x + node.size.width) * 2, node.position.y)
      end
    }
  end

  def add_ground
    texture = SKTexture.textureWithImageNamed('top.png')
    width = mid_x + 7

    2.times do |i|
      ground = SKSpriteNode.spriteNodeWithTexture(texture)
      # ground.position = CGPointMake(width + (i * width * 2), 56)
      ground.position = CGPointMake(width + (i * width * 2), 74)
      ground.runAction scroll_action(width, 0.02)
      ground.zPosition = 2

      addChild ground
    end

    addChild PhysicalGround.alloc.init
  end

  def add_player
    addChild Player.alloc.init
  end

  def begin_spawning_pipes
    pipes = SKAction.performSelector('add_pipes', onTarget: self)
    delay = SKAction.waitForDuration(4.0)
    sequence = SKAction.sequence([pipes, delay])

    runAction SKAction.repeatActionForever(sequence)
  end

  def add_pipes
    addChild PipePair.alloc.init
  end

  # This action is used for both the ground and sky.
  def scroll_action(x, duration)
    width = (x * 2)
    move = SKAction.moveByX(-width, y: 0, duration: duration * width)
    reset = SKAction.moveByX(width, y: 0, duration: 0)

    SKAction.repeatActionForever(SKAction.sequence([move, reset]))
  end

  def update(current_time)
    @delta = @last_update_time ?  current_time - @last_update_time : 0
    @last_update_time = current_time

    # check_controller
    move_background
    # rotate_player
  end


  def touchesBegan(touches, withEvent: event)
    puts 'touchesBegan'

    touch = touches.anyObject
    location = touch.locationInNode(self)
    node = nodeAtPoint(location)
    puts node.name

    if node.name == 'pause'
      if self.isPaused
        self.paused = false
      else
        self.paused = true
      end
    elsif node.name == 'player'
      player_jump(30)
    else
      player_jump
    end
  end

  def player_jump(impulse = 0)
    player = childNodeWithName('player')
    # return if player.position.y > 130

    # player.runAction(player.jump)
    player.physicsBody.velocity = CGVectorMake(0, 0)
    player.physicsBody.applyImpulse CGVectorMake(0, PLAYER_DEFAULT_JUMP_HEIGHT + impulse)
  end

  def rotate_player
    node = childNodeWithName('player')
    dy = node.physicsBody.velocity.dy
    node.zRotation = max_rotate(dy * (dy < 0 ? 0.003 : 0.001))
  end

  def max_rotate(value)
    if value > 0.7
      0.7
    elsif value < -0.3
      -0.3
    else
      value
    end
  end

  def didBeginContact(contact)
    if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask
      player = contact.bodyA
      if player.categoryBitMask == Player::PLAYER
        puts "Tocuhing the pipe #{player} #{player.node}"
        # player.node.zRotation = 0
        # player.node.position = CGPointMake(80, CGRectGetMidY(self.frame))
        # enumerateChildNodesWithName 'pipes', usingBlock:-> (node, stop) { node.removeFromParent }
      end
    else
      puts 'Touching the ground'
      player = contact.bodyB
    end

    puts contact.bodyA
    puts contact.bodyB
  end

  def min_x
    CGRectGetMinX(self.frame)
  end

  def min_y
    CGRectGetMinY(self.frame)
  end

  def mid_x
    CGRectGetMidX(self.frame)
  end

  def mid_y
    CGRectGetMidY(self.frame)
  end

  def max_x
    CGRectGetMaxX(self.frame)
  end

  def max_y
    CGRectGetMaxY(self.frame)
  end
end
