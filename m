Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH v2 10/13] PCI/portdrv: Remove "pcie_hp=nomsi" kernel
 parameter
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Keith Busch <keith.busch@intel.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Lukas Wunner <lukas@wunner.de>,
        Frederick Lawler <fred@fredlawl.com>
Date: Fri, 09 Mar 2018 13:00:43 -0600
Message-ID: <152062204375.77693.9816633817360497350.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152062141493.77693.9630397416694091342.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152062141493.77693.9630397416694091342.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

7570a333d8b0 ("PCI: Add pcie_hp=nomsi to disable MSI/MSI-X for pciehp
driver") added the "pcie_hp=nomsi" kernel parameter to work around this
error on shutdown:

  irq 16: nobody cared (try booting with the "irqpoll" option)
  Pid: 1081, comm: reboot Not tainted 3.2.0 #1
  ...
  Disabling IRQ #16

This happened on an unspecified system (possibly involving the Integrated
Device Technology, Inc. Device 807f bridge) where "an un-wanted interrupt
is generated when PCI driver switches from MSI/MSI-X to INTx while shutting
down the device."

The implication was that the device was buggy, but it is normal for a
device to use INTx after MSI/MSI-X have been disabled.  The only problem
was that the driver was still attached and it wasn't prepared for INTx
interrupts.  Prarit Bhargava fixed this issue with fda78d7a0ead ("PCI/MSI:
Stop disabling MSI/MSI-X in pci_device_shutdown()").

There is no automated way to set this parameter, so it's not very useful
for distributions or end users.  It's really only useful for debugging, and
we have "pci=nomsi" for that purpose.

Revert 7570a333d8b0 to remove the "pcie_hp=nomsi" parameter.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
CC: MUNEDA Takahiro <muneda.takahiro@jp.fujitsu.com>
CC: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
CC: Prarit Bhargava <prarit@redhat.com>
---
 Documentation/admin-guide/kernel-parameters.txt |    4 ----
 drivers/pci/pcie/portdrv.h                      |   12 ------------
 drivers/pci/pcie/portdrv_core.c                 |   20 +++-----------------
 3 files changed, 3 insertions(+), 33 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 1d1d53f85ddd..761749562165 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3130,10 +3130,6 @@
 		force	Enable ASPM even on devices that claim not to support it.
 			WARNING: Forcing ASPM on may cause system lockups.
 
-	pcie_hp=	[PCIE] PCI Express Hotplug driver options:
-		nomsi	Do not use MSI for PCI Express Native Hotplug (this
-			makes all PCIe ports use INTx for hotplug services).
-
 	pcie_ports=	[PCIE] PCIe ports handling:
 		auto	Ask the BIOS whether or not to use native PCIe services
 			associated with PCIe ports (PME, hot-plug, AER).  Use
diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index ed84e767085f..86368f9341d7 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -91,18 +91,6 @@ void pcie_port_bus_unregister(void);
 
 struct pci_dev;
 
-#ifdef CONFIG_HOTPLUG_PCI_PCIE
-extern bool pciehp_msi_disabled;
-
-static inline bool pciehp_no_msi(void)
-{
-	return pciehp_msi_disabled;
-}
-
-#else  /* !CONFIG_HOTPLUG_PCI_PCIE */
-static inline bool pciehp_no_msi(void) { return false; }
-#endif /* !CONFIG_HOTPLUG_PCI_PCIE */
-
 #ifdef CONFIG_PCIE_PME
 extern bool pcie_pme_msi_disabled;
 
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 589960fdd8a8..ed24a407518a 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -20,17 +20,6 @@
 #include "../pci.h"
 #include "portdrv.h"
 
-bool pciehp_msi_disabled;
-
-static int __init pciehp_setup(char *str)
-{
-	if (!strncmp(str, "nomsi", 5))
-		pciehp_msi_disabled = true;
-
-	return 1;
-}
-__setup("pcie_hp=", pciehp_setup);
-
 /**
  * release_pcie_device - free PCI Express port service device structure
  * @dev: Port service device to release
@@ -168,16 +157,13 @@ static int pcie_init_service_irqs(struct pci_dev *dev, int *irqs, int mask)
 		irqs[i] = -1;
 
 	/*
-	 * If we support PME or hotplug, but we can't use MSI/MSI-X for
-	 * them, we have to fall back to INTx or other interrupts, e.g., a
-	 * system shared interrupt.
+	 * If we support PME but can't use MSI/MSI-X for it, we have to
+	 * fall back to INTx or other interrupts, e.g., a system shared
+	 * interrupt.
 	 */
 	if ((mask & PCIE_PORT_SERVICE_PME) && pcie_pme_no_msi())
 		goto legacy_irq;
 
-	if ((mask & PCIE_PORT_SERVICE_HP) && pciehp_no_msi())
-		goto legacy_irq;
-
 	/* Try to use MSI-X or MSI if supported */
 	if (pcie_port_enable_irq_vec(dev, irqs, mask) == 0)
 		return 0;
