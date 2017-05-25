Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: <catalin.marinas@arm.com>, <will.deacon@arm.com>, <robh+dt@kernel.org>,
 <frowand.list@gmail.com>, <bhelgaas@google.com>, <rafael@kernel.org>,
 <arnd@arndb.de>, <linux-arm-kernel@lists.infradead.org>,
 <lorenzo.pieralisi@arm.com>
Subject: [PATCH v9 5/7] ACPI: Translate the I/O range of non-MMIO devices
 before scanning
Date: Thu, 25 May 2017 12:37:26 +0100
Message-ID: <1495712248-5232-6-git-send-email-gabriele.paoloni@huawei.com>
In-Reply-To: <1495712248-5232-1-git-send-email-gabriele.paoloni@huawei.com>
References: <1495712248-5232-1-git-send-email-gabriele.paoloni@huawei.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: mark.rutland@arm.com, minyard@acm.org, gabriele.paoloni@huawei.com,
 benh@kernel.crashing.org, john.garry@huawei.com, linux-kernel@vger.kernel.org,
 xuwei5@hisilicon.com, linuxarm@huawei.com, linux-acpi@vger.kernel.org,
 linux-pci@vger.kernel.org, olof@lixom.net, brian.starkey@arm.com
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

From: Gabriele <gabriele.paoloni@huawei.com>

On some platforms(such as Hip06/Hip07), the legacy ISA/LPC devices access
I/O with some special host-local I/O ports known on x86. As their I/O
space are not memory mapped like PCI/PCIE MMIO host bridges, this patch is
meant to support a new class of I/O host controllers where the local IO
ports of the children devices are translated into the Indirect I/O address
space.
Through the handler attach callback, all the I/O translations are done
before starting the enumeration on children devices and the translated
addresses are replaced in the children resources.

Signed-off-by: zhichang.yuan <yuanzhichang@hisilicon.com>
Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
---
 drivers/acpi/arm64/Makefile            |   1 +
 drivers/acpi/arm64/acpi_indirect_pio.c | 301 +++++++++++++++++++++++++++++++++
 drivers/acpi/internal.h                |   5 +
 drivers/acpi/scan.c                    |   1 +
 include/acpi/acpi_indirect_pio.h       |  24 +++
 5 files changed, 332 insertions(+)
 create mode 100644 drivers/acpi/arm64/acpi_indirect_pio.c
 create mode 100644 include/acpi/acpi_indirect_pio.h

diff --git a/drivers/acpi/arm64/Makefile b/drivers/acpi/arm64/Makefile
index 1017def..3944775 100644
--- a/drivers/acpi/arm64/Makefile
+++ b/drivers/acpi/arm64/Makefile
@@ -1,2 +1,3 @@
 obj-$(CONFIG_ACPI_IORT) 	+= iort.o
 obj-$(CONFIG_ACPI_GTDT) 	+= gtdt.o
