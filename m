Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:41231 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753986AbbICR5V (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 3 Sep 2015 13:57:21 -0400
Date: Thu, 3 Sep 2015 18:57:26 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "oe5hpm@gmail.com" <oe5hpm@gmail.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	"James E.J. Bottomley" <jejb@parisc-linux.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Richard Henderson <rth@twiddle.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	David Howells <dhowells@redhat.com>,
	Russell King <linux@arm.linux.org.uk>,
	Tony Luck <tony.luck@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Ingo Molnar <mingo@redhat.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Michal Simek <monstr@monstr.eu>,
	Chris Zankel <chris@zankel.net>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yinghai Lu <yinghai@kernel.org>
Subject: Re: trouble with PCI: Call pci_read_bridge_bases() from core instead
 of arch code
Message-ID: <20150903175726.GB19123@red-moon>
References: <CAAa04yFQEUJm7Jj1qMT57-LG7ZGtnhNDBe=PpSRa70Mj+XhW-A@mail.gmail.com>
 <20150902174716.GA6305@red-moon>
 <20150902203250.GB829@google.com>
 <20150903100115.GA15308@red-moon>
 <20150903162140.GG829@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150903162140.GG829@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Sep 03, 2015 at 05:21:40PM +0100, Bjorn Helgaas wrote:

[...]

> > > > Subject: [PATCH] arm: kernel: pci: fixup erroneous PCI bridge apertures
> > > >
> > > > Bridge apertures read by core PCI code through pci_read_bridge_bases()
> > > > might be erroneous (bogus platform setup). If the arch code does not vet
> > > > the bridge resources (ie by trying to claim them), we can end up in a
> > > > situation where wrong bridge apertures can prevent resources assignment
> > > > for downstream devices causing enumeration failures (eg a bridge
> > > > aperture does not fit in the respective host controller resource window,
> > > > so it can't be assigned).
> > > >
> > > > This patch adds arm arch code that vets bridge resources by trying
> > > > to claim them, and reset them on claiming failure so that they can
> > > > be properly reassigned.
> > >
> > > We definitely should not depend on the platform to set up the bridge
> > > windows.  Do we know what the platform left in the 00:00.0 window
> > > registers?
> >
> > Well, I agree but the point here is, by reading the bridge bases
> > we are initializing the apertures resources and this is causing
> > issues, we have to have a way to nuke the initialized apertures resources
> > if they are bogus, more below. I wonder why we want to read the bridge
> > apertures at all on !PCI_PROBE_ONLY systems.
> 
> I'm not quite sure I understand your question.  We have to know the
> bridge apertures to know whether downstream device BARs are valid.
> For PCI_PROBE_ONLY, that means reading the apertures, since we won't
> assign them ourselves.
> 
> For !PCI_PROBE_ONLY, we *could* completely disregard the bridge
> apertures (except to determine what kind of windows we have) and
> assign them from scratch.  But I don't like that approach because
> we're throwing away any assignment done by the firmware without even
> considering whether it's valid.

Ok, here is the answer I was looking for, you understood my question :)

> I would like /proc/iomem to contain host bridge windows, P2P bridge
> windows, and device BARs.  I think the contents should be identical
> for PCI_PROBE_ONLY and !PCI_PROBE_ONLY unless we actually changed
> something in the !PCI_PROBE_ONLY case.

Understood, I am a bit dubious about FW set-up correctness of some
of the platforms I am dealing with (we have an example here) but that's
not your problem.

> > pci 0000:00:00.0:   bridge window [mem 0x01000000-0x01ffffff]
> >
> > > I see that bus 01 requires 0x204100 of mem space, which must be
> > > rounded up to a megabyte boundary, so the window must be at least 3M
> > > (0x00300000):
> > >
> > >   pci 0000:01:00.0: BAR 2: failed to assign [mem size 0x00200000]
> > >   pci 0000:01:00.0: BAR 1: failed to assign [mem size 0x00004000]
> > >   pci 0000:01:00.0: BAR 0: failed to assign [mem size 0x00000100]
> > >
> > > I don't understand the connection with dff22d2054b5 yet.  If we don't
> > > call pci_read_bridge_bases(), apparently some assign-resources path
> > > figures out the required size and assigns a 3M window.
> > >
> > > If we *do* call pci_read_bridge_bases(), do we read a bogus 16M window
> > > size, fail to assign that because the host controller window isn't big
> > > enough, and then the assign-resources path just gives up?  I assume
> > > clearing r->flags in your patch is the critical thing?  Is there
> > > something in assign-resources that checks for r->flags == 0?
> >
> > You summed it up, but the point here is not about the flags, it is
> > about the bogus 16M bridge aperture (so r->start and r->end).
> >
> > While sizing the bridge apertures, the code in pbus_size_mem() checks
> > the size required by devices and then set-up the bridge aperture.
> >
> > Now, calculate_memsize() takes as an input the "old" aperture size (16M)
> > which means that the updated aperture will keep the old aperture
> > size instead of the one computed from the size of downstream devices
> > (because the old aperture - read from bridge bases - is larger, see
> > calculate_memsize()), hence the failure.
> 
> I don't see the point of sizing a bridge at all *unless* we find that
> we need to reassign one of its windows.  If firmware gave us a working
> assignment, we should read the bridge windows, claim them, read the
> BARs of downstream devices, claim them, and be done.  If firmware
> didn't give us a working assignment (as in this case), we should read
> the window, attempt to claim it, fail, *then* figure out how big the
> window needs to be to accommodate all the downstream BARs.  In that
> case, the original window size is irrelevant.
> 
> So I'm dubious about the idea that calculate_memsize() should keep the
> old size if it is larger.

I did not say it should, I said this is what's happening and I would
like to understand if that's the behaviour we should expect.

> > If the bridge aperture is reset (ie resource start and end are zeroed)
> > before sizing the bridge everything is back to normal.
> >
> > x86 does the same thing I implement in the patch attached, and probably
> > we have also discovered why Alpha and MIPS were reading bridge bases
> > on PROBE_ONLY systems only.
> >
> > > I think it would be ideal if we could someday claim the resource
> > > immediately, as soon as we read it from a BAR or bridge window, and
> > > mark it as IORESOURCE_UNSET if claiming it fails.  Then if the
> > > platform set up reasonable windows, we could use them; if it didn't,
> > > we could just assign our own.
> >
> > Well, that's what my patch does and that's what x86 does. I am nervous
> > about adding this to core PCI code (in particular I am worried about
> > claiming the bridge windows ie when you say reasonable, it does not
> > necessarily mean optimal, claiming the bridge apertures can cause
> > issues in relation to resources allocation IMO since we claim
> > the aperture before sizing the bridge).
> 
> I think we should claim the resource immediately so the resource tree
> reflects what the hardware is doing.  If we have to reassign things,
> we can release the original assignment and claim the new one.
> 
> I agree we're going to trip over issues.  But I think those issues are
> symptoms of things we're doing wrong, so I think we should find and
> fix them instead of tip-toeing around them.  We might need short-term
> workarounds, and I'm OK with that as long we try not to think of them
> as the real fixes.

I agree with you, I just wanted to fix this regression promptly without
reverting the patch that triggered it because from what you are saying
above, reading the bridge bases from core code should be there to stay.
I need some time to understand how to claim resources safely especially
if the resulting code has to live in PCI core, in the interim to fix the
regression I need a temporary fix for ARM.

> > My question is: on !PCI_PROBE_ONLY systems, why do we want to "trust" the
> > bridge bases (that we want to reassign after sizing bridges *anyway*) ?
> > I understand on PCI_PROBE_ONLY systems they should be immutable, I would
> > like to understand why we have to read them on !PCI_PROBE_ONLY systems.
> 
> For the normal case (!PCI_PROBE_ONLY), we've historically used the
> existing window assignments if they work.  We only reassign windows if
> there's a reason why we have to, e.g., some device has no resources
> but we can give it some by rearranging things.  I think it makes sense
> to continue that practice -- why would we change something that is
> already working?

I did not say we should change it, it was a question for me to
understand. On ARM resources are not claimed, they are always
assigned or we leave them as they are (ie on PCI_PROBE_ONLY).

Reading the bridge apertures in core code is triggering this regression,
so, even if temporary, I have to find a solution which might be the patch
I sent or something more sophisticated, I am working on it.

Thank you,
Lorenzo
