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
Subject: [PATCH v7 05/12] PCI: hotplug: Convert SHPC to be builtin only
Date: Thu, 17 May 2018 12:28:56 +0300
Message-Id: <20180517092903.43701-6-mika.westerberg@linux.intel.com>
In-Reply-To: <20180517092903.43701-1-mika.westerberg@linux.intel.com>
References: <20180517092903.43701-1-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We need to be able coordinate between SHPC and acpiphp in order to
determine which driver handles hotplug of a given bridge. Because
acpiphp is already bool convert SHPC to be bool as well.

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pci/hotplug/Kconfig | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/pci/hotplug/Kconfig b/drivers/pci/hotplug/Kconfig
index a8f21d051e0c..e9f78eb390d2 100644
--- a/drivers/pci/hotplug/Kconfig
+++ b/drivers/pci/hotplug/Kconfig
@@ -104,14 +104,11 @@ config HOTPLUG_PCI_CPCI_GENERIC
 	  When in doubt, say N.
 
 config HOTPLUG_PCI_SHPC
-	tristate "SHPC PCI Hotplug driver"
+	bool "SHPC PCI Hotplug driver"
 	help
 	  Say Y here if you have a motherboard with a SHPC PCI Hotplug
 	  controller.
 
-	  To compile this driver as a module, choose M here: the
-	  module will be called shpchp.
-
 	  When in doubt, say N.
 
 config HOTPLUG_PCI_POWERNV
-- 
2.17.0

