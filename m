Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail1.g1.pair.com ([66.39.3.162]:46220 "EHLO mail1.g1.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752862Ab3GAHkF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 1 Jul 2013 03:40:05 -0400
From: Sean Cross <xobs@kosagi.com>
To: devicetree-discuss@lists.ozlabs.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Sean Cross <xobs@kosagi.com>
Subject: [PATCH 1/4] ARM i.MX6q: Add descriptors for LVDS clocks
Date: Mon,  1 Jul 2013 07:15:44 +0000
Message-Id: <1372662947-27160-2-git-send-email-xobs@kosagi.com>
In-Reply-To: <1372662947-27160-1-git-send-email-xobs@kosagi.com>
References: <1372662947-27160-1-git-send-email-xobs@kosagi.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

There are two general-purpose LVDS clocks available on the i.MX6.  Add
clock descriptors for both of these clocks, as well as selectors to be
able to generate various external signals.

Signed-off-by: Sean Cross <xobs@kosagi.com>
---
 .../devicetree/bindings/clock/imx6q-clock.txt      |    4 ++++
 arch/arm/mach-imx/clk-imx6q.c                      |   13 +++++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/imx6q-clock.txt b/Documentation/devicetree/bindings/clock/imx6q-clock.txt
index 6deb6fd..b2b4acb 100644
--- a/Documentation/devicetree/bindings/clock/imx6q-clock.txt
+++ b/Documentation/devicetree/bindings/clock/imx6q-clock.txt
@@ -208,6 +208,10 @@ clocks and IDs.
 	pll4_post_div		193
 	pll5_post_div		194
 	pll5_video_div		195
+	lvds1_sel		196
+	lvds2_sel		197
+	lvds1			198
+	lvds2			199
 
 Examples:
 
diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index 4e3148c..f0c0591 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -204,7 +204,9 @@ static const char *vdo_axi_sels[]	= { "axi", "ahb", };
 static const char *vpu_axi_sels[]	= { "axi", "pll2_pfd2_396m", "pll2_pfd0_352m", };
 static const char *cko1_sels[]	= { "pll3_usb_otg", "pll2_bus", "pll1_sys", "pll5_video_div",
 				    "dummy", "axi", "enfc", "ipu1_di0", "ipu1_di1", "ipu2_di0",
-				    "ipu2_di1", "ahb", "ipg", "ipg_per", "ckil", "pll4_post_div", };
+				    "ipu2_di1", "ahb", "ipg", "ipg_per", "ckil", "pll4_audio", };
+static const char *lvds1_sels[] = { "dummy", "dummy", "dummy", "dummy", "dummy", "dummy", "pll4_audio", "pll5_video", "pll8_mlb", "enet_ref", "pcie_ref", "sata_ref", "dummy", "dummy", "dummy", "dummy", "dummy", "dummy", "dummy", "lvds1", "lvds2", };
+static const char *lvds2_sels[] = { "dummy", "dummy", "dummy", "dummy", "dummy", "dummy", "pll4_audio", "pll5_video", "pll8_mlb", "enet_ref", "pcie_ref", "sata_ref", "dummy", "dummy", "dummy", "dummy", "dummy", "dummy", "dummy", "lvds1", "lvds2", };
 
 enum mx6q_clks {
 	dummy, ckil, ckih, osc, pll2_pfd0_352m, pll2_pfd1_594m, pll2_pfd2_396m,
@@ -238,7 +240,8 @@ enum mx6q_clks {
 	pll4_audio, pll5_video, pll8_mlb, pll7_usb_host, pll6_enet, ssi1_ipg,
 	ssi2_ipg, ssi3_ipg, rom, usbphy1, usbphy2, ldb_di0_div_3_5, ldb_di1_div_3_5,
 	sata_ref, sata_ref_100m, pcie_ref, pcie_ref_125m, enet_ref, usbphy1_gate,
-	usbphy2_gate, pll4_post_div, pll5_post_div, pll5_video_div, clk_max
+	usbphy2_gate, pll4_post_div, pll5_post_div, pll5_video_div,
+	lvds1_sel, lvds2_sel, lvds1, lvds2, clk_max
 };
 
 static struct clk *clk[clk_max];
@@ -360,6 +363,12 @@ int __init mx6q_clocks_init(void)
 	clk[pll5_post_div] = clk_register_divider_table(NULL, "pll5_post_div", "pll5_video", CLK_SET_RATE_PARENT, base + 0xa0, 19, 2, 0, post_div_table, &imx_ccm_lock);
 	clk[pll5_video_div] = clk_register_divider_table(NULL, "pll5_video_div", "pll5_post_div", CLK_SET_RATE_PARENT, base + 0x170, 30, 2, 0, video_div_table, &imx_ccm_lock);
 
+	clk[lvds1_sel]        = imx_clk_mux("lvds1_sel",	base + 0x160, 0, 5, lvds1_sels,		ARRAY_SIZE(lvds1_sels));
+	clk[lvds2_sel]        = imx_clk_mux("lvds2_sel",	base + 0x160, 0, 5, lvds2_sels,		ARRAY_SIZE(lvds2_sels));
+
+	clk[lvds1] = imx_clk_gate("lvds1", "dummy", base + 0x160, 10);
+	clk[lvds2] = imx_clk_gate("lvds2", "dummy", base + 0x160, 11);
+
 	np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-ccm");
 	base = of_iomap(np, 0);
 	WARN_ON(!base);
-- 
1.7.9.5

