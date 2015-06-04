Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:35287 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752128AbbFDEQy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 4 Jun 2015 00:16:54 -0400
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Murali Karicheri <m-karicheri2@ti.com>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [RFT v2 33/48] PCI/keystone: Prepare for killing the first parameter 'irq' of irq_flow_handler_t
Date: Thu,  4 Jun 2015 12:13:43 +0800
Message-Id: <1433391238-19471-34-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
References: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Change irq flow handler to prepare for killing the first parameter 'irq'
of irq_flow_handler_t.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 drivers/pci/host/pci-keystone.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pci-keystone.c b/drivers/pci/host/pci-keystone.c
index 75333b0c4f0a..98862768f1da 100644
--- a/drivers/pci/host/pci-keystone.c
+++ b/drivers/pci/host/pci-keystone.c
@@ -112,8 +112,9 @@ static int ks_pcie_establish_link(struct keystone_pcie *ks_pcie)
 	return 0;
 }
 
-static void ks_pcie_msi_irq_handler(unsigned int irq, struct irq_desc *desc)
+static void ks_pcie_msi_irq_handler(unsigned int __irq, struct irq_desc *desc)
 {
+	unsigned int irq = irq_desc_get_irq(desc);
 	struct keystone_pcie *ks_pcie = irq_desc_get_handler_data(desc);
 	u32 offset = irq - ks_pcie->msi_host_irqs[0];
 	struct pcie_port *pp = &ks_pcie->pp;
@@ -139,8 +140,9 @@ static void ks_pcie_msi_irq_handler(unsigned int irq, struct irq_desc *desc)
  * Traverse through pending legacy interrupts and invoke handler for each. Also
  * takes care of interrupt controller level mask/ack operation.
  */
-static void ks_pcie_legacy_irq_handler(unsigned int irq, struct irq_desc *desc)
+static void ks_pcie_legacy_irq_handler(unsigned int __irq, struct irq_desc *desc)
 {
+	unsigned int irq = irq_desc_get_irq(desc);
 	struct keystone_pcie *ks_pcie = irq_desc_get_handler_data(desc);
 	struct pcie_port *pp = &ks_pcie->pp;
 	u32 irq_offset = irq - ks_pcie->legacy_host_irqs[0];
-- 
1.7.10.4

