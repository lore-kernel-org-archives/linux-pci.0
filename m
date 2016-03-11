Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 11 Mar 2016 15:10:53 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	michals@xilinx.com, sorenb@xilinx.com, bhelgaas@google.com,
	arnd@arndb.de, tinamdar@apm.com, treding@nvidia.com,
	rjui@broadcom.com, Minghuan.Lian@freescale.com,
	m-karicheri2@ti.com, hauke@hauke-m.de, marc.zyngier@arm.com,
	dhdang@apm.com, sbranden@broadcom.com, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Bharat Kumar Gogada <bharatku@xilinx.com>,
	Ravi Kiran Gummaluri <rgummal@xilinx.com>
Subject: Re: [PATCH v12] [PATCH] PCI: Xilinx-NWL-PCIe: Adding support for
 Xilinx NWL PCIe Host Controller
Message-ID: <20160311211053.GF4725@localhost>
References: <1457281934-32068-1-git-send-email-bharatku@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1457281934-32068-1-git-send-email-bharatku@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Mar 06, 2016 at 10:02:14PM +0530, Bharat Kumar Gogada wrote:
> Adding PCIe Root Port driver for Xilinx PCIe NWL bridge IP.
> 
> Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
> Signed-off-by: Ravi Kiran Gummaluri <rgummal@xilinx.com>
> ---
> Changes for v12:
> -> Removed nwl_setup_sspl function, it will be added after more
> testing.
> -> Broke nwl_pcie_link_up into nwl_pcie_link_up, nwl_phy_link_up
> functions.
> -> Using generic functions for configuration read and write.
> -> Removed unneccessary comments.
> -> Removed unneccessary new lines.
> -> Added #define for number of legacy interrupts.
> -> Changed MSI interrupt handlers registering sequence.
> ---
>  .../devicetree/bindings/pci/xilinx-nwl-pcie.txt    |  68 ++
>  drivers/pci/host/Kconfig                           |  10 +
>  drivers/pci/host/Makefile                          |   1 +
>  drivers/pci/host/pcie-xilinx-nwl.c                 | 912 +++++++++++++++++++++
>  4 files changed, 991 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/xilinx-nwl-pcie.txt
>  create mode 100644 drivers/pci/host/pcie-xilinx-nwl.c

I applied this to pci/host-xilinx-nwl for v4.6.

I cleaned up a bunch of stuff: whitespace, spelling, unused
definitions, etc., and also some minor code cleanups.  I can't build
it myself, so please check and make sure I didn't break anything.

You can browse or check out the branch from here:
https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/log/?h=pci/host-xilinx-nwl

Here's the diff showing what I changed relative to the patch you
posted:

diff --git a/Documentation/devicetree/bindings/pci/xilinx-nwl-pcie.txt b/Documentation/devicetree/bindings/pci/xilinx-nwl-pcie.txt
index 90e8f32..337fc97 100644
--- a/Documentation/devicetree/bindings/pci/xilinx-nwl-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/xilinx-nwl-pcie.txt
@@ -7,7 +7,7 @@ Required properties:
 - #interrupt-cells: specifies the number of cells needed to encode an
 	interrupt source. The value must be 1.
 - reg: Should contain Bridge, PCIe Controller registers location,
-	configuration sapce, and length
+	configuration space, and length
 - reg-names: Must include the following entries:
 	"breg": bridge registers
 	"pcireg": PCIe controller registers
@@ -15,8 +15,8 @@ Required properties:
 - device_type: must be "pci"
 - interrupts: Should contain NWL PCIe interrupt
 - interrupt-names: Must include the following entries:
-	"msi1, msi0": interrupt asserted when msi is received
-	"intx": interrupt that is asserted when an legacy interrupt is received
+	"msi1, msi0": interrupt asserted when MSI is received
+	"intx": interrupt asserted when a legacy interrupt is received
 	"misc": interrupt asserted when miscellaneous is received
 - interrupt-map-mask and interrupt-map: standard PCI properties to define the
 	mapping of the PCI interface to interrupt numbers.
diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index 466a601..c39989a 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -21,7 +21,7 @@ config PCIE_XILINX_NWL
 	depends on ARCH_ZYNQMP
 	select PCI_MSI_IRQ_DOMAIN if PCI_MSI
 	help
-	 Say 'Y' here if you want kernel to support for Xilinx
+	 Say 'Y' here if you want kernel support for Xilinx
 	 NWL PCIe controller. The controller can act as Root Port
 	 or End Point. The current option selection will only
 	 support root port enabling.
