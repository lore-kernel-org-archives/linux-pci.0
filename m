Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751205AbeCIS7z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 9 Mar 2018 13:59:55 -0500
Subject: [PATCH v2 01/13] PCI/portdrv: Merge pcieport_if.h into portdrv.h
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Keith Busch <keith.busch@intel.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Lukas Wunner <lukas@wunner.de>,
        Frederick Lawler <fred@fredlawl.com>
Date: Fri, 09 Mar 2018 12:59:54 -0600
Message-ID: <152062199471.77693.15585860566110984931.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152062141493.77693.9630397416694091342.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152062141493.77693.9630397416694091342.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

pcieport_if.h contained the interfaces to register port service driver,
e.g., pcie_port_service_register().  portdrv.h contained internal data
structures of the port driver.

I don't think it's worth keeping those files separate, since both headers
and their users are all inside the PCI core.

Merge pcieport_if.h directly in drivers/pci/pcie/portdrv.h and update the
users to include that instead.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/hotplug/pciehp.h    |    2 +
 drivers/pci/pcie/aer/aerdrv.h   |    2 +
 drivers/pci/pcie/pcie-dpc.c     |    2 +
 drivers/pci/pcie/pcieport_if.h  |   71 ---------------------------------------
 drivers/pci/pcie/pme.c          |    1 -
 drivers/pci/pcie/portdrv.h      |   61 +++++++++++++++++++++++++++++++++-
 drivers/pci/pcie/portdrv_acpi.c |    1 -
 drivers/pci/pcie/portdrv_bus.c  |    1 -
 drivers/pci/pcie/portdrv_core.c |    1 -
 drivers/pci/pcie/portdrv_pci.c  |    1 -
 10 files changed, 63 insertions(+), 80 deletions(-)
 delete mode 100644 drivers/pci/pcie/pcieport_if.h

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index 08072bcaa381..88e917c9120f 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -23,7 +23,7 @@
 #include <linux/mutex.h>
 #include <linux/workqueue.h>
 
-#include "../pcie/pcieport_if.h"
+#include "../pcie/portdrv.h"
 
 #define MY_NAME	"pciehp"
 
diff --git a/drivers/pci/pcie/aer/aerdrv.h b/drivers/pci/pcie/aer/aerdrv.h
index 568326f385b7..a884f68bada4 100644
--- a/drivers/pci/pcie/aer/aerdrv.h
+++ b/drivers/pci/pcie/aer/aerdrv.h
@@ -13,7 +13,7 @@
 #include <linux/aer.h>
 #include <linux/interrupt.h>
 
-#include "../pcieport_if.h"
+#include "../portdrv.h"
 
 #define SYSTEM_ERROR_INTR_ON_MESG_MASK	(PCI_EXP_RTCTL_SECEE|	\
 					PCI_EXP_RTCTL_SENFEE|	\
diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
index bac895de4c72..8c57d607e603 100644
--- a/drivers/pci/pcie/pcie-dpc.c
+++ b/drivers/pci/pcie/pcie-dpc.c
@@ -11,7 +11,7 @@
 #include <linux/init.h>
 #include <linux/pci.h>
 
-#include "pcieport_if.h"
+#include "portdrv.h"
 #include "../pci.h"
 #include "aer/aerdrv.h"
 
