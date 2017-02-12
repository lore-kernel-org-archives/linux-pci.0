Return-Path: <SRS0=PF/i=ZZ=wunner.de=lukas@kernel.org>
Return-Path: <SRS0=PF/i=ZZ=wunner.de=lukas@kernel.org>
Message-Id: <14ffd1ceeb76200b34e0abfebab134545e504bdc.1486913733.git.lukas@wunner.de>
In-Reply-To: <cover.1486913733.git.lukas@wunner.de>
References: <cover.1486913733.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sun, 12 Feb 2017 17:07:45 +0100
Subject: [PATCH v6 3/8] PCI: pciehp: Reinstate runtime PM on Thunderbolt
 hotplug ports
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Andreas Noever <andreas.noever@gmail.com>, linux-pci@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Erik Veijola <erik.veijola@linux.intel.com>, Ashok Raj <ashok.raj@intel.com>, Keith Busch <keith.busch@intel.com>, Yinghai Lu <yinghai@kernel.org>
List-ID: <linux-pci.vger.kernel.org>

Commit 68db9bc81436 ("PCI: pciehp: Add runtime PM support for PCIe
hotplug ports") extended runtime PM for PCIe ports to hotplug ports.
However Yinghai Lu reported the following breakage caused by the commit:

* After disabling a slot on one of his servers, the slot signals PME
  which causes pciehp to immediately re-enable the card, thus defeating
  manual slot control via sysfs.

* On another server which has a Power Controller for PCIe hotplug ports
  (PCIe r3.1, sec 6.7.1.8), the slot cannot be re-enabled after manually
  disabling it via sysfs since commit 68db9bc81436 acquired a runtime
  ref only *after* enabling power on the slot, yet this particular
  SkyLake server requires that the port is in D0 when enabling power.

Hence the commit was reverted with d98e0929071e.  It is herewith
reinstated in modified form:

* The Power Controller issue is addressed by no longer acquiring the
  runtime ref in board_added() and remove_board(), but in their callers.
  (There's just a single one each.)

* An additional condition is added to pci_bridge_d3_possible() such that
  runtime PM is only enabled on *Thunderbolt* hotplug ports to constrain
  it to a few well understood chips.  In all other cases the feature can
  be enabled by booting with pcie_port_pm=force.  If confidence is high
  that it works well for everyone, it can be made the default by
  removing this condition:

  /*
   * Non-Thunderbolt hotplug ports need further testing before
   * enabling D3 on them.
   */
  if (bridge->is_hotplug_bridge)
	  return false;

Following is an updated recapitulation of the extra considerations
required for hotplug ports as laid out in 68db9bc81436:

* The configuration space of the port remains accessible in D3hot, so
  all the functions to read or modify the Slot Status and Slot Control
  registers need not be modified.

* However D0 is required to access devices on the secondary bus.  This
  happens in pciehp_check_link_status() and pciehp_configure_device()
  (both called from board_added()) and in pciehp_unconfigure_device()
  (called from remove_board()), so acquire a runtime PM ref for their
  invocation.

* The hotplug port stays active as long as it has active children.
  If all hotplugged devices below the port runtime suspend, the port
  is allowed to runtime suspend as well.  Plug and unplug detection
  continues to work in D3hot.

* Hotplug interrupts are delivered in-band, which requires parents of
  the hotplug port to stay in D0.  For hotplug-capable root ports this
  is a non-issue.  For cascaded hotplug ports, side-band signaling is
  required.  E.g. with Thunderbolt, a plug event at the end of the chain
  is signaled through the CIO switching fabric to the NHI regardless of
  PCIe ports on the chain being in D3.  It is then the NHI's job to
  runtime resume the PCIe port on which the plug event occurred.

* Runtime PM may only be allowed if the hotplug port is handled natively
  by the OS.  On ACPI systems, the port may alternatively be handled by
  the firmware and things break if the OS puts the port into D3 behind the
  firmware's back:  E.g. Thunderbolt hotplug ports on non-Macs are handled
  by Intel's firmware in System Management Mode and the firmware is known
  to access devices on the port's secondary bus without checking first if
  the port is in D0:  https://bugzilla.kernel.org/show_bug.cgi?id=53811

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=193951
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Erik Veijola <erik.veijola@linux.intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/hotplug/pciehp_ctrl.c | 13 +++++++++++--
 drivers/pci/pci.c                 | 14 +++++++++-----
 2 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index ec0b4c11ccd9..d071aa63dac9 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -31,6 +31,7 @@
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/slab.h>
+#include <linux/pm_runtime.h>
 #include <linux/pci.h>
 #include "../pci.h"
 #include "pciehp.h"
@@ -390,6 +391,7 @@ int pciehp_enable_slot(struct slot *p_slot)
 {
 	u8 getstatus = 0;
 	struct controller *ctrl = p_slot->ctrl;
+	int retval;
 
 	pciehp_get_adapter_status(p_slot, &getstatus);
 	if (!getstatus) {
@@ -414,7 +416,10 @@ int pciehp_enable_slot(struct slot *p_slot)
 		}
 	}
 
-	return board_added(p_slot);
+	pm_runtime_get_sync(&ctrl->pcie->port->dev);
+	retval = board_added(p_slot);
+	pm_runtime_put(&ctrl->pcie->port->dev);
+	return retval;
 }
 
 /*
@@ -424,6 +429,7 @@ int pciehp_disable_slot(struct slot *p_slot)
 {
 	u8 getstatus = 0;
 	struct controller *ctrl = p_slot->ctrl;
+	int retval;
 
 	if (!p_slot->ctrl)
 		return 1;
@@ -437,7 +443,10 @@ int pciehp_disable_slot(struct slot *p_slot)
 		}
 	}
 
-	return remove_board(p_slot);
+	pm_runtime_get_sync(&ctrl->pcie->port->dev);
+	retval = remove_board(p_slot);
+	pm_runtime_put(&ctrl->pcie->port->dev);
+	return retval;
 }
 
 int pciehp_sysfs_enable_slot(struct slot *p_slot)
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 441083a0d5b0..a1896df274d4 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2241,13 +2241,10 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
 			return false;
 
 		/*
-		 * Hotplug interrupts cannot be delivered if the link is down,
-		 * so parents of a hotplug port must stay awake. In addition,
-		 * hotplug ports handled by firmware in System Management Mode
+		 * Hotplug ports handled by firmware in System Management Mode
 		 * may not be put into D3 by the OS (Thunderbolt on non-Macs).
-		 * For simplicity, disallow in general for now.
 		 */
-		if (bridge->is_hotplug_bridge)
+		if (bridge->is_hotplug_bridge && !pciehp_is_native(bridge))
 			return false;
 
 		if (pci_bridge_d3_force)
@@ -2258,6 +2255,13 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
 			return true;
 
 		/*
+		 * Non-Thunderbolt hotplug ports need further testing before
+		 * enabling D3 on them.
+		 */
+		if (bridge->is_hotplug_bridge)
+			return false;
+
+		/*
 		 * It should be safe to put PCIe ports from 2015 or newer
 		 * to D3.
 		 */
-- 
2.11.0
