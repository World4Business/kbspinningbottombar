import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kbspinningbottombar/src/modals.dart';

class SpinCircleBottomBarHolder extends StatefulWidget {
  final SCBottomBarDetails bottomNavigationBar;
  final Widget child;

  const SpinCircleBottomBarHolder(
      {Key? key, required this.bottomNavigationBar, required this.child})
      : super(key: key);

  @override
  State<SpinCircleBottomBarHolder> createState() =>
      _SpinCircleBottomBarHolderState();
}

class _SpinCircleBottomBarHolderState extends State<SpinCircleBottomBarHolder> {
  bool expansionStatus = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Column(
          children: <Widget>[
            Expanded(child: widget.child),
            Container(
              height: widget.bottomNavigationBar.bnbHeight ?? 80,
            )
          ],
        ),
        if(expansionStatus == true)
        Container(
          width: MediaQuery.of(context).size.width,
          height: (MediaQuery.of(context).size.width -
              (widget.bottomNavigationBar.bnbHeight ?? 80)),
          color: (widget.bottomNavigationBar.planColor != null)
              ? widget.bottomNavigationBar.planColor
              : Colors.black26,
        ),
        Positioned(
            bottom: 0,
            left: 0,
            child: SpinCircleBottomBar(
                bottomNavigationBar: widget.bottomNavigationBar,
                isChange: (openornot) {
                  setState(() {
                    expansionStatus = openornot;
                  });
                }))
      ],
    );
  }
}

class SpinCircleBottomBar extends StatefulWidget {
  final SCBottomBarDetails bottomNavigationBar;
  final Function isChange;

  const SpinCircleBottomBar(
      {Key? key, required this.bottomNavigationBar, required this.isChange})
      : super(key: key);

  @override
  State<SpinCircleBottomBar> createState() {
    // Avoid using private types in public APIs.
    return _SpinCircleBottomBarState();
  }
}

enum ExpansionStatus { open, close, idle }

class _SpinCircleBottomBarState extends State<SpinCircleBottomBar> {
  ExpansionStatus expansionStatus = ExpansionStatus.idle;
  late SCBottomBarDetails expandableBottomBarDetails;
  int activeIndex = 0;

  @override
  void initState() {
    super.initState();

    expandableBottomBarDetails = widget.bottomNavigationBar;
    expandableBottomBarDetails.items
        .insert((expandableBottomBarDetails.items.length / 2).floor(), null);
    expandableBottomBarDetails.circleColors =
        expandableBottomBarDetails.circleColors ??
            [Colors.white, Colors.blue, Colors.red];
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final double bottomBarHeight = expandableBottomBarDetails.bnbHeight ?? 80;
    final IconThemeData iconTheme = expandableBottomBarDetails.iconTheme ??
        const IconThemeData(color: Colors.black45);
    final IconThemeData activeIconTheme =
        expandableBottomBarDetails.activeIconTheme ??
            const IconThemeData(color: Colors.black);
    final TextStyle textStyle = expandableBottomBarDetails.titleStyle ??
        const TextStyle(
            color: Colors.black45, fontWeight: FontWeight.normal, fontSize: 12);
    final TextStyle activeTextStyle =
        expandableBottomBarDetails.activeTitleStyle ??
            const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12);
    final SCActionButtonDetails actionButtonDetails =
        expandableBottomBarDetails.actionButtonDetails;

    final bool shouldOpen = expansionStatus == ExpansionStatus.open;