diff --git a/drivers/pci/pcie/pcieport_if.h b/drivers/pci/pcie/pcieport_if.h
deleted file mode 100644
index b69769dbf659..000000000000
--- a/drivers/pci/pcie/pcieport_if.h
+++ /dev/null
@@ -1,71 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * File:	pcieport_if.h
- * Purpose:	PCI Express Port Bus Driver's IF Data Structure
- *
- * Copyright (C) 2004 Intel
- * Copyright (C) Tom Long Nguyen (tom.l.nguyen@intel.com)
- */
-
-#ifndef _PCIEPORT_IF_H_
-#define _PCIEPORT_IF_H_
-
-/* Port Type */
-#define PCIE_ANY_PORT			(~0)
-
-/* Service Type */
-#define PCIE_PORT_SERVICE_PME_SHIFT	0	/* Power Management Event */
-#define PCIE_PORT_SERVICE_PME		(1 << PCIE_PORT_SERVICE_PME_SHIFT)
-#define PCIE_PORT_SERVICE_AER_SHIFT	1	/* Advanced Error Reporting */
-#define PCIE_PORT_SERVICE_AER		(1 << PCIE_PORT_SERVICE_AER_SHIFT)
-#define PCIE_PORT_SERVICE_HP_SHIFT	2	/* Native Hotplug */
-#define PCIE_PORT_SERVICE_HP		(1 << PCIE_PORT_SERVICE_HP_SHIFT)
-#define PCIE_PORT_SERVICE_VC_SHIFT	3	/* Virtual Channel */
-#define PCIE_PORT_SERVICE_VC		(1 << PCIE_PORT_SERVICE_VC_SHIFT)
-#define PCIE_PORT_SERVICE_DPC_SHIFT	4	/* Downstream Port Containment */
-#define PCIE_PORT_SERVICE_DPC		(1 << PCIE_PORT_SERVICE_DPC_SHIFT)
-
-struct pcie_device {
-	int		irq;	    /* Service IRQ/MSI/MSI-X Vector */
-	struct pci_dev *port;	    /* Root/Upstream/Downstream Port */
-	u32		service;    /* Port service this device represents */
-	void		*priv_data; /* Service Private Data */
-	struct device	device;     /* Generic Device Interface */
-};
-#define to_pcie_device(d) container_of(d, struct pcie_device, device)
-
-static inline void set_service_data(struct pcie_device *dev, void *data)
-{
-	dev->priv_data = data;
-}
-
-static inline void *get_service_data(struct pcie_device *dev)
-{
-	return dev->priv_data;
-}
-
-struct pcie_port_service_driver {
-	const char *name;
-	int (*probe) (struct pcie_device *dev);
-	void (*remove) (struct pcie_device *dev);
-	int (*suspend) (struct pcie_device *dev);
-	int (*resume) (struct pcie_device *dev);
-
-	/* Device driver may resume normal operations */
-	void (*error_resume)(struct pci_dev *dev);
-
-	/* Link Reset Capability - AER service driver specific */
-	pci_ers_result_t (*reset_link) (struct pci_dev *dev);
-
-	int port_type;  /* Type of the port this driver can handle */
-	u32 service;    /* Port service this device represents */
-
-	struct device_driver driver;
-};
-#define to_service_driver(d) \
-	container_of(d, struct pcie_port_service_driver, driver)
-
-int pcie_port_service_register(struct pcie_port_service_driver *new);
-void pcie_port_service_unregister(struct pcie_port_service_driver *new);
-
-#endif /* _PCIEPORT_IF_H_ */
diff --git a/drivers/pci/pcie/pme.c b/drivers/pci/pcie/pme.c
index d29678958d92..3ed67676ea2a 100644
--- a/drivers/pci/pcie/pme.c
+++ b/drivers/pci/pcie/pme.c
@@ -16,7 +16,6 @@
 #include <linux/device.h>
 #include <linux/pm_runtime.h>
 
-#include "pcieport_if.h"
 #include "../pci.h"
 #include "portdrv.h"
 
diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index a854bc569117..d4009e35702c 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
  * File:	portdrv.h
- * Purpose:	PCI Express Port Bus Driver's Internal Data Structures
+ * Purpose:	PCI Express Port Bus Driver's Data Structures
  *
  * Copyright (C) 2004 Intel
  * Copyright (C) Tom Long Nguyen (tom.l.nguyen@intel.com)
@@ -12,7 +12,66 @@
 
 #include <linux/compiler.h>
 
+/* Service Type */
+#define PCIE_PORT_SERVICE_PME_SHIFT	0	/* Power Management Event */
+#define PCIE_PORT_SERVICE_PME		(1 << PCIE_PORT_SERVICE_PME_SHIFT)
+#define PCIE_PORT_SERVICE_AER_SHIFT	1	/* Advanced Error Reporting */
+#define PCIE_PORT_SERVICE_AER		(1 << PCIE_PORT_SERVICE_AER_SHIFT)
+#define PCIE_PORT_SERVICE_HP_SHIFT	2	/* Native Hotplug */
+#define PCIE_PORT_SERVICE_HP		(1 << PCIE_PORT_SERVICE_HP_SHIFT)
+#define PCIE_PORT_SERVICE_VC_SHIFT	3	/* Virtual Channel */
+#define PCIE_PORT_SERVICE_VC		(1 << PCIE_PORT_SERVICE_VC_SHIFT)
+#define PCIE_PORT_SERVICE_DPC_SHIFT	4	/* Downstream Port Containment */
+#define PCIE_PORT_SERVICE_DPC		(1 << PCIE_PORT_SERVICE_DPC_SHIFT)
+
 #define PCIE_PORT_DEVICE_MAXSERVICES   5
