Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:40770 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752611AbeCMVbi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Mar 2018 17:31:38 -0400
Subject: [pci PATCH v6 5/5] pci-pf-stub: Add PF driver stub for PFs that
 function only to enable VFs
From: Alexander Duyck <alexander.duyck@gmail.com>
To: bhelgaas@google.com, alexander.h.duyck@intel.com,
        linux-pci@vger.kernel.org
Cc: virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org,
        netdev@vger.kernel.org, dan.daly@intel.com,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        keith.busch@intel.com, netanel@amazon.com, ddutile@redhat.com,
        mheyne@amazon.de, liang-min.wang@intel.com,
        mark.d.rustad@intel.com, dwmw2@infradead.org, hch@lst.de,
        dwmw@amazon.co.uk
Date: Tue, 13 Mar 2018 14:31:36 -0700
Message-ID: <20180313213054.3553.89366.stgit@localhost.localdomain>
In-Reply-To: <20180313212508.3553.65326.stgit@localhost.localdomain>
References: <20180313212508.3553.65326.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Alexander Duyck <alexander.h.duyck@intel.com>

Add a new driver called "pci-pf-stub" to act as a "white-list" for PF
devices that provide no other functionality other then acting as a means of
allocating a set of VFs. For now I only have one example ID provided by
Amazon in terms of devices that require this functionality. The general
idea is that in the future we will see other devices added as vendors come
up with devices where the PF is more or less just a lightweight shim used
to allocate VFs.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---

v6: New driver to address concerns about Amazon devices left unsupported

 drivers/pci/Kconfig       |   12 +++++++++
 drivers/pci/Makefile      |    2 ++
 drivers/pci/pci-pf-stub.c |   60 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci_ids.h   |    2 ++
 4 files changed, 76 insertions(+)
 create mode 100644 drivers/pci/pci-pf-stub.c

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 34b56a8f8480..cdef2a2a9bc5 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -71,6 +71,18 @@ config PCI_STUB
 
 	  When in doubt, say N.
 
+config PCI_PF_STUB
+	tristate "PCI PF Stub driver"
+	depends on PCI
+	depends on PCI_IOV
+	help
+	  Say Y or M here if you want to enable support for devices that
+	  require SR-IOV support, while at the same time the PF itself is
+	  not providing any actual services on the host itself such as
+	  storage or networking.
+
+	  When in doubt, say N.
+
 config XEN_PCIDEV_FRONTEND
         tristate "Xen PCI Frontend"
         depends on PCI && X86 && XEN
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 941970936840..4e133d3df403 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -43,6 +43,8 @@ obj-$(CONFIG_PCI_SYSCALL) += syscall.o
 
 obj-$(CONFIG_PCI_STUB) += pci-stub.o
 
+obj-$(CONFIG_PCI_PF_STUB) += pci-pf-stub.o
+
 obj-$(CONFIG_PCI_ECAM) += ecam.o
 
 obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
diff --git a/drivers/pci/pci-pf-stub.c b/drivers/pci/pci-pf-stub.c
new file mode 100644
index 000000000000..d218924d9bdb
--- /dev/null
+++ b/drivers/pci/pci-pf-stub.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0
+/* pci-pf-stub - simple stub driver for PCI SR-IOV PF device
+ *
+ * This driver is meant to act as a "white-list" for devices that provde
+ * SR-IOV functionality while at the same time not actually needing a
+ * driver of their own.
+ */
+
+#include <linux/module.h>
+#include <linux/pci.h>
+
+/**
+ * pci_pf_stub_white_list - White list of devices to bind pci-pf-stub onto
+ *
+ * This table provides the list of IDs this driver is supposed to bind
+ * onto. You could think of this as a list of "quirked" devices where we
+ * are adding support for SR-IOV here since there are no other drivers
+ * that they would be running under.
+ *
+ * Layout of the table below is as follows:
+ * { Vendor ID, Device ID,
+ *   SubVendor ID, SubDevice ID,
+ *   Class, Class Mask,
+ *   private data (not used) }
+ */
+static const struct pci_device_id pci_pf_stub_white_list[] = {
+	{ PCI_VDEVICE(AMAZON, 0x0053) },
+	/* required last entry */
+	{ 0 }
+};
+MODULE_DEVICE_TABLE(pci, pci_pf_stub_white_list);
+
+static int pci_pf_stub_probe(struct pci_dev *dev,
+			     const struct pci_device_id *id)
+{
+	pci_info(dev, "claimed by pci-pf-stub\n");
+	return 0;
+}
+
+static struct pci_driver pf_stub_driver = {
+	.name			= "pci-pf-stub",
+	.id_table		= pci_pf_stub_white_list,
+	.probe			= pci_pf_stub_probe,
+	.sriov_configure	= pci_sriov_configure_simple,
+};
+
+static int __init pci_pf_stub_init(void)
+{
+	return pci_register_driver(&pf_stub_driver);
+}
+
+static void __exit pci_pf_stub_exit(void)
+{
+	pci_unregister_driver(&pf_stub_driver);
+}
+
+module_init(pci_pf_stub_init);
+module_exit(pci_pf_stub_exit);
+
+MODULE_LICENSE("GPL");
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index a6b30667a331..b10621896017 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2548,6 +2548,8 @@
 #define PCI_VENDOR_ID_CIRCUITCO		0x1cc8
 #define PCI_SUBSYSTEM_ID_CIRCUITCO_MINNOWBOARD	0x0001
 
+#define PCI_VENDOR_ID_AMAZON		0x1d0f
+
 #define PCI_VENDOR_ID_TEKRAM		0x1de1
 #define PCI_DEVICE_ID_TEKRAM_DC290	0xdc29
 
