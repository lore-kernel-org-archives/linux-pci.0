Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.hostsharing.net ([83.223.90.233]:42761 "EHLO
        mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932788AbeFPTd6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Jun 2018 15:33:58 -0400
Message-Id: <d0939ab42589f950b8d606c1407c9228bf925a36.1529173804.git.lukas@wunner.de>
In-Reply-To: <cover.1529173804.git.lukas@wunner.de>
References: <cover.1529173804.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sat, 16 Jun 2018 21:25:00 +0200
Subject: [PATCH 26/32] PCI: pciehp: Obey compulsory command delay after resume
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Yinghai Lu <yinghai@kernel.org>, Sinan Kaya <okaya@kernel.org>,
        linux-pci@vger.kernel.org
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Upon resume from system sleep, the Slot Control register is written via:

  pci_pm_resume_noirq()
    pci_pm_default_resume_early()
      pci_restore_state()
        pci_restore_pcie_state()

PCIe r4.0, sec 6.7.3.2 says that after "issuing a write transaction that
targets any portion of the Port's Slot Control register, [...] software
must wait for [the] command to complete before issuing the next command".

pciehp currently fails to enforce that rule after the above-mentioned
write.  Fix it.

(Moving restoration of the Slot Control register to pciehp doesn't seem
to make sense because the other PCIe hotplug drivers may need it as
well.)

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/hotplug/pciehp_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index a5bd3b055c0e..3e73b12ed656 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -284,6 +284,10 @@ static int pciehp_resume_noirq(struct pcie_device *dev)
 	struct controller *ctrl = get_service_data(dev);
 	struct slot *slot = ctrl->slot;
 
+	/* pci_restore_state() just wrote to the Slot Control register */
+	ctrl->cmd_started = jiffies;
+	ctrl->cmd_busy = true;
+
 	/* clear spurious events from rediscovery of inserted card */
 	if (slot->state == ON_STATE || slot->state == BLINKINGOFF_STATE)
 		pcie_clear_hotplug_events(ctrl);
-- 
2.17.1
