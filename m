Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Allen Hubbe <Allen.Hubbe@emc.com>
To: linux-ntb@googlegroups.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <Allen.Hubbe@emc.com>
Subject: [PATCH 02/16] NTB Abstraction Layer
Date: Wed, 20 May 2015 11:41:03 -0400
Message-Id: <d653819e0ebc03241fe073c9239be36a52f5e265.1432135631.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1432135631.git.Allen.Hubbe@emc.com>
References: <cover.1432135631.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1432135631.git.Allen.Hubbe@emc.com>
References: <cover.1432135631.git.Allen.Hubbe@emc.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Abstract the ntb device behind a programming interface, so that it can
support different hardware.  Change the intel hardware driver to fit the
abstraction.

Expose the ntb hardware api to client drivers instead of tying it to
ntb_transport.  Make ntb_transport a client of the ntb hardware api.

Signed-off-by: Allen Hubbe <Allen.Hubbe@emc.com>
---
 Documentation/ntb.txt               |   58 +
 MAINTAINERS                         |   14 +-
 drivers/net/ntb_netdev.c            |   58 +-
 drivers/ntb/Kconfig                 |   20 +-
 drivers/ntb/Makefile                |    4 +-
 drivers/ntb/hw/Kconfig              |    1 +
 drivers/ntb/hw/Makefile             |    1 +
 drivers/ntb/hw/intel/Kconfig        |    8 +
 drivers/ntb/hw/intel/Makefile       |    1 +
 drivers/ntb/hw/intel/ntb_hw_intel.c | 3108 +++++++++++++++++++----------------
 drivers/ntb/hw/intel/ntb_hw_intel.h |  591 +++----
 drivers/ntb/ntb.c                   |  251 +++
 drivers/ntb/ntb_transport.c         |  927 ++++++-----
 include/linux/ntb.h                 |  983 +++++++++++
 include/linux/ntb_transport.h       |   25 +-
 15 files changed, 3873 insertions(+), 2177 deletions(-)
 create mode 100644 Documentation/ntb.txt
 create mode 100644 drivers/ntb/hw/Kconfig
 create mode 100644 drivers/ntb/hw/Makefile
 create mode 100644 drivers/ntb/hw/intel/Kconfig
 create mode 100644 drivers/ntb/hw/intel/Makefile
 create mode 100644 drivers/ntb/ntb.c
 create mode 100644 include/linux/ntb.h

diff --git a/Documentation/ntb.txt b/Documentation/ntb.txt
new file mode 100644
index 0000000..725ba1e
--- /dev/null
+++ b/Documentation/ntb.txt
@@ -0,0 +1,58 @@
+# NTB Drivers
+
+NTB (Non-Transparent Bridge) is a type of PCI-Express bridge chip that connects
+the separate memory systems of two computers to the same PCI-Express fabric.
+Existing NTB hardware supports a common feature set, including scratchpad
+registers, doorbell registers, and memory translation windows.  Scratchpad
+registers are read-and-writable registers that are accessible from either side
+of the device, so that peers can exchange a small amount of information at a
+fixed address.  Doorbell registers provide a way for peers to send interrupt
+events.  Memory windows allow translated read and write access to the peer
+memory.
+
+## NTB Core Driver (ntb)
+
+The NTB core driver defines an api wrapping the common feature set, and allows
+clients interested in NTB features to discover NTB the devices supported by
+hardware drivers.  The term "client" is used here to mean an upper layer
+component making use of the NTB api.  The term "driver," or "hardware driver,"
+is used here to mean a driver for a specific vendor and model of NTB hardware.
+
+## NTB Client Drivers
+
+NTB client drivers should register with the NTB core driver.  After
+registering, the client probe and remove functions will be called appropriately
+as ntb hardware, or hardware drivers, are inserted and removed.  The
+registration uses the Linux Device framework, so it should feel familiar to
+anyone who has written a pci driver.
+
+### NTB Transport Client (ntb\_transport) and NTB Netdev (ntb\_netdev)
+
+The primary client for NTB is the Transport client, used in tandem with NTB
+Netdev.  These drivers function together to create a logical link to the peer,
+across the ntb, to exchange packets of network data.  The Transport client
+establishes a logical link to the peer, and creates queue pairs to exchange
+messages and data.  The NTB Netdev then creates an ethernet device using a
+Transport queue pair.  Network data is copied between socket buffers and the
+Transport queue pair buffer.  The Transport client may be used for other things
+besides Netdev, however no other applications have yet been written.
+
+## NTB Hardware Drivers
+
+NTB hardware drivers should register devices with the NTB core driver.  After
+registering, clients probe and remove functions will be called.
+
+### NTB Intel Hardware Driver (ntb\_hw\_intel)
+
+The Intel hardware driver supports NTB on Xeon and Atom CPUs.
+
+Module Parameters:
+
+* b2b\_mw\_idx - If the peer ntb is to be accessed via a memory window, then use
+	this memory window to access the peer ntb.  A value of zero or positive
+	starts from the first mw idx, and a negative value starts from the last
+	mw idx.  Both sides MUST set the same value here!  The default value is
+	`-1`.
+* b2b\_mw\_share - If the peer ntb is to be accessed via a memory window, and if
+	the memory window is large enough, still allow the client to use the
+	second half of the memory window for address translation to the peer.
diff --git a/MAINTAINERS b/MAINTAINERS
index 2e5bbc0..2560e18 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6943,7 +6943,7 @@ T:	git git://git.rocketboards.org/linux-socfpga-next.git
 S:	Maintained
 F:	arch/nios2/
 
-NTB DRIVER
+NTB DRIVER CORE
 M:	Jon Mason <jdmason@kudzu.us>
 M:	Dave Jiang <dave.jiang@intel.com>
 S:	Supported
@@ -6951,7 +6951,19 @@ W:	https://github.com/jonmason/ntb/wiki
 T:	git git://github.com/jonmason/ntb.git
 F:	drivers/ntb/
 F:	drivers/net/ntb_netdev.c
+F:	drivers/ntb/ntb.c
+F:	drivers/ntb/ntb_transport.c
 F:	include/linux/ntb.h
+F:	include/linux/ntb_transport.h
+
+NTB INTEL DRIVER
+M:	Jon Mason <jdmason@kudzu.us>
+M:	Dave Jiang <dave.jiang@intel.com>
+S:	Supported
+W:	https://github.com/jonmason/ntb/wiki
+T:	git git://github.com/jonmason/ntb.git
+F:	drivers/ntb/hw/intel/ntb_hw_intel.c
+F:	drivers/ntb/hw/intel/ntb_hw_intel.h
 
 NTFS FILESYSTEM
 M:	Anton Altaparmakov <anton@tuxera.com>
diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
index dcf8000..3cc316c 100644
--- a/drivers/net/ntb_netdev.c
+++ b/drivers/net/ntb_netdev.c
@@ -5,6 +5,7 @@
  *   GPL LICENSE SUMMARY
  *
  *   Copyright(c) 2012 Intel Corporation. All rights reserved.
+ *   Copyright (C) 2015 EMC Corporation. All Rights Reserved.
  *
  *   This program is free software; you can redistribute it and/or modify
  *   it under the terms of version 2 of the GNU General Public License as
@@ -13,6 +14,7 @@
  *   BSD LICENSE
  *
  *   Copyright(c) 2012 Intel Corporation. All rights reserved.
+ *   Copyright (C) 2015 EMC Corporation. All Rights Reserved.
  *
  *   Redistribution and use in source and binary forms, with or without
  *   modification, are permitted provided that the following conditions
@@ -40,7 +42,7 @@
  *   (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
  *   OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  *
- * Intel PCIe NTB Network Linux driver
+ * PCIe NTB Network Linux driver
  *
  * Contact Information:
  * Jon Mason <jon.mason@intel.com>
@@ -49,6 +51,7 @@
 #include <linux/ethtool.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/ntb.h>
 #include <linux/ntb_transport.h>
 
 #define NTB_NETDEV_VER	"0.7"
@@ -70,26 +73,19 @@ struct ntb_netdev {
 
 static LIST_HEAD(dev_list);
 
-static void ntb_netdev_event_handler(void *data, int status)
+static void ntb_netdev_event_handler(void *data, int link_is_up)
 {
 	struct net_device *ndev = data;
 	struct ntb_netdev *dev = netdev_priv(ndev);
 
-	netdev_dbg(ndev, "Event %x, Link %x\n", status,
+	netdev_dbg(ndev, "Event %x, Link %x\n", link_is_up,
 		   ntb_transport_link_query(dev->qp));
 
-	switch (status) {
-	case NTB_LINK_DOWN:
+	if (link_is_up) {
+		if (ntb_transport_link_query(dev->qp))
+			netif_carrier_on(ndev);
+	} else {
 		netif_carrier_off(ndev);
-		break;
-	case NTB_LINK_UP:
-		if (!ntb_transport_link_query(dev->qp))
-			return;
-
-		netif_carrier_on(ndev);
-		break;
-	default:
-		netdev_warn(ndev, "Unsupported event type %d\n", status);
 	}
 }
 
@@ -160,8 +156,6 @@ static netdev_tx_t ntb_netdev_start_xmit(struct sk_buff *skb,
 	struct ntb_netdev *dev = netdev_priv(ndev);
 	int rc;
 
-	netdev_dbg(ndev, "%s: skb len %d\n", __func__, skb->len);
-
 	rc = ntb_transport_tx_enqueue(dev->qp, skb, skb->data, skb->len);
 	if (rc)
 		goto err;
@@ -322,20 +316,26 @@ static const struct ntb_queue_handlers ntb_netdev_handlers = {
 	.event_handler = ntb_netdev_event_handler,
 };
 
-static int ntb_netdev_probe(struct pci_dev *pdev)
+static int ntb_netdev_probe(struct device *client_dev)
 {
+	struct ntb_dev *ntb;
 	struct net_device *ndev;
+	struct pci_dev *pdev;
 	struct ntb_netdev *dev;
 	int rc;
 
-	ndev = alloc_etherdev(sizeof(struct ntb_netdev));
+	ntb = dev_ntb(client_dev->parent);
+	pdev = ntb->pdev;
+	if (!pdev)
+		return -ENODEV;
+
+	ndev = alloc_etherdev(sizeof(*dev));
 	if (!ndev)
 		return -ENOMEM;
 
 	dev = netdev_priv(ndev);
 	dev->ndev = ndev;
 	dev->pdev = pdev;
-	BUG_ON(!dev->pdev);
 	ndev->features = NETIF_F_HIGHDMA;
 
 	ndev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
@@ -349,7 +349,8 @@ static int ntb_netdev_probe(struct pci_dev *pdev)
 	ndev->netdev_ops = &ntb_netdev_ops;
 	ndev->ethtool_ops = &ntb_ethtool_ops;
 
-	dev->qp = ntb_transport_create_queue(ndev, pdev, &ntb_netdev_handlers);
+	dev->qp = ntb_transport_create_queue(ndev, client_dev,
+					     &ntb_netdev_handlers);
 	if (!dev->qp) {
 		rc = -EIO;
 		goto err;
@@ -372,12 +373,17 @@ err:
 	return rc;
 }
 
-static void ntb_netdev_remove(struct pci_dev *pdev)
+static void ntb_netdev_remove(struct device *client_dev)
 {
+	struct ntb_dev *ntb;
 	struct net_device *ndev;
+	struct pci_dev *pdev;
 	struct ntb_netdev *dev;
 	bool found = false;
 
+	ntb = dev_ntb(client_dev->parent);
+	pdev = ntb->pdev;
+
 	list_for_each_entry(dev, &dev_list, list) {
 		if (dev->pdev == pdev) {
 			found = true;
@@ -396,7 +402,7 @@ static void ntb_netdev_remove(struct pci_dev *pdev)
 	free_netdev(ndev);
 }
 
-static struct ntb_client ntb_netdev_client = {
+static struct ntb_transport_client ntb_netdev_client = {
 	.driver.name = KBUILD_MODNAME,
 	.driver.owner = THIS_MODULE,
 	.probe = ntb_netdev_probe,
@@ -407,16 +413,16 @@ static int __init ntb_netdev_init_module(void)
 {
 	int rc;
 
-	rc = ntb_register_client_dev(KBUILD_MODNAME);
+	rc = ntb_transport_register_client_dev(KBUILD_MODNAME);
 	if (rc)
 		return rc;
-	return ntb_register_client(&ntb_netdev_client);
+	return ntb_transport_register_client(&ntb_netdev_client);
 }
 module_init(ntb_netdev_init_module);
 
 static void __exit ntb_netdev_exit_module(void)
 {
-	ntb_unregister_client(&ntb_netdev_client);
-	ntb_unregister_client_dev(KBUILD_MODNAME);
+	ntb_transport_unregister_client(&ntb_netdev_client);
+	ntb_transport_unregister_client_dev(KBUILD_MODNAME);
 }
 module_exit(ntb_netdev_exit_module);
diff --git a/drivers/ntb/Kconfig b/drivers/ntb/Kconfig
index f69df793..988b03d 100644
--- a/drivers/ntb/Kconfig
+++ b/drivers/ntb/Kconfig
@@ -1,7 +1,6 @@
-config NTB
-       tristate "Intel Non-Transparent Bridge support"
+menuconfig NTB
+       tristate "Non-Transparent Bridge support"
        depends on PCI
-       depends on X86
        help
         The PCI-E Non-transparent bridge hardware is a point-to-point PCI-E bus
         connecting 2 systems.  When configured, writes to the device's PCI
@@ -11,3 +10,18 @@ config NTB
 
         If unsure, say N.
 
+if NTB
+
+source "drivers/ntb/hw/Kconfig"
+
+config NTB_TRANSPORT
+       tristate "NTB Transport Client"
+       depends on NTB
+       help
+        This is a transport driver that enables connected systems to exchange
+        messages over the ntb hardware.  The transport exposes a queue pair api
+        to client drivers.
+
+        If unsure, say N.
+
+endif # NTB
diff --git a/drivers/ntb/Makefile b/drivers/ntb/Makefile
index 17f0309..671c4e6 100644
--- a/drivers/ntb/Makefile
+++ b/drivers/ntb/Makefile
@@ -1,3 +1,3 @@
+obj-y += hw/
 obj-$(CONFIG_NTB) += ntb.o
-
-ntb-objs := hw/intel/ntb_hw_intel.o ntb_transport.o
+obj-$(CONFIG_NTB_TRANSPORT) += ntb_transport.o
diff --git a/drivers/ntb/hw/Kconfig b/drivers/ntb/hw/Kconfig
new file mode 100644
index 0000000..4d5535c
--- /dev/null
+++ b/drivers/ntb/hw/Kconfig
@@ -0,0 +1 @@
+source "drivers/ntb/hw/intel/Kconfig"
diff --git a/drivers/ntb/hw/Makefile b/drivers/ntb/hw/Makefile
new file mode 100644
index 0000000..175d7c9
--- /dev/null
+++ b/drivers/ntb/hw/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_NTB_INTEL)	+= intel/
diff --git a/drivers/ntb/hw/intel/Kconfig b/drivers/ntb/hw/intel/Kconfig
new file mode 100644
index 0000000..85de2e8
--- /dev/null
+++ b/drivers/ntb/hw/intel/Kconfig
@@ -0,0 +1,8 @@
+config NTB_INTEL
+       tristate "Intel Non-Transparent Bridge support"
+       depends on NTB
+       depends on X86
+       help
+        This driver supports Intel NTB on capable Xeon and Atom hardware.
+
+        If unsure, say N.
diff --git a/drivers/ntb/hw/intel/Makefile b/drivers/ntb/hw/intel/Makefile
new file mode 100644
index 0000000..1b43456
--- /dev/null
+++ b/drivers/ntb/hw/intel/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_NTB_INTEL) += ntb_hw_intel.o
diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.c b/drivers/ntb/hw/intel/ntb_hw_intel.c
index 9ce4148..05c4b77 100644
--- a/drivers/ntb/hw/intel/ntb_hw_intel.c
+++ b/drivers/ntb/hw/intel/ntb_hw_intel.c
@@ -5,6 +5,7 @@
  *   GPL LICENSE SUMMARY
  *
  *   Copyright(c) 2012 Intel Corporation. All rights reserved.
+ *   Copyright (C) 2015 EMC Corporation. All Rights Reserved.
  *
  *   This program is free software; you can redistribute it and/or modify
  *   it under the terms of version 2 of the GNU General Public License as
@@ -13,6 +14,7 @@
  *   BSD LICENSE
  *
  *   Copyright(c) 2012 Intel Corporation. All rights reserved.
+ *   Copyright (C) 2015 EMC Corporation. All Rights Reserved.
  *
  *   Redistribution and use in source and binary forms, with or without
  *   modification, are permitted provided that the following conditions
@@ -45,6 +47,7 @@
  * Contact Information:
  * Jon Mason <jon.mason@intel.com>
  */
+
 #include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/init.h>
@@ -53,99 +56,97 @@
 #include <linux/pci.h>
 #include <linux/random.h>
 #include <linux/slab.h>
+#include <linux/ntb.h>
+
 #include "ntb_hw_intel.h"
 
-#define NTB_NAME	"Intel(R) PCI-E Non-Transparent Bridge Driver"
-#define NTB_VER		"1.0"
+#define NTB_NAME	"ntb_hw_intel"
+#define NTB_DESC	"Intel(R) PCI-E Non-Transparent Bridge Driver"
+#define NTB_VER		"2.0"
 
-MODULE_DESCRIPTION(NTB_NAME);
+MODULE_DESCRIPTION(NTB_DESC);
 MODULE_VERSION(NTB_VER);
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_AUTHOR("Intel Corporation");
 
-enum {
-	NTB_CONN_TRANSPARENT = 0,
-	NTB_CONN_B2B,
-	NTB_CONN_RP,
-};
-
-enum {
-	NTB_DEV_USD = 0,
-	NTB_DEV_DSD,
-};
-
-enum {
-	SNB_HW = 0,
-	BWD_HW,
-};
-
+#define bar0_off(base, bar) ((base) + ((bar) << 2))
+#define bar2_off(base, bar) bar0_off(base, (bar) - 2)
+
+static int b2b_mw_idx = -1;
+module_param(b2b_mw_idx, int, 0644);
+MODULE_PARM_DESC(b2b_mw_idx, "Use this mw idx to access the peer ntb.  A "
+		 "value of zero or positive starts from first mw idx, and a "
+		 "negative value starts from last mw idx.  Both sides MUST "
+		 "set the same value here!");
+
+static unsigned int b2b_mw_share;
+module_param(b2b_mw_share, uint, 0644);
+MODULE_PARM_DESC(b2b_mw_share, "If the b2b mw is large enough, configure the "
+		 "ntb so that the peer ntb only occupies the first half of "
+		 "the mw, so the second half can still be used as a mw.  Both "
+		 "sides MUST set the same value here!");
+
+static const struct intel_ntb_reg bwd_reg;
+static const struct intel_ntb_alt_reg bwd_pri_reg;
+static const struct intel_ntb_alt_reg bwd_sec_reg;
+static const struct intel_ntb_alt_reg bwd_b2b_reg;
+static const struct intel_ntb_xlat_reg bwd_pri_xlat;
+static const struct intel_ntb_xlat_reg bwd_sec_xlat;
+static const struct intel_ntb_reg snb_reg;
+static const struct intel_ntb_alt_reg snb_pri_reg;
+static const struct intel_ntb_alt_reg snb_sec_reg;
+static const struct intel_ntb_alt_reg snb_b2b_reg;
+static const struct intel_ntb_xlat_reg snb_pri_xlat;
+static const struct intel_ntb_xlat_reg snb_sec_xlat;
+static const struct intel_b2b_addr snb_b2b_usd_addr;
+static const struct intel_b2b_addr snb_b2b_dsd_addr;
+
+static const struct ntb_dev_ops intel_ntb_ops;
+
+static const struct file_operations intel_ntb_debugfs_info;
 static struct dentry *debugfs_dir;
 
-#define BWD_LINK_RECOVERY_TIME	500
-
-/* Translate memory window 0,1,2 to BAR 2,4,5 */
-#define MW_TO_BAR(mw)	(mw == 0 ? 2 : (mw == 1 ? 4 : 5))
-
-static const struct pci_device_id ntb_pci_tbl[] = {
-	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_NTB_B2B_BWD)},
-	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_NTB_B2B_JSF)},
-	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_NTB_B2B_SNB)},
-	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_NTB_B2B_IVT)},
-	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_NTB_B2B_HSX)},
-	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_NTB_PS_JSF)},
-	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_NTB_PS_SNB)},
-	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_NTB_PS_IVT)},
-	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_NTB_PS_HSX)},
-	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_NTB_SS_JSF)},
-	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_NTB_SS_SNB)},
-	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_NTB_SS_IVT)},
-	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_NTB_SS_HSX)},
-	{0}
-};
-MODULE_DEVICE_TABLE(pci, ntb_pci_tbl);
-
-static int is_ntb_xeon(struct ntb_device *ndev)
+#ifndef ioread64
+#ifdef readq
+#define ioread64 readq
+#else
+#define ioread64 _ioread64
+static inline u64 _ioread64(void __iomem *mmio)
 {
-	switch (ndev->pdev->device) {
-	case PCI_DEVICE_ID_INTEL_NTB_SS_JSF:
-	case PCI_DEVICE_ID_INTEL_NTB_SS_SNB:
-	case PCI_DEVICE_ID_INTEL_NTB_SS_IVT:
-	case PCI_DEVICE_ID_INTEL_NTB_SS_HSX:
-	case PCI_DEVICE_ID_INTEL_NTB_PS_JSF:
-	case PCI_DEVICE_ID_INTEL_NTB_PS_SNB:
-	case PCI_DEVICE_ID_INTEL_NTB_PS_IVT:
-	case PCI_DEVICE_ID_INTEL_NTB_PS_HSX:
-	case PCI_DEVICE_ID_INTEL_NTB_B2B_JSF:
-	case PCI_DEVICE_ID_INTEL_NTB_B2B_SNB:
-	case PCI_DEVICE_ID_INTEL_NTB_B2B_IVT:
-	case PCI_DEVICE_ID_INTEL_NTB_B2B_HSX:
-		return 1;
-	default:
-		return 0;
-	}
+	u64 low, high;
 
-	return 0;
+	low = ioread32(mmio);
+	high = ioread32(mmio + sizeof(u32));
+	return low | (high << 32);
+}
+#endif
+#endif
+
+#ifndef iowrite64
+#ifdef writeq
+#define iowrite64 writeq
+#else
+#define iowrite64 _iowrite64
+static inline void _iowrite64(u64 val, void __iomem *mmio)
+{
+	iowrite32(val, mmio);
+	iowrite32(val >> 32, mmio + sizeof(u32));
 }
+#endif
+#endif
 
