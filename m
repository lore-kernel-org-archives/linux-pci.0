Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:58065 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752944AbcDZUsQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 26 Apr 2016 16:48:16 -0400
From: Keith Busch <keith.busch@intel.com>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc: Keith Busch <keith.busch@intel.com>
Subject: [PATCH] pcie: Add driver for Downstream Port Containment
Date: Tue, 26 Apr 2016 14:48:13 -0600
Message-Id: <1461703693-29400-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This adds driver support for root and downstream ports that implement
the Downstream Port PCI-Express extended capability. DPC is an optional
capability to contained uncorrectable errors below a downstream port.

When a DPC is triggered due to receipt of an uncorrectable error message,
the DPC driver will schedule removal for all downstream devices as DPC
capable ports disable downstream links. This may happen concurrently
with a PCI-e hotplug driver if enabled. After the downstream devices
are removed, the DPC driver will clear the status and interrupt bits
the link may retrain for a newly connected device.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pcie/Kconfig        |   1 +
 drivers/pci/pcie/Makefile       |   1 +
 drivers/pci/pcie/dpc/Kconfig    |  13 +++
 drivers/pci/pcie/dpc/Makefile   |   5 ++
 drivers/pci/pcie/dpc/dpcdrv.c   | 179 ++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pcie/portdrv.h      |   2 +-
 drivers/pci/pcie/portdrv_acpi.c |   2 +-
 drivers/pci/pcie/portdrv_core.c |   4 +-
 include/linux/pcieport_if.h     |   2 +
 include/uapi/linux/pci_regs.h   |  27 +++++-
 10 files changed, 232 insertions(+), 4 deletions(-)
 create mode 100644 drivers/pci/pcie/dpc/Kconfig
 create mode 100644 drivers/pci/pcie/dpc/Makefile
 create mode 100644 drivers/pci/pcie/dpc/dpcdrv.c

diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
index e294713..bd9fca7 100644
--- a/drivers/pci/pcie/Kconfig
+++ b/drivers/pci/pcie/Kconfig
@@ -23,6 +23,7 @@ config HOTPLUG_PCI_PCIE
 	  When in doubt, say N.
 
 source "drivers/pci/pcie/aer/Kconfig"
+source "drivers/pci/pcie/dpc/Kconfig"
 
 #
 # PCI Express ASPM
diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
index 00c62df..18604a6 100644
--- a/drivers/pci/pcie/Makefile
+++ b/drivers/pci/pcie/Makefile
@@ -12,5 +12,6 @@ obj-$(CONFIG_PCIEPORTBUS)	+= pcieportdrv.o
 
 # Build PCI Express AER if needed
 obj-$(CONFIG_PCIEAER)		+= aer/
+obj-$(CONFIG_PCIEDPC)		+= dpc/
 
 obj-$(CONFIG_PCIE_PME) += pme.o
