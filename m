Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:34253 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751480AbaGPWAt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 16 Jul 2014 18:00:49 -0400
Received: by mail-ig0-f180.google.com with SMTP id l13so1636532iga.13
        for <linux-pci@vger.kernel.org>; Wed, 16 Jul 2014 15:00:49 -0700 (PDT)
Date: Wed, 16 Jul 2014 16:00:46 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Matthew Minter <matthew_minter@xyratex.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH RFC] Added code to ensure hot-added PCI devices are given
 an IRQ on rescan
Message-ID: <20140716220046.GD14366@google.com>
References: <CAFJTrDt146269JkQ7eRcgGxk=4EEQ2XK+Rbe11Y+6URr=LQzrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAFJTrDt146269JkQ7eRcgGxk=4EEQ2XK+Rbe11Y+6URr=LQzrA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 10, 2014 at 04:47:55PM +0100, Matthew Minter wrote:
> Some boards which contain physically hot-pluggable PCIe slots such as
> 8639 connectors can hot-add devices simply by connecting them while up
> and writing to /sys/bus/pci/rescan.

This is a tangent, but I'm curious about this part of the hotplug
process.  Since this is PCIe, I assume the switch leading to the 8639
connector supports hotplug and the pciehp driver would be involved.
Why doesn't it notice the device addition and handle it automatically?
You shouldn't have to do anything with /sys/bus/pci/rescan.

> This probes the device and loads a driver. However when a device is
> added in this way it is not given an interrupt. Irqs seem to be passed
> by the PCI BIOS, or emulated PCI BIOS in the case of non x86 arches
> and so these hot-added cards naturally do not get one.
> 
> This means that when a device is added in this way, unless the device
> and driver use only MSI/MSI-X it will try to request irq vector 0
> which does not end well. To prevent this I have added a check for an
> empty irq vector and use pdev_fixup_irq to set one at run time if one
> has not been provided. This is done inside an unlikely block in order
> to make negligible the performance impact on the normal PCI device
> adding code path, this should not be a performance critical area
> anyway as devices are not often added.

pci_fixup_irqs() has been broken from the beginning because it is only
done for devices present at boot-time, and nothing happens for
hot-added devices.

I think you're on the right path by looking at the generic
pci_bus_add_device() path that is used both at boot-time and hot
add-time.  I would like to see something that works the same way at
both times and gets rid of pci_fixup_irqs() altogether.

I'm not sure this needs to be done as early as pci_bus_add_device();
it could probably be done somewhere in the pci_enable_device() path,
since drivers can't use interrupts before that anyway.

Bjorn

> I have looked into instead modifying the rescan code however this
> would be a less effective solution as there is no convenient way there
> to run code between device probing and the driver loading and so would
> need a significant redesign.
> 
> If anyone has any suggestions or feedback on this patch, or a better
> way to solve this issue should there be one, I would be very grateful.
> 
> In addition I have only had the opportunity to test this code on non
> x86 platforms so if anyone has a x86 or AMD64 PC with physical hot-add
> capability I would be very appreciative if you could try running this.
> 
> Best regards,
> Matthew
> 
> drivers/pci/bus.c | 11 +++++++++++
> drivers/pci/setup-irq.c | 2 +-
> include/linux/pci.h | 2 ++
> 3 files changed, 14 insertions(+), 1 deletion(-)
> 
> -- 
> 
> 
> ------------------------------
> For additional information including the registered office and the treatment of Xyratex confidential information please visit www.xyratex.com
> 
> ------------------------------
