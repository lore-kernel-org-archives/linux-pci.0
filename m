Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Khuong Dinh <kdinh@apm.com>
To: lorenzo.pieralisi@arm.com, marc.zyngier@arm.com, msalter@redhat.com,
 bhelgaas@google.com, linux-pci@vger.kernel.org, jcm@redhat.com
Subject: [PATCH v4 pci 2/2] PCI/MSI: Enforce MSI driver loaded before PCIe in
 ACPI boot
Date: Tue, 26 Sep 2017 11:49:21 -0600
Message-Id: <1506448161-30961-3-git-send-email-kdinh@apm.com>
In-Reply-To: <1506448161-30961-1-git-send-email-kdinh@apm.com>
References: <1506448161-30961-1-git-send-email-kdinh@apm.com>
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

This patch enforces MSI driver loaded before PCIe controller driver
in ACPI boot mode.

Signed-off-by: Khuong Dinh <kdinh@apm.com>
---
 drivers/acpi/Makefile            |    2 +-
 drivers/acpi/acpi_msi.c          |   86 ++++++++++++++++++++++++++++++++++++++
 drivers/acpi/acpi_platform.c     |    3 +-
 drivers/acpi/internal.h          |    1 +
 drivers/acpi/scan.c              |    1 +
 drivers/pci/host/pci-xgene-msi.c |   22 +++++++++-
 include/linux/acpi_msi.h         |   37 ++++++++++++++++
 7 files changed, 148 insertions(+), 4 deletions(-)
 create mode 100644 drivers/acpi/acpi_msi.c
 create mode 100644 include/linux/acpi_msi.h

diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 90265ab..b33247e 100644
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
index 0000000..a254e84
--- /dev/null
+++ b/drivers/acpi/acpi_msi.c
@@ -0,0 +1,86 @@
+/*
+ * Enforce MSI driver loaded before PCIe controller driver
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
+#include <linux/acpi_msi.h>
+
+struct msi_driver_item {
+	struct list_head msi_drv_list;
+	struct platform_driver *addr;
+	unsigned char id[ACPI_ID_LEN];
+};
+
+static LIST_HEAD(msi_drv_list);
+
+static acpi_status acpi_create_msi_device(acpi_handle handle, u32 Level,
+					void *context, void **retval)
+{
+	acpi_status status = AE_OK;
+	int result;
+
+	acpi_scan_lock_acquire();
+	result = acpi_bus_scan(handle);
+	acpi_scan_lock_release();
+	if (result) {
+		status = AE_ERROR;
+		goto out;
+	}
+	result = platform_driver_register((struct platform_driver *) context);
+	if (result) {
+		status = AE_ERROR;
+		goto out;
+	}
+out:
+	return status;
+}
+
+void __init acpi_msi_init(void)
+{
+	struct msi_driver_item *current_msi;
+	struct list_head *pos;
+
+	list_for_each(pos, &msi_drv_list) {
+		current_msi = list_entry(pos, struct msi_driver_item,
+					msi_drv_list);
+		if (!current_msi)
+			return;
+
+		acpi_get_devices(current_msi->id,
+			acpi_create_msi_device,
+			(void *) current_msi->addr,
+			NULL);
+	}
+}
+
+void acpi_msi_drv_subscribe(struct acpi_device_id msi_acpi_ids,
+					struct platform_driver *msi)
+{
+	struct msi_driver_item *new_msi;
+
+	if (!msi)
+		return;
+
+	new_msi = kmalloc(sizeof(*new_msi), GFP_KERNEL);
+	if (!new_msi)
+		return;
+
+	list_add(&(new_msi->msi_drv_list), &msi_drv_list);
+	new_msi->addr = msi;
+	strncpy(new_msi->id, msi_acpi_ids.id, sizeof(new_msi->id));
+	new_msi->id[sizeof(new_msi->id) - 1] = '\0';
+}
diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
index 88cd949..a546076 100644
--- a/drivers/acpi/acpi_platform.c
+++ b/drivers/acpi/acpi_platform.c
@@ -44,7 +44,8 @@ static void acpi_platform_fill_resource(struct acpi_device *adev,
 	 * If the device has parent we need to take its resources into
 	 * account as well because this device might consume part of those.
 	 */
