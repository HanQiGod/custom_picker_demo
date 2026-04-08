import '../models/link_data.dart';

List<LinkData> buildCategoryData() {
  return const <LinkData>[
    LinkData(
      name: '电子产品',
      children: <LinkData>[
        LinkData(
          name: '手机通讯',
          children: <LinkData>[
            LinkData(name: '智能手机'),
            LinkData(name: '卫星电话'),
            LinkData(name: '对讲机'),
          ],
        ),
        LinkData(
          name: '电脑办公',
          children: <LinkData>[
            LinkData(name: '笔记本电脑'),
            LinkData(name: '台式电脑'),
            LinkData(name: '显示器'),
          ],
        ),
        LinkData(
          name: '影音娱乐',
          children: <LinkData>[
            LinkData(name: '投影仪'),
            LinkData(name: '蓝牙音箱'),
            LinkData(name: '游戏主机'),
          ],
        ),
      ],
    ),
    LinkData(
      name: '服装服饰',
      children: <LinkData>[
        LinkData(
          name: '男装',
          children: <LinkData>[
            LinkData(name: '上衣'),
            LinkData(name: '裤子'),
            LinkData(name: '外套'),
          ],
        ),
        LinkData(
          name: '女装',
          children: <LinkData>[
            LinkData(name: '连衣裙'),
            LinkData(name: '半身裙'),
            LinkData(name: '针织衫'),
          ],
        ),
      ],
    ),
    LinkData(
      name: '家居生活',
      children: <LinkData>[
        LinkData(
          name: '厨房用品',
          children: <LinkData>[
            LinkData(name: '锅具'),
            LinkData(name: '餐具'),
            LinkData(name: '收纳盒'),
          ],
        ),
        LinkData(
          name: '卧室家纺',
          children: <LinkData>[
            LinkData(name: '床上四件套'),
            LinkData(name: '记忆枕'),
            LinkData(name: '毛毯'),
          ],
        ),
      ],
    ),
  ];
}
