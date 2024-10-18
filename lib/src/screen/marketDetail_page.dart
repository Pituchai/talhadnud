import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:talhadnad/model/market.dart';
import 'package:talhadnad/model/user_model.dart';
import 'package:talhadnad/theme/talhadnad_theme.dart';
import 'package:talhadnad/widgets/MapKmutt.dart';
import 'package:talhadnad/widgets/calendar.dart';


class MarketDetailPage extends StatefulWidget {
  final String id;
  const MarketDetailPage({required this.id, Key? key}) : super(key: key);

  @override
  State<MarketDetailPage> createState() => _MarketDetailPageState();
}

class _MarketDetailPageState extends State<MarketDetailPage> {
  Market? market;
  bool isLoading = true;
  String? errorMessage;
  DateTime selectedDate = DateTime.now();
  late Map<String, String>? selectedLocation;

  // Mock data
  final List<Map<String, String>> mockLocations = [
    {'name': 'KMUTT', 'latitude': '13.650329', 'longitude': '100.495503'},
    {'name': 'CentralWorld', 'latitude': '13.7470', 'longitude': '100.5392'},
    {'name': 'Chatuchak', 'latitude': '13.7999', 'longitude': '100.5502'},
  ];

  final List<String> mockImages = [
    'https://scontent.fbkk7-3.fna.fbcdn.net/v/t1.6435-9/52595856_1433644083438301_8073669339653341184_n.jpg?stp=dst-jpg_p960x960&_nc_cat=107&ccb=1-7&_nc_sid=7b2446&_nc_eui2=AeG3h7e4W6MuYhQteMdmcLjeKL1BbSR66-wovUFtJHrr7Dz53nhafhNj8Ea_awhn8P8p5J99sWZjBvzyapeRPDIM&_nc_ohc=JG5NTg7Yxg8Q7kNvgEmsyDh&_nc_zt=23&_nc_ht=scontent.fbkk7-3.fna&_nc_gid=AsgsCg1j9e6pPuiR56nNt4B&oh=00_AYBm626eWeZz7aVKzC09N9Zr1S4XYW5MHMYUpnKV7t9Dfw&oe=67348CB1',
    'https://scontent.fbkk7-3.fna.fbcdn.net/v/t1.6435-9/52849956_1433644306771612_7213995604878295040_n.jpg?stp=dst-jpg_p960x960&_nc_cat=108&ccb=1-7&_nc_sid=7b2446&_nc_eui2=AeFU7a8KgODd3TyVi7KfiztfDCYiobqdco4MJiKhup1yjq6nXRzJzSV3drs82Qy_sKoW2hw6v_UgjeRl5oTDIiK0&_nc_ohc=m_-mcqHJad4Q7kNvgFXlFDZ&_nc_zt=23&_nc_ht=scontent.fbkk7-3.fna&_nc_gid=AsgsCg1j9e6pPuiR56nNt4B&oh=00_AYDKC1-yZICek7Y6eiWAkaYa9rOexXZuc9r9yGoxuECIVg&oe=6734AF54',
    'https://scontent.fbkk7-3.fna.fbcdn.net/v/t1.6435-9/52908255_1433644430104933_1345055440664264704_n.jpg?_nc_cat=108&ccb=1-7&_nc_sid=7b2446&_nc_eui2=AeF-O9-GNI2n4-bLFNc1carc_7w0pjDZx5D_vDSmMNnHkGrA6ig5HS4P2T4CRQxK6BOjMtzHwaYYx9bJjg51yW0p&_nc_ohc=shBAZ-yBvvsQ7kNvgFlFM61&_nc_zt=23&_nc_ht=scontent.fbkk7-3.fna&_nc_gid=ANAQCCfxmPuAvjqgdRAvaLU&oh=00_AYCMXqrMbV3h6eWwpuA08-mPgR_9hgUgPGcsK1_TiqZB4g&oe=6734BD3E',
    'https://scontent.fbkk7-2.fna.fbcdn.net/v/t1.6435-9/52953600_1433644536771589_354880954256326656_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=7b2446&_nc_eui2=AeEqgpU6vEtfU7s6kejQNbWQh86yshD0VmKHzrKyEPRWYgaTMtA6_4GQxBohIGYL0Hswj0-bX0iKCHGpqCxXKkGJ&_nc_ohc=Pkq2T20TQkgQ7kNvgGLuo15&_nc_zt=23&_nc_ht=scontent.fbkk7-2.fna&_nc_gid=ABxpKMmaG1kw9zSIZtDacrX&oh=00_AYBcAgp4Tyj2WtF13wahe_RloVs8Je-uihT9pgiadSFMOg&oe=67348D07',
  ];