diff --git a/drivers/pci/pcie/dpc/Kconfig b/drivers/pci/pcie/dpc/Kconfig
new file mode 100644
index 0000000..97d8baa
--- /dev/null
+++ b/drivers/pci/pcie/dpc/Kconfig
@@ -0,0 +1,13 @@
+#
+# PCI Express Device DPC Configuration
+#
+
+config PCIEDPC
+	boolean "Root Port Downstream Port Containment support"
+	depends on PCIEPORTBUS
+	default n
+	help
+	  This enables PCI Express Downstream Port Containment (DPC)
+	  driver support. Error reporting messages sent to Root and
+	  Downstream ports will be handled by PCI Express DPC driver.
+
diff --git a/drivers/pci/pcie/dpc/Makefile b/drivers/pci/pcie/dpc/Makefile
new file mode 100644
index 0000000..60273ec
--- /dev/null
+++ b/drivers/pci/pcie/dpc/Makefile
@@ -0,0 +1,5 @@
+#
+# Makefile for PCI-Express Downstream Port Containment Driver
+#
+
+obj-$(CONFIG_PCIEDPC) += dpcdrv.o
diff --git a/drivers/pci/pcie/dpc/dpcdrv.c b/drivers/pci/pcie/dpc/dpcdrv.c
new file mode 100644
index 0000000..d179008
--- /dev/null
+++ b/drivers/pci/pcie/dpc/dpcdrv.c
@@ -0,0 +1,179 @@
+/*
+ * PCI-Express Downstream Port Containment services driver
+ * Copyright (C) 2016 Intel Corp.
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/pcieport_if.h>
+
+struct event_info {
+	struct pcie_device *dev;
+	struct work_struct work;
+};
+
+static void dpc_wait_link_inactive(struct pci_dev *pdev)
+{
+	int timeout = jiffies + HZ;
+	u16 lnk_status;
+
+	pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
+	while (lnk_status & PCI_EXP_LNKSTA_DLLLA &&
+					!time_after(jiffies, timeout)) {
+		msleep(10);
+		pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
+	} 
+}
+
+static void interrupt_event_handler(struct work_struct *work)
+{
+	int pos;
+
+	struct event_info *info = container_of(work, struct event_info, work);
+	struct pci_dev *dev, *temp, *pdev = info->dev->port;
+	struct pci_bus *parent = pdev->subordinate;
+
+	pci_lock_rescan_remove();
+	list_for_each_entry_safe_reverse(dev, temp, &parent->devices,
+					 bus_list) {
+		pci_dev_get(dev);
+		pci_stop_and_remove_bus_device(dev);
+		pci_dev_put(dev);
+	}
+	pci_unlock_rescan_remove();
+
+	dpc_wait_link_inactive(pdev);
+
+	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_DPC);
+	pci_write_config_word(info->dev->port, pos + PCI_EXP_DPC_STATUS,
+		PCI_EXP_DPC_STATUS_TRIGGER | PCI_EXP_DPC_STATUS_INTERRUPT);
+
+	kfree(info);
+}
+
+static void dpc_queue_event(struct pcie_device *dev)
+{
+	struct event_info *info;
+
+	info = kmalloc(sizeof(*info), GFP_ATOMIC);
+	if (!info) {
+		dev_warn(&dev->device, "dropped containment event\n");
+		return;
+	}
+
+	INIT_WORK(&info->work, interrupt_event_handler);
+	info->dev = dev;
+
+	schedule_work(&info->work);
+}
+
+static irqreturn_t dpc_irq(int irq, void *context)
+{
+	int pos;
+	u16 status, source;
+
+	struct pcie_device *dev = (struct pcie_device *)context;
+	struct pci_dev *pdev = dev->port;
+
+	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_DPC);
+	pci_read_config_word(pdev, pos + PCI_EXP_DPC_STATUS, &status);
+	pci_read_config_word(pdev, pos + PCI_EXP_DPC_SOURCE_ID, &source);
+
+	if (!status)
+		return IRQ_NONE;
+
+	dev_warn(&dev->device, "dpc status:%04x source:%04x\n", status, source);
+
+	if (status & PCI_EXP_DPC_STATUS_TRIGGER)
+		dpc_queue_event(dev);
+
+	return IRQ_HANDLED;
+}
+
+#define FLAG(x, y)	(((x) & (y)) ? '+' : '-')
+
+static void dpc_enable_port(struct pcie_device *dev)
+{
+	struct pci_dev *pdev = dev->port;
+	int pos;
+	u16 ctl, cap;
+
+	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_DPC);
+	pci_read_config_word(pdev, pos + PCI_EXP_DPC_CAP, &cap);
+	pci_read_config_word(pdev, pos + PCI_EXP_DPC_CTL, &ctl);
+
+	ctl |= PCI_EXP_DPC_CTL_EN_NONFATAL | PCI_EXP_DPC_CTL_INT_EN;
+	pci_write_config_word(pdev, pos + PCI_EXP_DPC_CTL, ctl);
+
+	dev_info(&dev->device,
+		"DPC Int Msg #%d, RPExt%c PoisonedTLP%c SwTrigger%c RP PIO Log %d, DL_ActiveErr%c\n",
+		cap & 0xf, FLAG(cap, PCI_EXP_DPC_CAP_RP_EXT),
+		FLAG(cap, PCI_EXP_DPC_CAP_POISONED_TLP),
+		FLAG(cap, PCI_EXP_DPC_CAP_SW_TRIGGER), (cap >> 8) & 0xf,
+		FLAG(cap, PCI_EXP_DPC_CAP_DL_ACTIVE));
+}
+
+static void dpc_disable_port(struct pcie_device *dev)
+{
+	struct pci_dev *pdev = dev->port;
+	int pos;
+	u16 ctl;
+
+	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_DPC);
+	pci_read_config_word(pdev, pos + PCI_EXP_DPC_CTL, &ctl);
+
+	ctl |= ~(PCI_EXP_DPC_CTL_EN_NONFATAL | PCI_EXP_DPC_CTL_INT_EN);
+	pci_write_config_word(pdev, pos + PCI_EXP_DPC_CTL, ctl);
+}
+
+static int dpc_probe(struct pcie_device *dev)
+{
+	int status;
+
+	status = request_irq(dev->irq, dpc_irq, IRQF_SHARED, "dpcdrv", dev);
+	if (status) {
+		dev_warn(&dev->device, "request IRQ failed\n");
+		return status;
+	}
+	dpc_enable_port(dev);
+
+	return status;
+}
+
+static void dpc_remove(struct pcie_device *dev)
+{
+	dpc_disable_port(dev);
+	free_irq(dev->irq, dev);
+}
+
+static struct pcie_port_service_driver dpcdriver = {
+	.name		= "pciedpc",
+	.port_type	= PCI_EXP_TYPE_ROOT_PORT | PCI_EXP_TYPE_DOWNSTREAM,
+	.service	= PCIE_PORT_SERVICE_DPC,
+	.probe		= dpc_probe,
+	.remove		= dpc_remove,
+};
+
+static int __init dpc_service_init(void)
+{
+	/* XXX: Add kernel parameters to control PCIe DPC module */
+	return pcie_port_service_register(&dpcdriver);
+}
+
+static void __exit dpc_service_exit(void)
+{
+	pcie_port_service_unregister(&dpcdriver);
+}
+
+MODULE_AUTHOR("Keith Busch <keith.busch@intel.com>");
+MODULE_DESCRIPTION("PCI Express Downstream Port Containment driver");
+MODULE_LICENSE("GPL");
+MODULE_VERSION("0.1");
+
+module_init(dpc_service_init);
+module_exit(dpc_service_exit);
diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index d525548..5c2f6ef 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -11,7 +11,7 @@
 
 #include <linux/compiler.h>
 
