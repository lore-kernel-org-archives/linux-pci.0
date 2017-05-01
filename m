Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.hostsharing.net ([83.223.90.233]:37665 "EHLO
        mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423442AbdEAMHN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 May 2017 08:07:13 -0400
Message-Id: <2cf485a95fe875f1d6874a90e922e89dce173d77.1493631639.git.lukas@wunner.de>
In-Reply-To: <cover.1493631639.git.lukas@wunner.de>
References: <cover.1493631639.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Mon, 1 May 2017 14:06:39 +0200
Subject: [PATCH 1/5] PCI: pciehp: Resume to D0 on board addition/removal
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Ashok Raj <ashok.raj@intel.com>,
        Yinghai Lu <yinghai@kernel.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Erik Veijola <erik.veijola@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Krishna Dhulipala <krishnad@fb.com>, Wei Zhang <wzhang@fb.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hotplug ports need to be in D0 to access devices on their secondary bus.
pciehp itself does this in
    pciehp_check_link_status(),
    pciehp_configure_device() (both called from board_added())
and
    pciehp_unconfigure_device() (called from remove_board()).

In addition, Yinghai Lu discovered that some Skylake server CPUs or PCHs
feature a Power Controller for their PCIe hotplug ports (PCIe r3.1, sec
6.7.1.8) which requires the port to be in D0 when invoking
    pciehp_power_on_slot() (likewise called from board_added()).

The spec is silent about such a requirement, but it seems prudent to
assume that any hotplug port with a Power Controller may need this.

Thus, acquire a runtime PM ref for the invocation of board_added() and
remove_board().

Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Erik Veijola <erik.veijola@linux.intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Yinghai Lu <yinghai@kernel.org>
Cc: Krishna Dhulipala <krishnad@fb.com>
Cc: Wei Zhang <wzhang@fb.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/hotplug/pciehp_ctrl.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

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
-- 
2.11.0
