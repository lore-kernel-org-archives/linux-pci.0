Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.hostsharing.net ([176.9.242.54]:32917 "EHLO
        mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932554AbeFPTcf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Jun 2018 15:32:35 -0400
Message-Id: <617e37a86150a1f5dec684217596e879718f5d33.1529173804.git.lukas@wunner.de>
In-Reply-To: <cover.1529173804.git.lukas@wunner.de>
References: <cover.1529173804.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sat, 16 Jun 2018 21:25:00 +0200
Subject: [PATCH 22/32] PCI: pciehp: Always enable occupied slot on probe
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Yinghai Lu <yinghai@kernel.org>, Sinan Kaya <okaya@kernel.org>,
        linux-pci@vger.kernel.org
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Per PCIe r4.0, sec 6.7.3.4, a "port may optionally send an MSI when
there are hot-plug events that occur while interrupt generation is
disabled, and interrupt generation is subsequently enabled."

On probe, we currently clear all event bits in the Slot Status register
with the notable exception of the Presence Detect Changed bit.  Thereby
we seek to receive an interrupt for an already occupied slot once event
notification is enabled.

But because the interrupt is optional, users may have to specify the
pciehp_force parameter on the command line, which is inconvenient.

Moreover, now that pciehp's event handling has become resilient to
missed events, a Presence Detect Changed interrupt for a slot which is
powered on is interpreted as removal of the card.  If the slot has
already been brought up by the BIOS, receiving such an interrupt on
probe causes the slot to be powered off and immediately back on, which
is likewise undesirable.

Avoid both issues by making the behavior of pciehp_force the default and
clearing the Presence Detect Changed bit on probe.

Note that the stated purpose of pciehp_force per the MODULE_PARM_DESC
("Force pciehp, even if OSHP is missing") seems nonsensical because the
OSHP control method is only relevant for SHCP slots according to the
PCI Firmware specification r3.0, sec 4.8.

Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/hotplug/pciehp_core.c | 12 ++++--------
 drivers/pci/hotplug/pciehp_hpc.c  |  9 ++-------
 2 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index b11f0db0695f..f4eaa9944699 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -30,7 +30,6 @@
 bool pciehp_debug;
 bool pciehp_poll_mode;
 int pciehp_poll_time;
-static bool pciehp_force;
 
 /*
  * not really modular, but the easiest way to keep compat with existing
@@ -39,11 +38,9 @@ static bool pciehp_force;
 module_param(pciehp_debug, bool, 0644);
 module_param(pciehp_poll_mode, bool, 0644);
 module_param(pciehp_poll_time, int, 0644);
-module_param(pciehp_force, bool, 0644);
 MODULE_PARM_DESC(pciehp_debug, "Debugging mode enabled or not");
 MODULE_PARM_DESC(pciehp_poll_mode, "Using polling mechanism for hot-plug events or not");
 MODULE_PARM_DESC(pciehp_poll_time, "Polling mechanism frequency, in seconds");
-MODULE_PARM_DESC(pciehp_force, "Force pciehp, even if OSHP is missing");
 
 #define PCIE_MODULE_NAME "pciehp"
 
@@ -243,11 +240,10 @@ static int pciehp_probe(struct pcie_device *dev)
 	mutex_lock(&slot->lock);
 	pciehp_get_adapter_status(slot, &occupied);
 	pciehp_get_power_status(slot, &poweron);
-	if (pciehp_force &&
-	    ((occupied && (slot->state == OFF_STATE ||
-			   slot->state == BLINKINGON_STATE)) ||
-	     (!occupied && (slot->state == ON_STATE ||
-			    slot->state == BLINKINGOFF_STATE))))
+	if ((occupied && (slot->state == OFF_STATE ||
+			  slot->state == BLINKINGON_STATE)) ||
+	    (!occupied && (slot->state == ON_STATE ||
+			   slot->state == BLINKINGOFF_STATE)))
 		pciehp_request(ctrl, PCI_EXP_SLTSTA_PDC);
 	/* If empty slot's power status is on, turn power off */
 	if (!occupied && poweron && POWER_CTRL(ctrl))
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index b746c3b52719..3c0adf4967a8 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -843,16 +843,11 @@ struct controller *pcie_init(struct pcie_device *dev)
 	if (link_cap & PCI_EXP_LNKCAP_DLLLARC)
 		ctrl->link_active_reporting = 1;
 
-	/*
-	 * Clear all remaining event bits in Slot Status register except
-	 * Presence Detect Changed. We want to make sure possible
-	 * hotplug event is triggered when the interrupt is unmasked so
-	 * that we don't lose that event.
-	 */
+	/* Clear all remaining event bits in Slot Status register. */
 	pcie_capability_write_word(pdev, PCI_EXP_SLTSTA,
 		PCI_EXP_SLTSTA_ABP | PCI_EXP_SLTSTA_PFD |
 		PCI_EXP_SLTSTA_MRLSC | PCI_EXP_SLTSTA_CC |
-		PCI_EXP_SLTSTA_DLLSC);
+		PCI_EXP_SLTSTA_DLLSC | PCI_EXP_SLTSTA_PDC);
 
 	ctrl_info(ctrl, "Slot #%d AttnBtn%c PwrCtrl%c MRL%c AttnInd%c PwrInd%c HotPlug%c Surprise%c Interlock%c NoCompl%c LLActRep%c%s\n",
 		(slot_cap & PCI_EXP_SLTCAP_PSN) >> 19,
-- 
2.17.1
