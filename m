Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:8683 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753973AbbFDEWy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 4 Jun 2015 00:22:54 -0400
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Vinod Koul <vinod.koul@intel.com>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Steve Longerbeam <slongerbeam@gmail.com>,
	Gilad Avidov <gavidov@codeaurora.org>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [RFT v2 48/48] genirq, drivers: Kill the first parameter 'irq' of irq_flow_handler_t
Date: Thu,  4 Jun 2015 12:13:58 +0800
Message-Id: <1433391238-19471-49-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
References: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Now most IRQ flow handlers make no use of the first parameter 'irq'.
And for those who do make use of 'irq', we could easily get the irq
number through irq_desc->irq_data->irq. So kill the first parameter
'irq' of irq_flow_handler_t.

To ease review, I have split the changes into several parts, though
they should be merge as one to support bisecting.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 drivers/dma/ipu/ipu_irq.c       |    4 ++--
 drivers/gpu/ipu-v3/ipu-common.c |    4 ++--
 drivers/pci/host/pci-keystone.c |    5 ++---
 drivers/spmi/spmi-pmic-arb.c    |    2 +-
 4 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/ipu/ipu_irq.c b/drivers/dma/ipu/ipu_irq.c
index 84083c93fe70..4791a7630f97 100644
--- a/drivers/dma/ipu/ipu_irq.c
+++ b/drivers/dma/ipu/ipu_irq.c
@@ -266,7 +266,7 @@ int ipu_irq_unmap(unsigned int source)
 }
 
 /* Chained IRQ handler for IPU error interrupt */
-static void ipu_irq_err(unsigned int __irq, struct irq_desc *desc)
+static void ipu_irq_err(struct irq_desc *desc)
 {
 	struct ipu *ipu = irq_desc_get_handler_data(desc);
 	u32 status;
@@ -308,7 +308,7 @@ static void ipu_irq_err(unsigned int __irq, struct irq_desc *desc)
 }
 
 /* Chained IRQ handler for IPU function interrupt */
-static void ipu_irq_fn(unsigned int __irq, struct irq_desc *desc)
+static void ipu_irq_fn(struct irq_desc *desc)
 {
 	struct ipu *ipu = irq_desc_get_handler_data(desc);
 	u32 status;
diff --git a/drivers/gpu/ipu-v3/ipu-common.c b/drivers/gpu/ipu-v3/ipu-common.c
index 7022825b7a2c..1125b03c36af 100644
--- a/drivers/gpu/ipu-v3/ipu-common.c
+++ b/drivers/gpu/ipu-v3/ipu-common.c
@@ -912,7 +912,7 @@ static void ipu_irq_handle(struct ipu_soc *ipu, const int *regs, int num_regs)
 	}
 }
 
-static void ipu_irq_handler(unsigned int irq, struct irq_desc *desc)
+static void ipu_irq_handler(struct irq_desc *desc)
 {
 	struct ipu_soc *ipu = irq_desc_get_handler_data(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
@@ -925,7 +925,7 @@ static void ipu_irq_handler(unsigned int irq, struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
-static void ipu_err_irq_handler(unsigned int irq, struct irq_desc *desc)
+static void ipu_err_irq_handler(struct irq_desc *desc)
 {
 	struct ipu_soc *ipu = irq_desc_get_handler_data(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
diff --git a/drivers/pci/host/pci-keystone.c b/drivers/pci/host/pci-keystone.c
index 98862768f1da..72eca81f2f67 100644
--- a/drivers/pci/host/pci-keystone.c
+++ b/drivers/pci/host/pci-keystone.c
@@ -112,7 +112,7 @@ static int ks_pcie_establish_link(struct keystone_pcie *ks_pcie)
 	return 0;
 }
 
-static void ks_pcie_msi_irq_handler(unsigned int __irq, struct irq_desc *desc)
+static void ks_pcie_msi_irq_handler(struct irq_desc *desc)
 {
 	unsigned int irq = irq_desc_get_irq(desc);
 	struct keystone_pcie *ks_pcie = irq_desc_get_handler_data(desc);
@@ -134,13 +134,12 @@ static void ks_pcie_msi_irq_handler(unsigned int __irq, struct irq_desc *desc)
 
 /**
  * ks_pcie_legacy_irq_handler() - Handle legacy interrupt
- * @irq: IRQ line for legacy interrupts
  * @desc: Pointer to irq descriptor
  *
  * Traverse through pending legacy interrupts and invoke handler for each. Also
  * takes care of interrupt controller level mask/ack operation.
  */
-static void ks_pcie_legacy_irq_handler(unsigned int __irq, struct irq_desc *desc)
+static void ks_pcie_legacy_irq_handler(struct irq_desc *desc)
 {
 	unsigned int irq = irq_desc_get_irq(desc);
 	struct keystone_pcie *ks_pcie = irq_desc_get_handler_data(desc);
diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
index b32cb0a813cb..d7e7846917ae 100644
--- a/drivers/spmi/spmi-pmic-arb.c
+++ b/drivers/spmi/spmi-pmic-arb.c
@@ -451,7 +451,7 @@ static void periph_interrupt(struct spmi_pmic_arb_dev *pa, u8 apid)
 	}
 }
 
-static void pmic_arb_chained_irq(unsigned int irq, struct irq_desc *desc)
+static void pmic_arb_chained_irq(struct irq_desc *desc)
 {
 	struct spmi_pmic_arb_dev *pa = irq_desc_get_handler_data(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
-- 
1.7.10.4

