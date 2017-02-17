Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail5.windriver.com ([192.103.53.11]:37204 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753497AbdBQAUP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 16 Feb 2017 19:20:15 -0500
From: Yadi Hu <yadi.hu@windriver.com>
To: <yadi.hu@windriver.com>, <lftan@altera.com>
CC: <linux-pci@vger.kernel.org>, <rfi@lists.rocketboards.org>
Subject: [PATCH] PCI: altera: Check TLP completion status
Date: Fri, 17 Feb 2017 08:19:56 +0800
Message-ID: <1487290796-21192-2-git-send-email-yadi.hu@windriver.com>
In-Reply-To: <1487290796-21192-1-git-send-email-yadi.hu@windriver.com>
References: <1487290796-21192-1-git-send-email-yadi.hu@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Ley Foon Tan <lftan@altera.com>

Check TLP packet successful completion status.  This fix the issue when
accessing multi-function devices in enumeration process, TLP will return
error when accessing non-exist function number.  Returns PCI error code
instead of generic errno.

Tested on Ethernet adapter card with multi-functions.

[bhelgaas: simplify completion status checking code]
Signed-off-by: Ley Foon Tan <lftan@altera.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-altera.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pcie-altera.c b/drivers/pci/host/pcie-altera.c
index ed736a9..072255d 100644
--- a/drivers/pci/host/pcie-altera.c
+++ b/drivers/pci/host/pcie-altera.c
@@ -55,6 +55,7 @@
 #define TLP_CFG_DW2(bus, devfn, offset)	\
 				(((bus) << 24) | ((devfn) << 16) | (offset))
 #define TLP_REQ_ID(bus, devfn)		(((bus) << 8) | (devfn))
+#define TLP_COMP_STATUS(s)		(((s) >> 12) & 7)
 #define TLP_HDR_SIZE			3
 #define TLP_LOOP			500
 #define RP_DEVFN			0
@@ -171,6 +172,7 @@ static int tlp_read_packet(struct altera_pcie *pcie, u32 *value)
 	bool sop = 0;
 	u32 ctrl;
 	u32 reg0, reg1;
+	u32 comp_status = 1;
 
 	/*
 	 * Minimum 2 loops to read TLP headers and 1 loop to read data
@@ -182,19 +184,25 @@ static int tlp_read_packet(struct altera_pcie *pcie, u32 *value)
 			reg0 = cra_readl(pcie, RP_RXCPL_REG0);
 			reg1 = cra_readl(pcie, RP_RXCPL_REG1);
 
-			if (ctrl & RP_RXCPL_SOP)
+			if (ctrl & RP_RXCPL_SOP) {
 				sop = true;
+				comp_status = TLP_COMP_STATUS(reg1);
+			}
 
 			if (ctrl & RP_RXCPL_EOP) {
+				if (comp_status)
+					return PCIBIOS_DEVICE_NOT_FOUND;
+
 				if (value)
 					*value = reg0;
+
 				return PCIBIOS_SUCCESSFUL;
 			}
 		}
 		udelay(5);
 	}
 
-	return -ENOENT;
+	return PCIBIOS_DEVICE_NOT_FOUND;
 }
 
 static void tlp_write_packet(struct altera_pcie *pcie, u32 *headers,
-- 
2.9.3
