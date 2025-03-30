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
  final List<List<String>> _cardTopics = [
    [''], // Vocabulary 默认一个空卡片
    [''], // Sentence 默认一个空卡片
    [''], // Writing 默认一个空卡片
  ];

  void _addTab() {
    setState(() {
      _tabs.insert(_currentIndex + 1, 'Reading');
      _cardTopics.insert(_currentIndex + 1, ['']); // 新标签页也默认一个空卡片
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
                    height: 96,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.blue,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: List.generate(_tabs.length, (index) {
                                return IntrinsicHeight(
                                  child: Row(
                                    children: [
                                      if (index > 0)
                                        VerticalDivider(
                                          color: Colors.grey[300],
                                          width: 1,
                                          thickness: 1,
                                        ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            _currentIndex = index;
                                          });
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 16,
                                          ),
                                          decoration: BoxDecoration(
                                            color: _currentIndex == index
                                                ? Colors.blue
                                                : Colors.transparent,
                                          ),
                                          child: Row(
                                            children: [
                                              Text(
                                                _tabs[index],
                                                style: TextStyle(
                                                  color: _currentIndex == index
                                                      ? Colors.white
                                                      : Colors.black,
                                                ),
                                              ),
                                              const SizedBox(width: 4),
                                              InkWell(
                                                onTap: () => _removeTab(index),
                                                child: Icon(
                                                  Icons.close,
                                                  size: 16,
                                                  color: _currentIndex == index
                                                      ? Colors.white
                                                      : Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            ),
                          ),
                        ),
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
            child: Stack(
              children: [
                ListView.builder(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 80),
                  itemCount: _cardTopics[_currentIndex].length,
                  itemBuilder: (context, index) {
                    return WritingCard(
                      key: ValueKey('card_$_currentIndex\_$index'),
                      topic: _cardTopics[_currentIndex][index],
                      onTopicChanged: (value) => _updateCardTopic(index, value),
                      onDelete: () => _removeCard(index),
                      index: index,
                    );
                  },
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 20,
                  child: Center(
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.add_circle_outline,
                          size: 30,
                          color: Colors.blue,
                        ),
                        onPressed: _addCard,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 