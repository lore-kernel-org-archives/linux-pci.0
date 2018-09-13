Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Mario.Limonciello@dell.com,
        Anthony Wong <anthony.wong@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH v2 07/10] PCI: pciehp: Implement runtime PM callbacks
Date: Thu, 13 Sep 2018 17:33:19 +0300
Message-Id: <20180913143322.77953-8-mika.westerberg@linux.intel.com>
In-Reply-To: <20180913143322.77953-1-mika.westerberg@linux.intel.com>
References: <20180913143322.77953-1-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Basically we need to do the same thing when runtime suspending than with
system sleep so re-use those operations here. This makes sure hotplug
interrupt does not trigger immediately when the link goes down.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pci/hotplug/pciehp_core.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index 940c64fdcaae..203610478d55 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -312,6 +312,23 @@ static int pciehp_resume(struct pcie_device *dev)
 
 	return 0;
 }
+
+static int pciehp_runtime_resume(struct pcie_device *dev)
+{
+	struct controller *ctrl = get_service_data(dev);
+	struct slot *slot = ctrl->slot;
+
+	/* pci_restore_state() just wrote to the Slot Control register */
+	ctrl->cmd_started = jiffies;
+	ctrl->cmd_busy = true;
+
+	/* clear spurious events from rediscovery of inserted card */
+	if ((slot->state == ON_STATE || slot->state == BLINKINGOFF_STATE) &&
+	     pme_is_native(dev))
+		pcie_clear_hotplug_events(ctrl);
+
+	return pciehp_resume(dev);
+}
 #endif /* PM */
 
 static struct pcie_port_service_driver hpdriver_portdrv = {
@@ -326,6 +343,8 @@ static struct pcie_port_service_driver hpdriver_portdrv = {
 	.suspend	= pciehp_suspend,
 	.resume_noirq	= pciehp_resume_noirq,
 	.resume		= pciehp_resume,
+	.runtime_suspend = pciehp_suspend,
+	.runtime_resume	= pciehp_runtime_resume,
 #endif	/* PM */
 };
 
-- 
2.18.0
