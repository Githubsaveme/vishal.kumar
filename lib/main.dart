import 'package:flutter/material.dart';
import 'package:my_site/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(VishalWebsite());
}

class VishalWebsite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vishal Kumar',
      theme: ThemeData(
        brightness: Brightness.dark,
        textTheme: const TextTheme(
          displayLarge: TextStyle(
              fontSize: 72, fontWeight: FontWeight.bold, letterSpacing: 1.5),
          bodyLarge: TextStyle(fontSize: 20, color: Colors.white70),
        ),
      ),
      home: LandingPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundImage(),
          Column(
            children: [
              Header(),
              const Expanded(
                child: ContentSections(),
              ),
              Footer(),
            ],
          ),
        ],
      ),
    );
  }
}

class BackgroundImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage('assets/black.jpg'),
          // Add a Kanye-inspired background image
          fit: BoxFit.cover,
          colorFilter:
              ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.darken),
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('VISHAL KUMAR', style: Theme.of(context).textTheme.displayLarge),
          Row(
            children: [
              NavButton(
                  label: 'Linked in',
                  onPressed: () {
                    launchUrl(
                        Uri.parse('https://www.linkedin.com/in/vishalk3/'));
                  }),
              NavButton(
                  label: 'Gmail',
                  onPressed: () {
                    launchUrl(emailLaunchUri);
                  }),
            ],
          ),
        ],
      ),
    );
  }
}

class NavButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  NavButton({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        label,
        style: const TextStyle(color: Colors.white70, fontSize: 18),
      ),
    );
  }
}

class ContentSections extends StatefulWidget {
  const ContentSections({super.key});

  @override
  State<ContentSections> createState() => _ContentSectionsState();
}

class _ContentSectionsState extends State<ContentSections> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Section(
            title: 'Projects',
            content: 'Explore Vishal\'s latest applications...',
          ),
          const SizedBox(height: 10),
          Visibility(visible: isHovered, child: ProjectView()),
        ],
      ),
    );
  }
}

class Section extends StatelessWidget {
  final String title;
  final String content;

  Section({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 40),
        Text(
          title,
          style:
              Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 36),
        ),
        const SizedBox(height: 16),
        Text(
          content,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Text(
        '© 2024 Vishal Kumar',
        style: TextStyle(color: Colors.white54, fontSize: 14),
      ),
    );
  }
}

class ProjectView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<AppData> items = [
      AppData(
          name: " name",
          description: 'description',
          androidUrl: "androidUrl",
          iosUrl: "iosUrl",
          windowsUrl: " windowsUrl",
          icon: ''),
    ];
    return Expanded(
      child: GridView.builder(
          padding: const EdgeInsets.all(10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 10, // Number of items per row
            crossAxisSpacing: 10, // Horizontal spacing between items
            mainAxisSpacing: 10, // Vertical spacing between items
            childAspectRatio: 1, // Ratio for item size
          ),
          itemCount: items.length, // Total number of items
          itemBuilder: (context, index) {
            return DownloadButton(
                label: items[index].name, url: items[index].androidUrl);
          }),
    );
  }
}

////--------------------------------------------

// Data model for app information
class AppData {
  final String name;
  final String icon;
  final String description;
  final String androidUrl;
  final String iosUrl;
  final String windowsUrl;

  AppData({
    required this.name,
    required this.icon,
    required this.description,
    required this.androidUrl,
    required this.iosUrl,
    required this.windowsUrl,
  });
}

// Download Button Widget
class DownloadButton extends StatelessWidget {
  final String label;
  final String url;

  DownloadButton({required this.label, required this.url});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () async {
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          throw 'Could not launch $url';
        }
      },
      icon: const Icon(Icons.download),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }
}
