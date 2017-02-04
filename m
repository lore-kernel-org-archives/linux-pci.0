Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.hostsharing.net ([83.223.95.204]:38573 "EHLO
        mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750876AbdBDSyX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 4 Feb 2017 13:54:23 -0500
Date: Sat, 4 Feb 2017 19:56:07 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: pciehp is broken from 4.10-rc1
Message-ID: <20170204185607.GA29957@wunner.de>
References: <CAE9FiQVCMCa7iVyuwp9z6VrY0cE7V_xghuXip28Ft52=8QmTWw@mail.gmail.com>
 <20170203055200.GA29413@wunner.de>
 <CAE9FiQWs0H9vqEo2ZYnWWBW0Ao-hx4WYHQ69cyR32nFQ9yV9rw@mail.gmail.com>
 <20170204081254.GA29595@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170204081254.GA29595@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Feb 04, 2017 at 09:12:54AM +0100, Lukas Wunner wrote:
> On Fri, Feb 03, 2017 at 11:00:19PM -0800, Yinghai Lu wrote:
> > we have extra Link Up event queued, while pm_runtime_get_sync/pm_runtime_put ?
> >   [  143.445483] pcieport 0000:60:03.2: PME# enabled
> >   [  143.992915] pciehp 0000:60:03.2:pcie004: Slot(8): Link Up
> 
> I notice that with 68db9bc81436 applied, PME is repeatedly enabled and
> disabled on the port, presumably whenever it switches from D3 to D0
> and vice-versa.
> 
> Perhaps this port sends an interrupt while PME is enabled and the slot
> is actually occupied, despite it having been disabled via sysfs.

Section 6.7.3.4 of the PCIe Base spec seems to support the theory above,
so here's a tentative patch.

Thanks,

Lukas

-- >8 --
Subject: [PATCH] PCI: pciehp: Don't enable PME on runtime suspend

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
 drivers/pci/pci.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index a881c0d..daf3c02 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2072,7 +2072,13 @@ int pci_finish_runtime_suspend(struct pci_dev *dev)
 
 	dev->runtime_d3cold = target_state == PCI_D3cold;
 
-	__pci_enable_wake(dev, target_state, true, pci_dev_run_wake(dev));
+	/*
+	 * Enable PME if dev can generate wakeup events at runtime, but not on
+	 * hotplug ports since PME signals unwanted interrupts if the slot is
+	 * occupied (PCIe Base Specification, section 6.7.3.4).
+	 */
+	__pci_enable_wake(dev, target_state, true, pci_dev_run_wake(dev) &&
+						   !dev->is_hotplug_bridge);
 
 	error = pci_set_power_state(dev, target_state);
 
-- 
2.11.0
