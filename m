Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:11578 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757305AbeEJS2x (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 May 2018 14:28:53 -0400
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
Subject: [PATCH v6 10/12] PCI: Document return value of pci_scan_bridge() and pci_scan_bridge_extend()
Date: Thu, 10 May 2018 21:28:42 +0300
Message-Id: <20180510182844.77349-11-mika.westerberg@linux.intel.com>
In-Reply-To: <20180510182844.77349-1-mika.westerberg@linux.intel.com>
References: <20180510182844.77349-1-mika.westerberg@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
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
index cd28ab122748..a0c48aa1c42f 100644
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
@@ -1231,6 +1233,8 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
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
