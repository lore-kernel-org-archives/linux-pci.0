Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751622AbeBKCsW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 10 Feb 2018 21:48:22 -0500
Subject: [PATCH] PCI/portdrv: Remove "pcie_hp=nomsi" kernel parameter
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Prarit Bhargava <prarit@redhat.com>, linux-kernel@vger.kernel.org,
        MUNEDA Takahiro <muneda.takahiro@jp.fujitsu.com>,
        Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Date: Sat, 10 Feb 2018 20:48:15 -0600
Message-ID: <20180211024815.73781.92853.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
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
Device Technology, Inc. Device 807f bridge).  There is no automated way to
set this parameter, so it's not very useful for distributions or end users.

I suspect the root cause of the underlying "irq 16: nobody cared" issue was
fixed by Prarit Bhargava <prarit@redhat.com> with fda78d7a0ead ("PCI/MSI:
Stop disabling MSI/MSI-X in pci_device_shutdown()") and we probably don't
need "pcie_hp=nomsi" any more.

Revert 7570a333d8b0 to remove the "pcie_hp=nomsi" parameter.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
CC: MUNEDA Takahiro <muneda.takahiro@jp.fujitsu.com>
CC: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
CC: Prarit Bhargava <prarit@redhat.com>
---
 Documentation/admin-guide/kernel-parameters.txt |    4 ----
 drivers/pci/pcie/portdrv.h                      |   12 ------------
 drivers/pci/pcie/portdrv_core.c                 |   20 +++-----------------
 3 files changed, 3 insertions(+), 33 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 78cdf6a637fc..ed0d26d26c26 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3101,10 +3101,6 @@
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
index a854bc569117..b00764bc684d 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -36,18 +36,6 @@ struct pci_dev;
 
 void pcie_clear_root_pme_status(struct pci_dev *dev);
 
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
index ef3bad4ad010..219f0f47f6fb 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -21,17 +21,6 @@
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
@@ -169,16 +158,13 @@ static int pcie_init_service_irqs(struct pci_dev *dev, int *irqs, int mask)
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