-static int is_ntb_atom(struct ntb_device *ndev)
+static inline int pdev_is_bwd(struct pci_dev *pdev)
 {
-	switch (ndev->pdev->device) {
+	switch (pdev->device) {
 	case PCI_DEVICE_ID_INTEL_NTB_B2B_BWD:
 		return 1;
-	default:
-		return 0;
 	}
-
 	return 0;
 }
 
-static void ntb_set_errata_flags(struct ntb_device *ndev)
+static inline int pdev_is_snb(struct pci_dev *pdev)
 {
-	switch (ndev->pdev->device) {
-	/*
-	 * this workaround applies to all platform up to IvyBridge
-	 * Haswell has splitbar support and use a different workaround
-	 */
+	switch (pdev->device) {
 	case PCI_DEVICE_ID_INTEL_NTB_SS_JSF:
 	case PCI_DEVICE_ID_INTEL_NTB_SS_SNB:
 	case PCI_DEVICE_ID_INTEL_NTB_SS_IVT:
@@ -158,1738 +159,1995 @@ static void ntb_set_errata_flags(struct ntb_device *ndev)
 	case PCI_DEVICE_ID_INTEL_NTB_B2B_SNB:
 	case PCI_DEVICE_ID_INTEL_NTB_B2B_IVT:
 	case PCI_DEVICE_ID_INTEL_NTB_B2B_HSX:
-		ndev->wa_flags |= WA_SNB_ERR;
-		break;
+		return 1;
 	}
+	return 0;
 }
 
-/**
- * ntb_register_event_callback() - register event callback
- * @ndev: pointer to ntb_device instance
- * @func: callback function to register
- *
- * This function registers a callback for any HW driver events such as link
- * up/down, power management notices and etc.
- *
- * RETURNS: An appropriate -ERRNO error value on error, or zero for success.
- */
-int ntb_register_event_callback(struct ntb_device *ndev,
-				void (*func)(void *handle,
-					     enum ntb_hw_event event))
+static inline void ndev_reset_unsafe_flags(struct intel_ntb_dev *ndev)
 {
-	if (ndev->event_cb)
-		return -EINVAL;
-
-	ndev->event_cb = func;
-
-	return 0;
+	ndev->unsafe_flags = 0;
+	ndev->unsafe_flags_ignore = 0;
+
+	/* Only B2B has a workaround to avoid SDOORBELL */
+	if (ndev->hwerr_flags & NTB_HWERR_SDOORBELL_LOCKUP)
+		if (!ntb_topo_is_b2b(ndev->ntb.topo))
+			ndev->unsafe_flags |= NTB_UNSAFE_DB;
+
+	/* No low level workaround to avoid SB01BASE */
+	if (ndev->hwerr_flags & NTB_HWERR_SB01BASE_LOCKUP) {
+		ndev->unsafe_flags |= NTB_UNSAFE_DB;
+		ndev->unsafe_flags |= NTB_UNSAFE_SPAD;
+	}
 }
 
-/**
- * ntb_unregister_event_callback() - unregisters the event callback
- * @ndev: pointer to ntb_device instance
- *
- * This function unregisters the existing callback from transport
- */
-void ntb_unregister_event_callback(struct ntb_device *ndev)
+static inline int ndev_is_unsafe(struct intel_ntb_dev *ndev,
+				 unsigned long flag)
 {
-	ndev->event_cb = NULL;
+	return !!(flag & ndev->unsafe_flags & ~ndev->unsafe_flags_ignore);
 }
 
-static void ntb_irq_work(unsigned long data)
+static inline int ndev_ignore_unsafe(struct intel_ntb_dev *ndev,
+				     unsigned long flag)
 {
-	struct ntb_db_cb *db_cb = (struct ntb_db_cb *)data;
-	int rc;
+	flag &= ndev->unsafe_flags;
+	ndev->unsafe_flags_ignore |= flag;
 
-	rc = db_cb->callback(db_cb->data, db_cb->db_num);
-	if (rc)
-		tasklet_schedule(&db_cb->irq_work);
-	else {
-		struct ntb_device *ndev = db_cb->ndev;
-		unsigned long mask;
-
-		mask = readw(ndev->reg_ofs.ldb_mask);
-		clear_bit(db_cb->db_num * ndev->bits_per_vector, &mask);
-		writew(mask, ndev->reg_ofs.ldb_mask);
-	}
+	return !!flag;
 }
 
-/**
- * ntb_register_db_callback() - register a callback for doorbell interrupt
- * @ndev: pointer to ntb_device instance
- * @idx: doorbell index to register callback, zero based
- * @data: pointer to be returned to caller with every callback
- * @func: callback function to register
- *
- * This function registers a callback function for the doorbell interrupt
- * on the primary side. The function will unmask the doorbell as well to
- * allow interrupt.
- *
- * RETURNS: An appropriate -ERRNO error value on error, or zero for success.
- */
-int ntb_register_db_callback(struct ntb_device *ndev, unsigned int idx,
-			     void *data, int (*func)(void *data, int db_num))
+static int ndev_mw_to_bar(struct intel_ntb_dev *ndev, int idx)
 {
-	unsigned long mask;
-
-	if (idx >= ndev->max_cbs || ndev->db_cb[idx].callback) {
-		dev_warn(&ndev->pdev->dev, "Invalid Index.\n");
+	if (idx < 0 || idx > ndev->mw_count)
 		return -EINVAL;
-	}
+	return ndev->reg->mw_bar[idx];
+}
 
-	ndev->db_cb[idx].callback = func;
-	ndev->db_cb[idx].data = data;
-	ndev->db_cb[idx].ndev = ndev;
+static inline int ndev_db_addr(struct intel_ntb_dev *ndev,
+			       phys_addr_t *db_addr, resource_size_t *db_size,
+			       phys_addr_t reg_addr, unsigned long reg)
+{
+	WARN_ON_ONCE(ndev_is_unsafe(ndev, NTB_UNSAFE_DB));
 
-	tasklet_init(&ndev->db_cb[idx].irq_work, ntb_irq_work,
-		     (unsigned long) &ndev->db_cb[idx]);
+	if (db_addr) {
+		*db_addr = reg_addr + reg;
+		dev_dbg(ndev_dev(ndev), "Peer db addr %llx\n", *db_addr);
+	}
 
-	/* unmask interrupt */
-	mask = readw(ndev->reg_ofs.ldb_mask);
-	clear_bit(idx * ndev->bits_per_vector, &mask);
-	writew(mask, ndev->reg_ofs.ldb_mask);
+	if (db_size) {
+		*db_size = ndev->reg->db_size;
+		dev_dbg(ndev_dev(ndev), "Peer db size %llx\n", *db_size);
+	}
 
 	return 0;
 }
 
-/**
- * ntb_unregister_db_callback() - unregister a callback for doorbell interrupt
- * @ndev: pointer to ntb_device instance
- * @idx: doorbell index to register callback, zero based
- *
- * This function unregisters a callback function for the doorbell interrupt
- * on the primary side. The function will also mask the said doorbell.
- */
-void ntb_unregister_db_callback(struct ntb_device *ndev, unsigned int idx)
+static inline u64 ndev_db_read(struct intel_ntb_dev *ndev,
+			       void __iomem *mmio)
 {
-	unsigned long mask;
+	WARN_ON_ONCE(ndev_is_unsafe(ndev, NTB_UNSAFE_DB));
 
-	if (idx >= ndev->max_cbs || !ndev->db_cb[idx].callback)
-		return;
+	return ndev->reg->db_ioread(mmio);
+}
+
+static inline int ndev_db_write(struct intel_ntb_dev *ndev, u64 db_bits,
+				void __iomem *mmio)
+{
+	WARN_ON_ONCE(ndev_is_unsafe(ndev, NTB_UNSAFE_DB));
 
-	mask = readw(ndev->reg_ofs.ldb_mask);
-	set_bit(idx * ndev->bits_per_vector, &mask);
-	writew(mask, ndev->reg_ofs.ldb_mask);
+	if (db_bits & ~ndev->db_valid_mask)
+		return -EINVAL;
 
-	tasklet_disable(&ndev->db_cb[idx].irq_work);
+	ndev->reg->db_iowrite(db_bits, mmio);
 
-	ndev->db_cb[idx].callback = NULL;
+	return 0;
 }
 
-/**
- * ntb_find_transport() - find the transport pointer
- * @transport: pointer to pci device
- *
- * Given the pci device pointer, return the transport pointer passed in when
- * the transport attached when it was inited.
- *
- * RETURNS: pointer to transport.
- */
-void *ntb_find_transport(struct pci_dev *pdev)
+static inline int ndev_db_set_mask(struct intel_ntb_dev *ndev, u64 db_bits,
+				   void __iomem *mmio)
 {
-	struct ntb_device *ndev = pci_get_drvdata(pdev);
-	return ndev->ntb_transport;
-}
+	unsigned long irqflags;
 
-/**
- * ntb_register_transport() - Register NTB transport with NTB HW driver
- * @transport: transport identifier
- *
- * This function allows a transport to reserve the hardware driver for
- * NTB usage.
- *
- * RETURNS: pointer to ntb_device, NULL on error.
- */
-struct ntb_device *ntb_register_transport(struct pci_dev *pdev, void *transport)
-{
-	struct ntb_device *ndev = pci_get_drvdata(pdev);
+	WARN_ON_ONCE(ndev_is_unsafe(ndev, NTB_UNSAFE_DB));
+
+	if (db_bits & ~ndev->db_valid_mask)
+		return -EINVAL;
 
-	if (ndev->ntb_transport)
-		return NULL;
+	spin_lock_irqsave(&ndev->db_mask_lock, irqflags);
+	{
+		ndev->db_mask |= db_bits;
+		ndev->reg->db_iowrite(ndev->db_mask, mmio);
+	}
+	spin_unlock_irqrestore(&ndev->db_mask_lock, irqflags);
 
-	ndev->ntb_transport = transport;
-	return ndev;
+	return 0;
 }
 
-/**
- * ntb_unregister_transport() - Unregister the transport with the NTB HW driver
- * @ndev - ntb_device of the transport to be freed
- *
- * This function unregisters the transport from the HW driver and performs any
- * necessary cleanups.
- */
-void ntb_unregister_transport(struct ntb_device *ndev)
+static inline int ndev_db_clear_mask(struct intel_ntb_dev *ndev, u64 db_bits,
+				     void __iomem *mmio)
 {
-	int i;
+	unsigned long irqflags;
 
-	if (!ndev->ntb_transport)
-		return;
+	WARN_ON_ONCE(ndev_is_unsafe(ndev, NTB_UNSAFE_DB));
+
+	if (db_bits & ~ndev->db_valid_mask)
+		return -EINVAL;
 
-	for (i = 0; i < ndev->max_cbs; i++)
-		ntb_unregister_db_callback(ndev, i);
+	spin_lock_irqsave(&ndev->db_mask_lock, irqflags);
+	{
+		ndev->db_mask &= ~db_bits;
+		ndev->reg->db_iowrite(ndev->db_mask, mmio);
+	}
+	spin_unlock_irqrestore(&ndev->db_mask_lock, irqflags);
 
-	ntb_unregister_event_callback(ndev);
-	ndev->ntb_transport = NULL;
+	return 0;
 }
 
-/**
- * ntb_write_local_spad() - write to the secondary scratchpad register
- * @ndev: pointer to ntb_device instance
- * @idx: index to the scratchpad register, 0 based
- * @val: the data value to put into the register
- *
- * This function allows writing of a 32bit value to the indexed scratchpad
- * register. This writes over the data mirrored to the local scratchpad register
- * by the remote system.
- *
- * RETURNS: An appropriate -ERRNO error value on error, or zero for success.
- */
-int ntb_write_local_spad(struct ntb_device *ndev, unsigned int idx, u32 val)
+static inline int ndev_vec_mask(struct intel_ntb_dev *ndev, int db_vector)
 {
-	if (idx >= ndev->limits.max_spads)
-		return -EINVAL;
+	u64 shift, mask;
 
-	dev_dbg(&ndev->pdev->dev, "Writing %x to local scratch pad index %d\n",
-		val, idx);
-	writel(val, ndev->reg_ofs.spad_read + idx * 4);
+	shift = ndev->db_vec_shift;
+	mask = BIT_ULL(shift) - 1;
 
-	return 0;
+	return mask << (shift * db_vector);
 }
 
-/**
- * ntb_read_local_spad() - read from the primary scratchpad register
- * @ndev: pointer to ntb_device instance
- * @idx: index to scratchpad register, 0 based
- * @val: pointer to 32bit integer for storing the register value
- *
- * This function allows reading of the 32bit scratchpad register on
- * the primary (internal) side.  This allows the local system to read data
- * written and mirrored to the scratchpad register by the remote system.
- *
- * RETURNS: An appropriate -ERRNO error value on error, or zero for success.
- */
-int ntb_read_local_spad(struct ntb_device *ndev, unsigned int idx, u32 *val)
+static inline int ndev_spad_addr(struct intel_ntb_dev *ndev, int idx,
+				 phys_addr_t *spad_addr, phys_addr_t reg_addr,
+				 unsigned long reg)
 {
-	if (idx >= ndev->limits.max_spads)
+	WARN_ON_ONCE(ndev_is_unsafe(ndev, NTB_UNSAFE_DB));
+
+	if (idx < 0 || idx >= ndev->spad_count)
 		return -EINVAL;
 
-	*val = readl(ndev->reg_ofs.spad_write + idx * 4);
-	dev_dbg(&ndev->pdev->dev,
-		"Reading %x from local scratch pad index %d\n", *val, idx);
+	if (spad_addr) {
+		*spad_addr = reg_addr + reg + (idx << 2);
+		dev_dbg(ndev_dev(ndev), "Peer spad addr %llx\n", *spad_addr);
+	}
 
 	return 0;
 }
 
-/**
- * ntb_write_remote_spad() - write to the secondary scratchpad register
- * @ndev: pointer to ntb_device instance
- * @idx: index to the scratchpad register, 0 based
- * @val: the data value to put into the register
- *
- * This function allows writing of a 32bit value to the indexed scratchpad
- * register. The register resides on the secondary (external) side.  This allows
- * the local system to write data to be mirrored to the remote systems
- * scratchpad register.
- *
- * RETURNS: An appropriate -ERRNO error value on error, or zero for success.
- */
-int ntb_write_remote_spad(struct ntb_device *ndev, unsigned int idx, u32 val)
+static inline u32 ndev_spad_read(struct intel_ntb_dev *ndev, int idx,
+				 void __iomem *mmio)
 {
-	if (idx >= ndev->limits.max_spads)
-		return -EINVAL;
+	WARN_ON_ONCE(ndev_is_unsafe(ndev, NTB_UNSAFE_SPAD));
 
-	dev_dbg(&ndev->pdev->dev, "Writing %x to remote scratch pad index %d\n",
-		val, idx);
-	writel(val, ndev->reg_ofs.spad_write + idx * 4);
+	if (idx < 0 || idx >= ndev->spad_count)
+		return 0;
 
-	return 0;
+	return ioread32(mmio + (idx << 2));
 }
 
-/**
- * ntb_read_remote_spad() - read from the primary scratchpad register
- * @ndev: pointer to ntb_device instance
- * @idx: index to scratchpad register, 0 based
- * @val: pointer to 32bit integer for storing the register value
- *
- * This function allows reading of the 32bit scratchpad register on
- * the primary (internal) side.  This alloows the local system to read the data
- * it wrote to be mirrored on the remote system.
- *
- * RETURNS: An appropriate -ERRNO error value on error, or zero for success.
- */
-int ntb_read_remote_spad(struct ntb_device *ndev, unsigned int idx, u32 *val)
+static inline int ndev_spad_write(struct intel_ntb_dev *ndev, int idx, u32 val,
+				  void __iomem *mmio)
 {
-	if (idx >= ndev->limits.max_spads)
+	WARN_ON_ONCE(ndev_is_unsafe(ndev, NTB_UNSAFE_SPAD));
+
+	if (idx < 0 || idx >= ndev->spad_count)
 		return -EINVAL;
 
-	*val = readl(ndev->reg_ofs.spad_read + idx * 4);
-	dev_dbg(&ndev->pdev->dev,
-		"Reading %x from remote scratch pad index %d\n", *val, idx);
+	iowrite32(val, mmio + (idx << 2));
 
 	return 0;
 }
 
-/**
- * ntb_get_mw_base() - get addr for the NTB memory window
- * @ndev: pointer to ntb_device instance
- * @mw: memory window number
- *
- * This function provides the base address of the memory window specified.
- *
- * RETURNS: address, or NULL on error.
- */
-resource_size_t ntb_get_mw_base(struct ntb_device *ndev, unsigned int mw)
+static irqreturn_t ndev_interrupt(struct intel_ntb_dev *ndev, int vec)
 {
-	if (mw >= ntb_max_mw(ndev))
-		return 0;
+	u64 vec_mask;
+
+	vec_mask = ndev_vec_mask(ndev, vec);
+
+	dev_dbg(ndev_dev(ndev), "vec %d vec_mask %llx\n", vec, vec_mask);
 
-	return pci_resource_start(ndev->pdev, MW_TO_BAR(mw));
+	ndev->last_ts = jiffies;
+
+	if (vec_mask & ndev->db_link_mask) {
+		if (ndev->reg->poll_link(ndev))
+			ntb_link_event(&ndev->ntb);
+	}
+
+	if (vec_mask & ndev->db_valid_mask)
+		ntb_db_event(&ndev->ntb, vec);
+
+	return IRQ_HANDLED;
 }
 
-/**
- * ntb_get_mw_vbase() - get virtual addr for the NTB memory window
- * @ndev: pointer to ntb_device instance
- * @mw: memory window number
- *
- * This function provides the base virtual address of the memory window
- * specified.
- *
- * RETURNS: pointer to virtual address, or NULL on error.
- */
-void __iomem *ntb_get_mw_vbase(struct ntb_device *ndev, unsigned int mw)
+static irqreturn_t ndev_vec_isr(int irq, void *dev)
 {
-	if (mw >= ntb_max_mw(ndev))
-		return NULL;
+	struct intel_ntb_vec *nvec = dev;
 
-	return ndev->mw[mw].vbase;
+	return ndev_interrupt(nvec->ndev, nvec->num);
 }
 
-/**
- * ntb_get_mw_size() - return size of NTB memory window
- * @ndev: pointer to ntb_device instance
- * @mw: memory window number
- *
- * This function provides the physical size of the memory window specified
- *
- * RETURNS: the size of the memory window or zero on error
- */
-u64 ntb_get_mw_size(struct ntb_device *ndev, unsigned int mw)
+static irqreturn_t ndev_irq_isr(int irq, void *dev)
 {
-	if (mw >= ntb_max_mw(ndev))
-		return 0;
+	struct intel_ntb_dev *ndev = dev;
 
-	return ndev->mw[mw].bar_sz;
+	return ndev_interrupt(ndev, irq - ndev_pdev(ndev)->irq);
 }
 
-/**
- * ntb_set_mw_addr - set the memory window address
- * @ndev: pointer to ntb_device instance
- * @mw: memory window number
- * @addr: base address for data
- *
- * This function sets the base physical address of the memory window.  This
- * memory address is where data from the remote system will be transfered into
- * or out of depending on how the transport is configured.
- */
-void ntb_set_mw_addr(struct ntb_device *ndev, unsigned int mw, u64 addr)
+static int ndev_init_isr(struct intel_ntb_dev *ndev,
+			 int msix_min, int msix_max,
+			 int msix_shift, int total_shift)
 {
-	if (mw >= ntb_max_mw(ndev))
-		return;
+	struct pci_dev *pdev;
+	int rc, i, msix_count;
 
-	dev_dbg(&ndev->pdev->dev, "Writing addr %Lx to BAR %d\n", addr,
-		MW_TO_BAR(mw));
+	pdev = ndev_pdev(ndev);
 
-	ndev->mw[mw].phys_addr = addr;
+	/* Mask all doorbell interrupts */
+	ndev->db_mask = ndev->db_valid_mask;
+	ndev->reg->db_iowrite(ndev->db_mask,
+			      ndev->self_mmio +
+			      ndev->self_reg->db_mask);
 
-	switch (MW_TO_BAR(mw)) {
-	case NTB_BAR_23:
-		writeq(addr, ndev->reg_ofs.bar2_xlat);
-		break;
-	case NTB_BAR_4:
-		if (ndev->split_bar)
-			writel(addr, ndev->reg_ofs.bar4_xlat);
-		else
-			writeq(addr, ndev->reg_ofs.bar4_xlat);
-		break;
-	case NTB_BAR_5:
-		writel(addr, ndev->reg_ofs.bar5_xlat);
-		break;
+	/* Try to set up msix irq */
+
+	ndev->vec = kcalloc(msix_max, sizeof(*ndev->vec), GFP_KERNEL);
+	if (!ndev->vec)
+		goto err_msix_vec_alloc;
+
+	ndev->msix = kcalloc(msix_max, sizeof(*ndev->msix), GFP_KERNEL);
+	if (!ndev->msix)
+		goto err_msix_alloc;
+
+	for (i = 0; i < msix_max; ++i)
+		ndev->msix[i].entry = i;
+
+	msix_count = pci_enable_msix_range(pdev, ndev->msix,
+					   msix_min, msix_max);
+	if (msix_count < 0)
+		goto err_msix_enable;
+
+	for (i = 0; i < msix_count; ++i) {
+		ndev->vec[i].ndev = ndev;
+		ndev->vec[i].num = i;
+		rc = request_irq(ndev->msix[i].vector, ndev_vec_isr, 0,
+				 "ndev_vec_isr", &ndev->vec[i]);
+		if (rc)
+			goto err_msix_request;
 	}
-}
 
-/**
- * ntb_ring_doorbell() - Set the doorbell on the secondary/external side
- * @ndev: pointer to ntb_device instance
- * @db: doorbell to ring
- *
- * This function allows triggering of a doorbell on the secondary/external
- * side that will initiate an interrupt on the remote host
- *
- * RETURNS: An appropriate -ERRNO error value on error, or zero for success.
- */
-void ntb_ring_doorbell(struct ntb_device *ndev, unsigned int db)
-{
-	dev_dbg(&ndev->pdev->dev, "%s: ringing doorbell %d\n", __func__, db);
+	dev_dbg(ndev_dev(ndev), "Using msix interrupts\n");
+	ndev->db_vec_count = msix_count;
+	ndev->db_vec_shift = msix_shift;
+	return 0;
 
-	if (ndev->hw_type == BWD_HW)
-		writeq((u64) 1 << db, ndev->reg_ofs.rdb);
-	else
-		writew(((1 << ndev->bits_per_vector) - 1) <<
-		       (db * ndev->bits_per_vector), ndev->reg_ofs.rdb);
-}
+err_msix_request:
+	while (i-- > 0)
+		free_irq(ndev->msix[i].vector, ndev);
+	pci_disable_msix(pdev);
+err_msix_enable:
+	kfree(ndev->msix);
+err_msix_alloc:
+	kfree(ndev->vec);
+err_msix_vec_alloc:
+	ndev->msix = NULL;
+	ndev->vec = NULL;
 
-static void bwd_recover_link(struct ntb_device *ndev)
-{
-	u32 status;
+	/* Try to set up msi irq */
 
-	/* Driver resets the NTB ModPhy lanes - magic! */
-	writeb(0xe0, ndev->reg_base + BWD_MODPHY_PCSREG6);
-	writeb(0x40, ndev->reg_base + BWD_MODPHY_PCSREG4);
-	writeb(0x60, ndev->reg_base + BWD_MODPHY_PCSREG4);
-	writeb(0x60, ndev->reg_base + BWD_MODPHY_PCSREG6);
+	rc = pci_enable_msi(pdev);
+	if (rc)
+		goto err_msi_enable;
 
-	/* Driver waits 100ms to allow the NTB ModPhy to settle */
-	msleep(100);
+	rc = request_irq(pdev->irq, ndev_irq_isr, 0,
+			 "ndev_irq_isr", ndev);
+	if (rc)
+		goto err_msi_request;
 
-	/* Clear AER Errors, write to clear */
-	status = readl(ndev->reg_base + BWD_ERRCORSTS_OFFSET);
-	dev_dbg(&ndev->pdev->dev, "ERRCORSTS = %x\n", status);
-	status &= PCI_ERR_COR_REP_ROLL;
-	writel(status, ndev->reg_base + BWD_ERRCORSTS_OFFSET);
+	dev_dbg(ndev_dev(ndev), "Using msi interrupts\n");
+	ndev->db_vec_count = 1;
+	ndev->db_vec_shift = total_shift;
+	return 0;
 
-	/* Clear unexpected electrical idle event in LTSSM, write to clear */
-	status = readl(ndev->reg_base + BWD_LTSSMERRSTS0_OFFSET);
-	dev_dbg(&ndev->pdev->dev, "LTSSMERRSTS0 = %x\n", status);
-	status |= BWD_LTSSMERRSTS0_UNEXPECTEDEI;
-	writel(status, ndev->reg_base + BWD_LTSSMERRSTS0_OFFSET);
+err_msi_request:
+	pci_disable_msi(pdev);
+err_msi_enable:
 
-	/* Clear DeSkew Buffer error, write to clear */
-	status = readl(ndev->reg_base + BWD_DESKEWSTS_OFFSET);
-	dev_dbg(&ndev->pdev->dev, "DESKEWSTS = %x\n", status);
-	status |= BWD_DESKEWSTS_DBERR;
-	writel(status, ndev->reg_base + BWD_DESKEWSTS_OFFSET);
+	/* Try to set up intx irq */
+
+	pci_msi_off(pdev);
+	pci_intx(pdev, 1);
 
-	status = readl(ndev->reg_base + BWD_IBSTERRRCRVSTS0_OFFSET);
-	dev_dbg(&ndev->pdev->dev, "IBSTERRRCRVSTS0 = %x\n", status);
-	status &= BWD_IBIST_ERR_OFLOW;
-	writel(status, ndev->reg_base + BWD_IBSTERRRCRVSTS0_OFFSET);
+	rc = request_irq(pdev->irq, ndev_irq_isr, IRQF_SHARED,
+			 "ndev_irq_isr", ndev);
+	if (rc)
+		goto err_intx_request;
 
-	/* Releases the NTB state machine to allow the link to retrain */
-	status = readl(ndev->reg_base + BWD_LTSSMSTATEJMP_OFFSET);
-	dev_dbg(&ndev->pdev->dev, "LTSSMSTATEJMP = %x\n", status);
-	status &= ~BWD_LTSSMSTATEJMP_FORCEDETECT;
-	writel(status, ndev->reg_base + BWD_LTSSMSTATEJMP_OFFSET);
+	dev_dbg(ndev_dev(ndev), "Using intx interrupts\n");
+	ndev->db_vec_count = 1;
+	ndev->db_vec_shift = total_shift;
+	return 0;
+
+err_intx_request:
+	return rc;
 }
 
-static void ntb_link_event(struct ntb_device *ndev, int link_state)
+static void ndev_deinit_isr(struct intel_ntb_dev *ndev)
 {
-	unsigned int event;
+	struct pci_dev *pdev;
+	int i;
 
-	if (ndev->link_status == link_state)
-		return;
+	pdev = ndev_pdev(ndev);
 
-	if (link_state == NTB_LINK_UP) {
-		u16 status;
-
-		dev_info(&ndev->pdev->dev, "Link Up\n");
-		ndev->link_status = NTB_LINK_UP;
-		event = NTB_EVENT_HW_LINK_UP;
-
-		if (is_ntb_atom(ndev) ||
-		    ndev->conn_type == NTB_CONN_TRANSPARENT)
-			status = readw(ndev->reg_ofs.lnk_stat);
-		else {
-			int rc = pci_read_config_word(ndev->pdev,
-						      SNB_LINK_STATUS_OFFSET,
-						      &status);
-			if (rc)
-				return;
-		}
+	/* Mask all doorbell interrupts */
+	ndev->db_mask = ndev->db_valid_mask;
+	ndev->reg->db_iowrite(ndev->db_mask,
+			      ndev->self_mmio +
+			      ndev->self_reg->db_mask);
 
-		ndev->link_width = (status & NTB_LINK_WIDTH_MASK) >> 4;
-		ndev->link_speed = (status & NTB_LINK_SPEED_MASK);
-		dev_info(&ndev->pdev->dev, "Link Width %d, Link Speed %d\n",
-			 ndev->link_width, ndev->link_speed);
+	if (ndev->msix) {
+		i = ndev->db_vec_count;
+		while (i--)
+			free_irq(ndev->msix[i].vector, &ndev->vec[i]);
+		pci_disable_msix(pdev);
+		kfree(ndev->msix);
+		kfree(ndev->vec);
 	} else {
-		dev_info(&ndev->pdev->dev, "Link Down\n");
-		ndev->link_status = NTB_LINK_DOWN;
-		event = NTB_EVENT_HW_LINK_DOWN;
-		/* Don't modify link width/speed, we need it in link recovery */
+		free_irq(pdev->irq, ndev);
+		if (pci_dev_msi_enabled(pdev))
+			pci_disable_msi(pdev);
 	}
-
-	/* notify the upper layer if we have an event change */
-	if (ndev->event_cb)
-		ndev->event_cb(ndev->ntb_transport, event);
 }
 
-static int ntb_link_status(struct ntb_device *ndev)
+static ssize_t ndev_debugfs_read(struct file *filp, char __user *ubuf,
+				 size_t count, loff_t *offp)
 {
-	int link_state;
+	struct intel_ntb_dev *ndev;
+	void __iomem *mmio;
+	char *buf;
+	size_t buf_size;
+	ssize_t ret, off;
+	union { u64 v64; u32 v32; u16 v16; } u;
+	unsigned long reg;
+
+	ndev = filp->private_data;
+	mmio = ndev->self_mmio;
 
-	if (is_ntb_atom(ndev)) {
-		u32 ntb_cntl;
+	buf_size = min(count, 0x800ul);
 
-		ntb_cntl = readl(ndev->reg_ofs.lnk_cntl);
-		if (ntb_cntl & BWD_CNTL_LINK_DOWN)
-			link_state = NTB_LINK_DOWN;
-		else
-			link_state = NTB_LINK_UP;
-	} else {
-		u16 status;
-		int rc;
+	buf = kmalloc(buf_size, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
 
-		rc = pci_read_config_word(ndev->pdev, SNB_LINK_STATUS_OFFSET,
-					  &status);
-		if (rc)
-			return rc;
+	off = 0;
 
-		if (status & NTB_LINK_STATUS_ACTIVE)
-			link_state = NTB_LINK_UP;
-		else
-			link_state = NTB_LINK_DOWN;
-	}
+	off += scnprintf(buf + off, buf_size - off,
+			 "NTB Device Information:\n");
 
-	ntb_link_event(ndev, link_state);
+	off += scnprintf(buf + off, buf_size - off,
+			 "Connection Topology -\t%s\n",
+			 ntb_topo_string(ndev->ntb.topo));
 
-	return 0;
-}
+	off += scnprintf(buf + off, buf_size - off,
+			 "B2B Offset -\t\t%#lx\n", ndev->b2b_off);
+	off += scnprintf(buf + off, buf_size - off,
+			 "B2B MW Idx -\t\t%d\n", ndev->b2b_idx);
+	off += scnprintf(buf + off, buf_size - off,
+			 "BAR4 Split -\t\t%s\n",
+			 ndev->bar4_split ? "yes" : "no");
 
-static void bwd_link_recovery(struct work_struct *work)
-{
-	struct ntb_device *ndev = container_of(work, struct ntb_device,
-					       lr_timer.work);
-	u32 status32;
+	off += scnprintf(buf + off, buf_size - off,
+			 "NTB CTL -\t\t%#06x\n", ndev->ntb_ctl);
+	off += scnprintf(buf + off, buf_size - off,
+			 "LNK STA -\t\t%#06x\n", ndev->lnk_sta);
 
-	bwd_recover_link(ndev);
-	/* There is a potential race between the 2 NTB devices recovering at the
-	 * same time.  If the times are the same, the link will not recover and
-	 * the driver will be stuck in this loop forever.  Add a random interval
-	 * to the recovery time to prevent this race.
-	 */
-	msleep(BWD_LINK_RECOVERY_TIME + prandom_u32() % BWD_LINK_RECOVERY_TIME);
-
-	status32 = readl(ndev->reg_base + BWD_LTSSMSTATEJMP_OFFSET);
-	if (status32 & BWD_LTSSMSTATEJMP_FORCEDETECT)
-		goto retry;
-
-	status32 = readl(ndev->reg_base + BWD_IBSTERRRCRVSTS0_OFFSET);
-	if (status32 & BWD_IBIST_ERR_OFLOW)
-		goto retry;
-
-	status32 = readl(ndev->reg_ofs.lnk_cntl);
-	if (!(status32 & BWD_CNTL_LINK_DOWN)) {
-		unsigned char speed, width;
-		u16 status16;
-
-		status16 = readw(ndev->reg_ofs.lnk_stat);
-		width = (status16 & NTB_LINK_WIDTH_MASK) >> 4;
-		speed = (status16 & NTB_LINK_SPEED_MASK);
-		if (ndev->link_width != width || ndev->link_speed != speed)
-			goto retry;
+	if (!ndev->reg->link_is_up(ndev)) {
+		off += scnprintf(buf + off, buf_size - off,
+				 "Link Satus -\t\tDown\n");
+	} else {
+		off += scnprintf(buf + off, buf_size - off,
+				 "Link Satus -\t\tUp\n");
+		off += scnprintf(buf + off, buf_size - off,
+				 "Link Speed -\t\tPCI-E Gen %u\n",
+				 NTB_LNK_STA_SPEED(ndev->lnk_sta));
+		off += scnprintf(buf + off, buf_size - off,
+				 "Link Width -\t\tx%u\n",
+				 NTB_LNK_STA_WIDTH(ndev->lnk_sta));
 	}
 
-	schedule_delayed_work(&ndev->hb_timer, NTB_HB_TIMEOUT);
-	return;
+	off += scnprintf(buf + off, buf_size - off,
+			 "Memory Window Count -\t%u\n", ndev->mw_count);
+	off += scnprintf(buf + off, buf_size - off,
+			 "Scratchpad Count -\t%u\n", ndev->spad_count);
+	off += scnprintf(buf + off, buf_size - off,
+			 "Doorbell Count -\t%u\n", ndev->db_count);
+	off += scnprintf(buf + off, buf_size - off,
+			 "Doorbell Vector Count -\t%u\n", ndev->db_vec_count);
+	off += scnprintf(buf + off, buf_size - off,
+			 "Doorbell Vector Shift -\t%u\n", ndev->db_vec_shift);
+
+	off += scnprintf(buf + off, buf_size - off,
+			 "Doorbell Valid Mask -\t%#llx\n", ndev->db_valid_mask);
+	off += scnprintf(buf + off, buf_size - off,
+			 "Doorbell Link Mask -\t%#llx\n", ndev->db_link_mask);
+	off += scnprintf(buf + off, buf_size - off,
+			 "Doorbell Mask Cached -\t%#llx\n", ndev->db_mask);
+
+	reg = ndev->self_reg->db_mask;
+	u.v64 = ndev_db_read(ndev, mmio + reg);
+	off += scnprintf(buf + off, buf_size - off,
+			 "Doorbell Mask -\t\t%#llx\n", u.v64);
+
+	reg = ndev->self_reg->db_bell;
+	u.v64 = ndev_db_read(ndev, mmio + reg);
+	off += scnprintf(buf + off, buf_size - off,
+			 "Doorbell Bell -\t\t%#llx\n", u.v64);
+
+	off += scnprintf(buf + off, buf_size - off,
+			 "\nNTB Incoming XLAT:\n");
+
+	reg = bar2_off(ndev->xlat_reg->bar2_xlat, 2);
+	u.v64 = ioread64(mmio + reg);
+	off += scnprintf(buf + off, buf_size - off,
+			 "XLAT23 -\t\t%#018llx\n", u.v64);
+
+	reg = bar2_off(ndev->xlat_reg->bar2_xlat, 4);
+	u.v64 = ioread64(mmio + reg);
+	off += scnprintf(buf + off, buf_size - off,
+			 "XLAT45 -\t\t%#018llx\n", u.v64);
+
+	reg = bar2_off(ndev->xlat_reg->bar2_limit, 2);
+	u.v64 = ioread64(mmio + reg);
+	off += scnprintf(buf + off, buf_size - off,
+			 "LMT23 -\t\t\t%#018llx\n", u.v64);
+
+	reg = bar2_off(ndev->xlat_reg->bar2_limit, 4);
+	u.v64 = ioread64(mmio + reg);
+	off += scnprintf(buf + off, buf_size - off,
+			 "LMT45 -\t\t\t%#018llx\n", u.v64);
+
+	if (pdev_is_snb(ndev->ntb.pdev)) {
+		if (ntb_topo_is_b2b(ndev->ntb.topo)) {
+			off += scnprintf(buf + off, buf_size - off,
+					 "\nNTB Outgoing B2B XLAT:\n");
+
+			reg = bar2_off(SNB_PBAR2XLAT_OFFSET, 2);
+			u.v64 = ioread64(mmio + reg);
+			off += scnprintf(buf + off, buf_size - off,
+					 "B2B XLAT23 -\t\t%#018llx\n", u.v64);
+
+			reg = bar2_off(SNB_PBAR2XLAT_OFFSET, 4);
+			u.v64 = ioread64(mmio + reg);
+			off += scnprintf(buf + off, buf_size - off,
+					 "B2B XLAT45 -\t\t%#018llx\n", u.v64);
+
+			reg = bar2_off(SNB_PBAR2LMT_OFFSET, 2);
+			u.v64 = ioread64(mmio + reg);
+			off += scnprintf(buf + off, buf_size - off,
+					 "B2B LMT23 -\t\t%#018llx\n", u.v64);
+
+			reg = bar2_off(SNB_PBAR2LMT_OFFSET, 4);
+			u.v64 = ioread64(mmio + reg);
+			off += scnprintf(buf + off, buf_size - off,
+					 "B2B LMT45 -\t\t%#018llx\n", u.v64);
+
+			off += scnprintf(buf + off, buf_size - off,
+					 "\nNTB Secondary BAR:\n");
+
+			reg = bar0_off(SNB_SBAR0BASE_OFFSET, 0);
+			u.v64 = ioread64(mmio + reg);
+			off += scnprintf(buf + off, buf_size - off,
+					 "SBAR01 -\t\t%#018llx\n", u.v64);
+
+			reg = bar0_off(SNB_SBAR0BASE_OFFSET, 2);
+			u.v64 = ioread64(mmio + reg);
+			off += scnprintf(buf + off, buf_size - off,
+					 "SBAR23 -\t\t%#018llx\n", u.v64);
+
+			reg = bar0_off(SNB_SBAR0BASE_OFFSET, 4);
+			u.v64 = ioread64(mmio + reg);
+			off += scnprintf(buf + off, buf_size - off,
+					 "SBAR45 -\t\t%#018llx\n", u.v64);
+		}
+
+		off += scnprintf(buf + off, buf_size - off,
+				 "\nSNB NTB Statistics:\n");
+
+		reg = SNB_USMEMMISS_OFFSET;
+		u.v16 = ioread16(mmio + reg);
+		off += scnprintf(buf + off, buf_size - off,
+				 "Upstream Memory Miss -\t%u\n", u.v16);
+
+		off += scnprintf(buf + off, buf_size - off,
+				 "\nSNB NTB Hardware Errors:\n");
+
+		reg = SNB_DEVSTS_OFFSET;
+		if (!pci_read_config_word(ndev->ntb.pdev, reg, &u.v16))
+			off += scnprintf(buf + off, buf_size - off,
+					 "DEVSTS -\t\t%#06x\n", u.v16);
 
-retry:
-	schedule_delayed_work(&ndev->lr_timer, NTB_HB_TIMEOUT);
+		reg = SNB_LINK_STATUS_OFFSET;
+		if (!pci_read_config_word(ndev->ntb.pdev, reg, &u.v16))
+			off += scnprintf(buf + off, buf_size - off,
+					 "LNKSTS -\t\t%#06x\n", u.v16);
+
+		reg = SNB_UNCERRSTS_OFFSET;
+		if (!pci_read_config_dword(ndev->ntb.pdev, reg, &u.v32))
+			off += scnprintf(buf + off, buf_size - off,
+					 "UNCERRSTS -\t\t%#06x\n", u.v32);
+
+		reg = SNB_CORERRSTS_OFFSET;
+		if (!pci_read_config_dword(ndev->ntb.pdev, reg, &u.v32))
+			off += scnprintf(buf + off, buf_size - off,
+					 "CORERRSTS -\t\t%#06x\n", u.v32);
+	}
+
+	ret = simple_read_from_buffer(ubuf, count, offp, buf, off);
+	kfree(buf);
+	return ret;
 }
 
-/* BWD doesn't have link status interrupt, poll on that platform */
-static void bwd_link_poll(struct work_struct *work)
+static void ndev_init_debugfs(struct intel_ntb_dev *ndev)
 {
-	struct ntb_device *ndev = container_of(work, struct ntb_device,
-					       hb_timer.work);
-	unsigned long ts = jiffies;
-
-	/* If we haven't gotten an interrupt in a while, check the BWD link
-	 * status bit
-	 */
-	if (ts > ndev->last_ts + NTB_HB_TIMEOUT) {
-		int rc = ntb_link_status(ndev);
-		if (rc)
-			dev_err(&ndev->pdev->dev,
-				"Error determining link status\n");
-
-		/* Check to see if a link error is the cause of the link down */
-		if (ndev->link_status == NTB_LINK_DOWN) {
-			u32 status32 = readl(ndev->reg_base +
-					     BWD_LTSSMSTATEJMP_OFFSET);
-			if (status32 & BWD_LTSSMSTATEJMP_FORCEDETECT) {
-				schedule_delayed_work(&ndev->lr_timer, 0);
-				return;
-			}
-		}
+	if (!debugfs_dir) {
+		ndev->debugfs_dir = NULL;
+		ndev->debugfs_info = NULL;
+	} else {
+		ndev->debugfs_dir =
+			debugfs_create_dir(ndev_name(ndev), debugfs_dir);
+		if (!ndev->debugfs_dir)
+			ndev->debugfs_info = NULL;
+		else
+			ndev->debugfs_info =
+				debugfs_create_file("info", S_IRUSR,
+						    ndev->debugfs_dir, ndev,
+						    &intel_ntb_debugfs_info);
 	}
+}
 
-	schedule_delayed_work(&ndev->hb_timer, NTB_HB_TIMEOUT);
+static void ndev_deinit_debugfs(struct intel_ntb_dev *ndev)
+{
+	debugfs_remove_recursive(ndev->debugfs_dir);
 }
 
-static int ntb_xeon_setup(struct ntb_device *ndev)
+static int intel_ntb_mw_count(struct ntb_dev *ntb)
 {
-	switch (ndev->conn_type) {
-	case NTB_CONN_B2B:
-		ndev->reg_ofs.ldb = ndev->reg_base + SNB_PDOORBELL_OFFSET;
-		ndev->reg_ofs.ldb_mask = ndev->reg_base + SNB_PDBMSK_OFFSET;
-		ndev->reg_ofs.spad_read = ndev->reg_base + SNB_SPAD_OFFSET;
-		ndev->reg_ofs.bar2_xlat = ndev->reg_base + SNB_SBAR2XLAT_OFFSET;
-		ndev->reg_ofs.bar4_xlat = ndev->reg_base + SNB_SBAR4XLAT_OFFSET;
-		if (ndev->split_bar)
-			ndev->reg_ofs.bar5_xlat =
-				ndev->reg_base + SNB_SBAR5XLAT_OFFSET;
-		ndev->limits.max_spads = SNB_MAX_B2B_SPADS;
+	return ntb_ndev(ntb)->mw_count;
+}
 
-		/* There is a Xeon hardware errata related to writes to
-		 * SDOORBELL or B2BDOORBELL in conjunction with inbound access
-		 * to NTB MMIO Space, which may hang the system.  To workaround
-		 * this use the second memory window to access the interrupt and
-		 * scratch pad registers on the remote system.
-		 */
-		if (ndev->wa_flags & WA_SNB_ERR) {
-			if (!ndev->mw[ndev->limits.max_mw - 1].bar_sz)
-				return -EINVAL;
-
-			ndev->limits.max_db_bits = SNB_MAX_DB_BITS;
-			ndev->reg_ofs.spad_write =
-				ndev->mw[ndev->limits.max_mw - 1].vbase +
-				SNB_SPAD_OFFSET;
-			ndev->reg_ofs.rdb =
-				ndev->mw[ndev->limits.max_mw - 1].vbase +
-				SNB_PDOORBELL_OFFSET;
-
-			/* Set the Limit register to 4k, the minimum size, to
-			 * prevent an illegal access
-			 */
-			writeq(ndev->mw[1].bar_sz + 0x1000, ndev->reg_base +
-			       SNB_PBAR4LMT_OFFSET);
-			/* HW errata on the Limit registers.  They can only be
-			 * written when the base register is 4GB aligned and
-			 * < 32bit.  This should already be the case based on
-			 * the driver defaults, but write the Limit registers
-			 * first just in case.
-			 */
-
-			ndev->limits.max_mw = SNB_ERRATA_MAX_MW;
-		} else {
-			/* HW Errata on bit 14 of b2bdoorbell register.  Writes
-			 * will not be mirrored to the remote system.  Shrink
-			 * the number of bits by one, since bit 14 is the last
-			 * bit.
-			 */
-			ndev->limits.max_db_bits = SNB_MAX_DB_BITS - 1;
-			ndev->reg_ofs.spad_write = ndev->reg_base +
-						   SNB_B2B_SPAD_OFFSET;
-			ndev->reg_ofs.rdb = ndev->reg_base +
-					    SNB_B2B_DOORBELL_OFFSET;
-
-			/* Disable the Limit register, just incase it is set to
-			 * something silly. A 64bit write should handle it
-			 * regardless of whether it has a split BAR or not.
-			 */
-			writeq(0, ndev->reg_base + SNB_PBAR4LMT_OFFSET);
-			/* HW errata on the Limit registers.  They can only be
-			 * written when the base register is 4GB aligned and
-			 * < 32bit.  This should already be the case based on
-			 * the driver defaults, but write the Limit registers
-			 * first just in case.
-			 */
-			if (ndev->split_bar)
-				ndev->limits.max_mw = HSX_SPLITBAR_MAX_MW;
-			else
-				ndev->limits.max_mw = SNB_MAX_MW;
-		}
+static int intel_ntb_mw_get_range(struct ntb_dev *ntb, int idx,
+				  phys_addr_t *base,
+				  resource_size_t *size,
+				  resource_size_t *align,
+				  resource_size_t *align_size)
+{
+	struct intel_ntb_dev *ndev = ntb_ndev(ntb);
+	int bar;
 
-		/* The Xeon errata workaround requires setting SBAR Base
-		 * addresses to known values, so that the PBAR XLAT can be
-		 * pointed at SBAR0 of the remote system.
-		 */
-		if (ndev->dev_type == NTB_DEV_USD) {
-			writeq(SNB_MBAR23_DSD_ADDR, ndev->reg_base +
-			       SNB_PBAR2XLAT_OFFSET);
-			if (ndev->wa_flags & WA_SNB_ERR)
-				writeq(SNB_MBAR01_DSD_ADDR, ndev->reg_base +
-				       SNB_PBAR4XLAT_OFFSET);
-			else {
-				if (ndev->split_bar) {
-					writel(SNB_MBAR4_DSD_ADDR,
-					       ndev->reg_base +
-					       SNB_PBAR4XLAT_OFFSET);
-					writel(SNB_MBAR5_DSD_ADDR,
-					       ndev->reg_base +
-					       SNB_PBAR5XLAT_OFFSET);
-				} else
-					writeq(SNB_MBAR4_DSD_ADDR,
-					       ndev->reg_base +
-					       SNB_PBAR4XLAT_OFFSET);
-
-				/* B2B_XLAT_OFFSET is a 64bit register, but can
-				 * only take 32bit writes
-				 */
-				writel(SNB_MBAR01_DSD_ADDR & 0xffffffff,
-				       ndev->reg_base + SNB_B2B_XLAT_OFFSETL);
-				writel(SNB_MBAR01_DSD_ADDR >> 32,
-				       ndev->reg_base + SNB_B2B_XLAT_OFFSETU);
-			}
-
-			writeq(SNB_MBAR01_USD_ADDR, ndev->reg_base +
-			       SNB_SBAR0BASE_OFFSET);
-			writeq(SNB_MBAR23_USD_ADDR, ndev->reg_base +
-			       SNB_SBAR2BASE_OFFSET);
-			if (ndev->split_bar) {
-				writel(SNB_MBAR4_USD_ADDR, ndev->reg_base +
-				       SNB_SBAR4BASE_OFFSET);
-				writel(SNB_MBAR5_USD_ADDR, ndev->reg_base +
-				       SNB_SBAR5BASE_OFFSET);
-			} else
-				writeq(SNB_MBAR4_USD_ADDR, ndev->reg_base +
-				       SNB_SBAR4BASE_OFFSET);
-		} else {
-			writeq(SNB_MBAR23_USD_ADDR, ndev->reg_base +
-			       SNB_PBAR2XLAT_OFFSET);
-			if (ndev->wa_flags & WA_SNB_ERR)
-				writeq(SNB_MBAR01_USD_ADDR, ndev->reg_base +
-				       SNB_PBAR4XLAT_OFFSET);
-			else {
-				if (ndev->split_bar) {
-					writel(SNB_MBAR4_USD_ADDR,
-					       ndev->reg_base +
-					       SNB_PBAR4XLAT_OFFSET);
-					writel(SNB_MBAR5_USD_ADDR,
-					       ndev->reg_base +
-					       SNB_PBAR5XLAT_OFFSET);
-				} else
-					writeq(SNB_MBAR4_USD_ADDR,
-					       ndev->reg_base +
-					       SNB_PBAR4XLAT_OFFSET);
-
-				/*
-				 * B2B_XLAT_OFFSET is a 64bit register, but can
-				 * only take 32bit writes
-				 */
-				writel(SNB_MBAR01_USD_ADDR & 0xffffffff,
-				       ndev->reg_base + SNB_B2B_XLAT_OFFSETL);
-				writel(SNB_MBAR01_USD_ADDR >> 32,
-				       ndev->reg_base + SNB_B2B_XLAT_OFFSETU);
-			}
-			writeq(SNB_MBAR01_DSD_ADDR, ndev->reg_base +
-			       SNB_SBAR0BASE_OFFSET);
-			writeq(SNB_MBAR23_DSD_ADDR, ndev->reg_base +
-			       SNB_SBAR2BASE_OFFSET);
-			if (ndev->split_bar) {
-				writel(SNB_MBAR4_DSD_ADDR, ndev->reg_base +
-				       SNB_SBAR4BASE_OFFSET);
-				writel(SNB_MBAR5_DSD_ADDR, ndev->reg_base +
-				       SNB_SBAR5BASE_OFFSET);
-			} else
-				writeq(SNB_MBAR4_DSD_ADDR, ndev->reg_base +
-				       SNB_SBAR4BASE_OFFSET);
+	if (idx >= ndev->b2b_idx && !ndev->b2b_off)
+		idx += 1;
 
-		}
-		break;
-	case NTB_CONN_RP:
-		if (ndev->wa_flags & WA_SNB_ERR) {
-			dev_err(&ndev->pdev->dev,
-				"NTB-RP disabled due to hardware errata.\n");
-			return -EINVAL;
-		}
+	bar = ndev_mw_to_bar(ndev, idx);
+	if (bar < 0)
+		return bar;
 
-		/* Scratch pads need to have exclusive access from the primary
-		 * or secondary side.  Halve the num spads so that each side can
-		 * have an equal amount.
-		 */
-		ndev->limits.max_spads = SNB_MAX_COMPAT_SPADS / 2;
-		ndev->limits.max_db_bits = SNB_MAX_DB_BITS;
-		/* Note: The SDOORBELL is the cause of the errata.  You REALLY
-		 * don't want to touch it.
-		 */
-		ndev->reg_ofs.rdb = ndev->reg_base + SNB_SDOORBELL_OFFSET;
-		ndev->reg_ofs.ldb = ndev->reg_base + SNB_PDOORBELL_OFFSET;
-		ndev->reg_ofs.ldb_mask = ndev->reg_base + SNB_PDBMSK_OFFSET;
-		/* Offset the start of the spads to correspond to whether it is
-		 * primary or secondary
-		 */
-		ndev->reg_ofs.spad_write = ndev->reg_base + SNB_SPAD_OFFSET +
-					   ndev->limits.max_spads * 4;
-		ndev->reg_ofs.spad_read = ndev->reg_base + SNB_SPAD_OFFSET;
-		ndev->reg_ofs.bar2_xlat = ndev->reg_base + SNB_SBAR2XLAT_OFFSET;
-		ndev->reg_ofs.bar4_xlat = ndev->reg_base + SNB_SBAR4XLAT_OFFSET;
-		if (ndev->split_bar) {
-			ndev->reg_ofs.bar5_xlat =
-				ndev->reg_base + SNB_SBAR5XLAT_OFFSET;
-			ndev->limits.max_mw = HSX_SPLITBAR_MAX_MW;
-		} else
-			ndev->limits.max_mw = SNB_MAX_MW;
-		break;
-	case NTB_CONN_TRANSPARENT:
-		if (ndev->wa_flags & WA_SNB_ERR) {
-			dev_err(&ndev->pdev->dev,
-				"NTB-TRANSPARENT disabled due to hardware errata.\n");
-			return -EINVAL;
-		}
+	if (base)
+		*base = pci_resource_start(ndev->ntb.pdev, bar) +
+			(idx == ndev->b2b_idx ? ndev->b2b_off : 0);
 
-		/* Scratch pads need to have exclusive access from the primary
-		 * or secondary side.  Halve the num spads so that each side can
-		 * have an equal amount.
-		 */
-		ndev->limits.max_spads = SNB_MAX_COMPAT_SPADS / 2;
-		ndev->limits.max_db_bits = SNB_MAX_DB_BITS;
-		ndev->reg_ofs.rdb = ndev->reg_base + SNB_PDOORBELL_OFFSET;
-		ndev->reg_ofs.ldb = ndev->reg_base + SNB_SDOORBELL_OFFSET;
-		ndev->reg_ofs.ldb_mask = ndev->reg_base + SNB_SDBMSK_OFFSET;
-		ndev->reg_ofs.spad_write = ndev->reg_base + SNB_SPAD_OFFSET;
-		/* Offset the start of the spads to correspond to whether it is
-		 * primary or secondary
-		 */
-		ndev->reg_ofs.spad_read = ndev->reg_base + SNB_SPAD_OFFSET +
-					  ndev->limits.max_spads * 4;
-		ndev->reg_ofs.bar2_xlat = ndev->reg_base + SNB_PBAR2XLAT_OFFSET;
-		ndev->reg_ofs.bar4_xlat = ndev->reg_base + SNB_PBAR4XLAT_OFFSET;
-
-		if (ndev->split_bar) {
-			ndev->reg_ofs.bar5_xlat =
-				ndev->reg_base + SNB_PBAR5XLAT_OFFSET;
-			ndev->limits.max_mw = HSX_SPLITBAR_MAX_MW;
-		} else
-			ndev->limits.max_mw = SNB_MAX_MW;
-		break;
-	default:
-		/*
-		 * we should never hit this. the detect function should've
-		 * take cared of everything.
-		 */
-		return -EINVAL;
-	}
+	if (size)
+		*size = pci_resource_len(ndev->ntb.pdev, bar) -
+			(idx == ndev->b2b_idx ? ndev->b2b_off : 0);
 
-	ndev->reg_ofs.lnk_cntl = ndev->reg_base + SNB_NTBCNTL_OFFSET;
-	ndev->reg_ofs.lnk_stat = ndev->reg_base + SNB_SLINK_STATUS_OFFSET;
-	ndev->reg_ofs.spci_cmd = ndev->reg_base + SNB_PCICMD_OFFSET;
+	if (align)
+		*align = pci_resource_len(ndev->ntb.pdev, bar);
 
-	ndev->limits.msix_cnt = SNB_MSIX_CNT;
-	ndev->bits_per_vector = SNB_DB_BITS_PER_VEC;
+	if (align_size)
+		*align_size = 1;
 
 	return 0;
 }
 
-static int ntb_bwd_setup(struct ntb_device *ndev)
+static int intel_ntb_mw_set_trans(struct ntb_dev *ntb, int idx,
+				  dma_addr_t addr, resource_size_t size)
 {
-	int rc;
-	u32 val;
+	struct intel_ntb_dev *ndev = ntb_ndev(ntb);
+	unsigned long base_reg, xlat_reg, limit_reg;
+	resource_size_t bar_size, mw_size;
+	void __iomem *mmio;
+	u64 base, limit, reg_val;
+	int bar;
 
-	ndev->hw_type = BWD_HW;
+	if (idx >= ndev->b2b_idx && !ndev->b2b_off)
+		idx += 1;
 
-	rc = pci_read_config_dword(ndev->pdev, NTB_PPD_OFFSET, &val);
-	if (rc)
-		return rc;
+	bar = ndev_mw_to_bar(ndev, idx);
+	if (bar < 0)
+		return bar;
 
-	switch ((val & BWD_PPD_CONN_TYPE) >> 8) {
-	case NTB_CONN_B2B:
-		ndev->conn_type = NTB_CONN_B2B;
-		break;
-	case NTB_CONN_RP:
-	default:
-		dev_err(&ndev->pdev->dev, "Unsupported NTB configuration\n");
+	bar_size = pci_resource_len(ndev->ntb.pdev, bar);
+
+	if (idx == ndev->b2b_idx)
+		mw_size = bar_size - ndev->b2b_off;
+	else
+		mw_size = bar_size;
+
+	/* hardware requires that addr is aligned to bar size */
+	if (addr & (bar_size - 1))
 		return -EINVAL;
+
+	/* make sure the range fits in the usable mw size */
+	if (size > mw_size)
+		return -EINVAL;
+
+	mmio = ndev->self_mmio;
+	base_reg = bar0_off(ndev->xlat_reg->bar0_base, bar);
+	xlat_reg = bar2_off(ndev->xlat_reg->bar2_xlat, bar);
+	limit_reg = bar2_off(ndev->xlat_reg->bar2_limit, bar);
+
+	if (bar < 4 || !ndev->bar4_split) {
+		base = ioread64(mmio + base_reg);
+
+		/* Set the limit if supported, if size is not mw_size */
+		if (limit_reg && size != mw_size)
+			limit = base + size;
+		else
+			limit = 0;
+
+		/* set and verify setting the translation address */
+		iowrite64(addr, mmio + xlat_reg);
+		reg_val = ioread64(mmio + xlat_reg);
+		if (reg_val != addr) {
+			iowrite64(0, mmio + xlat_reg);
+			return -EIO;
+		}
+
+		/* set and verify setting the limit */
+		iowrite64(limit, mmio + limit_reg);
+		reg_val = ioread64(mmio + limit_reg);
+		if (reg_val != limit) {
+			iowrite64(base, mmio + limit_reg);
+			iowrite64(0, mmio + xlat_reg);
+			return -EIO;
+		}
+	} else {
+		/* split bar addr range must all be 32 bit */
+		if (addr & (~0ull << 32))
+			return -EINVAL;
+		if ((addr + size) & (~0ull << 32))
+			return -EINVAL;
+
+		base = ioread32(mmio + base_reg);
+
+		/* Set the limit if supported, if size is not mw_size */
+		if (limit_reg && size != mw_size)
+			limit = base + size;
+		else
+			limit = 0;
+
+		/* set and verify setting the translation address */
+		iowrite32(addr, mmio + xlat_reg);
+		reg_val = ioread32(mmio + xlat_reg);
+		if (reg_val != addr) {
+			iowrite32(0, mmio + xlat_reg);
+			return -EIO;
+		}
+
+		/* set and verify setting the limit */
+		iowrite32(limit, mmio + limit_reg);
+		reg_val = ioread32(mmio + limit_reg);
+		if (reg_val != limit) {
+			iowrite32(base, mmio + limit_reg);
+			iowrite32(0, mmio + xlat_reg);
+			return -EIO;
+		}
 	}
 
-	if (val & BWD_PPD_DEV_TYPE)
-		ndev->dev_type = NTB_DEV_DSD;
-	else
-		ndev->dev_type = NTB_DEV_USD;
+	return 0;
+}
 
-	/* Initiate PCI-E link training */
-	rc = pci_write_config_dword(ndev->pdev, NTB_PPD_OFFSET,
-				    val | BWD_PPD_INIT_LINK);
-	if (rc)
-		return rc;
+static int intel_ntb_link_is_up(struct ntb_dev *ntb,
+				enum ntb_speed *speed,
+				enum ntb_width *width)
+{
+	struct intel_ntb_dev *ndev = ntb_ndev(ntb);
 
-	ndev->reg_ofs.ldb = ndev->reg_base + BWD_PDOORBELL_OFFSET;
-	ndev->reg_ofs.ldb_mask = ndev->reg_base + BWD_PDBMSK_OFFSET;
-	ndev->reg_ofs.rdb = ndev->reg_base + BWD_B2B_DOORBELL_OFFSET;
-	ndev->reg_ofs.bar2_xlat = ndev->reg_base + BWD_SBAR2XLAT_OFFSET;
-	ndev->reg_ofs.bar4_xlat = ndev->reg_base + BWD_SBAR4XLAT_OFFSET;
-	ndev->reg_ofs.lnk_cntl = ndev->reg_base + BWD_NTBCNTL_OFFSET;
-	ndev->reg_ofs.lnk_stat = ndev->reg_base + BWD_LINK_STATUS_OFFSET;
-	ndev->reg_ofs.spad_read = ndev->reg_base + BWD_SPAD_OFFSET;
-	ndev->reg_ofs.spad_write = ndev->reg_base + BWD_B2B_SPAD_OFFSET;
-	ndev->reg_ofs.spci_cmd = ndev->reg_base + BWD_PCICMD_OFFSET;
-	ndev->limits.max_mw = BWD_MAX_MW;
-	ndev->limits.max_spads = BWD_MAX_SPADS;
-	ndev->limits.max_db_bits = BWD_MAX_DB_BITS;
-	ndev->limits.msix_cnt = BWD_MSIX_CNT;
-	ndev->bits_per_vector = BWD_DB_BITS_PER_VEC;
-
-	/* Since bwd doesn't have a link interrupt, setup a poll timer */
-	INIT_DELAYED_WORK(&ndev->hb_timer, bwd_link_poll);
-	INIT_DELAYED_WORK(&ndev->lr_timer, bwd_link_recovery);
-	schedule_delayed_work(&ndev->hb_timer, NTB_HB_TIMEOUT);
+	if (ndev->reg->link_is_up(ndev)) {
+		if (speed)
+			*speed = NTB_LNK_STA_SPEED(ndev->lnk_sta);
+		if (width)
+			*width = NTB_LNK_STA_WIDTH(ndev->lnk_sta);
+		return 1;
+	} else {
+		/* TODO MAYBE: is it possible to observe the link speed and
+		 * width while link is training? */
+		if (speed)
+			*speed = NTB_SPEED_NONE;
+		if (width)
+			*width = NTB_WIDTH_NONE;
+		return 0;
+	}
+}
+
+static int intel_ntb_link_enable(struct ntb_dev *ntb,
+				 enum ntb_speed max_speed,
+				 enum ntb_width max_width)
+{
+	struct intel_ntb_dev *ndev;
+	u32 ntb_ctl;
+
+	ndev = container_of(ntb, struct intel_ntb_dev, ntb);
+
+	if (ndev->ntb.topo == NTB_TOPO_SEC)
+		return -EINVAL;
+
+	dev_dbg(ndev_dev(ndev),
+		"Enabling link with max_speed %d max_width %d\n",
+		max_speed, max_width);
+	if (max_speed != NTB_SPEED_AUTO)
+		dev_dbg(ndev_dev(ndev), "ignoring max_speed %d\n", max_speed);
+	if (max_width != NTB_WIDTH_AUTO)
+		dev_dbg(ndev_dev(ndev), "ignoring max_width %d\n", max_width);
+
+	ntb_ctl = ioread32(ndev->self_mmio + ndev->reg->ntb_ctl);
+	ntb_ctl &= ~(NTB_CTL_DISABLE | NTB_CTL_CFG_LOCK);
+	ntb_ctl |= NTB_CTL_P2S_BAR2_SNOOP | NTB_CTL_S2P_BAR2_SNOOP;
+	ntb_ctl |= NTB_CTL_P2S_BAR4_SNOOP | NTB_CTL_S2P_BAR4_SNOOP;
+	if (ndev->bar4_split)
+		ntb_ctl |= NTB_CTL_P2S_BAR5_SNOOP | NTB_CTL_S2P_BAR5_SNOOP;
+	iowrite32(ntb_ctl, ndev->self_mmio + ndev->reg->ntb_ctl);
 
 	return 0;
 }
 
-static int ntb_device_setup(struct ntb_device *ndev)
+static int intel_ntb_link_disable(struct ntb_dev *ntb)
 {
-	int rc;
+	struct intel_ntb_dev *ndev;
+	u32 ntb_cntl;
 
-	if (is_ntb_xeon(ndev))
-		rc = ntb_xeon_setup(ndev);
-	else if (is_ntb_atom(ndev))
-		rc = ntb_bwd_setup(ndev);
-	else
-		rc = -ENODEV;
+	ndev = container_of(ntb, struct intel_ntb_dev, ntb);
 
-	if (rc)
-		return rc;
+	if (ndev->ntb.topo == NTB_TOPO_SEC)
+		return -EINVAL;
 
-	if (ndev->conn_type == NTB_CONN_B2B)
-		/* Enable Bus Master and Memory Space on the secondary side */
-		writew(PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER,
-		       ndev->reg_ofs.spci_cmd);
+	dev_dbg(ndev_dev(ndev), "Disabling link\n");
+
+	/* Bring NTB link down */
+	ntb_cntl = ioread32(ndev->self_mmio + ndev->reg->ntb_ctl);
+	ntb_cntl &= ~(NTB_CTL_P2S_BAR2_SNOOP | NTB_CTL_S2P_BAR2_SNOOP);
+	ntb_cntl &= ~(NTB_CTL_P2S_BAR4_SNOOP | NTB_CTL_S2P_BAR4_SNOOP);
+	if (ndev->bar4_split)
+		ntb_cntl &= ~(NTB_CTL_P2S_BAR5_SNOOP | NTB_CTL_S2P_BAR5_SNOOP);
+	ntb_cntl |= NTB_CTL_DISABLE | NTB_CTL_CFG_LOCK;
+	iowrite32(ntb_cntl, ndev->self_mmio + ndev->reg->ntb_ctl);
 
 	return 0;
 }
 
-static void ntb_device_free(struct ntb_device *ndev)
+static int intel_ntb_db_is_unsafe(struct ntb_dev *ntb)
 {
-	if (is_ntb_atom(ndev)) {
-		cancel_delayed_work_sync(&ndev->hb_timer);
-		cancel_delayed_work_sync(&ndev->lr_timer);
-	}
+	return ndev_ignore_unsafe(ntb_ndev(ntb), NTB_UNSAFE_DB);
 }
 
-static irqreturn_t bwd_callback_msix_irq(int irq, void *data)
+static u64 intel_ntb_db_valid_mask(struct ntb_dev *ntb)
 {
-	struct ntb_db_cb *db_cb = data;
-	struct ntb_device *ndev = db_cb->ndev;
-	unsigned long mask;
+	return ntb_ndev(ntb)->db_valid_mask;
+}
 
-	dev_dbg(&ndev->pdev->dev, "MSI-X irq %d received for DB %d\n", irq,
-		db_cb->db_num);
+static int intel_ntb_db_vector_count(struct ntb_dev *ntb)
+{
+	struct intel_ntb_dev *ndev;
 
-	mask = readw(ndev->reg_ofs.ldb_mask);
-	set_bit(db_cb->db_num * ndev->bits_per_vector, &mask);
-	writew(mask, ndev->reg_ofs.ldb_mask);
+	ndev = container_of(ntb, struct intel_ntb_dev, ntb);
 
-	tasklet_schedule(&db_cb->irq_work);
+	return ndev->db_vec_count;
+}
 
-	/* No need to check for the specific HB irq, any interrupt means
-	 * we're connected.
-	 */
-	ndev->last_ts = jiffies;
+static u64 intel_ntb_db_vector_mask(struct ntb_dev *ntb, int db_vector)
+{
+	struct intel_ntb_dev *ndev = ntb_ndev(ntb);
 
-	writeq((u64) 1 << db_cb->db_num, ndev->reg_ofs.ldb);
+	if (db_vector < 0 || db_vector > ndev->db_vec_count)
+		return 0;
 
-	return IRQ_HANDLED;
+	return ndev->db_valid_mask & ndev_vec_mask(ndev, db_vector);
 }
 
-static irqreturn_t xeon_callback_msix_irq(int irq, void *data)
+static u64 intel_ntb_db_read(struct ntb_dev *ntb)
 {
-	struct ntb_db_cb *db_cb = data;
-	struct ntb_device *ndev = db_cb->ndev;
-	unsigned long mask;
+	struct intel_ntb_dev *ndev = ntb_ndev(ntb);
 
-	dev_dbg(&ndev->pdev->dev, "MSI-X irq %d received for DB %d\n", irq,
-		db_cb->db_num);
+	return ndev_db_read(ndev,
+			    ndev->self_mmio +
+			    ndev->self_reg->db_bell);
+}
 
-	mask = readw(ndev->reg_ofs.ldb_mask);
-	set_bit(db_cb->db_num * ndev->bits_per_vector, &mask);
-	writew(mask, ndev->reg_ofs.ldb_mask);
+static int intel_ntb_db_clear(struct ntb_dev *ntb, u64 db_bits)
+{
+	struct intel_ntb_dev *ndev = ntb_ndev(ntb);
 
-	tasklet_schedule(&db_cb->irq_work);
+	return ndev_db_write(ndev, db_bits,
+			     ndev->self_mmio +
+			     ndev->self_reg->db_bell);
+}
 
-	/* On Sandybridge, there are 16 bits in the interrupt register
-	 * but only 4 vectors.  So, 5 bits are assigned to the first 3
-	 * vectors, with the 4th having a single bit for link
-	 * interrupts.
-	 */
-	writew(((1 << ndev->bits_per_vector) - 1) <<
-	       (db_cb->db_num * ndev->bits_per_vector), ndev->reg_ofs.ldb);
+static int intel_ntb_db_set_mask(struct ntb_dev *ntb, u64 db_bits)
+{
+	struct intel_ntb_dev *ndev = ntb_ndev(ntb);
 
-	return IRQ_HANDLED;
+	return ndev_db_set_mask(ndev, db_bits,
+				ndev->self_mmio +
+				ndev->self_reg->db_mask);
 }
 
-/* Since we do not have a HW doorbell in BWD, this is only used in JF/JT */
-static irqreturn_t xeon_event_msix_irq(int irq, void *dev)
+static int intel_ntb_db_clear_mask(struct ntb_dev *ntb, u64 db_bits)
 {
-	struct ntb_device *ndev = dev;
-	int rc;
-
-	dev_dbg(&ndev->pdev->dev, "MSI-X irq %d received for Events\n", irq);
+	struct intel_ntb_dev *ndev = ntb_ndev(ntb);
 
-	rc = ntb_link_status(ndev);
-	if (rc)
-		dev_err(&ndev->pdev->dev, "Error determining link status\n");
+	return ndev_db_clear_mask(ndev, db_bits,
+				  ndev->self_mmio +
+				  ndev->self_reg->db_mask);
+}
 
-	/* bit 15 is always the link bit */
-	writew(1 << SNB_LINK_DB, ndev->reg_ofs.ldb);
+static int intel_ntb_peer_db_addr(struct ntb_dev *ntb,
+				  phys_addr_t *db_addr,
+				  resource_size_t *db_size)
+{
+	struct intel_ntb_dev *ndev = ntb_ndev(ntb);
 
-	return IRQ_HANDLED;
+	return ndev_db_addr(ndev, db_addr, db_size, ndev->peer_addr,
+			    ndev->peer_reg->db_bell);
 }
 
-static irqreturn_t ntb_interrupt(int irq, void *dev)
+static int intel_ntb_peer_db_set(struct ntb_dev *ntb, u64 db_bits)
 {
-	struct ntb_device *ndev = dev;
-	unsigned int i = 0;
+	struct intel_ntb_dev *ndev = ntb_ndev(ntb);
 
-	if (is_ntb_atom(ndev)) {
-		u64 ldb = readq(ndev->reg_ofs.ldb);
+	return ndev_db_write(ndev, db_bits,
+			     ndev->peer_mmio +
+			     ndev->peer_reg->db_bell);
+}
 
-		dev_dbg(&ndev->pdev->dev, "irq %d - ldb = %Lx\n", irq, ldb);
+static int intel_ntb_spad_is_unsafe(struct ntb_dev *ntb)
+{
+	return ndev_ignore_unsafe(ntb_ndev(ntb), NTB_UNSAFE_SPAD);
+}
 
-		while (ldb) {
-			i = __ffs(ldb);
-			ldb &= ldb - 1;
-			bwd_callback_msix_irq(irq, &ndev->db_cb[i]);
-		}
-	} else {
-		u16 ldb = readw(ndev->reg_ofs.ldb);
+static int intel_ntb_spad_count(struct ntb_dev *ntb)
+{
+	struct intel_ntb_dev *ndev;
 
-		dev_dbg(&ndev->pdev->dev, "irq %d - ldb = %x\n", irq, ldb);
+	ndev = container_of(ntb, struct intel_ntb_dev, ntb);
 
-		if (ldb & SNB_DB_HW_LINK) {
-			xeon_event_msix_irq(irq, dev);
-			ldb &= ~SNB_DB_HW_LINK;
-		}
+	return ndev->spad_count;
+}
 
-		while (ldb) {
-			i = __ffs(ldb);
-			ldb &= ldb - 1;
-			xeon_callback_msix_irq(irq, &ndev->db_cb[i]);
-		}
-	}
+static u32 intel_ntb_spad_read(struct ntb_dev *ntb, int idx)
+{
+	struct intel_ntb_dev *ndev = ntb_ndev(ntb);
 
-	return IRQ_HANDLED;
+	return ndev_spad_read(ndev, idx,
+			      ndev->self_mmio +
+			      ndev->self_reg->spad);
 }
 
-static int ntb_setup_snb_msix(struct ntb_device *ndev, int msix_entries)
+static int intel_ntb_spad_write(struct ntb_dev *ntb,
+				int idx, u32 val)
 {
-	struct pci_dev *pdev = ndev->pdev;
-	struct msix_entry *msix;
-	int rc, i;
+	struct intel_ntb_dev *ndev = ntb_ndev(ntb);
 
-	if (msix_entries < ndev->limits.msix_cnt)
-		return -ENOSPC;
+	return ndev_spad_write(ndev, idx, val,
+			       ndev->self_mmio +
+			       ndev->self_reg->spad);
+}
 
-	rc = pci_enable_msix_exact(pdev, ndev->msix_entries, msix_entries);
-	if (rc < 0)
-		return rc;
+static int intel_ntb_peer_spad_addr(struct ntb_dev *ntb, int idx,
+				    phys_addr_t *spad_addr)
+{
+	struct intel_ntb_dev *ndev = ntb_ndev(ntb);
 
-	for (i = 0; i < msix_entries; i++) {
-		msix = &ndev->msix_entries[i];
-		WARN_ON(!msix->vector);
+	return ndev_spad_addr(ndev, idx, spad_addr, ndev->peer_addr,
+			      ndev->peer_reg->spad);
+}
 
-		if (i == msix_entries - 1) {
-			rc = request_irq(msix->vector,
-					 xeon_event_msix_irq, 0,
-					 "ntb-event-msix", ndev);
-			if (rc)
-				goto err;
-		} else {
-			rc = request_irq(msix->vector,
-					 xeon_callback_msix_irq, 0,
-					 "ntb-callback-msix",
-					 &ndev->db_cb[i]);
-			if (rc)
-				goto err;
-		}
-	}
+static u32 intel_ntb_peer_spad_read(struct ntb_dev *ntb, int idx)
+{
+	struct intel_ntb_dev *ndev = ntb_ndev(ntb);
 
-	ndev->num_msix = msix_entries;
-	ndev->max_cbs = msix_entries - 1;
+	return ndev_spad_read(ndev, idx,
+			      ndev->peer_mmio +
+			      ndev->peer_reg->spad);
+}
 
-	return 0;
+static int intel_ntb_peer_spad_write(struct ntb_dev *ntb,
+				     int idx, u32 val)
+{
+	struct intel_ntb_dev *ndev = ntb_ndev(ntb);
 
-err:
-	while (--i >= 0) {
-		/* Code never reaches here for entry nr 'ndev->num_msix - 1' */
-		msix = &ndev->msix_entries[i];
-		free_irq(msix->vector, &ndev->db_cb[i]);
-	}
+	return ndev_spad_write(ndev, idx, val,
+			       ndev->peer_mmio +
+			       ndev->peer_reg->spad);
+}
 
-	pci_disable_msix(pdev);
-	ndev->num_msix = 0;
+/* BWD */
 
-	return rc;
+static u64 bwd_db_ioread(void __iomem *mmio)
+{
+	return ioread64(mmio);
 }
 
-static int ntb_setup_bwd_msix(struct ntb_device *ndev, int msix_entries)
+static void bwd_db_iowrite(u64 bits, void __iomem *mmio)
 {
-	struct pci_dev *pdev = ndev->pdev;
-	struct msix_entry *msix;
-	int rc, i;
+	iowrite64(bits, mmio);
+}
 
-	msix_entries = pci_enable_msix_range(pdev, ndev->msix_entries,
-					     1, msix_entries);
-	if (msix_entries < 0)
-		return msix_entries;
+static int bwd_poll_link(struct intel_ntb_dev *ndev)
+{
+	u32 ntb_ctl;
 
-	for (i = 0; i < msix_entries; i++) {
-		msix = &ndev->msix_entries[i];
-		WARN_ON(!msix->vector);
+	ntb_ctl = ioread32(ndev->self_mmio + BWD_NTBCNTL_OFFSET);
 
-		rc = request_irq(msix->vector, bwd_callback_msix_irq, 0,
-				 "ntb-callback-msix", &ndev->db_cb[i]);
-		if (rc)
-			goto err;
-	}
+	if (ntb_ctl == ndev->ntb_ctl)
+		return 0;
 
-	ndev->num_msix = msix_entries;
-	ndev->max_cbs = msix_entries;
+	ndev->ntb_ctl = ntb_ctl;
 
-	return 0;
+	ndev->lnk_sta = ioread32(ndev->self_mmio + BWD_LINK_STATUS_OFFSET);
 
-err:
-	while (--i >= 0)
-		free_irq(msix->vector, &ndev->db_cb[i]);
+	return 1;
+}
 
-	pci_disable_msix(pdev);
-	ndev->num_msix = 0;
+static int bwd_link_is_up(struct intel_ntb_dev *ndev)
+{
+	return BWD_NTB_CTL_ACTIVE(ndev->ntb_ctl);
+}
 
-	return rc;
+static int bwd_link_is_err(struct intel_ntb_dev *ndev)
+{
+	if (ioread32(ndev->self_mmio + BWD_LTSSMSTATEJMP_OFFSET)
+	    & BWD_LTSSMSTATEJMP_FORCEDETECT)
+		return 1;
+
+	if (ioread32(ndev->self_mmio + BWD_IBSTERRRCRVSTS0_OFFSET)
+	    & BWD_IBIST_ERR_OFLOW)
+		return 1;
+
+	return 0;
 }
 
-static int ntb_setup_msix(struct ntb_device *ndev)
+static inline enum ntb_topo bwd_ppd_topo(struct intel_ntb_dev *ndev, u32 ppd)
 {
-	struct pci_dev *pdev = ndev->pdev;
-	int msix_entries;
-	int rc, i;
+	switch (ppd & BWD_PPD_TOPO_MASK) {
+	case BWD_PPD_TOPO_B2B_USD:
+		dev_dbg(ndev_dev(ndev), "PPD %d B2B USD\n", ppd);
+		return NTB_TOPO_B2B_USD;
+
+	case BWD_PPD_TOPO_B2B_DSD:
+		dev_dbg(ndev_dev(ndev), "PPD %d B2B DSD\n", ppd);
+		return NTB_TOPO_B2B_DSD;
+
+	case BWD_PPD_TOPO_PRI_USD:
+	case BWD_PPD_TOPO_PRI_DSD: /* accept bogus PRI_DSD */
+	case BWD_PPD_TOPO_SEC_USD:
+	case BWD_PPD_TOPO_SEC_DSD: /* accept bogus SEC_DSD */
+		dev_dbg(ndev_dev(ndev), "PPD %d non B2B disabled\n", ppd);
+		return NTB_TOPO_NONE;
+	}
 
-	msix_entries = pci_msix_vec_count(pdev);
-	if (msix_entries < 0) {
-		rc = msix_entries;
-		goto err;
-	} else if (msix_entries > ndev->limits.msix_cnt) {
-		rc = -EINVAL;
-		goto err;
+	dev_dbg(ndev_dev(ndev), "PPD %d invalid\n", ppd);
+	return NTB_TOPO_NONE;
+}
+
+static void bwd_link_hb(struct work_struct *work)
+{
+	struct intel_ntb_dev *ndev = hb_ndev(work);
+	unsigned long poll_ts;
+	void __iomem *mmio;
+	u32 status32;
+
+	poll_ts = ndev->last_ts + BWD_LINK_HB_TIMEOUT;
+
+	/* Delay polling the link status if an interrupt was received,
+	 * unless the cached link status says the link is down.
+	 */
+	if (time_after(poll_ts, jiffies) && bwd_link_is_up(ndev)) {
+		schedule_delayed_work(&ndev->hb_timer, poll_ts - jiffies);
+		return;
 	}
 
-	ndev->msix_entries = kmalloc(sizeof(struct msix_entry) * msix_entries,
-				     GFP_KERNEL);
-	if (!ndev->msix_entries) {
-		rc = -ENOMEM;
-		goto err;
+	if (bwd_poll_link(ndev))
+		ntb_link_event(&ndev->ntb);
+
+	if (bwd_link_is_up(ndev) || !bwd_link_is_err(ndev)) {
+		schedule_delayed_work(&ndev->hb_timer, BWD_LINK_HB_TIMEOUT);
+		return;
 	}
 
-	for (i = 0; i < msix_entries; i++)
-		ndev->msix_entries[i].entry = i;
+	/* Link is down with error: recover the link! */
 
-	if (is_ntb_atom(ndev))
-		rc = ntb_setup_bwd_msix(ndev, msix_entries);
-	else
-		rc = ntb_setup_snb_msix(ndev, msix_entries);
-	if (rc)
-		goto err1;
+	mmio = ndev->self_mmio;
 
-	return 0;
+	/* Driver resets the NTB ModPhy lanes - magic! */
+	iowrite8(0xe0, mmio + BWD_MODPHY_PCSREG6);
+	iowrite8(0x40, mmio + BWD_MODPHY_PCSREG4);
+	iowrite8(0x60, mmio + BWD_MODPHY_PCSREG4);
+	iowrite8(0x60, mmio + BWD_MODPHY_PCSREG6);
 
-err1:
-	kfree(ndev->msix_entries);
-err:
-	dev_err(&pdev->dev, "Error allocating MSI-X interrupt\n");
-	return rc;
+	/* Driver waits 100ms to allow the NTB ModPhy to settle */
+	msleep(100);
+
+	/* Clear AER Errors, write to clear */
+	status32 = ioread32(mmio + BWD_ERRCORSTS_OFFSET);
+	dev_dbg(ndev_dev(ndev), "ERRCORSTS = %x\n", status32);
+	status32 &= PCI_ERR_COR_REP_ROLL;
+	iowrite32(status32, mmio + BWD_ERRCORSTS_OFFSET);
+
+	/* Clear unexpected electrical idle event in LTSSM, write to clear */
+	status32 = ioread32(mmio + BWD_LTSSMERRSTS0_OFFSET);
+	dev_dbg(ndev_dev(ndev), "LTSSMERRSTS0 = %x\n", status32);
+	status32 |= BWD_LTSSMERRSTS0_UNEXPECTEDEI;
+	iowrite32(status32, mmio + BWD_LTSSMERRSTS0_OFFSET);
+
+	/* Clear DeSkew Buffer error, write to clear */
+	status32 = ioread32(mmio + BWD_DESKEWSTS_OFFSET);
+	dev_dbg(ndev_dev(ndev), "DESKEWSTS = %x\n", status32);
+	status32 |= BWD_DESKEWSTS_DBERR;
+	iowrite32(status32, mmio + BWD_DESKEWSTS_OFFSET);
+
+	status32 = ioread32(mmio + BWD_IBSTERRRCRVSTS0_OFFSET);
+	dev_dbg(ndev_dev(ndev), "IBSTERRRCRVSTS0 = %x\n", status32);
+	status32 &= BWD_IBIST_ERR_OFLOW;
+	iowrite32(status32, mmio + BWD_IBSTERRRCRVSTS0_OFFSET);
+
+	/* Releases the NTB state machine to allow the link to retrain */
+	status32 = ioread32(mmio + BWD_LTSSMSTATEJMP_OFFSET);
+	dev_dbg(ndev_dev(ndev), "LTSSMSTATEJMP = %x\n", status32);
+	status32 &= ~BWD_LTSSMSTATEJMP_FORCEDETECT;
+	iowrite32(status32, mmio + BWD_LTSSMSTATEJMP_OFFSET);
+
+	/* There is a potential race between the 2 NTB devices recovering at the
+	 * same time.  If the times are the same, the link will not recover and
+	 * the driver will be stuck in this loop forever.  Add a random interval
+	 * to the recovery time to prevent this race.
+	 */
+	schedule_delayed_work(&ndev->hb_timer, BWD_LINK_RECOVERY_TIME
+			      + prandom_u32() % BWD_LINK_RECOVERY_TIME);
 }
 
-static int ntb_setup_msi(struct ntb_device *ndev)
+static int bwd_init_isr(struct intel_ntb_dev *ndev)
 {
-	struct pci_dev *pdev = ndev->pdev;
 	int rc;
 
-	rc = pci_enable_msi(pdev);
+	rc = ndev_init_isr(ndev, 1, BWD_DB_MSIX_VECTOR_COUNT,
+			   BWD_DB_MSIX_VECTOR_SHIFT, BWD_DB_TOTAL_SHIFT);
 	if (rc)
 		return rc;
 
-	rc = request_irq(pdev->irq, ntb_interrupt, 0, "ntb-msi", ndev);
-	if (rc) {
-		pci_disable_msi(pdev);
-		dev_err(&pdev->dev, "Error allocating MSI interrupt\n");
-		return rc;
-	}
+	/* BWD doesn't have link status interrupt, poll on that platform */
+	ndev->last_ts = jiffies;
+	INIT_DELAYED_WORK(&ndev->hb_timer, bwd_link_hb);
+	schedule_delayed_work(&ndev->hb_timer, BWD_LINK_HB_TIMEOUT);
 
 	return 0;
 }
 
-static int ntb_setup_intx(struct ntb_device *ndev)
+static void bwd_deinit_isr(struct intel_ntb_dev *ndev)
 {
-	struct pci_dev *pdev = ndev->pdev;
-	int rc;
+	cancel_delayed_work_sync(&ndev->hb_timer);
+	ndev_deinit_isr(ndev);
+}
 
-	pci_msi_off(pdev);
+static int bwd_init_ntb(struct intel_ntb_dev *ndev)
+{
+	ndev->mw_count = BWD_MW_COUNT;
+	ndev->spad_count = BWD_SPAD_COUNT;
+	ndev->db_count = BWD_DB_COUNT;
 
-	/* Verify intx is enabled */
-	pci_intx(pdev, 1);
+	switch (ndev->ntb.topo) {
+	case NTB_TOPO_B2B_USD:
+	case NTB_TOPO_B2B_DSD:
+		ndev->self_reg = &bwd_pri_reg;
+		ndev->peer_reg = &bwd_b2b_reg;
+		ndev->xlat_reg = &bwd_sec_xlat;
 
-	rc = request_irq(pdev->irq, ntb_interrupt, IRQF_SHARED, "ntb-intx",
-			 ndev);
-	if (rc)
-		return rc;
+		/* Enable Bus Master and Memory Space on the secondary side */
+		iowrite16(PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER,
+			  ndev->self_mmio + BWD_SPCICMD_OFFSET);
+
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	ndev->db_valid_mask = BIT_ULL(ndev->db_count) - 1;
 
 	return 0;
 }
 
-static int ntb_setup_interrupts(struct ntb_device *ndev)
+static int bwd_init_dev(struct intel_ntb_dev *ndev)
 {
+	u32 ppd;
 	int rc;
 
-	/* On BWD, disable all interrupts.  On SNB, disable all but Link
-	 * Interrupt.  The rest will be unmasked as callbacks are registered.
-	 */
-	if (is_ntb_atom(ndev))
-		writeq(~0, ndev->reg_ofs.ldb_mask);
-	else {
-		u16 var = 1 << SNB_LINK_DB;
-		writew(~var, ndev->reg_ofs.ldb_mask);
-	}
-
-	rc = ntb_setup_msix(ndev);
-	if (!rc)
-		goto done;
+	rc = pci_read_config_dword(ndev->ntb.pdev, BWD_PPD_OFFSET, &ppd);
+	if (rc)
+		return -EIO;
 
-	ndev->bits_per_vector = 1;
-	ndev->max_cbs = ndev->limits.max_db_bits;
+	ndev->ntb.topo = bwd_ppd_topo(ndev, ppd);
+	if (ndev->ntb.topo == NTB_TOPO_NONE)
+		return -EINVAL;
 
-	rc = ntb_setup_msi(ndev);
-	if (!rc)
-		goto done;
+	rc = bwd_init_ntb(ndev);
+	if (rc)
+		return rc;
 
-	rc = ntb_setup_intx(ndev);
-	if (rc) {
-		dev_err(&ndev->pdev->dev, "no usable interrupts\n");
+	rc = bwd_init_isr(ndev);
+	if (rc)
 		return rc;
+
+	if (ndev->ntb.topo != NTB_TOPO_SEC) {
+		/* Initiate PCI-E link training */
+		rc = pci_write_config_dword(ndev->ntb.pdev, BWD_PPD_OFFSET,
+					    ppd | BWD_PPD_INIT_LINK);
+		if (rc)
+			return rc;
 	}
 
-done:
 	return 0;
 }
 
-static void ntb_free_interrupts(struct ntb_device *ndev)
+static void bwd_deinit_dev(struct intel_ntb_dev *ndev)
 {
-	struct pci_dev *pdev = ndev->pdev;
+	bwd_deinit_isr(ndev);
+}
 
-	/* mask interrupts */
-	if (is_ntb_atom(ndev))
-		writeq(~0, ndev->reg_ofs.ldb_mask);
-	else
-		writew(~0, ndev->reg_ofs.ldb_mask);
+/* SNB */
 
-	if (ndev->num_msix) {
-		struct msix_entry *msix;
-		u32 i;
+static u64 snb_db_ioread(void __iomem *mmio)
+{
+	return (u64)ioread16(mmio);
+}
 
-		for (i = 0; i < ndev->num_msix; i++) {
-			msix = &ndev->msix_entries[i];
-			if (is_ntb_xeon(ndev) && i == ndev->num_msix - 1)
-				free_irq(msix->vector, ndev);
-			else
-				free_irq(msix->vector, &ndev->db_cb[i]);
-		}
-		pci_disable_msix(pdev);
-		kfree(ndev->msix_entries);
-	} else {
-		free_irq(pdev->irq, ndev);
+static void snb_db_iowrite(u64 bits, void __iomem *mmio)
+{
+	iowrite16((u16)bits, mmio);
+}
 
-		if (pci_dev_msi_enabled(pdev))
-			pci_disable_msi(pdev);
-	}
+static int snb_poll_link(struct intel_ntb_dev *ndev)
+{
+	u16 reg_val;
+	int rc;
+
+	ndev->reg->db_iowrite(ndev->db_link_mask,
+			      ndev->self_mmio +
+			      ndev->self_reg->db_bell);
+
+	rc = pci_read_config_word(ndev->ntb.pdev,
+				  SNB_LINK_STATUS_OFFSET, &reg_val);
+	if (rc)
+		return 0;
+
+	if (reg_val == ndev->lnk_sta)
+		return 0;
+
+	ndev->lnk_sta = reg_val;
+
+	return 1;
 }
 
-static int ntb_create_callbacks(struct ntb_device *ndev)
+static int snb_link_is_up(struct intel_ntb_dev *ndev)
 {
-	int i;
+	return NTB_LNK_STA_ACTIVE(ndev->lnk_sta);
+}
 
-	/* Chicken-egg issue.  We won't know how many callbacks are necessary
-	 * until we see how many MSI-X vectors we get, but these pointers need
-	 * to be passed into the MSI-X register function.  So, we allocate the
-	 * max, knowing that they might not all be used, to work around this.
-	 */
-	ndev->db_cb = kcalloc(ndev->limits.max_db_bits,
-			      sizeof(struct ntb_db_cb),
-			      GFP_KERNEL);
-	if (!ndev->db_cb)
-		return -ENOMEM;
+static inline enum ntb_topo snb_ppd_topo(struct intel_ntb_dev *ndev, u8 ppd)
+{
+	switch (ppd & SNB_PPD_TOPO_MASK) {
+	case SNB_PPD_TOPO_B2B_USD:
+		return NTB_TOPO_B2B_USD;
+
+	case SNB_PPD_TOPO_B2B_DSD:
+		return NTB_TOPO_B2B_DSD;
 
-	for (i = 0; i < ndev->limits.max_db_bits; i++) {
-		ndev->db_cb[i].db_num = i;
-		ndev->db_cb[i].ndev = ndev;
+	case SNB_PPD_TOPO_PRI_USD:
+	case SNB_PPD_TOPO_PRI_DSD: /* accept bogus PRI_DSD */
+		return NTB_TOPO_PRI;
+
+	case SNB_PPD_TOPO_SEC_USD:
+	case SNB_PPD_TOPO_SEC_DSD: /* accept bogus SEC_DSD */
+		return NTB_TOPO_SEC;
 	}
 
-	return 0;
+	return NTB_TOPO_NONE;
 }
 
-static void ntb_free_callbacks(struct ntb_device *ndev)
+static inline int snb_ppd_bar4_split(struct intel_ntb_dev *ndev, u8 ppd)
 {
-	int i;
+	if (ppd & SNB_PPD_SPLIT_BAR_MASK) {
+		dev_dbg(ndev_dev(ndev), "PPD %d split bar\n", ppd);
+		return 1;
+	}
+	return 0;
+}
 
-	for (i = 0; i < ndev->limits.max_db_bits; i++)
-		ntb_unregister_db_callback(ndev, i);
+static int snb_init_isr(struct intel_ntb_dev *ndev)
+{
+	return ndev_init_isr(ndev, SNB_DB_MSIX_VECTOR_COUNT,
+			     SNB_DB_MSIX_VECTOR_COUNT,
+			     SNB_DB_MSIX_VECTOR_SHIFT,
+			     SNB_DB_TOTAL_SHIFT);
+}
 
-	kfree(ndev->db_cb);
+static void snb_deinit_isr(struct intel_ntb_dev *ndev)
+{
+	ndev_deinit_isr(ndev);
 }
 
-static ssize_t ntb_debugfs_read(struct file *filp, char __user *ubuf,
-				size_t count, loff_t *offp)
+static int snb_setup_b2b_mw(struct intel_ntb_dev *ndev,
+			    const struct intel_b2b_addr *addr,
+			    const struct intel_b2b_addr *peer_addr)
 {
-	struct ntb_device *ndev;
-	char *buf;
-	ssize_t ret, offset, out_count;
+	struct pci_dev *pdev;
+	void __iomem *mmio;
+	unsigned long off;
+	resource_size_t bar_size;
+	phys_addr_t bar_addr;
+	int b2b_bar;
+	u8 bar_sz;
+
+	pdev = ndev_pdev(ndev);
+	mmio = ndev->self_mmio;
+
+	if (ndev->b2b_idx >= ndev->mw_count) {
+		dev_dbg(ndev_dev(ndev), "not using b2b mw\n");
+		b2b_bar = 0;
+		ndev->b2b_off = 0;
+	} else {
+		b2b_bar = ndev_mw_to_bar(ndev, ndev->b2b_idx);
+		if (b2b_bar < 0)
+			return -EIO;
 
-	out_count = 500;
+		dev_dbg(ndev_dev(ndev), "using b2b mw bar %d\n", b2b_bar);
 
-	buf = kmalloc(out_count, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
+		bar_size = pci_resource_len(ndev->ntb.pdev, b2b_bar);
 
-	ndev = filp->private_data;
-	offset = 0;
-	offset += snprintf(buf + offset, out_count - offset,
-			   "NTB Device Information:\n");
-	offset += snprintf(buf + offset, out_count - offset,
-			   "Connection Type - \t\t%s\n",
-			   ndev->conn_type == NTB_CONN_TRANSPARENT ?
-			   "Transparent" : (ndev->conn_type == NTB_CONN_B2B) ?
-			   "Back to back" : "Root Port");
-	offset += snprintf(buf + offset, out_count - offset,
-			   "Device Type - \t\t\t%s\n",
-			   ndev->dev_type == NTB_DEV_USD ?
-			   "DSD/USP" : "USD/DSP");
-	offset += snprintf(buf + offset, out_count - offset,
-			   "Max Number of Callbacks - \t%u\n",
-			   ntb_max_cbs(ndev));
-	offset += snprintf(buf + offset, out_count - offset,
-			   "Link Status - \t\t\t%s\n",
-			   ntb_hw_link_status(ndev) ? "Up" : "Down");
-	if (ntb_hw_link_status(ndev)) {
-		offset += snprintf(buf + offset, out_count - offset,
-				   "Link Speed - \t\t\tPCI-E Gen %u\n",
-				   ndev->link_speed);
-		offset += snprintf(buf + offset, out_count - offset,
-				   "Link Width - \t\t\tx%u\n",
-				   ndev->link_width);
-	}
+		dev_dbg(ndev_dev(ndev), "b2b bar size %#llx\n", bar_size);
 
-	if (is_ntb_xeon(ndev)) {
-		u32 status32;
-		u16 status16;
-		int rc;
-
-		offset += snprintf(buf + offset, out_count - offset,
-				   "\nNTB Device Statistics:\n");
-		offset += snprintf(buf + offset, out_count - offset,
-				   "Upstream Memory Miss - \t%u\n",
-				   readw(ndev->reg_base +
-					 SNB_USMEMMISS_OFFSET));
-
-		offset += snprintf(buf + offset, out_count - offset,
-				   "\nNTB Hardware Errors:\n");
-
-		rc = pci_read_config_word(ndev->pdev, SNB_DEVSTS_OFFSET,
-					  &status16);
-		if (!rc)
-			offset += snprintf(buf + offset, out_count - offset,
-					   "DEVSTS - \t%#06x\n", status16);
-
-		rc = pci_read_config_word(ndev->pdev, SNB_LINK_STATUS_OFFSET,
-					  &status16);
-		if (!rc)
-			offset += snprintf(buf + offset, out_count - offset,
-					   "LNKSTS - \t%#06x\n", status16);
-
-		rc = pci_read_config_dword(ndev->pdev, SNB_UNCERRSTS_OFFSET,
-					   &status32);
-		if (!rc)
-			offset += snprintf(buf + offset, out_count - offset,
-					   "UNCERRSTS - \t%#010x\n", status32);
-
-		rc = pci_read_config_dword(ndev->pdev, SNB_CORERRSTS_OFFSET,
-					   &status32);
-		if (!rc)
-			offset += snprintf(buf + offset, out_count - offset,
-					   "CORERRSTS - \t%#010x\n", status32);
+		if (b2b_mw_share && SNB_B2B_MIN_SIZE <= bar_size >> 1) {
+			dev_dbg(ndev_dev(ndev),
+				"b2b using first half of bar\n");
+			ndev->b2b_off = bar_size >> 1;
+		} else if (SNB_B2B_MIN_SIZE <= bar_size) {
+			dev_dbg(ndev_dev(ndev),
+				"b2b using whole bar\n");
+			ndev->b2b_off = 0;
+			--ndev->mw_count;
+		} else {
+			dev_dbg(ndev_dev(ndev),
+				"b2b bar size is too small\n");
+			return -EIO;
+		}
 	}
 
-	if (offset > out_count)
-		offset = out_count;
+	/* Reset the secondary bar sizes to match the primary bar sizes,
+	 * except disable or halve the size of the b2b secondary bar.
+	 *
+	 * Note: code for each specific bar size register, because the register
+	 * offsets are not in a consistent order (bar5sz comes after ppd, odd).
+	 */
+	pci_read_config_byte(pdev, SNB_PBAR23SZ_OFFSET, &bar_sz);
+	dev_dbg(ndev_dev(ndev), "PBAR23SZ %#x\n", bar_sz);
+	if (b2b_bar == 2) {
+		if (ndev->b2b_off)
+			bar_sz -= 1;
+		else
+			bar_sz = 0;
+	}
+	pci_write_config_byte(pdev, SNB_SBAR23SZ_OFFSET, bar_sz);
+	pci_read_config_byte(pdev, SNB_SBAR23SZ_OFFSET, &bar_sz);
+	dev_dbg(ndev_dev(ndev), "SBAR23SZ %#x\n", bar_sz);
+
+	if (!ndev->bar4_split) {
+		pci_read_config_byte(pdev, SNB_PBAR45SZ_OFFSET, &bar_sz);
+		dev_dbg(ndev_dev(ndev), "PBAR45SZ %#x\n", bar_sz);
+		if (b2b_bar == 4) {
+			if (ndev->b2b_off)
+				bar_sz -= 1;
+			else
+				bar_sz = 0;
+		}
+		pci_write_config_byte(pdev, SNB_SBAR45SZ_OFFSET, bar_sz);
+		pci_read_config_byte(pdev, SNB_SBAR45SZ_OFFSET, &bar_sz);
+		dev_dbg(ndev_dev(ndev), "SBAR45SZ %#x\n", bar_sz);
+	} else {
+		pci_read_config_byte(pdev, SNB_PBAR4SZ_OFFSET, &bar_sz);
+		dev_dbg(ndev_dev(ndev), "PBAR4SZ %#x\n", bar_sz);
+		if (b2b_bar == 4) {
+			if (ndev->b2b_off)
+				bar_sz -= 1;
+			else
+				bar_sz = 0;
+		}
+		pci_write_config_byte(pdev, SNB_SBAR4SZ_OFFSET, bar_sz);
+		pci_read_config_byte(pdev, SNB_SBAR4SZ_OFFSET, &bar_sz);
+		dev_dbg(ndev_dev(ndev), "SBAR4SZ %#x\n", bar_sz);
+
+		pci_read_config_byte(pdev, SNB_PBAR5SZ_OFFSET, &bar_sz);
+		dev_dbg(ndev_dev(ndev), "PBAR5SZ %#x\n", bar_sz);
+		if (b2b_bar == 5) {
+			if (ndev->b2b_off)
+				bar_sz -= 1;
+			else
+				bar_sz = 0;
+		}
+		pci_write_config_byte(pdev, SNB_SBAR5SZ_OFFSET, bar_sz);
+		pci_read_config_byte(pdev, SNB_SBAR5SZ_OFFSET, &bar_sz);
+		dev_dbg(ndev_dev(ndev), "SBAR5SZ %#x\n", bar_sz);
+	}
 
-	ret = simple_read_from_buffer(ubuf, count, offp, buf, offset);
-	kfree(buf);
-	return ret;
-}
+	/* setup incoming bar base addresses */
+	off = SNB_SBAR0BASE_OFFSET;
+
+	/* SBAR01 hit by first part of the b2b bar */
+	if (b2b_bar == 0) {
+		bar_addr = addr->bar0_addr;
+	} else if (b2b_bar == 2) {
+		bar_addr = addr->bar2_addr64;
+	} else if (b2b_bar == 4 && !ndev->bar4_split) {
+		bar_addr = addr->bar4_addr64;
+	} else if (b2b_bar == 4) {
+		bar_addr = addr->bar4_addr32;
+	} else if (b2b_bar == 5) {
+		bar_addr = addr->bar5_addr32;
+	} else {
+		bar_addr = 0;
+		BUG();
+	}
 
-static const struct file_operations ntb_debugfs_info = {
-	.owner = THIS_MODULE,
-	.open = simple_open,
-	.read = ntb_debugfs_read,
-};
+	dev_dbg(ndev_dev(ndev), "SBAR01 %#018llx\n", bar_addr);
+	iowrite64(bar_addr, mmio + bar0_off(off, 0));
 
-static void ntb_setup_debugfs(struct ntb_device *ndev)
-{
-	if (!debugfs_initialized())
-		return;
+	/* Other SBAR are normally hit by the PBAR xlat, except for b2b bar.
+	 * The b2b bar is either disabled above, or configured half-size, and
+	 * it starts at the PBAR xlat + offset.
+	 */
 
-	if (!debugfs_dir)
-		debugfs_dir = debugfs_create_dir(KBUILD_MODNAME, NULL);
+	bar_addr = addr->bar2_addr64 + (b2b_bar == 2 ? ndev->b2b_off : 0);
+	iowrite64(bar_addr, mmio + bar0_off(off, 2));
+	bar_addr = ioread64(mmio + bar0_off(off, 2));
+	dev_dbg(ndev_dev(ndev), "SBAR23 %#018llx\n", bar_addr);
+
+	if (!ndev->bar4_split) {
+		bar_addr = addr->bar4_addr64 +
+			(b2b_bar == 4 ? ndev->b2b_off : 0);
+		iowrite64(bar_addr, mmio + bar0_off(off, 4));
+		bar_addr = ioread64(mmio + bar0_off(off, 4));
+		dev_dbg(ndev_dev(ndev), "SBAR45 %#018llx\n", bar_addr);
+	} else {
+		bar_addr = addr->bar4_addr32 +
+			(b2b_bar == 4 ? ndev->b2b_off : 0);
+		iowrite32(bar_addr, mmio + bar0_off(off, 4));
+		bar_addr = ioread32(mmio + bar0_off(off, 4));
+		dev_dbg(ndev_dev(ndev), "SBAR4 %#010llx\n", bar_addr);
+
+		bar_addr = addr->bar5_addr32 +
+			(b2b_bar == 5 ? ndev->b2b_off : 0);
+		iowrite32(bar_addr, mmio + bar0_off(off, 5));
+		bar_addr = ioread32(mmio + bar0_off(off, 5));
+		dev_dbg(ndev_dev(ndev), "SBAR5 %#010llx\n", bar_addr);
+	}
 
-	ndev->debugfs_dir = debugfs_create_dir(pci_name(ndev->pdev),
-					       debugfs_dir);
-	if (ndev->debugfs_dir)
-		ndev->debugfs_info = debugfs_create_file("info", S_IRUSR,
-							 ndev->debugfs_dir,
-							 ndev,
-							 &ntb_debugfs_info);
-}
+	/* setup incoming bar limits == base addrs (zero length windows) */
+	off = SNB_SBAR2LMT_OFFSET;
 
-static void ntb_free_debugfs(struct ntb_device *ndev)
-{
-	debugfs_remove_recursive(ndev->debugfs_dir);
+	bar_addr = addr->bar2_addr64 + (b2b_bar == 2 ? ndev->b2b_off : 0);
+	iowrite64(bar_addr, mmio + bar2_off(off, 2));
+	bar_addr = ioread64(mmio + bar2_off(off, 2));
+	dev_dbg(ndev_dev(ndev), "SBAR23LMT %#018llx\n", bar_addr);
 
-	if (debugfs_dir && simple_empty(debugfs_dir)) {
-		debugfs_remove_recursive(debugfs_dir);
-		debugfs_dir = NULL;
+	if (!ndev->bar4_split) {
+		bar_addr = addr->bar4_addr64 +
+			(b2b_bar == 4 ? ndev->b2b_off : 0);
+		iowrite64(bar_addr, mmio + bar2_off(off, 4));
+		bar_addr = ioread64(mmio + bar2_off(off, 4));
+		dev_dbg(ndev_dev(ndev), "SBAR45LMT %#018llx\n", bar_addr);
+	} else {
+		bar_addr = addr->bar4_addr32 +
+			(b2b_bar == 4 ? ndev->b2b_off : 0);
+		iowrite32(bar_addr, mmio + bar2_off(off, 4));
+		bar_addr = ioread32(mmio + bar2_off(off, 4));
+		dev_dbg(ndev_dev(ndev), "SBAR4LMT %#010llx\n", bar_addr);
+
+		bar_addr = addr->bar5_addr32 +
+			(b2b_bar == 5 ? ndev->b2b_off : 0);
+		iowrite32(bar_addr, mmio + bar2_off(off, 5));
+		bar_addr = ioread32(mmio + bar2_off(off, 5));
+		dev_dbg(ndev_dev(ndev), "SBAR5LMT %#05llx\n", bar_addr);
 	}
-}
 
-static void ntb_hw_link_up(struct ntb_device *ndev)
-{
-	if (ndev->conn_type == NTB_CONN_TRANSPARENT)
-		ntb_link_event(ndev, NTB_LINK_UP);
-	else {
-		u32 ntb_cntl;
+	/* zero incoming translation addrs */
+	off = SNB_SBAR2XLAT_OFFSET;
 
-		/* Let's bring the NTB link up */
-		ntb_cntl = readl(ndev->reg_ofs.lnk_cntl);
-		ntb_cntl &= ~(NTB_CNTL_LINK_DISABLE | NTB_CNTL_CFG_LOCK);
-		ntb_cntl |= NTB_CNTL_P2S_BAR23_SNOOP | NTB_CNTL_S2P_BAR23_SNOOP;
-		ntb_cntl |= NTB_CNTL_P2S_BAR4_SNOOP | NTB_CNTL_S2P_BAR4_SNOOP;
-		if (ndev->split_bar)
-			ntb_cntl |= NTB_CNTL_P2S_BAR5_SNOOP |
-				    NTB_CNTL_S2P_BAR5_SNOOP;
+	iowrite64(0, mmio + bar2_off(off, 2));
 
-		writel(ntb_cntl, ndev->reg_ofs.lnk_cntl);
+	if (!ndev->bar4_split) {
+		iowrite64(0, mmio + bar2_off(off, 4));
+	} else {
+		iowrite32(0, mmio + bar2_off(off, 4));
+		iowrite32(0, mmio + bar2_off(off, 5));
 	}
-}
 
-static void ntb_hw_link_down(struct ntb_device *ndev)
-{
-	u32 ntb_cntl;
+	/* zero outgoing translation limits (whole bar size windows) */
+	off = SNB_PBAR2LMT_OFFSET;
+	iowrite64(0, mmio + bar2_off(off, 2));
+	if (!ndev->bar4_split) {
+		iowrite64(0, mmio + bar2_off(off, 4));
+	} else {
+		iowrite32(0, mmio + bar2_off(off, 4));
+		iowrite32(0, mmio + bar2_off(off, 5));
+	}
 
-	if (ndev->conn_type == NTB_CONN_TRANSPARENT) {
-		ntb_link_event(ndev, NTB_LINK_DOWN);
-		return;
+	/* set outgoing translation offsets */
+	off = SNB_PBAR2XLAT_OFFSET;
+
+	bar_addr = peer_addr->bar2_addr64;
+	iowrite64(bar_addr, mmio + bar2_off(off, 2));
+	bar_addr = ioread64(mmio + bar2_off(off, 2));
+	dev_dbg(ndev_dev(ndev), "PBAR23XLAT %#018llx\n", bar_addr);
+
+	if (!ndev->bar4_split) {
+		bar_addr = peer_addr->bar4_addr64;
+		iowrite64(bar_addr, mmio + bar2_off(off, 4));
+		bar_addr = ioread64(mmio + bar2_off(off, 4));
+		dev_dbg(ndev_dev(ndev), "PBAR45XLAT %#018llx\n", bar_addr);
+	} else {
+		bar_addr = peer_addr->bar2_addr64;
+		iowrite32(bar_addr, mmio + bar2_off(off, 4));
+		bar_addr = ioread32(mmio + bar2_off(off, 4));
+		dev_dbg(ndev_dev(ndev), "PBAR4XLAT %#010llx\n", bar_addr);
+
+		bar_addr = peer_addr->bar2_addr64;
+		iowrite32(bar_addr, mmio + bar2_off(off, 5));
+		bar_addr = ioread32(mmio + bar2_off(off, 5));
+		dev_dbg(ndev_dev(ndev), "PBAR5XLAT %#010llx\n", bar_addr);
 	}
 
-	/* Bring NTB link down */
-	ntb_cntl = readl(ndev->reg_ofs.lnk_cntl);
-	ntb_cntl &= ~(NTB_CNTL_P2S_BAR23_SNOOP | NTB_CNTL_S2P_BAR23_SNOOP);
-	ntb_cntl &= ~(NTB_CNTL_P2S_BAR4_SNOOP | NTB_CNTL_S2P_BAR4_SNOOP);
-	if (ndev->split_bar)
-		ntb_cntl &= ~(NTB_CNTL_P2S_BAR5_SNOOP |
-			      NTB_CNTL_S2P_BAR5_SNOOP);
-	ntb_cntl |= NTB_CNTL_LINK_DISABLE | NTB_CNTL_CFG_LOCK;
-	writel(ntb_cntl, ndev->reg_ofs.lnk_cntl);
-}
+	/* set the translation offset for b2b registers */
+	if (b2b_bar == 0) {
+		bar_addr = peer_addr->bar0_addr;
+	} else if (b2b_bar == 2) {
+		bar_addr = peer_addr->bar2_addr64;
+	} else if (b2b_bar == 4 && !ndev->bar4_split) {
+		bar_addr = peer_addr->bar4_addr64;
+	} else if (b2b_bar == 4) {
+		bar_addr = peer_addr->bar4_addr32;
+	} else if (b2b_bar == 5) {
+		bar_addr = peer_addr->bar5_addr32;
+	} else {
+		bar_addr = 0;
+		BUG();
+	}
+	/* B2B_XLAT_OFFSET is 64bit, but can only take 32bit writes */
+	dev_dbg(ndev_dev(ndev), "B2BXLAT %#018llx\n", bar_addr);
+	iowrite32(bar_addr, mmio + SNB_B2B_XLAT_OFFSETL);
+	iowrite32(bar_addr >> 32, mmio + SNB_B2B_XLAT_OFFSETU);
+
+	if (b2b_bar) {
+		/* map peer ntb mmio config space registers */
+		ndev->peer_mmio = pci_iomap(pdev, b2b_bar,
+					    SNB_B2B_MIN_SIZE);
+		if (!ndev->peer_mmio)
+			return -EIO;
+	}
 
-static void ntb_max_mw_detect(struct ntb_device *ndev)
-{
-	if (ndev->split_bar)
-		ndev->limits.max_mw = HSX_SPLITBAR_MAX_MW;
-	else
-		ndev->limits.max_mw = SNB_MAX_MW;
+	return 0;
 }
 
-static int ntb_xeon_detect(struct ntb_device *ndev)
+static int snb_init_ntb(struct intel_ntb_dev *ndev)
 {
-	int rc, bars_mask;
-	u32 bars;
-	u8 ppd;
-
-	ndev->hw_type = SNB_HW;
-
-	rc = pci_read_config_byte(ndev->pdev, NTB_PPD_OFFSET, &ppd);
-	if (rc)
-		return -EIO;
+	int rc;
 
-	if (ppd & SNB_PPD_DEV_TYPE)
-		ndev->dev_type = NTB_DEV_USD;
+	if (ndev->bar4_split)
+		ndev->mw_count = HSX_SPLIT_BAR_MW_COUNT;
 	else
-		ndev->dev_type = NTB_DEV_DSD;
+		ndev->mw_count = SNB_MW_COUNT;
 
-	ndev->split_bar = (ppd & SNB_PPD_SPLIT_BAR) ? 1 : 0;
+	ndev->spad_count = SNB_SPAD_COUNT;
+	ndev->db_count = SNB_DB_COUNT;
+	ndev->db_link_mask = SNB_DB_LINK_BIT;
 
-	switch (ppd & SNB_PPD_CONN_TYPE) {
-	case NTB_CONN_B2B:
-		dev_info(&ndev->pdev->dev, "Conn Type = B2B\n");
-		ndev->conn_type = NTB_CONN_B2B;
+	switch (ndev->ntb.topo) {
+	case NTB_TOPO_PRI:
+		if (ndev->hwerr_flags & NTB_HWERR_SDOORBELL_LOCKUP) {
+			dev_err(ndev_dev(ndev), "NTB Primary config disabled\n");
+			return -EINVAL;
+		}
+		/* use half the spads for the peer */
+		ndev->spad_count >>= 1;
+		ndev->self_reg = &snb_pri_reg;
+		ndev->peer_reg = &snb_sec_reg;
+		ndev->xlat_reg = &snb_sec_xlat;
 		break;
-	case NTB_CONN_RP:
-		dev_info(&ndev->pdev->dev, "Conn Type = RP\n");
-		ndev->conn_type = NTB_CONN_RP;
+
+	case NTB_TOPO_SEC:
+		if (ndev->hwerr_flags & NTB_HWERR_SDOORBELL_LOCKUP) {
+			dev_err(ndev_dev(ndev), "NTB Secondary config disabled\n");
+			return -EINVAL;
+		}
+		/* use half the spads for the peer */
+		ndev->spad_count >>= 1;
+		ndev->self_reg = &snb_sec_reg;
+		ndev->peer_reg = &snb_pri_reg;
+		ndev->xlat_reg = &snb_pri_xlat;
 		break;
-	case NTB_CONN_TRANSPARENT:
-		dev_info(&ndev->pdev->dev, "Conn Type = TRANSPARENT\n");
-		ndev->conn_type = NTB_CONN_TRANSPARENT;
-		/*
-		 * This mode is default to USD/DSP. HW does not report
-		 * properly in transparent mode as it has no knowledge of
-		 * NTB. We will just force correct here.
-		 */
-		ndev->dev_type = NTB_DEV_USD;
 
-		/*
-		 * This is a way for transparent BAR to figure out if we
-		 * are doing split BAR or not. There is no way for the hw
-		 * on the transparent side to know and set the PPD.
-		 */
-		bars_mask = pci_select_bars(ndev->pdev, IORESOURCE_MEM);
-		bars = hweight32(bars_mask);
-		if (bars == (HSX_SPLITBAR_MAX_MW + 1))
-			ndev->split_bar = 1;
+	case NTB_TOPO_B2B_USD:
+	case NTB_TOPO_B2B_DSD:
+		ndev->self_reg = &snb_pri_reg;
+		ndev->peer_reg = &snb_b2b_reg;
+		ndev->xlat_reg = &snb_sec_xlat;
 
-		break;
-	default:
-		dev_err(&ndev->pdev->dev, "Unknown PPD %x\n", ppd);
-		return -ENODEV;
-	}
+		if (ndev->hwerr_flags & NTB_HWERR_SDOORBELL_LOCKUP) {
+			ndev->peer_reg = &snb_pri_reg;
 
-	ntb_max_mw_detect(ndev);
+			if (b2b_mw_idx < 0)
+				ndev->b2b_idx = b2b_mw_idx + ndev->mw_count;
+			else
+				ndev->b2b_idx = b2b_mw_idx;
 
-	return 0;
-}
+			dev_dbg(ndev_dev(ndev),
+				"setting up b2b mw idx %d means %d\n",
+				b2b_mw_idx, ndev->b2b_idx);
 
-static int ntb_atom_detect(struct ntb_device *ndev)
-{
-	int rc;
-	u32 ppd;
+		} else if (ndev->hwerr_flags & NTB_HWERR_B2BDOORBELL_BIT14) {
+			dev_warn(ndev_dev(ndev), "Reduce doorbell count by 1\n");
+			ndev->db_count -= 1;
+		}
 
-	ndev->hw_type = BWD_HW;
+		if (ndev->ntb.topo == NTB_TOPO_B2B_USD) {
+			rc = snb_setup_b2b_mw(ndev,
+					      &snb_b2b_dsd_addr,
+					      &snb_b2b_usd_addr);
+		} else {
+			rc = snb_setup_b2b_mw(ndev,
+					      &snb_b2b_usd_addr,
+					      &snb_b2b_dsd_addr);
+		}
+		if (rc)
+			return rc;
 
-	rc = pci_read_config_dword(ndev->pdev, NTB_PPD_OFFSET, &ppd);
-	if (rc)
-		return rc;
+		/* Enable Bus Master and Memory Space on the secondary side */
+		iowrite16(PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER,
+			  ndev->self_mmio + SNB_SPCICMD_OFFSET);
 
-	switch ((ppd & BWD_PPD_CONN_TYPE) >> 8) {
-	case NTB_CONN_B2B:
-		dev_info(&ndev->pdev->dev, "Conn Type = B2B\n");
-		ndev->conn_type = NTB_CONN_B2B;
 		break;
-	case NTB_CONN_RP:
+
 	default:
-		dev_err(&ndev->pdev->dev, "Unsupported NTB configuration\n");
 		return -EINVAL;
 	}
 
-	if (ppd & BWD_PPD_DEV_TYPE)
-		ndev->dev_type = NTB_DEV_DSD;
-	else
-		ndev->dev_type = NTB_DEV_USD;
+	ndev->db_valid_mask = BIT_ULL(ndev->db_count) - 1;
+
+	ndev->reg->db_iowrite(ndev->db_valid_mask,
+			      ndev->self_mmio +
+			      ndev->self_reg->db_mask);
 
 	return 0;
 }
 
-static int ntb_device_detect(struct ntb_device *ndev)
+static int snb_init_dev(struct intel_ntb_dev *ndev)
 {
-	int rc;
+	struct pci_dev *pdev;
+	u8 ppd;
+	int rc, mem;
 
-	if (is_ntb_xeon(ndev))
-		rc = ntb_xeon_detect(ndev);
-	else if (is_ntb_atom(ndev))
-		rc = ntb_atom_detect(ndev);
-	else
-		rc = -ENODEV;
+	/* There is a Xeon hardware errata related to writes to SDOORBELL or
+	 * B2BDOORBELL in conjunction with inbound access to NTB MMIO Space,
+	 * which may hang the system.  To workaround this use the second memory
+	 * window to access the interrupt and scratch pad registers on the
+	 * remote system.
+	 */
+	ndev->hwerr_flags |= NTB_HWERR_SDOORBELL_LOCKUP;
 
-	dev_info(&ndev->pdev->dev, "Device Type = %s\n",
-		 ndev->dev_type == NTB_DEV_USD ? "USD/DSP" : "DSD/USP");
+	/* There is a hardware errata related to accessing any register in
+	 * SB01BASE in the presence of bidirectional traffic crossing the NTB.
+	 */
+	ndev->hwerr_flags |= NTB_HWERR_SB01BASE_LOCKUP;
 
-	return 0;
-}
+	/* HW Errata on bit 14 of b2bdoorbell register.  Writes will not be
+	 * mirrored to the remote system.  Shrink the number of bits by one,
+	 * since bit 14 is the last bit.
+	 */
+	ndev->hwerr_flags |= NTB_HWERR_B2BDOORBELL_BIT14;
 
-static int ntb_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
-{
-	struct ntb_device *ndev;
-	int rc, i;
+	ndev->reg = &snb_reg;
 
-	ndev = kzalloc(sizeof(struct ntb_device), GFP_KERNEL);
-	if (!ndev)
-		return -ENOMEM;
+	pdev = ndev_pdev(ndev);
 
-	ndev->pdev = pdev;
+	rc = pci_read_config_byte(pdev, SNB_PPD_OFFSET, &ppd);
+	if (rc)
+		return -EIO;
 
-	ntb_set_errata_flags(ndev);
+	ndev->ntb.topo = snb_ppd_topo(ndev, ppd);
+	dev_dbg(ndev_dev(ndev), "ppd %#x topo %s\n", ppd,
+		ntb_topo_string(ndev->ntb.topo));
+	if (ndev->ntb.topo == NTB_TOPO_NONE)
+		return -EINVAL;
 
-	ndev->link_status = NTB_LINK_DOWN;
-	pci_set_drvdata(pdev, ndev);
-	ntb_setup_debugfs(ndev);
+	if (ndev->ntb.topo != NTB_TOPO_PRI) {
+		ndev->bar4_split = snb_ppd_bar4_split(ndev, ppd);
+		dev_dbg(ndev_dev(ndev), "ppd %#x bar4_split %d\n",
+			ppd, ndev->bar4_split);
+	} else {
+		/* This is a way for transparent BAR to figure out if we are
+		 * doing split BAR or not. There is no way for the hw on the
+		 * transparent side to know and set the PPD.
+		 */
+		mem = pci_select_bars(pdev, IORESOURCE_MEM);
+		ndev->bar4_split = hweight32(mem) ==
+			HSX_SPLIT_BAR_MW_COUNT + 1;
+		dev_dbg(ndev_dev(ndev), "mem %#x bar4_split %d\n",
+			mem, ndev->bar4_split);
+	}
 
-	rc = pci_enable_device(pdev);
+	rc = snb_init_ntb(ndev);
 	if (rc)
-		goto err;
-
-	pci_set_master(ndev->pdev);
+		return rc;
 
-	rc = ntb_device_detect(ndev);
+	rc = snb_init_isr(ndev);
 	if (rc)
-		goto err;
+		return rc;
 
-	ndev->mw = kcalloc(ndev->limits.max_mw, sizeof(struct ntb_mw),
-			   GFP_KERNEL);
-	if (!ndev->mw) {
-		rc = -ENOMEM;
-		goto err1;
-	}
+	return 0;
+}
 
-	if (ndev->split_bar)
-		rc = pci_request_selected_regions(pdev, NTB_SPLITBAR_MASK,
-						  KBUILD_MODNAME);
-	else
-		rc = pci_request_selected_regions(pdev, NTB_BAR_MASK,
-						  KBUILD_MODNAME);
+static void snb_deinit_dev(struct intel_ntb_dev *ndev)
+{
+	snb_deinit_isr(ndev);
+}
 
-	if (rc)
-		goto err2;
+static int intel_ntb_init_pci(struct intel_ntb_dev *ndev, struct pci_dev *pdev)
+{
+	int rc;
 
-	ndev->reg_base = pci_ioremap_bar(pdev, NTB_BAR_MMIO);
-	if (!ndev->reg_base) {
-		dev_warn(&pdev->dev, "Cannot remap BAR 0\n");
-		rc = -EIO;
-		goto err3;
-	}
+	pci_set_drvdata(pdev, ndev);
 
-	for (i = 0; i < ndev->limits.max_mw; i++) {
-		ndev->mw[i].bar_sz = pci_resource_len(pdev, MW_TO_BAR(i));
+	rc = pci_enable_device(pdev);
+	if (rc)
+		goto err_pci_enable;
 
-		/*
-		 * with the errata we need to steal last of the memory
-		 * windows for workarounds and they point to MMIO registers.
-		 */
-		if ((ndev->wa_flags & WA_SNB_ERR) &&
-		    (i == (ndev->limits.max_mw - 1))) {
-			ndev->mw[i].vbase =
-				ioremap_nocache(pci_resource_start(pdev,
-							MW_TO_BAR(i)),
-						ndev->mw[i].bar_sz);
-		} else {
-			ndev->mw[i].vbase =
-				ioremap_wc(pci_resource_start(pdev,
-							MW_TO_BAR(i)),
-					   ndev->mw[i].bar_sz);
-		}
+	rc = pci_request_regions(pdev, NTB_NAME);
+	if (rc)
+		goto err_pci_regions;
 
-		dev_info(&pdev->dev, "MW %d size %llu\n", i,
-			 (unsigned long long) ndev->mw[i].bar_sz);
-		if (!ndev->mw[i].vbase) {
-			dev_warn(&pdev->dev, "Cannot remap BAR %d\n",
-				 MW_TO_BAR(i));
-			rc = -EIO;
-			goto err3;
-		}
-	}
+	pci_set_master(pdev);
 
 	rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(64));
 	if (rc) {
 		rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
 		if (rc)
-			goto err4;
-
-		dev_warn(&pdev->dev, "Cannot DMA highmem\n");
+			goto err_dma_mask;
+		dev_warn(ndev_dev(ndev), "Cannot DMA highmem\n");
 	}
 
 	rc = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64));
 	if (rc) {
 		rc = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(32));
 		if (rc)
-			goto err4;
+			goto err_dma_mask;
+		dev_warn(ndev_dev(ndev), "Cannot DMA consistent highmem\n");
+	}
 
-		dev_warn(&pdev->dev, "Cannot DMA consistent highmem\n");
+	ndev->self_mmio = pci_iomap(pdev, 0, 0);
+	if (!ndev->self_mmio) {
+		rc = -EIO;
+		goto err_mmio;
 	}
+	ndev->peer_mmio = ndev->self_mmio;
 
-	rc = ntb_device_setup(ndev);
-	if (rc)
-		goto err4;
+	return 0;
 
-	rc = ntb_create_callbacks(ndev);
-	if (rc)
-		goto err5;
+err_mmio:
+err_dma_mask:
+	pci_clear_master(pdev);
+	pci_release_regions(pdev);
+err_pci_regions:
+	pci_disable_device(pdev);
+err_pci_enable:
+	pci_set_drvdata(pdev, NULL);
+	return rc;
+}
 
-	rc = ntb_setup_interrupts(ndev);
-	if (rc)
-		goto err6;
+static void intel_ntb_deinit_pci(struct intel_ntb_dev *ndev)
+{
+	struct pci_dev *pdev = ndev_pdev(ndev);
 
-	/* The scratchpad registers keep the values between rmmod/insmod,
-	 * blast them now
-	 */
-	for (i = 0; i < ndev->limits.max_spads; i++) {
-		ntb_write_local_spad(ndev, i, 0);
-		ntb_write_remote_spad(ndev, i, 0);
+	if (ndev->peer_mmio && ndev->peer_mmio != ndev->self_mmio)
+		pci_iounmap(pdev, ndev->peer_mmio);
+	pci_iounmap(pdev, ndev->self_mmio);
+
+	pci_clear_master(pdev);
+	pci_release_regions(pdev);
+	pci_disable_device(pdev);
+	pci_set_drvdata(pdev, NULL);
+}
+
+static inline void ndev_init_struct(struct intel_ntb_dev *ndev,
+				    struct pci_dev *pdev)
+{
+	ndev->ntb.pdev = pdev;
+	ndev->ntb.topo = NTB_TOPO_NONE;
+	ndev->ntb.ops = &intel_ntb_ops;
+
+	ndev->b2b_off = 0;
+	ndev->b2b_idx = INT_MAX;
+
+	ndev->bar4_split = 0;
+
+	ndev->mw_count = 0;
+	ndev->spad_count = 0;
+	ndev->db_count = 0;
+	ndev->db_vec_count = 0;
+	ndev->db_vec_shift = 0;
+
+	ndev->ntb_ctl = 0;
+	ndev->lnk_sta = 0;
+
+	ndev->db_valid_mask = 0;
+	ndev->db_link_mask = 0;
+	ndev->db_mask = 0;
+
+	spin_lock_init(&ndev->db_mask_lock);
+}
+
+static int intel_ntb_pci_probe(struct pci_dev *pdev,
+			       const struct pci_device_id *id)
+{
+	struct intel_ntb_dev *ndev;
+	int rc;
+
+	if (pdev_is_bwd(pdev)) {
+		ndev = kmalloc(sizeof(*ndev), GFP_KERNEL);
+		if (!ndev) {
+			rc = -ENOMEM;
+			goto err_ndev;
+		}
+
+		ndev_init_struct(ndev, pdev);
+
+		rc = intel_ntb_init_pci(ndev, pdev);
+		if (rc)
+			goto err_init_pci;
+
+		rc = bwd_init_dev(ndev);
+		if (rc)
+			goto err_init_dev;
+
+	} else if (pdev_is_snb(pdev)) {
+		ndev = kmalloc(sizeof(*ndev), GFP_KERNEL);
+		if (!ndev) {
+			rc = -ENOMEM;
+			goto err_ndev;
+		}
+
+		ndev_init_struct(ndev, pdev);
+
+		rc = intel_ntb_init_pci(ndev, pdev);
+		if (rc)
+			goto err_init_pci;
+
+		rc = snb_init_dev(ndev);
+		if (rc)
+			goto err_init_dev;
+
+	} else {
+		rc = -EINVAL;
+		goto err_ndev;
 	}
 
-	rc = ntb_transport_init(pdev);
-	if (rc)
-		goto err7;
+	ndev_reset_unsafe_flags(ndev);
+
+	ndev->reg->poll_link(ndev);
 
-	ntb_hw_link_up(ndev);
+	ndev_init_debugfs(ndev);
+
+	rc = ntb_register_device(&ndev->ntb);
+	if (rc)
+		goto err_register;
 
 	return 0;
 
-err7:
-	ntb_free_interrupts(ndev);
-err6:
-	ntb_free_callbacks(ndev);
-err5:
-	ntb_device_free(ndev);
-err4:
-	for (i--; i >= 0; i--)
-		iounmap(ndev->mw[i].vbase);
-	iounmap(ndev->reg_base);
-err3:
-	if (ndev->split_bar)
-		pci_release_selected_regions(pdev, NTB_SPLITBAR_MASK);
+err_register:
+	ndev_deinit_debugfs(ndev);
+	if (pdev_is_bwd(pdev))
+		bwd_deinit_dev(ndev);
+	else if (pdev_is_snb(pdev))
+		snb_deinit_dev(ndev);
 	else
-		pci_release_selected_regions(pdev, NTB_BAR_MASK);
-err2:
-	kfree(ndev->mw);
-err1:
-	pci_disable_device(pdev);
-err:
-	ntb_free_debugfs(ndev);
+		BUG();
+err_init_dev:
+	intel_ntb_deinit_pci(ndev);
+err_init_pci:
 	kfree(ndev);
-
-	dev_err(&pdev->dev, "Error loading %s module\n", KBUILD_MODNAME);
+err_ndev:
 	return rc;
 }
 
-static void ntb_pci_remove(struct pci_dev *pdev)
+static void intel_ntb_pci_remove(struct pci_dev *pdev)
 {
-	struct ntb_device *ndev = pci_get_drvdata(pdev);
-	int i;
+	struct intel_ntb_dev *ndev = pci_get_drvdata(pdev);
+
+	ntb_unregister_device(&ndev->ntb);
+	ndev_deinit_debugfs(ndev);
+	if (pdev_is_bwd(pdev))
+		bwd_deinit_dev(ndev);
+	else if (pdev_is_snb(pdev))
+		snb_deinit_dev(ndev);
+	else
+		BUG();
 
-	ntb_hw_link_down(ndev);
+	intel_ntb_deinit_pci(ndev);
+	kfree(ndev);
+}
 
-	ntb_transport_free(ndev->ntb_transport);
+static const struct intel_ntb_reg bwd_reg = {
+	.poll_link		= bwd_poll_link,
+	.link_is_up		= bwd_link_is_up,
+	.db_ioread		= bwd_db_ioread,
+	.db_iowrite		= bwd_db_iowrite,
+	.db_size		= sizeof(u64),
+	.ntb_ctl		= BWD_NTBCNTL_OFFSET,
+	.mw_bar			= {2, 4},
+};
 
-	ntb_free_interrupts(ndev);
-	ntb_free_callbacks(ndev);
-	ntb_device_free(ndev);
+static const struct intel_ntb_alt_reg bwd_pri_reg = {
+	.db_bell		= BWD_PDOORBELL_OFFSET,
+	.db_mask		= BWD_PDBMSK_OFFSET,
+	.spad			= BWD_SPAD_OFFSET,
+};
 
-	/* need to reset max_mw limits so we can unmap properly */
-	if (ndev->hw_type == SNB_HW)
-		ntb_max_mw_detect(ndev);
+static const struct intel_ntb_alt_reg bwd_b2b_reg = {
+	.db_bell		= BWD_B2B_DOORBELL_OFFSET,
+	.spad			= BWD_B2B_SPAD_OFFSET,
+};
 
-	for (i = 0; i < ndev->limits.max_mw; i++)
-		iounmap(ndev->mw[i].vbase);
+static const struct intel_ntb_xlat_reg bwd_sec_xlat = {
+	/* FIXME : .bar0_base	= BWD_SBAR0BASE_OFFSET, */
+	/* FIXME : .bar2_limit	= BWD_SBAR2LMT_OFFSET, */
+	.bar2_xlat		= BWD_SBAR2XLAT_OFFSET,
+};
 
-	kfree(ndev->mw);
-	iounmap(ndev->reg_base);
-	if (ndev->split_bar)
-		pci_release_selected_regions(pdev, NTB_SPLITBAR_MASK);
-	else
-		pci_release_selected_regions(pdev, NTB_BAR_MASK);
-	pci_disable_device(pdev);
-	ntb_free_debugfs(ndev);
-	kfree(ndev);
-}
+static const struct intel_ntb_reg snb_reg = {
+	.poll_link		= snb_poll_link,
+	.link_is_up		= snb_link_is_up,
+	.db_ioread		= snb_db_ioread,
+	.db_iowrite		= snb_db_iowrite,
+	.db_size		= sizeof(u32),
+	.ntb_ctl		= SNB_NTBCNTL_OFFSET,
+	.mw_bar			= {2, 4, 5},
+};
+
+static const struct intel_ntb_alt_reg snb_pri_reg = {
+	.db_bell		= SNB_PDOORBELL_OFFSET,
+	.db_mask		= SNB_PDBMSK_OFFSET,
+	.spad			= SNB_SPAD_OFFSET,
+};
+
+static const struct intel_ntb_alt_reg snb_sec_reg = {
+	.db_bell		= SNB_SDOORBELL_OFFSET,
+	.db_mask		= SNB_SDBMSK_OFFSET,
+	/* second half of the scratchpads */
+	.spad			= SNB_SPAD_OFFSET + (SNB_SPAD_COUNT << 1),
+};
+
+static const struct intel_ntb_alt_reg snb_b2b_reg = {
+	.db_bell		= SNB_B2B_DOORBELL_OFFSET,
+	.spad			= SNB_B2B_SPAD_OFFSET,
+};
+
+static const struct intel_ntb_xlat_reg snb_pri_xlat = {
+	/* Note: no primary .bar0_base visible to the secondary side.
+	 *
+	 * The secondary side cannot get the base address stored in primary
+	 * bars.  The base address is necessary to set the limit register to
+	 * any value other than zero, or unlimited.
+	 *
+	 * WITHOUT THE BASE ADDRESS, THE SECONDARY SIDE CANNOT DISABLE the
+	 * window by setting the limit equal to base, nor can it limit the size
+	 * of the memory window by setting the limit to base + size.
+	 */
+	.bar2_limit		= SNB_PBAR2LMT_OFFSET,
+	.bar2_xlat		= SNB_PBAR2XLAT_OFFSET,
+};
+
+static const struct intel_ntb_xlat_reg snb_sec_xlat = {
+	.bar0_base		= SNB_SBAR0BASE_OFFSET,
+	.bar2_limit		= SNB_SBAR2LMT_OFFSET,
+	.bar2_xlat		= SNB_SBAR2XLAT_OFFSET,
+};
+
+static const struct intel_b2b_addr snb_b2b_usd_addr = {
+	.bar2_addr64		= SNB_B2B_BAR2_USD_ADDR64,
+	.bar4_addr64		= SNB_B2B_BAR4_USD_ADDR64,
+	.bar4_addr32		= SNB_B2B_BAR4_USD_ADDR32,
+	.bar5_addr32		= SNB_B2B_BAR5_USD_ADDR32,
+};
+
+static const struct intel_b2b_addr snb_b2b_dsd_addr = {
+	.bar2_addr64		= SNB_B2B_BAR2_DSD_ADDR64,
+	.bar4_addr64		= SNB_B2B_BAR4_DSD_ADDR64,
+	.bar4_addr32		= SNB_B2B_BAR4_DSD_ADDR32,
+	.bar5_addr32		= SNB_B2B_BAR5_DSD_ADDR32,
+};
+
+/* operations for primary side of local ntb */
+static const struct ntb_dev_ops intel_ntb_ops = {
+	.mw_count		= intel_ntb_mw_count,
+	.mw_get_range		= intel_ntb_mw_get_range,
+	.mw_set_trans		= intel_ntb_mw_set_trans,
+	.link_is_up		= intel_ntb_link_is_up,
+	.link_enable		= intel_ntb_link_enable,
+	.link_disable		= intel_ntb_link_disable,
+	.db_is_unsafe		= intel_ntb_db_is_unsafe,
+	.db_valid_mask		= intel_ntb_db_valid_mask,
+	.db_vector_count	= intel_ntb_db_vector_count,
+	.db_vector_mask		= intel_ntb_db_vector_mask,
+	.db_read		= intel_ntb_db_read,
+	.db_clear		= intel_ntb_db_clear,
+	.db_set_mask		= intel_ntb_db_set_mask,
+	.db_clear_mask		= intel_ntb_db_clear_mask,
+	.peer_db_addr		= intel_ntb_peer_db_addr,
+	.peer_db_set		= intel_ntb_peer_db_set,
+	.spad_is_unsafe		= intel_ntb_spad_is_unsafe,
+	.spad_count		= intel_ntb_spad_count,
+	.spad_read		= intel_ntb_spad_read,
+	.spad_write		= intel_ntb_spad_write,
+	.peer_spad_addr		= intel_ntb_peer_spad_addr,
+	.peer_spad_read		= intel_ntb_peer_spad_read,
+	.peer_spad_write	= intel_ntb_peer_spad_write,
+};
 
-static struct pci_driver ntb_pci_driver = {
+static const struct file_operations intel_ntb_debugfs_info = {
+	.owner = THIS_MODULE,
+	.open = simple_open,
+	.read = ndev_debugfs_read,
+};
+
+static const struct pci_device_id intel_ntb_pci_tbl[] = {
+	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_NTB_B2B_BWD)},
+	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_NTB_B2B_JSF)},
+	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_NTB_B2B_SNB)},
+	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_NTB_B2B_IVT)},
+	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_NTB_B2B_HSX)},
+	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_NTB_PS_JSF)},
+	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_NTB_PS_SNB)},
+	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_NTB_PS_IVT)},
+	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_NTB_PS_HSX)},
+	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_NTB_SS_JSF)},
+	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_NTB_SS_SNB)},
+	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_NTB_SS_IVT)},
+	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_NTB_SS_HSX)},
+	{0}
+};
+MODULE_DEVICE_TABLE(pci, intel_ntb_pci_tbl);
+
+static struct pci_driver intel_ntb_pci_driver = {
 	.name = KBUILD_MODNAME,
-	.id_table = ntb_pci_tbl,
-	.probe = ntb_pci_probe,
-	.remove = ntb_pci_remove,
+	.id_table = intel_ntb_pci_tbl,
+	.probe = intel_ntb_pci_probe,
+	.remove = intel_ntb_pci_remove,
 };
 
