import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../bloc/color/color_bloc.dart';
import '../models/Pharmacy.dart';

class PagePharmacySpecificMarker extends StatefulWidget {
  final Pharmacy pharmacy;
  PagePharmacySpecificMarker({super.key, required this.pharmacy});

  @override
  State<PagePharmacySpecificMarker> createState() => _PageSpecificMarkerState();
}

class _PageSpecificMarkerState extends State<PagePharmacySpecificMarker> {
  late GoogleMapController mapController;

  CustomInfoWindowController _customInfoWindowController = CustomInfoWindowController();

  final Set<Marker> markers = {};

  @override
  void initState() {
    setState(() {
      markers.add(Marker(
        onTap: () {
          _customInfoWindowController.addInfoWindow!(
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.topLeft,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            widget.pharmacy.imageUrl != null ? Image.network(widget.pharmacy.imageUrl!, height: 80.0, width: 80.0) : Image.asset('assets/iconomapa.png'),
                            SizedBox(
                              width: 8.0,
                            ),
                            Row(
                              children: [
                                Text('Nombre:', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                                SizedBox(width: 4.0),
                                Text(
                                    widget.pharmacy.name!
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                ],
              ),
              LatLng(widget.pharmacy.latitude!, widget.pharmacy.longitude!)
          );
        },
        markerId: MarkerId(widget.pharmacy.idPharmacy!),
        position: LatLng(widget.pharmacy.latitude!, widget.pharmacy.longitude!),
        infoWindow: InfoWindow(
          title: widget.pharmacy.name,
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
    super.initState();
  }

  @override
  void dispose() {
    _customInfoWindowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Stack(
        children: <Widget>[
          GoogleMap(
            myLocationButtonEnabled: false,
            mapType: MapType.normal,
            onTap: (position) {
              _customInfoWindowController.hideInfoWindow!();
            },
            onCameraMove: (position) {
              _customInfoWindowController.onCameraMove!();
            },
            onMapCreated: (GoogleMapController controller) async {
              _customInfoWindowController.googleMapController = controller;
            },
            initialCameraPosition: CameraPosition(
              target: LatLng(widget.pharmacy.latitude!, widget.pharmacy.longitude!),
              zoom: 15.4746,
            ),
            markers: markers,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(

        backgroundColor: context.watch<ColorBloc>().state.colorPrimary,
        onPressed: () => Navigator.pop(context),
        child: Icon(Icons.chevron_left, color: context.watch<ColorBloc>().state.colorSecondary),
        shape: CircleBorder(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}