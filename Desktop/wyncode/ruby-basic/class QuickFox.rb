class QuickFox
  p self
	def jumped_over thing1, thing2
    p self
	end
end

def whatami
  p self
end

whatami

quick_fox = QuickFox.new
lazy_dog, daisy_log = nil
quick_fox.jumped_over(lazy_dog, daisy_log)

p self.class
