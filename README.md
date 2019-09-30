## Issue Description
Method `Future<LatLng> getLatLng(ScreenCoordinate screenCoordinate)` returns different results for the same `ScreenCoordinate` on iOS and Android.

## Steps to Reproduce
1. Add `GoogleMap` widget filling entire device screen.
2. Set `initialCameraPosition.target` to (lat; lng) coordinates.
3. Retrieve `GoogleMapController` in `onMapCreated` handler.
4. In `onCameraIdle` handler get center of current context and call `getLatLng()` on `GoogleMapController`


<!--
     Please tell us exactly how to reproduce the problem you are running into.

     Please attach a small application (ideally just one main.dart file) that
     reproduces the problem. You could use https://gist.github.com/ for this.

     If the problem is with your application's rendering, then please attach
     a screenshot and explain what the problem is.
-->

1. ...
2. ...
3. ...

## Logs

<!--
      Run your application with `flutter run --verbose` and attach all the
      log output below between the lines with the backticks. If there is an
      exception, please see if the error message includes enough information
      to explain how to solve the issue.
-->

```
```

<!--
     Run `flutter analyze` and attach any output of that command below.
     If there are any analysis errors, try resolving them before filing this issue.
-->

```
```

<!-- Finally, paste the output of running `flutter doctor -v` here. -->

```
```

