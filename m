Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.hostsharing.net ([83.223.95.204]:50419 "EHLO
        mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750937AbdBFFyi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Feb 2017 00:54:38 -0500
Message-Id: <d1ae979d256631e7c189694a6d3e1a518abf3fc8.1486359844.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Mon, 6 Feb 2017 06:54:37 +0100
Subject: [PATCH v2] PCI: pciehp: Don't enable PME on runtime suspend
To: Bjorn Helgaas <bhelgaas@google.com>,
        Yinghai Lu <yinghai@kernel.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Since commit 68db9bc81436 ("PCI: pciehp: Add runtime PM support for PCIe
hotplug ports") we runtime suspend a hotplug port to D3hot when all its
children are runtime suspended or none are present.

When runtime suspending the port the PCI core automatically enables PME:
    pci_pm_runtime_suspend()
        pci_finish_runtime_suspend()
            __pci_enable_wake()

According to the PCI Express Base Specification, section 6.7.3.4:
   "Note that PME and Hot-Plug Event interrupts (when both are
    implemented) always share the same MSI or MSI-X vector [...]
    If wake generation is required by the associated form factor
    specification, a hot-plug capable Downstream Port must support
    generation of a wakeup event (using the PME mechanism) on hotplug
    events that occur when the system is in a sleep state or the Port
    is in device state D1, D2, or D3Hot."

Thus, if the port is runtime suspended even though it is still occupied,
it may immediately be woken by a PME interrupt.  One scenario where this
happens is if all children of the hotplug port have runtime suspended.
Another scenario is power control via sysfs:  If a user manually turns
the hotplug port off (e.g. to safely remove the card), PME will signal
an interrupt for the still-occupied slot, which is interpreted by pciehp
as re-insertion of a card.  As a result, power control via sysfs is no
longer possible.  This was observed and reported by Yinghai Lu.

PME is in fact unnecessary on hotplug ports:  Hotplug can be signaled
even in D3hot, and commit 68db9bc81436 ensures that all parents of the
hotplug port are kept awake so that interrupts can be delivered.
PME would allow us to runtime suspend the parent ports as well, but we
do not make use of it because we cannot be sure if PME actually works.
Thunderbolt controllers for instance advertise PME capability, but at
least on Macs the PME pin is not connected.

Since we do not rely on PME for hotplug ports, we may as well not enable
it, thereby avoiding its negative side effects.  However the present
commit deliberately only avoids enabling PME on runtime suspend, the
ability to enable it for system sleep is retained.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=193951
Fixes: 68db9bc81436 ("PCI: pciehp: Add runtime PM support for PCIe
    hotplug ports")
Reported-by: Yinghai Lu <yinghai@kernel.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---

v1-> v2:
 Move check for is_hotplug_bridge from pci_finish_runtime_suspend()
 down into pci_dev_run_wake(), this seems cleaner, less clumsy.

 drivers/pci/pci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index a881c0d..9c22e62 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2096,6 +2096,14 @@ bool pci_dev_run_wake(struct pci_dev *dev)
 {
 	struct pci_bus *bus = dev->bus;
 
+	/*
+	 * Don't enable PME at runtime on hotplug ports (even if supported)
+	 * since PME sends unwanted interrupts if the slot is occupied while
+	 * suspended to D3hot (PCIe Base Specification, section 6.7.3.4).
+	 */
+	if (dev->is_hotplug_bridge)
+		return false;
+
 	if (device_run_wake(&dev->dev))
 		return true;
 
-- 
2.11.0
