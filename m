Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:35141 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933095AbeFUIax (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jun 2018 04:30:53 -0400
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: davem@davemloft.net
Cc: ryankao@realtek.com, hayeswang@realtek.com, hau@realtek.com,
        hkallweit1@gmail.com, romieu@fr.zoreil.com, bhelgaas@google.com,
        acelan.kao@canonical.com, netdev@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH net-next v4 2/2] r8169: Reinstate ASPM Support
Date: Thu, 21 Jun 2018 16:30:39 +0800
Message-Id: <20180621083039.22545-2-kai.heng.feng@canonical.com>
In-Reply-To: <20180621083039.22545-1-kai.heng.feng@canonical.com>
References: <20180621083039.22545-1-kai.heng.feng@canonical.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Intel platforms (Skylake and newer), ASPM support in r8169 is the
last missing puzzle to let CPU's Package C-State reaches PC8.  Without
ASPM support, the CPU cannot reach beyond PC3. PC8 can save additional
~3W in comparison with PC3 on a Coffee Lake platform, Dell G3 3779.

This is based on the work from Chunhao Lin <hau@realtek.com>.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v4:
- Improve commit message.
- Move the empty line to where it belongs.

v3:
- Change commit message wording.
- Rename the function to rtl_hw_aspm_clkreq_enable().

v2:
- Remove module parameter.
- Remove pci_disable_link_state().

 drivers/net/ethernet/realtek/r8169.c | 39 +++++++++++++++++++---------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169.c b/drivers/net/ethernet/realtek/r8169.c
index 2bdfd25acd58..269ac7561368 100644
--- a/drivers/net/ethernet/realtek/r8169.c
+++ b/drivers/net/ethernet/realtek/r8169.c
@@ -5289,6 +5289,17 @@ static void rtl_pcie_state_l2l3_enable(struct rtl8169_private *tp, bool enable)
 	RTL_W8(tp, Config3, data);
 }
 
+static void rtl_hw_aspm_clkreq_enable(struct rtl8169_private *tp, bool enable)
+{
+	if (enable) {
+		RTL_W8(tp, Config2, RTL_R8(tp, Config2) | ClkReqEn);
+		RTL_W8(tp, Config5, RTL_R8(tp, Config5) | ASPM_en);
+	} else {
+		RTL_W8(tp, Config2, RTL_R8(tp, Config2) & ~ClkReqEn);
+		RTL_W8(tp, Config5, RTL_R8(tp, Config5) & ~ASPM_en);
+	}
+}
+
 static void rtl_hw_start_8168bb(struct rtl8169_private *tp)
 {
 	RTL_W8(tp, Config3, RTL_R8(tp, Config3) & ~Beacon_en);
@@ -5645,9 +5656,9 @@ static void rtl_hw_start_8168g_1(struct rtl8169_private *tp)
 	rtl_hw_start_8168g(tp);
 
 	/* disable aspm and clock request before access ephy */
-	RTL_W8(tp, Config2, RTL_R8(tp, Config2) & ~ClkReqEn);
-	RTL_W8(tp, Config5, RTL_R8(tp, Config5) & ~ASPM_en);
+	rtl_hw_aspm_clkreq_enable(tp, false);
 	rtl_ephy_init(tp, e_info_8168g_1, ARRAY_SIZE(e_info_8168g_1));
+	rtl_hw_aspm_clkreq_enable(tp, true);
 }
 
 static void rtl_hw_start_8168g_2(struct rtl8169_private *tp)
@@ -5680,9 +5691,9 @@ static void rtl_hw_start_8411_2(struct rtl8169_private *tp)
 	rtl_hw_start_8168g(tp);
 
 	/* disable aspm and clock request before access ephy */
-	RTL_W8(tp, Config2, RTL_R8(tp, Config2) & ~ClkReqEn);
-	RTL_W8(tp, Config5, RTL_R8(tp, Config5) & ~ASPM_en);
+	rtl_hw_aspm_clkreq_enable(tp, false);
 	rtl_ephy_init(tp, e_info_8411_2, ARRAY_SIZE(e_info_8411_2));
+	rtl_hw_aspm_clkreq_enable(tp, true);
 }
 
 static void rtl_hw_start_8168h_1(struct rtl8169_private *tp)
