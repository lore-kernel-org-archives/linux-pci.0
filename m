Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59538 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751714AbbEZVL4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 26 May 2015 17:11:56 -0400
Subject: [PATCH v2 2/2] ACPI / PCI: Account for ARI in _PRT lookups
From: Alex Williamson <alex.williamson@redhat.com>
To: linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, ddutile@redhat.com, rjw@rjwysocki.net,
	linux-kernel@vger.kernel.org, lenb@kernel.org
Date: Tue, 26 May 2015 15:11:51 -0600
Message-ID: <20150526211150.7537.42311.stgit@gimli.home>
In-Reply-To: <20150526210927.7537.55656.stgit@gimli.home>
References: <20150526210927.7537.55656.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The PCIe specification, rev 3.0, section 2.2.8.1, contains the
following implementation note:

    Virtual Wire Mapping for INTx Interrupts From ARI Devices

    The implied Device Number for an ARI Device is 0. When ARI-aware
    software (including BIOS and operating system) enables ARI
    Forwarding in the Downstream Port immediately above an ARI Device
    in order to access its Extended Functions, software must
    comprehend that the Downstream Port will use Device Number 0 for
    the virtual wire mappings of INTx interrupts coming from all
    Functions of the ARI Device. If non-ARI-aware software attempts
    to determine the virtual wire mappings for Extended Functions, it
    can come up with incorrect mappings by examining the traditional
    Device Number field and finding it to be non-0.

We account for this in pci_swizzle_interrupt_pin(), but it looks like
we miss it here, looking for a _PRT entry with a slot matching the
ARI device slot number.  This can cause errors like:

pcieport 0000:80:03.0: can't derive routing for PCI INT B
sfc 0000:82:01.1: PCI INT B: no GSI

pci_dev.irq is then invalid, resulting in errors for drivers that
attempt to enable INTx on the device.  Fix by using slot 0 for ARI
enabled devices.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/acpi/pci_irq.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index b1def41..4db10b1 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -163,7 +163,7 @@ static int acpi_pci_irq_check_entry(acpi_handle handle, struct pci_dev *dev,
 {
 	int segment = pci_domain_nr(dev->bus);
 	int bus = dev->bus->number;
-	int device = PCI_SLOT(dev->devfn);
+	int device = pci_ari_enabled(dev->bus) ? 0 : PCI_SLOT(dev->devfn);
 	struct acpi_prt_entry *entry;
 
 	if (((prt->address >> 16) & 0xffff) != device ||

