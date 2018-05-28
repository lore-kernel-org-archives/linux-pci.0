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
Subject: [PATCH v8 3/7] PCI: Introduce hotplug_is_native()
Date: Mon, 28 May 2018 15:47:52 +0300
Message-Id: <20180528124756.78512-4-mika.westerberg@linux.intel.com>
In-Reply-To: <20180528124756.78512-1-mika.westerberg@linux.intel.com>
References: <20180528124756.78512-1-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This helper function can be used for finding out whether the OS is
supposed to handle native hotplug of a given bridge.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 include/linux/pci_hotplug.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/pci_hotplug.h b/include/linux/pci_hotplug.h
index 4c378368215c..cf5e22103f68 100644
--- a/include/linux/pci_hotplug.h
+++ b/include/linux/pci_hotplug.h
@@ -181,4 +181,9 @@ static inline int acpi_get_hp_hw_control_from_firmware(struct pci_dev *bridge)
 static inline bool pciehp_is_native(struct pci_dev *bridge) { return true; }
 static inline bool shpchp_is_native(struct pci_dev *bridge) { return true; }
 #endif
+
+static inline bool hotplug_is_native(struct pci_dev *bridge)
+{
+	return pciehp_is_native(bridge) || shpchp_is_native(bridge);
+}
 #endif
-- 
2.17.0

