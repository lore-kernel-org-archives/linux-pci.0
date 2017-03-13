Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "zhichang.yuan" <yuanzhichang@hisilicon.com>
To: <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <robh+dt@kernel.org>, <frowand.list@gmail.com>,
        <bhelgaas@google.com>, <rafael@kernel.org>, <mark.rutland@arm.com>,
        <rjw@rjwysocki.net>, <arnd@arndb.de>,
        <linux-arm-kernel@lists.infradead.org>
CC: <linux-acpi@vger.kernel.org>, <lorenzo.pieralisi@arm.com>,
        <benh@kernel.crashing.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <devicetree@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <minyard@acm.org>, <liviu.dudau@arm.com>, <zourongrong@gmail.com>,
        <john.garry@huawei.com>, <gabriele.paoloni@huawei.com>,
        <zhichang.yuan02@gmail.com>, <kantyzc@163.com>,
        <xuwei5@hisilicon.com>,
        "zhichang.yuan" <yuanzhichang@hisilicon.com>
Subject: [PATCH V7 6/7] LIBIO: Support the dynamically logical PIO registration  of ACPI host I/O
Date: Mon, 13 Mar 2017 10:42:42 +0800
Message-ID: <1489372963-9000-7-git-send-email-yuanzhichang@hisilicon.com>
In-Reply-To: <1489372963-9000-1-git-send-email-yuanzhichang@hisilicon.com>
References: <1489372963-9000-1-git-send-email-yuanzhichang@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

For those hosts which access I/O based on the host/bus local I/O addresses,
their I/O range must be registered and translated as unique logical PIO before
the ACPI enumeration on the devices under the hosts. Otherwise, there is no
available I/O resources allocated for those devices.
This patch implements the interfaces in LIBIO to perform the host local I/O
translation and set the logical IO mapped as ACPI I/O resources.

Signed-off-by: zhichang.yuan <yuanzhichang@hisilicon.com>
Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
---
 include/linux/libio.h |   4 +
 lib/libio.c           | 224 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 228 insertions(+)

diff --git a/include/linux/libio.h b/include/linux/libio.h
index 91038aa..95c5f3e 100644
--- a/include/linux/libio.h
+++ b/include/linux/libio.h
@@ -20,6 +20,7 @@
 
 #ifdef __KERNEL__
 
+#include <linux/acpi.h>
 #include <linux/fwnode.h>
 
 /* This is compatible to PCI MMIO. */
@@ -90,5 +91,8 @@ static inline unsigned long libio_translate_hwaddr(struct fwnode_handle *fwnode,
 
 extern unsigned long libio_translate_cpuaddr(resource_size_t hw_addr);
 
+extern int acpi_set_libio_resource(struct acpi_device *adev,
+			struct acpi_device *host);
+
 #endif /* __KERNEL__ */
 #endif /* __LINUX_LIBIO_H */
diff --git a/lib/libio.c b/lib/libio.c
index e42f50b..b60ec9c 100644
--- a/lib/libio.c
+++ b/lib/libio.c
@@ -242,6 +242,230 @@ resource_size_t libio_to_hwaddr(unsigned long pio)
 	return -1;
 }
 