-module_pci_driver(ntb_pci_driver);
+static int __init intel_ntb_pci_driver_init(void)
+{
+	if (debugfs_initialized())
+		debugfs_dir = debugfs_create_dir(KBUILD_MODNAME, NULL);
+
+	return pci_register_driver(&intel_ntb_pci_driver);
+}
+module_init(intel_ntb_pci_driver_init);
+
+static void __exit intel_ntb_pci_driver_exit(void)
+{
+	pci_unregister_driver(&intel_ntb_pci_driver);
+
+	debugfs_remove_recursive(debugfs_dir);
+}
+module_exit(intel_ntb_pci_driver_exit);
+
diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.h b/drivers/ntb/hw/intel/ntb_hw_intel.h
index 9356104..0224b1a 100644
--- a/drivers/ntb/hw/intel/ntb_hw_intel.h
+++ b/drivers/ntb/hw/intel/ntb_hw_intel.h
@@ -5,6 +5,7 @@
  *   GPL LICENSE SUMMARY
  *
  *   Copyright(c) 2012 Intel Corporation. All rights reserved.
+ *   Copyright (C) 2015 EMC Corporation. All Rights Reserved.
  *
  *   This program is free software; you can redistribute it and/or modify
  *   it under the terms of version 2 of the GNU General Public License as
