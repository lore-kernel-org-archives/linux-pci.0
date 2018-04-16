Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, Mario.Limonciello@dell.com,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH v5 7/9] PCI: Document return value of pci_scan_bridge() and pci_scan_bridge_extend()
Date: Mon, 16 Apr 2018 13:34:51 +0300
Message-Id: <20180416103453.46232-8-mika.westerberg@linux.intel.com>
In-Reply-To: <20180416103453.46232-1-mika.westerberg@linux.intel.com>
References: <20180416103453.46232-1-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

It is not immediately clear what the two functions actually return so
add kernel-doc comment explaining it a bit better.

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pci/probe.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 7c34a2ccb514..30a895bd9839 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -998,6 +998,8 @@ static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
  * already configured by the BIOS and after we are done with all of
  * them, we proceed to assigning numbers to the remaining buses in
  * order to avoid overlaps between old and new bus numbers.
+ *
+ * Return: New subordinate number covering all buses behind this bridge.
  */
 static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 				  int max, unsigned int available_buses,
@@ -1230,6 +1232,8 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
  * already configured by the BIOS and after we are done with all of
  * them, we proceed to assigning numbers to the remaining buses in
  * order to avoid overlaps between old and new bus numbers.
+ *
+ * Return: New subordinate number covering all buses behind this bridge.
  */
 int pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max, int pass)
 {
-- 
2.16.3