-#define PCIE_PORT_DEVICE_MAXSERVICES   4
+#define PCIE_PORT_DEVICE_MAXSERVICES   5
 /*
  * According to the PCI Express Base Specification 2.0, the indices of
  * the MSI-X table entries used by port services must not exceed 31
diff --git a/drivers/pci/pcie/portdrv_acpi.c b/drivers/pci/pcie/portdrv_acpi.c
index b4d2894..44296eb 100644
--- a/drivers/pci/pcie/portdrv_acpi.c
+++ b/drivers/pci/pcie/portdrv_acpi.c
@@ -51,7 +51,7 @@ int pcie_port_acpi_setup(struct pci_dev *port, int *srv_mask)
 
 	flags = root->osc_control_set;
 
-	*srv_mask = PCIE_PORT_SERVICE_VC;
+	*srv_mask = PCIE_PORT_SERVICE_VC | PCIE_PORT_SERVICE_DPC;
 	if (flags & OSC_PCI_EXPRESS_NATIVE_HP_CONTROL)
 		*srv_mask |= PCIE_PORT_SERVICE_HP;
 	if (flags & OSC_PCI_EXPRESS_PME_CONTROL)
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 88122dc..79558d8 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -262,7 +262,7 @@ static int get_port_device_capability(struct pci_dev *dev)
 		return 0;
 
 	cap_mask = PCIE_PORT_SERVICE_PME | PCIE_PORT_SERVICE_HP
-			| PCIE_PORT_SERVICE_VC;
+			| PCIE_PORT_SERVICE_VC | PCIE_PORT_SERVICE_DPC;
 	if (pci_aer_available())
 		cap_mask |= PCIE_PORT_SERVICE_AER;
 
@@ -311,6 +311,8 @@ static int get_port_device_capability(struct pci_dev *dev)
 		 */
 		pcie_pme_interrupt_enable(dev, false);
 	}
+	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC))
+		services |= PCIE_PORT_SERVICE_DPC;
 
 	return services;
 }