diff --git a/drivers/pci/host/pcie-xilinx-nwl.c b/drivers/pci/host/pcie-xilinx-nwl.c
index e5774dc..7a2dc2e 100644
--- a/drivers/pci/host/pcie-xilinx-nwl.c
+++ b/drivers/pci/host/pcie-xilinx-nwl.c
@@ -27,26 +27,15 @@
 
 /* Bridge core config registers */
 #define BRCFG_PCIE_RX0			0x00000000
-#define BRCFG_PCIE_RX1			0x00000004
-#define BRCFG_AXI_MASTER		0x00000008
-#define BRCFG_PCIE_TX			0x0000000C
 #define BRCFG_INTERRUPT			0x00000010
-#define BRCFG_RAM_DISABLE0		0x00000014
-#define BRCFG_RAM_DISABLE1		0x00000018
-#define BRCFG_PCIE_RELAXED_ORDER	0x0000001C
 #define BRCFG_PCIE_RX_MSG_FILTER	0x00000020
 
-/* Attribute registers */
-#define NWL_ATTRIB_100			0x00000190
-
 /* Egress - Bridge translation registers */
 #define E_BREG_CAPABILITIES		0x00000200
-#define E_BREG_STATUS			0x00000204
 #define E_BREG_CONTROL			0x00000208
 #define E_BREG_BASE_LO			0x00000210
 #define E_BREG_BASE_HI			0x00000214
 #define E_ECAM_CAPABILITIES		0x00000220
-#define E_ECAM_STATUS			0x00000224
 #define E_ECAM_CONTROL			0x00000228
 #define E_ECAM_BASE_LO			0x00000230
 #define E_ECAM_BASE_HI			0x00000234
@@ -68,11 +57,6 @@
 #define MSGF_MSI_STATUS_HI		0x00000444
 #define MSGF_MSI_MASK_LO		0x00000448
 #define MSGF_MSI_MASK_HI		0x0000044C
-#define MSGF_RX_FIFO_POP		0x00000484
-#define MSGF_RX_FIFO_TYPE		0x00000488
-#define MSGF_RX_FIFO_ADDRLO		0x00000490
-#define MSGF_RX_FIFO_ADDRHI		0x00000494
-#define MSGF_RX_FIFO_DATA		0x00000498
 
 /* Msg filter mask bits */
 #define CFG_ENABLE_PM_MSG_FWD		BIT(1)
@@ -116,10 +100,6 @@
 					MSGF_MISC_SR_PCIE_CORE | \
 					MSGF_MISC_SR_PCIE_CORE_ERR)
 
-/* Message rx fifo type mask bits */
-#define MSGF_RX_FIFO_TYPE_MSI		(1)
-#define MSGF_RX_FIFO_TYPE_TYPE		GENMASK(1, 0)
-
 /* Legacy interrupt status mask bits */
 #define MSGF_LEG_SR_INTA		BIT(0)
 #define MSGF_LEG_SR_INTB		BIT(1)
@@ -144,30 +124,27 @@
 
 /* E_ECAM status mask bits */
 #define E_ECAM_PRESENT			BIT(0)
-#define E_ECAM_SR_WR_PEND		BIT(16)
-#define E_ECAM_SR_RD_PEND		BIT(0)
-#define E_ECAM_SR_MASKALL		(E_ECAM_SR_WR_PEND | E_ECAM_SR_RD_PEND)
 #define E_ECAM_CR_ENABLE		BIT(0)
 #define E_ECAM_SIZE_LOC			GENMASK(20, 16)
 #define E_ECAM_SIZE_SHIFT		16
 #define ECAM_BUS_LOC_SHIFT		20
 #define ECAM_DEV_LOC_SHIFT		12
 #define NWL_ECAM_VALUE_DEFAULT		12
-#define NWL_ECAM_SIZE_MIN		4096
 
-#define ATTR_UPSTREAM_FACING		BIT(6)
 #define CFG_DMA_REG_BAR			GENMASK(2, 0)
 
 #define INT_PCI_MSI_NR			(2 * 32)
-
 #define INTX_NUM			4
+
 /* Readin the PS_LINKUP */
 #define PS_LINKUP_OFFSET		0x00000238
 #define PCIE_PHY_LINKUP_BIT		BIT(0)
 #define PHY_RDY_LINKUP_BIT		BIT(1)
