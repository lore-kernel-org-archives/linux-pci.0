Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.hostsharing.net ([83.223.95.204]:45378 "EHLO
	mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753039AbcEDNDS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 4 May 2016 09:03:18 -0400
Message-Id: <a1c9caeb4124f89fbf7cde171642ca3f511081b5.1462366514.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Wed, 4 May 2016 15:05:57 +0200
Subject: [PATCH] PCI/portdrv: Use cached copy of PCI_EXP_SLTCAP_HPC bit
To: linux-pci@vger.kernel.org
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We cache the PCI_EXP_SLTCAP_HPC bit in pci_dev->is_hotplug_bridge on
device probe, so there's no need to read it again on allocation of
port service devices.

No functional change intended.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/pcie/portdrv_core.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 050069f..af7796d 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -254,7 +254,6 @@ static void cleanup_service_irqs(struct pci_dev *dev)
 static int get_port_device_capability(struct pci_dev *dev)
 {
 	int services = 0;
-	u32 reg32;
 	int cap_mask = 0;
 
 	if (pcie_ports_disabled)
@@ -269,19 +268,15 @@ static int get_port_device_capability(struct pci_dev *dev)
 		pcie_port_platform_notify(dev, &cap_mask);
 
 	/* Hot-Plug Capable */
-	if ((cap_mask & PCIE_PORT_SERVICE_HP) &&
-	    pcie_caps_reg(dev) & PCI_EXP_FLAGS_SLOT) {
-		pcie_capability_read_dword(dev, PCI_EXP_SLTCAP, &reg32);
-		if (reg32 & PCI_EXP_SLTCAP_HPC) {
-			services |= PCIE_PORT_SERVICE_HP;
-			/*
-			 * Disable hot-plug interrupts in case they have been
-			 * enabled by the BIOS and the hot-plug service driver
-			 * is not loaded.
-			 */
-			pcie_capability_clear_word(dev, PCI_EXP_SLTCTL,
-				PCI_EXP_SLTCTL_CCIE | PCI_EXP_SLTCTL_HPIE);
-		}
+	if ((cap_mask & PCIE_PORT_SERVICE_HP)
+	    && dev->is_hotplug_bridge) {
+		services |= PCIE_PORT_SERVICE_HP;
+		/*
+		 * Disable hot-plug interrupts in case they have been enabled
+		 * by the BIOS and the hot-plug service driver is not loaded.
+		 */
+		pcie_capability_clear_word(dev, PCI_EXP_SLTCTL,
+			  PCI_EXP_SLTCTL_CCIE | PCI_EXP_SLTCTL_HPIE);
 	}
 	/* AER capable */
 	if ((cap_mask & PCIE_PORT_SERVICE_AER)
-- 
2.8.1

