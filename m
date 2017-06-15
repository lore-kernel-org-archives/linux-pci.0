Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:58904 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751795AbdFOUhp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Jun 2017 16:37:45 -0400
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-ntb@googlegroups.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <Allen.Hubbe@emc.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Stephen Bates <sbates@raithlin.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date: Thu, 15 Jun 2017 14:37:21 -0600
Message-Id: <20170615203729.9009-6-logang@deltatee.com>
In-Reply-To: <20170615203729.9009-1-logang@deltatee.com>
References: <20170615203729.9009-1-logang@deltatee.com>
Subject: [RFC PATCH 05/13] switchtec_ntb: introduce initial ntb driver
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Seeing the switchtec NTB hardware shares the same endpoint as the
management endpoint we utilize the class_interface api to register
an NTB driver for every switchtec device in the system that has the
NTB class code.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Stephen Bates <sbates@raithlin.com>
Reviewed-by: Kurt Schwemmer <kurt.schwemmer@microsemi.com>
---
 MAINTAINERS                         |  1 +
 drivers/ntb/hw/Kconfig              |  1 +
 drivers/ntb/hw/Makefile             |  1 +
 drivers/ntb/hw/mscc/Kconfig         |  9 +++++
 drivers/ntb/hw/mscc/Makefile        |  1 +
 drivers/ntb/hw/mscc/switchtec_ntb.c | 81 +++++++++++++++++++++++++++++++++++++
 include/linux/switchtec.h           |  4 ++
 7 files changed, 98 insertions(+)
 create mode 100644 drivers/ntb/hw/mscc/Kconfig
 create mode 100644 drivers/ntb/hw/mscc/Makefile
 create mode 100644 drivers/ntb/hw/mscc/switchtec_ntb.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 6cee5e253ec3..fbd88be1be03 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9842,6 +9842,7 @@ F:	Documentation/ABI/testing/sysfs-class-switchtec
 F:	drivers/pci/switch/switchtec*
 F:	include/uapi/linux/switchtec_ioctl.h
 F:	include/linux/switchtec.h
+F:	drivers/ntb/hw/mscc/
 
 PCI DRIVER FOR NVIDIA TEGRA
 M:	Thierry Reding <thierry.reding@gmail.com>
diff --git a/drivers/ntb/hw/Kconfig b/drivers/ntb/hw/Kconfig
index 7116472b4625..1d1360db87e1 100644
--- a/drivers/ntb/hw/Kconfig
+++ b/drivers/ntb/hw/Kconfig
@@ -1,2 +1,3 @@
 source "drivers/ntb/hw/amd/Kconfig"
 source "drivers/ntb/hw/intel/Kconfig"
+source "drivers/ntb/hw/mscc/Kconfig"
diff --git a/drivers/ntb/hw/Makefile b/drivers/ntb/hw/Makefile
index 532e0859b4a1..690c00274174 100644
--- a/drivers/ntb/hw/Makefile
+++ b/drivers/ntb/hw/Makefile
@@ -1,2 +1,3 @@
 obj-$(CONFIG_NTB_AMD)	+= amd/
 obj-$(CONFIG_NTB_INTEL)	+= intel/
+obj-$(CONFIG_NTB_SWITCHTEC) += mscc/
diff --git a/drivers/ntb/hw/mscc/Kconfig b/drivers/ntb/hw/mscc/Kconfig
new file mode 100644
index 000000000000..013ed6716438
--- /dev/null
+++ b/drivers/ntb/hw/mscc/Kconfig
@@ -0,0 +1,9 @@
+config NTB_SWITCHTEC
+	tristate "MicroSemi Switchtec Non-Transparent Bridge Support"
+	select PCI_SW_SWITCHTEC
+	help
+	 Enables NTB support for Switchtec PCI switches. This also
+	 selects the Switchtec management driver as they share the same
+	 hardware interface.
+
+	 If unsure, say N.
diff --git a/drivers/ntb/hw/mscc/Makefile b/drivers/ntb/hw/mscc/Makefile
new file mode 100644
index 000000000000..21907b364e19
--- /dev/null
+++ b/drivers/ntb/hw/mscc/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_NTB_SWITCHTEC) += switchtec_ntb.o
diff --git a/drivers/ntb/hw/mscc/switchtec_ntb.c b/drivers/ntb/hw/mscc/switchtec_ntb.c
new file mode 100644
index 000000000000..1f094216aa1c
--- /dev/null
+++ b/drivers/ntb/hw/mscc/switchtec_ntb.c
@@ -0,0 +1,81 @@
+/*
+ * Microsemi Switchtec(tm) PCIe Management Driver
+ * Copyright (c) 2017, Microsemi Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ */
+
+#include <linux/switchtec.h>
+#include <linux/module.h>
+
+MODULE_DESCRIPTION("Microsemi Switchtec(tm) NTB Driver");
+MODULE_VERSION("0.1");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Microsemi Corporation");
+
+struct switchtec_ntb {
+	struct switchtec_dev *stdev;
+};
+
+static int switchtec_ntb_add(struct device *dev,
+			     struct class_interface *class_intf)
+{
+	struct switchtec_dev *stdev = to_stdev(dev);
+	struct switchtec_ntb *sndev;
+
+	stdev->sndev = NULL;
+
+	if (stdev->pdev->class != MICROSEMI_NTB_CLASSCODE)
+		return -ENODEV;
+
+	sndev = kzalloc_node(sizeof(*sndev), GFP_KERNEL, dev_to_node(dev));
+	if (!sndev)
+		return -ENOMEM;
+
+	sndev->stdev = stdev;
+
+	stdev->sndev = sndev;
+	dev_info(dev, "NTB device registered");
+
+	return 0;
+}
+
+void switchtec_ntb_remove(struct device *dev,
+			  struct class_interface *class_intf)
+{
+	struct switchtec_dev *stdev = to_stdev(dev);
+	struct switchtec_ntb *sndev = stdev->sndev;
+
+	if (!sndev)
+		return;
+
+	stdev->sndev = NULL;
+	kfree(sndev);
+	dev_info(dev, "ntb device unregistered");
+}
+
+static struct class_interface switchtec_interface  = {
+	.class = &switchtec_class,
+	.add_dev = switchtec_ntb_add,
+	.remove_dev = switchtec_ntb_remove,
+};
+
+static int __init switchtec_ntb_init(void)
+{
+	return class_interface_register(&switchtec_interface);
+}
+module_init(switchtec_ntb_init);
+
+static void __exit switchtec_ntb_exit(void)
+{
+	class_interface_unregister(&switchtec_interface);
+}
+module_exit(switchtec_ntb_exit);
diff --git a/include/linux/switchtec.h b/include/linux/switchtec.h
index 8d66a0659cef..0a7d0ed77507 100644
--- a/include/linux/switchtec.h
+++ b/include/linux/switchtec.h
@@ -312,6 +312,8 @@ struct pff_csr_regs {
 	u32 reserved4[174];
 } __packed;
 
+struct switchtec_ntb;
+
 struct switchtec_dev {
 	struct pci_dev *pdev;
 	struct device dev;
@@ -349,6 +351,8 @@ struct switchtec_dev {
 	struct work_struct link_event_work;
 	struct blocking_notifier_head link_notifier;
 	u8 link_event_count[SWITCHTEC_MAX_PFF_CSR];
+
+	struct switchtec_ntb *sndev;
 };
 
 static inline struct switchtec_dev *to_stdev(struct device *dev)
-- 
2.11.0
