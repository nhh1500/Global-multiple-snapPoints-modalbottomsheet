import 'package:flutter/material.dart';
import 'package:global_multiple_snapheights_modalbottomsheet/multiple_snapHeights_modalbottomsheet.dart';

///example child widget
class ChildWidget extends StatelessWidget {
  final Color color;
  const ChildWidget({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (p0, p1) {
        double videoHeight = p1.maxHeight;
        double videoWidth = p1.maxHeight / 9 * 16;

        double titleHeight = p1.maxHeight;
        double titleWidth = p1.maxWidth - p1.maxHeight / 9 * 16 - 100 < 0
            ? 0
            : p1.maxWidth - p1.maxHeight / 9 * 16 - 100;
        double playButton = 50;
        double closeButton = 50;
        return Material(
          child: Container(
            color: Colors.black,
            child: Stack(
              children: [
                Positioned(
                    left: videoWidth,
                    child: Container(
                        height: titleHeight,
                        width: titleWidth,
                        child: SingleChildScrollView(
                          child: DefaultTextStyle(
                              style: TextStyle(),
                              child: Container(
                                padding: EdgeInsets.all(5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      'Create on Youtube: Video, Shorts, & Live',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      'Youtube Creators',
                                      style: TextStyle(color: Colors.grey),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    )
                                  ],
                                ),
                              )),
                        ))),
                Positioned(
                    right: titleWidth < 0 ? null : 50,
                    left: titleWidth > 0 ? null : videoWidth,
                    child: Container(
                      color: Colors.black,
                      width: playButton,
                      height: playButton,
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                          )),
                    )),
                Positioned(
                    right: videoWidth > p1.maxWidth - 50 ? null : 0,
                    left: videoWidth > p1.maxWidth - 50 ? videoWidth : null,
                    child: Container(
                      color: Colors.black,
                      width: closeButton,
                      height: closeButton,
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.close,
                            color: Colors.white,
                          )),
                    )),
                Positioned(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: videoHeight,
                      width: videoWidth,
                      constraints:
                          BoxConstraints(maxWidth: videoWidth, maxHeight: 200),
                      color: color,
                    ),
                    Expanded(
                        child: Opacity(
                      opacity: CustomBottomSheet.instance.height.value /
                          MediaQuery.of(context).size.height,
                      child: SingleChildScrollView(
                        primary: true,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          color: Colors.black,
                          child: DefaultTextStyle(
                              style: TextStyle(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Create on Youtube: Video, Shorts, & Live',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Row(
                                    children: const [
                                      Text('253K views'),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text('2 months ago')
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        height: 35,
                                        width: 35,
                                        child: Image.network(
                                            'https://cdn-icons-png.flaticon.com/512/3670/3670147.png'),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Text(
                                        'Youtube Creators',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const Spacer(),
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          18)),
                                              backgroundColor: Colors.white),
                                          onPressed: () {},
                                          child: const Text(
                                            'Subscribe',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ))
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 28,
                                          child: Row(
                                            children: [
                                              ElevatedButton.icon(
                                                  style: ElevatedButton.styleFrom(
                                                      shape: const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          18),
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          18))),
                                                      backgroundColor:
                                                          Colors.grey[800]),
                                                  onPressed: () {},
                                                  icon: const Icon(
                                                    Icons.thumb_up,
                                                    size: 15,
                                                  ),
                                                  label: const Text(
                                                    '12K',
                                                    style:
                                                        TextStyle(fontSize: 13),
                                                  )),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    padding: EdgeInsets.zero,
                                                    minimumSize:
                                                        const Size(47, 28),
                                                    shape: const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        18),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        18))),
                                                    backgroundColor:
                                                        Colors.grey[800]),
                                                onPressed: () {},
                                                child: const Icon(
                                                    Icons.thumb_down,
                                                    size: 15),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              ElevatedButton.icon(
                                                onPressed: () {},
                                                style: ElevatedButton.styleFrom(
                                                    shape: const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    18))),
                                                    backgroundColor:
                                                        Colors.grey[800]),
                                                icon: const Icon(
                                                  Icons.share,
                                                  size: 15,
                                                ),
                                                label: const Text(
                                                  'Share',
                                                  style:
                                                      TextStyle(fontSize: 13),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              ElevatedButton.icon(
                                                onPressed: () {},
                                                style: ElevatedButton.styleFrom(
                                                    shape: const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    18))),
                                                    backgroundColor:
                                                        Colors.grey[800]),
                                                icon: Icon(
                                                  Icons.download,
                                                  size: 15,
                                                ),
                                                label: Text(
                                                  'Download',
                                                  style:
                                                      TextStyle(fontSize: 13),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              ElevatedButton.icon(
                                                onPressed: () {},
                                                style: ElevatedButton.styleFrom(
                                                    shape: const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    18))),
                                                    backgroundColor:
                                                        Colors.grey[800]),
                                                icon: Icon(
                                                  Icons.cut,
                                                  size: 15,
                                                ),
                                                label: Text(
                                                  'Clip',
                                                  style:
                                                      TextStyle(fontSize: 13),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    height: 40,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: Colors.grey[800],
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: const [
                                            Text(
                                              'Comments',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              '1.7K',
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    height: 180,
                                    width: double.infinity,
                                    color: Colors.blue,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    height: 180,
                                    width: double.infinity,
                                    color: Colors.blue,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    height: 180,
                                    width: double.infinity,
                                    color: Colors.blue,
                                  )
                                ],
                              )),
                        ),
                      ),
                    ))
                  ],
                )),
              ],
            ),
          ),
        );
      },
    );
  }
}
