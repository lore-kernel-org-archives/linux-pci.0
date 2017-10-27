Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <robh+dt@kernel.org>, <frowand.list@gmail.com>,
        <bhelgaas@google.com>, <rafael@kernel.org>, <arnd@arndb.de>,
        <linux-arm-kernel@lists.infradead.org>, <lorenzo.pieralisi@arm.com>
CC: <gabriele.paoloni@huawei.com>, <mark.rutland@arm.com>,
        <brian.starkey@arm.com>, <olof@lixom.net>,
        <benh@kernel.crashing.org>, <linux-kernel@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-pci@vger.kernel.org>, <minyard@acm.org>,
        <john.garry@huawei.com>, <xuwei5@hisilicon.com>
Subject: [PATCH v10 7/9] ACPI: Translate the I/O range of non-MMIO devices before scanning
Date: Fri, 27 Oct 2017 17:11:25 +0100
Message-ID: <1509120687-7352-8-git-send-email-gabriele.paoloni@huawei.com>
In-Reply-To: <1509120687-7352-1-git-send-email-gabriele.paoloni@huawei.com>
References: <1509120687-7352-1-git-send-email-gabriele.paoloni@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: gabriele paoloni <gabriele.paoloni@huawei.com>

On some platforms(such as Hip06/Hip07), the legacy ISA/LPC devices access
I/O with some special host-local I/O ports known on x86. As their I/O space
are not memory mapped like PCI/PCIE MMIO host bridges, this patch is meant
to support a new class of I/O host controllers where the local IO ports of
the children devices are translated into the Indirect I/O address space.

Through the handler attach callback, all the I/O translations are done
before starting the enumeration on children devices and the translated
addresses are replaced in the children resources.

Signed-off-by: zhichang.yuan <yuanzhichang@hisilicon.com>
Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
---
 drivers/acpi/arm64/Makefile          |   1 +
 drivers/acpi/arm64/acpi_indirectio.c | 156 +++++++++++++++++++++++++++++++++++
 drivers/acpi/arm64/acpi_indirectio.h |  24 ++++++
 drivers/acpi/internal.h              |   5 ++
 drivers/acpi/scan.c                  |   1 +
 5 files changed, 187 insertions(+)
 create mode 100644 drivers/acpi/arm64/acpi_indirectio.c
 create mode 100644 drivers/acpi/arm64/acpi_indirectio.h

diff --git a/drivers/acpi/arm64/Makefile b/drivers/acpi/arm64/Makefile
index 1017def..6a33ac6 100644
--- a/drivers/acpi/arm64/Makefile
+++ b/drivers/acpi/arm64/Makefile
@@ -1,2 +1,3 @@
 obj-$(CONFIG_ACPI_IORT) 	+= iort.o
 obj-$(CONFIG_ACPI_GTDT) 	+= gtdt.o
