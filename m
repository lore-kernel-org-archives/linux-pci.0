Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:35794 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751646AbdBXAJr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 23 Feb 2017 19:09:47 -0500
From: Logan Gunthorpe <logang@deltatee.com>
To: Keith Busch <keith.busch@intel.com>,
        Myron Stowe <myron.stowe@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Wei Zhang <wzhang@fb.com>
Cc: Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Stephen Bates <stephen.bates@microsemi.com>,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Logan Gunthorpe <logang@deltatee.com>
Date: Thu, 23 Feb 2017 17:07:23 -0700
Message-Id: <1487894844-2721-4-git-send-email-logang@deltatee.com>
In-Reply-To: <1487894844-2721-1-git-send-email-logang@deltatee.com>
References: <1487894844-2721-1-git-send-email-logang@deltatee.com>
Subject: [PATCH v3 3/4] switchtec: Add sysfs attributes to the Switchtec driver
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch adds a few read-only sysfs attributes which provide
some device information that is exposed from the devices. Primarily
component and device names and versions. These are documented in
Documentation/ABI/testing/sysfs-class-switchtec.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Stephen Bates <stephen.bates@microsemi.com>
Tested-by: Krishna Dhulipala <krishnad@fb.com>
Reviewed-by: Wei Zhang <wzhang@fb.com>
Reviewed-by: Jens Axboe <axboe@fb.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/ABI/testing/sysfs-class-switchtec |  96 ++++++++++++++++++++
 MAINTAINERS                                     |   1 +
 drivers/pci/switch/switchtec.c                  | 113 ++++++++++++++++++++++++
 3 files changed, 210 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-switchtec

diff --git a/Documentation/ABI/testing/sysfs-class-switchtec b/Documentation/ABI/testing/sysfs-class-switchtec
new file mode 100644
index 0000000..48cb4c1
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-switchtec
@@ -0,0 +1,96 @@
+switchtec - Microsemi Switchtec PCI Switch Management Endpoint
+
+For details on this subsystem look at Documentation/switchtec.txt.
+
+What: 		/sys/class/switchtec
+Date:		05-Jan-2017
+KernelVersion:	v4.11
+Contact:	Logan Gunthorpe <logang@deltatee.com>
+Description:	The switchtec class subsystem folder.
+		Each registered switchtec driver is represented by a switchtecX
+		subfolder (X being an integer >= 0).
+
+
+What:		/sys/class/switchtec/switchtec[0-9]+/component_id
+Date:		05-Jan-2017
+KernelVersion:	v4.11
+Contact:	Logan Gunthorpe <logang@deltatee.com>
+Description:	Component identifier as stored in the hardware (eg. PM8543)
+		(read only)
+Values: 	arbitrary string.
+
+
+What:		/sys/class/switchtec/switchtec[0-9]+/component_revision
+Date:		05-Jan-2017
+KernelVersion:	v4.11
+Contact:	Logan Gunthorpe <logang@deltatee.com>
+Description:	Component revision stored in the hardware (read only)
+Values: 	integer.
+
+
+What:		/sys/class/switchtec/switchtec[0-9]+/component_vendor
+Date:		05-Jan-2017
+KernelVersion:	v4.11
+Contact:	Logan Gunthorpe <logang@deltatee.com>
+Description:	Component vendor as stored in the hardware (eg. MICROSEM)
+		(read only)
+Values: 	arbitrary string.
+
+
+What:		/sys/class/switchtec/switchtec[0-9]+/device_version
+Date:		05-Jan-2017
+KernelVersion:	v4.11
+Contact:	Logan Gunthorpe <logang@deltatee.com>
+Description:	Device version as stored in the hardware (read only)
+Values: 	integer.
+
+
+What:		/sys/class/switchtec/switchtec[0-9]+/fw_version
+Date:		05-Jan-2017
+KernelVersion:	v4.11
+Contact:	Logan Gunthorpe <logang@deltatee.com>
+Description:	Currently running firmware version (read only)
+Values: 	integer (in hexadecimal).
+
+
+What:		/sys/class/switchtec/switchtec[0-9]+/partition
+Date:		05-Jan-2017
+KernelVersion:	v4.11
+Contact:	Logan Gunthorpe <logang@deltatee.com>
+Description:	Partition number for this device in the switch (read only)
+Values: 	integer.
+
+
+What:		/sys/class/switchtec/switchtec[0-9]+/partition_count
+Date:		05-Jan-2017
+KernelVersion:	v4.11
+Contact:	Logan Gunthorpe <logang@deltatee.com>
+Description:	Total number of partitions in the switch (read only)
+Values: 	integer.
+
+
+What:		/sys/class/switchtec/switchtec[0-9]+/product_id
+Date:		05-Jan-2017
+KernelVersion:	v4.11
+Contact:	Logan Gunthorpe <logang@deltatee.com>
+Description:	Product identifier as stored in the hardware (eg. PSX 48XG3)
+		(read only)
+Values: 	arbitrary string.
+
+
+What:		/sys/class/switchtec/switchtec[0-9]+/product_revision
+Date:		05-Jan-2017
+KernelVersion:	v4.11
+Contact:	Logan Gunthorpe <logang@deltatee.com>
+Description:	Product revision stored in the hardware (eg. RevB)
+		(read only)
+Values: 	arbitrary string.
+
+
+What:		/sys/class/switchtec/switchtec[0-9]+/product_vendor
+Date:		05-Jan-2017
+KernelVersion:	v4.11
+Contact:	Logan Gunthorpe <logang@deltatee.com>
+Description:	Product vendor as stored in the hardware (eg. MICROSEM)
+		(read only)
+Values: 	arbitrary string.
diff --git a/MAINTAINERS b/MAINTAINERS
index aa702b0..6fed938 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9513,6 +9513,7 @@ M:	Logan Gunthorpe <logang@deltatee.com>
 L:	linux-pci@vger.kernel.org
 S:	Maintained
 F:	Documentation/switchtec.txt
