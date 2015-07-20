class GameViewController < UIViewController
  def loadView
    self.view = skView
  end

  def skView
    @skView ||= SKView.new.tap do |view|
      view.showsFPS = true
      view.showsNodeCount = true
      view.showsDrawCount = true
      view.showsPhysics = true
      view.showsFields = true
    end
  end

  def prefersStatusBarHidden
    true
  end

  def viewWillLayoutSubviews
    super

    unless self.view.scene
      scene = MainScene.alloc.initWithSize(view.bounds.size)
      scene.scaleMode = SKSceneScaleModeAspectFill
      view.presentScene scene
    end
  end
end
