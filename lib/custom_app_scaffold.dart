import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:super_tooltip/super_tooltip.dart';

/// A customizable Scaffold widget with transparent AppBar and background gradient.
/// Always ensure that:
/// - When `scrollable` is true, `children` must be non-null and `body` should be null.
/// - When `scrollable` is false, provide a non-null `body` widget (which can be scrollable).

class AppScaffold extends StatefulWidget {
  final Widget? prefixIcon;
  final Widget? trailingWidget;
  final Widget? centerWidget;
  final double appBarHeight;
  final EdgeInsets appBarPadding;
  final List<Color>? backgroundGradient;
  final List<double>? gradientStops;
  final Widget? body;
  final bool scrollable;
  final Widget? leadingWidget;
  final double? leadingWidth;
  final Widget? bottomWidget;
  final EdgeInsetsGeometry? bodyPadding;
  final bool? showAppBar;
  final Widget? sliverToBoxAdapter;
  final Widget? bottomAppBarWidget;
  final Color? bgColor;
  final ThemeData? themeType;
  final bool? extendBodyBehindAppBar;
  final bool? resizeToAvoidBottomInset;
  final AlignmentGeometry? alignCenterWidget;

  ///SliverAppBar
  final Widget? leadingSliverWidget;
  final double? leadingSliverWidth;
  final Widget? trailingSliverWidget;
  final Widget? centerSliverWidget;
  final Alignment? alignCenterSliverWidget;
  final double? toolbarSliverHeight;
  final Color? sliverBaseColor;
  final double? sliverElevation;
  final Widget? flexibleSpace;
  final Color? sliverShadowColor;
  final double? expandedSliverHeight;
  final bool showTransparentSliverAppBar;
  final SuperTooltipController? tooltipController;
  final ScrollController? scrollController;
  final Widget? sliverFillRemaining;
  const AppScaffold({
    super.key,
    this.sliverToBoxAdapter,
    this.prefixIcon,
    this.trailingWidget,
    this.centerWidget,
    this.appBarHeight = 70,
    this.appBarPadding = const EdgeInsets.symmetric(horizontal: 16),
    this.backgroundGradient,
    this.body,
    this.gradientStops,
    this.scrollable = false,
    this.leadingWidget,
    this.leadingWidth,
    this.scrollController,
    this.bottomWidget,
    this.bodyPadding,
    this.showAppBar = true,
    this.themeType,
    this.tooltipController,
    this.bottomAppBarWidget,
    this.sliverFillRemaining,
    this.extendBodyBehindAppBar,
    this.resizeToAvoidBottomInset,
    this.alignCenterWidget,
    this.bgColor = Colors.white,
    this.leadingSliverWidget,
    this.leadingSliverWidth,
    this.trailingSliverWidget,
    this.centerSliverWidget,
    this.alignCenterSliverWidget,
    this.toolbarSliverHeight = kToolbarHeight,
    this.sliverBaseColor = Colors.white,
    this.sliverElevation = 0,
    this.flexibleSpace,
    this.sliverShadowColor,
    this.showTransparentSliverAppBar = false,
    this.expandedSliverHeight,
  });

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  ScrollController _scrollController = ScrollController();
  double _appBarOpacity = 0.0;

