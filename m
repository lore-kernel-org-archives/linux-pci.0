Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, Mario.Limonciello@dell.com,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH v7 08/12] ACPI / hotplug / PCI: Mark stale PCI devices disconnected
Date: Thu, 17 May 2018 12:28:59 +0300
Message-Id: <20180517092903.43701-9-mika.westerberg@linux.intel.com>
In-Reply-To: <20180517092903.43701-1-mika.westerberg@linux.intel.com>
References: <20180517092903.43701-1-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Following PCIehp mark the unplugged PCI devices disconnected. This makes
sure PCI core code leaves the now missing hardware registers alone.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pci/hotplug/acpiphp_glue.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
index a8286058f490..db256bb2bd6a 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -649,6 +649,11 @@ static void trim_stale_devices(struct pci_dev *dev)
 		alive = pci_device_is_present(dev);
 
 	if (!alive) {
+		pci_dev_set_disconnected(dev, NULL);
+		if (pci_has_subordinate(dev))
+			pci_walk_bus(dev->subordinate, pci_dev_set_disconnected,
+				     NULL);
+
 		pci_stop_and_remove_bus_device(dev);
 		if (adev)
 			acpi_bus_trim(adev);
-- 
2.17.0