-#define PCIE_USER_LINKUP		0
-#define PHY_RDY_LINKUP			1
-#define LINKUP_ITER_CHECK		5
+
+/* Parameters for the waiting for link up routine */
+#define LINK_WAIT_MAX_RETRIES          10
+#define LINK_WAIT_USLEEP_MIN           90000
+#define LINK_WAIT_USLEEP_MAX           100000
 
 struct nwl_msi {			/* MSI information */
 	struct irq_domain *msi_domain;
@@ -194,7 +171,6 @@ struct nwl_pcie {
 	u32 ecam_value;
 	u8 last_busno;
 	u8 root_busno;
-	u8 link_up;
 	struct nwl_msi msi;
 	struct irq_domain *legacy_irq_domain;
 };
@@ -223,11 +199,26 @@ static bool nwl_phy_link_up(struct nwl_pcie *pcie)
 	return false;
 }
 
+static int nwl_wait_for_link(struct nwl_pcie *pcie)
+{
+	int retries;
+
+	/* check if the link is up or not */
+	for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
+		if (nwl_phy_link_up(pcie))
+			return 0;
+		usleep_range(LINK_WAIT_USLEEP_MIN, LINK_WAIT_USLEEP_MAX);
+	}
+
+	dev_err(pcie->dev, "PHY link never came up\n");
+	return -ETIMEDOUT;
+}
+
 static bool nwl_pcie_valid_device(struct pci_bus *bus, unsigned int devfn)
 {
 	struct nwl_pcie *pcie = bus->sysdata;
 
-	/* Check link,before accessing downstream ports */
+	/* Check link before accessing downstream ports */
 	if (bus->number != pcie->root_busno) {
 		if (!nwl_pcie_link_up(pcie))
 			return false;
@@ -250,9 +241,8 @@ static bool nwl_pcie_valid_device(struct pci_bus *bus, unsigned int devfn)
  * Return: Base address of the configuration space needed to be
  *	   accessed.
  */
-static void __iomem *nwl_pcie_map_bus(struct pci_bus *bus,
-						 unsigned int devfn,
-						 int where)
+static void __iomem *nwl_pcie_map_bus(struct pci_bus *bus, unsigned int devfn,
+				      int where)
 {
 	struct nwl_pcie *pcie = bus->sysdata;
 	int relbus;
@@ -323,8 +313,7 @@ static void nwl_pcie_leg_handler(struct irq_desc *desc)
 
 	while ((status = nwl_bridge_readl(pcie, MSGF_LEG_STATUS) &
 				MSGF_LEG_SR_MASKALL) != 0) {
-		for_each_set_bit(bit, &status, 4) {
-
+		for_each_set_bit(bit, &status, INTX_NUM) {
 			virq = irq_find_mapping(pcie->legacy_irq_domain,
 						bit + 1);
 			if (virq)
@@ -357,29 +346,25 @@ static void nwl_pcie_handle_msi_irq(struct nwl_pcie *pcie, u32 status_reg)
 static void nwl_pcie_msi_handler_high(struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
-	struct nwl_pcie *pcie;
+	struct nwl_pcie *pcie = irq_desc_get_handler_data(desc);
 
 	chained_irq_enter(chip, desc);
-	pcie = irq_desc_get_handler_data(desc);
 	nwl_pcie_handle_msi_irq(pcie, MSGF_MSI_STATUS_HI);
-
 	chained_irq_exit(chip, desc);
 }
 
 static void nwl_pcie_msi_handler_low(struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
-	struct nwl_pcie *pcie;
+	struct nwl_pcie *pcie = irq_desc_get_handler_data(desc);
 
 	chained_irq_enter(chip, desc);
-	pcie = irq_desc_get_handler_data(desc);
 	nwl_pcie_handle_msi_irq(pcie, MSGF_MSI_STATUS_LO);
-
 	chained_irq_exit(chip, desc);
 }
 
 static int nwl_legacy_map(struct irq_domain *domain, unsigned int irq,
-				irq_hw_number_t hwirq)
+			  irq_hw_number_t hwirq)
 {
 	irq_set_chip_and_handler(irq, &dummy_irq_chip, handle_simple_irq);
 	irq_set_chip_data(irq, domain->host_data);
@@ -441,16 +426,13 @@ static int nwl_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 	mutex_lock(&msi->lock);
 	bit = bitmap_find_next_zero_area(msi->bitmap, INT_PCI_MSI_NR, 0,
 					 nr_irqs, 0);
-	if (bit < INT_PCI_MSI_NR)
-		bitmap_set(msi->bitmap, bit, nr_irqs);
-	else
-		bit = -ENOSPC;
-
-	if (bit < 0) {
+	if (bit >= INT_PCI_MSI_NR) {
 		mutex_unlock(&msi->lock);
-		return bit;
+		return -ENOSPC;
 	}
 
+	bitmap_set(msi->bitmap, bit, nr_irqs);
+
 	for (i = 0; i < nr_irqs; i++) {
 		irq_domain_set_info(domain, virq + i, bit + i, &nwl_irq_chip,
 				domain->host_data, handle_simple_irq,
@@ -518,14 +500,14 @@ static int nwl_pcie_init_msi_irq_domain(struct nwl_pcie *pcie)
 	struct nwl_msi *msi = &pcie->msi;
 
 	msi->dev_domain = irq_domain_add_linear(NULL, INT_PCI_MSI_NR,
-					&dev_msi_domain_ops, pcie);
+						&dev_msi_domain_ops, pcie);
 	if (!msi->dev_domain) {
 		dev_err(pcie->dev, "failed to create dev IRQ domain\n");
 		return -ENOMEM;
 	}
 	msi->msi_domain = pci_msi_create_irq_domain(fwnode,
-							&nwl_msi_domain_info,
-							msi->dev_domain);
+						    &nwl_msi_domain_info,
+						    msi->dev_domain);
 	if (!msi->msi_domain) {
 		dev_err(pcie->dev, "failed to create msi IRQ domain\n");
 		irq_domain_remove(msi->dev_domain);
@@ -557,7 +539,6 @@ static int nwl_pcie_init_irq_domain(struct nwl_pcie *pcie)
 	}
 
 	nwl_pcie_init_msi_irq_domain(pcie);
-
 	return 0;
 }
 
@@ -582,9 +563,10 @@ static int nwl_pcie_enable_msi(struct nwl_pcie *pcie, struct pci_bus *bus)
 		ret = -EINVAL;
 		goto err;
 	}
-	/* Register msi handler */
+
 	irq_set_chained_handler_and_data(msi->irq_msi1,
 					 nwl_pcie_msi_handler_high, pcie);
+
 	/* Get msi_0 IRQ number */
 	msi->irq_msi0 = platform_get_irq_byname(pdev, "msi0");
 	if (msi->irq_msi0 < 0) {
@@ -593,9 +575,9 @@ static int nwl_pcie_enable_msi(struct nwl_pcie *pcie, struct pci_bus *bus)
 		goto err;
 	}
 
-	/* Register msi handler */
 	irq_set_chained_handler_and_data(msi->irq_msi0,
 					 nwl_pcie_msi_handler_low, pcie);
+
 	/* Check for msii_present bit */
 	ret = nwl_bridge_readl(pcie, I_MSII_CAPABILITIES) & MSII_PRESENT;
 	if (!ret) {
@@ -618,7 +600,7 @@ static int nwl_pcie_enable_msi(struct nwl_pcie *pcie, struct pci_bus *bus)
 	nwl_bridge_writel(pcie, upper_32_bits(base), I_MSII_BASE_HI);
 
 	/*
-	 * For high range msi interrupts: disable, clear any pending,
+	 * For high range MSI interrupts: disable, clear any pending,
 	 * and enable
 	 */
 	nwl_bridge_writel(pcie, (u32)~MSGF_MSI_SR_HI_MASK, MSGF_MSI_MASK_HI);
@@ -629,7 +611,7 @@ static int nwl_pcie_enable_msi(struct nwl_pcie *pcie, struct pci_bus *bus)
 	nwl_bridge_writel(pcie, MSGF_MSI_SR_HI_MASK, MSGF_MSI_MASK_HI);
 
 	/*
-	 * For low range msi interrupts: disable, clear any pending,
+	 * For low range MSI interrupts: disable, clear any pending,
 	 * and enable
 	 */
 	nwl_bridge_writel(pcie, (u32)~MSGF_MSI_SR_LO_MASK, MSGF_MSI_MASK_LO);
@@ -651,15 +633,13 @@ static int nwl_pcie_bridge_init(struct nwl_pcie *pcie)
 	struct platform_device *pdev = to_platform_device(pcie->dev);
 	u32 breg_val, ecam_val, first_busno = 0;
 	int err;
-	int check_link_up = 0;
-	bool link_up;
 
-	/* Check for BREG present bit */
 	breg_val = nwl_bridge_readl(pcie, E_BREG_CAPABILITIES) & BREG_PRESENT;
 	if (!breg_val) {
 		dev_err(pcie->dev, "BREG is not present\n");
 		return breg_val;
 	}
+
 	/* Write bridge_off to breg base */
 	nwl_bridge_writel(pcie, lower_32_bits(pcie->phys_breg_base),
 			  E_BREG_BASE_LO);
@@ -680,15 +660,10 @@ static int nwl_pcie_bridge_init(struct nwl_pcie *pcie)
 	/* Enable msg filtering details */
 	nwl_bridge_writel(pcie, CFG_ENABLE_MSG_FILTER_MASK,
 			  BRCFG_PCIE_RX_MSG_FILTER);
-	do {
-		link_up = nwl_phy_link_up(pcie);
-		if (!link_up) {
-			check_link_up++;
-			if (check_link_up > LINKUP_ITER_CHECK)
-				return -ENODEV;
-			msleep(1000);
-		}
-	} while (!link_up);
+
+	err = nwl_wait_for_link(pcie);
+	if (err)
+		return err;
 
 	ecam_val = nwl_bridge_readl(pcie, E_ECAM_CAPABILITIES) & E_ECAM_PRESENT;
 	if (!ecam_val) {
@@ -718,8 +693,7 @@ static int nwl_pcie_bridge_init(struct nwl_pcie *pcie)
 	ecam_val |= (pcie->last_busno << E_ECAM_SIZE_SHIFT);
 	writel(ecam_val, (pcie->ecam_base + PCI_PRIMARY_BUS));
 
-	pcie->link_up = nwl_pcie_link_up(pcie);
-	if (pcie->link_up)
+	if (nwl_pcie_link_up(pcie))
 		dev_info(pcie->dev, "Link is UP\n");
 	else
 		dev_info(pcie->dev, "Link is DOWN\n");
@@ -731,7 +705,7 @@ static int nwl_pcie_bridge_init(struct nwl_pcie *pcie)
 			pcie->irq_misc);
 		return -EINVAL;
 	}
-	/* Register misc handler */
+
 	err = devm_request_irq(pcie->dev, pcie->irq_misc,
 			       nwl_pcie_misc_handler, IRQF_SHARED,
 			       "nwl_pcie:misc", pcie);
@@ -770,7 +744,7 @@ static int nwl_pcie_bridge_init(struct nwl_pcie *pcie)
 }
 
 static int nwl_pcie_parse_dt(struct nwl_pcie *pcie,
-					struct platform_device *pdev)
+			     struct platform_device *pdev)
 {
 	struct device_node *node = pcie->dev->of_node;
 	struct resource *res;
@@ -809,7 +783,6 @@ static int nwl_pcie_parse_dt(struct nwl_pcie *pcie,
 		return -EINVAL;
 	}
 
-	/* Register intx handler */
 	irq_set_chained_handler_and_data(pcie->irq_intx,
 					 nwl_pcie_leg_handler, pcie);
 
@@ -835,16 +808,15 @@ static int nwl_pcie_probe(struct platform_device *pdev)
 	if (!pcie)
 		return -ENOMEM;
 
-	pcie->ecam_value = NWL_ECAM_VALUE_DEFAULT;
-
 	pcie->dev = &pdev->dev;
+	pcie->ecam_value = NWL_ECAM_VALUE_DEFAULT;
 
 	err = nwl_pcie_parse_dt(pcie, pdev);
 	if (err) {
 		dev_err(pcie->dev, "Parsing DT failed\n");
 		return err;
 	}
-	/* Bridge initialization */
+
 	err = nwl_pcie_bridge_init(pcie);
 	if (err) {
 		dev_err(pcie->dev, "HW Initalization failed\n");
@@ -868,7 +840,6 @@ static int nwl_pcie_probe(struct platform_device *pdev)
 	if (!bus)
 		return -ENOMEM;
 
-	/* Enable MSI */
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
 		err = nwl_pcie_enable_msi(pcie, bus);
 		if (err < 0) {
@@ -883,7 +854,6 @@ static int nwl_pcie_probe(struct platform_device *pdev)
 		pcie_bus_configure_settings(child);
 	pci_bus_add_devices(bus);
 	platform_set_drvdata(pdev, pcie);
-
 	return 0;
 }
 
@@ -893,7 +863,6 @@ static int nwl_pcie_remove(struct platform_device *pdev)
 
 	nwl_pcie_free_irq_domain(pcie);
 	platform_set_drvdata(pdev, NULL);
-
 	return 0;
 }
 
