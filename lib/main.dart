import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MeridianMasterApp());
}

class MeridianMasterApp extends StatelessWidget {
  const MeridianMasterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    title: '十二经脉学习',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isChinese = true;
  int _currentIndex = 0;
  DateTime _currentTime = DateTime.now();
  Timer? _timer;
  
    void _showAboutDialog() {
    final isEn = !isChinese;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isEn ? "About This App" : "关于本应用"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(isEn ? "Developed by Yanfang" : "开发者：Yanfang"),
              const SizedBox(height: 12),
              Text(isEn 
                  ? "This educational app is designed to help people learn the Twelve Meridians and daily acupoint care.\n\nThank you for using it!"
                  : "这是一个帮助大家学习十二经脉和日常保健取穴的中医教育应用。\n\n感谢您的使用！"),
              const SizedBox(height: 16),
              Text(isEn ? "Contact & Cooperation:" : "交流与合作："),
              const SizedBox(height: 4),
              const SelectableText("wangyanfang2023@gmail.com", style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(isEn ? "Close" : "关闭"),
          ),
        ],
      ),
    );
  }
    final List<Map<String, dynamic>> meridians = [
    {
      "name": "手太阴肺经", "en": "Lung Meridian", "element": "金", "organ": "肺", "time": "3-5",
      "path": "起于中焦，下络大肠，还循胃口，上膈属肺。从肺系横出腋下，循上臂内侧，下行至寸口，出拇指末端。",
      "pathEn": "Starts in the middle jiao, connects to the large intestine, returns along the stomach, passes through the diaphragm to the lung. Emerges horizontally from the axillary fossa, runs along the medial side of the upper arm, descends to the wrist (cunkou), and ends at the tip of the thumb.",
      "function": "肺主气、司呼吸，朝百脉，调节全身气血运行，与大肠相表里，主皮毛。",
      "functionEn": "The Lung governs Qi and respiration, commands the hundred vessels, regulates Qi and blood circulation throughout the body, is internally-externally related to the Large Intestine, and governs the skin and body hair.",
      "indication": "咳嗽、气喘、胸痛、咽喉肿痛、鼻塞、皮肤病。",
      "indicationEn": "Cough, asthma, chest pain, sore throat, nasal congestion, skin diseases.",
      "timeInfo": "寅时（3-5点）—— 肺经最旺",
      "timeInfoEn": "Yin Hour (3-5 AM) — Lung Meridian Peak",
      "yangsheng": "寅时肺经最旺，宜安静休息或深睡养肺。肺为娇脏，喜润恶燥，此时养肺可提升全天免疫力。",
      "yangshengEn": "During Yin hour the Lung meridian is strongest. It is best to rest quietly or sleep deeply to nourish the Lung. The Lung is a delicate organ that prefers moisture and dislikes dryness. Nourishing it at this time greatly enhances whole-day immunity.",
      "diet": "推荐：梨、银耳、百合、莲子、杏仁、蜂蜜、白萝卜、绿豆。",
      "dietEn": "Recommended: Pear, tremella fungus, lily bulb, lotus seed, almond, honey, white radish, mung bean."
    },
    {
      "name": "手阳明大肠经", "en": "Large Intestine Meridian", "element": "金", "organ": "大肠", "time": "5-7",
      "path": "起于食指末端，沿上肢外侧上行至肩，过颈部，入面部，止于鼻旁。",
      "pathEn": "Starts at the tip of the index finger, ascends along the lateral side of the upper limb to the shoulder, passes through the neck, enters the face, and ends beside the nose.",
      "function": "传导糟粕，排泄废物，与肺相表里，主津液代谢。",
      "functionEn": "Transports and excretes waste, internally-externally related to the Lung, governs fluid metabolism.",
      "indication": "便秘、腹泻、牙痛、面瘫、鼻塞、肩臂痛。",
      "indicationEn": "Constipation, diarrhea, toothache, facial paralysis, nasal congestion, shoulder and arm pain.",
      "timeInfo": "卯时（5-7点）—— 大肠经最旺",
      "timeInfoEn": "Mao Hour (5-7 AM) — Large Intestine Meridian Peak",
      "yangsheng": "卯时大肠经旺，宜起床后喝温水，促进排便排毒。",
      "yangshengEn": "During Mao hour the Large Intestine meridian is strong. Drink warm water after getting up to promote bowel movement and detoxification.",
      "diet": "推荐：香蕉、菠菜、芹菜、木耳、玉米、苹果。",
      "dietEn": "Recommended: Banana, spinach, celery, wood ear mushroom, corn, apple."
    },
    {
      "name": "足阳明胃经", "en": "Stomach Meridian", "element": "土", "organ": "胃", "time": "7-9",
      "path": "起于鼻旁，沿面部下行，入胃，沿下肢前侧至足背第二趾。",
      "pathEn": "Starts beside the nose, descends along the face, enters the stomach, runs down the anterior side of the lower limb to the second toe.",
      "function": "主受纳腐熟水谷，为后天之本，化生气血。",
      "functionEn": "Receives and decomposes food and drink, is the root of acquired constitution, generates Qi and Blood.",
      "indication": "胃痛、消化不良、腹胀、牙痛、面部痤疮。",
      "indicationEn": "Stomach pain, indigestion, abdominal distension, toothache, facial acne.",
      "timeInfo": "辰时（7-9点）—— 胃经最旺",
      "timeInfoEn": "Chen Hour (7-9 AM) — Stomach Meridian Peak",
      "yangsheng": "辰时胃经最旺，早餐要吃好、吃暖。",
      "yangshengEn": "During Chen hour the Stomach meridian is strongest. Eat a good, warm breakfast.",
      "diet": "推荐：小米粥、燕麦、南瓜、番薯、豆腐、山药、苹果。",
      "dietEn": "Recommended: Millet porridge, oats, pumpkin, sweet potato, tofu, yam, apple."
    },
    {
      "name": "足太阴脾经", "en": "Spleen Meridian", "element": "土", "organ": "脾", "time": "9-11",
      "path": "起于足大趾内侧，沿下肢内侧上行，入腹属脾，络胃。",
      "pathEn": "Starts on the medial side of the big toe, ascends along the medial side of the lower limb, enters the abdomen to belong to the spleen and connects with the stomach.",
      "function": "脾主运化、统血，为气血生化之源，开窍于口，其华在唇。",
      "functionEn": "The Spleen governs transportation and transformation, controls blood, is the source of Qi and Blood production, opens to the mouth, and its brilliance is in the lips.",
      "indication": "腹胀、泄泻、水肿、食欲不振、月经不调、唇色异常。",
      "indicationEn": "Abdominal distension, diarrhea, edema, poor appetite, irregular menstruation, abnormal lip color.",
      "timeInfo": "巳时（9-11点）—— 脾经最旺",
      "timeInfoEn": "Si Hour (9-11 AM) — Spleen Meridian Peak",
      "yangsheng": "巳时脾经旺，脾主运化、统血。此时护脾最佳，避免思虑过度。",
      "yangshengEn": "During Si hour the Spleen meridian is strong. It governs transportation, transformation and blood control. This is the best time to protect the Spleen and avoid excessive thinking.",
      "diet": "推荐：扁豆、番薯、马铃薯、豆腐、芹菜、玉米、大米、山药。",
      "dietEn": "Recommended: Hyacinth bean, sweet potato, potato, tofu, celery, corn, rice, yam."
    },
    {
      "name": "手少阴心经", "en": "Heart Meridian", "element": "火", "organ": "心", "time": "11-13",
      "path": "起于心中，出属心系，循上臂内侧下行，至小指末端。",
      "pathEn": "Starts in the heart, emerges to connect with the heart system, runs along the medial side of the upper arm and ends at the tip of the little finger.",
      "function": "心主血脉、主神志，为君主之官。",
      "functionEn": "The Heart governs blood vessels and the mind, it is the monarch of all organs.",
      "indication": "心悸、失眠、胸痛、健忘、舌痛。",
      "indicationEn": "Palpitations, insomnia, chest pain, forgetfulness, tongue pain.",
      "timeInfo": "午时（11-13点）—— 心经最旺",
      "timeInfoEn": "Wu Hour (11 AM-1 PM) — Heart Meridian Peak",
      "yangsheng": "午时心经最旺，宜小憩养心。",
      "yangshengEn": "During Wu hour the Heart meridian is strongest. Take a short nap to nourish the Heart.",
      "diet": "推荐：莲子、百合、小米、红枣、桂圆。",
      "dietEn": "Recommended: Lotus seed, lily bulb, millet, red dates, longan."
    },
    {
      "name": "手太阳小肠经", "en": "Small Intestine Meridian", "element": "火", "organ": "小肠", "time": "13-15",
      "path": "起于小指末端，沿上肢外侧上行至肩，入面部，止于耳前。",
      "pathEn": "Starts at the tip of the little finger, ascends along the lateral side of the upper limb to the shoulder, enters the face and ends in front of the ear.",
      "function": "分清别浊，主吸收营养，与心相表里。",
      "functionEn": "Separates the clear from the turbid, governs nutrient absorption, internally-externally related to the Heart.",
      "indication": "颈肩痛、耳鸣、腹痛、口腔溃疡。",
      "indicationEn": "Neck and shoulder pain, tinnitus, abdominal pain, mouth ulcers.",
      "timeInfo": "未时（13-15点）—— 小肠经最旺",
      "timeInfoEn": "Wei Hour (1-3 PM) — Small Intestine Meridian Peak",
      "yangsheng": "未时小肠经旺，宜喝水帮助消化吸收。",
      "yangshengEn": "During Wei hour the Small Intestine meridian is strong. Drink water to aid digestion and absorption.",
      "diet": "推荐：薏米、冬瓜、绿豆、玉米。",
      "dietEn": "Recommended: Job's tears, winter melon, mung bean, corn."
    },
    {
      "name": "足太阳膀胱经", "en": "Bladder Meridian", "element": "水", "organ": "膀胱", "time": "15-17",
      "path": "起于内眼角，沿头、背、腰、下肢后侧至足小趾。",
      "pathEn": "Starts at the inner canthus of the eye, runs along the head, back, waist, and posterior side of the lower limb to the little toe.",
      "function": "主储藏津液，调节水液代谢，主管一身阳气。",
      "functionEn": "Stores body fluids, regulates water metabolism, governs Yang Qi of the whole body.",
      "indication": "腰痛、头痛、感冒、坐骨神经痛。",
      "indicationEn": "Low back pain, headache, common cold, sciatica.",
      "timeInfo": "申时（15-17点）—— 膀胱经最旺",
      "timeInfoEn": "Shen Hour (3-5 PM) — Bladder Meridian Peak",
      "yangsheng": "申时膀胱经旺，宜多喝水、适量运动。",
      "yangshengEn": "During Shen hour the Bladder meridian is strong. Drink plenty of water and do moderate exercise.",
      "diet": "推荐：冬瓜、西瓜、薏米、黑豆。",
      "dietEn": "Recommended: Winter melon, watermelon, Job's tears, black bean."
    },
    {
      "name": "足少阴肾经", "en": "Kidney Meridian", "element": "水", "organ": "肾", "time": "17-19",
      "path": "起于足心，沿下肢内侧上行，贯脊属肾，络膀胱。",
      "pathEn": "Starts at the sole of the foot, ascends along the medial side of the lower limb, passes through the spine to belong to the kidney and connects with the bladder.",
      "function": "肾藏精、主骨生髓，为先天之本，主水、主纳气。",
      "functionEn": "The Kidney stores essence, governs bones and marrow, is the root of congenital constitution, governs water and receives Qi.",
      "indication": "腰膝酸软、耳鸣、脱发、怕冷、失眠。",
      "indicationEn": "Soreness and weakness of waist and knees, tinnitus, hair loss, fear of cold, insomnia.",
      "timeInfo": "酉时（17-19点）—— 肾经最旺",
      "timeInfoEn": "You Hour (5-7 PM) — Kidney Meridian Peak",
      "yangsheng": "酉时肾经旺，宜休息养肾，早睡保护肾精。",
      "yangshengEn": "During You hour the Kidney meridian is strong. Rest to nourish the Kidney and go to bed early to protect Kidney essence.",
      "diet": "推荐：黑豆、黑芝麻、核桃、枸杞。",
      "dietEn": "Recommended: Black bean, black sesame, walnut, goji berry."
    },
    {
      "name": "手厥阴心包经", "en": "Pericardium Meridian", "element": "火", "organ": "心包", "time": "19-21",
      "path": "起于胸中，属心包，循上臂内侧下行，至中指末端。",
      "pathEn": "Starts in the chest, belongs to the pericardium, runs along the medial side of the upper arm and ends at the tip of the middle finger.",
      "function": "保护心脏，代心行事，主血脉与神志。",
      "functionEn": "Protects the Heart, acts on behalf of the Heart, governs blood vessels and mental activities.",
      "indication": "心痛、心悸、胸闷、失眠。",
      "indicationEn": "Cardiac pain, palpitations, chest oppression, insomnia.",
      "timeInfo": "戌时（19-21点）—— 心包经最旺",
      "timeInfoEn": "Xu Hour (7-9 PM) — Pericardium Meridian Peak",
      "yangsheng": "戌时心包经旺，宜放松心情、泡脚。",
      "yangshengEn": "During Xu hour the Pericardium meridian is strong. Relax the mind and soak the feet.",
      "diet": "推荐：莲子、百合、桂圆、小米粥。",
      "dietEn": "Recommended: Lotus seed, lily bulb, longan, millet porridge."
    },
    {
      "name": "手少阳三焦经", "en": "Triple Energizer Meridian", "element": "火", "organ": "三焦", "time": "21-23",
      "path": "起于无名指末端，沿上肢外侧上行至肩，分布于胸腹。",
      "pathEn": "Starts at the tip of the ring finger, ascends along the lateral side of the upper limb to the shoulder, and distributes in the chest and abdomen.",
      "function": "通行元气，疏通水道，主持诸气。",
      "functionEn": "Promotes the circulation of original Qi, dredges water passages, governs all Qi.",
      "indication": "耳鸣、偏头痛、肩臂痛、便秘。",
      "indicationEn": "Tinnitus, migraine, shoulder and arm pain, constipation.",
      "timeInfo": "亥时（21-23点）—— 三焦经最旺",
      "timeInfoEn": "Hai Hour (9-11 PM) — Triple Energizer Meridian Peak",
      "yangsheng": "亥时三焦经旺，宜安静准备入睡。",
      "yangshengEn": "During Hai hour the Triple Energizer meridian is strong. Calm down and prepare for sleep.",
      "diet": "推荐：菊花茶、绿豆、冬瓜。",
      "dietEn": "Recommended: Chrysanthemum tea, mung bean, winter melon."
    },
    {
      "name": "足少阳胆经", "en": "Gallbladder Meridian", "element": "木", "organ": "胆", "time": "23-1",
      "path": "起于外眼角，沿头侧、身侧、下肢外侧至足第四趾。",
      "pathEn": "Starts at the outer canthus of the eye, runs along the side of the head and body, and the lateral side of the lower limb to the fourth toe.",
      "function": "贮藏胆汁，决断力，主筋。",
      "functionEn": "Stores bile, governs decision-making, governs the tendons.",
      "indication": "偏头痛、胆囊炎、口苦、胁痛。",
      "indicationEn": "Migraine, cholecystitis, bitter taste in mouth, hypochondriac pain.",
      "timeInfo": "子时（23-1点）—— 胆经最旺",
      "timeInfoEn": "Zi Hour (11 PM-1 AM) — Gallbladder Meridian Peak",
      "yangsheng": "子时胆经旺，宜深度睡眠。",
      "yangshengEn": "During Zi hour the Gallbladder meridian is strong. Sleep deeply.",
      "diet": "推荐：苦瓜、绿茶、柠檬。",
      "dietEn": "Recommended: Bitter melon, green tea, lemon."
    },
    {
      "name": "足厥阴肝经", "en": "Liver Meridian", "element": "木", "organ": "肝", "time": "1-3",
      "path": "起于足大趾，沿下肢内侧上行，绕阴器，属肝，络胆。",
      "pathEn": "Starts at the big toe, ascends along the medial side of the lower limb, circles the genitals, belongs to the liver and connects with the gallbladder.",
      "function": "主疏泄、藏血，调节情绪。",
      "functionEn": "Governs the free flow of Qi, stores blood, and regulates emotions.",
      "indication": "胁痛、情绪不畅、月经不调、头痛、高血压。",
      "indicationEn": "Hypochondriac pain, emotional distress, irregular menstruation, headache, hypertension.",
      "timeInfo": "丑时（1-3点）—— 肝经最旺",
      "timeInfoEn": "Chou Hour (1-3 AM) — Liver Meridian Peak",
      "yangsheng": "丑时肝经旺，宜深度睡眠，避免熬夜和生气。",
      "yangshengEn": "During Chou hour the Liver meridian is strong. Sleep deeply and avoid staying up late or getting angry.",
      "diet": "推荐：菠菜、胡萝卜、黑木耳、柠檬、菊花茶。",
      "dietEn": "Recommended: Spinach, carrot, black fungus, lemon, chrysanthemum tea."
    },
  ];
  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      setState(() => _currentTime = DateTime.now());
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void toggleLanguage() {
    setState(() => isChinese = !isChinese);
  }

  String getCurrentMeridian() {
    int index = (_currentTime.hour + 21) % 24 ~/ 2;
    final m = meridians[index % 12];
    return isChinese ? m["name"] : m["en"];
  }

  void openDetail(Map<String, dynamic> m) {
    showDialog(
      context: context,
      builder: (context) => MeridianDetailPage(meridian: m, isChinese: isChinese),
    );
  }

  Widget _buildList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: meridians.length,
      itemBuilder: (context, index) {
        final m = meridians[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: CircleAvatar(backgroundColor: Colors.green[100], child: Text(m["element"])),
            title: Text(isChinese ? m["name"] : m["en"]),
            subtitle: Text("${m["organ"]}　${m["time"]}点"),
            onTap: () => openDetail(m),
          ),
        );
      },
    );
  }
        Widget _buildBodyMap() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 左侧 - 阴经原穴
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(isChinese ? "阴经原穴（补虚养本）" : "Yuan Points of Yin Meridians (Tonify Deficiency)", 
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green)),
                const SizedBox(height: 4),
                Text(isChinese 
                    ? "原穴是本经气血汇聚的根本穴位，阴经多虚证，用原穴补虚养本效果最佳，能直接调补相应脏腑之本。"
                    : "Yuan points are source points of Qi & Blood. Best for tonifying deficiency in Yin meridians.",
                    style: const TextStyle(fontSize: 13, height: 1.35)),
                const SizedBox(height: 8),
                _buildAcupointListItem("太渊 (肺原)", "手太阴肺经", "腕横纹桡侧凹陷处"),
                _buildAcupointListItem("神门 (心原)", "手少阴心经", "腕横纹尺侧凹陷处"),
                _buildAcupointListItem("大陵 (心包原)", "手厥阴心包经", "腕横纹中央"),
                _buildAcupointListItem("太白 (脾原)", "足太阴脾经", "足大趾本节后凹陷处"),
                _buildAcupointListItem("太溪 (肾原)", "足少阴肾经", "内踝后凹陷处"),
                _buildAcupointListItem("太冲 (肝原)", "足厥阴肝经", "足背第1、2跖骨间凹陷处"),
              ],
            ),
          ),
          const SizedBox(width: 10),
          // 右侧 - 阳经合穴
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(isChinese ? "阳经合穴（泻实清热）" : "He-Sea Points of Yang Meridians (Drain Excess & Clear Heat)", 
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green)),
                const SizedBox(height: 4),
                Text(isChinese 
                    ? "合穴位于肘膝关节附近，气血最旺盛，如水汇入大海。阳经多实证，用合穴泻实清热、止痛通络效果显著。"
                    : "He-Sea points near elbow/knee joints. Best for draining excess & clearing heat in Yang meridians.",   
                   style: const TextStyle(fontSize: 13, height: 1.35)),
                const SizedBox(height: 8),
                _buildAcupointListItem("曲池 (大肠合)", "手阳明大肠经", "屈肘横纹外端"),
                _buildAcupointListItem("小海 (小肠合)", "手太阳小肠经", "屈肘尺骨鹰嘴处"),
                _buildAcupointListItem("天井 (三焦合)", "手少阳三焦经", "屈肘尺骨鹰嘴上1寸"),
                _buildAcupointListItem("足三里 (胃合)", "足阳明胃经", "膝下4横指，胫骨外侧"),
                _buildAcupointListItem("委中 (膀胱合)", "足太阳膀胱经", "膝窝正中横纹处"),
                _buildAcupointListItem("阳陵泉 (胆合)", "足少阳胆经", "腓骨小头前下方凹陷"),
              ],
            ),
          ),
        ],
      ),
    );
  }

    String _getEnAcupointName(String name) {
    if (name.contains("太渊")) return "Taiyuan (LU9)";
    if (name.contains("神门")) return "Shenmen (HT7)";
    if (name.contains("大陵")) return "Daling (PC7)";
    if (name.contains("太白")) return "Taibai (SP3)";
    if (name.contains("太溪")) return "Taixi (KI3)";
    if (name.contains("太冲")) return "Taichong (LR3)";
    if (name.contains("曲池")) return "Quchi (LI11)";
    if (name.contains("小海")) return "Xiaohai (SI8)";
    if (name.contains("天井")) return "Tianjing (TE10)";
    if (name.contains("足三里")) return "Zusanli (ST36)";
    if (name.contains("委中")) return "Weizhong (BL40)";
    if (name.contains("阳陵泉")) return "Yanglingquan (GB34)";
    return name;
  }

  String _getEnMeridian(String meridian) {
    if (meridian.contains("肺经")) return "Lung Meridian";
    if (meridian.contains("大肠经")) return "Large Intestine Meridian";
    if (meridian.contains("胃经")) return "Stomach Meridian";
    if (meridian.contains("脾经")) return "Spleen Meridian";
    if (meridian.contains("心经")) return "Heart Meridian";
    if (meridian.contains("小肠经")) return "Small Intestine Meridian";
    if (meridian.contains("膀胱经")) return "Bladder Meridian";
    if (meridian.contains("肾经")) return "Kidney Meridian";
    if (meridian.contains("心包经")) return "Pericardium Meridian";
    if (meridian.contains("三焦经")) return "Triple Energizer Meridian";
    if (meridian.contains("胆经")) return "Gallbladder Meridian";
    if (meridian.contains("肝经")) return "Liver Meridian";
    return meridian;
  }
  
    // 穴位图片文件名映射（根据你电脑里的实际文件名）
  String _getImageFileName(String name) {
    if (name.contains("太渊")) return "太渊穴.gif";
    if (name.contains("神门")) return "神门穴.gif";
    if (name.contains("大陵")) return "大陵穴.jpg";
    if (name.contains("太白")) return "太白穴.webp";
    if (name.contains("太冲")) return "太冲穴.gif";
    if (name.contains("太溪")) return "太溪穴.gif";
    if (name.contains("曲池")) return "曲池穴.gif";
    if (name.contains("小海")) return "小海穴.jpg";
    if (name.contains("天井")) return "天井穴.jpg";
    if (name.contains("足三里")) return "足三里穴.gif";
    if (name.contains("委中")) return "委中穴.gif";
    if (name.contains("阳陵泉")) return "阳陵泉穴.webp";
    return "太渊穴.gif"; // 默认
  }

  // 穴位详情页（左右布局，和经脉详情一样）
      void showAcupointDetail(String name, String meridian, String location, String imageFile) {
    final isEn = !isChinese;
    final displayMeridian = isEn ? _getEnMeridian(meridian) : meridian;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isEn ? _getEnAcupointName(name) : name),
        content: SizedBox(
          width: 920,
          height: 620,
          child: SingleChildScrollView(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 6,
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          "assets/images/$imageFile",
                          height: 460,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) => const Icon(Icons.image_not_supported, size: 180, color: Colors.grey),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(isEn ? "Source: Standard TCM Acupoint Chart" : "图源：标准中医穴位示意图", 
                          style: const TextStyle(fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 60),
                      Text(isEn ? "Meridian: $displayMeridian" : "所属经脉：$meridian", 
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: 16),
                      Text(isEn ? "Location:" : "取穴位置：", style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text(isEn ? _getEnLocation(name) : location),
                      const SizedBox(height: 16),
                      Text(isEn ? "Main Functions:" : "主要作用：", style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text(isEn ? _getEnEffect(name) : getAcupointEffect(name)),
                      const SizedBox(height: 16),
                      Text(isEn ? "Usage:" : "操作方法：", style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text(isEn 
                          ? "Press and knead gently with thumb or middle finger for 1-3 minutes, twice daily. Feel soreness but not pain."
                          : "用拇指或中指指腹轻轻按揉，每次1-3分钟，每天早晚各1次。以感觉酸胀但不痛为宜。长期坚持可明显改善对应脏腑功能。"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(isEn ? "Close" : "关闭"),
          ),
        ],
      ),
    );
  }      // 方法结束

  // 每个穴位的作用（可继续补充）
  String getAcupointEffect(String name) {
    if (name.contains("太渊")) return "补肺气、止咳平喘、调理肺经，增强免疫力，适合咳嗽、气短者。";
    if (name.contains("神门")) return "养心安神、镇静宁心，适合失眠、心悸、焦虑、健忘。";
    if (name.contains("大陵")) return "清心宁神、宽胸理气，适合心烦、胸闷、失眠。";
    if (name.contains("太白")) return "健脾和胃、化湿止泻，适合脾虚、腹胀、食欲不振。";
    if (name.contains("太溪")) return "滋肾阴、补肾气、强腰膝，适合腰膝酸软、耳鸣、怕冷。";
    if (name.contains("太冲")) return "疏肝解郁、平肝潜阳，适合情绪不畅、头痛、高血压。";
    if (name.contains("曲池")) return "清热泻火、通经活络，适合发热、皮肤病、肘臂痛。";
    if (name.contains("小海")) return "清心泻火、通络止痛，适合颈肩痛、耳鸣。";
    if (name.contains("天井")) return "清热化痰、通络止痛，适合肩臂痛。";
    if (name.contains("足三里")) return "健脾和胃、补气养血、强壮全身，被誉为强身健体第一要穴。";
    if (name.contains("委中")) return "舒筋活络、缓解腰背痛，清热解毒。";
    if (name.contains("阳陵泉")) return "舒筋活络、利胆疏肝，适合胆囊炎、筋脉拘挛。";
    return "调理本经气血，平衡阴阳。";
  }
    String _getEnLocation(String name) {
    if (name.contains("太渊")) return "Radial depression at the wrist crease";
    if (name.contains("神门")) return "Ulnar depression at the wrist crease";
    if (name.contains("大陵")) return "Center of the wrist crease";
    if (name.contains("太白")) return "Depression posterior to the base of the big toe";
    if (name.contains("太溪")) return "Depression posterior to the medial malleolus";
    if (name.contains("太冲")) return "Depression between 1st and 2nd metatarsal bones";
    if (name.contains("曲池")) return "Lateral end of the elbow crease when flexed";
    if (name.contains("小海")) return "At the ulnar olecranon when elbow flexed";
    if (name.contains("天井")) return "1 cun above the ulnar olecranon";
    if (name.contains("足三里")) return "4 finger widths below the knee, lateral to tibia";
    if (name.contains("委中")) return "Center of the popliteal crease";
    if (name.contains("阳陵泉")) return "Anterior and inferior to the head of the fibula";
    return "Standard location";
  }

  String _getEnEffect(String name) {
    if (name.contains("太渊")) return "Tonifies Lung Qi, relieves cough and asthma, boosts immunity.";
    if (name.contains("神门")) return "Calms the mind, treats insomnia, palpitations, anxiety.";
    if (name.contains("大陵")) return "Clears heart fire, relieves chest oppression and insomnia.";
    if (name.contains("太白")) return "Strengthens spleen and stomach, relieves bloating and poor appetite.";
    if (name.contains("太溪")) return "Nourishes Kidney Yin, strengthens lower back and knees.";
    if (name.contains("太冲")) return "Soothing Liver Qi, lowers blood pressure, relieves stress.";
    if (name.contains("曲池")) return "Clears heat, treats skin diseases and arm pain.";
    if (name.contains("足三里")) return "Major point for strengthening the whole body and digestion.";
    // ... 其他可继续补充
    return "Regulates Qi and Blood.";
  }

      Widget _buildAcupointListItem(String name, String meridian, String location) {
    final displayName = isChinese ? name : _getEnAcupointName(name);
    final displayMeridian = isChinese ? meridian : _getEnMeridian(meridian);
    final displayLocation = isChinese ? location : _getEnLocation(name);

    return Card(
      margin: const EdgeInsets.only(bottom: 5),
      child: ListTile(
        dense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        leading: const CircleAvatar(backgroundColor: Colors.red, radius: 14, child: Icon(Icons.pin_drop, color: Colors.white, size: 18)),
        title: Text(displayName, style: const TextStyle(fontSize: 14.5, fontWeight: FontWeight.bold)),
        subtitle: Text("$displayMeridian\n${isChinese ? '位置：' : 'Location: '}$displayLocation", 
                     style: const TextStyle(fontSize: 12.5, height: 1.2)),
        onTap: () => showAcupointDetail(name, meridian, location, _getImageFileName(name)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isChinese ? '十二经脉学习' : 'Meridian Master'),
        backgroundColor: Colors.green[700],
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: toggleLanguage,
          ),
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => _showAboutDialog(),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Colors.green[50],
            child: Column(
              children: [
                Text(isChinese ? "当前时辰" : "Current Time", style: const TextStyle(fontSize: 16)),
                Text("${_currentTime.hour.toString().padLeft(2, '0')}:${_currentTime.minute.toString().padLeft(2, '0')}", style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                Text((isChinese ? "当令经脉：" : "Current Meridian: ") + getCurrentMeridian(), style: const TextStyle(fontSize: 18, color: Colors.green)),
              ],
            ),
          ),
          Expanded(child: _currentIndex == 0 ? _buildList() : _buildBodyMap()),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        selectedItemColor: Colors.green[700],
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: '列表'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '日常保健取穴'),
        ],
      ),
    );
  }
}

