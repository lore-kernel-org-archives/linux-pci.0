Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:16808 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752880AbbGIIAU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 9 Jul 2015 04:00:20 -0400
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Grant Likely <grant.likely@linaro.org>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Stuart Yoder <stuart.yoder@freescale.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Borislav Petkov <bp@alien8.de>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Michal Simek <michal.simek@xilinx.com>,
	=?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Srikanth Thokala <sthokal@xilinx.com>,
	Rob Herring <robh@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [RFC Patch V1 08/12] PCI: Use helper functions to access fields in struct msi_desc
Date: Thu,  9 Jul 2015 16:00:43 +0800
Message-Id: <1436428847-8886-9-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1436428847-8886-1-git-send-email-jiang.liu@linux.intel.com>
References: <1436428847-8886-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use helper functions to access fields in struct msi_desc, so we could
easily refine msi_desc later.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 drivers/pci/host/pci-keystone-dw.c |    6 +++---
 drivers/pci/host/pcie-designware.c |    4 ++--
 drivers/pci/host/pcie-xilinx.c     |   12 +++++-------
 drivers/pci/msi.c                  |   13 ++++++++-----
 4 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/host/pci-keystone-dw.c b/drivers/pci/host/pci-keystone-dw.c
index f34892e0edb4..e792086c1639 100644
--- a/drivers/pci/host/pci-keystone-dw.c
+++ b/drivers/pci/host/pci-keystone-dw.c
@@ -109,7 +109,7 @@ static void ks_dw_pcie_msi_irq_ack(struct irq_data *d)
 	struct pcie_port *pp;
 
 	msi = irq_get_msi_desc(irq);
-	pp = sys_to_pcie(msi->dev->bus->sysdata);
+	pp = sys_to_pcie(msi_desc_to_pci_sysdata(msi));
 	ks_pcie = to_keystone_pcie(pp);
 	offset = irq - irq_linear_revmap(pp->irq_domain, 0);
 	update_reg_offset_bit_pos(offset, &reg_offset, &bit_pos);
@@ -148,7 +148,7 @@ static void ks_dw_pcie_msi_irq_mask(struct irq_data *d)
 	u32 offset;
 
 	msi = irq_get_msi_desc(irq);
-	pp = sys_to_pcie(msi->dev->bus->sysdata);
+	pp = sys_to_pcie(msi_desc_to_pci_sysdata(msi));
 	ks_pcie = to_keystone_pcie(pp);
 	offset = irq - irq_linear_revmap(pp->irq_domain, 0);
 
@@ -170,7 +170,7 @@ static void ks_dw_pcie_msi_irq_unmask(struct irq_data *d)
 	u32 offset;
 
 	msi = irq_get_msi_desc(irq);
-	pp = sys_to_pcie(msi->dev->bus->sysdata);
+	pp = sys_to_pcie(msi_desc_to_pci_sysdata(msi));
 	ks_pcie = to_keystone_pcie(pp);
 	offset = irq - irq_linear_revmap(pp->irq_domain, 0);
 
diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 69486be7181e..65596f96763c 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -255,7 +255,7 @@ static void dw_pcie_msi_set_irq(struct pcie_port *pp, int irq)
 static int assign_irq(int no_irqs, struct msi_desc *desc, int *pos)
 {
 	int irq, pos0, i;
-	struct pcie_port *pp = sys_to_pcie(desc->dev->bus->sysdata);
+	struct pcie_port *pp = sys_to_pcie(msi_desc_to_pci_sysdata(desc));
 
 	pos0 = bitmap_find_free_region(pp->msi_irq_in_use, MAX_MSI_IRQS,
 				       order_base_2(no_irqs));
@@ -327,7 +327,7 @@ static void dw_msi_teardown_irq(struct msi_controller *chip, unsigned int irq)
 {
 	struct irq_data *data = irq_get_irq_data(irq);
 	struct msi_desc *msi = irq_data_get_msi(data);
-	struct pcie_port *pp = sys_to_pcie(msi->dev->bus->sysdata);
+	struct pcie_port *pp = sys_to_pcie(msi_desc_to_pci_sysdata(msi));
 
 	clear_irq_range(pp, irq, 1, data->hwirq);
 }
diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
index f1a06a091ccb..64454f416639 100644
--- a/drivers/pci/host/pcie-xilinx.c
+++ b/drivers/pci/host/pcie-xilinx.c
@@ -227,18 +227,16 @@ static struct pci_ops xilinx_pcie_ops = {
  */
 static void xilinx_pcie_destroy_msi(unsigned int irq)
 {
-	struct irq_desc *desc;
 	struct msi_desc *msi;
 	struct xilinx_pcie_port *port;
 
-	desc = irq_to_desc(irq);
-	msi = irq_desc_get_msi_desc(desc);
-	port = sys_to_pcie(msi->dev->bus->sysdata);
-
-	if (!test_bit(irq, msi_irq_in_use))
+	if (!test_bit(irq, msi_irq_in_use)) {
+		msi = irq_get_msi_desc(irq);
+		port = sys_to_pcie(msi_desc_to_pci_sys_data(msi));
 		dev_err(port->dev, "Trying to free unused MSI#%d\n", irq);
-	else
+	} else {
 		clear_bit(irq, msi_irq_in_use);
+	}
 }
 
 /**
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index d09afa78d7a1..6497608545e2 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -208,7 +208,8 @@ u32 __pci_msi_desc_mask_irq(struct msi_desc *desc, u32 mask, u32 flag)
 
 	mask_bits &= ~mask;
 	mask_bits |= flag;
-	pci_write_config_dword(desc->dev, desc->mask_pos, mask_bits);
+	pci_write_config_dword(msi_desc_to_pci_dev(desc), desc->mask_pos,
+			       mask_bits);
 
 	return mask_bits;
 }
@@ -288,7 +289,9 @@ void default_restore_msi_irqs(struct pci_dev *dev)
 
 void __pci_read_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
 {
-	BUG_ON(entry->dev->current_state != PCI_D0);
+	struct pci_dev *dev = msi_desc_to_pci_dev(entry);
+
+	BUG_ON(dev->current_state != PCI_D0);
 
 	if (entry->msi_attrib.is_msix) {
 		void __iomem *base = entry->mask_base +
@@ -298,7 +301,6 @@ void __pci_read_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
 		msg->address_hi = readl(base + PCI_MSIX_ENTRY_UPPER_ADDR);
 		msg->data = readl(base + PCI_MSIX_ENTRY_DATA);
 	} else {
-		struct pci_dev *dev = entry->dev;
 		int pos = dev->msi_cap;
 		u16 data;
 
@@ -318,7 +320,9 @@ void __pci_read_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
 
 void __pci_write_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
 {
-	if (entry->dev->current_state != PCI_D0) {
+	struct pci_dev *dev = msi_desc_to_pci_dev(entry);
+
+	if (dev->current_state != PCI_D0) {
 		/* Don't touch the hardware now */
 	} else if (entry->msi_attrib.is_msix) {
 		void __iomem *base;
@@ -329,7 +333,6 @@ void __pci_write_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
 		writel(msg->address_hi, base + PCI_MSIX_ENTRY_UPPER_ADDR);
 		writel(msg->data, base + PCI_MSIX_ENTRY_DATA);
 	} else {
-		struct pci_dev *dev = entry->dev;
 		int pos = dev->msi_cap;
 		u16 msgctl;
 
-- 
1.7.10.4