    return Container(
        height: bottomBarHeight * 2,
        width: width,
        alignment: Alignment.center,
        child: Stack(
          fit: StackFit.expand,
          clipBehavior: Clip.none,
          children: <Widget>[
            if (expansionStatus != ExpansionStatus.idle) ...[
              SizedBox(
                  width: width,
                  height: bottomBarHeight * 2,
                  child: Stack(
                    children: <Widget>[
                      TweenAnimationBuilder(
                        tween: Tween<double>(
                            begin: shouldOpen ? -3.14 : 0,
                            end: shouldOpen ? 0 : -3.14),
                        curve: Curves.easeInOutQuad,
                        duration:
                            Duration(milliseconds: shouldOpen ? 500 : 800),
                        builder: (BuildContext context, double value,
                            Widget? child) {
                          return Transform.rotate(
                            angle: value,
                            alignment: Alignment.bottomCenter,
                            child: child,
                          );
                        },
                        child: EmptyLayer(
                          radius: bottomBarHeight * 2,
                          color: expandableBottomBarDetails.circleColors![2],
                        ),
                      ),
                      TweenAnimationBuilder(
                        tween: Tween<double>(
                            begin: shouldOpen ? -3.14 : 0,
                            end: shouldOpen ? 0 : -3.14),
                        curve: Curves.easeInOutQuad,
                        duration: const Duration(milliseconds: 600),
                        builder: (BuildContext context, double value,
                            Widget? child) {
                          return Transform.rotate(
                            angle: value,
                            alignment: Alignment.bottomCenter,
                            child: child,
                          );
                        },
                        child: EmptyLayer(
                          radius: bottomBarHeight * 2,
                          color: expandableBottomBarDetails.circleColors![1],
                        ),
                      ),
                      TweenAnimationBuilder(
                        tween: Tween<double>(
                            begin: shouldOpen ? -3.14 : 0,
                            end: shouldOpen ? 0 : -3.14),
                        duration:
                            Duration(milliseconds: shouldOpen ? 800 : 500),
                        curve: Curves.easeInOutQuad,
                        builder: (BuildContext context, double value,
                            Widget? child) {
                          return Transform.rotate(
                            angle: value,
                            alignment: Alignment.bottomCenter,
                            child: child,
                          );
                        },
                        child: PrimaryCircle(
                          circleItems: expandableBottomBarDetails.circleItems,
                          radius: bottomBarHeight * 2,
                          color: expandableBottomBarDetails.circleColors![0],
                        ),
                      ),
                    ],
                  ))
            ],
            Positioned(
              bottom: 0,
              child: Container(
                height: bottomBarHeight,
                width: width,
                decoration: BoxDecoration(
                    color: expandableBottomBarDetails.backgroundColor ??
                        Colors.white,
                    border: expandableBottomBarDetails.border,
                    boxShadow: expandableBottomBarDetails.shadow ??
                        [
                          BoxShadow(
                              color: Colors.black.withAlpha(55),
                              offset: Offset(
                                  0, expandableBottomBarDetails.elevation ?? 0),
                              blurRadius: 10)
                        ]),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: expandableBottomBarDetails.items
                          .asMap()
                          .entries
                          .map((entry) {
                        final int index = entry.key;
                        final SCBottomBarItem? itemDetails = entry.value;
                        final bool isActive = activeIndex == index;
                        return Flexible(
                            child: itemDetails != null
                                ? InkWell(
                                    onTap: () {
                                      setState(() {
                                        activeIndex = index;
                                      });
                                      itemDetails.onPressed();
                                    },
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          (itemDetails.svgPicture != null &&
                                                  itemDetails
                                                          .activeSvgPicture !=
                                                      null)
                                              ? SvgPicture.asset(
                                                  (isActive
                                                      ? itemDetails.svgPicture!
                                                      : itemDetails
                                                          .activeSvgPicture!),
                                                  fit: itemDetails.boxFit ??
                                                      BoxFit.fill,
                                                  width: itemDetails.width,
                                                  height: itemDetails.height,
                                                )
                                              : Icon(
                                                  isActive
                                                      ? itemDetails
                                                              .activeIcon ??
                                                          itemDetails.icon
                                                      : itemDetails.icon,
                                                  color: isActive
                                                      ? activeIconTheme.color
                                                      : iconTheme.color,
                                                  size: isActive
                                                      ? activeIconTheme.size
                                                      : iconTheme.size,
                                                ),
                                          itemDetails.title != null
                                              ? Text(itemDetails.title ?? "",
                                                  style: isActive
                                                      ? activeTextStyle
                                                      : textStyle)
                                              : const Center()
                                        ],
                                      ),
                                    ),
                                  )
                                : const Center());
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
            if (actionButtonDetails.actionButtonText != null)
              Container(
                height: bottomBarHeight * 2,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: 70,
                  height: bottomBarHeight,
                  alignment: Alignment.bottomCenter,
                  padding: actionButtonDetails.textPadding ??
                      const EdgeInsets.only(right: 2),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(actionButtonDetails.actionButtonText!,
                          textAlign: TextAlign.center,
                          style: shouldOpen ? activeTextStyle : textStyle),
                      const SizedBox(
                        height: 17,
                      )
                    ],
                  ),
                ),
              ),
            Container(
                height: bottomBarHeight * 2,
                width: MediaQuery.of(context).size.width,
                margin: actionButtonDetails.margin,
                alignment: Alignment.center,
                child: TweenAnimationBuilder(
                  tween: Tween<double>(
                      begin: shouldOpen ? 0.0 : 6.28319,
                      end: shouldOpen ? 6.28319 : 0),
                  duration: const Duration(milliseconds: 250),
                  builder: (BuildContext context, double angle, Widget? child) {
                    return Transform.rotate(
                        angle: expansionStatus == ExpansionStatus.idle
                            ? 0.0
                            : angle,
                        child: child);
                  },
                  child: Container(
                    width: actionButtonDetails.width ?? 50,
                    height: actionButtonDetails.height ?? 50,
                    decoration: BoxDecoration(
                        borderRadius: actionButtonDetails.borderRadius ??
                            BorderRadius.circular(500),
                        border: actionButtonDetails.border,
                        boxShadow: actionButtonDetails.boxShadow,
                        color:
                            actionButtonDetails.backgorundColor ?? Colors.red),
                    child: Material(
                      color: Colors.transparent,
                      borderRadius: actionButtonDetails.borderRadius ??
                          BorderRadius.circular(500),
                      child: InkWell(
                        onTap: () {
                          if (expansionStatus == ExpansionStatus.idle) {
                            setState(() {
                              expansionStatus = ExpansionStatus.open;
                              widget.isChange(true);
                            });

                          } else {
                            setState(() {
                              expansionStatus =
                                  (expansionStatus == ExpansionStatus.open)
                                      ? ExpansionStatus.close
                                      : ExpansionStatus.open;
                              widget.isChange(((expansionStatus == ExpansionStatus.open) ? true : false));
                            });
                          }
                        },
                        borderRadius: actionButtonDetails.borderRadius ??
                            BorderRadius.circular(500),
                        child: Container(
                            width: actionButtonDetails.width ?? 50,
                            height: actionButtonDetails.height ?? 50,
                            padding: actionButtonDetails.padding ??
                                const EdgeInsets.all(10),
                            child: shouldOpen
                                ? actionButtonDetails.closeWidget
                                : actionButtonDetails.activeWidget),
                      ),
                    ),
                  ),
                )),
          ],
        ));
  }
}

class PrimaryCircle extends StatelessWidget {
  final List<SCItem> circleItems;
  final Color color;
  final double radius;

  const PrimaryCircle(
      {Key? key,
      required this.color,
      required this.radius,
      required this.circleItems})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double radianGap = 3.14159 / circleItems.length;
    final double start = radianGap / 2;
    return ClipRect(
      child: Align(
        heightFactor: 0.5,
        alignment: Alignment.topCenter,
        child: Container(
          width: radius,
          height: radius,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
          child: Center(
            child: Stack(
              fit: StackFit.expand,
              clipBehavior: Clip.none,
              children: circleItems.asMap().entries.map((entry) {
                final SCItem value = entry.value;
                return Transform.translate(
                    offset: Offset.fromDirection(
                        -(start + (entry.key * radianGap)), radius / 3),
                    child: GestureDetector(
                      onTap: value.onPressed,
                      child: value.icon,
                    ));
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}

class EmptyLayer extends StatelessWidget {
  final Color color;
  final double radius;

  const EmptyLayer({Key? key, required this.color, required this.radius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Align(
        heightFactor: 0.5,
        alignment: Alignment.topCenter,
        child: Container(
          width: radius,
          height: radius,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
          child: const Center(),
        ),
      ),
    );
  }
}
