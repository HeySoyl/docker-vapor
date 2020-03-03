# Docker Vapor

## 启动Vapor容器

```
docker run --name=vapor-dev \
    -v /tmp/vapor/HelloWorld:/var/www/HelloWorld \
    -p 8081:8080 \
    -it \
    -w /var/www/HelloWorld \
    soyl/vapor:0.1.1 \
    bash
```

这里，要注意几个事情：

1. --name=vapor-dev用于设置Vapor容器的名称，我们可以把这个名称理解为是主机名，之前这个名称都是Docker随机生成的，这里之所以要明确指定，是因为稍后，Nginx要通过这个名字，找到Vapor容器；
2. 我们需要Vapor容器的一个终端，因为为此修改了代码之后，Vapor需要重新编译执行，因此我们使用了-it，并且执行了bash；
3. 我们需要在Host映射一个端口号方便我们连接Nginx之前进行调试，因此，我们使用了-p 8081:8080；
4. 我们使用-v把Host上的源代码目录直接映射到了容器内部；
5. 我们使用-w把容器内Shell的working directory设置成了/var/www/HelloWorld，这样，docker run就会直接进入到这个目录；

如果一切顺利，我们就应该进入到这个Vapor容器的Shell了，执行下面的命令编译执行：

```
# Under /var/www/HelloWorld directory
vapor build && vapor run --hostname=0.0.0.0 --port=8080
```

这里要特别注意的就是vapor run的参数，如果在Host上执行，直接vapor run就好了，但是在容器里执行，我们必须使用--hostname=0.0.0.0参数，否则无法在容器外访问Vapor服务。至于--port则用于自定义端口号，大家可以根据自己的需要使用，它不是必须的。

这时，在Host上打开Safari，访问http://localhost:8081/hello，就可以看到Hello, world!的结果了。

并且，之后，只要我们在Host上修改了Vapor源代码，只要回到这个容器终端，重新build and run就好了。

### 把Nginx容器连接到Vapor

```
docker run --link=vapor-dev:vapor -p 80:80 -it --rm soyl/nginx:0.1.2
```

直接访问http://localhost/hello
