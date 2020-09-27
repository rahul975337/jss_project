import 'package:flutter/material.dart';
import 'package:jss_project/constants/constants.dart';
import 'package:jss_project/screens/loggedIn/profile/profileScreen.dart';
import 'package:page_transition/page_transition.dart';

class Timeline extends StatelessWidget {
  const Timeline({
    @required this.nameList,
    this.indicators,
    this.isLeftAligned = true,
    this.itemGap = 20,
    this.gutterSpacing = 30,
    this.padding = const EdgeInsets.all(8),
    this.controller,
    this.lineColor = Colors.white,
    this.physics,
    this.shrinkWrap = true,
    this.primary = false,
    this.reverse = false,
    this.indicatorSize = 30.0,
    this.lineGap = 7.0,
    this.indicatorColor = Colors.blue,
    this.indicatorStyle = PaintingStyle.fill,
    this.strokeCap = StrokeCap.butt,
    this.strokeWidth = 2.0,
    this.style = PaintingStyle.stroke,
    @required this.width,
    @required this.height,
    this.imageList,
  })  : itemCount = nameList.length,
        assert(itemGap >= 0),
        assert(lineGap >= 0),
        assert(indicators == null || nameList.length == indicators.length);

  final List nameList;
  final List imageList;
  final double itemGap;
  final double gutterSpacing;
  final List indicators;
  final bool isLeftAligned;
  final EdgeInsets padding;
  final ScrollController controller;
  final int itemCount;
  final ScrollPhysics physics;
  final bool shrinkWrap;
  final bool primary;
  final bool reverse;
  final double width;
  final double height;
  final Color lineColor;
  final double lineGap;
  final double indicatorSize;
  final Color indicatorColor;
  final PaintingStyle indicatorStyle;
  final StrokeCap strokeCap;
  final double strokeWidth;
  final PaintingStyle style;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: padding,
      separatorBuilder: (_, __) => SizedBox(height: itemGap),
      physics: physics,
      shrinkWrap: shrinkWrap,
      itemCount: itemCount,
      controller: controller,
      reverse: reverse,
      primary: primary,
      itemBuilder: (context, index) {
        final child = Container(
          height: height * 0.12,
          // width: 200,

          decoration: BoxDecoration(
              color: kProfSecondaryBackgroundColor,
              borderRadius: BorderRadius.circular(width * 0.05)),
          child: Container(
            margin: EdgeInsets.only(top: height * 0.02, left: width * 0.08),
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (context, index) => Container(
                child: GestureDetector(
                  onTap: () => Navigator.of(context).push(PageTransition(
                      type: PageTransitionType.fade,
                      child: ProfilePage(
                        name: nameList[index],
                        roomNo: indicators[index],
                      ))),
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(imageList[index]),
                      ),
                      Text(
                        nameList[index],
                        style: TextStyle(color: kProfTextColour),
                      )
                    ],
                  ),
                ),
              ),
              separatorBuilder: (context, index) => SizedBox(
                width: width / 8,
              ),
            ),
          ),
        );

        Widget indicator;
        if (indicators != null) {
          indicator = CircleAvatar(
              backgroundColor: kProfSecondaryBackgroundColor,
              child: Text(
                indicators[index],
                style: TextStyle(color: kProfAccentColour),
              ));
        }

        final isFirst = index == 0;
        final isLast = index == itemCount - 1;

        final timelineTile = <Widget>[
          CustomPaint(
            foregroundPainter: _TimelinePainter(
              hideDefaultIndicator: indicator != null,
              lineColor: lineColor,
              indicatorColor: indicatorColor,
              indicatorSize: indicatorSize,
              indicatorStyle: indicatorStyle,
              isFirst: isFirst,
              isLast: isLast,
              lineGap: lineGap,
              strokeCap: strokeCap,
              strokeWidth: strokeWidth,
              style: style,
              itemGap: itemGap,
            ),
            child: SizedBox(
              height: double.infinity,
              width: indicatorSize,
              child: indicator,
            ),
          ),
          SizedBox(width: gutterSpacing),
          Expanded(child: child),
        ];

        return IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children:
                isLeftAligned ? timelineTile : timelineTile.reversed.toList(),
          ),
        );
      },
    );
  }
}

class _TimelinePainter extends CustomPainter {
  _TimelinePainter({
    @required this.hideDefaultIndicator,
    @required this.indicatorColor,
    @required this.indicatorStyle,
    @required this.indicatorSize,
    @required this.lineGap,
    @required this.strokeCap,
    @required this.strokeWidth,
    @required this.style,
    @required this.lineColor,
    @required this.isFirst,
    @required this.isLast,
    @required this.itemGap,
  })  : linePaint = Paint()
          ..color = lineColor
          ..strokeCap = strokeCap
          ..strokeWidth = strokeWidth
          ..style = style,
        circlePaint = Paint()
          ..color = indicatorColor
          ..style = indicatorStyle;

  final bool hideDefaultIndicator;
  final Color indicatorColor;
  final PaintingStyle indicatorStyle;
  final double indicatorSize;
  final double lineGap;
  final StrokeCap strokeCap;
  final double strokeWidth;
  final PaintingStyle style;
  final Color lineColor;
  final Paint linePaint;
  final Paint circlePaint;
  final bool isFirst;
  final bool isLast;
  final double itemGap;

  @override
  void paint(Canvas canvas, Size size) {
    final indicatorRadius = indicatorSize / 2;
    final halfItemGap = itemGap / 2;
    final indicatorMargin = indicatorRadius + lineGap;

    final top = size.topLeft(Offset(indicatorRadius, 0.0 - halfItemGap));
    final centerTop = size.centerLeft(
      Offset(indicatorRadius, -indicatorMargin),
    );

    final bottom = size.bottomLeft(Offset(indicatorRadius, 0.0 + halfItemGap));
    final centerBottom = size.centerLeft(
      Offset(indicatorRadius, indicatorMargin),
    );

    if (!isFirst) canvas.drawLine(top, centerTop, linePaint);
    if (!isLast) canvas.drawLine(centerBottom, bottom, linePaint);

    if (!hideDefaultIndicator) {
      final Offset offsetCenter = size.centerLeft(Offset(indicatorRadius, 0));

      canvas.drawCircle(offsetCenter, indicatorRadius, circlePaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
