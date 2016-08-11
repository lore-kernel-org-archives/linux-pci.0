Return-Path: <tn@semihalf.com>
Return-Path: <tn@semihalf.com>
From: Tomasz Nowicki <tn@semihalf.com>
To: marc.zyngier@arm.com,
	tglx@linutronix.de,
	jason@lakedaemon.net,
	rjw@rjwysocki.net,
	helgaas@kernel.org,
	rafael@kernel.org,
	Lorenzo.Pieralisi@arm.com
Cc: will.deacon@arm.com,
	catalin.marinas@arm.com,
	hanjun.guo@linaro.org,
	shijie.huang@arm.com,
	robert.richter@caviumnetworks.com,
	mw@semihalf.com,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linaro-acpi@lists.linaro.org,
	andrea.gallo@linaro.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	al.stone@linaro.org,
	graeme.gregory@linaro.org,
	ddaney.cavm@gmail.com,
	okaya@codeaurora.org,
	Tomasz Nowicki <tn@semihalf.com>
Subject: [PATCH V8 3/8] PCI/MSI: Setup MSI domain on a per-device basis using IORT ACPI table
Date: Thu, 11 Aug 2016 12:06:33 +0200
Message-Id: <1470909998-16710-4-git-send-email-tn@semihalf.com>
In-Reply-To: <1470909998-16710-1-git-send-email-tn@semihalf.com>
References: <1470909998-16710-1-git-send-email-tn@semihalf.com>
List-ID: <linux-pci.vger.kernel.org>

It is possible to provide information about which MSI controller to
use on a per-device basis for DT. This patch supply this with ACPI support.

Currently, IORT is the only one ACPI table which can provide such mapping.
In order to plug IORT into MSI infrastructure we are adding ACPI
equivalents for finding PCI device domain and its RID translation
(pci_msi_domain_get_msi_rid and pci_msi_domain_get_msi_rid calls).

Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/msi.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index a02981e..7bb981a 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -19,6 +19,7 @@
 #include <linux/smp.h>
 #include <linux/errno.h>
 #include <linux/io.h>
+#include <linux/iort.h>
 #include <linux/slab.h>
 #include <linux/irqdomain.h>
 #include <linux/of_irq.h>
@@ -1498,8 +1499,8 @@ u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev)
 	pci_for_each_dma_alias(pdev, get_msi_id_cb, &rid);
 
 	of_node = irq_domain_get_of_node(domain);
-	if (of_node)
-		rid = of_msi_map_rid(&pdev->dev, of_node, rid);
+	rid = of_node ? of_msi_map_rid(&pdev->dev, of_node, rid) :
+			iort_msi_map_rid(&pdev->dev, rid);
 
 	return rid;
 }
@@ -1515,9 +1516,13 @@ u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev)
  */
 struct irq_domain *pci_msi_get_device_domain(struct pci_dev *pdev)
 {
+	struct irq_domain *dom;
 	u32 rid = 0;
 
 	pci_for_each_dma_alias(pdev, get_msi_id_cb, &rid);
-	return of_msi_map_get_device_domain(&pdev->dev, rid);
+	dom = of_msi_map_get_device_domain(&pdev->dev, rid);
+	if (!dom)
+		dom = iort_get_device_domain(&pdev->dev, rid);
+	return dom;
 }
 #endif /* CONFIG_PCI_MSI_IRQ_DOMAIN */
-- 
1.9.1
