Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f52.google.com ([209.85.219.52]:62038 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1160998Ab3BGSJI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 7 Feb 2013 13:09:08 -0500
Received: by mail-oa0-f52.google.com with SMTP id k14so3058339oag.25
        for <linux-pci@vger.kernel.org>; Thu, 07 Feb 2013 10:09:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20130207170020.289bac08@skate>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1359399397-29729-20-git-send-email-thomas.petazzoni@free-electrons.com>
 <5106F9F9.3010905@wwwdotorg.org> <20130129094143.1aad9377@skate>
 <20130129092006.GA16377@avionic-0098.mockup.avionic-design.de>
 <20130207112459.5f382ad4@skate> <CAErSpo7UOTGH7kjYBADymDdgmHwPxbXqczeXm1BH9C+XViQDRQ@mail.gmail.com>
 <20130207170020.289bac08@skate>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 7 Feb 2013 11:08:45 -0700
Message-ID: <CAErSpo797rhH=xt2x7eqdu7Vwf43FXoXQVcypvHM8-54LRC0wQ@mail.gmail.com>
Subject: Re: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP systems
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Thierry Reding <thierry.reding@avionic-design.de>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Jason Cooper <jason@lakedaemon.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Maen Suleiman <maen@marvell.com>, linux-pci@vger.kernel.org,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	linux-arm-kernel@lists.infradead.org,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 7, 2013 at 9:00 AM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> Dear Bjorn Helgaas,
>
> On Thu, 7 Feb 2013 08:46:06 -0700, Bjorn Helgaas wrote:
>
>> Can you post the entire dmesg log, ideally with CONFIG_PCI_DEBUG=y?
>> That should have more information about the enumeration process,
>> including what we think the XHCI BARs are and the apertures leading to
>> them.
>
> Sure, see below.
>
>> The PCI core assumes that we know the host bridge apertures up front,
>> and I'm not sure that is true on your platform, so maybe we'll need
>> some changes to accommodate that.
>
> In this hardware, we need to set up the address decoding windows. So
> there shouldn't be any access to a PCI device memory or I/O region
> until the addresses have been assigned in the PCI-to-PCI bridge.

I think this is the path where the crash happens (this is the same as
the backtrace you included below):

    mvebu_pcie_scan_bus
      pci_scan_root_bus
        pci_create_root_bus
        pci_scan_child_bus
        pci_bus_add_devices
          pci_bus_add_device
            pci_fixup_device(pci_fixup_final)
              quirk_usb_early_handoff           # pci_fixup_final
                quirk_usb_handoff_xhci

The problem is that we haven't assigned resources anywhere.  Normally
this is done by pci_bus_assign_resources() or
pci_assign_unassigned_bus_resources(), but I don't think there's
anything in the path above that does this.

This is not really a problem in your code; it's a generic PCI core
problem.  pci_scan_root_bus() does everything including creating the
root bus, scanning it, and adding the devices we find.  At the point
where we add a device (pci_bus_add_device()), it should be ready for a
driver to claim it -- all resource assignment should already be done.

I don't think it's completely trivial to fix this in the PCI core yet
(but we're moving in that direction) because we have some boot-time
ordering issues, e.g., x86 scans the root buses before we know about
the address space consumed by ACPI devices, so we can't just assign
the resources when we scan the bus.

I think the way you'll have to fix this in the meantime is to use
pci_create_root_bus() directly so you can do things in this sequence:

  pci_create_root_bus
  pci_scan_child_bus
  pci_bus_assign_resources
  pci_bus_add_devices

dino_probe() is an example of similar code that does this.

Bjorn
