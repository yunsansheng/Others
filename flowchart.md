# mermaid

- graph LR 横向图
- graph TD 竖向图

```
​``` mermaid
    graph LR
    A[方形] -->B(圆角)
        B --> C{条件a}
            C -->|a=1| D[结果1]
            C -->|a=2| E[结果2]

    F[横向流程图]
​```
```

```mermaid
graph LR
A[方形] -->B(圆角)
	B --> C{条件a}
		C -->|a=1| D[结果1]
		C -->|a=2| E[结果2]

F[横向流程图]
```

# 标准流程图源码格式

```flow

st=>start: 开始框
op=>operation: 处理框
cond=>condition: 判断框(是或否?)
sub1=>subroutine: 子流程
io=>inputoutput: 输入输出框
ends=>end: end 

st->op->cond->
cond(yes)->io->ends
cond(no)->sub1(right)->op

```

```flow

st=>start: 开始框

op=>operation: 处理框

cond=>condition: 判断框(是或否?)

sub1=>subroutine: 子流程

io=>inputoutput: 输入输出框

e=>end: 结束框

st(right)->op(right)->cond
cond(yes)->io(bottom)->e
cond(no)->sub1(right)->op

```

```mermaid

%% 语法示例

        gantt

        dateFormat  YYYY-MM-DD

        title 软件开发甘特图

        section 设计

        需求                      :done,    des1, 2014-01-06,2014-01-08

        原型                      :active,  des2, 2014-01-09, 3d

        UI设计                     :         des3, after des2, 5d

   	未来任务                     :         des4, after des3, 5d

        section 开发

        学习准备理解需求                      :crit, done, 2014-01-06,24h

        设计框架                             :crit, done, after des2, 2d

        开发                                 :crit, active, 3d

        未来任务                              :crit, 5d

        耍                                   :2d

    

        section 测试

        功能测试                              :active, a1, after des3, 3d

        压力测试                               :after a1  , 20h

        测试报告                               : 48h

```