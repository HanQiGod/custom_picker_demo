class LinkData {
  const LinkData({required this.name, this.children});

  final String name;
  final List<LinkData>? children;

  bool get hasChildren => children != null && children!.isNotEmpty;
}
