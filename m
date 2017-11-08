Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:56138 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751900AbdKHJ2W (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Nov 2017 04:28:22 -0500
From: Marek Vasut <marek.vasut@gmail.com>
To: linux-pci@vger.kernel.org
Cc: Phil Edworthy <phil.edworthy@renesas.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH 2/3] PCI: rcar: Support runtime PM, link state L1 handling
Date: Wed,  8 Nov 2017 10:28:05 +0100
Message-Id: <20171108092806.10335-2-marek.vasut+renesas@gmail.com>
In-Reply-To: <20171108092806.10335-1-marek.vasut+renesas@gmail.com>
References: <20171108092806.10335-1-marek.vasut+renesas@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Phil Edworthy <phil.edworthy@renesas.com>

Most PCIe host controllers support L0s and L1 power states via ASPM.
The R-Car hardware only supports L0s, so when the system suspends and
resumes we have to manually handle L1.

When the system suspends, cards can put themselves into L1 and send a
PM_ENTER_L1 DLLP to the host controller. At this point, we can no longer
access the card's config registers.

The R-Car host controller will handle taking cards out of L1 as long as
the host controller has also been transitioned to L1 link state.

Ideally, we would detect the PM_ENTER_L1 DLLP using an interrupt and
transition the host to L1 immediately. However, this patch just ensures
that we can talk to cards after they have gone into L1.
When attempting a config access, it checks to see if the card has gone
into L1, and if so, does the same for the host controller.

This is based on a patch by Hien Dang <hien.dang.eb@rvc.renesas.com>

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-renesas-soc@vger.kernel.org
---
 drivers/pci/host/pcie-rcar.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index aa588a7d4811..2b28292de93a 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -92,6 +92,13 @@
 #define MACCTLR			0x011058
 #define  SPEED_CHANGE		(1 << 24)
 #define  SCRAMBLE_DISABLE	(1 << 27)
+#define PMSR			0x01105c
+#define  L1FAEG			(1 << 31)
+#define  PM_ENTER_L1RX		(1 << 23)
+#define  PMSTATE		(7 << 16)
+#define  PMSTATE_L1		(3 << 16)
+#define PMCTLR			0x011060
+#define  L1_INIT		(1 << 31)
 #define MACS2R			0x011078
 #define MACCGSPSETR		0x011084
 #define  SPCNGRSN		(1 << 31)
@@ -191,6 +198,7 @@ static int rcar_pcie_config_access(struct rcar_pcie *pcie,
 		unsigned int devfn, int where, u32 *data)
 {
 	int dev, func, reg, index;
+	u32 val;
 
 	dev = PCI_SLOT(devfn);
 	func = PCI_FUNC(devfn);
@@ -232,6 +240,22 @@ static int rcar_pcie_config_access(struct rcar_pcie *pcie,
 	if (pcie->root_bus_nr < 0)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
+	/*
+	 * If we are not in L1 link state and we have received PM_ENTER_L1 DLLP,
+	 * transition to L1 link state. The HW will handle coming of of L1.
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
2.11.0
