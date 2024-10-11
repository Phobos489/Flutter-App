import 'package:flutter/material.dart';

class WavePainter extends CustomPainter {
  final BuildContext context;

  WavePainter(this.context);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Theme.of(context).primaryColor.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    final path1 = Path();
    final path2 = Path();
    final path3 = Path();

    path1.moveTo(0, size.height * 0.5);
    path1.quadraticBezierTo(size.width * 0.25, size.height * 0.6,
        size.width * 0.5, size.height * 0.5);
    path1.quadraticBezierTo(size.width * 0.75, size.height * 0.4,
        size.width, size.height * 0.6);
    path1.lineTo(size.width, size.height);
    path1.lineTo(0, size.height);

    path2.moveTo(0, size.height * 0.6);
    path2.quadraticBezierTo(size.width * 0.3, size.height * 0.7,
        size.width * 0.6, size.height * 0.55);
    path2.quadraticBezierTo(size.width * 0.8, size.height * 0.45,
        size.width, size.height * 0.65);
    path2.lineTo(size.width, size.height);
    path2.lineTo(0, size.height);

    path3.moveTo(0, size.height * 0.7);
    path3.quadraticBezierTo(size.width * 0.2, size.height * 0.75,
        size.width * 0.4, size.height * 0.65);
    path3.quadraticBezierTo(size.width * 0.7, size.height * 0.55,
        size.width, size.height * 0.7);
    path3.lineTo(size.width, size.height);
    path3.lineTo(0, size.height);

    canvas.drawPath(path1, paint);
    canvas.drawPath(path2, paint..color = paint.color.withOpacity(0.5));
    canvas.drawPath(path3, paint..color = paint.color.withOpacity(0.7));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home', style: TextStyle(color: Theme.of(context).primaryColor)),
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          CustomPaint(
            painter: WavePainter(context),
            size: Size.infinite,
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage('assets/student_avatar.png'),
                      ),
                      SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Selamat datang,', style: TextStyle(fontSize: 16)),
                          Text('Rio Syamsuri', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                ),
                GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  padding: EdgeInsets.all(16),
                  children: [
                    _buildMenuCard(context, Icons.calendar_today, 'Jadwal Kuliah'),
                    _buildMenuCard(context, Icons.assignment, 'Tugas'),
                    _buildMenuCard(context, Icons.school, 'Nilai'),
                    _buildMenuCard(context, Icons.book, 'Perpustakaan'),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Pengumuman Terbaru', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      _buildAnnouncementCard('Jadwal UTS Semester Ganjil 2023/2024'),
                      _buildAnnouncementCard('Pembayaran DPPS'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard(BuildContext context, IconData icon, String title) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: () {
          // Navigasi ke halaman terkait
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: Theme.of(context).primaryColor),
            SizedBox(height: 8),
            Text(title, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  Widget _buildAnnouncementCard(String title) {
    return Card(
      margin: EdgeInsets.only(bottom: 8),
      child: ListTile(
        title: Text(title),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: () {
          // Navigasi ke detail pengumuman
        },
      ),
    );
  }
}
