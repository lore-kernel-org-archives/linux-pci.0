Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        <linux-doc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC: <hch@infradead.org>, <nsekhar@ti.com>, <kishon@ti.com>
Subject: [PATCH v3 23/23] ARM: DRA7: clockdomain: Change the CLKTRCTRL of CM_PCIE_CLKSTCTRL to SW_WKUP
Date: Thu, 9 Mar 2017 13:27:34 +0530
Message-ID: <1489046254-19919-24-git-send-email-kishon@ti.com>
In-Reply-To: <1489046254-19919-1-git-send-email-kishon@ti.com>
References: <1489046254-19919-1-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The PCIe programming sequence in TRM suggests CLKSTCTRL of PCIe should
be set to SW_WKUP. There are no issues when CLKSTCTRL is set to HW_AUTO
in RC mode. However in EP mode, the host system is not able to access the
MEMSPACE and setting the CLKSTCTRL to SW_WKUP fixes it.

Acked-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/mach-omap2/clockdomains7xx_data.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/clockdomains7xx_data.c b/arch/arm/mach-omap2/clockdomains7xx_data.c
index 6c67965..67ebff8 100644
--- a/arch/arm/mach-omap2/clockdomains7xx_data.c
+++ b/arch/arm/mach-omap2/clockdomains7xx_data.c
@@ -524,7 +524,7 @@
 	.dep_bit	  = DRA7XX_PCIE_STATDEP_SHIFT,
 	.wkdep_srcs	  = pcie_wkup_sleep_deps,
 	.sleepdep_srcs	  = pcie_wkup_sleep_deps,
-	.flags		  = CLKDM_CAN_HWSUP_SWSUP,
+	.flags		  = CLKDM_CAN_SWSUP,
 };
 
 static struct clockdomain atl_7xx_clkdm = {
-- 
1.7.9.5