@@ -13,6 +14,7 @@
  *   BSD LICENSE
  *
  *   Copyright(c) 2012 Intel Corporation. All rights reserved.
+ *   Copyright (C) 2015 EMC Corporation. All Rights Reserved.
  *
  *   Redistribution and use in source and binary forms, with or without
  *   modification, are permitted provided that the following conditions
@@ -45,341 +47,280 @@
  * Contact Information:
  * Jon Mason <jon.mason@intel.com>
  */
-#include <linux/ntb_transport.h>
-
-#define NTB_LINK_STATUS_ACTIVE	0x2000
-#define NTB_LINK_SPEED_MASK	0x000f
-#define NTB_LINK_WIDTH_MASK	0x03f0
-
-#define SNB_MSIX_CNT		4
-#define SNB_MAX_B2B_SPADS	16
-#define SNB_MAX_COMPAT_SPADS	16
-/* Reserve the uppermost bit for link interrupt */
-#define SNB_MAX_DB_BITS		15
-#define SNB_LINK_DB		15
-#define SNB_DB_BITS_PER_VEC	5
-#define HSX_SPLITBAR_MAX_MW	3
-#define SNB_MAX_MW		2
-#define SNB_ERRATA_MAX_MW	1
-
-#define SNB_DB_HW_LINK		0x8000
-
-#define SNB_UNCERRSTS_OFFSET	0x014C
-#define SNB_CORERRSTS_OFFSET	0x0158
-#define SNB_LINK_STATUS_OFFSET	0x01A2
-#define SNB_PCICMD_OFFSET	0x0504
-#define SNB_DEVCTRL_OFFSET	0x0598
-#define SNB_DEVSTS_OFFSET	0x059A
-#define SNB_SLINK_STATUS_OFFSET	0x05A2
-
-#define SNB_PBAR2LMT_OFFSET	0x0000
-#define SNB_PBAR4LMT_OFFSET	0x0008
-#define SNB_PBAR5LMT_OFFSET	0x000C
-#define SNB_PBAR2XLAT_OFFSET	0x0010
-#define SNB_PBAR4XLAT_OFFSET	0x0018
-#define SNB_PBAR5XLAT_OFFSET	0x001C
-#define SNB_SBAR2LMT_OFFSET	0x0020
-#define SNB_SBAR4LMT_OFFSET	0x0028
-#define SNB_SBAR5LMT_OFFSET	0x002C
-#define SNB_SBAR2XLAT_OFFSET	0x0030
-#define SNB_SBAR4XLAT_OFFSET	0x0038
-#define SNB_SBAR5XLAT_OFFSET	0x003C
-#define SNB_SBAR0BASE_OFFSET	0x0040
-#define SNB_SBAR2BASE_OFFSET	0x0048
-#define SNB_SBAR4BASE_OFFSET	0x0050
-#define SNB_SBAR5BASE_OFFSET	0x0054
-#define SNB_NTBCNTL_OFFSET	0x0058
-#define SNB_SBDF_OFFSET		0x005C
-#define SNB_PDOORBELL_OFFSET	0x0060
-#define SNB_PDBMSK_OFFSET	0x0062
-#define SNB_SDOORBELL_OFFSET	0x0064
-#define SNB_SDBMSK_OFFSET	0x0066
-#define SNB_USMEMMISS_OFFSET	0x0070
-#define SNB_SPAD_OFFSET		0x0080
-#define SNB_SPADSEMA4_OFFSET	0x00c0
-#define SNB_WCCNTRL_OFFSET	0x00e0
-#define SNB_B2B_SPAD_OFFSET	0x0100
-#define SNB_B2B_DOORBELL_OFFSET	0x0140
-#define SNB_B2B_XLAT_OFFSETL	0x0144
-#define SNB_B2B_XLAT_OFFSETU	0x0148
 
