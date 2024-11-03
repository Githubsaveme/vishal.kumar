String? encodeQueryParameters(Map<String, String> params) {
  return params.entries
      .map((MapEntry<String, String> e) =>
          '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
      .join('&');
}

final Uri emailLaunchUri = Uri(
  scheme: 'mailto',
  path: 'vishalkumar.enggm@gmail.com',
  query: encodeQueryParameters(<String, String>{
    'subject': 'Write subject',
  }),
);
