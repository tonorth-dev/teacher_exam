import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<bool> _isHovering = List.generate(4, (index) => false);
  final ScrollController _scrollController = ScrollController();
  final List<int> _highlightedItems = [2]; // Example: Highlight the third item

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(95),
        child: AppBar(
          title: const Text(''),
          centerTitle: true,
          flexibleSpace: FlexibleSpaceBar(
            background: Image.asset(
              'assets/images/exam_banner_logo.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/exam_page_bg.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.5),
              BlendMode.dstATop,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(
                  4,
                      (index) => MouseRegion(
                    onEnter: (_) => setState(() => _isHovering[index] = true),
                    onExit: (_) => setState(() => _isHovering[index] = false),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.asset(
                            'assets/images/exam_btn_bg${index + 1}.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            print('Button $index clicked!');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(405, 110),
                            maximumSize: const Size(405, 110),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: _isHovering[index] ? 5 : 0,
                            shadowColor: Colors.black.withAlpha((0.25 * 255).round()),
                          ),
                          child: Center(
                            child: Text(
                              ['', '', '', ''][index],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 0),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLeftPanel(),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildRightPanel(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Left panel with user info and logs
  Widget _buildLeftPanel() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      width: 314,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildUserInfo(),
          const SizedBox(height: 20),
          _buildSystemLogs(),
        ],
      ),
    );
  }

  Widget _buildUserInfo() {
    return Container(
      width: 314,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('assets/images/student_header.png'),
            const SizedBox(height: 10),
            _buildInfoRow('考生姓名：', '张小菲'),
            const SizedBox(height: 10),
            _buildInfoRow('岗位代码：', '2024007013'),
            const SizedBox(height: 10),
            _buildInfoRow('岗位类别：', '工程'),
            const SizedBox(height: 10),
            _buildInfoRow('岗位名称：', '助理工程师'),
            const SizedBox(height: 10),
            _buildInfoRow('从事工作：', '装备质量监督'),
          ],
        ),
      ),
    );
  }

  // System logs section
  Widget _buildSystemLogs() {
    return Container(
      width: 314,
      height: 350,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('assets/images/log_header.png'),
            const SizedBox(height: 20),
            Text(
              '向【面试终端】发送信息\n' * 5 + '【172.16.64.132：60143】',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w400,
                height: 1.88,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Section header for user info or logs
  Widget _buildSectionHeader(String bgImg) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(bgImg),
          fit: BoxFit.contain,
          alignment: Alignment.centerLeft,
        ),
      ),
      child: Text(
        "",
      ),
    );
  }

  // Builds an info row for user details
  Widget _buildInfoRow(String label, String value) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w400,
              height: 1.38,
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontFamily: 'PingFang SC',
            fontWeight: FontWeight.w400,
            height: 1.38,
          ),
        ),
      ],
    );
  }

  // Right panel with question content and timer
  Widget _buildRightPanel() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: _buildQuestionContent(),
            ),
            const SizedBox(width: 38),
            _buildTimer(),
          ],
        ),
      ),
    );
  }

  // Question content section
  Widget _buildQuestionContent() {
    return Container(
      decoration: BoxDecoration(
        color: Color(0x70FFDBDB),
        borderRadius: BorderRadius.circular(2),
      ),
      child: ListView.builder(
        controller: _scrollController,
        itemCount: 6, // Adjust based on your number of questions
        itemBuilder: (context, index) => _buildQuestion(index: index),
      ),
    );
  }

  // Individual question layout
  Widget _buildQuestion({required int index}) {
    bool isHighlighted = _highlightedItems.contains(index);
    Color backgroundColor = isHighlighted ? Colors.yellow : Colors.white;

    // Scroll to the highlighted item if it's not visible
    if (isHighlighted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToIndex(index);
      });
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.grey[50],
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/question_icon.png',
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(width: 10),
                  Text('军队有大量的规章制度和条令条例，纪律严明，你怎么看?', style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/images/answer_icon.png',
                  width: 24,
                  height: 48,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    '没有特殊待遇...没有特殊待遇...没有特殊待遇...没有特殊待遇...没有特殊待遇...没有特殊待遇...没有特殊待遇...没有特殊待遇...没有特殊待遇...没有特殊待遇...没有特殊待遇...没有特殊待遇...没有特殊待遇...没有特殊待遇...没有特殊待遇...没有特殊待遇...没有特殊待遇...没有特殊待遇...没有特殊待遇...没有特殊待遇...没有特殊待遇...没有特殊待遇...没有特殊待遇...没有特殊待遇...没有特殊待遇...没有特殊待遇...没有特殊待遇...没有特殊待遇...没有特殊待遇...没有特殊待遇...没有特殊待遇...',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.7),
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Timer section
  Widget _buildTimer() {
    return Container(
      width: 320,
      height: 1000,
      decoration: BoxDecoration(
        color: Colors.red[400],
        borderRadius: BorderRadius.circular(2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              '答题时间',
              style: TextStyle(
                color: Color(0xFFFFF3E6),
                fontSize: 30,
                fontFamily: 'YouSheBiaoTiHei',
                fontWeight: FontWeight.w400,
                height: 1.30,
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Text(
                      '00:00:00',
                      style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _scrollToIndex(int index) {
    if (_scrollController.hasClients) {
      final itemExtent = 200.0; // Adjust this based on the actual height of each question item
      _scrollController.animateTo(
        index * itemExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }
}