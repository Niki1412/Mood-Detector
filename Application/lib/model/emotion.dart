class Emotion {
  final String day;
  final String colorVal;
  final int moodScore;

  Emotion({required this.colorVal, required this.day, required this.moodScore});

  Emotion.fromMap(Map<String, dynamic> map)
      : assert(map['day'] != null),
        assert(map['colorVal']),
        assert(map['moodScore'] != null),
        day = map['day'],
        colorVal = map['colorVal'],
        moodScore = map['moodScore'];
}
