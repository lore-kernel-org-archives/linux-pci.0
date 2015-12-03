Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1bn0100.outbound.protection.outlook.com ([157.56.110.100]:47488
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1759865AbbLCLSN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 3 Dec 2015 06:18:13 -0500
From: Ley Foon Tan <lftan@altera.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Ley Foon Tan <lftan@altera.com>, <lftan.linux@gmail.com>
Subject: [PATCH 2/3] PCI: altera: check TLP completion status
Date: Thu, 3 Dec 2015 19:17:53 +0800
Message-ID: <1449141474-3378-3-git-send-email-lftan@altera.com>
In-Reply-To: <1449141474-3378-1-git-send-email-lftan@altera.com>
References: <1449141474-3378-1-git-send-email-lftan@altera.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Check TLP packet successful completion status. This fix the issue when
accessing multi-function devices in enumeration process, TLP will return
error when accessing non-exist function number. Returns PCI error code
instead of generic errno.

Tested on Ethernet adapter card with multi-functions.

Signed-off-by: Ley Foon Tan <lftan@altera.com>
---
 drivers/pci/host/pcie-altera.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/host/pcie-altera.c b/drivers/pci/host/pcie-altera.c
index f05180f..e4176b3 100644
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
-				if (value)
-					*value = reg0;
-				return PCIBIOS_SUCCESSFUL;
+				if (!comp_status) {
+					if (value)
+						*value = reg0;
+					return PCIBIOS_SUCCESSFUL;
+				} else {
+					return PCIBIOS_DEVICE_NOT_FOUND;
+				}
 			}
 		}
 		udelay(5);
 	}
 
-	return -ENOENT;
+	return PCIBIOS_DEVICE_NOT_FOUND;
 }
 
 static void tlp_write_packet(struct altera_pcie *pcie, u32 *headers,
-- 
1.8.2.1

