Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.hostsharing.net ([83.223.95.204]:33094 "EHLO
	mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751741AbcEMLRY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 13 May 2016 07:17:24 -0400
Message-Id: <47f9e4a9ca09e854d2d01812a4c05b7c6df02259.1463134231.git.lukas@wunner.de>
In-Reply-To: <cover.1463134231.git.lukas@wunner.de>
References: <cover.1463134231.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Fri, 13 May 2016 13:15:31 +0200
Subject: [PATCH v2 08/13] PCI: Allow runtime PM for Thunderbolt hotplug ports
 on Macs
To: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Andreas Noever <andreas.noever@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Thunderbolt controllers have a pin to signal plug events while the
controller is powered down.  On Macs this pin is wired to the
southbridge and causes a GPE to be fired.  The OS may then power up the
controller to probe the newly connected device.  It is thus okay to let
Thunderbolt hotplug ports go to D3 on Macs.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/pcie/portdrv_pci.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index f75d4b5..7860ab3 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -224,9 +224,12 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
 	 * to enumerate devices behind this port properly (the port is
 	 * powered down preventing all config space accesses to the
 	 * subordinate devices).  We can't be sure for native PCIe hotplug
-	 * either so prevent that as well.
+	 * either so prevent that as well.  However Thunderbolt controllers
+	 * on Macs are capable of side-band signaling plug events while
+	 * powered down, so allow them to suspend.
 	 */
-	if (!dev->is_hotplug_bridge) {
+	if (!dev->is_hotplug_bridge ||
+	    (dev->is_thunderbolt && dmi_match(DMI_SYS_VENDOR, "Apple Inc."))) {
 		/*
 		 * Keep the port resumed 10ms to make sure things like
 		 * config space accesses from userspace (lspci) will not
@@ -243,7 +246,8 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
 
 static void pcie_portdrv_remove(struct pci_dev *dev)
 {
-	if (!dev->is_hotplug_bridge) {
+	if (!dev->is_hotplug_bridge ||
+	    (dev->is_thunderbolt && dmi_match(DMI_SYS_VENDOR, "Apple Inc."))) {
 		pm_runtime_forbid(&dev->dev);
 		pm_runtime_get_noresume(&dev->dev);
 		pm_runtime_dont_use_autosuspend(&dev->dev);
-- 
2.8.1

