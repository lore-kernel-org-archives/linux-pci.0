Return-Path: <stern+581ae0c0@rowland.harvard.edu>
Return-Path: <stern+581ae0c0@rowland.harvard.edu>
Date: Fri, 21 Oct 2016 16:45:38 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Bjorn Helgaas <helgaas@kernel.org>
cc: Lukas Wunner <lukas@wunner.de>, Pierre de Villemereuil <flyos@mailoo.org>,
     <linux-pci@vger.kernel.org>, USB list <linux-usb@vger.kernel.org>
Subject: [PATCH 1/2] PCI: check for PME in targeted sleep state
Message-ID: <Pine.LNX.4.44L0.1610211640150.1898-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-pci.vger.kernel.org>

One some systems, the firmware does not allow certain PCI devices to
be put in deep D-states.  This can cause problems for wakeup
signalling, if the device does not support PME# in the deepest allowed
suspend state.  For example, Pierre reports that on his system, ACPI
does not permit his xHCI host controller to go into D3 during runtime
suspend -- but D3 is the only state in which the controller can generate
PME# signals.  As a result, the controller goes into runtime suspend
but never wakes up, so it doesn't work properly.  USB devices plugged
into the controller are never detected.

If the device relies on PME# for wakeup signals but is not capable of
generating PME# in the target state, the PCI core should accurately
report that it cannot do wakeup from runtime suspend.  This patch
modifies the pci_dev_run_wake() routine to add this check.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
CC: Lukas Wunner <lukas@wunner.de>
Reported-by: Pierre de Villemereuil <flyos@mailoo.org>
Tested-by: Pierre de Villemereuil <flyos@mailoo.org>
CC: <stable@vger.kernel.org>

---

[as1814]


 drivers/pci/pci.c |    4 ++++
 1 file changed, 4 insertions(+)

Index: usb-4.x/drivers/pci/pci.c
===================================================================
--- usb-4.x.orig/drivers/pci/pci.c
+++ usb-4.x/drivers/pci/pci.c
@@ -2064,6 +2064,10 @@ bool pci_dev_run_wake(struct pci_dev *de
 	if (!dev->pme_support)
 		return false;
 
+	/* PME-capable in principle, but not from the intended sleep state */
+	if (!pci_pme_capable(dev, pci_target_state(dev)))
+		return false;
+
 	while (bus->parent) {
 		struct pci_dev *bridge = bus->self;
 
