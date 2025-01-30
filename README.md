# BIT-Typst-Template

## master-report-template

### 项目简介
寒假期间闲着无聊搓的非官方 BIT 本科毕业设计（论文）模板，基于 [关于开展2024年本科毕业设计（论文）检测、评阅、抽检及答辩相关工作的通知
](https://jwb.bit.edu.cn//tzgg/026420854e704c86a2790948f6dc7034.htm)中附件的 word 模板改编而来。

> [!CAUTION]
> 本人不保证该模板符合学校要求，使用该模板需自行检查是否符合学校要求。 <br>
> 本人并非往届毕业生，就读大二，对毕业设计一无所知，只是闲着无聊搓的模板，不保证模板的正确性。 <br>
> 调整格式的部分大多数采用叠加透明图片微调参数，没有理论支撑（理论支撑是：word 和 typst 的排版模型不同，没法相提并论）。

### 使用方法

#### 下载 typst

1. [github release](https://github.com/typst/typst/releases)
2. 包管理器
    ```sh
    choco install typst
    winget install typst
    ...

    ```

#### 使用模板

将项目下载到本地，使用 `vscode` 与 [`Tinymist`](https://Myriad-Dreamin.github.io/tinymist) 插件打开，可以类似于用 [`main.typ`](https://github.com/Ri-Nai/BIT-Typst-Template/blob/main/master-report-template/main.typ) 的格式进行写作。

即：

```typst
#import "template.typ": paper
#import "utils/three-line-table.typ": three-line-table
#import "pages/supplementary.typ": *

#show paper.with(
    ...
)

... // 你的正文内容

#references("./ref.bib")

#appendices()[]

#acknowledgements()[]

```

### 目前存在的问题

### 参考和致谢

- 感谢 [Typst](https://github.com/typst/typst) ...
- 感谢 [Tinymist](https://github.com/Myriad-Dreamin/tinymist) 是一个 vscode 插件，对我使用 typst 有很大的帮助。
- 感谢 [BIThesis](https://bithesis.bitnp.net/) 项目及其维护者。尽管看不太懂 $\LaTeX$ 没法有多大参考 ，但前人的工作给了我很大的启发和动力。
- 感谢 [HUST-typst-template](https://github.com/werifu/HUST-typst-template/) 项目及其维护者。该项目给了我很大的参考，使我能够更快地完成模板的制作。
  - 同时我寒假期间也在使用该模板写了数据结构的研学报告，感谢该模板的维护者。
- 

## slides-template

是我寒假制作 [数据结构-研学报告](https://github.com/Ri-Nai/BIT-Lexue-Code/blob/main/Data-Structure/Research-Report/1120231313-%E6%B1%87%E6%8A%A5.typ) 时使用的 slides 模板，基于 [touying-buaa](https://github.com/Coekjan/touying-buaa)

欢迎大家去给原作者的项目点个 star，支持一下。
