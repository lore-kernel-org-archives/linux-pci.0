Return-Path: <SRS0=NmO7=HF=gmail.com=hkallweit1@kernel.org>
Return-Path: <SRS0=NmO7=HF=gmail.com=hkallweit1@kernel.org>
Subject: [PATCH net-next 2/2] r8169: replace magic numbers with PCI MRRS
 constant
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>, David Miller <davem@davemloft.net>,
 Bjorn Helgaas <helgaas@kernel.org>,
 Realtek linux nic maintainers <nic_swsd@realtek.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <00f1255f-acf0-4760-c20f-0b78bda44645@gmail.com>
Message-ID: <0a0229e0-7980-7661-f26b-ea3b2becb12b@gmail.com>
Date: Mon, 16 Apr 2018 21:38:27 +0200
MIME-Version: 1.0
In-Reply-To: <00f1255f-acf0-4760-c20f-0b78bda44645@gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

Replace magic number "0x5 << MAX_READ_REQUEST_SHIFT" with the
appropriate constant as defined in PCI core.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169.c | 39 ++++++++++++++--------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169.c b/drivers/net/ethernet/realtek/r8169.c
index 604ae783..7d4e6890 100644
--- a/drivers/net/ethernet/realtek/r8169.c
+++ b/drivers/net/ethernet/realtek/r8169.c
@@ -84,7 +84,6 @@
    The RTL chips use a 64 element hash table based on the Ethernet CRC. */
 static const int multicast_filter_limit = 32;
 
-#define MAX_READ_REQUEST_SHIFT	12
 #define TX_DMA_BURST	7	/* Maximum PCI burst, '7' is unlimited */
 #define InterFrameGap	0x03	/* 3 means InterFrameGap = the shortest one */
 
@@ -5125,7 +5124,7 @@ static void r8168c_hw_jumbo_disable(struct rtl8169_private *tp)
 {
 	RTL_W8(tp, Config3, RTL_R8(tp, Config3) & ~Jumbo_En0);
 	RTL_W8(tp, Config4, RTL_R8(tp, Config4) & ~Jumbo_En1);
-	rtl_tx_performance_tweak(tp, 0x5 << MAX_READ_REQUEST_SHIFT);
+	rtl_tx_performance_tweak(tp, PCI_EXP_DEVCTL_READRQ_4096B);
 }
 
 static void r8168dp_hw_jumbo_enable(struct rtl8169_private *tp)
@@ -5151,7 +5150,7 @@ static void r8168e_hw_jumbo_disable(struct rtl8169_private *tp)
 	RTL_W8(tp, MaxTxPacketSize, 0x0c);
 	RTL_W8(tp, Config3, RTL_R8(tp, Config3) & ~Jumbo_En0);
 	RTL_W8(tp, Config4, RTL_R8(tp, Config4) & ~0x01);
-	rtl_tx_performance_tweak(tp, 0x5 << MAX_READ_REQUEST_SHIFT);
+	rtl_tx_performance_tweak(tp, PCI_EXP_DEVCTL_READRQ_4096B);
 }
 
 static void r8168b_0_hw_jumbo_enable(struct rtl8169_private *tp)
@@ -5163,7 +5162,7 @@ static void r8168b_0_hw_jumbo_enable(struct rtl8169_private *tp)
 static void r8168b_0_hw_jumbo_disable(struct rtl8169_private *tp)
 {
 	rtl_tx_performance_tweak(tp,
-		(0x5 << MAX_READ_REQUEST_SHIFT) | PCI_EXP_DEVCTL_NOSNOOP_EN);
+		PCI_EXP_DEVCTL_READRQ_4096B | PCI_EXP_DEVCTL_NOSNOOP_EN);
 }
 
 static void r8168b_1_hw_jumbo_enable(struct rtl8169_private *tp)
@@ -5736,7 +5735,7 @@ static void rtl_hw_start_8168bb(struct rtl8169_private *tp)
 	RTL_W16(tp, CPlusCmd, RTL_R16(tp, CPlusCmd) & ~R8168_CPCMD_QUIRK_MASK);
 
 	if (tp->dev->mtu <= ETH_DATA_LEN) {
-		rtl_tx_performance_tweak(tp, (0x5 << MAX_READ_REQUEST_SHIFT) |
+		rtl_tx_performance_tweak(tp, PCI_EXP_DEVCTL_READRQ_4096B |
 					 PCI_EXP_DEVCTL_NOSNOOP_EN);
 	}
 }
@@ -5757,7 +5756,7 @@ static void __rtl_hw_start_8168cp(struct rtl8169_private *tp)
 	RTL_W8(tp, Config3, RTL_R8(tp, Config3) & ~Beacon_en);
 
 	if (tp->dev->mtu <= ETH_DATA_LEN)