+F:	Documentation/ABI/testing/sysfs-class-switchtec
 F:	drivers/pci/switch/switchtec*
 
 PCI DRIVER FOR NVIDIA TEGRA
diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index f6bcff1..c09d335 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -485,6 +485,118 @@ static void mrpc_timeout_work(struct work_struct *work)
 	mutex_unlock(&stdev->mrpc_mutex);
 }
 
+static ssize_t device_version_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct switchtec_dev *stdev = to_stdev(dev);
+	u32 ver;
+
+	ver = ioread32(&stdev->mmio_sys_info->device_version);
+
+	return sprintf(buf, "%x\n", ver);
+}
+static DEVICE_ATTR_RO(device_version);
+
+static ssize_t fw_version_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct switchtec_dev *stdev = to_stdev(dev);
+	u32 ver;
+
+	ver = ioread32(&stdev->mmio_sys_info->firmware_version);
+
+	return sprintf(buf, "%08x\n", ver);
+}
+static DEVICE_ATTR_RO(fw_version);
+
+static ssize_t io_string_show(char *buf, void __iomem *attr, size_t len)
+{
+	int i;
+
+	memcpy_fromio(buf, attr, len);
+	buf[len] = '\n';
+	buf[len + 1] = 0;
+
+	for (i = len - 1; i > 0; i--) {
+		if (buf[i] != ' ')
+			break;
+		buf[i] = '\n';
+		buf[i + 1] = 0;
+	}
+
+	return strlen(buf);
+}
+
+#define DEVICE_ATTR_SYS_INFO_STR(field) \
+static ssize_t field ## _show(struct device *dev, \
+	struct device_attribute *attr, char *buf) \
+{ \
+	struct switchtec_dev *stdev = to_stdev(dev); \
+	return io_string_show(buf, &stdev->mmio_sys_info->field, \
+			    sizeof(stdev->mmio_sys_info->field)); \
+} \
+\
+static DEVICE_ATTR_RO(field)
+
+DEVICE_ATTR_SYS_INFO_STR(vendor_id);
+DEVICE_ATTR_SYS_INFO_STR(product_id);
+DEVICE_ATTR_SYS_INFO_STR(product_revision);
+DEVICE_ATTR_SYS_INFO_STR(component_vendor);
+
+static ssize_t component_id_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct switchtec_dev *stdev = to_stdev(dev);
+	int id = ioread16(&stdev->mmio_sys_info->component_id);
+
+	return sprintf(buf, "PM%04X\n", id);
+}
+static DEVICE_ATTR_RO(component_id);
+
+static ssize_t component_revision_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct switchtec_dev *stdev = to_stdev(dev);
+	int rev = ioread8(&stdev->mmio_sys_info->component_revision);
+
+	return sprintf(buf, "%d\n", rev);
+}
+static DEVICE_ATTR_RO(component_revision);
+
+static ssize_t partition_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct switchtec_dev *stdev = to_stdev(dev);
+
+	return sprintf(buf, "%d\n", stdev->partition);
+}
+static DEVICE_ATTR_RO(partition);
+
+static ssize_t partition_count_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct switchtec_dev *stdev = to_stdev(dev);
+
+	return sprintf(buf, "%d\n", stdev->partition_count);
+}
+static DEVICE_ATTR_RO(partition_count);
+
+static struct attribute *switchtec_device_attrs[] = {
+	&dev_attr_device_version.attr,
+	&dev_attr_fw_version.attr,
+	&dev_attr_vendor_id.attr,
+	&dev_attr_product_id.attr,
+	&dev_attr_product_revision.attr,
+	&dev_attr_component_vendor.attr,
+	&dev_attr_component_id.attr,
+	&dev_attr_component_revision.attr,
+	&dev_attr_partition.attr,
+	&dev_attr_partition_count.attr,
+	NULL,
+};
+
+ATTRIBUTE_GROUPS(switchtec_device);
+
 static int switchtec_dev_open(struct inode *inode, struct file *filp)
 {
 	struct switchtec_dev *stdev;
@@ -693,6 +805,7 @@ static struct switchtec_dev *stdev_create(struct pci_dev *pdev)
 	device_initialize(dev);
 	dev->class = switchtec_class;
 	dev->parent = &pdev->dev;
+	dev->groups = switchtec_device_groups;
 	dev->release = stdev_release;
 
 	minor = ida_simple_get(&switchtec_minor_ida, 0, 0,
-- 
2.1.4
