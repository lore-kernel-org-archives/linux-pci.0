Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.hostsharing.net ([176.9.242.54]:48289 "EHLO
        mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423525AbdEAMJO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 May 2017 08:09:14 -0400
Message-Id: <034551c3f3a60caf8b1f8b2a2abaf7bb3e0696a5.1493631639.git.lukas@wunner.de>
In-Reply-To: <cover.1493631639.git.lukas@wunner.de>
References: <cover.1493631639.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Mon, 1 May 2017 14:06:39 +0200
Subject: [PATCH 2/5] PCI: pciehp: Remain in D0 while awaiting command
 completion
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

Hotplug controllers may signal an interrupt after a command written to
the Slot Control register completes (PCIe r3.1, sec 6.7.3.2).

If the controller happens to be in D3hot and is PME capable, this
Command Complete interrupt triggers a wakeup to D0 because:

(a) PME is the only valid operation that can be initiated by the
    function when in D3hot (PCI PM r1.2, table 5-4, though Thunderbolt
    controllers do not adhere to this rule).

(b) Hotplug events (including command completion) occurring in D3hot
    cause "generation of a wakeup event (using the PME mechanism)"
    (PCIe r3.1, sec 6.7.3.4).

When writing to the Slot Control register, we've resumed the controller
to D0 (see the call sites of pcie_write_cmd and pcie_write_cmd_nowait).
It's silly to let it go to D3hot afterwards if we know that it will be
resumed to D0 once the command completes.  Thus, hold a runtime PM ref
while awaiting command completion.  In the "nowait" case, schedule
runtime suspend after 1 second, which is the time limit for execution of
commands (PCIe r3.1, sec 6.7.3.2).

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
 drivers/pci/hotplug/pciehp_hpc.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 026830a138ae..143e2143d62e 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -34,6 +34,7 @@
 #include <linux/jiffies.h>
 #include <linux/timer.h>
 #include <linux/pci.h>
+#include <linux/pm_runtime.h>
 #include <linux/interrupt.h>
 #include <linux/time.h>
 #include <linux/slab.h>
@@ -201,6 +202,7 @@ static void pcie_do_write_cmd(struct controller *ctrl, u16 cmd,
 	slot_ctrl |= (cmd & mask);
 	ctrl->cmd_busy = 1;
 	smp_mb();
+	pm_runtime_get_sync(&pdev->dev);
 	pcie_capability_write_word(pdev, PCI_EXP_SLTCTL, slot_ctrl);
 	ctrl->cmd_started = jiffies;
 	ctrl->slot_ctrl = slot_ctrl;
@@ -209,8 +211,13 @@ static void pcie_do_write_cmd(struct controller *ctrl, u16 cmd,
 	 * Optionally wait for the hardware to be ready for a new command,
 	 * indicating completion of the above issued command.
 	 */
-	if (wait)
+	if (wait) {
 		pcie_wait_cmd(ctrl);
+		pm_runtime_put(&pdev->dev);
+	} else {
+		pm_runtime_put_noidle(&pdev->dev);
+		pm_schedule_suspend(&pdev->dev, 1000);
+	}
 
 out:
 	mutex_unlock(&ctrl->ctrl_lock);
-- 
2.11.0