+obj-$(CONFIG_INDIRECT_PIO)     += acpi_indirectio.o
diff --git a/drivers/acpi/arm64/acpi_indirectio.c b/drivers/acpi/arm64/acpi_indirectio.c
new file mode 100644
index 0000000..013db6f
--- /dev/null
+++ b/drivers/acpi/arm64/acpi_indirectio.c
@@ -0,0 +1,156 @@
+/*
+ * ACPI support for indirect-IO bus.
+ *
+ * Copyright (C) 2017 Hisilicon Limited, All Rights Reserved.
+ * Author: Gabriele Paoloni <gabriele.paoloni@huawei.com>
+ * Author: Zhichang Yuan <yuanzhichang@hisilicon.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/acpi.h>
+#include <linux/platform_device.h>
+#include <linux/logic_pio.h>
+
+#include "acpi_indirectio.h"
+
+ACPI_MODULE_NAME("indirect IO");
+
+#define INDIRECT_IO_INFO(desc) ((unsigned long)&desc)
+
+static int acpi_translate_logiciores(struct acpi_device *adev,
+		struct acpi_device *host, struct resource *resource)
+{
+	unsigned long sys_port;
+	struct device *dev = &adev->dev;
+	resource_size_t length = resource->end - resource->start;
+
+	sys_port = logic_pio_trans_hwaddr(&host->fwnode, resource->start,
+					length);
+
+	if (sys_port == -1) {
+		dev_err(dev, "translate bus-addr(0x%llx) fail!\n",
+			resource->start);
+		return -EFAULT;
+	}
+
+	resource->start = sys_port;
+	resource->end = sys_port + length;
+
+	return 0;
+}
+
+/*
+ * update/set the current I/O resource of the designated device node.
+ * after this calling, the enumeration can be started as the I/O resource
+ * had been translated to logicial I/O from bus-local I/O.
+ *
+ * @child: the device node to be updated the I/O resource;
+ * @hostdev: the device node where 'adev' is attached, which can be not
+ *  the parent of 'adev';
+ * @res: double pointer to be set to the address of the updated resources
+ * @num_res: address of the variable to contain the number of updated resources
+ *
+ * return 0 when successful, negative is for failure.
+ */
+int acpi_set_logicio_resource(struct device *child,
+		struct device *hostdev, const struct resource **res,
+		int *num_res)
+{
+	struct acpi_device *adev;
+	struct acpi_device *host;
+	struct resource_entry *rentry;
+	LIST_HEAD(resource_list);
+	struct resource *resources = NULL;
+	int count;
+	int i;
+	int ret = -EIO;
+
+	if (!child || !hostdev)
+		return -EINVAL;
+
+	host = to_acpi_device(hostdev);
+	adev = to_acpi_device(child);
+
+	/* check the device state */
+	if (!adev->status.present) {
+		dev_info(child, "ACPI: device is not present!\n");
+		return 0;
+	}
+	/* whether the child had been enumerated? */
+	if (acpi_device_enumerated(adev)) {
+		dev_info(child, "ACPI: had been enumerated!\n");
+		return 0;
+	}
+
+	count = acpi_dev_get_resources(adev, &resource_list, NULL, NULL);
+	if (count <= 0) {
+		dev_err(&adev->dev, "failed to get ACPI resources\n");
+		return count ? count : -EIO;
+	}
+
+	resources = kcalloc(count, sizeof(struct resource), GFP_KERNEL);
+	if (!resources) {
+		dev_err(&adev->dev, "No memory for resources\n");
+		acpi_dev_free_resource_list(&resource_list);
+		return -ENOMEM;
+	}
+	count = 0;
+	list_for_each_entry(rentry, &resource_list, node)
+		resources[count++] = *rentry->res;
+
+	acpi_dev_free_resource_list(&resource_list);
+
+	/* translate the I/O resources */
+	for (i = 0; i < count; i++) {
+		if (resources[i].flags & IORESOURCE_IO) {
+			ret = acpi_translate_logiciores(adev, host,
+							&resources[i]);
+			if (ret) {
+				kfree(resources);
+				dev_err(child, "Translate I/O range FAIL!\n");
+				return ret;
+			}
+		}
+	}
+	*res = resources;
+	*num_res = count;
+
+	return ret;
+}
+
+/* All the host devices which apply indirect-IO can be listed here. */
+static const struct acpi_device_id acpi_indirect_host_id[] = {
+	{""},
+};
+
+static int acpi_indirectio_attach(struct acpi_device *adev,
+				const struct acpi_device_id *id)
+{
+	struct indirectio_device_desc *hostdata;
+	int ret;
+
+	hostdata = (struct indirectio_device_desc *)id->driver_data;
+	if (!hostdata || !hostdata->pre_setup)
+		return -EINVAL;
+
+	ret = hostdata->pre_setup(adev, hostdata->pdata);
+
+	if (ret < 0)
+		return ret;
+
+	return 1;
+}
+
+
+static struct acpi_scan_handler acpi_indirect_handler = {
+	.ids = acpi_indirect_host_id,
+	.attach = acpi_indirectio_attach,
+};
+
+void __init acpi_indirectio_scan_init(void)
+{
+	acpi_scan_add_handler(&acpi_indirect_handler);
+}
diff --git a/drivers/acpi/arm64/acpi_indirectio.h b/drivers/acpi/arm64/acpi_indirectio.h
new file mode 100644
index 0000000..8102ea0
--- /dev/null
+++ b/drivers/acpi/arm64/acpi_indirectio.h
@@ -0,0 +1,24 @@
+/*
+ * ACPI support for indirect-IO bus.
+ *
+ * Copyright (C) 2017 Hisilicon Limited, All Rights Reserved.
+ * Author: Gabriele Paoloni <gabriele.paoloni@huawei.com>
+ * Author: Zhichang Yuan <yuanzhichang@hisilicon.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _ACPI_INDIRECTIO_H
+#define _ACPI_INDIRECTIO_H
+
+struct indirectio_device_desc {
+	void *pdata; /* device relevant info data */
+	int (*pre_setup)(struct acpi_device *adev, void *pdata);
+};
+
+int acpi_set_logicio_resource(struct device *child,
+		struct device *hostdev, const struct resource **res,
+		int *num_res);
+#endif
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 9531d32..36da45c 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -31,6 +31,11 @@ void acpi_processor_init(void);
 void acpi_platform_init(void);
 void acpi_pnp_init(void);
 void acpi_int340x_thermal_init(void);
+#ifdef CONFIG_INDIRECT_PIO
+void acpi_indirectio_scan_init(void);
+#else
+static inline void acpi_indirectio_scan_init(void) {}
+#endif
 #ifdef CONFIG_ARM_AMBA
 void acpi_amba_init(void);
 #else
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 3389729..14d6126 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2041,6 +2041,7 @@ int __init acpi_scan_init(void)
 	acpi_int340x_thermal_init();
 	acpi_amba_init();
 	acpi_watchdog_init();
+	acpi_indirectio_scan_init();
 
 	acpi_scan_add_handler(&generic_device_handler);
 
-- 
2.7.4


