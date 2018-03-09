Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932759AbeCITA2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 9 Mar 2018 14:00:28 -0500
Subject: [PATCH v2 07/13] PCI/portdrv: Remove unused PCIE_PORT_SERVICE_VC
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Keith Busch <keith.busch@intel.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Lukas Wunner <lukas@wunner.de>,
        Frederick Lawler <fred@fredlawl.com>
Date: Fri, 09 Mar 2018 13:00:27 -0600
Message-ID: <152062202742.77693.2491710394330502440.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152062141493.77693.9630397416694091342.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152062141493.77693.9630397416694091342.stgit@bhelgaas-glaptop.roam.corp.google.com>
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
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pci/pcie/portdrv.h      |    6 ++----
 drivers/pci/pcie/portdrv_acpi.c |    2 +-
 drivers/pci/pcie/portdrv_core.c |   14 ++++----------
 3 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index 7086086e45d0..7bfd75f9197b 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -19,12 +19,10 @@
 #define PCIE_PORT_SERVICE_AER		(1 << PCIE_PORT_SERVICE_AER_SHIFT)
 #define PCIE_PORT_SERVICE_HP_SHIFT	2	/* Native Hotplug */
 #define PCIE_PORT_SERVICE_HP		(1 << PCIE_PORT_SERVICE_HP_SHIFT)
-#define PCIE_PORT_SERVICE_VC_SHIFT	3	/* Virtual Channel */
-#define PCIE_PORT_SERVICE_VC		(1 << PCIE_PORT_SERVICE_VC_SHIFT)
-#define PCIE_PORT_SERVICE_DPC_SHIFT	4	/* Downstream Port Containment */
+#define PCIE_PORT_SERVICE_DPC_SHIFT	3	/* Downstream Port Containment */
 #define PCIE_PORT_SERVICE_DPC		(1 << PCIE_PORT_SERVICE_DPC_SHIFT)
 
-#define PCIE_PORT_DEVICE_MAXSERVICES   5
+#define PCIE_PORT_DEVICE_MAXSERVICES   4
 
 /* Port Type */
 #define PCIE_ANY_PORT			(~0)
diff --git a/drivers/pci/pcie/portdrv_acpi.c b/drivers/pci/pcie/portdrv_acpi.c
index 53f60053bd47..9d12650dc2ae 100644
--- a/drivers/pci/pcie/portdrv_acpi.c
+++ b/drivers/pci/pcie/portdrv_acpi.c
@@ -47,7 +47,7 @@ void pcie_port_acpi_setup(struct pci_dev *port, int *srv_mask)
 
 	flags = root->osc_control_set;
 
-	*srv_mask = PCIE_PORT_SERVICE_VC | PCIE_PORT_SERVICE_DPC;
+	*srv_mask = PCIE_PORT_SERVICE_DPC;
 	if (flags & OSC_PCI_EXPRESS_NATIVE_HP_CONTROL)
 		*srv_mask |= PCIE_PORT_SERVICE_HP;
 	if (flags & OSC_PCI_EXPRESS_PME_CONTROL)
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 9a41751db332..bf851da97947 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -188,10 +188,8 @@ static int pcie_init_service_irqs(struct pci_dev *dev, int *irqs, int mask)
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
@@ -211,8 +209,7 @@ static int get_port_device_capability(struct pci_dev *dev)
 	int services = 0;
 	int cap_mask = 0;
 
-	cap_mask = PCIE_PORT_SERVICE_PME | PCIE_PORT_SERVICE_HP
-			| PCIE_PORT_SERVICE_VC;
+	cap_mask = PCIE_PORT_SERVICE_PME | PCIE_PORT_SERVICE_HP;
 	if (pci_aer_available())
 		cap_mask |= PCIE_PORT_SERVICE_AER | PCIE_PORT_SERVICE_DPC;
 
@@ -239,9 +236,6 @@ static int get_port_device_capability(struct pci_dev *dev)
 		 */
 		pci_disable_pcie_error_reporting(dev);
 	}
-	/* VC support */
-	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_VC))
-		services |= PCIE_PORT_SERVICE_VC;
 	/* Root ports are capable of generating PME too */
 	if ((cap_mask & PCIE_PORT_SERVICE_PME)
 	    && pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT) {
@@ -331,7 +325,7 @@ int pcie_port_device_register(struct pci_dev *dev)
 	 */
 	status = pcie_init_service_irqs(dev, irqs, capabilities);
 	if (status) {
-		capabilities &= PCIE_PORT_SERVICE_VC | PCIE_PORT_SERVICE_HP;
+		capabilities &= PCIE_PORT_SERVICE_HP;
 		if (!capabilities)
 			goto error_disable;
 	}
