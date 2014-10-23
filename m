Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57463 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752705AbaJWSVI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 23 Oct 2014 14:21:08 -0400
From: Prarit Bhargava <prarit@redhat.com>
To: rhkernel-list@redhat.com
Cc: Prarit Bhargava <prarit@redhat.com>,
	Myron Stowe <mstowe@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Alexander Ducyk <alexander.h.duyck@redhat.com>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	linux-pci@vger.kernel.org
Subject: [PATCH V2] pci, add sysfs numa_node write function
Date: Thu, 23 Oct 2014 14:20:54 -0400
Message-Id: <1414088454-24522-1-git-send-email-prarit@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Some new drivers, such as the Intel QAT driver, drivers/crypto/qat,
require that a specific node be assigned to the device in order to
achieve maximum performance for the device, and will fail to load if the
device has NUMA_NO_NODE.  Users can in some cases, with additional
information provided by vendor support, determine what the correct numa
node is supposed to be.  In the cases a quick hack of the driver results
in a function QAT device.

In theory, it should be possible to map a PCI device to a PCI root bridge
to a specific node, however, in practice it is not possible.  Nodes may
have multiple PCI root bridges, may share multiple PCI root bridges, or
may not have an active root bridge assigned.  Hardware manufacturers may
specifically have designed systems without numa node to PCI root bridge
mappings.  Without assistance from some hardware reporting mechanism
(SMBIOS, ACPI, etc.) there is no reliable way to determine the numa node
for a PCI bridge or device.  Typically this numa mapping is done via the
ACPI _PXM values in the ACPI tables, however, there are many systems out
there that do not populate the ACPI _PXM entries and therefore do not have
correct PCI device numa_node values.

Hardware vendors are accepting of reported bugs for the ACPI _PXM entries,
but production fixes are typically seen in 6 months to a year and in
some past cases, never.

This patch introduces a mechanism to allow a user that knows the correct
value of the numa node to set it via sysfs.  As suggested by Alexander
and Bjorn, the setting of the value issues a loud FW_BUG message and
TAINTS notify the user that the issue really is a firmware bug.

To use this, one can do

echo 3 > /sys/devices/pci0000:ff/0000:03:1f.3/numa_node

to set the numa node for PCI device 0000:03:1f.3.

Cc: Myron Stowe <mstowe@redhat.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Alexander Ducyk <alexander.h.duyck@redhat.com>
Cc: Jiang Liu <jiang.liu@linux.intel.com>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Prarit Bhargava <prarit@redhat.com>

[v2]: add warning about broken BIOS, rework message after attempting
to determine numa node on a wide number of broken systems, add
Documentation.
---
 Documentation/ABI/testing/sysfs-bus-pci |   13 +++++++++++++
 drivers/pci/pci-sysfs.c                 |   29 ++++++++++++++++++++++++++++-
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index ee6c040..76007b3 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -281,3 +281,16 @@ Description:
 		opt-out of driver binding using a driver_override name such as
 		"none".  Only a single driver may be specified in the override,
 		there is no support for parsing delimiters.
+
+What:		/sys/bus/pci/devices/.../numa_node
+Date:		Oct 2014
+Contact:	Prarit Bhargava <prarit@redhat.com>
+Description:
+		This file contains the value of the NUMA node that the PCI
+		device is attached to, or -1 if the device is attached to
+		multiple nodes.  The file can be written to to override the
+		value if the user determines that the system's firmware has
+		provided an incorrect value.  If this file is written to
+		the user should report a firmware bug to the system vendor.
+		Writing to this file will result in kernel taint of
+		TAINT_FIRMWARE_WORKAROUND.
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 92b6d9a..e5a4664 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -221,12 +221,39 @@ static ssize_t enabled_show(struct device *dev, struct device_attribute *attr,
 static DEVICE_ATTR_RW(enabled);
 
 #ifdef CONFIG_NUMA
+static ssize_t numa_node_store(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buf, size_t count)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	int node, ret;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	ret = kstrtoint(buf, 0, &node);
+	if (ret)
+		return ret;
+
+	if (!node_online(node))
+		return -EINVAL;
+
+	add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_STILL_OK);
+	dev_alert(&pdev->dev,
+		  FW_BUG "Overriding NUMA node to %d.  Contact your vendor for updates.",
+		  node);
+
+	dev->numa_node = node;
+
+	return count;
+}
+
 static ssize_t numa_node_show(struct device *dev, struct device_attribute *attr,
 			      char *buf)
 {
 	return sprintf(buf, "%d\n", dev->numa_node);
 }
-static DEVICE_ATTR_RO(numa_node);
+static DEVICE_ATTR_RW(numa_node);
 #endif
 
 static ssize_t dma_mask_bits_show(struct device *dev,
-- 
1.7.9.3

