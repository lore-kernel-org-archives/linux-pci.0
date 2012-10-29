Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu1sys200aog112.obsmtp.com ([207.126.144.133]:59991 "EHLO
	eu1sys200aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751682Ab2J2HCR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 29 Oct 2012 03:02:17 -0400
From: Pratyush Anand <pratyush.anand@st.com>
To: <arnd@arndb.de>, <shiraz.hashim@st.com>, <viresh.linux@gmail.com>
Cc: <spear-devel@list.st.com>, <linux-pci@vger.kernel.org>,
	<devicetree-discuss@lists.ozlabs.org>, <olof@lixom.net>,
	Pratyush Anand <pratyush.anand@st.com>
Subject: [PATCH 05/15] clk: SPEAr1340: Fix pcie0 clock name
Date: Mon, 29 Oct 2012 12:31:19 +0530
Message-ID: <bdf7a8419c5960c6d521b18f6e51cc5e170d1374.1351492562.git.pratyush.anand@st.com>
In-Reply-To: <cover.1351492562.git.pratyush.anand@st.com>
References: <cover.1351492562.git.pratyush.anand@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
---
 drivers/clk/spear/spear1340_clock.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/clk/spear/spear1340_clock.c b/drivers/clk/spear/spear1340_clock.c
index 364c947..9f69a61 100644
--- a/drivers/clk/spear/spear1340_clock.c
+++ b/drivers/clk/spear/spear1340_clock.c
@@ -844,7 +844,7 @@ void __init spear1340_clk_init(void)
 	clk = clk_register_gate(NULL, "pcie_sata_clk", "ahb_clk", 0,
 			SPEAR1340_PERIP1_CLK_ENB, SPEAR1340_PCIE_SATA_CLK_ENB,
 			0, &_lock);
-	clk_register_clkdev(clk, NULL, "dw_pcie");
+	clk_register_clkdev(clk, NULL, "b1000000.pcie0");
 	clk_register_clkdev(clk, NULL, "b1000000.ahci");
 
 	clk = clk_register_gate(NULL, "sysram0_clk", "ahb_clk", 0,
-- 
1.7.5.4

