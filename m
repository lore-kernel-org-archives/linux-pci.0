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
Subject: [PATCH v8 7/7] PCI: Document return value of pci_scan_bridge() and pci_scan_bridge_extend()
Date: Mon, 28 May 2018 15:47:56 +0300
Message-Id: <20180528124756.78512-8-mika.westerberg@linux.intel.com>
In-Reply-To: <20180528124756.78512-1-mika.westerberg@linux.intel.com>
References: <20180528124756.78512-1-mika.westerberg@linux.intel.com>
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
index 8f384e7ca2c2..7dc0b3c49941 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -999,6 +999,8 @@ static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
  * already configured by the BIOS and after we are done with all of
  * them, we proceed to assigning numbers to the remaining buses in
  * order to avoid overlaps between old and new bus numbers.
+ *
+ * Return: New subordinate number covering all buses behind this bridge.
  */
 static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 				  int max, unsigned int available_buses,
@@ -1226,6 +1228,8 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
  * already configured by the BIOS and after we are done with all of
  * them, we proceed to assigning numbers to the remaining buses in
  * order to avoid overlaps between old and new bus numbers.
+ *
+ * Return: New subordinate number covering all buses behind this bridge.
  */
 int pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max, int pass)
 {
-- 
2.17.0

