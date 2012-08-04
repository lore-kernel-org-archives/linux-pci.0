Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: [Resend][PATCH] PCI / PM: Fix messages printed by acpi_pci_set_power_state()
Date: Sat, 4 Aug 2012 23:27:32 +0200
Cc: Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Linux PM list <linux-pm@vger.kernel.org>,
	linux-pci@vger.kernel.org,
	ACPI Devel Mailing List <linux-acpi@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201208042327.33132.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


If a PCI device is put into D3_cold by acpi_bus_set_power(),
the message printed by acpi_pci_set_power_state() says that its
power state has been changed to D4, which doesn't make sense.
In turn, if the device is put into D3_hot, the message simply
says "D3" without specifying the variant of the D3 state.

Fix this by using the pci_power_name() macro for printing the state
name instead of building it from the numeric value corresponding to
the given state directly.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/pci/pci-acpi.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux/drivers/pci/pci-acpi.c
===================================================================
--- linux.orig/drivers/pci/pci-acpi.c
+++ linux/drivers/pci/pci-acpi.c
@@ -266,8 +266,8 @@ static int acpi_pci_set_power_state(stru
 	}
 
 	if (!error)
-		dev_printk(KERN_INFO, &dev->dev,
-				"power state changed by ACPI to D%d\n", state);
+		dev_info(&dev->dev, "power state changed by ACPI to %s\n",
+			 pci_power_name(state));
 
 	return error;
 }
