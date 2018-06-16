Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.hostsharing.net ([83.223.95.204]:51901 "EHLO
        mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932788AbeFPTej (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Jun 2018 15:34:39 -0400
Message-Id: <5eb3919f0ad63e8cdb27bffbdf6d879e25a88476.1529173804.git.lukas@wunner.de>
In-Reply-To: <cover.1529173804.git.lukas@wunner.de>
References: <cover.1529173804.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sat, 16 Jun 2018 21:25:00 +0200
Subject: [PATCH 28/32] PCI: pciehp: Resume to D0 on enable/disable
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Yinghai Lu <yinghai@kernel.org>, Sinan Kaya <okaya@kernel.org>,
        linux-pci@vger.kernel.org
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pciehp's IRQ thread ensures accessibility of the port by runtime resuming
its parent to D0.  However when the slot is enabled/disabled, the port
itself needs to be in D0 because its secondary bus is accessed in:

    pciehp_check_link_status(),
    pciehp_configure_device() (both called from board_added())
and
    pciehp_unconfigure_device() (called from remove_board()).

Thus, acquire a runtime PM ref on enable/disablement of the slot.

Yinghai Lu additionally discovered that some SkyLake servers feature a
Power Controller for their PCIe hotplug ports (PCIe r3.1, sec 6.7.1.8)
which requires the port to be in D0 when invoking
    pciehp_power_on_slot() (likewise called from board_added()).

If slot power is turned on while in D3hot, link training later fails:
https://lkml.org/lkml/2017/2/5/13

The spec is silent about such a requirement, but it seems prudent to
assume that any hotplug port with a Power Controller may need this.

The present commit holds a runtime PM ref whenever slot power is turned
on and off, but it doesn't keep the port in D0 as long as slot power is
on.  If vendors determine that's necessary, they need to amend pciehp to
acquire a runtime PM ref in pciehp_power_on_slot() and release one in
pciehp_power_off_slot().

Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Yinghai Lu <yinghai@kernel.org>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/hotplug/pciehp_ctrl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index 811019902ada..6855933ab372 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -17,6 +17,7 @@
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/slab.h>
+#include <linux/pm_runtime.h>
 #include <linux/pci.h>
 #include "../pci.h"
 #include "pciehp.h"
@@ -310,9 +311,11 @@ static int pciehp_enable_slot(struct slot *slot)
 	struct controller *ctrl = slot->ctrl;
 	int ret;
 
+	pm_runtime_get_sync(&ctrl->pcie->port->dev);
 	ret = __pciehp_enable_slot(slot);
 	if (ret && ATTN_BUTTN(ctrl))
 		pciehp_green_led_off(slot); /* may be blinking */
+	pm_runtime_put(&ctrl->pcie->port->dev);
 
 	mutex_lock(&slot->lock);
 	slot->state = ret ? OFF_STATE : ON_STATE;
@@ -341,9 +344,12 @@ static int __pciehp_disable_slot(struct slot *p_slot)
 
 static int pciehp_disable_slot(struct slot *slot)
 {
+	struct controller *ctrl = slot->ctrl;
 	int ret;
 
+	pm_runtime_get_sync(&ctrl->pcie->port->dev);
 	ret = __pciehp_disable_slot(slot);
+	pm_runtime_put(&ctrl->pcie->port->dev);
 
 	mutex_lock(&slot->lock);
 	slot->state = OFF_STATE;
-- 
2.17.1