@@ -5699,8 +5710,7 @@ static void rtl_hw_start_8168h_1(struct rtl8169_private *tp)
 	};
 
 	/* disable aspm and clock request before access ephy */
-	RTL_W8(tp, Config2, RTL_R8(tp, Config2) & ~ClkReqEn);
-	RTL_W8(tp, Config5, RTL_R8(tp, Config5) & ~ASPM_en);
+	rtl_hw_aspm_clkreq_enable(tp, false);
 	rtl_ephy_init(tp, e_info_8168h_1, ARRAY_SIZE(e_info_8168h_1));
 
 	RTL_W32(tp, TxConfig, RTL_R32(tp, TxConfig) | TXCFG_AUTO_FIFO);
@@ -5779,6 +5789,8 @@ static void rtl_hw_start_8168h_1(struct rtl8169_private *tp)
 	r8168_mac_ocp_write(tp, 0xe63e, 0x0000);
 	r8168_mac_ocp_write(tp, 0xc094, 0x0000);
 	r8168_mac_ocp_write(tp, 0xc09e, 0x0000);
+
+	rtl_hw_aspm_clkreq_enable(tp, true);
 }
 
 static void rtl_hw_start_8168ep(struct rtl8169_private *tp)
@@ -5830,11 +5842,12 @@ static void rtl_hw_start_8168ep_1(struct rtl8169_private *tp)
 	};
 
 	/* disable aspm and clock request before access ephy */
-	RTL_W8(tp, Config2, RTL_R8(tp, Config2) & ~ClkReqEn);
-	RTL_W8(tp, Config5, RTL_R8(tp, Config5) & ~ASPM_en);
+	rtl_hw_aspm_clkreq_enable(tp, false);
 	rtl_ephy_init(tp, e_info_8168ep_1, ARRAY_SIZE(e_info_8168ep_1));
 
 	rtl_hw_start_8168ep(tp);
+
+	rtl_hw_aspm_clkreq_enable(tp, true);
 }
 
 static void rtl_hw_start_8168ep_2(struct rtl8169_private *tp)
@@ -5846,14 +5859,15 @@ static void rtl_hw_start_8168ep_2(struct rtl8169_private *tp)
 	};
 
 	/* disable aspm and clock request before access ephy */
-	RTL_W8(tp, Config2, RTL_R8(tp, Config2) & ~ClkReqEn);
-	RTL_W8(tp, Config5, RTL_R8(tp, Config5) & ~ASPM_en);
+	rtl_hw_aspm_clkreq_enable(tp, false);
 	rtl_ephy_init(tp, e_info_8168ep_2, ARRAY_SIZE(e_info_8168ep_2));
 
 	rtl_hw_start_8168ep(tp);
 
 	RTL_W8(tp, DLLPR, RTL_R8(tp, DLLPR) & ~PFM_EN);
 	RTL_W8(tp, MISC_1, RTL_R8(tp, MISC_1) & ~PFM_D3COLD_EN);
+
+	rtl_hw_aspm_clkreq_enable(tp, true);
 }
 
 static void rtl_hw_start_8168ep_3(struct rtl8169_private *tp)
@@ -5867,8 +5881,7 @@ static void rtl_hw_start_8168ep_3(struct rtl8169_private *tp)
 	};
 
 	/* disable aspm and clock request before access ephy */
-	RTL_W8(tp, Config2, RTL_R8(tp, Config2) & ~ClkReqEn);
-	RTL_W8(tp, Config5, RTL_R8(tp, Config5) & ~ASPM_en);
+	rtl_hw_aspm_clkreq_enable(tp, false);
 	rtl_ephy_init(tp, e_info_8168ep_3, ARRAY_SIZE(e_info_8168ep_3));
 
 	rtl_hw_start_8168ep(tp);
@@ -5888,6 +5901,8 @@ static void rtl_hw_start_8168ep_3(struct rtl8169_private *tp)
 	data = r8168_mac_ocp_read(tp, 0xe860);
 	data |= 0x0080;
 	r8168_mac_ocp_write(tp, 0xe860, data);
+
+	rtl_hw_aspm_clkreq_enable(tp, true);
 }
 
 static void rtl_hw_start_8168(struct rtl8169_private *tp)
-- 
2.17.0
