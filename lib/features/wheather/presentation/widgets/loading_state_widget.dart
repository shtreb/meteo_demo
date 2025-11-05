part of '../wheather_page.dart';

Widget buildLoadingState(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.blue.shade400, Colors.blue.shade600, Colors.blue.shade800],
      ),
    ),
    child: Shimmer.fromColors(
      baseColor: Colors.white.withValues(alpha: 0.3),
      highlightColor: Colors.white.withValues(alpha: 0.5),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 80, width: double.infinity),
              Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              ),
              const SizedBox(height: 40),
              Container(
                height: 60,
                width: 200,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30)),
              ),
              const SizedBox(height: 20),
              Container(
                height: 40,
                width: 150,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