  @override
  void initState() {
    super.initState();
    if (widget.scrollController != null) {
      setState(() {
        _scrollController = widget.scrollController!;
      });
    } else {
      _scrollController.addListener(() {
        final offset = _scrollController.offset;
        setState(() {
          _appBarOpacity = (offset / 100).clamp(0.0, 1.0);
        });
        final screenHeight = MediaQuery.of(context).size.height;

        /// on scroll dismiss tooltip as it overlaps on SliverAppBar
        if (offset > screenHeight * 0.1 &&
            widget.tooltipController != null &&
            widget.tooltipController!.isVisible) {
          widget.tooltipController?.hideTooltip();
        }
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final brightness = (widget.themeType ?? ThemeData.light()).brightness;
    final overlayStyle = brightness == Brightness.dark
        ? SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
            systemNavigationBarColor: Colors.black,
            systemNavigationBarIconBrightness: Brightness.light,
          )
        : SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: Colors.white,
            systemNavigationBarIconBrightness: Brightness.dark,
          );
    final topPadding = MediaQuery.of(context).padding.top;
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: overlayStyle,
        child: Theme(
          data: widget.themeType ?? ThemeData.light(),
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            extendBodyBehindAppBar: widget.extendBodyBehindAppBar ?? false,
            backgroundColor: Colors.white,
            body: widget.scrollable
                ? Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 2.0,
                        padding:
                            widget.bodyPadding ??
                            const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          gradient: widget.backgroundGradient != null
                              ? LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: widget.backgroundGradient!,
                                  stops: widget.gradientStops ?? [0, 0.21, 1.0],
                                )
                              : null,
                          color: widget.bgColor,
                        ),
                      ),
                      CustomScrollView(
                        shrinkWrap: true,
                        controller: _scrollController,
                        slivers: [
                          if (widget.showAppBar == true)
                            SliverAppBar(
                              pinned: true,
                              expandedHeight: widget.expandedSliverHeight,
                              elevation: 3,
                              backgroundColor:
                                  widget.showTransparentSliverAppBar
                                  ? _appBarOpacity > 0.1
                                        ? widget.sliverBaseColor ??
                                              Colors.white
                                        : Colors.transparent
                                  : widget.sliverBaseColor,
                              systemOverlayStyle: overlayStyle,
                              toolbarHeight: widget.appBarHeight,
                              leading: widget.leadingSliverWidget,
                              leadingWidth: widget.leadingSliverWidth,
                              title: widget.centerSliverWidget,
                              flexibleSpace: widget.flexibleSpace,
                              shadowColor: _appBarOpacity > 0.3
                                  ? widget.sliverShadowColor
                                  : Colors.transparent,
                              surfaceTintColor: widget.sliverBaseColor,
                              bottom: widget.bottomAppBarWidget != null
                                  ? PreferredSize(
                                      preferredSize: Size.fromHeight(
                                        kToolbarHeight,
                                      ),
                                      child: Material(
                                        color: Colors.white,
                                        child: widget.bottomAppBarWidget,
                                      ),
                                    )
                                  : null,
                            ),
                          SliverToBoxAdapter(
                            child:
                                widget.sliverToBoxAdapter ??
                                Padding(
                                  padding:
                                      widget.bodyPadding ?? EdgeInsets.zero,
                                  child: widget.body ?? const SizedBox.shrink(),
                                ),
                          ),
                          if (widget.sliverFillRemaining != null)
                            SliverFillRemaining(
                              hasScrollBody: true,
                              child: widget.sliverFillRemaining,
                            ),
                        ],
                      ),
                    ],
                  )
                : Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 2.0,
                        padding:
                            widget.bodyPadding ??
                            const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: widget.bgColor,
                          gradient: widget.backgroundGradient != null
                              ? LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors:
                                      widget.backgroundGradient ??
                                      [
                                        Color(0XFFE2D3F3),
                                       Colors.white,
                                        Colors.white,
                                      ],
                                  stops: widget.gradientStops ?? [0, 0.21, 1.0],
                                )
                              : null,
                        ),
                      ),
                      widget.showAppBar == true
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 94,
                                  alignment: Alignment.center,
                                  padding:
                                      widget.appBarPadding +
                                      EdgeInsets.only(top: topPadding),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      widget.leadingWidget ??
                                          const SizedBox(width: 48),
                                      Gap(12),
                                      Expanded(
                                        child: Align(
                                          alignment:
                                              widget.alignCenterWidget ??
                                              Alignment.center,
                                          child: widget.centerWidget,
                                        ),
                                      ),
                                      widget.trailingWidget ??
                                          const SizedBox(width: 48),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding:
                                        widget.bodyPadding ?? EdgeInsets.zero,
                                    child:
                                        widget.body ?? const SizedBox.shrink(),
                                  ),
                                ),
                              ],
                            )
                          : Center(
                              child: Padding(
                                padding: widget.bodyPadding ?? EdgeInsets.zero,
                                child: widget.body ?? const SizedBox.shrink(),
                              ),
                            ),
                    ],
                  ),
            extendBody: widget.bottomWidget != null,
            bottomNavigationBar: widget.bottomWidget ?? null,
          ),
        ),
      ),
    );
  }
}