-	parent = acpi_get_first_physical_node(adev->parent);
+	parent = adev->parent ?
+			acpi_get_first_physical_node(adev->parent) : NULL;
 	if (parent && dev_is_pci(parent))
 		dest->parent = pci_find_resource(to_pci_dev(parent), dest);
 }
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 4361c44..ec81801 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -80,6 +80,7 @@ int acpi_scan_add_handler_with_hotplug(struct acpi_scan_handler *handler,
 void acpi_lpss_init(void);
 
 void acpi_apd_init(void);
+void acpi_msi_init(void);
 
 acpi_status acpi_hotplug_schedule(struct acpi_device *adev, u32 src);
 bool acpi_queue_hotplug_work(struct work_struct *work);
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 602f8ff..f1d7b96 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2110,6 +2110,7 @@ int __init acpi_scan_init(void)
 	acpi_status status;
 	struct acpi_table_stao *stao_ptr;
 
+	acpi_msi_init();
 	acpi_pci_root_init();
 	acpi_pci_link_init();
 	acpi_processor_init();
diff --git a/drivers/pci/host/pci-xgene-msi.c b/drivers/pci/host/pci-xgene-msi.c
index d657248..327e663 100644
--- a/drivers/pci/host/pci-xgene-msi.c
+++ b/drivers/pci/host/pci-xgene-msi.c
@@ -26,6 +26,7 @@
 #include <linux/platform_device.h>
 #include <linux/of_pci.h>
 #include <linux/acpi.h>
+#include <linux/acpi_msi.h>
 
 #define MSI_IR0			0x000000
 #define MSI_INT0		0x800000
@@ -577,8 +578,25 @@ static int xgene_msi_probe(struct platform_device *pdev)
 	.remove = xgene_msi_remove,
 };
 
-static int __init xgene_pcie_msi_init(void)
+static int __init xgene_pcie_msi_subscribe(void)
 {
+	int i;
+
+	for (i = 0; i < sizeof(xgene_msi_acpi_ids)
+			/ sizeof(xgene_msi_acpi_ids[0]) - 1; i++)
+		acpi_msi_drv_subscribe(xgene_msi_acpi_ids[i],
+						&xgene_msi_driver);
+	return 0;
+}
+
+static int __init xgene_pcie_msi_register(void)
+{
+	if (driver_find(xgene_msi_driver.driver.name, &platform_bus_type))
+		return -EBUSY;
+
 	return platform_driver_register(&xgene_msi_driver);
 }
-subsys_initcall(xgene_pcie_msi_init);
+
+pure_initcall(xgene_pcie_msi_subscribe);
+
+module_init(xgene_pcie_msi_register);
diff --git a/include/linux/acpi_msi.h b/include/linux/acpi_msi.h
new file mode 100644
index 0000000..f132416
--- /dev/null
+++ b/include/linux/acpi_msi.h
@@ -0,0 +1,37 @@
+/*
+ * Enforce MSI driver loaded before PCIe controller driver library
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
+#ifndef __ACPI_MSI_H__
+#define __ACPI_MSI_H__
+
+#include <linux/platform_device.h>
+
+/**
+ * acpi_msi_drv_subscribe - Allow MSI drivers to subscribe its driver
+ * information (acpi device id and platform driver address) such that
+ * the ACPI driver layer probes its first before the controller
+ * enumerated. This enforce that the MSI driver is always probed
+ * before the PCIe controller driver.
+ *
+ * @msi_acpi_ids: The MSI ACPI devive.
+ * @msi: The MSI platform driver.
+ *
+ */
+void acpi_msi_drv_subscribe(struct acpi_device_id msi_acpi_ids,
+					struct platform_driver *msi);
+
+#endif				/* __ACPI_MSI_H__ */
-- 
1.7.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
