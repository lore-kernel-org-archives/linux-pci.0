Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:12505 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757764Ab3GOO5y (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 15 Jul 2013 10:57:54 -0400
From: Prarit Bhargava <prarit@redhat.com>
To: linux-acpi@vger.kernel.org
Cc: Prarit Bhargava <prarit@redhat.com>, Len Brown <lenb@kernel.org>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	"Bjorn Helgaas" <bhelgaas@google.com>,
	"Myron Stowe" <mstowe@redhat.com>, linux-pci@vger.kernel.org
Subject: [PATCH] acpi, acpi_pci_irq_enable must return an error if ACPI cannot map an IRQ.
Date: Mon, 15 Jul 2013 10:57:40 -0400
Message-Id: <1373900260-1599-1-git-send-email-prarit@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Driver probe's currently do the following

	pci_enable_device();
	/* ... do some other init stuff, and eventually call ... */
	request_irq();

After pci_enable_device() is called it is assumed that the device's irq
value (pci_dev->irq) has been appropriately set on success.  This value
is passed into the request_irq() call.

In the case that ACPI is used to determine the irq value, it is possible
that the ACPI IRQ look up for a specific device fails and success is
returned by pci_enable_device().

The call sequence is:

pci_enable_device();
	-> pci_enable_device_flags();
		->do_pci_enable_device();
			-> pcibios_enable_device() which, if the device
			   does not use MSI calls
			   -> pcibios_enable_irq() which maps to
			      acpi_pci_irq_enable()
				-> acpi_pci_irq_lookup()

If acpi_pci_irq_lookup() cannot map the device's IRQ value it returns NULL
as an error.  The error is returned to acpi_pci_irq_enable(), but is not
propagated further.  This can result in the driver returning success for
pci_enable_device() and the driver probe attempting to call request_irq()
with dev->irq = 0.

This patch modifies acpi_pci_irq_enable() to return an error in the case
that an entry is not found in the ACPI tables.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Cc: Len Brown <lenb@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "Bjorn Helgaas" <bhelgaas@google.com>
Cc: "Myron Stowe" <mstowe@redhat.com>
Cc: linux-pci@vger.kernel.org
---
 drivers/acpi/pci_irq.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index 41c5e1b..9681847 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -430,6 +430,7 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
 		} else {
 			dev_warn(&dev->dev, "PCI INT %c: no GSI\n",
 				 pin_name(pin));
+			return -ENOENT;
 		}
 
 		return 0;
-- 
1.7.9.3

