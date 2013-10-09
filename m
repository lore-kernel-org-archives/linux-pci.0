Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:29612 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751798Ab3JIIKM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 9 Oct 2013 04:10:12 -0400
From: Jingoo Han <jg1.han@samsung.com>
To: 'Bjorn Helgaas' <bhelgaas@google.com>
Cc: 'Kishon Vijay Abraham I' <kishon@ti.com>,
	linux-pci@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	'Kukjin Kim' <kgene.kim@samsung.com>,
	'Pratyush Anand' <pratyush.anand@st.com>,
	'Mohit KUMAR' <Mohit.KUMAR@st.com>,
	'Siva Reddy Kallam' <siva.kallam@samsung.com>,
	'SRIKANTH TUMKUR SHIVANAND' <ts.srikanth@samsung.com>,
	'Arnd Bergmann' <arnd@arndb.de>,
	'Sean Cross' <xobs@kosagi.com>,
	'Thierry Reding' <thierry.reding@gmail.com>,
	'Thomas Petazzoni' <thomas.petazzoni@free-electrons.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	'Jingoo Han' <jg1.han@samsung.com>
Subject: [PATCH] PCI: designware: Add irq_create_mapping()
Date: Wed, 09 Oct 2013 17:09:21 +0900
Message-id: <000401cec4c6$dc415180$94c3f480$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Without irq_create_mapping(), the correct irq number cannot be
provided. In this case, it makes problem such as NULL deference.
Thus, irq_create_mapping() should be added for MSI.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
---
Tested on Exynos5440.

 drivers/pci/host/pcie-designware.c |   10 ++++------
 drivers/pci/host/pcie-designware.h |    1 +
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 8963017..e536bb6 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -237,6 +237,8 @@ static int assign_irq(int no_irqs, struct msi_desc *desc, int *pos)
 		}
 	}
 
+	pp->msi_irq_start = irq_create_mapping(pp->irq_domain, 0);
+
 	irq = (pp->msi_irq_start + pos0);
 
 	if ((irq + no_irqs) > (pp->msi_irq_start + MAX_MSI_IRQS-1))
@@ -372,8 +374,6 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
 	struct of_pci_range_parser parser;
 	u32 val;
 
-	struct irq_domain *irq_domain;
-
 	if (of_pci_range_parser_init(&parser, np)) {
 		dev_err(pp->dev, "missing ranges property\n");
 		return -EINVAL;
@@ -441,15 +441,13 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
 	}
 
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
-		irq_domain = irq_domain_add_linear(pp->dev->of_node,
+		pp->irq_domain = irq_domain_add_linear(pp->dev->of_node,
 					MAX_MSI_IRQS, &msi_domain_ops,
 					&dw_pcie_msi_chip);
-		if (!irq_domain) {
+		if (!pp->irq_domain) {
 			dev_err(pp->dev, "irq domain init failed\n");
 			return -ENXIO;
 		}
-
-		pp->msi_irq_start = irq_find_mapping(irq_domain, 0);
 	}
 
 	if (pp->ops->host_init)
diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
index faccbbf..240fc11 100644
--- a/drivers/pci/host/pcie-designware.h
+++ b/drivers/pci/host/pcie-designware.h
@@ -50,6 +50,7 @@ struct pcie_port {
 	int			msi_irq_start;
 	unsigned long		msi_data;
 	DECLARE_BITMAP(msi_irq_in_use, MAX_MSI_IRQS);
+	struct irq_domain	*irq_domain;
 };
 
 struct pcie_host_ops {
-- 
1.7.10.4


