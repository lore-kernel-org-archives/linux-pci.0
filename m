Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.hostsharing.net ([176.9.242.54]:58683 "EHLO
        mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753334AbcJSOKx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Oct 2016 10:10:53 -0400
Message-Id: <1f66f01ec1406ca76f578c02b218003fad3853e5.1476875113.git.lukas@wunner.de>
In-Reply-To: <cover.1476875113.git.lukas@wunner.de>
References: <cover.1476875113.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Wed, 19 Oct 2016 16:07:13 +0200
Subject: [PATCH 9/9] PCI: pciehp: Add runtime PM support for PCIe hotplug
 ports
To: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Keith Busch <keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Linux 4.8 added support for runtime suspending PCIe ports to D3hot with
commit 006d44e49a25 ("PCI: Add runtime PM support for PCIe ports"), but
excluded hotplug ports.  Those are now afforded runtime PM by the
present commit.

Hotplug ports require a few extra considerations:

- The configuration space of the port remains accessible in D3hot, so
  all the functions to read or modify the Slot Status and Slot Control
  registers need not be modified.  Even turning on slot power doesn't
  seem to require the port to be in D0, at least the PCIe spec doesn't
  say so and I confirmed that by testing with a Thunderbolt controller.

- However D0 is required to access devices on the subordinate bus.  This
  happens in pciehp_check_link_status() and pciehp_configure_device()
  (both called from board_added()) and in pciehp_unconfigure_device()
  (called from remove_board()), so acquire a runtime PM ref for their
  invocation.

- The hotplug port stays active as long as it has active children.  If
  all hotplugged devices below the port runtime suspend, the port is
  allowed to runtime suspend as well.  Plug and unplug detection
  continues to work in D3hot.

- Hotplug interrupts are delivered in-band, so while the hotplug port
  itself is allowed to go to D3hot, its parent ports must stay in D0 for
  interrupts to come through.  Add a corresponding restriction to
  pci_dev_check_d3cold().

- Runtime PM may only be allowed if the hotplug port is handled natively
  by the OS.  On ACPI systems, the port may alternatively be handled by
  the firmware and things break if the OS puts the port into D3 behind
  the firmware's back:  E.g. Thunderbolt hotplug ports on non-Macs are
  handled by Intel's firmware in System Management Mode and the firmware
  is known to access devices on the port's subordinate bus without
  checking first if the port is in D0:
  https://bugzilla.kernel.org/show_bug.cgi?id=53811

Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/hotplug/pciehp_ctrl.c | 6 ++++++
 drivers/pci/pci.c                 | 9 +++++----
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index efe69e8..ffd3fe6 100644
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
@@ -98,6 +99,7 @@ static int board_added(struct slot *p_slot)
 	pciehp_green_led_blink(p_slot);
 
 	/* Check link training status */
+	pm_runtime_get_sync(&ctrl->pcie->port->dev);
 	retval = pciehp_check_link_status(ctrl);
 	if (retval) {
 		ctrl_err(ctrl, "Failed to check link status\n");
@@ -118,12 +120,14 @@ static int board_added(struct slot *p_slot)
 		if (retval != -EEXIST)
 			goto err_exit;
 	}
+	pm_runtime_put(&ctrl->pcie->port->dev);
 
 	pciehp_green_led_on(p_slot);
 	pciehp_set_attention_status(p_slot, 0);
 	return 0;
 
 err_exit:
+	pm_runtime_put(&ctrl->pcie->port->dev);
 	set_slot_off(ctrl, p_slot);
 	return retval;
 }
@@ -137,7 +141,9 @@ static int remove_board(struct slot *p_slot)
 	int retval;
 	struct controller *ctrl = p_slot->ctrl;
 
+	pm_runtime_get_sync(&ctrl->pcie->port->dev);
 	retval = pciehp_unconfigure_device(p_slot);
+	pm_runtime_put(&ctrl->pcie->port->dev);
 	if (retval)
 		return retval;
 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index f1ddb6b..b10bcca 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2241,13 +2241,10 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
 			return false;
 
 		/*
-		 * Hotplug interrupts cannot be delivered if the link is down,
-		 * so parents of a hotplug port must stay awake. In addition,
 		 * Hotplug ports handled by firmware in System Management Mode
 		 * may not be put into D3 by the OS (Thunderbolt on non-Macs).
-		 * For simplicity, disallow in general for now.
 		 */
-		if (bridge->is_hotplug_bridge)
+		if (bridge->is_hotplug_bridge && !pciehp_is_native(bridge))
 			return false;
 
 		if (pci_bridge_d3_force)
@@ -2283,6 +2280,10 @@ static int pci_dev_check_d3cold(struct pci_dev *dev, void *data)
 	if (!pci_power_manageable(dev))
 		*d3cold_ok = false;
 
+	/* Hotplug interrupts cannot be delivered if the link is down. */
+	if (dev->is_hotplug_bridge)
+		*d3cold_ok = false;
+
 	return !*d3cold_ok;
 }
 
-- 
2.9.3

