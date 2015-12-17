Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relmlor3.renesas.com ([210.160.252.173]:37276 "EHLO
	relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S966642AbbLQNXR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 17 Dec 2015 08:23:17 -0500
From: Phil Edworthy <phil.edworthy@renesas.com>
To: Simon Horman <horms@verge.net.au>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Wolfram Sang <wsa@the-dreams.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-sh@vger.kernel.org>,
	Phil Edworthy <phil.edworthy@renesas.com>
Subject: [PATCH 2/4] PCI: rcar: Support runtime PM link state L1 handling in pcie-rcar
Date: Thu, 17 Dec 2015 13:22:35 +0000
Message-Id: <1450358557-28376-3-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1450358557-28376-1-git-send-email-phil.edworthy@renesas.com>
References: <1450358557-28376-1-git-send-email-phil.edworthy@renesas.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The R-Car PCIe host controller does not handle L1 ASPM. Instead, the
hardware needs assistance to transition to L1. When the controller
has received a PM_ENTER_L1 DLLP, we can't access a card's config regs
until we have got it out of L1 link state. The host controller will
handle this as long as it has also been transitioned to L1 link state.

So, when attempting a config access, check to see if the card has gone
into L1, and if so, do the same for the host controller.

This is based on a patch by Hien Dang <hien.dang.eb@rvc.renesas.com>

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
 drivers/pci/host/pcie-rcar.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index c72c0ae..4a4f8e1 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -83,6 +83,14 @@
 #define MACSR			0x011054
 #define MACCTLR			0x011058
 #define  SCRAMBLE_DISABLE	(1 << 27)
+#define PMSR			0x01105c
+#define  L1FAEG			(1 << 31)
+#define  PM_ENTER_L1RX		(1 << 23)
+#define  PMSTATE		(7 << 16)
+#define  PMSTATE_L1		(3 << 16)
+#define PMCTLR			0x011060
+#define  L1_INIT		(1 << 31)
+
 
 /* R-Car H1 PHY */
 #define H1_PCIEPHYADRR		0x04000c
@@ -175,6 +183,7 @@ static int rcar_pcie_config_access(struct rcar_pcie *pcie,
 		unsigned int devfn, int where, u32 *data)
 {
 	int dev, func, reg, index;
+	u32 val;
 
 	dev = PCI_SLOT(devfn);
 	func = PCI_FUNC(devfn);
@@ -216,6 +225,22 @@ static int rcar_pcie_config_access(struct rcar_pcie *pcie,
 	if (pcie->root_bus_nr < 0)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
+	/*
+	 * If we are not in L1 link state but have received PM_ENTER_L1 DLLP,
+	 * transition to L1 link state. The HW will handle coming out of L1.
+	 */
+	val = rcar_pci_read_reg(pcie, PMSR);
+	if ((val & PM_ENTER_L1RX) && ((val & PMSTATE) != PMSTATE_L1)) {
+		rcar_pci_write_reg(pcie, L1_INIT, PMCTLR);
+
+		/* Wait until we are in L1 */
+		while (!(val & L1FAEG))
+			val = rcar_pci_read_reg(pcie, PMSR);
+
+		/* Clear flags indicating link has transitioned to L1 */
+		rcar_pci_write_reg(pcie, L1FAEG | PM_ENTER_L1RX, PMSR);
+	}
+
 	/* Clear errors */
 	rcar_pci_write_reg(pcie, rcar_pci_read_reg(pcie, PCIEERRFR), PCIEERRFR);
 
-- 
2.5.0