diff --git a/include/linux/pcieport_if.h b/include/linux/pcieport_if.h
index 4f1089f..afcd130 100644
--- a/include/linux/pcieport_if.h
+++ b/include/linux/pcieport_if.h
@@ -21,6 +21,8 @@
 #define PCIE_PORT_SERVICE_HP		(1 << PCIE_PORT_SERVICE_HP_SHIFT)
 #define PCIE_PORT_SERVICE_VC_SHIFT	3	/* Virtual Channel */
 #define PCIE_PORT_SERVICE_VC		(1 << PCIE_PORT_SERVICE_VC_SHIFT)
+#define PCIE_PORT_SERVICE_DPC_SHIFT	4	/* Downstream Port Containment */
+#define PCIE_PORT_SERVICE_DPC		(1 << PCIE_PORT_SERVICE_DPC_SHIFT)
 
 struct pcie_device {
 	int		irq;	    /* Service IRQ/MSI/MSI-X Vector */
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 1becea8..c008294 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -670,7 +670,8 @@
 #define PCI_EXT_CAP_ID_SECPCI	0x19	/* Secondary PCIe Capability */
 #define PCI_EXT_CAP_ID_PMUX	0x1A	/* Protocol Multiplexing */
 #define PCI_EXT_CAP_ID_PASID	0x1B	/* Process Address Space ID */
-#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_PASID
+#define PCI_EXT_CAP_ID_DPC	0x1D	/* Downstream Port Containment */
+#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_DPC
 
 #define PCI_EXT_CAP_DSN_SIZEOF	12
 #define PCI_EXT_CAP_MCAST_ENDPOINT_SIZEOF 40
@@ -946,4 +947,28 @@
 #define PCI_TPH_CAP_ST_SHIFT	16	/* st table shift */
 #define PCI_TPH_BASE_SIZEOF	12	/* size with no st table */
 
+/* Downstream Port Containment */
+#define PCI_EXP_DPC_CAP			4	/* DPC Capability */
+#define  PCI_EXP_DPC_CAP_RP_EXT		0x20	/* Root Port Extensions for DPC */
+#define  PCI_EXP_DPC_CAP_POISONED_TLP	0x40	/* Poisoned TLP Egress Blocking Supported */
+#define  PCI_EXP_DPC_CAP_SW_TRIGGER	0x80	/* Software Triggering Supported */
+#define  PCI_EXP_DPC_CAP_DL_ACTIVE	0x1000	/* ERR_COR signal on DL_Active supported */
+
+#define PCI_EXP_DPC_CTL			6	/* DPC control */
+#define  PCI_EXP_DPC_CTL_DISABLE 	0x00	/* Disable trigger */
+#define  PCI_EXP_DPC_CTL_EN_FATAL 	0x01	/* Enable trigger on ERR_FATAL message */
+#define  PCI_EXP_DPC_CTL_EN_NONFATAL 	0x02	/* Enable trigger on ERR_NONFATAL message */
+#define  PCI_EXP_DPC_CTL_UR 		0x04	/* Unsupported Request Completion Status */
+#define  PCI_EXP_DPC_CTL_INT_EN 	0x08	/* DPC Interrupt Enable */
+#define  PCI_EXP_DPC_CTL_ERR_COR_EN 	0x10	/* Enable ERRO_COR Message on DPC triggered */
+#define  PCI_EXP_DPC_CTL_POSIONED_TLP	0x20	/* Enabled Poisoned TLP Egress Blocking */
+#define  PCI_EXP_DPC_CTL_SW_T_EN	0x40	/* Trigger DPC Status */
+#define  PCI_EXP_DPC_CTL_DL_A_ERR_COR	0x80	/* Signal ER_COR on DL_Active */
+
+#define PCI_EXP_DPC_STATUS		8	/* DPC Status */
+#define  PCI_EXP_DPC_STATUS_TRIGGER	0x01	/* Trigger Status */
+#define  PCI_EXP_DPC_STATUS_INTERRUPT	0x08	/* Interrupt Status */
+
+#define PCI_EXP_DPC_SOURCE_ID		0x0A
+
 #endif /* LINUX_PCI_REGS_H */
-- 
2.7.2