-		rtl_tx_performance_tweak(tp, 0x5 << MAX_READ_REQUEST_SHIFT);
+		rtl_tx_performance_tweak(tp, PCI_EXP_DEVCTL_READRQ_4096B);
 
 	rtl_disable_clock_request(tp);
 
@@ -5788,7 +5787,7 @@ static void rtl_hw_start_8168cp_2(struct rtl8169_private *tp)
 	RTL_W8(tp, Config3, RTL_R8(tp, Config3) & ~Beacon_en);
 
 	if (tp->dev->mtu <= ETH_DATA_LEN)
-		rtl_tx_performance_tweak(tp, 0x5 << MAX_READ_REQUEST_SHIFT);
+		rtl_tx_performance_tweak(tp, PCI_EXP_DEVCTL_READRQ_4096B);
 
 	RTL_W16(tp, CPlusCmd, RTL_R16(tp, CPlusCmd) & ~R8168_CPCMD_QUIRK_MASK);
 }
@@ -5805,7 +5804,7 @@ static void rtl_hw_start_8168cp_3(struct rtl8169_private *tp)
 	RTL_W8(tp, MaxTxPacketSize, TxPacketMax);
 
 	if (tp->dev->mtu <= ETH_DATA_LEN)
-		rtl_tx_performance_tweak(tp, 0x5 << MAX_READ_REQUEST_SHIFT);
+		rtl_tx_performance_tweak(tp, PCI_EXP_DEVCTL_READRQ_4096B);
 
 	RTL_W16(tp, CPlusCmd, RTL_R16(tp, CPlusCmd) & ~R8168_CPCMD_QUIRK_MASK);
 }
@@ -5862,7 +5861,7 @@ static void rtl_hw_start_8168d(struct rtl8169_private *tp)
 	RTL_W8(tp, MaxTxPacketSize, TxPacketMax);
 
 	if (tp->dev->mtu <= ETH_DATA_LEN)
-		rtl_tx_performance_tweak(tp, 0x5 << MAX_READ_REQUEST_SHIFT);
+		rtl_tx_performance_tweak(tp, PCI_EXP_DEVCTL_READRQ_4096B);
 
 	RTL_W16(tp, CPlusCmd, RTL_R16(tp, CPlusCmd) & ~R8168_CPCMD_QUIRK_MASK);
 }
@@ -5872,7 +5871,7 @@ static void rtl_hw_start_8168dp(struct rtl8169_private *tp)
 	rtl_csi_access_enable_1(tp);
 
 	if (tp->dev->mtu <= ETH_DATA_LEN)
-		rtl_tx_performance_tweak(tp, 0x5 << MAX_READ_REQUEST_SHIFT);
+		rtl_tx_performance_tweak(tp, PCI_EXP_DEVCTL_READRQ_4096B);
 
 	RTL_W8(tp, MaxTxPacketSize, TxPacketMax);
 
@@ -5889,7 +5888,7 @@ static void rtl_hw_start_8168d_4(struct rtl8169_private *tp)
 
 	rtl_csi_access_enable_1(tp);
 
-	rtl_tx_performance_tweak(tp, 0x5 << MAX_READ_REQUEST_SHIFT);
+	rtl_tx_performance_tweak(tp, PCI_EXP_DEVCTL_READRQ_4096B);
 
 	RTL_W8(tp, MaxTxPacketSize, TxPacketMax);
 
@@ -5921,7 +5920,7 @@ static void rtl_hw_start_8168e_1(struct rtl8169_private *tp)
 	rtl_ephy_init(tp, e_info_8168e_1, ARRAY_SIZE(e_info_8168e_1));
 
 	if (tp->dev->mtu <= ETH_DATA_LEN)
-		rtl_tx_performance_tweak(tp, 0x5 << MAX_READ_REQUEST_SHIFT);
+		rtl_tx_performance_tweak(tp, PCI_EXP_DEVCTL_READRQ_4096B);
 
 	RTL_W8(tp, MaxTxPacketSize, TxPacketMax);
 
@@ -5946,7 +5945,7 @@ static void rtl_hw_start_8168e_2(struct rtl8169_private *tp)
 	rtl_ephy_init(tp, e_info_8168e_2, ARRAY_SIZE(e_info_8168e_2));
 
 	if (tp->dev->mtu <= ETH_DATA_LEN)
-		rtl_tx_performance_tweak(tp, 0x5 << MAX_READ_REQUEST_SHIFT);
+		rtl_tx_performance_tweak(tp, PCI_EXP_DEVCTL_READRQ_4096B);
 
 	rtl_eri_write(tp, 0xc0, ERIAR_MASK_0011, 0x0000, ERIAR_EXGMAC);
 	rtl_eri_write(tp, 0xb8, ERIAR_MASK_0011, 0x0000, ERIAR_EXGMAC);
