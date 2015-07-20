class FireEmitter < SKNode

  def init
    super
    self.position = CGPointMake(0, 0)
    self.zPosition = 1
    self.name = 'fire'
    self.addChild(emitter)
    self
  end

  def emitter
    @emitter ||= NSKeyedUnarchiver.unarchiveObjectWithFile(NSBundle.mainBundle.pathForResource('fire/fire', ofType:"sks")).tap do |emitter|
      emitter.numParticlesToEmit = 0
      emitter.particleTexture = SKTexture.textureWithImageNamed 'fire/Spark.png'
    end
  end
end
