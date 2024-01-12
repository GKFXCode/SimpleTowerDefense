### github使用
1.登录/注册`github.com`，fork这个项目：`https://github.com/GKFXCode/SimpleTowerDefense`
2.将fork后的项目clone到本地
```bash
git clone [项目地址]
```
3.在`github.com`网站上生成Token
点击github右上角头像，点击settings，然后点击左侧导航栏最下方的Developer Settings，然后点击Personal Access Tokens，然后点击Generate new token，选择仓库的读写权限后点击Generate。
参考:`https://blog.csdn.net/chengwenyang/article/details/120060010`
4.`git remote remove origin`
删除现在的远程分支，然后利用Token创建新的远程分支
`git remote add origin https://[TOKEN]@github.com/[username]/[repo_name]`
5.编写代码并测试
6.将代码同步到fork得到的github仓库中
```bash
git add [文件]
git commit -m '简洁地描述修改了哪些内容'
# 如果修改内容较多，可以按修改的内容分多次add和commit
git push origin master
```
7.在fork的项目网页上方发起PR，将代码同步到原项目仓库`https://github.com/GKFXCode/SimpleTowerDefense`中

### SimpleTowerDefence
本项目基于`https://youtu.be/wFdpCGbrVXI?si=X3R6MtIzSUmiK2ul`修改。原作者制作了一部分教程后弃坑了 : ( 。

游戏的主场景是`Game.tscn`。
`GameScene.tscn`控制关卡的切换，敌人生成等游戏逻辑。
`Map.tscn`是所有地图的基类。
`Enemy.tscn`是所有敌人的基类。
`Tower.tscn`是所有防御塔的基类。
如`Tower.tscn`中所示，防御塔由底座(Base)，炮塔(Turrent)组成，攻击范围(Range), 动画(AnimationPlayer)组成。
Tower的攻击力等数据保存在`GameData.gd`中，这是一个自动加载脚本，因此你可以在任何位置获取其中的数据。
制作动画和图标所需的素材保存在`Assets`

#### MissileT1
当作用范围内存在敌人时，以固定的频率进行攻击。
向距离最近的目标发射一枚**追踪**导弹，导弹命中任意敌人后爆炸，造成**单体伤害**。如果瞄准的目标死亡或消失，导弹原地爆炸。
#### BombT1
当作用范围内存在敌人时，以固定的频率进行攻击。
向距离最近的**目标位置**发射一枚炸弹，炸弹到达后立即爆炸，对爆炸范围内的**所有敌人**造成固定伤害。
#### IceT1
当作用范围内存在敌人时，以固定的频率进行攻击。
让作用范围内的**所有敌人**进入冰冻(frozen)状态，使其速度下降。离开作用范围一定时间后敌人速度恢复。
提示：可以用`Timer`计时
#### FlamthrowerT1
向距离最近的目标发射火焰，让对象进入点燃(ignited)状态，每秒扣除固定血量。状态持续固定时间后消失。
#### SummoningT1
召唤一块岩石，沿着敌人路径**反向**运动，对碰撞到的敌人造成固定伤害。到达起点后消失。

提示：
- 使用Godot版本为3.5.3
- 原有内容中只需要修改`[tower_name].tscn`,`[tower_name].gd`,`enemy.gd`，如果需要修改其他位置(修改bug等)，需要单独提PR
- 多人同时修改`enemy.gd`会造成代码合并冲突，需要手动处理。为了尽可能避免冲突，请及时`git pull`
- 可以按需要自由新建场景和代码(放在对应的文件夹中)
- 新增的动画素材按分类保存到Assets文件夹中