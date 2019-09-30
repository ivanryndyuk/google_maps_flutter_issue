## Issue Description
Method `Future<LatLng> getLatLng(ScreenCoordinate screenCoordinate)` returns different results for the same `ScreenCoordinate` on iOS and Android.

## Steps to Reproduce
1. Add `GoogleMap` widget filling entire device screen.
2. Set `initialCameraPosition.target` to (lat; lng) coordinates.
3. Retrieve `GoogleMapController` in `onMapCreated` handler.
4. In `onCameraIdle` handler get center of current context and call `getLatLng()` on `GoogleMapController`

In the end you would expect latitude and longitude retrieved in step 4 to be equal to those set in step 2. This works as expected on iOS. But that's not the case for Android where you get the result with a weird offset:
iOS: https://drive.google.com/open?id=1MsxHHb59K2NqgKB3P17LVOk3ulHzANSE
Android: https://drive.google.com/open?id=1aYOuuSUqIkcFdV6WyN_6SDIEJPpSPWO9

## Workaround
As you can see in attached project I've found a workaround. I believe the problem is in different implementations of GMSProjection and Projection classes for iOS and Android. google_maps_flutter plugin uses these methods:
in iOS `(CLLocationCoordinate2D) coordinateForPoint:  (CGPoint)  point`:
https://developers.google.com/maps/documentation/ios-sdk/reference/interface_g_m_s_projection.html#a4e912bf5b8778dec702e025ea2036d49
in Android `public LatLng fromScreenLocation (Point point)`:  https://developers.google.com/maps/documentation/android-sdk/reference/com/google/android/libraries/maps/Projection.html#public-latlng-fromscreenlocation-point-point
The iOS method uses CGPoint that is relative to map view, and Android method takes actual screen location (screen pixels) which depend on device pixel density. So, the workaround is to use context width and height multiplied by `MediaQuery.of(context).devicePixelRatio` for Android and normal width and height for iOS.
```dart
final devicePixelRatio = Platform.isAndroid
   ? MediaQuery.of(context).devicePixelRatio
   : 1.0;

_latLng = await _mapController.getLatLng(
   // Center of a full screen GoogleMap widget.
   ScreenCoordinate(
      x: (context.size.width * devicePixelRatio) ~/ 2.0,
      y: (context.size.height * devicePixelRatio) ~/ 2.0,
   ),
);
```
Here is a sample project to view and play with the issue:
https://github.com/ivanryndyuk/google_maps_flutter_issue

## So, what's the point?
First of all, thank you all in Flutter team, Google and who help to develop and improve Flutter and additional plugins. You're doing a great job! 
It would be really nice to synchronize behavior of `getLatLng` method on both platforms, so that it would either use actual screen pixels or coordinates relative to widget. That would make life of many devs much more easier!
