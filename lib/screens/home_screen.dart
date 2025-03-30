import 'package:flutter/material.dart';
import '../widgets/writing_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _tabs = ['Vocabulary', 'Sentence', 'Writing'];
  int _currentIndex = 2; // 默认选中Writing标签
  final List<List<String>> _cardTopics = [[], [], []]; // 每个标签页的卡片内容

  void _addTab() {
    setState(() {
      _tabs.insert(_currentIndex + 1, 'Reading');
      _cardTopics.insert(_currentIndex + 1, []);
      _currentIndex = _currentIndex + 1;
    });
  }

  void _removeTab(int index) {
    if (_tabs.length <= 1) return; // 保持至少一个标签
    setState(() {
      _tabs.removeAt(index);
      _cardTopics.removeAt(index);
      if (_currentIndex >= _tabs.length) {
        _currentIndex = _tabs.length - 1;
      }
    });
  }

  void _addCard() {
    setState(() {
      _cardTopics[_currentIndex].add('');
    });
  }

  void _removeCard(int cardIndex) {
    setState(() {
      _cardTopics[_currentIndex].removeAt(cardIndex);
    });
  }

  void _updateCardTopic(int cardIndex, String topic) {
    setState(() {
      _cardTopics[_currentIndex][cardIndex] = topic;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 40, left: 4),
            child: Row(
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    // 返回功能
                  },
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 48,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        // Expanded(
                        //   child: ,
                        // ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(_tabs.length, (index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _currentIndex = index;
                                    });
                                  },
                                  child: Chip(
                                    label: Text(_tabs[index]),
                                    backgroundColor: _currentIndex == index
                                        ? Colors.blue
                                        : Colors.grey[200],
                                    labelStyle: TextStyle(
                                      color: _currentIndex == index
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                    deleteIcon: const Icon(Icons.close, size: 18),
                                    onDeleted: () => _removeTab(index),
                                    labelPadding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 0,
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        )   ,
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: _addTab,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _cardTopics[_currentIndex].length + 1,
              itemBuilder: (context, index) {
                if (index == _cardTopics[_currentIndex].length) {
                  return Center(
                    child: IconButton(
                      icon: const Icon(Icons.add_circle_outline, size: 30),
                      onPressed: _addCard,
                    ),
                  );
                }
                return WritingCard(
                  key: ValueKey('card_$_currentIndex\_$index'),
                  topic: _cardTopics[_currentIndex][index],
                  onTopicChanged: (value) => _updateCardTopic(index, value),
                  onDelete: () => _removeCard(index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
} 