Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:14374 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751663AbaGPDe6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 15 Jul 2014 23:34:58 -0400
Message-ID: <53C5F2C2.20707@linux.intel.com>
Date: Wed, 16 Jul 2014 11:34:26 +0800
From: Jiang Liu <jiang.liu@linux.intel.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Need advices about PCI IRQ reference count tracking
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,
	When enabling ACPI based IOAPIC hotplug, we encountered an
issue with PCI IRQ reference count tracking and need your advices.
	In order to hot-remove an IOAPIC, we need to track and keep
balance of IOAPIC pin usage count. But acpi_pci_irq_enable() may
be called twice for a PCI device,
1) pci_acpi_init() if pci_routeirq is true
2) pci_enable_device()

So in function acpi_pci_irq_enable(), we need a way to track whether
an IOAPIC IRQ has been assigned to the PCI device. Previously we check
"if (dev->irq > 0)" for that, but that's wrong because dev->irq may
be set to non-zero in pci_read_irq() if BIOS has already assigned
a legacy IRQ for the device. So is it OK to add a flag into pci_dev
to track this information?

Another possible workaround is to disable IOAPIC hotplug when
pci_routeirq is set, but that sounds not the best solution.

Regards!
Gerry
