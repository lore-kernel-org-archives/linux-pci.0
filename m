Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39698 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750857AbcBAXfS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 1 Feb 2016 18:35:18 -0500
Date: Mon, 1 Feb 2016 17:35:12 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Richard F <lists@keynet-technology.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: Hint HB6 - kernel doesn't see chips behind it.
Message-ID: <20160201233512.GA19585@localhost>
References: <20160115172640.GC28453@localhost>
 <569CFB5B.7050903@keynet-technology.com>
 <20160119033839.GA3339@localhost>
 <56A8DA21.7060607@keynet-technology.com>
 <20160127215522.GA4875@localhost>
 <56A9EC07.8080509@keynet-technology.com>
 <20160129162400.GB12965@localhost>
 <56ACF8D4.8010607@keynet-technology.com>
 <20160201190611.GA4861@localhost>
 <56AFBADB.3060108@keynet-technology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56AFBADB.3060108@keynet-technology.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 01, 2016 at 08:06:51PM +0000, Richard F wrote:
> Bjorn,
> 
> Thanks so much for your investigation.
> 
> Yes, MOBO has 2 PCI slots fed off the IT8893E.
> This guy -
> http://linux.derkeiler.com/Mailing-Lists/Debian/2005-08/3243.html  had a
> similar problem 10yrs ago(!), fixed by disabling ACPI, I tried that
> without any success.   

Interesting.  That makes you think there's some bridge init
difference.

> I did extract the BIOS tables and
> disassemble/reassemble them to see if there was anything obvious broken
> there, and not much shows, a few warnings, AML is pretty indecipherable
> stuff... I also tried fooling it with some Windows acpi_os_name's
> matching those in the AML, without luck.
> 
> For kicks I spun up an old Win XP image today, and it recognised the PCI
> bridge but may not have been able to see the BT878's behind, but then I
> didn't have a reliable source for drivers for it.

You should be able to tell whether Windows sees the BT878 even without
drivers.  I think there might be something in Device Manager, or you
can use a tool like AIDA64 (there was a free trial version last I
checked).

> Is there's something needing configuring in that Hint HB6/PCI6140
> bridge?

I can't think of anything, but that does seem like the most likely
explanation.

> When working, it loads the shpchp module, and it does advertise
> itself as "non transparent" mode. 

I see "Hint Corp HB6 Universal PCI-PCI bridge (non-transparent mode)"
in both lspci outputs.  Is that what you mean, or do you see a
difference somewhere else?  It looks like that string is just looked
up from the device ID; it's not influenced by anything the kernel
does.

> The other difference is a latency of
> 64 in the working scenario, 32 when not. Not configurable on the AMI
> BIOS unfortunately.

I did notice the shpchp and latency timer differences, but I couldn't
figure out how they could possibly be related.  But it certainly
wouldn't hurt to enable shpchp in your kernel and see if it makes a
difference.

I can't figure out how the latency timer could be involved either, but
you can try fiddling with it, e.g., set it to 64:

  # setpci -s04:01.0 0x0d.b=0x40
  # echo 1 > /sys/bus/pci/rescan

You can also use "lspci -vvv -s04:01.0" and compare with the working
system and see if there are other differences.  I think AIDA64 will
also dump that config space, so you might be able to compare with
with what Windows XP does, too.

> On 1/02/2016 19:06, Bjorn Helgaas wrote:
> > On Sat, Jan 30, 2016 at 05:54:28PM +0000, Richard F wrote:
> >> On 29/01/2016 16:24, Bjorn Helgaas wrote:
> >>> On Thu, Jan 28, 2016 at 10:23:03AM +0000, Richard F wrote:
> >>> Your topology looks a little strange:
> >>>
> >>>   00:1c.0 PCIe root port to [bus 01]    slot 0
> >>>   00:1c.1 PCIe root port to [bus 02]    slot 1
> >>>   00:1c.2 PCIe root port to [bus 03-05] slot 2
> >>>   03:00.0 PCI bridge to [bus 04-05] (Integrated Technology Express)
> >>>   04:01.0 PCI bridge to [bus 05] (Hint Corp)
> >>>
> >>> 00:1c.2 is a normal PCIe Root Port, so the device it's connected to
> >>> *should* be a PCIe device, but 03:00.0 doesn't have a PCIe capability.
> >>> Is this an adapter card of some kind?
> >>
> >> It's a motherboard bridge to get from PCIe to legacy PCI slots, quite a
> >> few motherboards use it I think. It's not an adapter I plugged in.
> > 
> > That makes sense.  It sounds like there are two conventional PCI
> > slots?  I think it's also a minor platform bug that the 00:1c.2 root
> > port advertises a slot.  1c.2 is connected to a system-integrated
> > device, i.e., 03:00.0, not a slot.  This might cause pciehp to claim
> > 1c.2 when it shouldn't.  But that's unrelated to the current issue, of
> > course.
> > 
> >> I posted the output of DMESG with your patch (in 4.4.0) to the bugzilla
> >> https://bugzilla.kernel.org/show_bug.cgi?id=110851
> >>
> >> It produced a fair bit of output but doesn't look like the card was
> >> recognised. At least modprobe'ing bttv with the right parameters didn't
> >> yield the right response.
> > 
> > I only added printks, so I didn't expect it to change the behavior.  I
> > just wanted to confirm that we are scanning the bus and device numbers
> > where we expect the bttv devices to be, and we are.  I think your bttv
> > card includes these devices:
> > 
> >   04:01.0 PCI-PCI bridge (Hint Corp)
> >   05:0c.0 bt878
> >   05:0c.1 bt878
> >   05:0d.0 bt878
> >   ...
> >   05:0f.1 bt878
> > 
> > For conventional PCI, I think the device number is determined by the
> > slot wiring.  That affects the device number of the Hint Corp bridge,
> > so if you move it between slots, it should change from device 01 to
> > something else.
> > 
> > The device and function numbers of the bt878 devices are determined by
> > wiring on the card, so those should be the same between machine A and
> > B.  These are 5- and 3-bit fields, respectively, so 0c.0 means we have
> > 01100 000 encoded into an 8-bit devfn as 0110 0000 or 0x60.  When we
> > tried to read the vendor & device ID from 0c.0, we got no response
> > from the device:
> > 
> >   pci_bus 0000:05: pci_scan_slot 60
> >   pci_bus 0000:05: pci_scan_single_device 60
> >   pci_bus 0000:05: pci_scan_device 60
> >   pci_bus 0000:05: pci_bus_read_dev_vendor_id 60 0xffffffff
> > 
> > I'm out of ideas.  Other cards work in this slot; it's only the bttv
> > card that doesn't work.  So it seems like it must be something about
> > that card that's different.
> > 
> > Maybe somebody on the list will have more ideas?
> > 
> > Bjorn
> > 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
