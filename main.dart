import 'package:flutter/material.dart';

void main() {
  runApp(const AloApp());
}

class AloApp extends StatelessWidget {
  const AloApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ALO AI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0B1220),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF67C8E8),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const AloHomePage(),
    );
  }
}

class AloHomePage extends StatefulWidget {
  const AloHomePage({super.key});

  @override
  State<AloHomePage> createState() => _AloHomePageState();
}

class _AloHomePageState extends State<AloHomePage> {
  final TextEditingController _controller = TextEditingController();
  final List<_ChatMessage> _messages = [
    const _ChatMessage(
      text: 'Halo, Bos. Saya ALO, asisten AI pribadi Anda. '
          'Saat ini saya masih dalam tahap awal. Kita akan '
          'menghubungkan otak AI, suara, dan memori pada tahap berikutnya.',
      isUser: false,
    ),
  ];

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(_ChatMessage(text: text, isUser: true));
      _messages.add(const _ChatMessage(
        text: 'Pesan diterima, Bos. Antarmuka ALO sudah berjalan. '
            'Koneksi ke layanan AI akan ditambahkan pada tahap berikutnya.',
        isUser: false,
      ));
      _controller.clear();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF101B2C),
        title: const Row(
          children: [
            Icon(Icons.auto_awesome, color: Color(0xFF83DDF5)),
            SizedBox(width: 10),
            Text('ALO', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Tentang ALO',
            onPressed: () => showAboutDialog(
              context: context,
              applicationName: 'ALO AI',
              applicationVersion: '1.0.0',
              applicationLegalese: 'Prototipe tahap pertama.',
            ),
            icon: const Icon(Icons.info_outline),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 18),
            Container(
              width: 116,
              height: 116,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [Color(0xFF8BE2F4), Color(0xFF426EAE)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF61CDEB).withOpacity(0.22),
                    blurRadius: 28,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: const Icon(
                Icons.face_3_rounded,
                size: 70,
                color: Color(0xFF102033),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'ALO',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const Text(
              'ASISTEN AI PRIBADI',
              style: TextStyle(
                color: Color(0xFF83DDF5),
                fontSize: 10,
                letterSpacing: 2.2,
              ),
            ),
            const SizedBox(height: 14),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(14, 8, 14, 12),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  return Align(
                    alignment: message.isUser
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 310),
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      padding: const EdgeInsets.all(13),
                      decoration: BoxDecoration(
                        color: message.isUser
                            ? const Color(0xFF24516B)
                            : const Color(0xFF172438),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Text(message.text),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 14),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => _sendMessage(),
                      decoration: InputDecoration(
                        hintText: 'Ketik pesan untuk ALO...',
                        filled: true,
                        fillColor: const Color(0xFF172438),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 14,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    backgroundColor: const Color(0xFF79D5EC),
                    child: IconButton(
                      onPressed: _sendMessage,
                      color: const Color(0xFF102033),
                      icon: const Icon(Icons.arrow_upward),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChatMessage {
  final String text;
  final bool isUser;

  const _ChatMessage({required this.text, required this.isUser});
}
