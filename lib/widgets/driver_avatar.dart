import 'package:flutter/material.dart';
import 'package:drayve/services/api_services.dart';

class DriverAvatar extends StatefulWidget {
  final String? imageUrl;
  final String? driverName;
  final String? fallbackAsset;
  final String fallbackInitials;
  final double radius;
  final Color? backgroundColor;

  const DriverAvatar({
    super.key,
    this.imageUrl,
    this.driverName,
    this.fallbackAsset,
    required this.fallbackInitials,
    this.radius = 30.0,
    this.backgroundColor,
  });

  @override
  State<DriverAvatar> createState() => _DriverAvatarState();
}

class _DriverAvatarState extends State<DriverAvatar> {
  Future<String?>? _headshotFuture;

  @override
  void initState() {
    super.initState();
    _initHeadshotFuture();
  }

  @override
  void didUpdateWidget(covariant DriverAvatar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.imageUrl != widget.imageUrl ||
        oldWidget.driverName != widget.driverName) {
      _initHeadshotFuture();
    }
  }

  void _initHeadshotFuture() {
    final explicitUrl = widget.imageUrl;
    if (explicitUrl != null && explicitUrl.isNotEmpty) {
      _headshotFuture = Future.value(explicitUrl);
    } else if (widget.driverName != null && widget.driverName!.trim().isNotEmpty) {
      _headshotFuture = ApiService().getOpenF1HeadshotUrl(widget.driverName!);
    } else {
      _headshotFuture = Future.value(null);
    }
  }

  Widget _buildInitialsFallback() {
    return Center(
      child: Text(
        widget.fallbackInitials,
        style: TextStyle(
          color: Colors.white,
          fontSize: widget.radius * 0.9,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildAssetOrInitialsFallback() {
    final asset = widget.fallbackAsset;
    if (asset != null && asset.isNotEmpty) {
      return Image.asset(
        asset,
        fit: BoxFit.cover,
        alignment: Alignment.topCenter,
        errorBuilder: (_, _, _) => _buildInitialsFallback(),
      );
    }
    return _buildInitialsFallback();
  }

  @override
  Widget build(BuildContext context) {
    final diameter = widget.radius * 2;
    return Container(
      width: diameter,
      height: diameter,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: widget.backgroundColor ?? Colors.grey[800],
      ),
      child: FutureBuilder<String?>(
        future: _headshotFuture,
        builder: (context, snapshot) {
          final url = snapshot.data;
          if (url != null && url.isNotEmpty) {
            return Image.network(
              url,
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
              errorBuilder: (_, _, _) => _buildAssetOrInitialsFallback(),
            );
          }
          return _buildAssetOrInitialsFallback();
        },
      ),
    );
  }
}
