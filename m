Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:36488 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751423AbbETKAu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 20 May 2015 06:00:50 -0400
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Murali Karicheri <m-karicheri2@ti.com>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [RFC v1 11/25] keystone, irq: Use irq_data_get_xxx() to avoid redundant lookup of irq_data
Date: Wed, 20 May 2015 17:59:59 +0800
Message-Id: <1432116013-25902-12-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1432116013-25902-1-git-send-email-jiang.liu@linux.intel.com>
References: <1432116013-25902-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use irq_data_get_xxx() to avoid redundant lookup of irq_data while we
already have a pointer to corresponding irq_data.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 drivers/pci/host/pci-keystone-dw.c |   15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/host/pci-keystone-dw.c b/drivers/pci/host/pci-keystone-dw.c
index f34892e0edb4..e42d077039d3 100644
--- a/drivers/pci/host/pci-keystone-dw.c
+++ b/drivers/pci/host/pci-keystone-dw.c
@@ -104,14 +104,13 @@ static void ks_dw_pcie_msi_irq_ack(struct irq_data *d)
 {
 	u32 offset, reg_offset, bit_pos;
 	struct keystone_pcie *ks_pcie;
-	unsigned int irq = d->irq;
 	struct msi_desc *msi;
 	struct pcie_port *pp;
 
-	msi = irq_get_msi_desc(irq);
+	msi = irq_data_get_msi_desc(d);
 	pp = sys_to_pcie(msi->dev->bus->sysdata);
 	ks_pcie = to_keystone_pcie(pp);
-	offset = irq - irq_linear_revmap(pp->irq_domain, 0);
+	offset = d->irq - irq_linear_revmap(pp->irq_domain, 0);
 	update_reg_offset_bit_pos(offset, &reg_offset, &bit_pos);
 
 	writel(BIT(bit_pos),
@@ -142,15 +141,14 @@ void ks_dw_pcie_msi_clear_irq(struct pcie_port *pp, int irq)
 static void ks_dw_pcie_msi_irq_mask(struct irq_data *d)
 {
 	struct keystone_pcie *ks_pcie;
-	unsigned int irq = d->irq;
 	struct msi_desc *msi;
 	struct pcie_port *pp;
 	u32 offset;
 
-	msi = irq_get_msi_desc(irq);
+	msi = irq_data_get_msi_desc(d);
 	pp = sys_to_pcie(msi->dev->bus->sysdata);
 	ks_pcie = to_keystone_pcie(pp);
-	offset = irq - irq_linear_revmap(pp->irq_domain, 0);
+	offset = d->irq - irq_linear_revmap(pp->irq_domain, 0);
 
 	/* Mask the end point if PVM implemented */
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
@@ -164,15 +162,14 @@ static void ks_dw_pcie_msi_irq_mask(struct irq_data *d)
 static void ks_dw_pcie_msi_irq_unmask(struct irq_data *d)
 {
 	struct keystone_pcie *ks_pcie;
-	unsigned int irq = d->irq;
 	struct msi_desc *msi;
 	struct pcie_port *pp;
 	u32 offset;
 
-	msi = irq_get_msi_desc(irq);
+	msi = irq_data_get_msi_desc(d);
 	pp = sys_to_pcie(msi->dev->bus->sysdata);
 	ks_pcie = to_keystone_pcie(pp);
-	offset = irq - irq_linear_revmap(pp->irq_domain, 0);
+	offset = d->irq - irq_linear_revmap(pp->irq_domain, 0);
 
 	/* Mask the end point if PVM implemented */
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
-- 
1.7.10.4

