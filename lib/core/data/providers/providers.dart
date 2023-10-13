import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:restart_project/core/utils/dark_mod/dark_mod_view_model.dart';
import 'package:restart_project/view/detail_maps/detail_map_model.dart';
import 'package:restart_project/view/detail_maps/detail_map_view_model.dart';

final locationProvider =
    StateNotifierProvider<LocationNotifier, Location>((ref) {
  return LocationNotifier(
    Location(
      startpoint: const LatLng(38.23456, 39.12345),
      endpoint: const LatLng(38.34568, 39.47856),
    ),
  );
});
DarkThemeProvider themeChangeProvider = DarkThemeProvider();

@override
void initState() {
  getCurrentAppTheme();
}

void getCurrentAppTheme() async {
  themeChangeProvider.darkTheme =
      await themeChangeProvider.darkThemePreference.getTheme();
}
