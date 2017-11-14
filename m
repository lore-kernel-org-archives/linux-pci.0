Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jim Quinlan <jim2101024@gmail.com>
To: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jonas Gorski <jonas.gorski@gmail.com>
Cc: linux-pci@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Jim Quinlan <jim2101024@gmail.com>
Subject: [PATCH v3 6/8] PCI: brcmstb: Add MSI capability
Date: Tue, 14 Nov 2017 17:12:10 -0500
Message-Id: <1510697532-32828-7-git-send-email-jim2101024@gmail.com>
In-Reply-To: <1510697532-32828-1-git-send-email-jim2101024@gmail.com>
References: <1510697532-32828-1-git-send-email-jim2101024@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This commit adds MSI to the Broadcom STB PCIe host controller. It does
not add MSIX since that functionality is not in the HW.  The MSI
controller is physically located within the PCIe block, however, there
is no reason why the MSI controller could not be moved elsewhere in
the future.

Since the internal Brcmstb MSI controller is intertwined with the PCIe
controller, it is not its own platform device but rather part of the
PCIe platform device.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 drivers/pci/host/pcie-brcmstb.c | 372 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 359 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/host/pcie-brcmstb.c b/drivers/pci/host/pcie-brcmstb.c
index 5f4c6aa..89bad31 100644
--- a/drivers/pci/host/pcie-brcmstb.c
+++ b/drivers/pci/host/pcie-brcmstb.c
@@ -11,6 +11,7 @@
  * GNU General Public License for more details.
  */
 
+#include <linux/bitops.h>
 #include <linux/clk.h>
 #include <linux/compiler.h>
 #include <linux/delay.h>
@@ -18,15 +19,16 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/ioport.h>
+#include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/log2.h>
 #include <linux/module.h>
+#include <linux/msi.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_pci.h>
-#include <linux/of_pci.h>
 #include <linux/of_platform.h>
 #include <linux/pci.h>
 #include <linux/printk.h>
@@ -56,6 +58,9 @@
 #define PCIE_MISC_RC_BAR2_CONFIG_LO			0x4034
 #define PCIE_MISC_RC_BAR2_CONFIG_HI			0x4038
 #define PCIE_MISC_RC_BAR3_CONFIG_LO			0x403c
+#define PCIE_MISC_MSI_BAR_CONFIG_LO			0x4044
+#define PCIE_MISC_MSI_BAR_CONFIG_HI			0x4048
+#define PCIE_MISC_MSI_DATA_CONFIG			0x404c
 #define PCIE_MISC_PCIE_CTRL				0x4064
 #define PCIE_MISC_PCIE_STATUS				0x4068
 #define PCIE_MISC_REVISION				0x406c
@@ -64,6 +69,7 @@
 #define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LIMIT_HI		0x4084
 #define PCIE_MISC_HARD_PCIE_HARD_DEBUG			0x4204
 #define PCIE_INTR2_CPU_BASE				0x4300
