Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Duc Dang <dhdang@apm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Tanmay Inamdar <tinamdar@apm.com>,
	Loc Ho <lho@apm.com>, Feng Kan <fkan@apm.com>, patches@apm.com,
	Duc Dang <dhdang@apm.com>
Subject: [PATCH] PCI/MSI: pci-xgene-msi: Enable MSI support in ACPI boot for X-Gene v1
Date: Tue,  9 Feb 2016 17:56:24 -0800
Message-Id: <1455069384-22323-1-git-send-email-dhdang@apm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch makes pci-xgene-msi driver ACPI-aware and provides
MSI capability for X-Gene v1 PCIe controllers in ACPI boot mode.

Signed-off-by: Duc Dang <dhdang@apm.com>
---
 drivers/pci/host/pci-xgene-msi.c | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pci-xgene-msi.c b/drivers/pci/host/pci-xgene-msi.c
index a6456b5..466aa93 100644
--- a/drivers/pci/host/pci-xgene-msi.c
+++ b/drivers/pci/host/pci-xgene-msi.c
@@ -24,6 +24,7 @@
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/of_pci.h>
+#include <linux/acpi.h>
 
 #define MSI_IR0			0x000000
 #define MSI_INT0		0x800000
@@ -39,7 +40,7 @@ struct xgene_msi_group {
 };
 
 struct xgene_msi {
-	struct device_node	*node;
+	struct fwnode_handle	*fwnode;
 	struct irq_domain	*inner_domain;
 	struct irq_domain	*msi_domain;
 	u64			msi_addr;
@@ -249,6 +250,13 @@ static const struct irq_domain_ops msi_domain_ops = {
 	.free   = xgene_irq_domain_free,
 };
 
+#ifdef CONFIG_ACPI
+static struct fwnode_handle *xgene_msi_get_fwnode(struct device *dev)
+{
+	return xgene_msi_ctrl.fwnode;
+}
+#endif
+
 static int xgene_allocate_domains(struct xgene_msi *msi)
 {
 	msi->inner_domain = irq_domain_add_linear(NULL, NR_MSI_VEC,
@@ -256,7 +264,7 @@ static int xgene_allocate_domains(struct xgene_msi *msi)
 	if (!msi->inner_domain)
 		return -ENOMEM;
 
-	msi->msi_domain = pci_msi_create_irq_domain(of_node_to_fwnode(msi->node),
+	msi->msi_domain = pci_msi_create_irq_domain(msi->fwnode,
 						    &xgene_msi_domain_info,
 						    msi->inner_domain);
 
@@ -265,6 +273,9 @@ static int xgene_allocate_domains(struct xgene_msi *msi)
 		return -ENOMEM;
 	}
 
+#ifdef CONFIG_ACPI
+	pci_msi_register_fwnode_provider(&xgene_msi_get_fwnode);
+#endif
 	return 0;
 }
 
@@ -473,6 +484,13 @@ static const struct of_device_id xgene_msi_match_table[] = {
 	{},
 };
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id xgene_msi_acpi_ids[] = {
+	{"APMC0D0E", 0},
+	{ },
+};
+#endif
+
 static int xgene_msi_probe(struct platform_device *pdev)
 {
 	struct resource *res;
@@ -494,7 +512,17 @@ static int xgene_msi_probe(struct platform_device *pdev)
 		goto error;
 	}
 	xgene_msi->msi_addr = res->start;
-	xgene_msi->node = pdev->dev.of_node;
+
+	xgene_msi->fwnode = of_node_to_fwnode(pdev->dev.of_node);
+	if (!xgene_msi->fwnode) {
+		xgene_msi->fwnode = irq_domain_alloc_fwnode(NULL);
+		if (!xgene_msi->fwnode) {
+			dev_err(&pdev->dev, "Failed to create fwnode\n");
+			rc = ENOMEM;
+			goto error;
+		}
+	}
+
 	xgene_msi->num_cpus = num_possible_cpus();
 
 	rc = xgene_msi_init_allocator(xgene_msi);
@@ -571,6 +599,7 @@ static struct platform_driver xgene_msi_driver = {
 	.driver = {
 		.name = "xgene-msi",
 		.of_match_table = xgene_msi_match_table,
+		.acpi_match_table = ACPI_PTR(xgene_msi_acpi_ids),
 	},
 	.probe = xgene_msi_probe,
 	.remove = xgene_msi_remove,
-- 
1.9.1
