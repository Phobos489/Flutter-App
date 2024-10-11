import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AgendaScreen extends StatefulWidget {
  @override
  _AgendaScreenState createState() => _AgendaScreenState();
}

class _AgendaScreenState extends State<AgendaScreen> {
  // Fungsi untuk mengambil data dari API
  Future<List<dynamic>> fetchAgenda() async {
    final response = await http.get(
        Uri.parse('https://praktikum-cpanel-unbin.com/kelompok_rio/api.php?endpoint=agenda'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Gagal memuat agenda');
    }
  }

  // Fungsi untuk menambah data
  void _addData() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String judul = '';
        String isi = '';
        String tanggal = '';
        
        return AlertDialog(
          title: Text('Tambah Data', style: TextStyle(color: Theme.of(context).primaryColor)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Judul Agenda',
                  labelStyle: TextStyle(color: Theme.of(context).primaryColor),
                ),
                onChanged: (value) => judul = value,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Isi Agenda',
                  labelStyle: TextStyle(color: Theme.of(context).primaryColor),
                ),
                onChanged: (value) => isi = value,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Tanggal Agenda',
                  labelStyle: TextStyle(color: Theme.of(context).primaryColor),
                ),
                onChanged: (value) => tanggal = value,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Batal', style: TextStyle(color: Theme.of(context).primaryColor)),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Simpan', style: TextStyle(color: Theme.of(context).primaryColor)),
              onPressed: () async {
                final response = await http.post(
                  Uri.parse('https://praktikum-cpanel-unbin.com/kelompok_rio/api.php?endpoint=agenda'),
                  body: json.encode({
                    'judul_agenda': judul,
                    'isi_agenda': isi,
                    'tgl_agenda': tanggal,
                    'tgl_post_agenda': DateTime.now().toIso8601String(),
                    'status_agenda': '1',
                    'kd_petugas': '1'
                  }),
                  headers: {'Content-Type': 'application/json'},
                );
                
                if (response.statusCode == 200) {
                  Navigator.of(context).pop();
                  setState(() {});
                } else {
                  // Tampilkan pesan error
                }
              },
            ),
          ],
        );
      },
    );
  }

  // Fungsi untuk mengupdate data
  void _updateData(Map<String, dynamic> agenda) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String judul = agenda['judul_agenda'];
        String isi = agenda['isi_agenda'];
        String tanggal = agenda['tgl_agenda'];
        
        return AlertDialog(
          title: Text('Update Data', style: TextStyle(color: Theme.of(context).primaryColor)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Judul Agenda',
                  labelStyle: TextStyle(color: Theme.of(context).primaryColor),
                ),
                onChanged: (value) => judul = value,
                controller: TextEditingController(text: judul),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Isi Agenda',
                  labelStyle: TextStyle(color: Theme.of(context).primaryColor),
                ),
                onChanged: (value) => isi = value,
                controller: TextEditingController(text: isi),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Tanggal Agenda',
                  labelStyle: TextStyle(color: Theme.of(context).primaryColor),
                ),
                onChanged: (value) => tanggal = value,
                controller: TextEditingController(text: tanggal),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Batal', style: TextStyle(color: Theme.of(context).primaryColor)),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Simpan', style: TextStyle(color: Theme.of(context).primaryColor)),
              onPressed: () async {
                final response = await http.put(
                  Uri.parse('https://praktikum-cpanel-unbin.com/kelompok_rio/api.php?endpoint=agenda'),
                  body: json.encode({
                    'kd_agenda': agenda['kd_agenda'],
                    'judul_agenda': judul,
                    'isi_agenda': isi,
                    'tgl_agenda': tanggal,
                    'tgl_post_agenda': agenda['tgl_post_agenda'],
                    'status_agenda': agenda['status_agenda'],
                    'kd_petugas': agenda['kd_petugas']
                  }),
                  headers: {'Content-Type': 'application/json'},
                );
                
                if (response.statusCode == 200) {
                  Navigator.of(context).pop();
                  setState(() {});
                } else {
                  // Tampilkan pesan error
                }
              },
            ),
          ],
        );
      },
    );
  }

  // Fungsi untuk menghapus data
  void _deleteData(String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Hapus Data', style: TextStyle(color: Theme.of(context).primaryColor)),
          content: Text('Apakah Anda yakin ingin menghapus data ini?', style: TextStyle(color: Theme.of(context).primaryColor)),
          actions: <Widget>[
            TextButton(
              child: Text('Batal', style: TextStyle(color: Theme.of(context).primaryColor)),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Hapus', style: TextStyle(color: Theme.of(context).primaryColor)),
              onPressed: () async {
                final response = await http.delete(
                  Uri.parse('https://praktikum-cpanel-unbin.com/kelompok_rio/api.php?endpoint=agenda&kd_agenda=$id'),
                );
                
                if (response.statusCode == 200) {
                  Navigator.of(context).pop();
                  setState(() {});
                } else {
                  // Tampilkan pesan error
                }
              },
            ),
          ],
        );
      },
    );
  }

  // Fungsi untuk menampilkan detail agenda
  void _showAgendaDetail(Map<String, dynamic> agenda) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(agenda['judul_agenda'], style: TextStyle(color: Theme.of(context).primaryColor)),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Deskripsi:', style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor)),
              Text(agenda['isi_agenda'], style: TextStyle(color: Theme.of(context).primaryColor)),
              SizedBox(height: 10),
              Text('Tanggal:', style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor)),
              Text(agenda['tgl_agenda'], style: TextStyle(color: Theme.of(context).primaryColor)),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Tutup', style: TextStyle(color: Theme.of(context).primaryColor)),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Agenda',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ),
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              icon: Icon(Icons.add, color: Theme.of(context).primaryColor),
              onPressed: _addData,
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: FutureBuilder<List<dynamic>>(
        future: fetchAgenda(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor));
          } else if (snapshot.hasError) {
            return Center(child: Text('Gagal memuat data', style: TextStyle(color: Theme.of(context).primaryColor)));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Tidak ada data', style: TextStyle(color: Theme.of(context).primaryColor)));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var agenda = snapshot.data![index];
                return ListTile(
                  title: Text(agenda['judul_agenda'], style: TextStyle(color: Theme.of(context).primaryColor)),
                  subtitle: Text(agenda['tgl_agenda'], style: TextStyle(color: Theme.of(context).primaryColor)),
                  onTap: () => _showAgendaDetail(agenda),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Theme.of(context).primaryColor),
                        onPressed: () => _updateData(agenda),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Theme.of(context).primaryColor),
                        onPressed: () => _deleteData(agenda['kd_agenda']),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
