import 'package:flutter/material.dart';
import 'package:super_sliver_list/super_sliver_list.dart';
import '../../component/widget.dart';
import './countdown_logic.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _listController = ListController();
  final ScrollController _scrollController = ScrollController();
  List<int> _highlightedItems = [2]; // Example: Highlight the third item
  List<bool> _isHovering =
      List.generate(4, (_) => false); // Initialize hover state
  late Countdown _countdown;

  @override
  void initState() {
    super.initState();
    _countdown = Countdown(
        totalDuration: 900); // Default total duration in seconds (15 minutes)
    _listenToCountdown();
  }

  @override
  void dispose() {
    _countdown.dispose();
    _scrollController.dispose();
    _listController.dispose(); // Don't forget to dispose ListController
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
                            shadowColor:
                                Colors.black.withAlpha((0.25 * 255).round()),
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
          for (int i = 0;
              i < 7;
              i++) // Changed to 7 to match your button indices
            HoverTextButton(
              onTap: () {
                setState(() {
                  _highlightedItems = [i];
                  print(i);
                  if (i < 6) {
                    // Ensure index is within bounds
                    _listController.animateToItem(
                      index: i,
                      scrollController: _scrollController,
                      alignment: 0.5,
                      duration: (estimatedDistance) =>
                          Duration(milliseconds: 500),
                      curve: (estimatedDistance) => Curves.easeInOut,
                    );
                  }
                });
              },
              text: "测试$i",
            ),
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

  Widget _buildQuestionContent() {
    return Container(
      decoration: BoxDecoration(
        color: Color(0x70FFDBDB),
        borderRadius: BorderRadius.circular(2),
      ),
      child: Column(
        children: [
          SizedBox(height: 15),
          Image.asset(
            'assets/images/question_header.png',
            width: 200,
          ),
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: SuperListView.builder(
                listController: _listController,
                controller: _scrollController,
                itemCount: 6, // Adjust based on your number of questions
                itemBuilder: (context, index) => _buildQuestion(index: index),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestion({required int index}) {
    bool isHighlighted = _highlightedItems.contains(index);
    Color? backgroundColor = isHighlighted ? Color(0xFFEAF7FE) : Colors.white;

    // Scroll to the item after building, but only if it's highlighted and the frame has been laid out
    if (isHighlighted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _listController.animateToItem(
          index: index,
          scrollController: _scrollController,
          alignment: 0.5,
          duration: (estimatedDistance) => Duration(milliseconds: 500),
          curve: (estimatedDistance) => Curves.easeInOut,
        );
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
                  Text('军队有大量的规章制度和条令条例，纪律严明，你怎么看?',
                      style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              color: Colors.grey[50],
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/images/answer_icon.png',
                    width: 24,
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimer() {
    return Container(
      width: 340,
      height: 800, // Adjusted height for better layout
      decoration: BoxDecoration(
        color: Colors.red[400],
        borderRadius:
            BorderRadius.circular(2), // Increased border radius for aesthetics
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              width: 200,
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Image.asset(
                'assets/images/timer_header.png',
                fit: BoxFit.fill,
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                      2), // Increased border radius for aesthetics
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 54,
                          fontWeight: FontWeight.bold,
                          color: Colors.red, // 根据需要调整颜色
                          fontFamily: 'Anton-Regular', // 根据需要调整字体
                        ),
                        children: [
                          TextSpan(
                            text: '${(_countdown.currentSeconds ~/ 60).toString().padLeft(2, '0')[0]}',
                          ),
                          TextSpan(
                            text: ' ', // 增加秒的两位数之间的间距
                            style: TextStyle(
                              color: Colors.transparent, // 透明颜色
                              fontSize: 54, // 与分钟和秒相同的字体大小
                            ),
                          ),
                          TextSpan(
                            text: '${(_countdown.currentSeconds ~/ 60).toString().padLeft(2, '0')[1]}',
                          ),
                          TextSpan(
                            text: ' : ', // 增加冒号两边的间距
                          ),
                          TextSpan(
                            text: '${(_countdown.currentSeconds % 60).toString().padLeft(2, '0')[0]}',
                          ),
                          TextSpan(
                            text: ' ', // 增加秒的两位数之间的间距
                            style: TextStyle(
                              color: Colors.transparent, // 透明颜色
                              fontSize: 54, // 与分钟和秒相同的字体大小
                            ),
                          ),
                          TextSpan(
                            text: '${(_countdown.currentSeconds % 60).toString().padLeft(2, '0')[1]}',
                          ),
                        ],
                      ),
                    ),
                  ),
                  //todo 我想在这里加一个按钮，按钮可以设置背景图片并有鼠标悬浮和点击效果
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  child: Text(_countdown.isRunning ? 'Pause' : 'Start'),
                  onPressed: () => _countdown.startOrResume(),
                ),
                ElevatedButton(
                  child: Text('Restart'),
                  onPressed: () => _countdown.restart(900),
                ),
                ElevatedButton(
                  child: Text('Mark Segment'),
                  onPressed: () => _countdown.markSegment(),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Display segments using StreamBuilder
            StreamBuilder<List<String>>(
              stream: _countdown.segmentsStream,
              initialData: [],
              builder: (context, snapshot) {
                final segments = snapshot.data ?? [];
                return segments.isNotEmpty
                    ? Text(
                        '分段: ${segments.join(", ")}',
                        style: const TextStyle(fontSize: 18),
                      )
                    : const Text('暂无分段', style: TextStyle(fontSize: 18));
              },
            ),
          ],
        ),
      ),
    );
  }

  void animateToItem(int index) {
    _listController.animateToItem(
      index: index,
      scrollController: _scrollController,
      alignment: 0.5,
      duration: (estimatedDistance) => Duration(milliseconds: 500),
      curve: (estimatedDistance) => Curves.easeInOut,
    );
  }

  void _listenToCountdown() {
    _countdown.tickStream.listen((seconds) {
      setState(() {});
    });

    _countdown.isRunningStream.listen((isRunning) {
      setState(() {});
    });

    _countdown.segmentsStream.listen((segments) {
      setState(() {});
    });
  }
}
