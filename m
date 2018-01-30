Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:58107 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751886AbeA3K2n (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Jan 2018 05:28:43 -0500
Date: Tue, 30 Jan 2018 12:28:40 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Stefan Roese <sr@denx.de>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [RFC PATCH] PCI: pciehp: Add module parameter to enable
 debouncing of HP link events
Message-ID: <20180130102840.GF27654@lahna.fi.intel.com>
References: <20180130084121.18653-1-sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180130084121.18653-1-sr@denx.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 30, 2018 at 09:41:21AM +0100, Stefan Roese wrote:
> Hotplugging of some PCIe devices on our platform sometimes leads to a
> bounce of link-up and link-down events, resulting in problems in the
> corresponding PCI drivers.
> 
> Here an example of such a hotplug event bounce for a AHCI PCIe card:
> ...
> pciehp 0000:00:1c.1:pcie004: Slot(1): Card present
> pciehp 0000:00:1c.1:pcie004: Slot(1): Link Up
> pciehp 0000:00:1c.1:pcie004: Slot(1): Link Up event ignored; already powering on
> pciehp 0000:00:1c.1:pcie004: Slot(1): Link Down
> pciehp 0000:00:1c.1:pcie004: Slot(1): Card present
> pciehp 0000:00:1c.1:pcie004: Slot(1): Link Up

It would be good to find out why this happens in the first place.
Perhaps there is some environmental interference or something causing
this?

> pci 0000:02:00.0: [1b4b:9215] type 00 class 0x010601
> pci 0000:02:00.0: reg 0x10: [io  0x8000-0x8007]
> ...
> ata3: SATA max UDMA/133 abar m2048@0x80910000 port 0x80910100 irq 100
> ata4: SATA max UDMA/133 abar m2048@0x80910000 port 0x80910180 irq 100
> ata5: SATA max UDMA/133 abar m2048@0x80910000 port 0x80910200 irq 100
> ata6: SATA max UDMA/133 abar m2048@0x80910000 port 0x80910280 irq 100
> pciehp 0000:00:1c.1:pcie004: Slot(1): Link Up event ignored; already powering on
> ahci 0000:02:00.0: PME# disabled
> ata3: SATA link down (SStatus 0 SControl 300)
> ata5: SATA link down (SStatus 0 SControl 300)
> ata4: SATA link down (SStatus 0 SControl 300)
> WARNING: CPU: 2 PID: 1162 at drivers/ata/libata-core.c:6620 ata_host_detach+0x125/0x130

I think the AHCI driver should be fixed to cope with this.

> ata6: SATA link down (SStatus 0 SControl 300)
> Modules linked in:
> CPU: 2 PID: 1162 Comm: kworker/u8:5 Not tainted 4.15.0+ #26
> Hardware name: congatec conga-qeval20-qa3-e3845/conga-qeval20-qa3-e3845, BIOS 2018.01-00033-g0125f37185-dirty 01/18/2018
> Workqueue: pciehp-1 pciehp_power_thread
> ...
> 
> This patch now adds the 'pciehp_debounce_time' module parameter, which
> can be used to drop all events for the specified time (in milliseconds)
> after a link-up event occurred. A value of ~100ms works fine in my tests
> to debounce all the link-up / link-down events in my tests.

This sounds a bit "hackish". I would rather make sure we can handle
situations like this properly without passing additional parameters.
