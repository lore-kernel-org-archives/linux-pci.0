Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Khuong  Dinh <kdinh@apm.com>
To: lorenzo.pieralisi@arm.com, marc.zyngier@arm.com, msalter@redhat.com,
 bhelgaas@google.com, linux-pci@vger.kernel.org, jcm@redhat.com
Subject: [PATCH v2 pci] PCI/MSI: pci-xgene-msi: Enable MSI support in ACPI
 boot for X-Gene v1
Date: Thu, 27 Apr 2017 18:54:07 -0600
Message-Id: <1493340847-25720-1-git-send-email-kdinh@apm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: patches@apm.com, Duc Dang <dhdang@apm.com>, rjw@rjwysocki.net,
 linux-kernel@vger.kernel.org, Khuong Dinh <kdinh@apm.com>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

From: Khuong Dinh <kdinh@apm.com>

This patch makes pci-xgene-msi driver ACPI-aware and provides
MSI capability for X-Gene v1 PCIe controllers in ACPI boot mode.

Signed-off-by: Khuong Dinh <kdinh@apm.com>
Signed-off-by: Duc Dang <dhdang@apm.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
---
v2:
 - Verify with BIOS version 3.06.25 and 3.07.09
v1:
 - Initial version
---
 drivers/pci/host/pci-xgene-msi.c |   35 ++++++++++++++++++++++++++++++++---
 1 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pci-xgene-msi.c b/drivers/pci/host/pci-xgene-msi.c
index f1b633b..00aaa3d 100644
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
@@ -249,6 +250,13 @@ static void xgene_irq_domain_free(struct irq_domain *domain,
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
 
@@ -449,6 +460,13 @@ static int xgene_msi_hwirq_free(unsigned int cpu)
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
@@ -469,7 +487,17 @@ static int xgene_msi_probe(struct platform_device *pdev)
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
@@ -540,6 +568,7 @@ static int xgene_msi_probe(struct platform_device *pdev)
 	.driver = {
 		.name = "xgene-msi",
 		.of_match_table = xgene_msi_match_table,
+		.acpi_match_table = ACPI_PTR(xgene_msi_acpi_ids),
 	},
 	.probe = xgene_msi_probe,
 	.remove = xgene_msi_remove,
-- 
1.7.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
