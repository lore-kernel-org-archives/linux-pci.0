Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <yehezkel.bernat@intel.com>,
        Mario.Limonciello@dell.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/8] PCI: pciehp: Do not clear Presence Detect Changed during initialization
Date: Fri, 13 Oct 2017 21:35:47 +0300
Message-Id: <20171013183548.68283-8-mika.westerberg@linux.intel.com>
In-Reply-To: <20171013183548.68283-1-mika.westerberg@linux.intel.com>
References: <20171013183548.68283-1-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

It is possible that the hotplug event has already happened before the
driver is attached to a PCIe hotplug downstream port. If we just clear
the status we never get the hotplug interrupt and thus the event will be
missed.

To make sure that does not happen, we leave Presence Detect Changed bit
untouched during initialization. Then once the event is unmasked we get
an interrupt and handle the hotplug event properly.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/hotplug/pciehp_hpc.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 83c93f9da65a..bc1622aa7a05 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -862,11 +862,16 @@ struct controller *pcie_init(struct pcie_device *dev)
 	if (link_cap & PCI_EXP_LNKCAP_DLLLARC)
 		ctrl->link_active_reporting = 1;
 
-	/* Clear all remaining event bits in Slot Status register */
+	/*
+	 * Clear all remaining event bits in Slot Status register except
+	 * Presence Detect Changed. We want to make sure possible
+	 * hotplug event is triggered when the interrupt is unmasked so
+	 * that we don't lose that event.
+	 */
 	pcie_capability_write_word(pdev, PCI_EXP_SLTSTA,
 		PCI_EXP_SLTSTA_ABP | PCI_EXP_SLTSTA_PFD |
-		PCI_EXP_SLTSTA_MRLSC | PCI_EXP_SLTSTA_PDC |
-		PCI_EXP_SLTSTA_CC | PCI_EXP_SLTSTA_DLLSC);
+		PCI_EXP_SLTSTA_MRLSC | PCI_EXP_SLTSTA_CC |
+		PCI_EXP_SLTSTA_DLLSC);
 
 	ctrl_info(ctrl, "Slot #%d AttnBtn%c PwrCtrl%c MRL%c AttnInd%c PwrInd%c HotPlug%c Surprise%c Interlock%c NoCompl%c LLActRep%c\n",
 		(slot_cap & PCI_EXP_SLTCAP_PSN) >> 19,
-- 
2.14.2
