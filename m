Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu1sys200aog107.obsmtp.com ([207.126.144.123]:33636 "EHLO
	eu1sys200aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751091Ab3LKKIA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 11 Dec 2013 05:08:00 -0500
From: Mohit Kumar <mohit.kumar@st.com>
To: <linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Cc: Pratyush Anand <pratyush.anand@st.com>,
	Mohit Kumar <mohit.kumar@st.com>,
	Viresh Kumar <viresh.linux@gmail.com>,
	<spear-devel@list.st.com>
Subject: [PATCH 05/12] clk: SPEAr13xx: Fix pcie clock name
Date: Wed, 11 Dec 2013 15:08:30 +0530
Message-ID: <aeeefe3537089f0d0a2f8f5662d50dfca2aadf29.1386752447.git.mohit.kumar@st.com>
In-Reply-To: <cover.1386752447.git.mohit.kumar@st.com>
References: <cover.1386752447.git.mohit.kumar@st.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Pratyush Anand <pratyush.anand@st.com>

Follow dt clock naming convention for PCIe clocks.

Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
Cc: Mohit Kumar <mohit.kumar@st.com>
Cc: Viresh Kumar <viresh.linux@gmail.com>
Cc: spear-devel@list.st.com
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/clk/spear/spear1310_clock.c |    6 +++---
 drivers/clk/spear/spear1340_clock.c |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/spear/spear1310_clock.c b/drivers/clk/spear/spear1310_clock.c
index 65894f7..4daa597 100644
--- a/drivers/clk/spear/spear1310_clock.c
+++ b/drivers/clk/spear/spear1310_clock.c
@@ -742,19 +742,19 @@ void __init spear1310_clk_init(void __iomem *misc_base, void __iomem *ras_base)
 	clk = clk_register_gate(NULL, "pcie_sata_0_clk", "ahb_clk", 0,
 			SPEAR1310_PERIP1_CLK_ENB, SPEAR1310_PCIE_SATA_0_CLK_ENB,
 			0, &_lock);
-	clk_register_clkdev(clk, NULL, "dw_pcie.0");
+	clk_register_clkdev(clk, NULL, "b1000000.pcie");
 	clk_register_clkdev(clk, NULL, "b1000000.ahci");
 
 	clk = clk_register_gate(NULL, "pcie_sata_1_clk", "ahb_clk", 0,
 			SPEAR1310_PERIP1_CLK_ENB, SPEAR1310_PCIE_SATA_1_CLK_ENB,
 			0, &_lock);
-	clk_register_clkdev(clk, NULL, "dw_pcie.1");
+	clk_register_clkdev(clk, NULL, "b1800000.pcie");
 	clk_register_clkdev(clk, NULL, "b1800000.ahci");
 
 	clk = clk_register_gate(NULL, "pcie_sata_2_clk", "ahb_clk", 0,
 			SPEAR1310_PERIP1_CLK_ENB, SPEAR1310_PCIE_SATA_2_CLK_ENB,
 			0, &_lock);
-	clk_register_clkdev(clk, NULL, "dw_pcie.2");
+	clk_register_clkdev(clk, NULL, "b4000000.pcie");
 	clk_register_clkdev(clk, NULL, "b4000000.ahci");
 
 	clk = clk_register_gate(NULL, "sysram0_clk", "ahb_clk", 0,
diff --git a/drivers/clk/spear/spear1340_clock.c b/drivers/clk/spear/spear1340_clock.c
index fe835c1..5a5c664 100644
--- a/drivers/clk/spear/spear1340_clock.c
+++ b/drivers/clk/spear/spear1340_clock.c
@@ -839,7 +839,7 @@ void __init spear1340_clk_init(void __iomem *misc_base)
 	clk = clk_register_gate(NULL, "pcie_sata_clk", "ahb_clk", 0,
 			SPEAR1340_PERIP1_CLK_ENB, SPEAR1340_PCIE_SATA_CLK_ENB,
 			0, &_lock);
-	clk_register_clkdev(clk, NULL, "dw_pcie");
+	clk_register_clkdev(clk, NULL, "b1000000.pcie");
 	clk_register_clkdev(clk, NULL, "b1000000.ahci");
 
 	clk = clk_register_gate(NULL, "sysram0_clk", "ahb_clk", 0,
-- 
1.7.0.1

