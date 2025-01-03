import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:super_sliver_list/super_sliver_list.dart';
import 'package:teacher_exam/app/home/head/logic.dart';
import '../../component/widget.dart';
import './countdown_logic.dart';
import 'home_logic.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _listController = ListController();
  final ScrollController _scrollController = ScrollController();
  List<int> _highlightedItems = [2]; // Example: Highlight the third item
  final List<bool> _isHovering = List.generate(4, (_) => false); // Initialize hover state
  late Countdown countdownLogic;
  final headerLogic = Get.put(HeadLogic());
  final homeLogic = Get.put(HomeLogic());

  @override
  void initState() {
    super.initState();
    countdownLogic = Countdown(
        totalDuration: 900); // Default total duration in seconds (15 minutes)
    _listenToCountdown();
  }

  @override
  void dispose() {
    countdownLogic.dispose();
    _scrollController.dispose();
    _listController.dispose(); // Don't forget to dispose ListController
    headerLogic.dispose();
    homeLogic.dispose();
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
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: InkWell(
                borderRadius: BorderRadius.circular(32),
                onTap: () {
                  headerLogic.clickHeadImage();
                },
                child: ClipOval(
                  child: Image.asset(
                    "assets/images/cat.jpeg",
                    height: 42,
                    width: 42,
                  ),
                ),
              ),
            ),
          ],
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
                children: [
                  MouseRegion(
                    onEnter: (_) => setState(() => _isHovering[0] = true),
                    onExit: (_) => setState(() => _isHovering[0] = false),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.asset(
                            'assets/images/exam_btn_bg1.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            homeLogic.pullExam();
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
                            elevation: _isHovering[0] ? 5 : 0,
                            shadowColor: Colors.black.withAlpha((0.25 * 255).round()),
                          ),
                          child: Center(
                            child: Text(
                              '', // 替换为实际文本
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
                  MouseRegion(
                    onEnter: (_) => setState(() => _isHovering[1] = true),
                    onExit: (_) => setState(() => _isHovering[1] = false),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.asset(
                            countdownLogic.isRunning ? 'assets/images/exam_btn_bg2_2.png' : 'assets/images/exam_btn_bg2_1.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => countdownLogic.startOrResume(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(405, 110),
                            maximumSize: const Size(405, 110),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: _isHovering[1] ? 5 : 0,
                            shadowColor: Colors.black.withAlpha((0.25 * 255).round()),
                          ),
                          child: Center(
                            child: Text(
                              '', // 替换为实际文本
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
                  MouseRegion(
                    onEnter: (_) => setState(() => _isHovering[2] = true),
                    onExit: (_) => setState(() => _isHovering[2] = false),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.asset(
                            'assets/images/exam_btn_bg3.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            countdownLogic.stop();
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
                            elevation: _isHovering[2] ? 5 : 0,
                            shadowColor: Colors.black.withAlpha((0.25 * 255).round()),
                          ),
                          child: Center(
                            child: Text(
                              '', // 替换为实际文本
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
                  MouseRegion(
                    onEnter: (_) => setState(() => _isHovering[3] = true),
                    onExit: (_) => setState(() => _isHovering[3] = false),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.asset(
                            'assets/images/exam_btn_bg4.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            print('Button 3 clicked!');
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
                            elevation: _isHovering[3] ? 5 : 0,
                            shadowColor: Colors.black.withAlpha((0.25 * 255).round()),
                          ),
                          child: Center(
                            child: Text(
                              '', // 替换为实际文本
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
                ],
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
        borderRadius: BorderRadius.circular(2), // Increased border radius for aesthetics
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Timer header image
            Container(
              width: double.infinity, // Make it stretch horizontally
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Image.asset(
                'assets/images/timer_header.png',
                height: 46,
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  // White container with time display and button inside
                  Container(
                    width: double.infinity,
                    height: 550, // Adjusted height for better layout
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(2), // Match with parent container
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          // Time display at the top of the white container
                          Center(
                            child: RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  fontSize: 54,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                  fontFamily: 'Anton-Regular',
                                ),
                                children: [
                                  TextSpan(text: (countdownLogic.currentSeconds ~/ 60).toString().padLeft(2, '0')[0]),
                                  TextSpan(
                                    text: ' ', // Increase space between digits of minutes
                                    style: TextStyle(color: Colors.transparent, fontSize: 54),
                                  ),
                                  TextSpan(text: (countdownLogic.currentSeconds ~/ 60).toString().padLeft(2, '0')[1]),
                                  TextSpan(text: ' : '), // Increase space around colon
                                  TextSpan(text: (countdownLogic.currentSeconds % 60).toString().padLeft(2, '0')[0]),
                                  TextSpan(
                                    text: ' ', // Increase space between digits of seconds
                                    style: TextStyle(color: Colors.transparent, fontSize: 54),
                                  ),
                                  TextSpan(text: (countdownLogic.currentSeconds % 60).toString().padLeft(2, '0')[1]),
                                ],
                              ),
                            ),
                          ),
                          if (countdownLogic.showElapsedTime)
                            Center(
                              child: Text(
                                '本次共用时${(countdownLogic.totalDuration - countdownLogic.currentSeconds) ~/ 60}分${(countdownLogic.totalDuration - countdownLogic.currentSeconds) % 60}秒',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.orange,
                                  fontFamily: 'PingFang SC',
                                ),
                              ),
                          ),
                          const SizedBox(height: 20), // Space between time and button
                          // Custom button directly below the time display
                          _buildCustomButton(),
                          const SizedBox(height: 20),
                          // Display segments using ListView
                          Expanded(
                            child: StreamBuilder<List<String>>(
                              stream: countdownLogic.segmentsStream,
                              initialData: [],
                              builder: (context, snapshot) {
                                final segments = snapshot.data ?? [];
                                return ListView.builder(
                                  itemCount: segments.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      leading: Text(
                                        '第${index + 1}段用时：',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'PingFang SC',
                                        ),
                                      ),
                                      title: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          segments[index],
                                          style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.redAccent,
                                            fontFamily: 'OPPOSans',
                                          ),
                                        ),
                                      ),
                                    );

                                  },
                                );
                              },
                            ),
                          ),
                        ],
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


// The custom button widget remains unchanged
  Widget _buildCustomButton() {
    return Container(
      width: double.infinity, // Make the button stretch horizontally
      height: 50, // Adjust based on design needs
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/timer_seg.png'),
          fit: BoxFit.fill,
        ),
        borderRadius: BorderRadius.circular(2), // Match with parent container
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            countdownLogic.markSegment();
          },
          onHover: (isHovering) {
            // Optional: Change state or appearance when hovered
          },
          child: Center(
            child: Text(
              '分段计时', // Button label
              style: TextStyle(
                color: Colors.white, // Label color
                fontSize: 20, // Label size
                fontWeight: FontWeight.bold, // Label weight
              ),
            ),
          ),
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
    countdownLogic.tickStream.listen((seconds) {
      setState(() {});
    });

    countdownLogic.isRunningStream.listen((isRunning) {
      setState(() {});
    });

    countdownLogic.segmentsStream.listen((segments) {
      setState(() {});
    });
  }
}