-/*
- * The addresses are setup so the 32bit BARs can function. Thus
- * the addresses are all in 32bit space
- */
-#define SNB_MBAR01_USD_ADDR	0x000000002100000CULL
-#define SNB_MBAR23_USD_ADDR	0x000000004100000CULL
-#define SNB_MBAR4_USD_ADDR	0x000000008100000CULL
-#define SNB_MBAR5_USD_ADDR	0x00000000A100000CULL
-#define SNB_MBAR01_DSD_ADDR	0x000000002000000CULL
-#define SNB_MBAR23_DSD_ADDR	0x000000004000000CULL
-#define SNB_MBAR4_DSD_ADDR	0x000000008000000CULL
-#define SNB_MBAR5_DSD_ADDR	0x00000000A000000CULL
-
-#define BWD_MSIX_CNT		34
-#define BWD_MAX_SPADS		16
-#define BWD_MAX_DB_BITS		34
-#define BWD_DB_BITS_PER_VEC	1
-#define BWD_MAX_MW		2
-
-#define BWD_PCICMD_OFFSET	0xb004
-#define BWD_MBAR23_OFFSET	0xb018
-#define BWD_MBAR45_OFFSET	0xb020
-#define BWD_DEVCTRL_OFFSET	0xb048
-#define BWD_LINK_STATUS_OFFSET	0xb052
-#define BWD_ERRCORSTS_OFFSET	0xb110
-
-#define BWD_SBAR2XLAT_OFFSET	0x0008
-#define BWD_SBAR4XLAT_OFFSET	0x0010
-#define BWD_PDOORBELL_OFFSET	0x0020
-#define BWD_PDBMSK_OFFSET	0x0028
-#define BWD_NTBCNTL_OFFSET	0x0060
-#define BWD_EBDF_OFFSET		0x0064
-#define BWD_SPAD_OFFSET		0x0080
-#define BWD_SPADSEMA_OFFSET	0x00c0
-#define BWD_STKYSPAD_OFFSET	0x00c4
-#define BWD_PBAR2XLAT_OFFSET	0x8008
-#define BWD_PBAR4XLAT_OFFSET	0x8010
-#define BWD_B2B_DOORBELL_OFFSET	0x8020
-#define BWD_B2B_SPAD_OFFSET	0x8080
-#define BWD_B2B_SPADSEMA_OFFSET	0x80c0
-#define BWD_B2B_STKYSPAD_OFFSET	0x80c4
-
-#define BWD_MODPHY_PCSREG4	0x1c004
-#define BWD_MODPHY_PCSREG6	0x1c006
-
-#define BWD_IP_BASE		0xC000
-#define BWD_DESKEWSTS_OFFSET	(BWD_IP_BASE + 0x3024)
-#define BWD_LTSSMERRSTS0_OFFSET (BWD_IP_BASE + 0x3180)
+#ifndef NTB_HW_INTEL_H
+#define NTB_HW_INTEL_H
+
+#include <linux/ntb.h>
+#include <linux/pci.h>
+
+#define PCI_DEVICE_ID_INTEL_NTB_B2B_JSF	0x3725
+#define PCI_DEVICE_ID_INTEL_NTB_PS_JSF	0x3726
+#define PCI_DEVICE_ID_INTEL_NTB_SS_JSF	0x3727
+#define PCI_DEVICE_ID_INTEL_NTB_B2B_SNB	0x3C0D
+#define PCI_DEVICE_ID_INTEL_NTB_PS_SNB	0x3C0E
+#define PCI_DEVICE_ID_INTEL_NTB_SS_SNB	0x3C0F
+#define PCI_DEVICE_ID_INTEL_NTB_B2B_IVT	0x0E0D
+#define PCI_DEVICE_ID_INTEL_NTB_PS_IVT	0x0E0E
+#define PCI_DEVICE_ID_INTEL_NTB_SS_IVT	0x0E0F
+#define PCI_DEVICE_ID_INTEL_NTB_B2B_HSX	0x2F0D
+#define PCI_DEVICE_ID_INTEL_NTB_PS_HSX	0x2F0E
+#define PCI_DEVICE_ID_INTEL_NTB_SS_HSX	0x2F0F
+#define PCI_DEVICE_ID_INTEL_NTB_B2B_BWD	0x0C4E
+
+/* SNB hardware (and JSF, IVT, HSX) */
+
+#define SNB_PBAR2LMT_OFFSET		0x0000
+#define SNB_PBAR2XLAT_OFFSET		0x0010
+#define SNB_SBAR2LMT_OFFSET		0x0020
+#define SNB_SBAR2XLAT_OFFSET		0x0030
+#define SNB_SBAR0BASE_OFFSET		0x0040
+#define SNB_SBDF_OFFSET			0x005c
+#define SNB_NTBCNTL_OFFSET		0x0058
+#define SNB_PDOORBELL_OFFSET		0x0060
+#define SNB_PDBMSK_OFFSET		0x0062
+#define SNB_SDOORBELL_OFFSET		0x0064
+#define SNB_SDBMSK_OFFSET		0x0066
+#define SNB_USMEMMISS_OFFSET		0x0070
+#define SNB_SPAD_OFFSET			0x0080
+#define SNB_PBAR23SZ_OFFSET		0x00d0
+#define SNB_PBAR45SZ_OFFSET		0x00d1
+#define SNB_PBAR4SZ_OFFSET		0x00d1
+#define SNB_SBAR23SZ_OFFSET		0x00d2
+#define SNB_SBAR45SZ_OFFSET		0x00d3
+#define SNB_SBAR4SZ_OFFSET		0x00d3
+#define SNB_PPD_OFFSET			0x00d4
+#define SNB_PBAR5SZ_OFFSET		0x00d5
+#define SNB_SBAR5SZ_OFFSET		0x00d6
+#define SNB_WCCNTRL_OFFSET		0x00e0
+#define SNB_UNCERRSTS_OFFSET		0x014c
+#define SNB_CORERRSTS_OFFSET		0x0158
+#define SNB_LINK_STATUS_OFFSET		0x01a2
+#define SNB_SPCICMD_OFFSET		0x0504
+#define SNB_DEVCTRL_OFFSET		0x0598
+#define SNB_DEVSTS_OFFSET		0x059a
+#define SNB_SLINK_STATUS_OFFSET		0x05a2
+#define SNB_B2B_SPAD_OFFSET		0x0100
+#define SNB_B2B_DOORBELL_OFFSET		0x0140
+#define SNB_B2B_XLAT_OFFSETL		0x0144
+#define SNB_B2B_XLAT_OFFSETU		0x0148
+#define SNB_PPD_CONN_MASK		0x03
+#define SNB_PPD_CONN_TRANSPARENT	0x00
+#define SNB_PPD_CONN_B2B		0x01
+#define SNB_PPD_CONN_RP			0x02
+#define SNB_PPD_DEV_MASK		0x10
+#define SNB_PPD_DEV_USD			0x00
+#define SNB_PPD_DEV_DSD			0x10
+#define SNB_PPD_SPLIT_BAR_MASK		0x40
+
+#define SNB_PPD_TOPO_MASK	(SNB_PPD_CONN_MASK | SNB_PPD_DEV_MASK)
+#define SNB_PPD_TOPO_PRI_USD	(SNB_PPD_CONN_RP | SNB_PPD_DEV_USD)
+#define SNB_PPD_TOPO_PRI_DSD	(SNB_PPD_CONN_RP | SNB_PPD_DEV_DSD)
+#define SNB_PPD_TOPO_SEC_USD	(SNB_PPD_CONN_TRANSPARENT | SNB_PPD_DEV_USD)
+#define SNB_PPD_TOPO_SEC_DSD	(SNB_PPD_CONN_TRANSPARENT | SNB_PPD_DEV_DSD)
+#define SNB_PPD_TOPO_B2B_USD	(SNB_PPD_CONN_B2B | SNB_PPD_DEV_USD)
+#define SNB_PPD_TOPO_B2B_DSD	(SNB_PPD_CONN_B2B | SNB_PPD_DEV_DSD)
+
+#define SNB_MW_COUNT			2
+#define HSX_SPLIT_BAR_MW_COUNT		3
+#define SNB_DB_COUNT			15
+#define SNB_DB_LINK			15
+#define SNB_DB_LINK_BIT			BIT_ULL(SNB_DB_LINK)
+#define SNB_DB_MSIX_VECTOR_COUNT	4
+#define SNB_DB_MSIX_VECTOR_SHIFT	5
+#define SNB_DB_TOTAL_SHIFT		16
+#define SNB_SPAD_COUNT			16
+
+/* BWD hardware */
+
+#define BWD_SBAR2XLAT_OFFSET		0x0008
+#define BWD_PDOORBELL_OFFSET		0x0020
+#define BWD_PDBMSK_OFFSET		0x0028
+#define BWD_NTBCNTL_OFFSET		0x0060
+#define BWD_SPAD_OFFSET			0x0080
+#define BWD_PPD_OFFSET			0x00d4
+#define BWD_PBAR2XLAT_OFFSET		0x8008
+#define BWD_B2B_DOORBELL_OFFSET		0x8020
+#define BWD_B2B_SPAD_OFFSET		0x8080
+#define BWD_SPCICMD_OFFSET		0xb004
+#define BWD_LINK_STATUS_OFFSET		0xb052
+#define BWD_ERRCORSTS_OFFSET		0xb110
+#define BWD_IP_BASE			0xc000
+#define BWD_DESKEWSTS_OFFSET		(BWD_IP_BASE + 0x3024)
+#define BWD_LTSSMERRSTS0_OFFSET		(BWD_IP_BASE + 0x3180)
 #define BWD_LTSSMSTATEJMP_OFFSET	(BWD_IP_BASE + 0x3040)
 #define BWD_IBSTERRRCRVSTS0_OFFSET	(BWD_IP_BASE + 0x3324)
+#define BWD_MODPHY_PCSREG4		0x1c004
+#define BWD_MODPHY_PCSREG6		0x1c006
+
+#define BWD_PPD_INIT_LINK		0x0008
+#define BWD_PPD_CONN_MASK		0x0300
+#define BWD_PPD_CONN_TRANSPARENT	0x0000
+#define BWD_PPD_CONN_B2B		0x0100
+#define BWD_PPD_CONN_RP			0x0200
+#define BWD_PPD_DEV_MASK		0x1000
+#define BWD_PPD_DEV_USD			0x0000
+#define BWD_PPD_DEV_DSD			0x1000
+#define BWD_PPD_TOPO_MASK	(BWD_PPD_CONN_MASK | BWD_PPD_DEV_MASK)
+#define BWD_PPD_TOPO_PRI_USD	(BWD_PPD_CONN_TRANSPARENT | BWD_PPD_DEV_USD)
+#define BWD_PPD_TOPO_PRI_DSD	(BWD_PPD_CONN_TRANSPARENT | BWD_PPD_DEV_DSD)
+#define BWD_PPD_TOPO_SEC_USD	(BWD_PPD_CONN_RP | BWD_PPD_DEV_USD)
+#define BWD_PPD_TOPO_SEC_DSD	(BWD_PPD_CONN_RP | BWD_PPD_DEV_DSD)
+#define BWD_PPD_TOPO_B2B_USD	(BWD_PPD_CONN_B2B | BWD_PPD_DEV_USD)
+#define BWD_PPD_TOPO_B2B_DSD	(BWD_PPD_CONN_B2B | BWD_PPD_DEV_DSD)
+
+#define BWD_MW_COUNT			2
+#define BWD_DB_COUNT			34
+#define BWD_DB_VALID_MASK		(BIT_ULL(BWD_DB_COUNT) - 1)
+#define BWD_DB_MSIX_VECTOR_COUNT	34
+#define BWD_DB_MSIX_VECTOR_SHIFT	1
+#define BWD_DB_TOTAL_SHIFT		34
+#define BWD_SPAD_COUNT			16
+
+#define BWD_NTB_CTL_DOWN_BIT		BIT(16)
+#define BWD_NTB_CTL_ACTIVE(x)		!(x & BWD_NTB_CTL_DOWN_BIT)
+
+#define BWD_DESKEWSTS_DBERR		BIT(15)
+#define BWD_LTSSMERRSTS0_UNEXPECTEDEI	BIT(20)
+#define BWD_LTSSMSTATEJMP_FORCEDETECT	BIT(2)
+#define BWD_IBIST_ERR_OFLOW		0x7FFF7FFF
+
+#define BWD_LINK_HB_TIMEOUT		msecs_to_jiffies(1000)
+#define BWD_LINK_RECOVERY_TIME		msecs_to_jiffies(500)
+
+/* Ntb control and link status */
+
+#define NTB_CTL_CFG_LOCK		BIT(0)
+#define NTB_CTL_DISABLE			BIT(1)
+#define NTB_CTL_S2P_BAR2_SNOOP		BIT(2)
+#define NTB_CTL_P2S_BAR2_SNOOP		BIT(4)
+#define NTB_CTL_S2P_BAR4_SNOOP		BIT(6)
+#define NTB_CTL_P2S_BAR4_SNOOP		BIT(8)
+#define NTB_CTL_S2P_BAR5_SNOOP		BIT(12)
+#define NTB_CTL_P2S_BAR5_SNOOP		BIT(14)
+
+#define NTB_LNK_STA_ACTIVE_BIT		0x2000
+#define NTB_LNK_STA_SPEED_MASK		0x000f
+#define NTB_LNK_STA_WIDTH_MASK		0x03f0
+#define NTB_LNK_STA_ACTIVE(x)		(!!((x) & NTB_LNK_STA_ACTIVE_BIT))
+#define NTB_LNK_STA_SPEED(x)		((x) & NTB_LNK_STA_SPEED_MASK)
+#define NTB_LNK_STA_WIDTH(x)		(((x) & NTB_LNK_STA_WIDTH_MASK) >> 4)
+
+/* Use the following addresses for translation between b2b ntb devices in case
+ * the hardware default values are not reliable. */
+#define SNB_B2B_BAR0_USD_ADDR		0x1000000000000000ull
+#define SNB_B2B_BAR2_USD_ADDR64		0x2000000000000000ull
+#define SNB_B2B_BAR4_USD_ADDR64		0x4000000000000000ull
+#define SNB_B2B_BAR4_USD_ADDR32		0x20000000u
+#define SNB_B2B_BAR5_USD_ADDR32		0x40000000u
+#define SNB_B2B_BAR0_DSD_ADDR		0x9000000000000000ull
+#define SNB_B2B_BAR2_DSD_ADDR64		0xa000000000000000ull
+#define SNB_B2B_BAR4_DSD_ADDR64		0xc000000000000000ull
+#define SNB_B2B_BAR4_DSD_ADDR32		0xa0000000u
+#define SNB_B2B_BAR5_DSD_ADDR32		0xc0000000u
+
+/* The peer ntb secondary config space is 32KB fixed size */
+#define SNB_B2B_MIN_SIZE		0x8000
+
+/* flags to indicate hardware errata */
+#define NTB_HWERR_SDOORBELL_LOCKUP	BIT_ULL(0)
+#define NTB_HWERR_SB01BASE_LOCKUP	BIT_ULL(1)
+#define NTB_HWERR_B2BDOORBELL_BIT14	BIT_ULL(2)
+
+/* flags to indicate unsafe api */
+#define NTB_UNSAFE_DB			BIT_ULL(0)
+#define NTB_UNSAFE_SPAD			BIT_ULL(1)
+
+struct intel_ntb_dev;
+
+struct intel_ntb_reg {
+	int (*poll_link)(struct intel_ntb_dev *ndev);
+	int (*link_is_up)(struct intel_ntb_dev *ndev);
+	u64 (*db_ioread)(void __iomem *mmio);
+	void (*db_iowrite)(u64 db_bits, void __iomem *mmio);
+	unsigned long			ntb_ctl;
+	resource_size_t			db_size;
+	int				mw_bar[];
+};
 
-#define BWD_DESKEWSTS_DBERR	(1 << 15)
-#define BWD_LTSSMERRSTS0_UNEXPECTEDEI	(1 << 20)
-#define BWD_LTSSMSTATEJMP_FORCEDETECT	(1 << 2)
-#define BWD_IBIST_ERR_OFLOW	0x7FFF7FFF
-
-#define NTB_CNTL_CFG_LOCK		(1 << 0)
-#define NTB_CNTL_LINK_DISABLE		(1 << 1)
-#define NTB_CNTL_S2P_BAR23_SNOOP	(1 << 2)
-#define NTB_CNTL_P2S_BAR23_SNOOP	(1 << 4)
-#define NTB_CNTL_S2P_BAR4_SNOOP	(1 << 6)
-#define NTB_CNTL_P2S_BAR4_SNOOP	(1 << 8)
-#define NTB_CNTL_S2P_BAR5_SNOOP	(1 << 12)
-#define NTB_CNTL_P2S_BAR5_SNOOP	(1 << 14)
-#define BWD_CNTL_LINK_DOWN		(1 << 16)
-
-#define NTB_PPD_OFFSET		0x00D4
-#define SNB_PPD_CONN_TYPE	0x0003
-#define SNB_PPD_DEV_TYPE	0x0010
-#define SNB_PPD_SPLIT_BAR	(1 << 6)
-#define BWD_PPD_INIT_LINK	0x0008
-#define BWD_PPD_CONN_TYPE	0x0300
-#define BWD_PPD_DEV_TYPE	0x1000
-#define PCI_DEVICE_ID_INTEL_NTB_B2B_JSF		0x3725
-#define PCI_DEVICE_ID_INTEL_NTB_PS_JSF		0x3726
-#define PCI_DEVICE_ID_INTEL_NTB_SS_JSF		0x3727
-#define PCI_DEVICE_ID_INTEL_NTB_B2B_SNB		0x3C0D
-#define PCI_DEVICE_ID_INTEL_NTB_PS_SNB		0x3C0E
-#define PCI_DEVICE_ID_INTEL_NTB_SS_SNB		0x3C0F
-#define PCI_DEVICE_ID_INTEL_NTB_B2B_IVT		0x0E0D
-#define PCI_DEVICE_ID_INTEL_NTB_PS_IVT		0x0E0E
-#define PCI_DEVICE_ID_INTEL_NTB_SS_IVT		0x0E0F
-#define PCI_DEVICE_ID_INTEL_NTB_B2B_HSX		0x2F0D
-#define PCI_DEVICE_ID_INTEL_NTB_PS_HSX		0x2F0E
-#define PCI_DEVICE_ID_INTEL_NTB_SS_HSX		0x2F0F
-#define PCI_DEVICE_ID_INTEL_NTB_B2B_BWD		0x0C4E
-
-#ifndef readq
-static inline u64 readq(void __iomem *addr)
-{
-	return readl(addr) | (((u64) readl(addr + 4)) << 32LL);
-}
-#endif
-
-#ifndef writeq
-static inline void writeq(u64 val, void __iomem *addr)
-{
-	writel(val & 0xffffffff, addr);
-	writel(val >> 32, addr + 4);
-}
-#endif
+struct intel_ntb_alt_reg {
+	unsigned long			db_bell;
+	unsigned long			db_mask;
+	unsigned long			spad;
+};
 
