Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.hostsharing.net ([83.223.95.204]:48475 "EHLO
        mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932667AbeFPTby (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Jun 2018 15:31:54 -0400
Message-Id: <c48e201894c0bd92a9c13dc04056ed08cf4abe6d.1529173804.git.lukas@wunner.de>
In-Reply-To: <cover.1529173804.git.lukas@wunner.de>
References: <cover.1529173804.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sat, 16 Jun 2018 21:25:00 +0200
Subject: [PATCH 20/32] PCI: pciehp: Tolerate initially unstable link
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Yinghai Lu <yinghai@kernel.org>, Sinan Kaya <okaya@kernel.org>,
        linux-pci@vger.kernel.org, Stefan Roese <sr@denx.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When a device is hotplugged, Presence Detect and Link Up events often do
not occur simultaneously, but with a lag of a few milliseconds.  Only
the first event received is relevant, the other one can be disregarded.

Moreover, Stefan Roese reports that on certain platforms, Link State and
Presence Detect may flap for up to 100 ms before stabilizing, suggesting
that such events should be disregarded for at least this long:
https://patchwork.ozlabs.org/patch/867418/

On slot enablement, pciehp_check_link_status() waits for 100 ms per
PCIe r4.0, sec 6.7.3.3, then probes the hotplugged device's vendor
register for up to 1 second.

If this succeeds, the link is definitely up, so ignore any Presence
Detect or Link State events that occurred up to this point.

pciehp_check_link_status() then checks the Link Training bit in the
Link Status register.  This is the final opportunity to detect
inaccessibility of the device and abort slot enablement.  Any link
or presence change that occurs afterwards will cause the slot to be
disabled again immediately after attempting to enable it.

The astute reviewer may appreciate that achieving this behavior would be
more complicated had pciehp not just been converted to enable/disable
the slot exclusively from the IRQ thread:  When the slot is enabled via
sysfs, each link or presence flap would otherwise cause the IRQ thread
to run and it would have to sense that those events are belonging to a
concurrent slot enablement operation and disregard them.  It would be
much more difficult than this mere 3 line change.

Cc: Stefan Roese <sr@denx.de>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/hotplug/pciehp_hpc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index c795d32dbb73..adc6a89a3b5d 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -270,6 +270,11 @@ int pciehp_check_link_status(struct controller *ctrl)
 	found = pci_bus_check_dev(ctrl->pcie->port->subordinate,
 					PCI_DEVFN(0, 0));
 
+	/* ignore link or presence changes up to this point */
+	if (found)
+		atomic_and(~(PCI_EXP_SLTSTA_DLLSC | PCI_EXP_SLTSTA_PDC),
+			   &ctrl->pending_events);
+
 	pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
 	ctrl_dbg(ctrl, "%s: lnk_status = %x\n", __func__, lnk_status);
 	if ((lnk_status & PCI_EXP_LNKSTA_LT) ||
-- 
2.17.1
