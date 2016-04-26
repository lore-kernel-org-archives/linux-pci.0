Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34552 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751772AbcDZRbs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 26 Apr 2016 13:31:48 -0400
Date: Tue, 26 Apr 2016 12:31:44 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Kumar Gala <galak@codeaurora.org>,
	linux-arm-kernel@lists.infradead.org,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Hanna Hawa <hannah@marvell.com>,
	Yehuda Yitschak <yehuday@marvell.com>
Subject: Re: [PATCH v3 0/2] pci: host: new driver for Marvell Armada 7K/8K
 PCIe controller
Message-ID: <20160426173144.GB27803@localhost>
References: <1461659506-10387-1-git-send-email-thomas.petazzoni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1461659506-10387-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 26, 2016 at 10:31:44AM +0200, Thomas Petazzoni wrote:
> Hello,
> 
> Here is the third iteration of the PCIe host controller driver needed
> for the ARM64 Marvell Armada 7K/8K platform.
> 
> Changes since v2:
> 
>  - Added Rob Herring's Acked-by on the Device Tree binding patch.
> 
>  - Reworked the PCIe host driver following the suggestion of Bjorn
>    Helgaas: creation of armada8k_add_pcie_port() and
>    armada8k_pcie_establish_link() in order to follow the convention of
>    other Designware based drivers.
> 
> Thanks!
> 
> Thomas
> 
> Thomas Petazzoni (2):
>   dt-bindings: pci: add DT binding for Marvell Armada 7K/8K PCIe
>     controller
>   pci: host: new driver for Marvell Armada 7K/8K PCIe controller
> 
>  .../devicetree/bindings/pci/pci-armada8k.txt       |  38 +++
>  drivers/pci/host/Kconfig                           |  11 +
>  drivers/pci/host/Makefile                          |   1 +
>  drivers/pci/host/pcie-armada8k.c                   | 276 +++++++++++++++++++++
>  4 files changed, 326 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/pci-armada8k.txt
>  create mode 100644 drivers/pci/host/pcie-armada8k.c

Thanks, Thomas, I applied these to pci/host-armada for v4.7.

I added the tweaks below to use dev_dbg() instead of pr_debug(), use
dw_pcie_wait_for_link() instead of another hand-coded timeout loop,
and fix a typo and remove unused constants.

Bjorn


diff --git a/drivers/pci/host/pcie-armada8k.c b/drivers/pci/host/pcie-armada8k.c
index 7302de2..811ddf8 100644
--- a/drivers/pci/host/pcie-armada8k.c
+++ b/drivers/pci/host/pcie-armada8k.c
@@ -10,8 +10,6 @@
  * warranty of any kind, whether express or implied.
  */
 
-#define pr_fmt(fmt) "armada-8k-pcie: " fmt
-
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
@@ -39,8 +37,6 @@ struct armada8k_pcie {
 #define PCIE_APP_LTSSM_EN		BIT(2)
 #define PCIE_DEVICE_TYPE_SHIFT		4
 #define PCIE_DEVICE_TYPE_MASK		0xF
-#define PCIE_DEVICE_TYPE_EP		0x0 /* Endpoint */
-#define PCIE_DEVICE_TYPE_LEP		0x1 /* Legacy endpoint */
 #define PCIE_DEVICE_TYPE_RC		0x4 /* Root complex */
 
 #define PCIE_GLOBAL_STATUS_REG		0x8
@@ -69,14 +65,12 @@ struct armada8k_pcie {
 #define AX_USER_DOMAIN_MASK		0x3
 #define AX_USER_DOMAIN_SHIFT		4
 
-
-
 #define to_armada8k_pcie(x)	container_of(x, struct armada8k_pcie, pp)
 
 static int armada8k_pcie_link_up(struct pcie_port *pp)
 {
-	u32 reg;
 	struct armada8k_pcie *pcie = to_armada8k_pcie(pp);
+	u32 reg;
 	u32 mask = PCIE_GLB_STS_RDLH_LINK_UP | PCIE_GLB_STS_PHY_LINK_UP;
 
 	reg = readl(pcie->base + PCIE_GLOBAL_STATUS_REG);
@@ -84,7 +78,7 @@ static int armada8k_pcie_link_up(struct pcie_port *pp)
 	if ((reg & mask) == mask)
 		return 1;
 
-	pr_debug("No link detected (Global-Status: 0x%08x).\n", reg);
+	dev_dbg(pp->dev, "No link detected (Global-Status: 0x%08x).\n", reg);
 	return 0;
 }
 
@@ -92,10 +86,9 @@ static void armada8k_pcie_establish_link(struct pcie_port *pp)
 {
 	struct armada8k_pcie *pcie = to_armada8k_pcie(pp);
 	void __iomem *base = pcie->base;
-	int timeout = 1000;
 	u32 reg;
 
-	if (!armada8k_pcie_link_up(pp)) {
+	if (!dw_pcie_link_up(pp)) {
 		/* Disable LTSSM state machine to enable configuration */
 		reg = readl(base + PCIE_GLOBAL_CONTROL_REG);
 		reg &= ~(PCIE_APP_LTSSM_EN);
@@ -129,7 +122,7 @@ static void armada8k_pcie_establish_link(struct pcie_port *pp)
 	       PCIE_INT_C_ASSERT_MASK | PCIE_INT_D_ASSERT_MASK;
 	writel(reg, base + PCIE_GLOBAL_INT_MASK1_REG);
 
-	if (!armada8k_pcie_link_up(pp)) {
+	if (!dw_pcie_link_up(pp)) {
 		/* Configuration done. Start LTSSM */
 		reg = readl(base + PCIE_GLOBAL_CONTROL_REG);
 		reg |= PCIE_APP_LTSSM_EN;
@@ -137,14 +130,7 @@ static void armada8k_pcie_establish_link(struct pcie_port *pp)
 	}
 
 	/* Wait until the link becomes active again */
-	while (timeout) {
-		if (armada8k_pcie_link_up(pp))
-			break;
-		msleep(1);
-		timeout--;
-	}
-
-	if (timeout == 0)
+	if (dw_pcie_wait_for_link(pp))
 		dev_err(pp->dev, "Link not up after reconfiguration\n");
 }
 
@@ -163,7 +149,7 @@ static irqreturn_t armada8k_pcie_irq_handler(int irq, void *arg)
 
 	/*
 	 * Interrupts are directly handled by the device driver of the
-	 * PCI device. However, there are also latched into the PCIe
+	 * PCI device.  However, they are also latched into the PCIe
 	 * controller, so we simply discard them.
 	 */
 	val = readl(base + PCIE_GLOBAL_INT_CAUSE1_REG);