+#define PCIE_MSI_INTR2_BASE				0x4500
 
 /*
  * Broadcom Settop Box PCIE Register Field shift and mask info. The
@@ -124,6 +130,8 @@
 
 #define BRCM_NUM_PCIE_OUT_WINS		0x4
 #define BRCM_MAX_SCB			0x4
+#define BRCM_INT_PCI_MSI_NR		32
+#define BRCM_PCIE_HW_REV_33		0x0303
 
 #define BRCM_MSI_TARGET_ADDR_LT_4GB	0x0fffffffcULL
 #define BRCM_MSI_TARGET_ADDR_GT_4GB	0xffffffffcULL
@@ -212,6 +220,30 @@ struct brcm_window {
 	dma_addr_t size;
 };
 
+struct brcm_msi {
+	struct irq_domain *msi_domain;
+	struct irq_domain *inner_domain;
+	struct mutex lock; /* guards the alloc/free operations */
+	u64 target_addr;
+	int irq;
+	/* intr_base is the base pointer for interrupt status/set/clr regs */
+	void __iomem *intr_base;
+	/* intr_legacy_mask indicates how many bits are MSI interrupts */
+	u32 intr_legacy_mask;
+	/*
+	 * intr_legacy_offset indicates bit position of MSI_01. It is
+	 * to map the register bit position to a hwirq that starts at 0.
+	 */
+	u32 intr_legacy_offset;
+	/* used indicates which MSI interrupts have been alloc'd */
+	unsigned long used;
+
+	void __iomem *base;
+	struct device *dev;
+	struct device_node *dn;
+	unsigned int rev;
+};
+
 /* Internal PCIe Host Controller Information.*/
 struct brcm_pcie {
 	struct list_head	list;
@@ -227,7 +259,10 @@ struct brcm_pcie {
 	int			num_out_wins;
 	bool			ssc;
 	int			gen;
+	u64			msi_target_addr;
 	struct brcm_window	out_wins[BRCM_NUM_PCIE_OUT_WINS];
+	struct brcm_msi		*msi;
+	bool			msi_internal;
 	unsigned int		rev;
 	const int		*reg_offsets;
 	const int		*reg_field_info;
@@ -240,6 +275,13 @@ struct pcie_cfg_data {
 	const enum pcie_type type;
 };
 
+struct brcm_info {
+	int rev;
+	u64 msi_target_addr;
+	void __iomem *base;
+	struct brcm_msi *msi;
+};
+
 static const int pcie_reg_field_info[] = {
 	[RGR1_SW_INIT_1_INIT_MASK] = 0x2,
 	[RGR1_SW_INIT_1_INIT_SHIFT] = 0x1,
@@ -546,6 +588,264 @@ static void brcm_pcie_set_outbound_win(struct brcm_pcie *pcie,
 	}
 }
 
+static struct irq_chip brcm_msi_irq_chip = {
+	.name = "Brcm_MSI",
+	.irq_mask = pci_msi_mask_irq,
+	.irq_unmask = pci_msi_unmask_irq,
+};
+
+static struct msi_domain_info brcm_msi_domain_info = {
+	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
+		   MSI_FLAG_PCI_MSIX),
+	.chip	= &brcm_msi_irq_chip,
+};
+
+static void brcm_pcie_msi_isr(struct irq_desc *desc)
+{
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct brcm_msi *msi;
+	unsigned long status, virq;
+	u32 mask, bit, hwirq;
+	struct device *dev;
+
+	chained_irq_enter(chip, desc);
+	msi = irq_desc_get_handler_data(desc);
+	mask = msi->intr_legacy_mask;
+	dev = msi->dev;
+
+	while ((status = bcm_readl(msi->intr_base + STATUS) & mask)) {
+		for_each_set_bit(bit, &status, BRCM_INT_PCI_MSI_NR) {
+			/* clear the interrupt */
+			bcm_writel(1 << bit, msi->intr_base + CLR);
+
+			/* Account for legacy interrupt offset */
+			hwirq = bit - msi->intr_legacy_offset;
+
+			virq = irq_find_mapping(msi->inner_domain, hwirq);
+			if (virq) {
+				if (msi->used & (1 << hwirq))
+					generic_handle_irq(virq);
+				else
+					dev_info(dev, "unhandled MSI %d\n",
+						 hwirq);
+			} else {
+				/* Unknown MSI, just clear it */
+				dev_dbg(dev, "unexpected MSI\n");
+			}
+		}
+	}
+	chained_irq_exit(chip, desc);
+}
+
+static void brcm_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
+{
+	struct brcm_msi *msi = irq_data_get_irq_chip_data(data);
+	u32 temp;
+
+	msg->address_lo = lower_32_bits(msi->target_addr);
+	msg->address_hi = upper_32_bits(msi->target_addr);
+	temp = bcm_readl(msi->base + PCIE_MISC_MSI_DATA_CONFIG);
+	msg->data = ((temp >> 16) & (temp & 0xffff)) | data->hwirq;
+}
+
+static int brcm_msi_set_affinity(struct irq_data *irq_data,
+				 const struct cpumask *mask, bool force)
+{
+	return -EINVAL;
+}
+
+static struct irq_chip brcm_msi_bottom_irq_chip = {
+	.name			= "Brcm_MSI",
+	.irq_compose_msi_msg	= brcm_compose_msi_msg,
+	.irq_set_affinity	= brcm_msi_set_affinity,
+};
+
+static int brcm_msi_alloc(struct brcm_msi *msi)
+{
+	int bit, hwirq;
+
+	mutex_lock(&msi->lock);
+	bit = ~msi->used ? ffz(msi->used) : -1;
+
+	if (bit >= 0 && bit < BRCM_INT_PCI_MSI_NR) {
+		msi->used |= (1 << bit);
+		hwirq = bit - msi->intr_legacy_offset;
+	} else {
+		hwirq = -ENOSPC;
+	}
+
+	mutex_unlock(&msi->lock);
+	return hwirq;
+}
+
+static void brcm_msi_free(struct brcm_msi *msi, unsigned long hwirq)
+{
+	mutex_lock(&msi->lock);
+	msi->used &= ~(1 << (hwirq + msi->intr_legacy_offset));
+	mutex_unlock(&msi->lock);
+}
+
+static int brcm_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
+				 unsigned int nr_irqs, void *args)
+{
+	struct brcm_msi *msi = domain->host_data;
+	int hwirq;
+
+	hwirq = brcm_msi_alloc(msi);
+
+	if (hwirq < 0)
+		return hwirq;
+
+	irq_domain_set_info(domain, virq, (irq_hw_number_t)hwirq,
+			    &brcm_msi_bottom_irq_chip, domain->host_data,
+			    handle_simple_irq, NULL, NULL);
+	return 0;
+}
+
+static void brcm_irq_domain_free(struct irq_domain *domain,
+				 unsigned int virq, unsigned int nr_irqs)
+{
+	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
+	struct brcm_msi *msi = irq_data_get_irq_chip_data(d);
+
+	brcm_msi_free(msi, d->hwirq);
+}
+
+void brcm_msi_set_regs(struct brcm_msi *msi)
+{
+	u32 data_val, msi_lo, msi_hi;
+
+	if (msi->rev >= BRCM_PCIE_HW_REV_33) {
+		/*
+		 * ffe0 -- least sig 5 bits are 0 indicating 32 msgs
+		 * 6540 -- this is our arbitrary unique data value
+		 */
+		data_val = 0xffe06540;
+	} else {
+		/*
+		 * fff8 -- least sig 3 bits are 0 indicating 8 msgs
+		 * 6540 -- this is our arbitrary unique data value
+		 */
+		data_val = 0xfff86540;
+	}
+
+	/*
+	 * Make sure we are not masking MSIs.  Note that MSIs can be masked,
+	 * but that occurs on the PCIe EP device
+	 */
+	bcm_writel(0xffffffff & msi->intr_legacy_mask,
+		   msi->intr_base + MASK_CLR);
+
+	msi_lo = lower_32_bits(msi->target_addr);
+	msi_hi = upper_32_bits(msi->target_addr);
+	/*
+	 * The 0 bit of PCIE_MISC_MSI_BAR_CONFIG_LO is repurposed to MSI
+	 * enable, which we set to 1.
+	 */
+	bcm_writel(msi_lo | 1, msi->base + PCIE_MISC_MSI_BAR_CONFIG_LO);
+	bcm_writel(msi_hi, msi->base + PCIE_MISC_MSI_BAR_CONFIG_HI);
+	bcm_writel(data_val, msi->base + PCIE_MISC_MSI_DATA_CONFIG);
+}
+
+static const struct irq_domain_ops msi_domain_ops = {
+	.alloc	= brcm_irq_domain_alloc,
+	.free	= brcm_irq_domain_free,
+};
+
+static int brcm_allocate_domains(struct brcm_msi *msi)
+{
+	struct fwnode_handle *fwnode = of_node_to_fwnode(msi->dn);
+	struct device *dev = msi->dev;
+
+	msi->inner_domain = irq_domain_add_linear(NULL, BRCM_INT_PCI_MSI_NR,
+						  &msi_domain_ops, msi);
+	if (!msi->inner_domain) {
+		dev_err(dev, "failed to create IRQ domain\n");
+		return -ENOMEM;
+	}
+
+	msi->msi_domain = pci_msi_create_irq_domain(fwnode,
+						    &brcm_msi_domain_info,
+						    msi->inner_domain);
+	if (!msi->msi_domain) {
+		dev_err(dev, "failed to create MSI domain\n");
+		irq_domain_remove(msi->inner_domain);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static void brcm_free_domains(struct brcm_msi *msi)
+{
+	irq_domain_remove(msi->msi_domain);
+	irq_domain_remove(msi->inner_domain);
+}
+
+void brcm_msi_remove(struct brcm_msi *msi)
+{
+	if (!msi)
+		return;
+	irq_set_chained_handler(msi->irq, NULL);
+	irq_set_handler_data(msi->irq, NULL);
+	brcm_free_domains(msi);
+}
+
+int brcm_msi_probe(struct platform_device *pdev, struct brcm_info *info)
+{
+	struct brcm_msi *msi;
+	int irq, ret;
+
+	irq = irq_of_parse_and_map(pdev->dev.of_node, 1);
+	if (irq <= 0) {
+		dev_err(&pdev->dev, "cannot map msi intr\n");
+		return -ENODEV;
+	}
+
+	msi = devm_kzalloc(&pdev->dev, sizeof(struct brcm_msi), GFP_KERNEL);
+	if (!msi)
+		return -ENOMEM;
+
+	msi->dev = &pdev->dev;
+	msi->base = info->base;
+	msi->rev =  info->rev;
+	msi->dn = pdev->dev.of_node;
+	msi->target_addr = info->msi_target_addr;
+	msi->irq = irq;
+
+	ret = brcm_allocate_domains(msi);
+	if (ret)
+		return ret;
+
+	irq_set_chained_handler_and_data(msi->irq, brcm_pcie_msi_isr, msi);
+
+	if (msi->rev >= BRCM_PCIE_HW_REV_33) {
+		msi->intr_base = msi->base + PCIE_MSI_INTR2_BASE;
+		/*
+		 * This version of PCIe hw has only 32 intr bits
+		 * starting at bit position 0.
+		 */
+		msi->intr_legacy_mask = 0xffffffff;
+		msi->intr_legacy_offset = 0x0;
+		msi->used = 0x0;
+
+	} else {
+		msi->intr_base = msi->base + PCIE_INTR2_CPU_BASE;
+		/*
+		 * This version of PCIe hw has only 8 intr bits starting
+		 * at bit position 24.
+		 */
+		msi->intr_legacy_mask = 0xff000000;
+		msi->intr_legacy_offset = 24;
+		msi->used = 0x00ffffff;
+	}
+
+	brcm_msi_set_regs(msi);
+	info->msi = msi;
+
+	return 0;
+}
+
 /* Configuration space read/write support */
 static int cfg_index(int busnr, int devfn, int reg)
 {
@@ -812,6 +1112,7 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	int i, j, ret, limit;
 	u16 nlw, cls, lnksta;
 	bool ssc_good = false;
+	u64 msi_target_addr;
 
 	/* reset the bridge and the endpoint device */
 	/* field: PCIE_BRIDGE_SW_INIT = 1 */
@@ -855,14 +1156,17 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	 * The PCIe host controller by design must set the inbound
 	 * viewport to be a contiguous arrangement of all of the
 	 * system's memory.  In addition, its size mut be a power of
-	 * two.  To further complicate matters, the viewport must
-	 * start on a pcie-address that is aligned on a multiple of its
-	 * size.  If a portion of the viewport does not represent
-	 * system memory -- e.g. 3GB of memory requires a 4GB viewport
-	 * -- we can map the outbound memory in or after 3GB and even
-	 * though the viewport will overlap the outbound memory the
-	 * controller will know to send outbound memory downstream and
-	 * everything else upstream.
+	 * two.  Further, the MSI target address must NOT be placed
+	 * inside this region, as the decoding logic will consider its
+	 * address to be inbound memory traffic.  To further
+	 * complicate matters, the viewport must start on a
+	 * pcie-address that is aligned on a multiple of its size.
+	 * If a portion of the viewport does not represent system
+	 * memory -- e.g. 3GB of memory requires a 4GB viewport --
+	 * we can map the outbound memory in or after 3GB and even
+	 * though the viewport will overlap the outbound memory
+	 * the controller will know to send outbound memory downstream
+	 * and everything else upstream.
 	 */
 	rc_bar2_size = roundup_pow_of_two_64(total_mem_size);
 
@@ -875,7 +1179,7 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	if (dma_ranges) {
 		/*
 		 * The best-case scenario is to place the inbound
-		 * region in the first 4GB of pci-space, as some
+		 * region in the first 4GB of pcie-space, as some
 		 * legacy devices can only address 32bits.
 		 * We would also like to put the MSI under 4GB
 		 * as well, since some devices require a 32bit
@@ -884,6 +1188,14 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 		if (total_mem_size <= 0xc0000000ULL &&
 		    rc_bar2_size <= 0x100000000ULL) {
 			rc_bar2_offset = 0;
+			/* If the viewport is less then 4GB we can fit
+			 * the MSI target address under 4GB. Otherwise
+			 * put it right below 64GB.
+			 */
+			msi_target_addr =
+				(rc_bar2_size == 0x100000000ULL)
+				? BRCM_MSI_TARGET_ADDR_GT_4GB
+				: BRCM_MSI_TARGET_ADDR_LT_4GB;
 		} else {
 			/*
 			 * The system memory is 4GB or larger so we
@@ -893,8 +1205,12 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 			 * start it at the 1x multiple of its size
 			 */
 			rc_bar2_offset = rc_bar2_size;
-		}
 
+			/* Since we are starting the viewport at 4GB or
+			 * higher, put the MSI target address below 4GB
+			 */
+			msi_target_addr = BRCM_MSI_TARGET_ADDR_LT_4GB;
+		}
 	} else {
 		/*
 		 * Set simple configuration based on memory sizes
@@ -902,7 +1218,12 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 		 * and set the MSI target address accordingly.
 		 */
 		rc_bar2_offset = 0;
+
+		msi_target_addr = (rc_bar2_size >= 0x100000000ULL)
+			? BRCM_MSI_TARGET_ADDR_GT_4GB
+			: BRCM_MSI_TARGET_ADDR_LT_4GB;
 	}
+	pcie->msi_target_addr = msi_target_addr;
 
 	tmp = lower_32_bits(rc_bar2_offset);
 	tmp = INSERT_FIELD(tmp, PCIE_MISC_RC_BAR2_CONFIG_LO, SIZE,
@@ -1076,6 +1397,9 @@ static int brcm_pcie_resume(struct device *dev)
 	if (ret)
 		return ret;
 
+	if (pcie->msi && pcie->msi_internal)
+		brcm_msi_set_regs(pcie->msi);
+
 	pcie->suspended = false;
 
 	return 0;
@@ -1083,6 +1407,7 @@ static int brcm_pcie_resume(struct device *dev)
 
 static void _brcm_pcie_remove(struct brcm_pcie *pcie)
 {
+	brcm_msi_remove(pcie->msi);
 	turn_off(pcie);
 	clk_disable_unprepare(pcie->clk);
 	clk_put(pcie->clk);
@@ -1111,7 +1436,7 @@ static int brcm_pcie_remove(struct platform_device *pdev)
 
 static int brcm_pcie_probe(struct platform_device *pdev)
 {
-	struct device_node *dn = pdev->dev.of_node;
+	struct device_node *dn = pdev->dev.of_node, *msi_dn;
 	const struct of_device_id *of_id;
 	const struct pcie_cfg_data *data;
 	int ret;
@@ -1194,6 +1519,28 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		goto fail;
 
+	msi_dn = of_parse_phandle(pcie->dn, "msi-parent", 0);
+	/* Use the internal MSI if no msi-parent property */
+	if (!msi_dn)
+		msi_dn = pcie->dn;
+
+	if (pci_msi_enabled() && msi_dn == pcie->dn) {
+		struct brcm_info info;
+
+		info.rev = pcie->rev;
+		info.msi_target_addr = pcie->msi_target_addr;
+		info.base = pcie->base;
+
+		ret = brcm_msi_probe(pdev, &info);
+		if (ret)
+			dev_err(pcie->dev,
+				"probe of internal MSI failed: %d)", ret);
+		else
+			pcie->msi_internal = true;
+
+		pcie->msi = info.msi;
+	}
+
 	list_splice_init(&pcie->resources, &bridge->windows);
 	bridge->dev.parent = &pdev->dev;
 	bridge->busnr = 0;
@@ -1216,7 +1563,6 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 	pcie->root_bus = bridge->bus;
 
 	return 0;
-
 fail:
 	_brcm_pcie_remove(pcie);
 	return ret;
-- 
1.9.0.138.g2de3478
