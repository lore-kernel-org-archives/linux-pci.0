Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:32762 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755052Ab3BLEQH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 11 Feb 2013 23:16:07 -0500
Message-ID: <1360642556.3248.64.camel@bling.home>
Subject: Re: PCI warning on boot 3.8.0-rc1
From: Alex Williamson <alex.williamson@redhat.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	David Woodhouse <dwmw2@infradead.org>,
	iommu@lists.linux-foundation.org
Date: Mon, 11 Feb 2013 21:15:56 -0700
In-Reply-To: <1360166321.11144.638.camel@bling.home>
References: <20130116143853.339dd89b@nehalam.linuxnetplumber.net>
	 <CAErSpo5eOE_=Ob2jN7ACy0eJBOa8k36XqCbHnGTCs-wfiy8tiw@mail.gmail.com>
	 <20130204103645.38ae2d5e@nehalam.linuxnetplumber.net>
	 <1360009684.11144.539.camel@bling.home>
	 <1360017684.11144.547.camel@bling.home>
	 <20130206074900.02f04e3f@nehalam.linuxnetplumber.net>
	 <1360166321.11144.638.camel@bling.home>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2013-02-06 at 08:58 -0700, Alex Williamson wrote:
> On Wed, 2013-02-06 at 07:49 -0800, Stephen Hemminger wrote:
> > On Mon, 04 Feb 2013 15:41:24 -0700
> > Alex Williamson <alex.williamson@redhat.com> wrote:
> > 
> > > On Mon, 2013-02-04 at 13:28 -0700, Alex Williamson wrote:
> > > > On Mon, 2013-02-04 at 10:36 -0800, Stephen Hemminger wrote:
> > > > > > I think drivers/pci/search.c is identical between 3.7 and 3.8-rc1.  Is
> > > > > > this the first time you've turned on the IOMMU on that box?
> > > > > 
> > > > > It exists in 3.7 and earlier kernels, just haven't turned on same config.
> > > > > 
> > > > > > It's the same warning as in this bugzilla:
> > > > > > https://bugzilla.kernel.org/show_bug.cgi?id=44881, and there's a patch
> > > > > > there at https://bugzilla.kernel.org/show_bug.cgi?id=44881#c11, but
> > > > > > it's just a quirk that turns off VT-d if we find certain broken
> > > > > > bridges.  It doesn't look like you have any of those (although I don't
> > > > > > know what you have at 05:00.0).
> > > > > > 
> > > > > > Bjorn
> > > > > 
> > > > > This is a standard ASUS motherboard, and don't want to disable VT-d.
> > > > 
> > > > Stephen,
> > > > 
> > > > Can you give the lspci -vvv of device 5:00.0 to see if it's one we've
> > > > seen before?  Does the patch below help?
> > > > 
> > > > Bjorn, I think we need to quirk it somehow.  So far they've all been
> > > > PCI-to-PCI bridges attached to root ports where we expect it's actually
> > > > a PCIe-to-PCI bridge.  Seems like maybe we could have the same attached
> > > > to a downstream port.  The patch below avoids the WARN and gives us a
> > > > device, but of course pci_is_pcie reports wrong for this device and may
> > > > cause some trickle down breakage.  A more complete option might be to
> > > > add a is_pcie flag to the device that can be set independent of
> > > > pcie_cap.  We'd need to check all the callers for assumptions, but then
> > > > we could put the quirk in one place and hopefully fix everything.
> > > > Thoughts?  Thanks,
> > > 
> > > This latter approach seems like it might be easier than I expected since
> > > all the users are so well filtered through the access functions.  A
> > > quick look through who uses pci_is_pcie seems like this might be
> > > complete, but more eyes are required.  I'll upload this to the bz for
> > > those reporters to test as well.  Thoughts?  Thanks,
> > > 
> > > Alex
> > 
> > On my hardware this gives:
> 
> > [    0.254621] pci_bus 0000:05: busn_res: can not insert [bus 05-ff] under [bus 00-3e] (conflicts with (null) [bus 00-3e])
> > [    0.254647] WARNING: Your hardware is broken, device (null) appears to be a
> > [    0.254647]  Legacy PCI device attached directly to a PCIe device which is not a
> > [    0.254647]  PCIe-to-PCI bridge.  Per section 7.8 of the PCI Express 3.0 spec, the
> > [    0.254647]  PCI express capability structure is required for PCI express device
> > [    0.254647] functions.
> > [    0.254653] pci 0000:05:00.0: [1b21:1080] type 01 class 0x060401
> 
> I guess I must be calling pci_name() before it's set.  The warning
> message needs some work too, it's mainly meant for hardware vendors with
> the hope that they might test Linux and see it before shipping these
> broken devices.  Bjorn, does this approach seem worth pursuing?  Thanks,

I don't know if it sways how we handle this devices, but a couple notes
on the asmedia chip.  I have one in a non-VT-d capable system and an
add-in legacy PCI NIC shows up behind it when added to the system.  The
chip is visible on the board and is an ASM1083.  Asmedia's website of
course claims this device is fully compliant with the PCIe-to-PCI bridge
spec, ignoring the multiple statements the spec contains requiring such
devices to support a PCIe capability.

Additionally, if you google for ASM1083 you'll find the next highest
links after the product links are bug reports that not only is this
device non-spec complaint, but it doesn't work.  There seems to be an
issue with how INTx is de-asserted (or not) leading to interrupt storms
and requiring the use of irqpoll.  Sure enough, the tulip card I
installed generated some of these and is operating in polling mode.  The
threads indicate that these issues are not isolated to Linux and Windows
users also complain about devices not working or having poor performance
installed behind this bridge.  All in all, it's an absurdly broken piece
of hardware.

I wonder if instead of trying to work around it, we should just
blacklist the device and ignore that it even exists.  Stop the bus walk
with some kind of dmesg error and provide a boot time option to scan it.
It's not the most user friendly option, but a) most people don't seem to
have anything behind it, b) it barely works if they do.  Thanks,

Alex

