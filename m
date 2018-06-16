Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.hostsharing.net ([83.223.90.233]:39297 "EHLO
        mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932667AbeFPTbd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Jun 2018 15:31:33 -0400
Message-Id: <e04667799c64b5f00f531d43d64da0eb4dfd21f4.1529173804.git.lukas@wunner.de>
In-Reply-To: <cover.1529173804.git.lukas@wunner.de>
References: <cover.1529173804.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sat, 16 Jun 2018 21:25:00 +0200
Subject: [PATCH 19/32] PCI: pciehp: Declare pciehp_enable/disable_slot()
 static
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Yinghai Lu <yinghai@kernel.org>, Sinan Kaya <okaya@kernel.org>,
        linux-pci@vger.kernel.org
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

No callers of pciehp_enable/disable_slot() outside of pciehp_ctrl.c
remain, so declare the functions static.  For now this requires forward
declarations.  Those can be eliminated by reshuffling functions once the
ongoing effort to refactor the driver has settled.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/hotplug/pciehp.h      | 2 --
 drivers/pci/hotplug/pciehp_ctrl.c | 7 +++++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index 5417180c3aff..9c75acd291fb 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -177,8 +177,6 @@ void pciehp_queue_pushbutton_work(struct work_struct *work);
 struct controller *pcie_init(struct pcie_device *dev);
 int pcie_init_notification(struct controller *ctrl);
 void pcie_shutdown_notification(struct controller *ctrl);
-int pciehp_enable_slot(struct slot *p_slot);
-int pciehp_disable_slot(struct slot *p_slot);
 void pcie_reenable_notification(struct controller *ctrl);
 int pciehp_power_on_slot(struct slot *slot);
 void pciehp_power_off_slot(struct slot *slot);
diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index 8ba937599fb3..4a12e70aacd0 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -122,6 +122,9 @@ static void remove_board(struct slot *p_slot)
 	pciehp_green_led_off(p_slot);
 }
 
+static int pciehp_enable_slot(struct slot *slot);
+static int pciehp_disable_slot(struct slot *slot);
+
 void pciehp_request(struct controller *ctrl, int action)
 {
 	atomic_or(action, &ctrl->pending_events);
@@ -308,7 +311,7 @@ static int __pciehp_enable_slot(struct slot *p_slot)
 	return board_added(p_slot);
 }
 
-int pciehp_enable_slot(struct slot *slot)
+static int pciehp_enable_slot(struct slot *slot)
 {
 	struct controller *ctrl = slot->ctrl;
 	int ret;
@@ -342,7 +345,7 @@ static int __pciehp_disable_slot(struct slot *p_slot)
 	return 0;
 }
 
-int pciehp_disable_slot(struct slot *slot)
+static int pciehp_disable_slot(struct slot *slot)
 {
 	int ret;
 
-- 
2.17.1