@@ -5976,7 +5975,7 @@ static void rtl_hw_start_8168f(struct rtl8169_private *tp)
 {
 	rtl_csi_access_enable_2(tp);
 
-	rtl_tx_performance_tweak(tp, 0x5 << MAX_READ_REQUEST_SHIFT);
+	rtl_tx_performance_tweak(tp, PCI_EXP_DEVCTL_READRQ_4096B);
 
 	rtl_eri_write(tp, 0xc0, ERIAR_MASK_0011, 0x0000, ERIAR_EXGMAC);
 	rtl_eri_write(tp, 0xb8, ERIAR_MASK_0011, 0x0000, ERIAR_EXGMAC);
@@ -6047,7 +6046,7 @@ static void rtl_hw_start_8168g(struct rtl8169_private *tp)
 
 	rtl_csi_access_enable_1(tp);
 
-	rtl_tx_performance_tweak(tp, 0x5 << MAX_READ_REQUEST_SHIFT);
+	rtl_tx_performance_tweak(tp, PCI_EXP_DEVCTL_READRQ_4096B);
 
 	rtl_w0w1_eri(tp, 0xdc, ERIAR_MASK_0001, 0x00, 0x01, ERIAR_EXGMAC);
 	rtl_w0w1_eri(tp, 0xdc, ERIAR_MASK_0001, 0x01, 0x00, ERIAR_EXGMAC);
@@ -6147,7 +6146,7 @@ static void rtl_hw_start_8168h_1(struct rtl8169_private *tp)
 
 	rtl_csi_access_enable_1(tp);
 
-	rtl_tx_performance_tweak(tp, 0x5 << MAX_READ_REQUEST_SHIFT);
+	rtl_tx_performance_tweak(tp, PCI_EXP_DEVCTL_READRQ_4096B);
 
 	rtl_w0w1_eri(tp, 0xdc, ERIAR_MASK_0001, 0x00, 0x01, ERIAR_EXGMAC);
 	rtl_w0w1_eri(tp, 0xdc, ERIAR_MASK_0001, 0x01, 0x00, ERIAR_EXGMAC);
@@ -6229,7 +6228,7 @@ static void rtl_hw_start_8168ep(struct rtl8169_private *tp)
 
 	rtl_csi_access_enable_1(tp);
 
-	rtl_tx_performance_tweak(tp, 0x5 << MAX_READ_REQUEST_SHIFT);
+	rtl_tx_performance_tweak(tp, PCI_EXP_DEVCTL_READRQ_4096B);
 
 	rtl_w0w1_eri(tp, 0xdc, ERIAR_MASK_0001, 0x00, 0x01, ERIAR_EXGMAC);
 	rtl_w0w1_eri(tp, 0xdc, ERIAR_MASK_0001, 0x01, 0x00, ERIAR_EXGMAC);
@@ -6495,7 +6494,7 @@ static void rtl_hw_start_8102e_1(struct rtl8169_private *tp)
 
 	RTL_W8(tp, DBG_REG, FIX_NAK_1);
 
-	rtl_tx_performance_tweak(tp, 0x5 << MAX_READ_REQUEST_SHIFT);
+	rtl_tx_performance_tweak(tp, PCI_EXP_DEVCTL_READRQ_4096B);
 
 	RTL_W8(tp, Config1,
 	       LEDS1 | LEDS0 | Speed_down | MEMMAP | IOMAP | VPD | PMEnable);
@@ -6512,7 +6511,7 @@ static void rtl_hw_start_8102e_2(struct rtl8169_private *tp)
 {
 	rtl_csi_access_enable_2(tp);
 
-	rtl_tx_performance_tweak(tp, 0x5 << MAX_READ_REQUEST_SHIFT);
+	rtl_tx_performance_tweak(tp, PCI_EXP_DEVCTL_READRQ_4096B);
 
 	RTL_W8(tp, Config1, MEMMAP | IOMAP | VPD | PMEnable);
 	RTL_W8(tp, Config3, RTL_R8(tp, Config3) & ~Beacon_en);
@@ -6575,7 +6574,7 @@ static void rtl_hw_start_8402(struct rtl8169_private *tp)
 
 	rtl_ephy_init(tp, e_info_8402, ARRAY_SIZE(e_info_8402));
 
-	rtl_tx_performance_tweak(tp, 0x5 << MAX_READ_REQUEST_SHIFT);
+	rtl_tx_performance_tweak(tp, PCI_EXP_DEVCTL_READRQ_4096B);
 
 	rtl_eri_write(tp, 0xc8, ERIAR_MASK_1111, 0x00000002, ERIAR_EXGMAC);
 	rtl_eri_write(tp, 0xe8, ERIAR_MASK_1111, 0x00000006, ERIAR_EXGMAC);
-- 
2.17.0
