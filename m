Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.hostsharing.net ([83.223.90.233]:41143 "EHLO
        mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S941509AbcJSOY3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Oct 2016 10:24:29 -0400
Message-Id: <a2073dcdc8287e1a7755ca7c2a48f4124888f143.1476875113.git.lukas@wunner.de>
In-Reply-To: <cover.1476875113.git.lukas@wunner.de>
References: <cover.1476875113.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Wed, 19 Oct 2016 16:07:13 +0200
Subject: [PATCH 4/9] PCI: Activate runtime PM on a PCIe port only if it can
 suspend
To: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Keith Busch <keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Currently pcie_portdrv_probe() activates runtime PM on a PCIe port even
if it will never actually suspend because the BIOS is too old or the
"pcie_port_pm=off" option was specified on the kernel command line.

A few CPU cycles can be saved by not activating runtime PM at all in
these cases, because rpm_idle() and rpm_suspend() will bail out right
at the beginning when calling rpm_check_suspend_allowed(), instead of
carrying out various locking and assignments, invoking rpm_callback(),
getting back -EBUSY and rolling everything back.

The conditions checked in pci_bridge_d3_possible() are all static, they
never change during uptime of the system, hence it's safe to call this
to determine if runtime PM should be activated.

No functional change intended.

Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/pci.c              | 2 +-
 drivers/pci/pci.h              | 1 +
 drivers/pci/pcie/portdrv_pci.c | 5 +++--
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index bc60f2c..854d185 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2226,7 +2226,7 @@ void pci_config_pm_runtime_put(struct pci_dev *pdev)
  * This function checks if it is possible to move the bridge to D3.
  * Currently we only allow D3 for recent enough PCIe ports.
  */
-static bool pci_bridge_d3_possible(struct pci_dev *bridge)
+bool pci_bridge_d3_possible(struct pci_dev *bridge)
 {
 	unsigned int year;
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 27048bb..ffffef3 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -85,6 +85,7 @@ void pci_pm_init(struct pci_dev *dev);
 void pci_ea_init(struct pci_dev *dev);
 void pci_allocate_cap_save_buffers(struct pci_dev *dev);
 void pci_free_cap_save_buffers(struct pci_dev *dev);
+bool pci_bridge_d3_possible(struct pci_dev *dev);
 void pci_bridge_d3_update(struct pci_dev *dev);
 
 static inline void pci_wakeup_event(struct pci_dev *dev)
diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index 79327cc..1ae712c 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -19,6 +19,7 @@
 #include <linux/dmi.h>
 #include <linux/pci-aspm.h>
 
+#include "../pci.h"
 #include "portdrv.h"
 #include "aer/aerdrv.h"
 
@@ -157,7 +158,7 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
 	 * subordinate devices).  We can't be sure for native PCIe hotplug
 	 * either so prevent that as well.
 	 */
-	if (!dev->is_hotplug_bridge) {
+	if (pci_bridge_d3_possible(dev) && !dev->is_hotplug_bridge) {
 		/*
 		 * Keep the port resumed 100ms to make sure things like
 		 * config space accesses from userspace (lspci) will not
@@ -175,7 +176,7 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
 
 static void pcie_portdrv_remove(struct pci_dev *dev)
 {
-	if (!dev->is_hotplug_bridge) {
+	if (pci_bridge_d3_possible(dev) && !dev->is_hotplug_bridge) {
 		pm_runtime_forbid(&dev->dev);
 		pm_runtime_get_noresume(&dev->dev);
 		pm_runtime_dont_use_autosuspend(&dev->dev);
-- 
2.9.3

