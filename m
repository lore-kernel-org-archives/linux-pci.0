Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751099AbeCGGN6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Mar 2018 01:13:58 -0500
Subject: [PATCH v1 6/9] PCI/portdrv: Remove unused PCIE_PORT_SERVICE_VC
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Keith Busch <keith.busch@intel.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Lukas Wunner <lukas@wunner.de>
Date: Wed, 07 Mar 2018 00:13:56 -0600
Message-ID: <152040323671.240786.17190514268346362843.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152040297576.240786.1532465558381209070.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152040297576.240786.1532465558381209070.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

No driver registers for PCIE_PORT_SERVICE_VC, so remove it.

This removes the VC "service" files from /sys/bus/pci_express/devices,
e.g., 0000:07:00.0:pcie108, 0000:08:04.0:pcie208 (all the files that
contained "8" as the last digit of the "pcieXXX" part).  The port driver
created these files for PCIe port devices that have a VC Capability.

Since this reduces PCIE_PORT_DEVICE_MAXSERVICES and moves DPC down into the
spot where VC used to be, the DPC sysfs files will now be named "pcieXX8".
I don't think there's anything useful userspace can do with those files, so
I hope nobody cares about these filenames.

There is no VC driver that calls pcie_port_service_register(), so there
never was a /sys/bus/pci_express/drivers/vc directory.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/portdrv.h      |    2 +-
 drivers/pci/pcie/portdrv_acpi.c |    2 +-
 drivers/pci/pcie/portdrv_core.c |   14 ++++----------
 include/linux/pcieport_if.h     |    4 +---
 4 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index a4fc44d52206..749d200936d9 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -12,7 +12,7 @@
 
 #include <linux/compiler.h>
 
-#define PCIE_PORT_DEVICE_MAXSERVICES   5
+#define PCIE_PORT_DEVICE_MAXSERVICES   4
 /*
  * The PCIe Capability Interrupt Message Number (PCIe r3.1, sec 7.8.2) must
  * be one of the first 32 MSI-X entries.  Per PCI r3.0, sec 6.8.3.1, MSI
diff --git a/drivers/pci/pcie/portdrv_acpi.c b/drivers/pci/pcie/portdrv_acpi.c
index 319c94976873..4a1b50867c98 100644
--- a/drivers/pci/pcie/portdrv_acpi.c
+++ b/drivers/pci/pcie/portdrv_acpi.c
@@ -48,7 +48,7 @@ void pcie_port_acpi_setup(struct pci_dev *port, int *srv_mask)
 
 	flags = root->osc_control_set;
 
-	*srv_mask = PCIE_PORT_SERVICE_VC | PCIE_PORT_SERVICE_DPC;
+	*srv_mask = PCIE_PORT_SERVICE_DPC;
 	if (flags & OSC_PCI_EXPRESS_NATIVE_HP_CONTROL)
 		*srv_mask |= PCIE_PORT_SERVICE_HP;
 	if (flags & OSC_PCI_EXPRESS_PME_CONTROL)
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 9db77c683732..94ce4dc50d1a 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -189,10 +189,8 @@ static int pcie_init_service_irqs(struct pci_dev *dev, int *irqs, int mask)
 	if (ret < 0)
 		return -ENODEV;
 
-	for (i = 0; i < PCIE_PORT_DEVICE_MAXSERVICES; i++) {
-		if (i != PCIE_PORT_SERVICE_VC_SHIFT)
-			irqs[i] = pci_irq_vector(dev, 0);
-	}
+	for (i = 0; i < PCIE_PORT_DEVICE_MAXSERVICES; i++)
+		irqs[i] = pci_irq_vector(dev, 0);
 
 	return 0;
 }
@@ -212,8 +210,7 @@ static int get_port_device_capability(struct pci_dev *dev)
 	int services = 0;
 	int cap_mask = 0;
 
-	cap_mask = PCIE_PORT_SERVICE_PME | PCIE_PORT_SERVICE_HP
-			| PCIE_PORT_SERVICE_VC;
+	cap_mask = PCIE_PORT_SERVICE_PME | PCIE_PORT_SERVICE_HP;
 	if (pci_aer_available())
 		cap_mask |= PCIE_PORT_SERVICE_AER | PCIE_PORT_SERVICE_DPC;
 
@@ -240,9 +237,6 @@ static int get_port_device_capability(struct pci_dev *dev)
 		 */
 		pci_disable_pcie_error_reporting(dev);
 	}
-	/* VC support */
-	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_VC))
-		services |= PCIE_PORT_SERVICE_VC;
 	/* Root ports are capable of generating PME too */
 	if ((cap_mask & PCIE_PORT_SERVICE_PME)
 	    && pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT) {
@@ -332,7 +326,7 @@ int pcie_port_device_register(struct pci_dev *dev)
 	 */
 	status = pcie_init_service_irqs(dev, irqs, capabilities);
 	if (status) {
-		capabilities &= PCIE_PORT_SERVICE_VC | PCIE_PORT_SERVICE_HP;
+		capabilities &= PCIE_PORT_SERVICE_HP;
 		if (!capabilities)
 			goto error_disable;
 	}
diff --git a/include/linux/pcieport_if.h b/include/linux/pcieport_if.h
index b69769dbf659..28eb21731db6 100644
--- a/include/linux/pcieport_if.h
+++ b/include/linux/pcieport_if.h
@@ -20,9 +20,7 @@
 #define PCIE_PORT_SERVICE_AER		(1 << PCIE_PORT_SERVICE_AER_SHIFT)
 #define PCIE_PORT_SERVICE_HP_SHIFT	2	/* Native Hotplug */
 #define PCIE_PORT_SERVICE_HP		(1 << PCIE_PORT_SERVICE_HP_SHIFT)
-#define PCIE_PORT_SERVICE_VC_SHIFT	3	/* Virtual Channel */
-#define PCIE_PORT_SERVICE_VC		(1 << PCIE_PORT_SERVICE_VC_SHIFT)
-#define PCIE_PORT_SERVICE_DPC_SHIFT	4	/* Downstream Port Containment */
+#define PCIE_PORT_SERVICE_DPC_SHIFT	3	/* Downstream Port Containment */
 #define PCIE_PORT_SERVICE_DPC		(1 << PCIE_PORT_SERVICE_DPC_SHIFT)
 
 struct pcie_device {
