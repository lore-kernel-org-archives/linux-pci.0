Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from out03.mta.xmission.com ([166.70.13.233]:35525 "EHLO
	out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757537Ab2FFTm3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 6 Jun 2012 15:42:29 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Khalid Aziz <khalid.aziz@hp.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>,
	linux-kernel@vger.kernel.org, bhelgaas@google.com,
	linux-pci@vger.kernel.org
References: <20120427190033.GA17588@ldl.usa.hp.com>
	<20120606135009.GB1517@srcf.ucam.org>
	<1338999463.25761.630.camel@lyra>
	<20120606162703.GA6779@srcf.ucam.org>
	<1339003956.25761.667.camel@lyra>
	<20120606174202.GA8750@srcf.ucam.org>
	<1339006060.25761.689.camel@lyra>
Date: Wed, 06 Jun 2012 12:42:07 -0700
In-Reply-To: <1339006060.25761.689.camel@lyra> (Khalid Aziz's message of "Wed,
	06 Jun 2012 12:07:40 -0600")
Message-ID: <87obowxm5s.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Re: [PATCH] Disable Bus Master on PCI device shutdown
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Khalid Aziz <khalid.aziz@hp.com> writes:

> On Wed, 2012-06-06 at 18:42 +0100, Matthew Garrett wrote:
>> On Wed, Jun 06, 2012 at 11:32:36AM -0600, Khalid Aziz wrote:
>> 
>> > Do we agree that if device shutdown routine cleanly shuts down all I/O,
>> > clearing PCI Bus Mster bit should be safe?
>> 
>> In the absence of hardware that dislikes the bus master bit ever being 
>> disabled, yes. Do we know if hardware is ever tested in that situation?
>
> I will wait for device vendors to comment on that. I can't claim I have
> tested more than a few devices that way.

Testing is easy.  kexec into a new kernel.  Shrug.  A long standing
useful kernel feature.  In all other cases I expec the firmware triggers
a board level reset of the hardware to avoid issues during reboot.

>> > If yes, then we only have to deal with broken devices. So the approach 
>> > could be to disable Bus Master bit unless the device ID matches a 
>> > blacklist which we update as we find broken devices. I really don't 
>> > like the idea of maintaining blacklists in the kernel for such things 
>> > but is that a more practical approach? If blacklist does not sound 
>> > good, maybe we can ask drivers to tell PCI subsystem if they are not 
>> > ok with clearing Bus Master bit and then PCI subsystem could skip 
>> > those devices.
>> 
>> Or we could just put responsibility on the drivers to ensure that the 
>> hardware won't continue doing any DMA, either by shutting down the 
>> engines or clearing the bit.

Where the responsibily has squarely been for the last decade, and we
still have issues in the common case.

> I assume device shutdown routine should stop all I/O and shutting down
> DMA engine. Disabling Bus Master bit is just an extra measure of safety.
> I do like the idea of disabling Bus Master bit in device shutdown
> routine. After all, drivers know their hardware best. On the other hand,
> it is change to lots of driver code to implement this which means it
> will end up happening slowly over period of time. I don't mind doing the
> work up front on a good number of drivers I feel comfortable modifying.
> I am ok with pulling out code to clear bus master bit from PCI subsystem
> and replacing it with modified shutdown routines for a few drivers to
> start with.

Absent anyone even knowing if there are devices that exist that can not
tolerate their bus master bit being flipped when DMA is not ongoing I
think the current state of the code is good.  When we find the broken
hardware that can not tolerate a standard PCI bit being used in a
standard way we can add a flag in the core to avoid doing that.

pci_device_shutdown calls drv->shutdown before calling
pci_device_disable.  Which means that only devices that have trouble
with this bit being flipped while DMA is ongoing and don't bother
to stop their own DMA will have a problem.

As for shifting problems I do think we have shifted the problem in a
very positive way.  Now instead of having a random failure at a random
location caused by DMA happing at a random moment for no expected reason
we have failures happening when we disable or enable a device, which
should be much more debugable.

If we encounter devices that can't have their bus master bit disabled at
all we can move that functionality into the drivers or add some sort of
flag so that pci_device_shutdown avoids this on real hardware.

> Does any one see any other issues with modifying driver shutdown
> routines for disabling Bus Master bit? Bjorn, any opinions?

I don't have a problem with moving it all of the way into the drivers
I just think it might be a little bit silly at this point.

Ultimately I don't see the complaint raised by this thread.  Either
the drivers for the broadcom devices in questoin are buggy before we
added the pci_disable_device or those drivers are not buggy.

If we really want to do something to reduce the testing burden and make
certain things work better in general we need to merge the device
shutdown and the device remove methods.  Shrug.  People keep getting
squeamish when I suggest that.

Eric
