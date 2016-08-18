Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750850AbcHSEVO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Aug 2016 00:21:14 -0400
Date: Thu, 18 Aug 2016 14:56:56 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/2] pci: Add ignore indicator quirk for devices
Message-ID: <20160818195656.GH27353@localhost>
References: <1470687542-30155-1-git-send-email-keith.busch@intel.com>
 <1470687542-30155-2-git-send-email-keith.busch@intel.com>
 <20160815174002.GB9790@localhost>
 <20160815192316.GB18083@localhost.localdomain>
 <20160817213745.GE27353@localhost>
 <20160817230951.GD25146@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160817230951.GD25146@localhost.localdomain>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 17, 2016 at 07:09:51PM -0400, Keith Busch wrote:
> On Wed, Aug 17, 2016 at 04:37:45PM -0500, Bjorn Helgaas wrote:
> > Usually when I think something is totally stupid, it's because I don't
> > know the whole story.  So it might make more sense and lead to a
> > better solution if you could tell us more about your intent here.
> 
> Definitely. I did not provide all the details because I didn't think
> knowing the full context would help toward understanding the function
> of the patch, but I see now that skimping on the details did not help
> our cause.
> 
> This came about from wanting a simple SGPIO-like LED management solution
> for PCIe SSDs. The Intel group who made this, not considering the
> more broad impact on standarization, chose to reuse the hot plug
> serial SMBus in the Intel CPUs (aka VPP) that already carried the Slot
> Control register bits out of the CPU.
> 
> We would love to have been able to disable the capability present
> bits, but the hardware logic that would disable those bits would also
> have disabled LED control entirely, and we can't change the hardware
> now. We have to rely on software to work around this limitation for this
> generation of hardware.
> 
> The next generation of these devices will pursue standards compliant
> methods by engaging with PCI-SIG and the NVMe-MI standards bodies.
> This current generation of devices is the only one set this way that
> requires this work-around.

That's good news.

> > How does 'ledmon' manage the indicators?  The kernel (pciehp) uses the
> > Slot Control register, which is not completely trivial because of the
> > Command Completed synchronization required.  I'm hoping ledmon isn't
> > going to mess up that synchronization.
> 
> We've augmented 'ledmon' with libpci and toggles these indicators very
> similar to how 'setpci' can change PCI config registers. It is done only
> after the storage device is up and registered, which is well outside
> the time when pciehp is actively using the slot control.

I assume this means ledmon writes Slot Control to manage the LEDs.
That sounds pretty scary to me because it's impossible to enforce the
assumption that ledmon only uses Slot Control when pciehp isn't using
it.  Hotplug includes surprise events, and I think pciehp is entitled
to assume it is the sole owner of Slot Control.

I wonder if there's some way to implement the LED control in pciehp,
e.g., by enhancing pciehp_set_attention_status().  I assume the
desired indicator state is coming from some in-kernel storage driver,
and ledmon learns about that somehow, then fiddles with Slot Control
behind the kernel's back?  That looping from kernel to user and back
to kernel sounds a little dodgy and fragile.

Can you share any details about how you plan to implement this on the
next generation of devices?  Maybe we can enhance pciehp indicator
control in a way that supports both Sky Lake and future devices.

Bjorn
