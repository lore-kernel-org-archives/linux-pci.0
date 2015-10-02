Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f181.google.com ([209.85.223.181]:32938 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751407AbbJBAuk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 1 Oct 2015 20:50:40 -0400
From: David Daney <ddaney.cavm@gmail.com>
To: linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	Marc Zyngier <marc.zyngier@arm.com>,
	Grant Likely <grant.likely@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Frank Rowand <frowand.list@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc: David Daney <david.daney@cavium.com>
Subject: [PATCH v4 3/4] PCI/MSI:  Add helper function pci_msi_domain_get_msi_rid().
Date: Thu,  1 Oct 2015 17:50:24 -0700
Message-Id: <1443747025-9918-4-git-send-email-ddaney.cavm@gmail.com>
In-Reply-To: <1443747025-9918-1-git-send-email-ddaney.cavm@gmail.com>
References: <1443747025-9918-1-git-send-email-ddaney.cavm@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: David Daney <david.daney@cavium.com>

Add pci_msi_domain_get_msi_rid() to return the MSI requester id (RID).
Initially needed by gic-v3 based systems. It will be used by follow on
patch to drivers/irqchip/irq-gic-v3-its-pci-msi.c

Initially supports mapping the RID via OF device tree.  In the future,
this could be extended to use ACPI _IORT tables as well.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 drivers/pci/msi.c   | 30 ++++++++++++++++++++++++++++++
 include/linux/msi.h |  1 +
 2 files changed, 31 insertions(+)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index d449714..81a2798 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -20,6 +20,7 @@
 #include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/irqdomain.h>
+#include <linux/of_irq.h>
 
 #include "pci.h"
 
@@ -1327,4 +1328,33 @@ struct irq_domain *pci_msi_create_default_irq_domain(struct device_node *node,
 
 	return domain;
 }
+
+static int get_msi_id_cb(struct pci_dev *pdev, u16 alias, void *data)
+{
+	u32 *pa = data;
+
+	*pa = alias;
+	return 0;
+}
+/**
+ * pci_msi_domain_get_msi_rid - Get the MSI requester id (RID)
+ * @domain:	The interrupt domain
+ * @pdev:	The PCI device.
+ *
+ * The RID for a device is formed from the alias, with a firmware
+ * supplied mapping applied
+ *
+ * Returns: The RID.
+ */
+u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev)
+{
+	u32 rid = 0;
+
+	pci_for_each_dma_alias(pdev, get_msi_id_cb, &rid);
+
+	if (domain->of_node)
+		rid = of_msi_map_rid(&pdev->dev, domain->of_node, rid);
+
+	return rid;
+}
 #endif /* CONFIG_PCI_MSI_IRQ_DOMAIN */
diff --git a/include/linux/msi.h b/include/linux/msi.h
index ad939d0..56e3b76 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -293,6 +293,7 @@ irq_hw_number_t pci_msi_domain_calc_hwirq(struct pci_dev *dev,
 					  struct msi_desc *desc);
 int pci_msi_domain_check_cap(struct irq_domain *domain,
 			     struct msi_domain_info *info, struct device *dev);
+u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev);
 #endif /* CONFIG_PCI_MSI_IRQ_DOMAIN */
 
 #endif /* LINUX_MSI_H */
-- 
1.9.1