+
+/* Port Type */
+#define PCIE_ANY_PORT			(~0)
+
+struct pcie_device {
+	int		irq;	    /* Service IRQ/MSI/MSI-X Vector */
+	struct pci_dev *port;	    /* Root/Upstream/Downstream Port */
+	u32		service;    /* Port service this device represents */
+	void		*priv_data; /* Service Private Data */
+	struct device	device;     /* Generic Device Interface */
+};
+#define to_pcie_device(d) container_of(d, struct pcie_device, device)
+
+static inline void set_service_data(struct pcie_device *dev, void *data)
+{
+	dev->priv_data = data;
+}
+
+static inline void *get_service_data(struct pcie_device *dev)
+{
+	return dev->priv_data;
+}
+
+struct pcie_port_service_driver {
+	const char *name;
+	int (*probe) (struct pcie_device *dev);
+	void (*remove) (struct pcie_device *dev);
+	int (*suspend) (struct pcie_device *dev);
+	int (*resume) (struct pcie_device *dev);
+
+	/* Device driver may resume normal operations */
+	void (*error_resume)(struct pci_dev *dev);
+
+	/* Link Reset Capability - AER service driver specific */
+	pci_ers_result_t (*reset_link) (struct pci_dev *dev);
+
+	int port_type;  /* Type of the port this driver can handle */
+	u32 service;    /* Port service this device represents */
+
+	struct device_driver driver;
+};
+#define to_service_driver(d) \
+	container_of(d, struct pcie_port_service_driver, driver)
+
+int pcie_port_service_register(struct pcie_port_service_driver *new);
+void pcie_port_service_unregister(struct pcie_port_service_driver *new);
+
 /*
  * The PCIe Capability Interrupt Message Number (PCIe r3.1, sec 7.8.2) must
  * be one of the first 32 MSI-X entries.  Per PCI r3.0, sec 6.8.3.1, MSI
diff --git a/drivers/pci/pcie/portdrv_acpi.c b/drivers/pci/pcie/portdrv_acpi.c
index c7d8debb4a5c..53f60053bd47 100644
--- a/drivers/pci/pcie/portdrv_acpi.c
+++ b/drivers/pci/pcie/portdrv_acpi.c
@@ -11,7 +11,6 @@
 #include <linux/acpi.h>
 #include <linux/pci-acpi.h>
 
-#include "pcieport_if.h"
 #include "aer/aerdrv.h"
 #include "../pci.h"
 #include "portdrv.h"
diff --git a/drivers/pci/pcie/portdrv_bus.c b/drivers/pci/pcie/portdrv_bus.c
index b5c5697cfb30..4969ccf6b214 100644
--- a/drivers/pci/pcie/portdrv_bus.c
+++ b/drivers/pci/pcie/portdrv_bus.c
@@ -13,7 +13,6 @@
 #include <linux/errno.h>
 #include <linux/pm.h>
 
-#include "pcieport_if.h"
 #include "portdrv.h"
 
 static int pcie_port_bus_match(struct device *dev, struct device_driver *drv);
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index bab9cb71130f..4268b2fc2c7a 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -17,7 +17,6 @@
 #include <linux/slab.h>
 #include <linux/aer.h>
 
-#include "pcieport_if.h"
 #include "../pci.h"
 #include "portdrv.h"
 
diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index 13dbe846a1d1..977bd3cca2e5 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -19,7 +19,6 @@
 #include <linux/dmi.h>
 #include <linux/pci-aspm.h>
 
-#include "pcieport_if.h"
 #include "../pci.h"
 #include "portdrv.h"
 