+#ifdef	CONFIG_ACPI
+static inline bool acpi_libio_supported_resource(struct acpi_resource *res)
+{
+	switch (res->type) {
+	case ACPI_RESOURCE_TYPE_ADDRESS32:
+	case ACPI_RESOURCE_TYPE_ADDRESS64:
+		return true;
+	}
+	return false;
+}
+
+static acpi_status acpi_count_libiores(struct acpi_resource *res,
+					   void *data)
+{
+	int *res_cnt = data;
+
+	if (acpi_libio_supported_resource(res) &&
+		!acpi_dev_filter_resource_type(res, IORESOURCE_IO))
+		(*res_cnt)++;
+
+	return AE_OK;
+}
+
+static acpi_status acpi_read_one_libiores(struct acpi_resource *res,
+		void *data)
+{
+	struct acpi_resource **resource = data;
+
+	if (acpi_libio_supported_resource(res) &&
+		!acpi_dev_filter_resource_type(res, IORESOURCE_IO)) {
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
+acpi_build_libiores_template(struct acpi_device *adev,
+			struct acpi_buffer *buffer)
+{
+	acpi_handle handle = adev->handle;
+	struct acpi_resource *resource;
+	acpi_status status;
+	int res_cnt = 0;
+
+	status = acpi_walk_resources(handle, METHOD_NAME__CRS,
+				     acpi_count_libiores, &res_cnt);
+	if (ACPI_FAILURE(status) || !res_cnt) {
+		dev_err(&adev->dev, "can't evaluate _CRS: %d\n", status);
+		return -EINVAL;
+	}
+
+	buffer->length = sizeof(struct acpi_resource) * (res_cnt + 1) + 1;
+	buffer->pointer = kzalloc(buffer->length - 1, GFP_KERNEL);
+	if (!buffer->pointer)
+		return -ENOMEM;
+
+	resource = (struct acpi_resource *)buffer->pointer;
+	status = acpi_walk_resources(handle, METHOD_NAME__CRS,
+				     acpi_read_one_libiores, &resource);
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
+static int acpi_translate_libiores(struct acpi_device *adev,
+		struct acpi_device *host, struct acpi_buffer *buffer)
+{
+	int res_cnt = (buffer->length - 1) / sizeof(struct acpi_resource) - 1;
+	struct acpi_resource *resource = buffer->pointer;
+	struct acpi_resource_address64 addr;
+	unsigned long sys_port;
+	struct device *dev = &adev->dev;
+
+	/* only one I/O resource now */
+	if (res_cnt != 1) {
+		dev_err(dev, "encode %d resources whose type is(%d)!\n",
+			res_cnt, resource->type);
+		return -EINVAL;
+	}
+
+	if (ACPI_FAILURE(acpi_resource_to_address64(resource, &addr))) {
+		dev_err(dev, "convert acpi resource(%d) as addr64 FAIL!\n",
+			resource->type);
+		return -EFAULT;
+	}
+
+	/* For indirect-IO, addr length must be fixed. (>0, 0/1, 0/1)(0,0,0) */
+	if (addr.min_address_fixed != addr.max_address_fixed) {
+		dev_warn(dev, "variable I/O resource is invalid!\n");
+		return -EINVAL;
+	}
+
+	dev_dbg(dev, "CRS IO: len=0x%llx [0x%llx - 0x%llx]\n",
+			addr.address.address_length, addr.address.minimum,
+			addr.address.maximum);
+	sys_port = libio_translate_hwaddr(&host->fwnode, addr.address.minimum);
+	if (sys_port == -1) {
+		dev_err(dev, "translate bus-addr(0x%llx) fail!\n",
+			addr.address.minimum);
+		return -EFAULT;
+	}
+
+	switch (resource->type) {
+	case ACPI_RESOURCE_TYPE_ADDRESS32:
+	{
+		struct acpi_resource_address32 *out_res;
+
+		out_res = &resource->data.address32;
+		if (!addr.address.address_length)
+			addr.address.address_length = out_res->address.maximum -
+				out_res->address.minimum + 1;
+		out_res->address.minimum = sys_port;
+		out_res->address.maximum = sys_port +
+				addr.address.address_length - 1;
+		out_res->address.address_length = addr.address.address_length;
+
+		dev_info(dev, "_SRS 32IO: [0x%x - 0x%x] len = 0x%x\n",
+			out_res->address.minimum,
+			out_res->address.maximum,
+			out_res->address.address_length);
+
+		break;
+	}
+
+	case ACPI_RESOURCE_TYPE_ADDRESS64:
+	{
+		struct acpi_resource_address64 *out_res;
+
+		out_res = &resource->data.address64;
+		if (!addr.address.address_length)
+			addr.address.address_length = out_res->address.maximum -
+				out_res->address.minimum + 1;
+		out_res->address.minimum = sys_port;
+		out_res->address.maximum = sys_port +
+				addr.address.address_length - 1;
+		out_res->address.address_length = addr.address.address_length;
+
+		dev_info(dev, "_SRS 64IO: [0x%llx - 0x%llx] len = 0x%llx\n",
+			out_res->address.minimum,
+			out_res->address.maximum,
+			out_res->address.address_length);
+
+		break;
+	}
+
+	default:
+		return -EINVAL;
+
+	}
+
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
+int acpi_set_libio_resource(struct acpi_device *adev,
+		struct acpi_device *host)
+{
+	struct device *dev = &adev->dev;
+	struct acpi_buffer buffer;
+	acpi_status status;
+	int ret;
+
+	if (!host)
+		return -EINVAL;
+
+	/* check the device state */
+	if (!adev->status.present) {
+		dev_info(dev, "ACPI: device is not present!\n");
+		return 0;
+	}
+	/* whether the child had been enumerated? */
+	if (acpi_device_enumerated(adev)) {
+		dev_info(dev, "ACPI: had been enumerated!\n");
+		return 0;
+	}
+
+	/* read the _CRS and convert as acpi_buffer */
+	status = acpi_build_libiores_template(adev, &buffer);
+	if (ACPI_FAILURE(status)) {
+		dev_warn(dev, "Failure evaluating %s\n", METHOD_NAME__CRS);
+		return -ENODEV;
+	}
+
+	/* translate the I/O resources */
+	ret = acpi_translate_libiores(adev, host, &buffer);
+	if (ret) {
+		kfree(buffer.pointer);
+		dev_err(dev, "Translate I/O range FAIL!\n");
+		return ret;
+	}
+
+	/* set current resource... */
+	status = acpi_set_current_resources(adev->handle, &buffer);
+	kfree(buffer.pointer);
+	if (ACPI_FAILURE(status)) {
+		dev_err(dev, "Error evaluating _SRS (0x%x)\n", status);
+		ret = -EIO;
+	}
+
+	return ret;
+}
+#endif
+
 #ifdef PCI_IOBASE
 static struct libio_range *find_io_range(unsigned long pio)
 {
-- 
1.9.1

