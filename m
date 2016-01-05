Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relmlor2.renesas.com ([210.160.252.172]:52059 "EHLO
	relmlie1.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752476AbcAENBF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 5 Jan 2016 08:01:05 -0500
From: Phil Edworthy <phil.edworthy@renesas.com>
To: Simon Horman <horms@verge.net.au>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Wolfram Sang <wsa@the-dreams.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-sh@vger.kernel.org>,
	Phil Edworthy <phil.edworthy@renesas.com>
Subject: [PATCH v2 2/4] PCI: rcar: Support runtime PM link state L1 handling in pcie-rcar
Date: Tue,  5 Jan 2016 13:00:29 +0000
Message-Id: <1451998831-27705-3-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1451998831-27705-1-git-send-email-phil.edworthy@renesas.com>
References: <1451998831-27705-1-git-send-email-phil.edworthy@renesas.com>
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
v2:
 - Use readl_poll_timeout_atomic when waiting until we are in L1.
---
 drivers/pci/host/pcie-rcar.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index c72c0ae..31ad93a 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -15,6 +15,7 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
+#include <linux/iopoll.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
@@ -83,6 +84,14 @@
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
@@ -175,6 +184,8 @@ static int rcar_pcie_config_access(struct rcar_pcie *pcie,
 		unsigned int devfn, int where, u32 *data)
 {
 	int dev, func, reg, index;
+	u32 val;
+	int err;
 
 	dev = PCI_SLOT(devfn);
 	func = PCI_FUNC(devfn);
@@ -216,6 +227,26 @@ static int rcar_pcie_config_access(struct rcar_pcie *pcie,
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
+		err = readl_poll_timeout_atomic(pcie->base + PMSR,
+			val, (val & L1FAEG), 5, 1000000);
+		if (err) {
+			dev_err(pcie->dev, "poll for L1 state timed out\n");
+			return PCIBIOS_DEVICE_NOT_FOUND;
+		}
+
+		/* Clear flags indicating link has transitioned to L1 */
+		rcar_pci_write_reg(pcie, L1FAEG | PM_ENTER_L1RX, PMSR);
+	}
+
 	/* Clear errors */
 	rcar_pci_write_reg(pcie, rcar_pci_read_reg(pcie, PCIEERRFR), PCIEERRFR);
 
-- 
2.5.0

