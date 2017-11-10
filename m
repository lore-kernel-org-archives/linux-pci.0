Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37815 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750932AbdKJV7D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Nov 2017 16:59:03 -0500
From: Marek Vasut <marek.vasut@gmail.com>
To: linux-pci@vger.kernel.org
Cc: Phil Edworthy <phil.edworthy@renesas.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH V2 4/5] PCI: rcar: Support runtime PM, link state L1 handling
Date: Fri, 10 Nov 2017 22:58:42 +0100
Message-Id: <20171110215843.432-5-marek.vasut+renesas@gmail.com>
In-Reply-To: <20171110215843.432-1-marek.vasut+renesas@gmail.com>
References: <20171110215843.432-1-marek.vasut+renesas@gmail.com>
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
Cc: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-renesas-soc@vger.kernel.org
---
V2: - Drop extra parenthesis
    - Use GENMASK()
    - Fix comment "The HW will handle coming of of L1.", s/of of/out of/
---
 drivers/pci/host/pcie-rcar.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index ab61829db389..068bf9067ec1 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -92,6 +92,13 @@
 #define MACCTLR			0x011058
 #define  SPEED_CHANGE		BIT(24)
 #define  SCRAMBLE_DISABLE	BIT(27)
+#define PMSR			0x01105c
+#define  L1FAEG			BIT(31)
+#define  PM_ENTER_L1RX		BIT(23)
+#define  PMSTATE		GENMASK(18, 16)
+#define  PMSTATE_L1		GENMASK(17, 16)
+#define PMCTLR			0x011060
+#define  L1_INIT		BIT(31)
 #define MACS2R			0x011078
 #define MACCGSPSETR		0x011084
 #define  SPCNGRSN		BIT(31)
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
+	 * transition to L1 link state. The HW will handle coming out of L1.
+	 */
+	val = rcar_pci_read_reg(pcie, PMSR);
+	if (val & PM_ENTER_L1RX && (val & PMSTATE) != PMSTATE_L1) {
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
