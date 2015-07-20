class RainEmitter < SKNode

  def initWithXY(x, y)
    init.tap do
      self.position = CGPointMake(x, y)
      self.zPosition = 1
      self.name = 'rain'
      self.addChild(emitter)
    end
  end

  def emitter
    @emitter ||= NSKeyedUnarchiver.unarchiveObjectWithFile(NSBundle.mainBundle.pathForResource("rain/Stars", ofType:"sks")).tap do |emitter|
      emitter.numParticlesToEmit = 0
      emitter.particleTexture = SKTexture.textureWithImageNamed 'rain/Stars.png'
    end
  end
end
