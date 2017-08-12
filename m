Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Khuong Dinh <kdinh@apm.com>
To: lorenzo.pieralisi@arm.com, marc.zyngier@arm.com, msalter@redhat.com,
 bhelgaas@google.com, linux-pci@vger.kernel.org, jcm@redhat.com
Subject: [PATCH v3 pci] PCI/MSI: pci-xgene-msi: Enable MSI support in ACPI
 boot for X-Gene v1
Date: Fri, 11 Aug 2017 18:02:53 -0600
Message-Id: <1502496173-6017-1-git-send-email-kdinh@apm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: rjw@rjwysocki.net, Khuong Dinh <kdinh@apm.com>, patches@apm.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

This patch makes pci-xgene-msi driver ACPI-aware and provides
MSI capability for X-Gene v1 PCIe controllers in ACPI boot mode.

Signed-off-by: Khuong Dinh <kdinh@apm.com>
        [Take over from Duc Dang]
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
---
v3:
 - Input X-Gene MSI base address for irq_domain_alloc_fwnode
 - Add a hook to enforce X-Gene MSI be probed prior acpi_bus_scan happens
v2:
 - Verify with BIOS version 3.06.25 and 3.07.09
v1:
 - Initial version
---
 drivers/acpi/Makefile            |    2 +-
 drivers/acpi/acpi_msi.c          |   74 ++++++++++++++++++++++++++++++++++++++
 drivers/acpi/internal.h          |    1 +
 drivers/acpi/scan.c              |    1 +
 drivers/pci/host/pci-xgene-msi.c |   36 +++++++++++++++++--
 5 files changed, 110 insertions(+), 4 deletions(-)
 create mode 100644 drivers/acpi/acpi_msi.c

diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index b1aacfc..c15f5cd 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -40,7 +40,7 @@ acpi-y				+= ec.o
 acpi-$(CONFIG_ACPI_DOCK)	+= dock.o
 acpi-y				+= pci_root.o pci_link.o pci_irq.o
 obj-$(CONFIG_ACPI_MCFG)		+= pci_mcfg.o
-acpi-y				+= acpi_lpss.o acpi_apd.o
+acpi-y				+= acpi_lpss.o acpi_apd.o acpi_msi.o
 acpi-y				+= acpi_platform.o
 acpi-y				+= acpi_pnp.o
 acpi-$(CONFIG_ARM_AMBA)	+= acpi_amba.o
diff --git a/drivers/acpi/acpi_msi.c b/drivers/acpi/acpi_msi.c
new file mode 100644
index 0000000..c2f8d26
--- /dev/null
+++ b/drivers/acpi/acpi_msi.c
@@ -0,0 +1,74 @@
+/*
+ * Enforce MSI driver loaded by PCIe controller driver
+ *
+ * Copyright (c) 2017, MACOM Technology Solutions Corporation
+ * Author: Khuong Dinh <kdinh@apm.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/acpi.h>
+#include "internal.h"
+
+static acpi_status acpi_create_msi_device(acpi_handle handle, u32 Level,
+					void *context, void **retval)
+{
+	struct acpi_device *device = NULL;
+	int type = ACPI_BUS_TYPE_DEVICE;
+	unsigned long long sta;
+	acpi_status status;
+	int ret = 0;
+
+	acpi_bus_get_device(handle, &device);
+	status = acpi_bus_get_status_handle(handle, &sta);
+	if (ACPI_FAILURE(status))
+		sta = 0;
+
+	device = kzalloc(sizeof(struct acpi_device), GFP_KERNEL);
+	if (!device)
+		return -ENOMEM;
+
+	acpi_init_device_object(device, handle, type, sta);
+	ret = acpi_device_add(device, NULL);
+	if (ret)
+		return ret;
+	device->parent = kzalloc(sizeof(struct acpi_device), GFP_KERNEL);
+	INIT_LIST_HEAD(&device->parent->physical_node_list);
+
+	acpi_device_add_finalize(device);
+
+	ret = device_attach(&device->dev);
+	if (ret < 0)
+		return ret;
+
+	acpi_create_platform_device(device, NULL);
+	acpi_device_set_enumerated(device);
+
+	return ret;
+}
+
+static const struct acpi_device_id acpi_msi_device_ids[] = {
+	{"APMC0D0E", 0},
+	{ }
+};
+
+int __init acpi_msi_init(void)
+{
+	acpi_status status;
+	int ret = 0;
+
+	status = acpi_get_devices(acpi_msi_device_ids[0].id,
+			acpi_create_msi_device, NULL, NULL);
+	if (ACPI_FAILURE(status))
+		ret = -ENODEV;
+
+	return ret;
+}
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 58dd7ab..3da50d3 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -80,6 +80,7 @@ int acpi_scan_add_handler_with_hotplug(struct acpi_scan_handler *handler,
 void acpi_lpss_init(void);
 
 void acpi_apd_init(void);
+int acpi_msi_init(void);
 
 acpi_status acpi_hotplug_schedule(struct acpi_device *adev, u32 src);
 bool acpi_queue_hotplug_work(struct work_struct *work);
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 3389729..8ec4d39 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2029,6 +2029,7 @@ int __init acpi_scan_init(void)
 	acpi_status status;
 	struct acpi_table_stao *stao_ptr;
 
+	acpi_msi_init();
 	acpi_pci_root_init();
 	acpi_pci_link_init();
 	acpi_processor_init();
diff --git a/drivers/pci/host/pci-xgene-msi.c b/drivers/pci/host/pci-xgene-msi.c
index f1b633b..b1768a1 100644
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
@@ -469,7 +487,18 @@ static int xgene_msi_probe(struct platform_device *pdev)
 		goto error;
 	}
 	xgene_msi->msi_addr = res->start;
-	xgene_msi->node = pdev->dev.of_node;
+
+	xgene_msi->fwnode = of_node_to_fwnode(pdev->dev.of_node);
+	if (!xgene_msi->fwnode) {
+		xgene_msi->fwnode =
+			irq_domain_alloc_fwnode((void *)xgene_msi->msi_addr);
+		if (!xgene_msi->fwnode) {
+			dev_err(&pdev->dev, "Failed to create fwnode\n");
+			rc = ENOMEM;
+			goto error;
+		}
+	}
+
 	xgene_msi->num_cpus = num_possible_cpus();
 
 	rc = xgene_msi_init_allocator(xgene_msi);
@@ -540,6 +569,7 @@ static int xgene_msi_probe(struct platform_device *pdev)
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
