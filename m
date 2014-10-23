Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail1.bemta5.messagelabs.com ([195.245.231.147]:36078 "EHLO
	mail1.bemta5.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750813AbaJWGAD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 23 Oct 2014 02:00:03 -0400
Date: Thu, 23 Oct 2014 07:52:54 +0200
From: Johannes Thumshirn <johannes.thumshirn@men.de>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Johannes Thumshirn <johannes.thumshirn@men.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: Question regarding pci_request_region()
Message-ID: <20141023055254.GB6523@jtlinux>
References: <20141021143709.GA19376@jtlinux>
 <CAErSpo7beR59ZjbWrnFpqVwk6OGm0wBUHYUdBr1Q1uyewZ32bA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <CAErSpo7beR59ZjbWrnFpqVwk6OGm0wBUHYUdBr1Q1uyewZ32bA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 21, 2014 at 09:34:44AM -0600, Bjorn Helgaas wrote:
> On Tue, Oct 21, 2014 at 8:37 AM, Johannes Thumshirn
> <johannes.thumshirn@men.de> wrote:
> > Hi,
> >
> > I've some questions regarding pci_request_region(). Is there a similar function
> > that allows me to request the memory from a PCIe device, but not a whole BAR?
>
> You can always do something like this:
>
>   start = pci_resource_start(dev, 0);
>   request_mem_region(start, 0x200, KBUILD_MODNAME);
>   ioremap(start, 0x200);
>
> > in drivers/mcb/mcb-pci.c I do a pci_request_region() for BAR 0. But I only need
> > the first 0x200 bytes. pci_request_region() locks the memory and thus probing of
> > mcb attached sub devices fails, as they can't do a request_mem on their part of
> > the PCI memory space until the mcb parser is done and releases BAR0.
>
> The default assumption is that the driver bound to a PCI device is the
> only user of the BARs.  For example, if there is no driver bound to a
> device, the PCI core assumes that it can reassign the BARs.
>
> You can carve up a BAR among sub-devices, but you should make sure
> that some driver remains bound to the PCI device as long as any
> sub-driver is active.  The top-level driver doesn't need to keep any
> BARs mapped itself, but it should remain bound to the device.
>
> It looks like mcb_pci_probe() disables the device before it returns.
> That doesn't seem like a good idea if you have sub-devices that are
> accessed via the device's BARs.  At a minimum, pci_disable_device()
> turns off bus mastering, and it may also disable IRQs
>
> > Generally this is no problem when you build all drivers as modules, but once I
> > do build in drivers, probing fails. Before rewriting all mcb based drivers to
> > use deferred probing I wanted to ask if there is a more clean way to do this.
>
> Deferred probing sounds like a workaround for a deeper problem.  It
> seems like you basically have a PCI device that is effectively a
> bridge to a MEN Chameleon Bus.  That means than when you enumerate
> such a device, the probe routine (mcb_pci_probe(), I think) should in
> turn enumerate any MCB devices "behind" it, i.e., the sub-devices.
>
> There should not be any ordering dependency between mcb_pci_probe()
> and the module_init functions of the drivers.  It is perfectly legal
> for a driver to register before there are any devices for it to bind
> to.  If a driver like men_z135_uart.c initializes first, it should
> register itself as an MCB driver, but its probe function won't be
> called because there's no matching device yet.  When mcb_pci_probe()
> runs later to claim the MCB "bridge", it should enumerate the MCB
> devices and add them.  When the devices are added, we should check for
> any already-registered drivers that match them and call their probe
> functions at that time.
>
> Bjorn

Hi Bjorn,

Thanks for the info, I'll do a patch based on your suggestions.

Thanks,
	Johannes