-#define NTB_BAR_MMIO		0
-#define NTB_BAR_23		2
-#define NTB_BAR_4		4
-#define NTB_BAR_5		5
-
-#define NTB_BAR_MASK		((1 << NTB_BAR_MMIO) | (1 << NTB_BAR_23) |\
-				 (1 << NTB_BAR_4))
-#define NTB_SPLITBAR_MASK	((1 << NTB_BAR_MMIO) | (1 << NTB_BAR_23) |\
-				 (1 << NTB_BAR_4) | (1 << NTB_BAR_5))
-
-#define NTB_HB_TIMEOUT		msecs_to_jiffies(1000)
-
-enum ntb_hw_event {
-	NTB_EVENT_SW_EVENT0 = 0,
-	NTB_EVENT_SW_EVENT1,
-	NTB_EVENT_SW_EVENT2,
-	NTB_EVENT_HW_ERROR,
-	NTB_EVENT_HW_LINK_UP,
-	NTB_EVENT_HW_LINK_DOWN,
+struct intel_ntb_xlat_reg {
+	unsigned long			bar0_base;
+	unsigned long			bar2_xlat;
+	unsigned long			bar2_limit;
 };
 
-struct ntb_mw {
-	dma_addr_t phys_addr;
-	void __iomem *vbase;
-	resource_size_t bar_sz;
+struct intel_b2b_addr {
+	phys_addr_t			bar0_addr;
+	phys_addr_t			bar2_addr64;
+	phys_addr_t			bar4_addr64;
+	phys_addr_t			bar4_addr32;
+	phys_addr_t			bar5_addr32;
 };
 
-struct ntb_db_cb {
-	int (*callback)(void *data, int db_num);
-	unsigned int db_num;
-	void *data;
-	struct ntb_device *ndev;
-	struct tasklet_struct irq_work;
+struct intel_ntb_vec {
+	struct intel_ntb_dev		*ndev;
+	int				num;
 };
 
-#define WA_SNB_ERR	0x00000001
-
-struct ntb_device {
-	struct pci_dev *pdev;
-	struct msix_entry *msix_entries;
-	void __iomem *reg_base;
-	struct ntb_mw *mw;
-	struct {
-		unsigned char max_mw;
-		unsigned char max_spads;
-		unsigned char max_db_bits;
-		unsigned char msix_cnt;
-	} limits;
-	struct {
-		void __iomem *ldb;
-		void __iomem *ldb_mask;
-		void __iomem *rdb;
-		void __iomem *bar2_xlat;
-		void __iomem *bar4_xlat;
-		void __iomem *bar5_xlat;
-		void __iomem *spad_write;
-		void __iomem *spad_read;
-		void __iomem *lnk_cntl;
-		void __iomem *lnk_stat;
-		void __iomem *spci_cmd;
-	} reg_ofs;
-	struct ntb_transport *ntb_transport;
-	void (*event_cb)(void *handle, enum ntb_hw_event event);
-
-	struct ntb_db_cb *db_cb;
-	unsigned char hw_type;
-	unsigned char conn_type;
-	unsigned char dev_type;
-	unsigned char num_msix;
-	unsigned char bits_per_vector;
-	unsigned char max_cbs;
-	unsigned char link_width;
-	unsigned char link_speed;
-	unsigned char link_status;
-	unsigned char split_bar;
-
-	struct delayed_work hb_timer;
-	unsigned long last_ts;
-
-	struct delayed_work lr_timer;
-
-	struct dentry *debugfs_dir;
-	struct dentry *debugfs_info;
-
-	unsigned int wa_flags;
+struct intel_ntb_dev {
+	struct ntb_dev			ntb;
+
+	/* offset of peer bar0 in b2b bar */
+	unsigned long			b2b_off;
+	/* mw idx used to access peer bar0 */
+	unsigned int			b2b_idx;
+
+	/* BAR45 is split into BAR4 and BAR5 */
+	bool				bar4_split;
+
+	u32				ntb_ctl;
+	u32				lnk_sta;
+
+	unsigned char			mw_count;
+	unsigned char			spad_count;
+	unsigned char			db_count;
+	unsigned char			db_vec_count;
+	unsigned char			db_vec_shift;
+
+	u64				db_valid_mask;
+	u64				db_link_mask;
+	u64				db_mask;
+
+	/* synchronize rmw access of db_mask and hw reg */
+	spinlock_t			db_mask_lock;
+
+	struct msix_entry		*msix;
+	struct intel_ntb_vec		*vec;
+
+	const struct intel_ntb_reg	*reg;
+	const struct intel_ntb_alt_reg	*self_reg;
+	const struct intel_ntb_alt_reg	*peer_reg;
+	const struct intel_ntb_xlat_reg	*xlat_reg;
+	void				__iomem *self_mmio;
+	void				__iomem *peer_mmio;
+	phys_addr_t			peer_addr;
+
+	unsigned long			last_ts;
+	struct delayed_work		hb_timer;
+
+	unsigned long			hwerr_flags;
+	unsigned long			unsafe_flags;
+	unsigned long			unsafe_flags_ignore;
+
+	struct dentry			*debugfs_dir;
+	struct dentry			*debugfs_info;
 };
 
-/**
- * ntb_max_cbs() - return the max callbacks
- * @ndev: pointer to ntb_device instance
- *
- * Given the ntb pointer, return the maximum number of callbacks
- *
- * RETURNS: the maximum number of callbacks
- */
-static inline unsigned char ntb_max_cbs(struct ntb_device *ndev)
-{
-	return ndev->max_cbs;
-}
-
-/**
- * ntb_max_mw() - return the max number of memory windows
- * @ndev: pointer to ntb_device instance
- *
- * Given the ntb pointer, return the maximum number of memory windows
- *
- * RETURNS: the maximum number of memory windows
- */
-static inline unsigned char ntb_max_mw(struct ntb_device *ndev)
-{
-	return ndev->limits.max_mw;
-}
-
-/**
- * ntb_hw_link_status() - return the hardware link status
- * @ndev: pointer to ntb_device instance
- *
- * Returns true if the hardware is connected to the remote system
- *
- * RETURNS: true or false based on the hardware link state
- */
-static inline bool ntb_hw_link_status(struct ntb_device *ndev)
-{
-	return ndev->link_status == NTB_LINK_UP;
-}
-
-/**
- * ntb_query_pdev() - return the pci_dev pointer
- * @ndev: pointer to ntb_device instance
- *
- * Given the ntb pointer, return the pci_dev pointer for the NTB hardware device
- *
- * RETURNS: a pointer to the ntb pci_dev
- */
-static inline struct pci_dev *ntb_query_pdev(struct ntb_device *ndev)
-{
-	return ndev->pdev;
-}
-
-/**
- * ntb_query_debugfs() - return the debugfs pointer
- * @ndev: pointer to ntb_device instance
- *
- * Given the ntb pointer, return the debugfs directory pointer for the NTB
- * hardware device
- *
- * RETURNS: a pointer to the debugfs directory
- */
-static inline struct dentry *ntb_query_debugfs(struct ntb_device *ndev)
-{
-	return ndev->debugfs_dir;
-}
-
-struct ntb_device *ntb_register_transport(struct pci_dev *pdev,
-					  void *transport);
-void ntb_unregister_transport(struct ntb_device *ndev);
-void ntb_set_mw_addr(struct ntb_device *ndev, unsigned int mw, u64 addr);
-int ntb_register_db_callback(struct ntb_device *ndev, unsigned int idx,
-			     void *data, int (*db_cb_func)(void *data,
-							   int db_num));
-void ntb_unregister_db_callback(struct ntb_device *ndev, unsigned int idx);
-int ntb_register_event_callback(struct ntb_device *ndev,
-				void (*event_cb_func)(void *handle,
-						      enum ntb_hw_event event));
-void ntb_unregister_event_callback(struct ntb_device *ndev);
-int ntb_get_max_spads(struct ntb_device *ndev);
-int ntb_write_local_spad(struct ntb_device *ndev, unsigned int idx, u32 val);
-int ntb_read_local_spad(struct ntb_device *ndev, unsigned int idx, u32 *val);
-int ntb_write_remote_spad(struct ntb_device *ndev, unsigned int idx, u32 val);
-int ntb_read_remote_spad(struct ntb_device *ndev, unsigned int idx, u32 *val);
-resource_size_t ntb_get_mw_base(struct ntb_device *ndev, unsigned int mw);
-void __iomem *ntb_get_mw_vbase(struct ntb_device *ndev, unsigned int mw);
-u64 ntb_get_mw_size(struct ntb_device *ndev, unsigned int mw);
-void ntb_ring_doorbell(struct ntb_device *ndev, unsigned int idx);
-void *ntb_find_transport(struct pci_dev *pdev);
-
-int ntb_transport_init(struct pci_dev *pdev);
-void ntb_transport_free(void *transport);
+#define ndev_pdev(ndev) ((ndev)->ntb.pdev)
+#define ndev_name(ndev) pci_name(ndev_pdev(ndev))
+#define ndev_dev(ndev) (&ndev_pdev(ndev)->dev)
+#define ntb_ndev(ntb) container_of(ntb, struct intel_ntb_dev, ntb)
+#define hb_ndev(work) container_of(work, struct intel_ntb_dev, hb_timer.work)
+
+#endif
diff --git a/drivers/ntb/ntb.c b/drivers/ntb/ntb.c
new file mode 100644
index 0000000..0e27745
--- /dev/null
+++ b/drivers/ntb/ntb.c
@@ -0,0 +1,251 @@
+/*
+ * This file is provided under a dual BSD/GPLv2 license.  When using or
+ *   redistributing this file, you may do so under either license.
+ *
+ *   GPL LICENSE SUMMARY
+ *
+ *   Copyright (C) 2015 EMC Corporation. All Rights Reserved.
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of version 2 of the GNU General Public License as
+ *   published by the Free Software Foundation.
+ *
+ *   This program is distributed in the hope that it will be useful, but
+ *   WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *   General Public License for more details.
+ *
+ *   BSD LICENSE
+ *
+ *   Copyright (C) 2015 EMC Corporation. All Rights Reserved.
+ *
+ *   Redistribution and use in source and binary forms, with or without
+ *   modification, are permitted provided that the following conditions
+ *   are met:
+ *
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copy
+ *       notice, this list of conditions and the following disclaimer in
+ *       the documentation and/or other materials provided with the
+ *       distribution.
+ *     * Neither the name of Intel Corporation nor the names of its
+ *       contributors may be used to endorse or promote products derived
+ *       from this software without specific prior written permission.
+ *
+ *   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ *   "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ *   LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
+ *   A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ *   OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ *   SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+ *   LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
+ *   DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
+ *   THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ *   (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
+ *   OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * PCIe NTB Linux driver
+ *
+ * Contact Information:
+ * Allen Hubbe <Allen.Hubbe@emc.com>
+ */
+
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+
+#include <linux/ntb.h>
+#include <linux/pci.h>
+
+#define DRIVER_NAME			"ntb"
+#define DRIVER_DESCRIPTION		"PCIe NTB Driver Framework"
+
+#define DRIVER_LICENSE			"Dual BSD/GPL"
+#define DRIVER_VERSION			"1.0"
+#define DRIVER_RELDATE			"24 March 2015"
+#define DRIVER_AUTHOR			"Allen Hubbe <Allen.Hubbe@emc.com>"
+
+MODULE_LICENSE(DRIVER_LICENSE);
+MODULE_VERSION(DRIVER_VERSION);
+MODULE_AUTHOR(DRIVER_AUTHOR);
+MODULE_DESCRIPTION(DRIVER_DESCRIPTION);
+
+static struct bus_type ntb_bus;
+static void ntb_dev_release(struct device *dev);
+
+int ntb_register_client(struct ntb_client *client)
+{
+	if (!client)
+		return -EINVAL;
+	if (!client->name)
+		return -EINVAL;
+	if (!ntb_client_ops_is_valid(&client->ops))
+		return -EINVAL;
+
+	memset(&client->drv, 0, sizeof(client->drv));
+	client->drv.bus = &ntb_bus;
+	client->drv.name = client->name;
+
+	return driver_register(&client->drv);
+}
+EXPORT_SYMBOL(ntb_register_client);
+
+void ntb_unregister_client(struct ntb_client *client)
+{
+	driver_unregister(&client->drv);
+}
+EXPORT_SYMBOL(ntb_unregister_client);
+
+int ntb_register_device(struct ntb_dev *ntb)
+{
+	if (!ntb)
+		return -EINVAL;
+	if (!ntb->pdev)
+		return -EINVAL;
+	if (!ntb->ops)
+		return -EINVAL;
+	if (!ntb_dev_ops_is_valid(ntb->ops))
+		return -EINVAL;
+
+	init_completion(&ntb->released);
+
+	memset(&ntb->dev, 0, sizeof(ntb->dev));
+	ntb->dev.bus = &ntb_bus;
+	ntb->dev.parent = &ntb->pdev->dev;
+	ntb->dev.release = ntb_dev_release;
+	dev_set_name(&ntb->dev, pci_name(ntb->pdev));
+
+	ntb->ctx = NULL;
+	ntb->ctx_ops = NULL;
+	spin_lock_init(&ntb->ctx_lock);
+
+	return device_register(&ntb->dev);
+}
+EXPORT_SYMBOL(ntb_register_device);
+
+void ntb_unregister_device(struct ntb_dev *ntb)
+{
+	device_unregister(&ntb->dev);
+	wait_for_completion(&ntb->released);
+}
+EXPORT_SYMBOL(ntb_unregister_device);
+
+int ntb_set_ctx(struct ntb_dev *ntb, void *ctx,
+		const struct ntb_ctx_ops *ctx_ops)
+{
+	unsigned long irqflags;
+
+	if (!ntb_ctx_ops_is_valid(ctx_ops))
+		return -EINVAL;
+	if (ntb->ctx_ops)
+		return -EINVAL;
+
+	spin_lock_irqsave(&ntb->ctx_lock, irqflags);
+	{
+		ntb->ctx = ctx;
+		ntb->ctx_ops = ctx_ops;
+	}
+	spin_unlock_irqrestore(&ntb->ctx_lock, irqflags);
+
+	return 0;
+}
+EXPORT_SYMBOL(ntb_set_ctx);
+
+void ntb_clear_ctx(struct ntb_dev *ntb)
+{
+	unsigned long irqflags;
+
+	spin_lock_irqsave(&ntb->ctx_lock, irqflags);
+	{
+		ntb->ctx_ops = NULL;
+		ntb->ctx = NULL;
+	}
+	spin_unlock_irqrestore(&ntb->ctx_lock, irqflags);
+}
+EXPORT_SYMBOL(ntb_clear_ctx);
+
+void ntb_link_event(struct ntb_dev *ntb)
+{
+	unsigned long irqflags;
+
+	spin_lock_irqsave(&ntb->ctx_lock, irqflags);
+	{
+		if (ntb->ctx_ops && ntb->ctx_ops->link_event)
+			ntb->ctx_ops->link_event(ntb->ctx);
+	}
+	spin_unlock_irqrestore(&ntb->ctx_lock, irqflags);
+}
+EXPORT_SYMBOL(ntb_link_event);
+
+void ntb_db_event(struct ntb_dev *ntb, int vector)
+{
+	unsigned long irqflags;
+
+	spin_lock_irqsave(&ntb->ctx_lock, irqflags);
+	{
+		if (ntb->ctx_ops && ntb->ctx_ops->db_event)
+			ntb->ctx_ops->db_event(ntb->ctx, vector);
+	}
+	spin_unlock_irqrestore(&ntb->ctx_lock, irqflags);
+}
+EXPORT_SYMBOL(ntb_db_event);
+
+static int ntb_probe(struct device *dev)
+{
+	struct ntb_dev *ntb;
+	struct ntb_client *client;
+	int rc;
+
+	get_device(dev);
+	ntb = dev_ntb(dev);
+	client = drv_ntb_client(dev->driver);
+
+	rc = client->ops.probe(client, ntb);
+	if (rc)
+		put_device(dev);
+
+	return rc;
+}
+
+static int ntb_remove(struct device *dev)
+{
+	struct ntb_dev *ntb;
+	struct ntb_client *client;
+
+	if (dev->driver) {
+		ntb = dev_ntb(dev);
+		client = drv_ntb_client(dev->driver);
+
+		client->ops.remove(client, ntb);
+		put_device(dev);
+	}
+
+	return 0;
+}
+
+static void ntb_dev_release(struct device *dev)
+{
+	struct ntb_dev *ntb = dev_ntb(dev);
+
+	complete(&ntb->released);
+}
+
+static struct bus_type ntb_bus = {
+	.name = "ntb",
+	.probe = ntb_probe,
+	.remove = ntb_remove,
+};
+
+static int __init ntb_driver_init(void)
+{
+	return bus_register(&ntb_bus);
+}
+module_init(ntb_driver_init);
+
+static void __exit ntb_driver_exit(void)
+{
+	bus_unregister(&ntb_bus);
+}
+module_exit(ntb_driver_exit);
+
diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index b9d8e19..f1ed1b7 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -5,6 +5,7 @@
  *   GPL LICENSE SUMMARY
  *
  *   Copyright(c) 2012 Intel Corporation. All rights reserved.
+ *   Copyright (C) 2015 EMC Corporation. All Rights Reserved.
  *
  *   This program is free software; you can redistribute it and/or modify
  *   it under the terms of version 2 of the GNU General Public License as
@@ -13,6 +14,7 @@
  *   BSD LICENSE
  *
  *   Copyright(c) 2012 Intel Corporation. All rights reserved.
+ *   Copyright (C) 2015 EMC Corporation. All Rights Reserved.
  *
  *   Redistribution and use in source and binary forms, with or without
  *   modification, are permitted provided that the following conditions
@@ -40,7 +42,7 @@
  *   (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
  *   OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  *
- * Intel PCIe NTB Linux driver
+ * PCIe NTB Transport Linux driver
  *
  * Contact Information:
  * Jon Mason <jon.mason@intel.com>
@@ -56,9 +58,22 @@
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/types.h>
-#include "hw/intel/ntb_hw_intel.h"
+#include "linux/ntb.h"
+#include "linux/ntb_transport.h"
 
-#define NTB_TRANSPORT_VERSION	3
+#define NTB_TRANSPORT_VERSION	4
+#define NTB_TRANSPORT_VER	"4"
+#define NTB_TRANSPORT_NAME	"ntb_transport"
+#define NTB_TRANSPORT_DESC	"Software Queue-Pair Transport over NTB"
+
+MODULE_DESCRIPTION(NTB_TRANSPORT_DESC);
+MODULE_VERSION(NTB_TRANSPORT_VER);
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_AUTHOR("Intel Corporation");
+
+static unsigned long max_mw_size;
+module_param(max_mw_size, ulong, 0644);
+MODULE_PARM_DESC(max_mw_size, "Limit size of large memory windows");
 
 static unsigned int transport_mtu = 0x401E;
 module_param(transport_mtu, uint, 0644);
@@ -72,6 +87,8 @@ static unsigned int copy_bytes = 1024;
 module_param(copy_bytes, uint, 0644);
 MODULE_PARM_DESC(copy_bytes, "Threshold under which NTB will use the CPU to copy instead of DMA");
 
+static struct dentry *nt_debugfs_dir;
+
 struct ntb_queue_entry {
 	/* ntb_queue list reference */
 	struct list_head entry;
@@ -94,14 +111,16 @@ struct ntb_rx_info {
 };
 
 struct ntb_transport_qp {
-	struct ntb_transport *transport;
-	struct ntb_device *ndev;
+	struct ntb_transport_ctx *transport;
+	struct ntb_dev *ndev;
 	void *cb_data;
 	struct dma_chan *dma_chan;
 
 	bool client_ready;
-	bool qp_link;
+	bool link_is_up;
+
 	u8 qp_num;	/* Only 64 QP's are allowed.  0-63 */
+	u64 qp_bit;
 
 	struct ntb_rx_info __iomem *rx_info;
 	struct ntb_rx_info *remote_rx_info;
@@ -153,33 +172,45 @@ struct ntb_transport_qp {
 };
 
 struct ntb_transport_mw {
-	size_t size;
+	phys_addr_t phys_addr;
+	resource_size_t phys_size;
+	resource_size_t xlat_align;
+	resource_size_t xlat_align_size;
+	void __iomem *vbase;
+	size_t xlat_size;
+	size_t buff_size;
 	void *virt_addr;
 	dma_addr_t dma_addr;
 };
 
 struct ntb_transport_client_dev {
 	struct list_head entry;
+	struct ntb_transport_ctx *nt;
 	struct device dev;
 };
 
-struct ntb_transport {
+struct ntb_transport_ctx {
 	struct list_head entry;
 	struct list_head client_devs;
 
-	struct ntb_device *ndev;
-	struct ntb_transport_mw *mw;
-	struct ntb_transport_qp *qps;
-	unsigned int max_qps;
-	unsigned long qp_bitmap;
-	bool transport_link;
+	struct ntb_dev *ndev;
+
+	struct ntb_transport_mw *mw_vec;
+	struct ntb_transport_qp *qp_vec;
+	unsigned int mw_count;
+	unsigned int qp_count;
+	u64 qp_bitmap;
+	u64 qp_bitmap_free;
+
+	bool link_is_up;
 	struct delayed_work link_work;
+	struct work_struct db_work;
 	struct work_struct link_cleanup;
 };
 
 enum {
-	DESC_DONE_FLAG = 1 << 0,
-	LINK_DOWN_FLAG = 1 << 1,
+	DESC_DONE_FLAG = BIT(0),
+	LINK_DOWN_FLAG = BIT(1),
 };
 
 struct ntb_payload_header {
@@ -200,68 +231,69 @@ enum {
 	MAX_SPAD,
 };
 
-#define QP_TO_MW(ndev, qp)	((qp) % ntb_max_mw(ndev))
+#define dev_client_dev(__dev) \
+	container_of((__dev), struct ntb_transport_client_dev, dev)
+
+#define drv_client(__drv) \
+	container_of((__drv), struct ntb_transport_client, driver)
+
+#define QP_TO_MW(nt, qp)	((qp) % nt->mw_count)
 #define NTB_QP_DEF_NUM_ENTRIES	100
 #define NTB_LINK_DOWN_TIMEOUT	10
 
-static int ntb_match_bus(struct device *dev, struct device_driver *drv)
+static void ntb_transport_doorbell_work(struct work_struct *ws);
+static const struct ntb_ctx_ops ntb_transport_ops;
+static struct ntb_client ntb_transport_client;
+
+static int ntb_transport_bus_match(struct device *dev,
+				   struct device_driver *drv)
 {
 	return !strncmp(dev_name(dev), drv->name, strlen(drv->name));
 }
 
-static int ntb_client_probe(struct device *dev)
+static int ntb_transport_bus_probe(struct device *dev)
 {
-	const struct ntb_client *drv = container_of(dev->driver,
-						    struct ntb_client, driver);
-	struct pci_dev *pdev = container_of(dev->parent, struct pci_dev, dev);
+	const struct ntb_transport_client *client;
 	int rc = -EINVAL;
 
 	get_device(dev);
-	if (drv && drv->probe)
-		rc = drv->probe(pdev);
+
+	client = drv_client(dev->driver);
+	rc = client->probe(dev);
 	if (rc)
 		put_device(dev);
 
 	return rc;
 }
 
-static int ntb_client_remove(struct device *dev)
+static int ntb_transport_bus_remove(struct device *dev)
 {
-	const struct ntb_client *drv = container_of(dev->driver,
-						    struct ntb_client, driver);
-	struct pci_dev *pdev = container_of(dev->parent, struct pci_dev, dev);
+	const struct ntb_transport_client *client;
 
-	if (drv && drv->remove)
-		drv->remove(pdev);
+	client = drv_client(dev->driver);
+	client->remove(dev);
 
 	put_device(dev);
 
 	return 0;
 }
 
-static struct bus_type ntb_bus_type = {
-	.name = "ntb_bus",
-	.match = ntb_match_bus,
-	.probe = ntb_client_probe,
-	.remove = ntb_client_remove,
+static struct bus_type ntb_transport_bus = {
+	.name = "ntb_transport",
+	.match = ntb_transport_bus_match,
+	.probe = ntb_transport_bus_probe,
+	.remove = ntb_transport_bus_remove,
 };
 
 static LIST_HEAD(ntb_transport_list);
 
-static int ntb_bus_init(struct ntb_transport *nt)
+static int ntb_bus_init(struct ntb_transport_ctx *nt)
 {
-	if (list_empty(&ntb_transport_list)) {
-		int rc = bus_register(&ntb_bus_type);
-		if (rc)
-			return rc;
-	}
-
 	list_add(&nt->entry, &ntb_transport_list);
-
 	return 0;
 }
 
-static void ntb_bus_remove(struct ntb_transport *nt)
+static void ntb_bus_remove(struct ntb_transport_ctx *nt)
 {
 	struct ntb_transport_client_dev *client_dev, *cd;
 
@@ -273,29 +305,26 @@ static void ntb_bus_remove(struct ntb_transport *nt)
 	}
 
 	list_del(&nt->entry);
-
-	if (list_empty(&ntb_transport_list))
-		bus_unregister(&ntb_bus_type);
 }
 
-static void ntb_client_release(struct device *dev)
+static void ntb_transport_client_release(struct device *dev)
 {
 	struct ntb_transport_client_dev *client_dev;
-	client_dev = container_of(dev, struct ntb_transport_client_dev, dev);
 
+	client_dev = dev_client_dev(dev);
 	kfree(client_dev);
 }
 
 /**
- * ntb_unregister_client_dev - Unregister NTB client device
+ * ntb_transport_unregister_client_dev - Unregister NTB client device
  * @device_name: Name of NTB client device
  *
  * Unregister an NTB client device with the NTB transport layer
  */
-void ntb_unregister_client_dev(char *device_name)
+void ntb_transport_unregister_client_dev(char *device_name)
 {
 	struct ntb_transport_client_dev *client, *cd;
-	struct ntb_transport *nt;
+	struct ntb_transport_ctx *nt;
 
 	list_for_each_entry(nt, &ntb_transport_list, entry)
 		list_for_each_entry_safe(client, cd, &nt->client_devs, entry)
@@ -305,18 +334,18 @@ void ntb_unregister_client_dev(char *device_name)
 				device_unregister(&client->dev);
 			}
 }
-EXPORT_SYMBOL_GPL(ntb_unregister_client_dev);
+EXPORT_SYMBOL_GPL(ntb_transport_unregister_client_dev);
 
 /**
- * ntb_register_client_dev - Register NTB client device
+ * ntb_transport_register_client_dev - Register NTB client device
  * @device_name: Name of NTB client device
  *
  * Register an NTB client device with the NTB transport layer
  */
-int ntb_register_client_dev(char *device_name)
+int ntb_transport_register_client_dev(char *device_name)
 {
 	struct ntb_transport_client_dev *client_dev;
-	struct ntb_transport *nt;
+	struct ntb_transport_ctx *nt;
 	int rc, i = 0;
 
 	if (list_empty(&ntb_transport_list))
@@ -325,7 +354,7 @@ int ntb_register_client_dev(char *device_name)
 	list_for_each_entry(nt, &ntb_transport_list, entry) {
 		struct device *dev;
 
-		client_dev = kzalloc(sizeof(struct ntb_transport_client_dev),
+		client_dev = kzalloc(sizeof(*client_dev),
 				     GFP_KERNEL);
 		if (!client_dev) {
 			rc = -ENOMEM;
@@ -336,9 +365,9 @@ int ntb_register_client_dev(char *device_name)
 
 		/* setup and register client devices */
 		dev_set_name(dev, "%s%d", device_name, i);
-		dev->bus = &ntb_bus_type;
-		dev->release = ntb_client_release;
-		dev->parent = &ntb_query_pdev(nt->ndev)->dev;
+		dev->bus = &ntb_transport_bus;
+		dev->release = ntb_transport_client_release;
+		dev->parent = &nt->ndev->dev;
 
 		rc = device_register(dev);
 		if (rc) {
@@ -353,44 +382,44 @@ int ntb_register_client_dev(char *device_name)
 	return 0;
 
 err:
-	ntb_unregister_client_dev(device_name);
+	ntb_transport_unregister_client_dev(device_name);
 
 	return rc;
 }
-EXPORT_SYMBOL_GPL(ntb_register_client_dev);
+EXPORT_SYMBOL_GPL(ntb_transport_register_client_dev);
 
 /**
- * ntb_register_client - Register NTB client driver
+ * ntb_transport_register_client - Register NTB client driver
  * @drv: NTB client driver to be registered
  *
  * Register an NTB client driver with the NTB transport layer
  *
  * RETURNS: An appropriate -ERRNO error value on error, or zero for success.
  */
-int ntb_register_client(struct ntb_client *drv)
+int ntb_transport_register_client(struct ntb_transport_client *drv)
 {
-	drv->driver.bus = &ntb_bus_type;
+	drv->driver.bus = &ntb_transport_bus;
 
 	if (list_empty(&ntb_transport_list))
 		return -ENODEV;
 
 	return driver_register(&drv->driver);
 }
-EXPORT_SYMBOL_GPL(ntb_register_client);
+EXPORT_SYMBOL_GPL(ntb_transport_register_client);
 
 /**
- * ntb_unregister_client - Unregister NTB client driver
+ * ntb_transport_unregister_client - Unregister NTB client driver
  * @drv: NTB client driver to be unregistered
  *
  * Unregister an NTB client driver with the NTB transport layer
  *
  * RETURNS: An appropriate -ERRNO error value on error, or zero for success.
  */
-void ntb_unregister_client(struct ntb_client *drv)
+void ntb_transport_unregister_client(struct ntb_transport_client *drv)
 {
 	driver_unregister(&drv->driver);
 }
-EXPORT_SYMBOL_GPL(ntb_unregister_client);
+EXPORT_SYMBOL_GPL(ntb_transport_unregister_client);
 
 static ssize_t debugfs_read(struct file *filp, char __user *ubuf, size_t count,
 			    loff_t *offp)
@@ -452,8 +481,7 @@ static ssize_t debugfs_read(struct file *filp, char __user *ubuf, size_t count,
 			       "tx_max_entry - \t%u\n", qp->tx_max_entry);
 
 	out_offset += snprintf(buf + out_offset, out_count - out_offset,
-			       "\nQP Link %s\n", (qp->qp_link == NTB_LINK_UP) ?
-			       "Up" : "Down");
+			"\nQP Link %s\n", qp->link_is_up ? "Up" : "Down");
 	if (out_offset > out_count)
 		out_offset = out_count;
 
@@ -497,26 +525,31 @@ out:
 	return entry;
 }
 
-static void ntb_transport_setup_qp_mw(struct ntb_transport *nt,
-				      unsigned int qp_num)
+static int ntb_transport_setup_qp_mw(struct ntb_transport_ctx *nt,
+				     unsigned int qp_num)
 {
-	struct ntb_transport_qp *qp = &nt->qps[qp_num];
+	struct ntb_transport_qp *qp = &nt->qp_vec[qp_num];
+	struct ntb_transport_mw *mw;
 	unsigned int rx_size, num_qps_mw;
-	u8 mw_num, mw_max;
+	unsigned int mw_num, mw_count, qp_count;
 	unsigned int i;
 
-	mw_max = ntb_max_mw(nt->ndev);
-	mw_num = QP_TO_MW(nt->ndev, qp_num);
+	mw_count = nt->mw_count;
+	qp_count = nt->qp_count;
 
-	WARN_ON(nt->mw[mw_num].virt_addr == NULL);
+	mw_num = QP_TO_MW(nt, qp_num);
+	mw = &nt->mw_vec[mw_num];
+
+	if (!mw->virt_addr)
+		return -ENOMEM;
 
-	if (nt->max_qps % mw_max && mw_num + 1 < nt->max_qps / mw_max)
-		num_qps_mw = nt->max_qps / mw_max + 1;
+	if (qp_count % mw_count && mw_num + 1 < qp_count / mw_count)
+		num_qps_mw = qp_count / mw_count + 1;
 	else
-		num_qps_mw = nt->max_qps / mw_max;
+		num_qps_mw = qp_count / mw_count;
 
-	rx_size = (unsigned int) nt->mw[mw_num].size / num_qps_mw;
-	qp->rx_buff = nt->mw[mw_num].virt_addr + qp_num / mw_max * rx_size;
+	rx_size = (unsigned int)mw->xlat_size / num_qps_mw;
+	qp->rx_buff = mw->virt_addr + rx_size * qp_num / mw_count;
 	rx_size -= sizeof(struct ntb_rx_info);
 
 	qp->remote_rx_info = qp->rx_buff + rx_size;
@@ -538,41 +571,55 @@ static void ntb_transport_setup_qp_mw(struct ntb_transport *nt,
 	qp->rx_pkts = 0;
 	qp->tx_pkts = 0;
 	qp->tx_index = 0;
+
+	return 0;
 }
 
-static void ntb_free_mw(struct ntb_transport *nt, int num_mw)
+static void ntb_free_mw(struct ntb_transport_ctx *nt, int num_mw)
 {
-	struct ntb_transport_mw *mw = &nt->mw[num_mw];
-	struct pci_dev *pdev = ntb_query_pdev(nt->ndev);
+	struct ntb_transport_mw *mw = &nt->mw_vec[num_mw];
+	struct pci_dev *pdev = nt->ndev->pdev;
 
 	if (!mw->virt_addr)
 		return;
 
-	dma_free_coherent(&pdev->dev, mw->size, mw->virt_addr, mw->dma_addr);
+	ntb_mw_clear_trans(nt->ndev, num_mw);
+	dma_free_coherent(&pdev->dev, mw->buff_size,
+			  mw->virt_addr, mw->dma_addr);
+	mw->xlat_size = 0;
+	mw->buff_size = 0;
 	mw->virt_addr = NULL;
 }
 
-static int ntb_set_mw(struct ntb_transport *nt, int num_mw, unsigned int size)
+static int ntb_set_mw(struct ntb_transport_ctx *nt, int num_mw,
+		      unsigned int size)
 {
-	struct ntb_transport_mw *mw = &nt->mw[num_mw];
-	struct pci_dev *pdev = ntb_query_pdev(nt->ndev);
+	struct ntb_transport_mw *mw = &nt->mw_vec[num_mw];
+	struct pci_dev *pdev = nt->ndev->pdev;
+	unsigned int xlat_size, buff_size;
+	int rc;
+
+	xlat_size = round_up(size, mw->xlat_align_size);
+	buff_size = round_up(size, mw->xlat_align);
 
 	/* No need to re-setup */
-	if (mw->size == ALIGN(size, 4096))
+	if (mw->xlat_size == xlat_size)
 		return 0;
 
-	if (mw->size != 0)
+	if (mw->buff_size)
 		ntb_free_mw(nt, num_mw);
 
-	/* Alloc memory for receiving data.  Must be 4k aligned */
-	mw->size = ALIGN(size, 4096);
+	/* Alloc memory for receiving data.  Must be aligned */
+	mw->xlat_size = xlat_size;
+	mw->buff_size = buff_size;
 
-	mw->virt_addr = dma_alloc_coherent(&pdev->dev, mw->size, &mw->dma_addr,
-					   GFP_KERNEL);
+	mw->virt_addr = dma_alloc_coherent(&pdev->dev, buff_size,
+			&mw->dma_addr, GFP_KERNEL);
 	if (!mw->virt_addr) {
-		mw->size = 0;
-		dev_err(&pdev->dev, "Unable to allocate MW buffer of size %d\n",
-		       (int) mw->size);
+		mw->xlat_size = 0;
+		mw->buff_size = 0;
+		dev_err(&pdev->dev, "Unable to alloc MW buff of size %d\n",
+			buff_size);
 		return -ENOMEM;
 	}
 
@@ -582,34 +629,39 @@ static int ntb_set_mw(struct ntb_transport *nt, int num_mw, unsigned int size)
 	 * is a requirement of the hardware. It is recommended to setup CMA
 	 * for BAR sizes equal or greater than 4MB.
 	 */
-	if (!IS_ALIGNED(mw->dma_addr, mw->size)) {
-		dev_err(&pdev->dev, "DMA memory %pad not aligned to BAR size\n",
+	if (!IS_ALIGNED(mw->dma_addr, mw->xlat_align)) {
+		dev_err(&pdev->dev, "DMA memory %pad is not aligned\n",
 			&mw->dma_addr);
 		ntb_free_mw(nt, num_mw);
 		return -ENOMEM;
 	}
 
 	/* Notify HW the memory location of the receive buffer */
-	ntb_set_mw_addr(nt->ndev, num_mw, mw->dma_addr);
+	rc = ntb_mw_set_trans(nt->ndev, num_mw, mw->dma_addr, mw->xlat_size);
+	if (rc) {
+		dev_err(&pdev->dev, "Unable to set mw%d translation", num_mw);
+		ntb_free_mw(nt, num_mw);
+		return -EIO;
+	}
 
 	return 0;
 }
 
 static void ntb_qp_link_cleanup(struct ntb_transport_qp *qp)
 {
-	struct ntb_transport *nt = qp->transport;
-	struct pci_dev *pdev = ntb_query_pdev(nt->ndev);
+	struct ntb_transport_ctx *nt = qp->transport;
+	struct pci_dev *pdev = nt->ndev->pdev;
 
-	if (qp->qp_link == NTB_LINK_DOWN) {
+	if (qp->link_is_up) {
 		cancel_delayed_work_sync(&qp->link_work);
 		return;
 	}
 
-	if (qp->event_handler)
-		qp->event_handler(qp->cb_data, NTB_LINK_DOWN);
-
 	dev_info(&pdev->dev, "qp %d: Link Down\n", qp->qp_num);
-	qp->qp_link = NTB_LINK_DOWN;
+	qp->link_is_up = false;
+
+	if (qp->event_handler)
+		qp->event_handler(qp->cb_data, qp->link_is_up);
 }
 
 static void ntb_qp_link_cleanup_work(struct work_struct *work)
@@ -617,11 +669,11 @@ static void ntb_qp_link_cleanup_work(struct work_struct *work)
 	struct ntb_transport_qp *qp = container_of(work,
 						   struct ntb_transport_qp,
 						   link_cleanup);
-	struct ntb_transport *nt = qp->transport;
+	struct ntb_transport_ctx *nt = qp->transport;
 
 	ntb_qp_link_cleanup(qp);
 
-	if (nt->transport_link == NTB_LINK_UP)
+	if (nt->link_is_up)
 		schedule_delayed_work(&qp->link_work,
 				      msecs_to_jiffies(NTB_LINK_DOWN_TIMEOUT));
 }
@@ -631,180 +683,132 @@ static void ntb_qp_link_down(struct ntb_transport_qp *qp)
 	schedule_work(&qp->link_cleanup);
 }
 
-static void ntb_transport_link_cleanup(struct ntb_transport *nt)
+static void ntb_transport_link_cleanup(struct ntb_transport_ctx *nt)
 {
+	struct ntb_transport_qp *qp;
+	u64 qp_bitmap_alloc;
 	int i;
 
+	qp_bitmap_alloc = nt->qp_bitmap & ~nt->qp_bitmap_free;
+
 	/* Pass along the info to any clients */
-	for (i = 0; i < nt->max_qps; i++)
-		if (!test_bit(i, &nt->qp_bitmap))
-			ntb_qp_link_cleanup(&nt->qps[i]);
+	for (i = 0; i < nt->qp_count; i++)
+		if (qp_bitmap_alloc & BIT_ULL(i)) {
+			qp = &nt->qp_vec[i];
+			ntb_qp_link_cleanup(qp);
+			cancel_work_sync(&qp->link_cleanup);
+			cancel_delayed_work_sync(&qp->link_work);
+		}
 
-	if (nt->transport_link == NTB_LINK_DOWN)
+	if (!nt->link_is_up)
 		cancel_delayed_work_sync(&nt->link_work);
-	else
-		nt->transport_link = NTB_LINK_DOWN;
 
 	/* The scratchpad registers keep the values if the remote side
 	 * goes down, blast them now to give them a sane value the next
 	 * time they are accessed
 	 */
 	for (i = 0; i < MAX_SPAD; i++)
-		ntb_write_local_spad(nt->ndev, i, 0);
+		ntb_spad_write(nt->ndev, i, 0);
 }
 
 static void ntb_transport_link_cleanup_work(struct work_struct *work)
 {
-	struct ntb_transport *nt = container_of(work, struct ntb_transport,
-						link_cleanup);
+	struct ntb_transport_ctx *nt =
+		container_of(work, struct ntb_transport_ctx, link_cleanup);
 
 	ntb_transport_link_cleanup(nt);
 }
 
-static void ntb_transport_event_callback(void *data, enum ntb_hw_event event)
+static void ntb_transport_event_callback(void *data)
 {
-	struct ntb_transport *nt = data;
+	struct ntb_transport_ctx *nt = data;
 
-	switch (event) {
-	case NTB_EVENT_HW_LINK_UP:
+	if (ntb_link_is_up(nt->ndev, NULL, NULL) == 1)
 		schedule_delayed_work(&nt->link_work, 0);
-		break;
-	case NTB_EVENT_HW_LINK_DOWN:
+	else
 		schedule_work(&nt->link_cleanup);
-		break;
-	default:
-		BUG();
-	}
 }
 
 static void ntb_transport_link_work(struct work_struct *work)
 {
-	struct ntb_transport *nt = container_of(work, struct ntb_transport,
-						link_work.work);
-	struct ntb_device *ndev = nt->ndev;
-	struct pci_dev *pdev = ntb_query_pdev(ndev);
+	struct ntb_transport_ctx *nt =
+		container_of(work, struct ntb_transport_ctx, link_work.work);
+	struct ntb_dev *ndev = nt->ndev;
+	struct pci_dev *pdev = ndev->pdev;
+	resource_size_t size;
 	u32 val;
-	int rc, i;
+	int rc, i, spad;
 
 	/* send the local info, in the opposite order of the way we read it */
-	for (i = 0; i < ntb_max_mw(ndev); i++) {
-		rc = ntb_write_remote_spad(ndev, MW0_SZ_HIGH + (i * 2),
-					   ntb_get_mw_size(ndev, i) >> 32);
-		if (rc) {
-			dev_err(&pdev->dev, "Error writing %u to remote spad %d\n",
-				(u32)(ntb_get_mw_size(ndev, i) >> 32),
-				MW0_SZ_HIGH + (i * 2));
-			goto out;
-		}
+	for (i = 0; i < nt->mw_count; i++) {
+		size = nt->mw_vec[i].phys_size;
 
-		rc = ntb_write_remote_spad(ndev, MW0_SZ_LOW + (i * 2),
-					   (u32) ntb_get_mw_size(ndev, i));
-		if (rc) {
-			dev_err(&pdev->dev, "Error writing %u to remote spad %d\n",
-				(u32) ntb_get_mw_size(ndev, i),
-				MW0_SZ_LOW + (i * 2));
-			goto out;
-		}
-	}
+		if (max_mw_size && size > max_mw_size)
+			size = max_mw_size;
 
-	rc = ntb_write_remote_spad(ndev, NUM_MWS, ntb_max_mw(ndev));
-	if (rc) {
-		dev_err(&pdev->dev, "Error writing %x to remote spad %d\n",
-			ntb_max_mw(ndev), NUM_MWS);
-		goto out;
-	}
+		spad = MW0_SZ_HIGH + (i * 2);
+		ntb_peer_spad_write(ndev, spad, (u32)(size >> 32));
 
-	rc = ntb_write_remote_spad(ndev, NUM_QPS, nt->max_qps);
-	if (rc) {
-		dev_err(&pdev->dev, "Error writing %x to remote spad %d\n",
-			nt->max_qps, NUM_QPS);
-		goto out;
+		spad = MW0_SZ_LOW + (i * 2);
+		ntb_peer_spad_write(ndev, spad, (u32)size);
 	}
 
-	rc = ntb_write_remote_spad(ndev, VERSION, NTB_TRANSPORT_VERSION);
-	if (rc) {
-		dev_err(&pdev->dev, "Error writing %x to remote spad %d\n",
-			NTB_TRANSPORT_VERSION, VERSION);
-		goto out;
-	}
+	ntb_peer_spad_write(ndev, NUM_MWS, nt->mw_count);
 
-	/* Query the remote side for its info */
-	rc = ntb_read_remote_spad(ndev, VERSION, &val);
-	if (rc) {
-		dev_err(&pdev->dev, "Error reading remote spad %d\n", VERSION);
-		goto out;
-	}
+	ntb_peer_spad_write(ndev, NUM_QPS, nt->qp_count);
 
-	if (val != NTB_TRANSPORT_VERSION)
-		goto out;
-	dev_dbg(&pdev->dev, "Remote version = %d\n", val);
+	ntb_peer_spad_write(ndev, VERSION, NTB_TRANSPORT_VERSION);
 
-	rc = ntb_read_remote_spad(ndev, NUM_QPS, &val);
-	if (rc) {
-		dev_err(&pdev->dev, "Error reading remote spad %d\n", NUM_QPS);
+	/* Query the remote side for its info */
+	val = ntb_peer_spad_read(ndev, VERSION);
+	dev_dbg(&pdev->dev, "Remote version = %d\n", val);
+	if (val != NTB_TRANSPORT_VERSION)
 		goto out;
-	}
 
-	if (val != nt->max_qps)
-		goto out;
+	val = ntb_peer_spad_read(ndev, NUM_QPS);
 	dev_dbg(&pdev->dev, "Remote max number of qps = %d\n", val);
-
-	rc = ntb_read_remote_spad(ndev, NUM_MWS, &val);
-	if (rc) {
-		dev_err(&pdev->dev, "Error reading remote spad %d\n", NUM_MWS);
+	if (val != nt->qp_count)
 		goto out;
-	}
 
-	if (val != ntb_max_mw(ndev))
-		goto out;
+	val = ntb_peer_spad_read(ndev, NUM_MWS);
 	dev_dbg(&pdev->dev, "Remote number of mws = %d\n", val);
+	if (val != nt->mw_count)
+		goto out;
 
-	for (i = 0; i < ntb_max_mw(ndev); i++) {
+	for (i = 0; i < nt->mw_count; i++) {
 		u64 val64;
 
-		rc = ntb_read_remote_spad(ndev, MW0_SZ_HIGH + (i * 2), &val);
-		if (rc) {
-			dev_err(&pdev->dev, "Error reading remote spad %d\n",
-				MW0_SZ_HIGH + (i * 2));
-			goto out1;
-		}
-
-		val64 = (u64) val << 32;
-
-		rc = ntb_read_remote_spad(ndev, MW0_SZ_LOW + (i * 2), &val);
-		if (rc) {
-			dev_err(&pdev->dev, "Error reading remote spad %d\n",
-				MW0_SZ_LOW + (i * 2));
-			goto out1;
-		}
+		val = ntb_peer_spad_read(ndev, MW0_SZ_HIGH + (i * 2));
+		val64 = (u64)val << 32;
 
+		val = ntb_peer_spad_read(ndev, MW0_SZ_LOW + (i * 2));
 		val64 |= val;
 
-		dev_dbg(&pdev->dev, "Remote MW%d size = %llu\n", i, val64);
+		dev_dbg(&pdev->dev, "Remote MW%d size = %#llx\n", i, val64);
 
 		rc = ntb_set_mw(nt, i, val64);
 		if (rc)
 			goto out1;
 	}
 
-	nt->transport_link = NTB_LINK_UP;
+	nt->link_is_up = true;
 
-	for (i = 0; i < nt->max_qps; i++) {
-		struct ntb_transport_qp *qp = &nt->qps[i];
+	for (i = 0; i < nt->qp_count; i++) {
+		struct ntb_transport_qp *qp = &nt->qp_vec[i];
 
 		ntb_transport_setup_qp_mw(nt, i);
 
-		if (qp->client_ready == NTB_LINK_UP)
+		if (qp->client_ready)
 			schedule_delayed_work(&qp->link_work, 0);
 	}
 
 	return;
 
 out1:
-	for (i = 0; i < ntb_max_mw(ndev); i++)
+	for (i = 0; i < nt->mw_count; i++)
 		ntb_free_mw(nt, i);
 out:
-	if (ntb_hw_link_status(ndev))
+	if (ntb_link_is_up(ndev, NULL, NULL) == 1)
 		schedule_delayed_work(&nt->link_work,
 				      msecs_to_jiffies(NTB_LINK_DOWN_TIMEOUT));
 }
@@ -814,73 +818,73 @@ static void ntb_qp_link_work(struct work_struct *work)
 	struct ntb_transport_qp *qp = container_of(work,
 						   struct ntb_transport_qp,
 						   link_work.work);
-	struct pci_dev *pdev = ntb_query_pdev(qp->ndev);
-	struct ntb_transport *nt = qp->transport;
-	int rc, val;
+	struct pci_dev *pdev = qp->ndev->pdev;
+	struct ntb_transport_ctx *nt = qp->transport;
+	int val;
 
-	WARN_ON(nt->transport_link != NTB_LINK_UP);
+	WARN_ON(!nt->link_is_up);
 
-	rc = ntb_read_local_spad(nt->ndev, QP_LINKS, &val);
-	if (rc) {
-		dev_err(&pdev->dev, "Error reading spad %d\n", QP_LINKS);
-		return;
-	}
+	val = ntb_spad_read(nt->ndev, QP_LINKS);
 
-	rc = ntb_write_remote_spad(nt->ndev, QP_LINKS, val | 1 << qp->qp_num);
-	if (rc)
-		dev_err(&pdev->dev, "Error writing %x to remote spad %d\n",
-			val | 1 << qp->qp_num, QP_LINKS);
+	ntb_peer_spad_write(nt->ndev, QP_LINKS, val | BIT(qp->qp_num));
 
 	/* query remote spad for qp ready bits */
-	rc = ntb_read_remote_spad(nt->ndev, QP_LINKS, &val);
-	if (rc)
-		dev_err(&pdev->dev, "Error reading remote spad %d\n", QP_LINKS);
-
+	ntb_peer_spad_read(nt->ndev, QP_LINKS);
 	dev_dbg(&pdev->dev, "Remote QP link status = %x\n", val);
 
 	/* See if the remote side is up */
-	if (1 << qp->qp_num & val) {
-		qp->qp_link = NTB_LINK_UP;
-
+	if (val & BIT(qp->qp_num)) {
 		dev_info(&pdev->dev, "qp %d: Link Up\n", qp->qp_num);
+		qp->link_is_up = true;
+
 		if (qp->event_handler)
-			qp->event_handler(qp->cb_data, NTB_LINK_UP);
-	} else if (nt->transport_link == NTB_LINK_UP)
+			qp->event_handler(qp->cb_data, qp->link_is_up);
+	} else if (nt->link_is_up)
 		schedule_delayed_work(&qp->link_work,
 				      msecs_to_jiffies(NTB_LINK_DOWN_TIMEOUT));
 }
 
-static int ntb_transport_init_queue(struct ntb_transport *nt,
+static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
 				    unsigned int qp_num)
 {
 	struct ntb_transport_qp *qp;
+	struct ntb_transport_mw *mw;
+	phys_addr_t mw_base;
+	resource_size_t mw_size;
 	unsigned int num_qps_mw, tx_size;
-	u8 mw_num, mw_max;
+	unsigned int mw_num, mw_count, qp_count;
 	u64 qp_offset;
 
-	mw_max = ntb_max_mw(nt->ndev);
-	mw_num = QP_TO_MW(nt->ndev, qp_num);
+	mw_count = nt->mw_count;
+	qp_count = nt->qp_count;
 
-	qp = &nt->qps[qp_num];
+	mw_num = QP_TO_MW(nt, qp_num);
+	mw = &nt->mw_vec[mw_num];
+
+	qp = &nt->qp_vec[qp_num];
 	qp->qp_num = qp_num;
 	qp->transport = nt;
 	qp->ndev = nt->ndev;
-	qp->qp_link = NTB_LINK_DOWN;
-	qp->client_ready = NTB_LINK_DOWN;
+	qp->link_is_up = false;
+	qp->client_ready = false;
 	qp->event_handler = NULL;
 
-	if (nt->max_qps % mw_max && mw_num + 1 < nt->max_qps / mw_max)
-		num_qps_mw = nt->max_qps / mw_max + 1;
+	if (qp_count % mw_count && mw_num + 1 < qp_count / mw_count)
+		num_qps_mw = qp_count / mw_count + 1;
 	else
-		num_qps_mw = nt->max_qps / mw_max;
+		num_qps_mw = qp_count / mw_count;
+
+	mw_base = nt->mw_vec[mw_num].phys_addr;
+	mw_size = nt->mw_vec[mw_num].phys_size;
+
+	tx_size = (unsigned int)mw_size / num_qps_mw;
+	qp_offset = tx_size * qp_num / mw_count;
 
-	tx_size = (unsigned int) ntb_get_mw_size(qp->ndev, mw_num) / num_qps_mw;
-	qp_offset = qp_num / mw_max * tx_size;
-	qp->tx_mw = ntb_get_mw_vbase(nt->ndev, mw_num) + qp_offset;
+	qp->tx_mw = nt->mw_vec[mw_num].vbase + qp_offset;
 	if (!qp->tx_mw)
 		return -EINVAL;
 
-	qp->tx_mw_phys = ntb_get_mw_base(qp->ndev, mw_num) + qp_offset;
+	qp->tx_mw_phys = mw_base + qp_offset;
 	if (!qp->tx_mw_phys)
 		return -EINVAL;
 
@@ -891,16 +895,19 @@ static int ntb_transport_init_queue(struct ntb_transport *nt,
 	qp->tx_max_frame = min(transport_mtu, tx_size / 2);
 	qp->tx_max_entry = tx_size / qp->tx_max_frame;
 
-	if (ntb_query_debugfs(nt->ndev)) {
+	if (nt_debugfs_dir) {
 		char debugfs_name[4];
 
 		snprintf(debugfs_name, 4, "qp%d", qp_num);
 		qp->debugfs_dir = debugfs_create_dir(debugfs_name,
-						 ntb_query_debugfs(nt->ndev));
+						 nt_debugfs_dir);
 
 		qp->debugfs_stats = debugfs_create_file("stats", S_IRUSR,
 							qp->debugfs_dir, qp,
 							&ntb_qp_debugfs_stats);
+	} else {
+		qp->debugfs_dir = NULL;
+		qp->debugfs_stats = NULL;
 	}
 
 	INIT_DELAYED_WORK(&qp->link_work, ntb_qp_link_work);
@@ -917,53 +924,88 @@ static int ntb_transport_init_queue(struct ntb_transport *nt,
 	return 0;
 }
 
-int ntb_transport_init(struct pci_dev *pdev)
+static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
 {
-	struct ntb_transport *nt;
+	struct ntb_transport_ctx *nt;
+	struct ntb_transport_mw *mw;
+	unsigned int mw_count, qp_count;
+	u64 qp_bitmap;
 	int rc, i;
 
-	nt = kzalloc(sizeof(struct ntb_transport), GFP_KERNEL);
+	if (ntb_db_is_unsafe(ndev))
+		dev_dbg(&ndev->dev,
+			"doorbell is unsafe, proceed anyway...\n");
+	if (ntb_spad_is_unsafe(ndev))
+		dev_dbg(&ndev->dev,
+			"scratchpad is unsafe, proceed anyway...\n");
+
+	nt = kzalloc(sizeof(*nt), GFP_KERNEL);
 	if (!nt)
 		return -ENOMEM;
 
-	nt->ndev = ntb_register_transport(pdev, nt);
-	if (!nt->ndev) {
-		rc = -EIO;
+	nt->ndev = ndev;
+
+	mw_count = ntb_mw_count(ndev);
+
+	nt->mw_count = mw_count;
+
+	nt->mw_vec = kcalloc(mw_count, sizeof(*nt->mw_vec), GFP_KERNEL);
+	if (!nt->mw_vec) {
+		rc = -ENOMEM;
 		goto err;
 	}
 
-	nt->mw = kcalloc(ntb_max_mw(nt->ndev), sizeof(struct ntb_transport_mw),
-			 GFP_KERNEL);
-	if (!nt->mw) {
-		rc = -ENOMEM;
-		goto err1;
+	for (i = 0; i < mw_count; i++) {
+		mw = &nt->mw_vec[i];
+
+		rc = ntb_mw_get_range(ndev, i, &mw->phys_addr, &mw->phys_size,
+				      &mw->xlat_align, &mw->xlat_align_size);
+		if (rc)
+			goto err1;
+
+		mw->vbase = ioremap(mw->phys_addr, mw->phys_size);
+		if (!mw->vbase) {
+			rc = -ENOMEM;
+			goto err1;
+		}
+
+		mw->buff_size = 0;
+		mw->xlat_size = 0;
+		mw->virt_addr = NULL;
+		mw->dma_addr = 0;
 	}
 
-	if (max_num_clients)
-		nt->max_qps = min(ntb_max_cbs(nt->ndev), max_num_clients);
-	else
-		nt->max_qps = min(ntb_max_cbs(nt->ndev), ntb_max_mw(nt->ndev));
+	qp_bitmap = ntb_db_valid_mask(ndev);
+
+	qp_count = ilog2(qp_bitmap);
+	if (max_num_clients && max_num_clients < qp_count)
+		qp_count = max_num_clients;
+	else if (mw_count < qp_count)
+		qp_count = mw_count;
 
-	nt->qps = kcalloc(nt->max_qps, sizeof(struct ntb_transport_qp),
-			  GFP_KERNEL);
-	if (!nt->qps) {
+	qp_bitmap &= BIT_ULL(qp_count) - 1;
+
+	nt->qp_count = qp_count;
+	nt->qp_bitmap = qp_bitmap;
+	nt->qp_bitmap_free = qp_bitmap;
+
+	nt->qp_vec = kcalloc(qp_count, sizeof(*nt->qp_vec), GFP_KERNEL);
+	if (!nt->qp_vec) {
 		rc = -ENOMEM;
 		goto err2;
 	}
 
-	nt->qp_bitmap = ((u64) 1 << nt->max_qps) - 1;
-
-	for (i = 0; i < nt->max_qps; i++) {
+	for (i = 0; i < qp_count; i++) {
 		rc = ntb_transport_init_queue(nt, i);
 		if (rc)
 			goto err3;
 	}
 
 	INIT_DELAYED_WORK(&nt->link_work, ntb_transport_link_work);
+	INIT_WORK(&nt->db_work, ntb_transport_doorbell_work);
 	INIT_WORK(&nt->link_cleanup, ntb_transport_link_cleanup_work);
 
-	rc = ntb_register_event_callback(nt->ndev,
-					 ntb_transport_event_callback);
+	rc = ntb_set_ctx(ndev, nt, &ntb_transport_ops);
 	if (rc)
 		goto err3;
 
@@ -972,51 +1014,62 @@ int ntb_transport_init(struct pci_dev *pdev)
 	if (rc)
 		goto err4;
 
-	if (ntb_hw_link_status(nt->ndev))
-		schedule_delayed_work(&nt->link_work, 0);
+	nt->link_is_up = false;
+	ntb_link_enable(ndev, NTB_SPEED_AUTO, NTB_WIDTH_AUTO);
+	ntb_link_event(ndev);
 
 	return 0;
 
 err4:
-	ntb_unregister_event_callback(nt->ndev);
+	ntb_clear_ctx(ndev);
 err3:
-	kfree(nt->qps);
+	kfree(nt->qp_vec);
 err2:
-	kfree(nt->mw);
+	kfree(nt->mw_vec);
 err1:
-	ntb_unregister_transport(nt->ndev);
+	while (i--) {
+		mw = &nt->mw_vec[i];
+		iounmap(mw->vbase);
+	}
 err:
 	kfree(nt);
 	return rc;
 }
 
-void ntb_transport_free(void *transport)
+static void ntb_transport_free(struct ntb_client *self, struct ntb_dev *ndev)
 {
-	struct ntb_transport *nt = transport;
-	struct ntb_device *ndev = nt->ndev;
+	struct ntb_transport_ctx *nt = ndev->ctx;
+	struct ntb_transport_qp *qp;
+	u64 qp_bitmap_alloc;
 	int i;
 
 	ntb_transport_link_cleanup(nt);
+	cancel_work_sync(&nt->db_work);
+	cancel_work_sync(&nt->link_cleanup);
+	cancel_delayed_work_sync(&nt->link_work);
+
+	qp_bitmap_alloc = nt->qp_bitmap & ~nt->qp_bitmap_free;
 
 	/* verify that all the qp's are freed */
-	for (i = 0; i < nt->max_qps; i++) {
-		if (!test_bit(i, &nt->qp_bitmap))
-			ntb_transport_free_queue(&nt->qps[i]);
-		debugfs_remove_recursive(nt->qps[i].debugfs_dir);
+	for (i = 0; i < nt->qp_count; i++) {
+		qp = &nt->qp_vec[i];
+		if (qp_bitmap_alloc & BIT_ULL(i))
+			ntb_transport_free_queue(qp);
+		debugfs_remove_recursive(qp->debugfs_dir);
 	}
 
-	ntb_bus_remove(nt);
-
-	cancel_delayed_work_sync(&nt->link_work);
+	ntb_link_disable(ndev);
+	ntb_clear_ctx(ndev);
 
-	ntb_unregister_event_callback(ndev);
+	ntb_bus_remove(nt);
 
-	for (i = 0; i < ntb_max_mw(ndev); i++)
+	for (i = nt->mw_count; i--; ) {
 		ntb_free_mw(nt, i);
+		iounmap(nt->mw_vec[i].vbase);
+	}
 
-	kfree(nt->qps);
-	kfree(nt->mw);
-	ntb_unregister_transport(ndev);
+	kfree(nt->qp_vec);
+	kfree(nt->mw_vec);
 	kfree(nt);
 }
 
@@ -1028,15 +1081,13 @@ static void ntb_rx_copy_callback(void *data)
 	unsigned int len = entry->len;
 	struct ntb_payload_header *hdr = entry->rx_hdr;
 
-	/* Ensure that the data is fully copied out before clearing the flag */
-	wmb();
 	hdr->flags = 0;
 
 	iowrite32(entry->index, &qp->rx_info->entry);
 
 	ntb_list_add(&qp->ntb_rx_free_q_lock, &entry->entry, &qp->rx_free_q);
 
-	if (qp->rx_handler && qp->client_ready == NTB_LINK_UP)
+	if (qp->rx_handler && qp->client_ready)
 		qp->rx_handler(qp, qp->cb_data, cb_data, len);
 }
 
@@ -1047,6 +1098,9 @@ static void ntb_memcpy_rx(struct ntb_queue_entry *entry, void *offset)
 
 	memcpy(buf, offset, len);
 
+	/* Ensure that the data is fully copied out before clearing the flag */
+	wmb();
+
 	ntb_rx_copy_callback(entry);
 }
 
@@ -1138,77 +1192,95 @@ static int ntb_process_rxc(struct ntb_transport_qp *qp)
 	struct ntb_payload_header *hdr;
 	struct ntb_queue_entry *entry;
 	void *offset;
+	int rc;
 
 	offset = qp->rx_buff + qp->rx_max_frame * qp->rx_index;
 	hdr = offset + qp->rx_max_frame - sizeof(struct ntb_payload_header);
 
-	entry = ntb_list_rm(&qp->ntb_rx_pend_q_lock, &qp->rx_pend_q);
-	if (!entry) {
-		dev_dbg(&ntb_query_pdev(qp->ndev)->dev,
-			"no buffer - HDR ver %u, len %d, flags %x\n",
-			hdr->ver, hdr->len, hdr->flags);
-		qp->rx_err_no_buf++;
-		return -ENOMEM;
-	}
+	dev_dbg(&qp->ndev->pdev->dev, "qp %d: RX ver %u len %d flags %x\n",
+		qp->qp_num, hdr->ver, hdr->len, hdr->flags);
 
 	if (!(hdr->flags & DESC_DONE_FLAG)) {
-		ntb_list_add(&qp->ntb_rx_pend_q_lock, &entry->entry,
-			     &qp->rx_pend_q);
+		dev_dbg(&qp->ndev->pdev->dev, "done flag not set\n");
 		qp->rx_ring_empty++;
 		return -EAGAIN;
 	}
 
-	if (hdr->ver != (u32) qp->rx_pkts) {
-		dev_dbg(&ntb_query_pdev(qp->ndev)->dev,
-			"qp %d: version mismatch, expected %llu - got %u\n",
-			qp->qp_num, qp->rx_pkts, hdr->ver);
-		ntb_list_add(&qp->ntb_rx_pend_q_lock, &entry->entry,
-			     &qp->rx_pend_q);
+	if (hdr->flags & LINK_DOWN_FLAG) {
+		dev_dbg(&qp->ndev->pdev->dev, "link down flag set\n");
+		ntb_qp_link_down(qp);
+		hdr->flags = 0;
+		iowrite32(qp->rx_index, &qp->rx_info->entry);
+		return 0;
+	}
+
+	if (hdr->ver != (u32)qp->rx_pkts) {
+		dev_dbg(&qp->ndev->pdev->dev,
+			"version mismatch, expected %llu - got %u\n",
+			qp->rx_pkts, hdr->ver);
 		qp->rx_err_ver++;
 		return -EIO;
 	}
 
-	if (hdr->flags & LINK_DOWN_FLAG) {
-		ntb_qp_link_down(qp);
+	entry = ntb_list_rm(&qp->ntb_rx_pend_q_lock, &qp->rx_pend_q);
+	if (!entry) {
+		dev_dbg(&qp->ndev->pdev->dev, "no receive buffer\n");
+		qp->rx_err_no_buf++;
 
+		rc = -ENOMEM;
 		goto err;
 	}
 
-	dev_dbg(&ntb_query_pdev(qp->ndev)->dev,
-		"rx offset %u, ver %u - %d payload received, buf size %d\n",
-		qp->rx_index, hdr->ver, hdr->len, entry->len);
-
-	qp->rx_bytes += hdr->len;
-	qp->rx_pkts++;
-
 	if (hdr->len > entry->len) {
-		qp->rx_err_oflow++;
-		dev_dbg(&ntb_query_pdev(qp->ndev)->dev,
-			"RX overflow! Wanted %d got %d\n",
+		dev_dbg(&qp->ndev->pdev->dev,
+			"receive buffer overflow! Wanted %d got %d\n",
 			hdr->len, entry->len);
+		qp->rx_err_oflow++;
 
+		rc = -EIO;
 		goto err;
 	}
 
+	dev_dbg(&qp->ndev->pdev->dev,
+		"RX OK index %u ver %u size %d into buf size %d\n",
+		qp->rx_index, hdr->ver, hdr->len, entry->len);
+
+	qp->rx_bytes += hdr->len;
+	qp->rx_pkts++;
+
 	entry->index = qp->rx_index;
 	entry->rx_hdr = hdr;
 
 	ntb_async_rx(entry, offset, hdr->len);
 
-out:
 	qp->rx_index++;
 	qp->rx_index %= qp->rx_max_entry;
 
 	return 0;
 
 err:
-	ntb_list_add(&qp->ntb_rx_pend_q_lock, &entry->entry, &qp->rx_pend_q);
-	/* Ensure that the data is fully copied out before clearing the flag */
-	wmb();
+	/* FIXME: if this syncrhonous update of the rx_index gets ahead of
+	 * asyncrhonous ntb_rx_copy_callback of previous entry, there are three
+	 * scenarios:
+	 *
+	 * 1) The peer might miss this update, but observe the update
+	 * from the memcpy completion callback.  In this case, the buffer will
+	 * not be freed on the peer to be reused for a different packet.  The
+	 * successful rx of a later packet would clear the condition, but the
+	 * condition could persist if several rx fail in a row.
+	 *
+	 * 2) The peer may observe this update before the asyncrhonous copy of
+	 * prior packets is completed.  The peer may overwrite the buffers of
+	 * the prior packets before they are copied.
+	 *
+	 * 3) Both: the peer may observe the update, and then observe the index
+	 * decrement by the asynchronous completion callback.  Who knows what
+	 * badness that will cause.
+	 */
 	hdr->flags = 0;
 	iowrite32(qp->rx_index, &qp->rx_info->entry);
 
-	goto out;
+	return rc;
 }
 
 static int ntb_transport_rxc_db(void *data, int db_num)
@@ -1216,7 +1288,7 @@ static int ntb_transport_rxc_db(void *data, int db_num)
 	struct ntb_transport_qp *qp = data;
 	int rc, i;
 
-	dev_dbg(&ntb_query_pdev(qp->ndev)->dev, "%s: doorbell %d received\n",
+	dev_dbg(&qp->ndev->pdev->dev, "%s: doorbell %d received\n",
 		__func__, db_num);
 
 	/* Limit the number of packets processed in a single interrupt to
@@ -1240,11 +1312,9 @@ static void ntb_tx_copy_callback(void *data)
 	struct ntb_transport_qp *qp = entry->qp;
 	struct ntb_payload_header __iomem *hdr = entry->tx_hdr;
 
-	/* Ensure that the data is fully copied out before setting the flags */
-	wmb();
 	iowrite32(entry->flags | DESC_DONE_FLAG, &hdr->flags);
 
-	ntb_ring_doorbell(qp->ndev, qp->qp_num);
+	ntb_peer_db_set(qp->ndev, BIT_ULL(qp->qp_num));
 
 	/* The entry length can only be zero if the packet is intended to be a
 	 * "link down" or similar.  Since no payload is being sent in these
@@ -1265,6 +1335,9 @@ static void ntb_memcpy_tx(struct ntb_queue_entry *entry, void __iomem *offset)
 {
 	memcpy_toio(offset, entry->buf, entry->len);
 
+	/* Ensure that the data is fully copied out before setting the flags */
+	wmb();
+
 	ntb_tx_copy_callback(entry);
 }
 
@@ -1347,9 +1420,6 @@ err:
 static int ntb_process_tx(struct ntb_transport_qp *qp,
 			  struct ntb_queue_entry *entry)
 {
-	dev_dbg(&ntb_query_pdev(qp->ndev)->dev, "%lld - tx %u, entry len %d flags %x buff %p\n",
-		qp->tx_pkts, qp->tx_index, entry->len, entry->flags,
-		entry->buf);
 	if (qp->tx_index == qp->remote_rx_info->entry) {
 		qp->tx_ring_full++;
 		return -EAGAIN;
@@ -1376,14 +1446,14 @@ static int ntb_process_tx(struct ntb_transport_qp *qp,
 
 static void ntb_send_link_down(struct ntb_transport_qp *qp)
 {
-	struct pci_dev *pdev = ntb_query_pdev(qp->ndev);
+	struct pci_dev *pdev = qp->ndev->pdev;
 	struct ntb_queue_entry *entry;
 	int i, rc;
 
-	if (qp->qp_link == NTB_LINK_DOWN)
+	if (!qp->link_is_up)
 		return;
 
-	qp->qp_link = NTB_LINK_DOWN;
+	qp->link_is_up = false;
 	dev_info(&pdev->dev, "qp %d: Link Down\n", qp->qp_num);
 
 	for (i = 0; i < NTB_LINK_DOWN_TIMEOUT; i++) {
@@ -1422,18 +1492,21 @@ static void ntb_send_link_down(struct ntb_transport_qp *qp)
  * RETURNS: pointer to newly created ntb_queue, NULL on error.
  */
 struct ntb_transport_qp *
-ntb_transport_create_queue(void *data, struct pci_dev *pdev,
+ntb_transport_create_queue(void *data, struct device *client_dev,
 			   const struct ntb_queue_handlers *handlers)
 {
+	struct ntb_dev *ndev;
+	struct pci_dev *pdev;
+	struct ntb_transport_ctx *nt;
 	struct ntb_queue_entry *entry;
 	struct ntb_transport_qp *qp;
-	struct ntb_transport *nt;
+	u64 qp_bit;
 	unsigned int free_queue;
-	int rc, i;
+	int i;
 
-	nt = ntb_find_transport(pdev);
-	if (!nt)
-		goto err;
+	ndev = dev_ntb(client_dev->parent);
+	pdev = ndev->pdev;
+	nt = ndev->ctx;
 
 	free_queue = ffs(nt->qp_bitmap);
 	if (!free_queue)
@@ -1442,9 +1515,11 @@ ntb_transport_create_queue(void *data, struct pci_dev *pdev,
 	/* decrement free_queue to make it zero based */
 	free_queue--;
 
-	clear_bit(free_queue, &nt->qp_bitmap);
+	qp = &nt->qp_vec[free_queue];
+	qp_bit = BIT_ULL(qp->qp_num);
+
+	nt->qp_bitmap_free &= ~qp_bit;
 
-	qp = &nt->qps[free_queue];
 	qp->cb_data = data;
 	qp->rx_handler = handlers->rx_handler;
 	qp->tx_handler = handlers->tx_handler;
@@ -1458,7 +1533,7 @@ ntb_transport_create_queue(void *data, struct pci_dev *pdev,
 	}
 
 	for (i = 0; i < NTB_QP_DEF_NUM_ENTRIES; i++) {
-		entry = kzalloc(sizeof(struct ntb_queue_entry), GFP_ATOMIC);
+		entry = kzalloc(sizeof(*entry), GFP_ATOMIC);
 		if (!entry)
 			goto err1;
 
@@ -1468,7 +1543,7 @@ ntb_transport_create_queue(void *data, struct pci_dev *pdev,
 	}
 
 	for (i = 0; i < NTB_QP_DEF_NUM_ENTRIES; i++) {
-		entry = kzalloc(sizeof(struct ntb_queue_entry), GFP_ATOMIC);
+		entry = kzalloc(sizeof(*entry), GFP_ATOMIC);
 		if (!entry)
 			goto err2;
 
@@ -1477,10 +1552,8 @@ ntb_transport_create_queue(void *data, struct pci_dev *pdev,
 			     &qp->tx_free_q);
 	}
 
-	rc = ntb_register_db_callback(qp->ndev, free_queue, qp,
-				      ntb_transport_rxc_db);
-	if (rc)
-		goto err2;
+	ntb_db_clear(qp->ndev, qp_bit);
+	ntb_db_clear_mask(qp->ndev, qp_bit);
 
 	dev_info(&pdev->dev, "NTB Transport QP %d created\n", qp->qp_num);
 
@@ -1494,7 +1567,7 @@ err1:
 		kfree(entry);
 	if (qp->dma_chan)
 		dmaengine_put();
-	set_bit(free_queue, &nt->qp_bitmap);
+	nt->qp_bitmap_free |= qp_bit;
 err:
 	return NULL;
 }
@@ -1508,13 +1581,15 @@ EXPORT_SYMBOL_GPL(ntb_transport_create_queue);
  */
 void ntb_transport_free_queue(struct ntb_transport_qp *qp)
 {
+	struct ntb_transport_ctx *nt = qp->transport;
 	struct pci_dev *pdev;
 	struct ntb_queue_entry *entry;
+	u64 qp_bit;
 
 	if (!qp)
 		return;
 
-	pdev = ntb_query_pdev(qp->ndev);
+	pdev = qp->ndev->pdev;
 
 	if (qp->dma_chan) {
 		struct dma_chan *chan = qp->dma_chan;
@@ -1531,10 +1606,17 @@ void ntb_transport_free_queue(struct ntb_transport_qp *qp)
 		dmaengine_put();
 	}
 
-	ntb_unregister_db_callback(qp->ndev, qp->qp_num);
+	qp_bit = BIT_ULL(qp->qp_num);
+
+	ntb_db_set_mask(qp->ndev, qp_bit);
 
 	cancel_delayed_work_sync(&qp->link_work);
 
+	qp->cb_data = NULL;
+	qp->rx_handler = NULL;
+	qp->tx_handler = NULL;
+	qp->event_handler = NULL;
+
 	while ((entry = ntb_list_rm(&qp->ntb_rx_free_q_lock, &qp->rx_free_q)))
 		kfree(entry);
 
@@ -1546,7 +1628,7 @@ void ntb_transport_free_queue(struct ntb_transport_qp *qp)
 	while ((entry = ntb_list_rm(&qp->ntb_tx_free_q_lock, &qp->tx_free_q)))
 		kfree(entry);
 
-	set_bit(qp->qp_num, &qp->transport->qp_bitmap);
+	nt->qp_bitmap_free |= qp_bit;
 
 	dev_info(&pdev->dev, "NTB Transport QP %d freed\n", qp->qp_num);
 }
@@ -1567,7 +1649,7 @@ void *ntb_transport_rx_remove(struct ntb_transport_qp *qp, unsigned int *len)
 	struct ntb_queue_entry *entry;
 	void *buf;
 
-	if (!qp || qp->client_ready == NTB_LINK_UP)
+	if (!qp || qp->client_ready)
 		return NULL;
 
 	entry = ntb_list_rm(&qp->ntb_rx_pend_q_lock, &qp->rx_pend_q);
@@ -1636,7 +1718,7 @@ int ntb_transport_tx_enqueue(struct ntb_transport_qp *qp, void *cb, void *data,
 	struct ntb_queue_entry *entry;
 	int rc;
 
-	if (!qp || qp->qp_link != NTB_LINK_UP || !len)
+	if (!qp || !qp->link_is_up || !len)
 		return -EINVAL;
 
 	entry = ntb_list_rm(&qp->ntb_tx_free_q_lock, &qp->tx_free_q);
@@ -1670,9 +1752,9 @@ void ntb_transport_link_up(struct ntb_transport_qp *qp)
 	if (!qp)
 		return;
 
-	qp->client_ready = NTB_LINK_UP;
+	qp->client_ready = true;
 
-	if (qp->transport->transport_link == NTB_LINK_UP)
+	if (qp->transport->link_is_up)
 		schedule_delayed_work(&qp->link_work, 0);
 }
 EXPORT_SYMBOL_GPL(ntb_transport_link_up);
@@ -1688,27 +1770,20 @@ EXPORT_SYMBOL_GPL(ntb_transport_link_up);
 void ntb_transport_link_down(struct ntb_transport_qp *qp)
 {
 	struct pci_dev *pdev;
-	int rc, val;
+	int val;
 
 	if (!qp)
 		return;
 
-	pdev = ntb_query_pdev(qp->ndev);
-	qp->client_ready = NTB_LINK_DOWN;
+	pdev = qp->ndev->pdev;
+	qp->client_ready = false;
 
-	rc = ntb_read_local_spad(qp->ndev, QP_LINKS, &val);
-	if (rc) {
-		dev_err(&pdev->dev, "Error reading spad %d\n", QP_LINKS);
-		return;
-	}
+	val = ntb_spad_read(qp->ndev, QP_LINKS);
 
-	rc = ntb_write_remote_spad(qp->ndev, QP_LINKS,
-				   val & ~(1 << qp->qp_num));
-	if (rc)
-		dev_err(&pdev->dev, "Error writing %x to remote spad %d\n",
-			val & ~(1 << qp->qp_num), QP_LINKS);
+	ntb_peer_spad_write(qp->ndev, QP_LINKS,
+			    val & ~BIT(qp->qp_num));
 
-	if (qp->qp_link == NTB_LINK_UP)
+	if (qp->link_is_up)
 		ntb_send_link_down(qp);
 	else
 		cancel_delayed_work_sync(&qp->link_work);
@@ -1728,7 +1803,7 @@ bool ntb_transport_link_query(struct ntb_transport_qp *qp)
 	if (!qp)
 		return false;
 
-	return qp->qp_link == NTB_LINK_UP;
+	return qp->link_is_up;
 }
 EXPORT_SYMBOL_GPL(ntb_transport_link_query);
 
@@ -1774,3 +1849,93 @@ unsigned int ntb_transport_max_size(struct ntb_transport_qp *qp)
 	return max;
 }
 EXPORT_SYMBOL_GPL(ntb_transport_max_size);
+
+static void ntb_transport_doorbell_work(struct work_struct *work)
+{
+	struct ntb_transport_ctx *nt = container_of(work,
+			struct ntb_transport_ctx, db_work);
+	struct ntb_transport_qp *qp;
+	u64 db_mask, db_bits, db_again;
+	unsigned int qp_num;
+	int rc;
+
+	db_mask = nt->qp_bitmap & ~nt->qp_bitmap_free;
+	db_bits = db_mask & ntb_db_read(nt->ndev);
+
+	while (db_bits) {
+		ntb_db_clear(nt->ndev, db_bits);
+		db_again = 0;
+
+		while (db_bits) {
+			qp_num = __ffs(db_bits);
+			qp = &nt->qp_vec[qp_num];
+
+			rc = ntb_transport_rxc_db(qp, qp_num);
+			if (rc == qp->rx_max_entry)
+				db_again |= BIT_ULL(qp_num);
+
+			db_bits &= ~BIT_ULL(qp_num);
+		}
+
+		db_bits = db_mask & ntb_db_read(nt->ndev);
+		db_bits |= db_again;
+	}
+
+	ntb_db_clear_mask(nt->ndev, db_mask);
+}
+
+static void ntb_transport_doorbell_callback(void *data, int vector)
+{
+	struct ntb_transport_ctx *nt = data;
+
+	ntb_db_set_mask(nt->ndev, ntb_db_valid_mask(nt->ndev));
+
+	schedule_work(&nt->db_work);
+}
+
+static const struct ntb_ctx_ops ntb_transport_ops = {
+	.link_event = ntb_transport_event_callback,
+	.db_event = ntb_transport_doorbell_callback,
+};
+
+static struct ntb_client ntb_transport_client = {
+	.ops = {
+		.probe = ntb_transport_probe,
+		.remove = ntb_transport_free,
+	},
+	.name = NTB_TRANSPORT_NAME,
+};
+
+static int __init ntb_transport_init(void)
+{
+	int rc;
+
+	if (debugfs_initialized())
+		nt_debugfs_dir = debugfs_create_dir(KBUILD_MODNAME, NULL);
+
+	rc = bus_register(&ntb_transport_bus);
+	if (rc)
+		goto err_bus;
+
+	rc = ntb_register_client(&ntb_transport_client);
+	if (rc)
+		goto err_client;
+
+	return 0;
+
+err_client:
+	bus_unregister(&ntb_transport_bus);
+err_bus:
+	debugfs_remove_recursive(nt_debugfs_dir);
+	return rc;
+}
+module_init(ntb_transport_init);
+
+static void __exit ntb_transport_exit(void)
+{
+	debugfs_remove_recursive(nt_debugfs_dir);
+
+	ntb_unregister_client(&ntb_transport_client);
+	bus_unregister(&ntb_transport_bus);
+}
+module_exit(ntb_transport_exit);
diff --git a/include/linux/ntb.h b/include/linux/ntb.h
new file mode 100644
index 0000000..e8f29be
--- /dev/null
+++ b/include/linux/ntb.h
@@ -0,0 +1,983 @@
+/*
+ * This file is provided under a dual BSD/GPLv2 license.  When using or
+ *   redistributing this file, you may do so under either license.
+ *
+ *   GPL LICENSE SUMMARY
+ *
+ *   Copyright (C) 2015 EMC Corporation. All Rights Reserved.
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of version 2 of the GNU General Public License as
+ *   published by the Free Software Foundation.
+ *
+ *   This program is distributed in the hope that it will be useful, but
+ *   WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *   General Public License for more details.
+ *
+ *   BSD LICENSE
+ *
+ *   Copyright (C) 2015 EMC Corporation. All Rights Reserved.
+ *
+ *   Redistribution and use in source and binary forms, with or without
+ *   modification, are permitted provided that the following conditions
+ *   are met:
+ *
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copy
+ *       notice, this list of conditions and the following disclaimer in
+ *       the documentation and/or other materials provided with the
+ *       distribution.
+ *     * Neither the name of Intel Corporation nor the names of its
+ *       contributors may be used to endorse or promote products derived
+ *       from this software without specific prior written permission.
+ *
+ *   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ *   "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ *   LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
+ *   A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ *   OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ *   SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+ *   LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
+ *   DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
+ *   THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ *   (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
+ *   OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * PCIe NTB Linux driver
+ *
+ * Contact Information:
+ * Allen Hubbe <Allen.Hubbe@emc.com>
+ */
+
+#ifndef _NTB_H_
+#define _NTB_H_
+
+#include <linux/completion.h>
+#include <linux/device.h>
+
+struct ntb_client;
+struct ntb_dev;
+struct pci_dev;
+
+/**
+ * enum ntb_topo - NTB connection topology
+ * @NTB_TOPO_NONE:	Topology is unknown or invalid.
+ * @NTB_TOPO_PRI:	On primary side of local ntb.
+ * @NTB_TOPO_SEC:	On secondary side of remote ntb.
+ * @NTB_TOPO_B2B_USD:	On primary side of local ntb upstream of remote ntb.
+ * @NTB_TOPO_B2B_DSD:	On primary side of local ntb downstream of remote ntb.
+ */
+enum ntb_topo {
+	NTB_TOPO_NONE = -1,
+	NTB_TOPO_PRI,
+	NTB_TOPO_SEC,
+	NTB_TOPO_B2B_USD,
+	NTB_TOPO_B2B_DSD,
+};
+
+static inline int ntb_topo_is_b2b(enum ntb_topo topo)
+{
+	switch ((int)topo) {
+	case NTB_TOPO_B2B_USD:
+	case NTB_TOPO_B2B_DSD:
+		return 1;
+	}
+	return 0;
+}
+
+static inline char *ntb_topo_string(enum ntb_topo topo)
+{
+	switch (topo) {
+	case NTB_TOPO_NONE:	return "NTB_TOPO_NONE";
+	case NTB_TOPO_PRI:	return "NTB_TOPO_PRI";
+	case NTB_TOPO_SEC:	return "NTB_TOPO_SEC";
+	case NTB_TOPO_B2B_USD:	return "NTB_TOPO_B2B_USD";
+	case NTB_TOPO_B2B_DSD:	return "NTB_TOPO_B2B_DSD";
+	}
+	return "NTB_TOPO_INVALID";
+}
+
+/**
+ * enum ntb_speed - NTB link training speed
+ * @NTB_SPEED_AUTO:	Request the max supported speed.
+ * @NTB_SPEED_NONE:	Link is not trained to any speed.
+ * @NTB_SPEED_GEN1:	Link is trained to gen1 speed.
+ * @NTB_SPEED_GEN2:	Link is trained to gen2 speed.
+ * @NTB_SPEED_GEN3:	Link is trained to gen3 speed.
+ */
+enum ntb_speed {
+	NTB_SPEED_AUTO = -1,
+	NTB_SPEED_NONE = 0,
+	NTB_SPEED_GEN1 = 1,
+	NTB_SPEED_GEN2 = 2,
+	NTB_SPEED_GEN3 = 3,
+};
+
+/**
+ * enum ntb_width - NTB link training width
+ * @NTB_WIDTH_AUTO:	Request the max supported width.
+ * @NTB_WIDTH_NONE:	Link is not trained to any width.
+ * @NTB_WIDTH_1:	Link is trained to 1 lane width.
+ * @NTB_WIDTH_2:	Link is trained to 2 lane width.
+ * @NTB_WIDTH_4:	Link is trained to 4 lane width.
+ * @NTB_WIDTH_8:	Link is trained to 8 lane width.
+ * @NTB_WIDTH_12:	Link is trained to 12 lane width.
+ * @NTB_WIDTH_16:	Link is trained to 16 lane width.
+ * @NTB_WIDTH_32:	Link is trained to 32 lane width.
+ */
+enum ntb_width {
+	NTB_WIDTH_AUTO = -1,
+	NTB_WIDTH_NONE = 0,
+	NTB_WIDTH_1 = 1,
+	NTB_WIDTH_2 = 2,
+	NTB_WIDTH_4 = 4,
+	NTB_WIDTH_8 = 8,
+	NTB_WIDTH_12 = 12,
+	NTB_WIDTH_16 = 16,
+	NTB_WIDTH_32 = 32,
+};
+
+/**
+ * struct ntb_client_ops - ntb client operations
+ * @probe:		Notify client of a new device.
+ * @remove:		Notify client to remove a device.
+ */
+struct ntb_client_ops {
+	int (*probe)(struct ntb_client *client, struct ntb_dev *ntb);
+	void (*remove)(struct ntb_client *client, struct ntb_dev *ntb);
+};
+
+static inline int ntb_client_ops_is_valid(const struct ntb_client_ops *ops)
+{
+	/* commented callbacks are not required: */
+	return
+		ops->probe			&&
+		ops->remove			&&
+		1;
+}
+
+/**
+ * struct ntb_ctx_ops - ntb driver context operations
+ * @link_event:		See ntb_link_event().
+ * @db_event:		See ntb_db_event().
+ */
+struct ntb_ctx_ops {
+	void (*link_event)(void *ctx);
+	void (*db_event)(void *ctx, int db_vector);
+};
+
+static inline int ntb_ctx_ops_is_valid(const struct ntb_ctx_ops *ops)
+{
+	/* commented callbacks are not required: */
+	return
+		/* ops->link_event		&& */
+		/* ops->db_event		&& */
+		1;
+}
+
+/**
+ * struct ntb_ctx_ops - ntb device operations
+ * @mw_count:		See ntb_mw_count().
+ * @mw_get_range:	See ntb_mw_get_range().
+ * @mw_set_trans:	See ntb_mw_set_trans().
+ * @mw_clear_trans:	See ntb_mw_clear_trans().
+ * @link_is_up:		See ntb_link_is_up().
+ * @link_enable:	See ntb_link_enable().
+ * @link_disable:	See ntb_link_disable().
+ * @db_is_unsafe:	See ntb_db_is_unsafe().
+ * @db_valid_mask:	See ntb_db_valid_mask().
+ * @db_vector_count:	See ntb_db_vector_count().
+ * @db_vector_mask:	See ntb_db_vector_mask().
+ * @db_read:		See ntb_db_read().
+ * @db_set:		See ntb_db_set().
+ * @db_clear:		See ntb_db_clear().
+ * @db_read_mask:	See ntb_db_read_mask().
+ * @db_set_mask:	See ntb_db_set_mask().
+ * @db_clear_mask:	See ntb_db_clear_mask().
+ * @peer_db_addr:	See ntb_peer_db_addr().
+ * @peer_db_read:	See ntb_peer_db_read().
+ * @peer_db_set:	See ntb_peer_db_set().
+ * @peer_db_clear:	See ntb_peer_db_clear().
+ * @peer_db_read_mask:	See ntb_peer_db_read_mask().
+ * @peer_db_set_mask:	See ntb_peer_db_set_mask().
+ * @peer_db_clear_mask:	See ntb_peer_db_clear_mask().
+ * @spad_is_unsafe:	See ntb_spad_is_unsafe().
+ * @spad_count:		See ntb_spad_count().
+ * @spad_read:		See ntb_spad_read().
+ * @spad_write:		See ntb_spad_write().
+ * @peer_spad_addr:	See ntb_peer_spad_addr().
+ * @peer_spad_read:	See ntb_peer_spad_read().
+ * @peer_spad_write:	See ntb_peer_spad_write().
+ */
+struct ntb_dev_ops {
+	int (*mw_count)(struct ntb_dev *ntb);
+	int (*mw_get_range)(struct ntb_dev *ntb, int idx,
+			    phys_addr_t *base, resource_size_t *size,
+			resource_size_t *align, resource_size_t *align_size);
+	int (*mw_set_trans)(struct ntb_dev *ntb, int idx,
+			    dma_addr_t addr, resource_size_t size);
+	int (*mw_clear_trans)(struct ntb_dev *ntb, int idx);
+
+	int (*link_is_up)(struct ntb_dev *ntb,
+			  enum ntb_speed *speed, enum ntb_width *width);
+	int (*link_enable)(struct ntb_dev *ntb,
+			   enum ntb_speed max_speed, enum ntb_width max_width);
+	int (*link_disable)(struct ntb_dev *ntb);
+
+	int (*db_is_unsafe)(struct ntb_dev *ntb);
+	u64 (*db_valid_mask)(struct ntb_dev *ntb);
+	int (*db_vector_count)(struct ntb_dev *ntb);
+	u64 (*db_vector_mask)(struct ntb_dev *ntb, int db_vector);
+
+	u64 (*db_read)(struct ntb_dev *ntb);
+	int (*db_set)(struct ntb_dev *ntb, u64 db_bits);
+	int (*db_clear)(struct ntb_dev *ntb, u64 db_bits);
+
+	u64 (*db_read_mask)(struct ntb_dev *ntb);
+	int (*db_set_mask)(struct ntb_dev *ntb, u64 db_bits);
+	int (*db_clear_mask)(struct ntb_dev *ntb, u64 db_bits);
+
+	int (*peer_db_addr)(struct ntb_dev *ntb,
+			    phys_addr_t *db_addr, resource_size_t *db_size);
+	u64 (*peer_db_read)(struct ntb_dev *ntb);
+	int (*peer_db_set)(struct ntb_dev *ntb, u64 db_bits);
+	int (*peer_db_clear)(struct ntb_dev *ntb, u64 db_bits);
+
+	u64 (*peer_db_read_mask)(struct ntb_dev *ntb);
+	int (*peer_db_set_mask)(struct ntb_dev *ntb, u64 db_bits);
+	int (*peer_db_clear_mask)(struct ntb_dev *ntb, u64 db_bits);
+
+	int (*spad_is_unsafe)(struct ntb_dev *ntb);
+	int (*spad_count)(struct ntb_dev *ntb);
+
+	u32 (*spad_read)(struct ntb_dev *ntb, int idx);
+	int (*spad_write)(struct ntb_dev *ntb, int idx, u32 val);
+
+	int (*peer_spad_addr)(struct ntb_dev *ntb, int idx,
+			      phys_addr_t *spad_addr);
+	u32 (*peer_spad_read)(struct ntb_dev *ntb, int idx);
+	int (*peer_spad_write)(struct ntb_dev *ntb, int idx, u32 val);
+};
+
+static inline int ntb_dev_ops_is_valid(const struct ntb_dev_ops *ops)
+{
+	/* commented callbacks are not required: */
+	return
+		ops->mw_count				&&
+		ops->mw_get_range			&&
+		ops->mw_set_trans			&&
+		/* ops->mw_clear_trans			&& */
+		ops->link_is_up				&&
+		ops->link_enable			&&
+		ops->link_disable			&&
+		/* ops->db_is_unsafe			&& */
+		ops->db_valid_mask			&&
+
+		/* both set, or both unset */
+		(!ops->db_vector_count == !ops->db_vector_mask) &&
+
+		ops->db_read				&&
+		/* ops->db_set				&& */
+		ops->db_clear				&&
+		/* ops->db_read_mask			&& */
+		ops->db_set_mask			&&
+		ops->db_clear_mask			&&
+		ops->peer_db_addr			&&
+		/* ops->peer_db_read			&& */
+		ops->peer_db_set			&&
+		/* ops->peer_db_clear			&& */
+		/* ops->peer_db_read_mask		&& */
+		/* ops->peer_db_set_mask		&& */
+		/* ops->peer_db_clear_mask		&& */
+		/* ops->spad_is_unsafe			&& */
+		ops->spad_count				&&
+		ops->spad_read				&&
+		ops->spad_write				&&
+		ops->peer_spad_addr			&&
+		/* ops->peer_spad_read			&& */
+		ops->peer_spad_write			&&
+		1;
+}
+
+/**
+ * struct ntb_client - client interested in ntb devices
+ * @drv:		Linux driver object.
+ * @name:		Client driver name.
+ * @ops:		See &ntb_client_ops.
+ */
+struct ntb_client {
+	struct device_driver		drv;
+	const char			*name;
+	const struct ntb_client_ops	ops;
+};
+
+#define drv_ntb_client(__drv) container_of((__drv), struct ntb_client, drv)
+
+/**
+ * struct ntb_device - ntb device
+ * @dev:		Linux device object.
+ * @pdev:		Pci device entry of the ntb.
+ * @topo:		Detected topology of the ntb.
+ * @ops:		See &ntb_dev_ops.
+ * @ctx:		See &ntb_ctx_ops.
+ * @ctx_ops:		See &ntb_ctx_ops.
+ * @ctx_lock:		Synchronize operations on ctx.
+ */
+struct ntb_dev {
+	struct device			dev;
+	struct pci_dev			*pdev;
+	enum ntb_topo			topo;
+	const struct ntb_dev_ops	*ops;
+	void				*ctx;
+	const struct ntb_ctx_ops	*ctx_ops;
+
+	/* private: */
+
+	/* synchronize setting, clearing, and calling ctx_ops */
+	spinlock_t			ctx_lock;
+	/* block unregister until device is fully released */
+	struct completion		released;
+};
+
+#define dev_ntb(__dev) container_of((__dev), struct ntb_dev, dev)
+
+/**
+ * ntb_register_client() - register a client for interest in ntb devices
+ * @client:	Client context.
+ *
+ * The client will be added to the list of clients interested in ntb devices.
+ * The client will be notified of any ntb devices that are not already
+ * associated with a client, or if ntb devices are registered later.
+ *
+ * Return: Zero if the client is registered, otherwise an error number.
+ */
+int ntb_register_client(struct ntb_client *client);
+
+/**
+ * ntb_unregister_client() - unregister a client for interest in ntb devices
+ * @client:	Client context.
+ *
+ * The client will be removed from the list of clients interested in ntb
+ * devices.  If any ntb devices are associated with the client, the client will
+ * be notified to remove those devices.
+ */
+void ntb_unregister_client(struct ntb_client *client);
+
+#define module_ntb_client(__ntb_client) \
+	module_driver(__ntb_client, ntb_register_client, \
+			ntb_unregister_client)
+
+/**
+ * ntb_register_device() - register a ntb device
+ * @ntb:	NTB device context.
+ *
+ * The device will be added to the list of ntb devices.  If any clients are
+ * interested in ntb devices, each client will be notified of the ntb device,
+ * until at most one client accepts the device.
+ *
+ * Return: Zero if the device is registered, otherwise an error number.
+ */
+int ntb_register_device(struct ntb_dev *ntb);
+
+/**
+ * ntb_register_device() - unregister a ntb device
+ * @ntb:	NTB device context.
+ *
+ * The device will be removed from the list of ntb devices.  If the ntb device
+ * is associated with a client, the client will be notified to remove the
+ * device.
+ */
+void ntb_unregister_device(struct ntb_dev *ntb);
+
+/**
+ * ntb_set_ctx() - associate a driver context with an ntb device
+ * @ntb:	NTB device context.
+ * @ctx:	Driver context.
+ * @ctx_ops:	Driver context operations.
+ *
+ * Associate a driver context and operations with a ntb device.  The context is
+ * provided by the client driver, and the driver may associate a different
+ * context with each ntb device.
+ *
+ * Return: Zero if the context is associated, otherwise an error number.
+ */
+int ntb_set_ctx(struct ntb_dev *ntb, void *ctx,
+		const struct ntb_ctx_ops *ctx_ops);
+
+/**
+ * ntb_clear_ctx() - disassociate any driver context from an ntb device
+ * @ntb:	NTB device context.
+ *
+ * Clear any association that may exist between a driver context and the ntb
+ * device.
+ */
+void ntb_clear_ctx(struct ntb_dev *ntb);
+
+/**
+ * ntb_link_event() - notify driver context of a change in link status
+ * @ntb:	NTB device context.
+ *
+ * Notify the driver context that the link status may have changed.  The driver
+ * should call ntb_link_is_up() to get the current status.
+ */
+void ntb_link_event(struct ntb_dev *ntb);
+
+/**
+ * ntb_db_event() - notify driver context of a doorbell event
+ * @ntb:	NTB device context.
+ * @vector:	Interrupt vector number.
+ *
+ * Notify the driver context of a doorbell event.  If hardware supports
+ * multiple interrupt vectors for doorbells, the vector number indicates which
+ * vector received the interrupt.  The vector number is relative to the first
+ * vector used for doorbells, starting at zero, and must be less than
+ ** ntb_db_vector_count().  The driver may call ntb_db_read() to check which
+ * doorbell bits need service, and ntb_db_vector_mask() to determine which of
+ * those bits are associated with the vector number.
+ */
+void ntb_db_event(struct ntb_dev *ntb, int vector);
+
+/**
+ * ntb_mw_count() - get the number of memory windows
+ * @ntb:	NTB device context.
+ *
+ * Hardware and topology may support a different number of memory windows.
+ *
+ * Return: the number of memory windows.
+ */
+static inline int ntb_mw_count(struct ntb_dev *ntb)
+{
+	return ntb->ops->mw_count(ntb);
+}
+
+/**
+ * ntb_mw_get_range() - get the range of a memory window
+ * @ntb:	NTB device context.
+ * @idx:	Memory window number.
+ * @base:	OUT - the base address for mapping the memory window
+ * @size:	OUT - the size for mapping the memory window
+ * @align:	OUT - the base alignment for translating the memory window
+ * @align_size:	OUT - the size alignment for translating the memory window
+ *
+ * Get the range of a memory window.  NULL may be given for any output
+ * parameter if the value is not needed.  The base and size may be used for
+ * mapping the memory window, to access the peer memory.  The alignment and
+ * size may be used for translating the memory window, for the peer to access
+ * memory on the local system.
+ *
+ * Return: Zero on success, otherwise an error number.
+ */
+static inline int ntb_mw_get_range(struct ntb_dev *ntb, int idx,
+				   phys_addr_t *base, resource_size_t *size,
+		resource_size_t *align, resource_size_t *align_size)
+{
+	return ntb->ops->mw_get_range(ntb, idx, base, size,
+			align, align_size);
+}
+
+/**
+ * ntb_mw_set_trans() - set the translation of a memory window
+ * @ntb:	NTB device context.
+ * @idx:	Memory window number.
+ * @addr:	The dma address local memory to expose to the peer.
+ * @size:	The size of the local memory to expose to the peer.
+ *
+ * Set the translation of a memory window.  The peer may access local memory
+ * through the window starting at the address, up to the size.  The address
+ * must be aligned to the alignment specified by ntb_mw_get_range().  The size
+ * must be aligned to the size alignment specified by ntb_mw_get_range().
+ *
+ * Return: Zero on success, otherwise an error number.
+ */
+static inline int ntb_mw_set_trans(struct ntb_dev *ntb, int idx,
+				   dma_addr_t addr, resource_size_t size)
+{
+	return ntb->ops->mw_set_trans(ntb, idx, addr, size);
+}
+
+/**
+ * ntb_mw_clear_trans() - clear the translation of a memory window
+ * @ntb:	NTB device context.
+ * @idx:	Memory window number.
+ *
+ * Clear the translation of a memory window.  The peer may no longer access
+ * local memory through the window.
+ *
+ * Return: Zero on success, otherwise an error number.
+ */
+static inline int ntb_mw_clear_trans(struct ntb_dev *ntb, int idx)
+{
+	if (!ntb->ops->mw_clear_trans)
+		return ntb->ops->mw_set_trans(ntb, idx, 0, 0);
+
+	return ntb->ops->mw_clear_trans(ntb, idx);
+}
+
+/**
+ * ntb_link_is_up() - get the current ntb link state
+ * @ntb:	NTB device context.
+ * @speed:	OUT - The link speed expressed as PCIe generation number.
+ * @width:	OUT - The link width expressed as the number of PCIe lanes.
+ *
+ * Set the translation of a memory window.  The peer may access local memory
+ * through the window starting at the address, up to the size.  The address
+ * must be aligned to the alignment specified by ntb_mw_get_range().  The size
+ * must be aligned to the size alignment specified by ntb_mw_get_range().
+ *
+ * Return: One if the link is up, zero if the link is down, otherwise a
+ *		negative value indicating the error number.
+ */
+static inline int ntb_link_is_up(struct ntb_dev *ntb,
+				 enum ntb_speed *speed, enum ntb_width *width)
+{
+	return ntb->ops->link_is_up(ntb, speed, width);
+}
+
+/**
+ * ntb_link_enable() - enable the link on the secondary side of the ntb
+ * @ntb:	NTB device context.
+ * @max_speed:	The maximum link speed expressed as PCIe generation number.
+ * @max_width:	The maximum link width expressed as the number of PCIe lanes.
+ *
+ * Enable the link on the secondary side of the ntb.  This can only be done
+ * from the primary side of the ntb in primary or b2b topology.  The ntb device
+ * should train the link to its maximum speed and width, or the requested speed
+ * and width, whichever is smaller, if supported.
+ *
+ * Return: Zero on success, otherwise an error number.
+ */
+static inline int ntb_link_enable(struct ntb_dev *ntb,
+				  enum ntb_speed max_speed,
+				  enum ntb_width max_width)
+{
+	return ntb->ops->link_enable(ntb, max_speed, max_width);
+}
+
+/**
+ * ntb_link_disable() - disable the link on the secondary side of the ntb
+ * @ntb:	NTB device context.
+ *
+ * Disable the link on the secondary side of the ntb.  This can only be
+ * done from the primary side of the ntb in primary or b2b topology.  The ntb
+ * device should disable the link.  Returning from this call must indicate that
+ * a barrier has passed, though with no more writes may pass in either
+ * direction across the link, except if this call returns an error number.
+ *
+ * Return: Zero on success, otherwise an error number.
+ */
+static inline int ntb_link_disable(struct ntb_dev *ntb)
+{
+	return ntb->ops->link_disable(ntb);
+}
+
+/**
+ * ntb_db_is_unsafe() - check if it is safe to use hardware doorbell
+ * @ntb:	NTB device context.
+ *
+ * It is possible for some ntb hardware to be affected by errata.  Hardware
+ * drivers can advise clients to avoid using doorbells.  Clients may ignore
+ * this advice, though caution is recommended.
+ *
+ * Return: Zero if it is safe to use doorbells, or One if it is not safe.
+ */
+static inline int ntb_db_is_unsafe(struct ntb_dev *ntb)
+{
+	if (!ntb->ops->db_is_unsafe)
+		return 0;
+
+	return ntb->ops->db_is_unsafe(ntb);
+}
+
+/**
+ * ntb_db_valid_mask() - get a mask of doorbell bits supported by the ntb
+ * @ntb:	NTB device context.
+ *
+ * Hardware may support different number or arrangement of doorbell bits.
+ *
+ * Return: A mask of doorbell bits supported by the ntb.
+ */
+static inline u64 ntb_db_valid_mask(struct ntb_dev *ntb)
+{
+	return ntb->ops->db_valid_mask(ntb);
+}
+
+/**
+ * ntb_db_vector_count() - get the number of doorbell interrupt vectors
+ * @ntb:	NTB device context.
+ *
+ * Hardware may support different number of interrupt vectors.
+ *
+ * Return: The number of doorbell interrupt vectors.
+ */
+static inline int ntb_db_vector_count(struct ntb_dev *ntb)
+{
+	if (!ntb->ops->db_vector_count)
+		return 1;
+
+	return ntb->ops->db_vector_count(ntb);
+}
+
+/**
+ * ntb_db_vector_mask() - get a mask of doorbell bits serviced by a vector
+ * @ntb:	NTB device context.
+ * @vector:	Doorbell vector number.
+ *
+ * Each interrupt vector may have a different number or arrangement of bits.
+ *
+ * Return: A mask of doorbell bits serviced by a vector.
+ */
+static inline u64 ntb_db_vector_mask(struct ntb_dev *ntb, int vector)
+{
+	if (!ntb->ops->db_vector_mask)
+		return ntb_db_valid_mask(ntb);
+
+	return ntb->ops->db_vector_mask(ntb, vector);
+}
+
+/**
+ * ntb_db_read() - read the local doorbell register
+ * @ntb:	NTB device context.
+ *
+ * Read the local doorbell register, and return the bits that are set.
+ *
+ * Return: The bits currently set in the local doorbell register.
+ */
+static inline u64 ntb_db_read(struct ntb_dev *ntb)
+{
+	return ntb->ops->db_read(ntb);
+}
+
+/**
+ * ntb_db_set() - set bits in the local doorbell register
+ * @ntb:	NTB device context.
+ * @db_bits:	Doorbell bits to set.
+ *
+ * Set bits in the local doorbell register, which may generate a local doorbell
+ * interrupt.  Bits that were already set must remain set.
+ *
+ * This is unusual, and hardware may not support it.
+ *
+ * Return: Zero on success, otherwise an error number.
+ */
+static inline int ntb_db_set(struct ntb_dev *ntb, u64 db_bits)
+{
+	if (!ntb->ops->db_set)
+		return -EINVAL;
+
+	return ntb->ops->db_set(ntb, db_bits);
+}
+
+/**
+ * ntb_db_clear() - clear bits in the local doorbell register
+ * @ntb:	NTB device context.
+ * @db_bits:	Doorbell bits to clear.
+ *
+ * Clear bits in the local doorbell register, arming the bits for the next
+ * doorbell.
+ *
+ * Return: Zero on success, otherwise an error number.
+ */
+static inline int ntb_db_clear(struct ntb_dev *ntb, u64 db_bits)
+{
+	return ntb->ops->db_clear(ntb, db_bits);
+}
+
+/**
+ * ntb_db_read_mask() - read the local doorbell mask
+ * @ntb:	NTB device context.
+ *
+ * Read the local doorbell mask register, and return the bits that are set.
+ *
+ * This is unusual, though hardware is likely to support it.
+ *
+ * Return: The bits currently set in the local doorbell mask register.
+ */
+static inline u64 ntb_db_read_mask(struct ntb_dev *ntb)
+{
+	if (!ntb->ops->db_read_mask)
+		return 0;
+
+	return ntb->ops->db_read_mask(ntb);
+}
+
+/**
+ * ntb_db_set_mask() - set bits in the local doorbell mask
+ * @ntb:	NTB device context.
+ * @db_bits:	Doorbell mask bits to set.
+ *
+ * Set bits in the local doorbell mask register, preventing doorbell interrupts
+ * from being generated for those doorbell bits.  Bits that were already set
+ * must remain set.
+ *
+ * Return: Zero on success, otherwise an error number.
+ */
+static inline int ntb_db_set_mask(struct ntb_dev *ntb, u64 db_bits)
+{
+	return ntb->ops->db_set_mask(ntb, db_bits);
+}
+
+/**
+ * ntb_db_clear_mask() - clear bits in the local doorbell mask
+ * @ntb:	NTB device context.
+ * @db_bits:	Doorbell bits to clear.
+ *
+ * Clear bits in the local doorbell mask register, allowing doorbell interrupts
+ * from being generated for those doorbell bits.  If a doorbell bit is already
+ * set at the time the mask is cleared, and the corresponding mask bit is
+ * changed from set to clear, then the ntb driver must ensure that
+ * ntb_db_event() is called.  If the hardware does not generate the interrupt
+ * on clearing the mask bit, then the driver must call ntb_db_event() anyway.
+ *
+ * Return: Zero on success, otherwise an error number.
+ */
+static inline int ntb_db_clear_mask(struct ntb_dev *ntb, u64 db_bits)
+{
+	return ntb->ops->db_clear_mask(ntb, db_bits);
+}
+
+/**
+ * ntb_peer_db_addr() - address and size of the peer doorbell register
+ * @ntb:	NTB device context.
+ * @db_addr:	OUT - The address of the peer doorbell register.
+ * @db_size:	OUT - The number of bytes to write the peer doorbell register.
+ *
+ * Return the address of the peer doorbell register.  This may be used, for
+ * example, by drivers that offload memory copy operations to a dma engine.
+ * The drivers may wish to ring the peer doorbell at the completion of memory
+ * copy operations.  For efficiency, and to simplify ordering of operations
+ * between the dma memory copies and the ringing doorbell, the driver may
+ * append one additional dma memory copy with the doorbell register as the
+ * destination, after the memory copy operations.
+ *
+ * Return: Zero on success, otherwise an error number.
+ */
+static inline int ntb_peer_db_addr(struct ntb_dev *ntb,
+				   phys_addr_t *db_addr,
+				   resource_size_t *db_size)
+{
+	return ntb->ops->peer_db_addr(ntb, db_addr, db_size);
+}
+
+/**
+ * ntb_peer_db_read() - read the peer doorbell register
+ * @ntb:	NTB device context.
+ *
+ * Read the peer doorbell register, and return the bits that are set.
+ *
+ * This is unusual, and hardware may not support it.
+ *
+ * Return: The bits currently set in the peer doorbell register.
+ */
+static inline u64 ntb_peer_db_read(struct ntb_dev *ntb)
+{
+	if (!ntb->ops->peer_db_read)
+		return 0;
+
+	return ntb->ops->peer_db_read(ntb);
+}
+
+/**
+ * ntb_peer_db_set() - set bits in the peer doorbell register
+ * @ntb:	NTB device context.
+ * @db_bits:	Doorbell bits to set.
+ *
+ * Set bits in the peer doorbell register, which may generate a peer doorbell
+ * interrupt.  Bits that were already set must remain set.
+ *
+ * Return: Zero on success, otherwise an error number.
+ */
+static inline int ntb_peer_db_set(struct ntb_dev *ntb, u64 db_bits)
+{
+	return ntb->ops->peer_db_set(ntb, db_bits);
+}
+
+/**
+ * ntb_peer_db_clear() - clear bits in the local doorbell register
+ * @ntb:	NTB device context.
+ * @db_bits:	Doorbell bits to clear.
+ *
+ * Clear bits in the peer doorbell register, arming the bits for the next
+ * doorbell.
+ *
+ * This is unusual, and hardware may not support it.
+ *
+ * Return: Zero on success, otherwise an error number.
+ */
+static inline int ntb_peer_db_clear(struct ntb_dev *ntb, u64 db_bits)
+{
+	if (!ntb->ops->db_clear)
+		return -EINVAL;
+
+	return ntb->ops->peer_db_clear(ntb, db_bits);
+}
+
+/**
+ * ntb_peer_db_read_mask() - read the peer doorbell mask
+ * @ntb:	NTB device context.
+ *
+ * Read the peer doorbell mask register, and return the bits that are set.
+ *
+ * This is unusual, and hardware may not support it.
+ *
+ * Return: The bits currently set in the peer doorbell mask register.
+ */
+static inline u64 ntb_peer_db_read_mask(struct ntb_dev *ntb)
+{
+	if (!ntb->ops->db_read_mask)
+		return 0;
+
+	return ntb->ops->peer_db_read_mask(ntb);
+}
+
+/**
+ * ntb_peer_db_set_mask() - set bits in the peer doorbell mask
+ * @ntb:	NTB device context.
+ * @db_bits:	Doorbell mask bits to set.
+ *
+ * Set bits in the peer doorbell mask register, preventing doorbell interrupts
+ * from being generated for those doorbell bits.  Bits that were already set
+ * must remain set.
+ *
+ * This is unusual, and hardware may not support it.
+ *
+ * Return: Zero on success, otherwise an error number.
+ */
+static inline int ntb_peer_db_set_mask(struct ntb_dev *ntb, u64 db_bits)
+{
+	if (!ntb->ops->db_set_mask)
+		return -EINVAL;
+
+	return ntb->ops->peer_db_set_mask(ntb, db_bits);
+}
+
+/**
+ * ntb_peer_db_clear_mask() - clear bits in the peer doorbell mask
+ * @ntb:	NTB device context.
+ * @db_bits:	Doorbell bits to clear.
+ *
+ * Clear bits in the peer doorbell mask register, allowing doorbell interrupts
+ * from being generated for those doorbell bits.  If the hardware does not
+ * generate the interrupt on clearing the mask bit, then the driver should not
+ * implement this function!
+ *
+ * This is unusual, and hardware may not support it.
+ *
+ * Return: Zero on success, otherwise an error number.
+ */
+static inline int ntb_peer_db_clear_mask(struct ntb_dev *ntb, u64 db_bits)
+{
+	if (!ntb->ops->db_clear_mask)
+		return -EINVAL;
+
+	return ntb->ops->peer_db_clear_mask(ntb, db_bits);
+}
+
+/**
+ * ntb_spad_is_unsafe() - check if it is safe to use the hardware scratchpads
+ * @ntb:	NTB device context.
+ *
+ * It is possible for some ntb hardware to be affected by errata.  Hardware
+ * drivers can advise clients to avoid using scratchpads.  Clients may ignore
+ * this advice, though caution is recommended.
+ *
+ * Return: Zero if it is safe to use scratchpads, or One if it is not safe.
+ */
+static inline int ntb_spad_is_unsafe(struct ntb_dev *ntb)
+{
+	if (!ntb->ops->spad_is_unsafe)
+		return 0;
+
+	return ntb->ops->spad_is_unsafe(ntb);
+}
+
+/**
+ * ntb_mw_count() - get the number of scratchpads
+ * @ntb:	NTB device context.
+ *
+ * Hardware and topology may support a different number of scratchpads.
+ *
+ * Return: the number of scratchpads.
+ */
+static inline int ntb_spad_count(struct ntb_dev *ntb)
+{
+	return ntb->ops->spad_count(ntb);
+}
+
+/**
+ * ntb_spad_read() - read the local scratchpad register
+ * @ntb:	NTB device context.
+ * @idx:	Scratchpad index.
+ *
+ * Read the local scratchpad register, and return the value.
+ *
+ * Return: The value of the local scratchpad register.
+ */
+static inline u32 ntb_spad_read(struct ntb_dev *ntb, int idx)
+{
+	return ntb->ops->spad_read(ntb, idx);
+}
+
+/**
+ * ntb_spad_write() - write the local scratchpad register
+ * @ntb:	NTB device context.
+ * @idx:	Scratchpad index.
+ * @val:	Scratchpad value.
+ *
+ * Write the value to the local scratchpad register.
+ *
+ * Return: Zero on success, otherwise an error number.
+ */
+static inline int ntb_spad_write(struct ntb_dev *ntb, int idx, u32 val)
+{
+	return ntb->ops->spad_write(ntb, idx, val);
+}
+
+/**
+ * ntb_peer_spad_addr() - address of the peer scratchpad register
+ * @ntb:	NTB device context.
+ * @idx:	Scratchpad index.
+ * @spad_addr:	OUT - The address of the peer scratchpad register.
+ *
+ * Return the address of the peer doorbell register.  This may be used, for
+ * example, by drivers that offload memory copy operations to a dma engine.
+ *
+ * Return: Zero on success, otherwise an error number.
+ */
+static inline int ntb_peer_spad_addr(struct ntb_dev *ntb, int idx,
+				     phys_addr_t *spad_addr)
+{
+	return ntb->ops->peer_spad_addr(ntb, idx, spad_addr);
+}
+
+/**
+ * ntb_peer_spad_read() - read the peer scratchpad register
+ * @ntb:	NTB device context.
+ * @idx:	Scratchpad index.
+ *
+ * Read the peer scratchpad register, and return the value.
+ *
+ * Return: The value of the local scratchpad register.
+ */
+static inline u32 ntb_peer_spad_read(struct ntb_dev *ntb, int idx)
+{
+	return ntb->ops->peer_spad_read(ntb, idx);
+}
+
+/**
+ * ntb_peer_spad_write() - write the peer scratchpad register
+ * @ntb:	NTB device context.
+ * @idx:	Scratchpad index.
+ * @val:	Scratchpad value.
+ *
+ * Write the value to the peer scratchpad register.
+ *
+ * Return: Zero on success, otherwise an error number.
+ */
+static inline int ntb_peer_spad_write(struct ntb_dev *ntb, int idx, u32 val)
+{
+	return ntb->ops->peer_spad_write(ntb, idx, val);
+}
+
+#endif
diff --git a/include/linux/ntb_transport.h b/include/linux/ntb_transport.h
index 9ac1a62..2862861 100644
--- a/include/linux/ntb_transport.h
+++ b/include/linux/ntb_transport.h
@@ -5,6 +5,7 @@
  *   GPL LICENSE SUMMARY
  *
  *   Copyright(c) 2012 Intel Corporation. All rights reserved.
+ *   Copyright (C) 2015 EMC Corporation. All Rights Reserved.
  *
  *   This program is free software; you can redistribute it and/or modify
  *   it under the terms of version 2 of the GNU General Public License as
@@ -13,6 +14,7 @@
  *   BSD LICENSE
  *
  *   Copyright(c) 2012 Intel Corporation. All rights reserved.
+ *   Copyright (C) 2015 EMC Corporation. All Rights Reserved.
  *
  *   Redistribution and use in source and binary forms, with or without
  *   modification, are permitted provided that the following conditions
@@ -40,7 +42,7 @@
  *   (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
  *   OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  *
- * Intel PCIe NTB Linux driver
+ * PCIe NTB Transport Linux driver
  *
  * Contact Information:
  * Jon Mason <jon.mason@intel.com>
@@ -48,21 +50,16 @@
 
 struct ntb_transport_qp;
 
-struct ntb_client {
+struct ntb_transport_client {
 	struct device_driver driver;
-	int (*probe)(struct pci_dev *pdev);
-	void (*remove)(struct pci_dev *pdev);
+	int (*probe)(struct device *client_dev);
+	void (*remove)(struct device *client_dev);
 };
 
-enum {
-	NTB_LINK_DOWN = 0,
-	NTB_LINK_UP,
-};
-
-int ntb_register_client(struct ntb_client *drvr);
-void ntb_unregister_client(struct ntb_client *drvr);
-int ntb_register_client_dev(char *device_name);
-void ntb_unregister_client_dev(char *device_name);
+int ntb_transport_register_client(struct ntb_transport_client *drvr);
+void ntb_transport_unregister_client(struct ntb_transport_client *drvr);
+int ntb_transport_register_client_dev(char *device_name);
+void ntb_transport_unregister_client_dev(char *device_name);
 
 struct ntb_queue_handlers {
 	void (*rx_handler)(struct ntb_transport_qp *qp, void *qp_data,
@@ -75,7 +72,7 @@ struct ntb_queue_handlers {
 unsigned char ntb_transport_qp_num(struct ntb_transport_qp *qp);
 unsigned int ntb_transport_max_size(struct ntb_transport_qp *qp);
 struct ntb_transport_qp *
-ntb_transport_create_queue(void *data, struct pci_dev *pdev,
+ntb_transport_create_queue(void *data, struct device *client_dev,
 			   const struct ntb_queue_handlers *handlers);
 void ntb_transport_free_queue(struct ntb_transport_qp *qp);
 int ntb_transport_rx_enqueue(struct ntb_transport_qp *qp, void *cb, void *data,
-- 
2.4.0.rc0.43.gcf8a8c6