+obj-$(CONFIG_INDIRECT_PIO) += acpi_indirect_pio.o
diff --git a/drivers/acpi/arm64/acpi_indirect_pio.c b/drivers/acpi/arm64/acpi_indirect_pio.c
new file mode 100644
index 0000000..7813f73
--- /dev/null
+++ b/drivers/acpi/arm64/acpi_indirect_pio.c
@@ -0,0 +1,301 @@
+/*
+ * ACPI support for indirect-PIO bus.
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
+#include <acpi/acpi_indirect_pio.h>
+
+ACPI_MODULE_NAME("indirect PIO");
+
+#define INDIRECT_PIO_INFO(desc) ((unsigned long)&desc)
+
+static acpi_status acpi_count_logic_iores(struct acpi_resource *res,
+					   void *data)
+{
+	int *res_cnt = data;
+
+	if (!acpi_dev_filter_resource_type(res, IORESOURCE_IO))
+		(*res_cnt)++;
+
+	return AE_OK;
+}
+
+static acpi_status acpi_read_one_logicpiores(struct acpi_resource *res,
+		void *data)
+{
+	struct acpi_resource **resource = data;
+
+	if (!acpi_dev_filter_resource_type(res, IORESOURCE_IO)) {
+		memcpy((*resource), res, sizeof(struct acpi_resource));
+		(*resource)->length = sizeof(struct acpi_resource);
+		(*resource)->type = res->type;
+		(*resource)++;
+	}
+
+	return AE_OK;
+}
+
+static acpi_status
+acpi_build_logicpiores_template(struct acpi_device *adev,
+			struct acpi_buffer *buffer)
+{
+	acpi_handle handle = adev->handle;
+	struct acpi_resource *resource;
+	acpi_status status;
+	int res_cnt = 0;
+
+	status = acpi_walk_resources(handle, METHOD_NAME__CRS,
+				     acpi_count_logic_iores, &res_cnt);
+	if (ACPI_FAILURE(status)) {
+		dev_err(&adev->dev, "can't evaluate _CRS: %d\n", status);
+		return -EINVAL;
+	}
+
+	if (!res_cnt) {
+		dev_err(&adev->dev, "no logic IO resources\n");
+		return -ENODEV;
+	}
+
+	buffer->length = sizeof(struct acpi_resource) * (res_cnt + 1);
+	buffer->pointer = kzalloc(buffer->length, GFP_KERNEL);
+	if (!buffer->pointer)
+		return -ENOMEM;
+
+	resource = (struct acpi_resource *)buffer->pointer;
+	status = acpi_walk_resources(handle, METHOD_NAME__CRS,
+				     acpi_read_one_logicpiores, &resource);
+	if (ACPI_FAILURE(status)) {
+		kfree(buffer->pointer);
+		dev_err(&adev->dev, "can't evaluate _CRS: %d\n", status);
+		return -EINVAL;
+	}
+
+	resource->type = ACPI_RESOURCE_TYPE_END_TAG;
+	resource->length = sizeof(struct acpi_resource);
+
+	return 0;
+}
+
+static int acpi_translate_logicpiores(struct acpi_device *adev,
+		struct acpi_device *host, struct acpi_buffer *buffer)
+{
+	struct acpi_resource *resource = buffer->pointer;
+	unsigned long sys_port;
+	struct device *dev = &adev->dev;
+	union acpi_resource_data *trans_data = &resource->data;
+	resource_size_t bus_addr;
+	resource_size_t max_pio;
+	resource_size_t length;
+
+	switch (resource->type) {
+	case ACPI_RESOURCE_TYPE_ADDRESS16:
+		if (trans_data->address16.min_address_fixed !=
+				trans_data->address16.max_address_fixed) {
+			dev_warn(dev, "variable I/O resource is invalid!\n");
+			return -EINVAL;
+		}
+		bus_addr = trans_data->address16.address.minimum;
+		length = trans_data->address16.address.address_length;
+		max_pio = U16_MAX;
+		break;
+	case ACPI_RESOURCE_TYPE_ADDRESS32:
+		if (trans_data->address32.min_address_fixed !=
+				trans_data->address32.max_address_fixed) {
+			dev_warn(dev, "variable I/O resource is invalid!\n");
+			return -EINVAL;
+		}
+		bus_addr = trans_data->address32.address.minimum;
+		length = trans_data->address32.address.address_length;
+		max_pio = U32_MAX;
+		break;
+	case ACPI_RESOURCE_TYPE_ADDRESS64:
+		if (trans_data->address64.min_address_fixed !=
+				trans_data->address64.max_address_fixed) {
+			dev_warn(dev, "variable I/O resource is invalid!\n");
+			return -EINVAL;
+		}
+		bus_addr = trans_data->address64.address.minimum;
+		length = trans_data->address64.address.address_length;
+		max_pio = U64_MAX;
+		break;
+	case ACPI_RESOURCE_TYPE_EXTENDED_ADDRESS64:
+		if (trans_data->ext_address64.min_address_fixed !=
+				trans_data->ext_address64.max_address_fixed) {
+			dev_warn(dev, "variable I/O resource is invalid!\n");
+			return -EINVAL;
+		}
+		bus_addr = trans_data->ext_address64.address.minimum;
+		length = trans_data->ext_address64.address.address_length;
+		max_pio = U64_MAX;
+		break;
+	case ACPI_RESOURCE_TYPE_IO:
+		bus_addr = trans_data->io.minimum;
+		length = trans_data->io.address_length;
+		max_pio = U16_MAX;
+		break;
+	case ACPI_RESOURCE_TYPE_FIXED_IO:
+		bus_addr = trans_data->fixed_io.address;
+		length = trans_data->fixed_io.address_length;
+		max_pio = U16_MAX;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	sys_port = logic_pio_trans_hwaddr(&host->fwnode, bus_addr);
+	if (sys_port == -1) {
+		dev_err(dev, "translate bus-addr(0x%llx) fail!\n", bus_addr);
+		return -EFAULT;
+	}
+
+	/*
+	 * we need to check if the resource address can contain the
+	 * translated IO token
+	 */
+	if ((sys_port + length) > max_pio) {
+		dev_err(dev, "sys_port exceeds the max resource address\n");
+		return -ENOSPC;
+	}
+
+	switch (resource->type) {
+	case ACPI_RESOURCE_TYPE_ADDRESS16:
+		trans_data->address16.address.minimum = sys_port;
+		trans_data->address16.address.maximum = sys_port + length;
+		break;
+	case ACPI_RESOURCE_TYPE_ADDRESS32:
+		trans_data->address32.address.minimum = sys_port;
+		trans_data->address32.address.maximum = sys_port + length;
+		break;
+	case ACPI_RESOURCE_TYPE_ADDRESS64:
+		trans_data->address64.address.minimum = sys_port;
+		trans_data->address64.address.maximum = sys_port + length;
+		break;
+	case ACPI_RESOURCE_TYPE_EXTENDED_ADDRESS64:
+		trans_data->ext_address64.address.minimum = sys_port;
+		trans_data->ext_address64.address.maximum = sys_port + length;
+		break;
+	case ACPI_RESOURCE_TYPE_IO:
+		trans_data->io.minimum = sys_port;
+		trans_data->io.maximum = sys_port + length;
+		break;
+	case ACPI_RESOURCE_TYPE_FIXED_IO:
+		trans_data->fixed_io.address = sys_port;
+		break;
+	}
+	return 0;
+}
+
+/*
+ * update/set the current I/O resource of the designated device node.
+ * after this calling, the enumeration can be started as the I/O resource
+ * had been translated to logicial I/O from bus-local I/O.
+ *
+ * @adev: the device node to be updated the I/O resource;
+ * @host: the device node where 'adev' is attached, which can be not
+ *	the parent of 'adev';
+ *
+ * return 0 when successful, negative is for failure.
+ */
+int acpi_set_logic_pio_resource(struct device *child,
+		struct device *hostdev)
+{
+	struct acpi_device *adev;
+	struct acpi_device *host;
+	struct acpi_buffer buffer;
+	acpi_status status;
+	int ret;
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
+	/* read the _CRS and convert as acpi_buffer */
+	status = acpi_build_logicpiores_template(adev, &buffer);
+	if (ACPI_FAILURE(status)) {
+		dev_warn(child, "Failure evaluating %s\n", METHOD_NAME__CRS);
+		return -ENODEV;
+	}
+
+	/* translate the I/O resources */
+	ret = acpi_translate_logicpiores(adev, host, &buffer);
+	if (ret) {
+		kfree(buffer.pointer);
+		dev_err(child, "Translate I/O range FAIL!\n");
+		return ret;
+	}
+
+	/* set current resource... */
+	status = acpi_set_current_resources(adev->handle, &buffer);
+	kfree(buffer.pointer);
+	if (ACPI_FAILURE(status)) {
+		dev_err(child, "Error evaluating _SRS (0x%x)\n", status);
+		ret = -EIO;
+	}
+
+	return ret;
+}
+
+/* All the host devices which apply indirect-PIO can be listed here. */
+static const struct acpi_device_id acpi_indirect_host_id[] = {
+	{""},
+};
+
+static int acpi_indirectpio_attach(struct acpi_device *adev,
+				const struct acpi_device_id *id)
+{
+	struct indirect_pio_device_desc *hostdata;
+	struct platform_device *pdev;
+	int ret;
+
+	hostdata = (struct indirect_pio_device_desc *)id->driver_data;
+	if (!hostdata || !hostdata->pre_setup)
+		return -EINVAL;
+
+	ret = hostdata->pre_setup(adev, hostdata->pdata);
+	if (!ret) {
+		pdev = acpi_create_platform_device(adev, NULL);
+		if (IS_ERR_OR_NULL(pdev)) {
+			dev_err(&adev->dev, "Create platform device for host FAIL!\n");
+			return -EFAULT;
+		}
+		acpi_device_set_enumerated(adev);
+		ret = 1;
+	}
+
+	return ret;
+}
+
+
+static struct acpi_scan_handler acpi_indirect_handler = {
+	.ids = acpi_indirect_host_id,
+	.attach = acpi_indirectpio_attach,
+};
+
+void __init acpi_indirectio_scan_init(void)
+{
+	acpi_scan_add_handler(&acpi_indirect_handler);
+}
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 66229ff..bf8aaf8 100644
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
index e39ec7b..37dd23c 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2035,6 +2035,7 @@ int __init acpi_scan_init(void)
 	acpi_int340x_thermal_init();
 	acpi_amba_init();
 	acpi_watchdog_init();
+	acpi_indirectio_scan_init();
 
 	acpi_scan_add_handler(&generic_device_handler);
 
diff --git a/include/acpi/acpi_indirect_pio.h b/include/acpi/acpi_indirect_pio.h
new file mode 100644
index 0000000..efc5c43
--- /dev/null
+++ b/include/acpi/acpi_indirect_pio.h
@@ -0,0 +1,24 @@
+/*
+ * ACPI support for indirect-PIO bus.
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
+#ifndef _ACPI_INDIRECT_PIO_H
+#define _ACPI_INDIRECT_PIO_H
+
+struct indirect_pio_device_desc {
+	void *pdata; /* device relevant info data */
+	int (*pre_setup)(struct acpi_device *adev, void *pdata);
+};
+
+int acpi_set_logic_pio_resource(struct device *child,
+		struct device *hostdev);
+
+#endif
-- 
2.7.4



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
