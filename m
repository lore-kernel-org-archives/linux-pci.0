Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Aaron Lu <aaron.lu@intel.com>
Subject: [PATCH 2/4] PCI / ACPI: Use acpi_find_child_device() for child devices lookup
Date: Mon, 25 Nov 2013 01:12:10 +0100
Message-ID: <1827111.PaqOm34rfO@vostro.rjw.lan>
In-Reply-To: <2610478.KxPMyuOMok@vostro.rjw.lan>
References: <2610478.KxPMyuOMok@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

It is much more efficient to use acpi_find_child_device()
for child devices lookup in acpi_pci_find_device() and pass
ACPI_COMPANION(dev->parent) to it directly instead of obtaining
ACPI_HANDLE() of ACPI_COMPANION(dev->parent) and passing it to
acpi_find_child() which has to run acpi_bus_get_device() to
obtain ACPI_COMPANION(dev->parent) from that again.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pci/pci-acpi.c |   16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

Index: linux-pm/drivers/pci/pci-acpi.c
===================================================================
--- linux-pm.orig/drivers/pci/pci-acpi.c
+++ linux-pm/drivers/pci/pci-acpi.c
@@ -309,7 +309,8 @@ void acpi_pci_remove_bus(struct pci_bus
 static int acpi_pci_find_device(struct device *dev, acpi_handle *handle)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
-	bool is_bridge;
+	struct acpi_device *adev;
+	bool check_children;
 	u64 addr;
 
 	/*
@@ -317,14 +318,17 @@ static int acpi_pci_find_device(struct d
 	 * is set only after acpi_pci_find_device() has been called for the
 	 * given device.
 	 */
-	is_bridge = pci_dev->hdr_type == PCI_HEADER_TYPE_BRIDGE
+	check_children = pci_dev->hdr_type == PCI_HEADER_TYPE_BRIDGE
 			|| pci_dev->hdr_type == PCI_HEADER_TYPE_CARDBUS;
 	/* Please ref to ACPI spec for the syntax of _ADR */
 	addr = (PCI_SLOT(pci_dev->devfn) << 16) | PCI_FUNC(pci_dev->devfn);
-	*handle = acpi_find_child(ACPI_HANDLE(dev->parent), addr, is_bridge);
-	if (!*handle)
-		return -ENODEV;
-	return 0;
+	adev = acpi_find_child_device(ACPI_COMPANION(dev->parent), addr,
+				      check_children);
+	if (adev) {
+		*handle = adev->handle;
+		return 0;
+	}
+	return -ENODEV;
 }
 
 static void pci_acpi_setup(struct device *dev)

