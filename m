Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:22105 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753264AbbFDEQp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 4 Jun 2015 00:16:45 -0400
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
	Vinod Koul <vinod.koul@intel.com>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, dmaengine@vger.kernel.org
Subject: [RFT v2 29/48] ipu: Prepare for killing the first parameter 'irq' of irq_flow_handler_t
Date: Thu,  4 Jun 2015 12:13:39 +0800
Message-Id: <1433391238-19471-30-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
References: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Change irq flow handler to prepare for killing the first parameter 'irq'
of irq_flow_handler_t.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 drivers/dma/ipu/ipu_irq.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/ipu/ipu_irq.c b/drivers/dma/ipu/ipu_irq.c
index 0e12af37fe2f..84083c93fe70 100644
--- a/drivers/dma/ipu/ipu_irq.c
+++ b/drivers/dma/ipu/ipu_irq.c
@@ -266,7 +266,7 @@ int ipu_irq_unmap(unsigned int source)
 }
 
 /* Chained IRQ handler for IPU error interrupt */
-static void ipu_irq_err(unsigned int irq, struct irq_desc *desc)
+static void ipu_irq_err(unsigned int __irq, struct irq_desc *desc)
 {
 	struct ipu *ipu = irq_desc_get_handler_data(desc);
 	u32 status;
@@ -286,6 +286,7 @@ static void ipu_irq_err(unsigned int irq, struct irq_desc *desc)
 		raw_spin_unlock(&bank_lock);
 		while ((line = ffs(status))) {
 			struct ipu_irq_map *map;
+			unsigned int irq;
 
 			line--;
 			status &= ~(1UL << line);
@@ -307,7 +308,7 @@ static void ipu_irq_err(unsigned int irq, struct irq_desc *desc)
 }
 
 /* Chained IRQ handler for IPU function interrupt */
-static void ipu_irq_fn(unsigned int irq, struct irq_desc *desc)
+static void ipu_irq_fn(unsigned int __irq, struct irq_desc *desc)
 {
 	struct ipu *ipu = irq_desc_get_handler_data(desc);
 	u32 status;
@@ -323,6 +324,7 @@ static void ipu_irq_fn(unsigned int irq, struct irq_desc *desc)
 		raw_spin_unlock(&bank_lock);
 		while ((line = ffs(status))) {
 			struct ipu_irq_map *map;
+			unsigned int irq;
 
 			line--;
 			status &= ~(1UL << line);
-- 
1.7.10.4

