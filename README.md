# Orange-Book-Type

## 模板介绍

Orange-Book-Type是为撰写简易笔记而设计的Typst模板，修改自flavio20002制作的typst模板 [typst-orange-template](https://github.com/flavio20002/typst-orange-template)，原项目灵感来源于Mathias Legrand创作的latex模板 [The Legrand Orange Book](https://www.latextemplates.com/template/legrand-orange-book)，有问题欢迎提交 Issue。

相比先前的模板，该模板增加了前言页（可以关闭），修改了页码的显示效果（前言页和目录页页码样式为罗马数字，正文页页码样式为阿拉伯数字），修正了字体效果（页眉和一级标题采用了无衬线字体，正文采用衬线字体，优化了中文字符的粗体显示），修改了段落效果（增加首行缩进）,优化了链接的显示（所有字符都已支持），但索引未做修改（不能按照拼音或者笔划顺序整理中文）

## 使用方法

> [!编译信息]
>
> 此模板需要使用 Typst 0.12.0 及以上版本进行编译。

页面右边点击：**Clone or download -> Download Zip**，将模板文件下载到本地并解压

### 文件结构

模板文件夹内主要包含以下部分：

- main.typ 主文件
- refs.bib 参考文献
- /lib/template.typ 文档格式控制，包括一些基础的设置、函数
- /lib/fonts.typ 字体设置
- /lib/my-index.typ 索引生成函数
- /lib/my-outline.typ 目录生成函数
- /lib/theorems.typ 公式环境生成函数
- /content 内容文件夹，存放各个章节
- /fig 图片文件夹

### 具体使用

使用模板首先需配置 `main.typ`，设置标题、描述、作者等信息，然后就可以在 `/content` 增补文件开始编写文档。如果要增加图像可以放在 `/fig` 文件夹内。如需要进一步更改文档格式，请修改 `/lib`文件夹内部的文件。

> [!CAUTION]
>
>如果要将文档拆分为多个文件进行组织，需要将 `#import "../template.typ": *` 添加到每个文件的顶部，以使某些函数（例如 `blockquote()`）正常工作。
>
> 例如，假设你在项目根目录下有一个 `./content/chapter.typ` 文件和一个 `./template.typ` 文件，那么你需要在 `chapter.typ` 文件顶部添加 `#import "../template.typ": *`。