  @override
  void initState() {
    super.initState();
    selectedLocation = mockLocations.first;
    loadMarketDetail();
  }

  Future<void> loadMarketDetail() async {
    try {
      final userModel = Provider.of<UserModel>(context, listen: false);
      market = await userModel.getMarketById(widget.id);
      setState(() => isLoading = false);
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  void _selectDate(DateTime date) {
    setState(() => selectedDate = date);
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (errorMessage != null || market == null) {
      return _buildErrorScreen();
    }

    return Scaffold(
      backgroundColor: const Color(0xFFf0f1f3),
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              _buildImageSection(),
              SizedBox(
                height: 30,
              ),
              _buildMarketDetails(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildErrorScreen() {
    return Scaffold(
      appBar: AppBar(title: const Text('Market Detail')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Error: $errorMessage'),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: loadMarketDetail,
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSize _buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(86),
      child: Column(
        children: [
          Container(
            height: 30,
            color: const Color(0xFF1A2B47),
          ),
          AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            automaticallyImplyLeading: false,
            title: const Text(
              'Market Detail',
              style: TextStyle(
                color: Color(0xFF1A2B47),
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Quicksand',
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back,
                  color: Color(0xFF1A2B47), size: 32),
              onPressed: () => context.push('/'),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.more_vert,
                    color: Color(0xFF1A2B47), size: 32),
                onPressed: () {
                  // Add functionality for the menu button
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImageSection() {
    if (mockImages.isEmpty) {
      return const SizedBox.shrink();
    } else if (mockImages.length == 1) {
      return Image.network(
        mockImages.first,
        width: double.infinity,
        height: 200,
        fit: BoxFit.cover,
      );
    } else {
      return CarouselSlider(
        options: CarouselOptions(
          height: 200.0,
          viewportFraction: 0.8,
          enlargeCenterPage: true,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 8),
          autoPlayAnimationDuration: const Duration(milliseconds: 3200),
          autoPlayCurve: Curves.fastOutSlowIn,
        ),
        items: mockImages.map((imageUrl) {
          return Builder(
            builder: (BuildContext context) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Image.network(
                  imageUrl,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              );
            },
          );
        }).toList(),
      );
    }
  }

  Widget _buildMarketDetails() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16, top: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            market!.name,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: mountainMeadow,
                  fontSize: 24,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            market!.description,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 8),
          _buildRatingRow(),
          const SizedBox(height: 8),
          _buildPhoneRow(),
          const SizedBox(height: 8),
          _buildAddressRow(),
          const SizedBox(height: 16),
          _buildMap(),
          const SizedBox(height: 16),
          const Divider(color: Colors.black, thickness: 2),
          const SizedBox(height: 16),
          _buildMarketOpenerSection(),
        ],
      ),
    );
  }

  Widget _buildRatingRow() {
    return const Row(
      children: [
        Icon(Icons.star, color: Colors.amber),
        SizedBox(width: 4),
        Text('4.3 (238 ratings)'),
      ],
    );
  }

  Widget _buildPhoneRow() {
    return const Row(
      children: [
        Icon(Icons.phone),
        SizedBox(width: 8),
        Text("23123134"),
      ],
    );
  }

  Widget _buildAddressRow() {
    return Row(
      children: [
        const Icon(Icons.location_on),
        const SizedBox(width: 8),
        Expanded(
          child: Text(market!.address),
        ),
      ],
    );
  }

  Widget _buildMap() {
    if (selectedLocation == null) {
      return const SizedBox.shrink();
    }
    return Container(
      height: 150,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: MapKmutt(
          latitude: double.parse(selectedLocation!['latitude']!),
          longitude: double.parse(selectedLocation!['longitude']!),
          title: selectedLocation!['name']!,
        ),
      ),
    );
  }

  Widget _buildMarketOpenerSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Kmutt Market Opener',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 16),
        CalendarWidget(
          onDateSelected: _selectDate,
          marketCloseDates: [
            "2024-10-17",
            "2024-10-24",
            "2024-10-01",
            "2024-10-08",
          ],
          marketId: widget.id,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
