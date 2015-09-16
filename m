Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:5263 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753338AbbIPAjO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 15 Sep 2015 20:39:14 -0400
From: Ray Jui <rjui@broadcom.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Hauke Mehrtens <hauke@hauke-m.de>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>
Subject: [PATCH 4/8] PCI: iproc: Fix PCIe reset logic
Date: Tue, 15 Sep 2015 17:39:18 -0700
Message-ID: <1442363962-29805-5-git-send-email-rjui@broadcom.com>
In-Reply-To: <1442363962-29805-1-git-send-email-rjui@broadcom.com>
References: <1442363962-29805-1-git-send-email-rjui@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The current iProc PCIe reset logic does not always properly reset the
device. For example, in the case when the perst_b signal is already
de-asserted in the bootloader, the current reset logic fails to trigger
a proper asssert -> de-assert reset sequence. This patch fixes the issue
by always triggering the proper reset sequence

This patch also explicitly selects the desired reset source, i.e.,
perst_b and reduces the wait time after the device comes out of reset
from 250 ms to 100 ms, based on recommendation from the ASIC team

Signed-off-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Vladimir Dreizin <vdreizin@broadcom.com>
Reviewed-by: Trac Hoang <trhoang@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
Tested-by: Vladimir Dreizin <vdreizin@broadcom.com>
Tested-by: Darren Edamura <dedamura@broadcom.com>
---
 drivers/pci/host/pcie-iproc.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
index 52e7ff2..80e0541 100644
--- a/drivers/pci/host/pcie-iproc.c
+++ b/drivers/pci/host/pcie-iproc.c
@@ -31,6 +31,8 @@
 #include "pcie-iproc.h"
 
 #define CLK_CONTROL_OFFSET           0x000
+#define EP_PERST_SOURCE_SELECT_SHIFT 2
+#define EP_PERST_SOURCE_SELECT       BIT(EP_PERST_SOURCE_SELECT_SHIFT)
 #define EP_MODE_SURVIVE_PERST_SHIFT  1
 #define EP_MODE_SURVIVE_PERST        BIT(EP_MODE_SURVIVE_PERST_SHIFT)
 #define RC_PCIE_RST_OUTPUT_SHIFT     0
@@ -119,15 +121,18 @@ static void iproc_pcie_reset(struct iproc_pcie *pcie)
 	u32 val;
 
 	/*
-	 * Configure the PCIe controller as root complex and send a downstream
-	 * reset
+	 * Select perst_b signal as reset source. Put the device into reset,
+	 * and then bring it out of reset
 	 */
-	val = EP_MODE_SURVIVE_PERST | RC_PCIE_RST_OUTPUT;
+	val = readl(pcie->base + CLK_CONTROL_OFFSET);
+	val &= ~EP_PERST_SOURCE_SELECT & ~EP_MODE_SURVIVE_PERST &
+		~RC_PCIE_RST_OUTPUT;
 	writel(val, pcie->base + CLK_CONTROL_OFFSET);
 	udelay(250);
-	val &= ~EP_MODE_SURVIVE_PERST;
+
+	val |= RC_PCIE_RST_OUTPUT;
 	writel(val, pcie->base + CLK_CONTROL_OFFSET);
-	msleep(250);
+	msleep(100);
 }
 
 static int iproc_pcie_check_link(struct iproc_pcie *pcie, struct pci_bus *bus)
-- 
1.9.1

