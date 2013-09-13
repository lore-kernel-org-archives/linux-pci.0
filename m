Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail1.g1.pair.com ([66.39.3.162]:44171 "EHLO mail1.g1.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754706Ab3IMJ5S (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 13 Sep 2013 05:57:18 -0400
From: Sean Cross <xobs@kosagi.com>
To: devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
	Zhu Richard-R65037 <r65037@freescale.com>,
	Shawn Guo <shawn.guo@linaro.org>, Sean Cross <xobs@kosagi.com>
Subject: [PATCH v4 1/3] ARM: imx: Add LVDS general-purpose clocks to i.MX6Q
Date: Fri, 13 Sep 2013 09:40:20 +0000
Message-Id: <1379065222-7275-2-git-send-email-xobs@kosagi.com>
In-Reply-To: <1379065222-7275-1-git-send-email-xobs@kosagi.com>
References: <1379065222-7275-1-git-send-email-xobs@kosagi.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The i.MX6 has two general-purpose LVDS clocks that can be driven
from a variety of sources.  This patch adds a mux and a gate for
both of these clocks.

Signed-off-by: Sean Cross <xobs@kosagi.com>
---
 .../devicetree/bindings/clock/imx6q-clock.txt      |    4 ++++
 arch/arm/mach-imx/clk-imx6q.c                      |   21 +++++++++++++++++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/imx6q-clock.txt b/Documentation/devicetree/bindings/clock/imx6q-clock.txt
index 5a90a72..35e82c7 100644
--- a/Documentation/devicetree/bindings/clock/imx6q-clock.txt
+++ b/Documentation/devicetree/bindings/clock/imx6q-clock.txt
@@ -215,6 +215,10 @@ clocks and IDs.
 	cko2      		200
 	cko      		201
 	vdoa      		202
+	lvds1_sel		203
+	lvds2_sel		204
+	lvds1_gate		205
+	lvds2_gate		206
 
 Examples:
 
diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index 9181a24..679d49a 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -217,6 +217,16 @@ static const char *cko2_sels[] = {
 	"uart_serial", "spdif", "asrc", "hsi_tx",
 };
 static const char *cko_sels[] = { "cko1", "cko2", };
+static const char *lvds1_sels[] = {
+	"dummy", "dummy", "dummy", "dummy", "dummy", "dummy",
+	"pll4_audio", "pll5_video", "pll8_mlb", "enet_ref",
+	"pcie_ref", "sata_ref",
+};
+static const char *lvds2_sels[] = {
+	"dummy", "dummy", "dummy", "dummy", "dummy", "dummy",
+	"pll4_audio", "pll5_video", "pll8_mlb", "enet_ref",
+	"pcie_ref", "sata_ref",
+};
 
 enum mx6q_clks {
 	dummy, ckil, ckih, osc, pll2_pfd0_352m, pll2_pfd1_594m, pll2_pfd2_396m,
@@ -251,7 +261,8 @@ enum mx6q_clks {
 	ssi2_ipg, ssi3_ipg, rom, usbphy1, usbphy2, ldb_di0_div_3_5, ldb_di1_div_3_5,
 	sata_ref, sata_ref_100m, pcie_ref, pcie_ref_125m, enet_ref, usbphy1_gate,
 	usbphy2_gate, pll4_post_div, pll5_post_div, pll5_video_div, eim_slow,
-	spdif, cko2_sel, cko2_podf, cko2, cko, vdoa, clk_max
+	spdif, cko2_sel, cko2_podf, cko2, cko, vdoa,
+	lvds1_sel, lvds2_sel, lvds1_gate, lvds2_gate, clk_max
 };
 
 static struct clk *clk[clk_max];
@@ -342,6 +353,12 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 			base + 0xe0, 0, 2, 0, clk_enet_ref_table,
 			&imx_ccm_lock);
 
+	clk[lvds1_sel] = imx_clk_mux("lvds1_sel", base + 0x160, 0, 5, lvds1_sels,         ARRAY_SIZE(lvds1_sels));
+	clk[lvds2_sel] = imx_clk_mux("lvds2_sel", base + 0x160, 5, 5, lvds2_sels,         ARRAY_SIZE(lvds2_sels));
+
+	clk[lvds1_gate] = imx_clk_gate("lvds1_gate", "dummy", base + 0x160, 10);
+	clk[lvds2_gate] = imx_clk_gate("lvds2_gate", "dummy", base + 0x160, 11);
+
 	/*                                name              parent_name        reg       idx */
 	clk[pll2_pfd0_352m] = imx_clk_pfd("pll2_pfd0_352m", "pll2_bus",     base + 0x100, 0);
 	clk[pll2_pfd1_594m] = imx_clk_pfd("pll2_pfd1_594m", "pll2_bus",     base + 0x100, 1);
@@ -569,6 +586,8 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 	clk_register_clkdev(clk[cko1_sel], "cko1_sel", NULL);
 	clk_register_clkdev(clk[ahb], "ahb", NULL);
 	clk_register_clkdev(clk[cko1], "cko1", NULL);
+	clk_register_clkdev(clk[lvds1_gate], "lvds1_gate", NULL);
+	clk_register_clkdev(clk[lvds2_gate], "lvds2_gate", NULL);
 	clk_register_clkdev(clk[arm], NULL, "cpu0");
 	clk_register_clkdev(clk[pll4_post_div], "pll4_post_div", NULL);
 	clk_register_clkdev(clk[pll4_audio], "pll4_audio", NULL);
-- 
1.7.9.5

