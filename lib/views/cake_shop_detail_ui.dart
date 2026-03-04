import 'package:flutter/material.dart';
import 'package:flutter_iot_cake_fast_app/models/Cake_Shop.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class CakeShopDetailUi extends StatefulWidget {
  //สร้างตัวแปรรับข้อมูลร้านเค้กที่ส่งมาจากหน้า CakeShopListUi
  CakeShop? cakeShopDetail;

  //สร้าง Constructor เพื่อรับข้อมูลร้านเค้กที่ส่งมาจากหน้า CakeShopListUi
  CakeShopDetailUi({super.key, this.cakeShopDetail});

  @override
  State<CakeShopDetailUi> createState() => _CakeShopDetailUiState();
}

class _CakeShopDetailUiState extends State<CakeShopDetailUi> {
  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  MapController? mapController;

  @override
  void initState() {
    super.initState();
    mapController = MapController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 0, 0),
        title: Text(
          widget.cakeShopDetail!.name!,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new),
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(45.0),
          child: Center(
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    //"assets/images/" + widget.cakeShopDetail!.image1!,
                    "assets/images/${widget.cakeShopDetail!.image1!}",
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        "assets/images/${widget.cakeShopDetail!.image2!}",
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      width: 75,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        "assets/images/${widget.cakeShopDetail!.image3!}",
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        ListTile(
                          leading: Icon(FontAwesomeIcons.shop),
                          title: Text(widget.cakeShopDetail!.name!),
                        ),
                        ListTile(
                          leading: Icon(FontAwesomeIcons.locationDot),
                          title: Text(widget.cakeShopDetail!.address!),
                        ),
                        ListTile(
                          onTap: () {
                            _makePhoneCall(widget.cakeShopDetail!.phone!);
                          },
                          leading:
                              Icon(FontAwesomeIcons.phone, color: Colors.green),
                          title: Text(widget.cakeShopDetail!.phone!),
                        ),
                        ListTile(
                          onTap: () {
                            _launchInBrowser(
                              Uri.parse(widget.cakeShopDetail!.website!),
                            );
                          },
                          leading: Icon(FontAwesomeIcons.globe,
                              color: Colors.yellow[700]),
                          title: Text(widget.cakeShopDetail!.website!),
                        ),
                        ListTile(
                          onTap: () {
                            _launchInBrowser(
                              Uri.parse(widget.cakeShopDetail!.facebook!),
                            );
                          },
                          leading: Icon(FontAwesomeIcons.facebook,
                              color: Colors.blue),
                          title: Text(widget.cakeShopDetail!.facebook!),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  child: FlutterMap(
                    mapController: MapController(),
                    options: MapOptions(
                      initialCenter: LatLng(
                        double.parse(widget.cakeShopDetail!.latitude!),
                        double.parse(widget.cakeShopDetail!.longitude!),
                      ),
                      initialZoom: 15.0,
                    ),
                    //วาดแผนที่
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.example.app',
                      ),
                      RichAttributionWidget(
                        attributions: [
                          TextSourceAttribution(
                            'OpenStreetMap contributors',
                            onTap: () => _launchInBrowser(
                              Uri.parse(
                                  'https://www.openstreetmap.org/copyright'),
                            ),
                          ),
                        ],
                      ),
                      MarkerLayer(
                        markers: [
                          Marker(
                            point: LatLng(
                              double.parse(widget.cakeShopDetail!.latitude!),
                              double.parse(widget.cakeShopDetail!.longitude!),
                            ),
                            child: InkWell(
                              onTap: () {
                                String googleMapsUrl =
                                    'https://www.google.com/maps/search/?api=1&query=${widget.cakeShopDetail!.latitude},${widget.cakeShopDetail!.longitude}';
                                _launchInBrowser(Uri.parse(googleMapsUrl));
                                // Handle marker tap event if needed
                              },
                              child: Icon(
                                //FontAwesomeIcons.locationArrow,
                                Icons.location_pin,
                                color: Colors.red,
                                size: 40,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
