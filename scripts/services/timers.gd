
var bag
var container

func _init_bag(bag, container):
    self.bag = bag
    self.container = container

func set_timeout(timeout, object, method, args=[]):
    var timer = Timer.new()
    timer.set_wait_time(timeout)
    timer.set_one_shot(true)
    timer.connect("timeout", self, "execute_timeout", [object, method, args, timer])
    self.container.add_child(timer)
    timer.start()

func execute_timeout(object, method, args, timer):
    self.container.remove_child(timer)
    timer.queue_free()
    if args.size() > 0:
        object.call(method, args)
    else:
        object.call(method)