class MeridianDetailPage extends StatelessWidget {
  final Map<String, dynamic> meridian;
  final bool isChinese;

  const MeridianDetailPage({super.key, required this.meridian, required this.isChinese});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(isChinese ? meridian["name"] : meridian["en"]),
      content: SizedBox(
        width: 920,
        height: 620,
        child: SingleChildScrollView(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 6,
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset("assets/images/${meridian["name"]}.gif", height: 460, fit: BoxFit.contain, errorBuilder: (c, e, s) => const Icon(Icons.image_not_supported, size: 180)),
                    ),
                    const SizedBox(height: 12),
                    Text(isChinese ? "图源：国立阳明交通大学 NYCU" : "Source: NYCU", style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(isChinese ? meridian["timeInfo"] : meridian["timeInfoEn"] ?? "", style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.green)),
                    const SizedBox(height: 16),
                    Text(isChinese ? "经络走向：" : "Path:", style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(isChinese ? meridian["path"] : (meridian["pathEn"] ?? "")),
                    const SizedBox(height: 16),
                    Text(isChinese ? "经脉功能：" : "Functions:", style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(isChinese ? meridian["function"] : (meridian["functionEn"] ?? "")),
                    const SizedBox(height: 16),
                    Text(isChinese ? "主治病症：" : "Indications:", style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(isChinese ? meridian["indication"] : (meridian["indicationEn"] ?? "")),
                    const SizedBox(height: 16),
                    Text(isChinese ? "养生之道：" : "Health Preservation:", style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(isChinese ? meridian["yangsheng"] : (meridian["yangshengEn"] ?? "")),
                    const SizedBox(height: 16),
                    Text(isChinese ? "建议饮食：" : "Recommended Diet:", style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(isChinese ? meridian["diet"] : (meridian["dietEn"] ?? "")),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text(isChinese ? "关闭" : "Close"))],
    );
  }
}