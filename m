Return-Path: <SRS0=41+x=Z2=rjwysocki.net=rjw@kernel.org>
Return-Path: <SRS0=41+x=Z2=rjwysocki.net=rjw@kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Lukas Wunner <lukas@wunner.de>
Cc: Yinghai Lu <yinghai@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Bart Van Assche <bart.vanassche@sandisk.com>, Christoph Hellwig <hch@lst.de>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Ashok Raj <ashok.raj@intel.com>, Keith Busch <keith.busch@intel.com>
Subject: Re: [GIT PULL] PCI fixes for v4.10
Date: Mon, 13 Feb 2017 13:10:40 +0100
Message-ID: <2004027.cSeInBS7s4@aspire.rjw.lan>
In-Reply-To: <20170212190502.GA2937@wunner.de>
References: <20170208192054.GA31395@bhelgaas-glaptop.roam.corp.google.com> <CAE9FiQUpzE-5XKS8hKy3e25CyhknDjwXkNk=ADxi-r_euJTd5A@mail.gmail.com> <20170212190502.GA2937@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-pci.vger.kernel.org>

On Sunday, February 12, 2017 08:05:02 PM Lukas Wunner wrote:
> On Fri, Feb 10, 2017 at 06:39:16PM -0800, Yinghai Lu wrote:
> > On Thu, Feb 9, 2017 at 12:11 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Thu, Feb 09, 2017 at 09:09:50AM -0600, Bjorn Helgaas wrote:
> > > > On Thu, Feb 09, 2017 at 05:06:48AM +0100, Lukas Wunner wrote:
> > > > > https://patchwork.kernel.org/patch/9557113/
> > > > > https://patchwork.kernel.org/patch/9562007/
> > >
> > > I apologize: I had quirks on the brain, but neither of the patches
> > > above is device-specific.  So neither is claiming broken hardware.
> > >
> > > However, 9557113 claims we get unwanted PME interrupts if the slot is
> > > occupied when we suspend to D3hot.  This is what I want to explore
> > > further, because that hardware behavior doesn't really make sense to
> > > me.
> > >
> > > 9562007 apparently fixes something, but at this point it's a debugging
> > > patch (no changelog or signed-off-by) so not a candidate for tossing
> > > into v4.10 at this late date.
> > 
> > Agreed. It should need more test coverage.  Found more problems.
> > 
> > Actually we don't need 9557113 as even with that, we still saw link up
> > when power off slots with some cards.
> > 
> > please check updated version of 9562007, that fix power on/off link up
> > problem.
> 
> Thank you for debugging this further.  The patch I've submitted today
> reinstates runtime PM for hotplug ports but constrains it to those on
> a Thunderbolt daisy chain.  The patch allows enabling the feature on
> other hardware by booting with pcie_port_pm=force.
> 
> A few things to keep in mind:
> 
> * On Thunderbolt hotplug ports, interrupts are sent even if the port
>   is in D3hot, which as Bjorn has pointed out contradicts the PCI PM
>   spec r1.2, table 5-4.  This may be caused by liberal interpretation
>   of the spec by Intel when designing the Thunderbolt controllers,
>   or perhaps Thunderbolt controllers simply do not possess a "real",
>   fully-fledged PCIe switch.  I let the hotplug ports go to D3hot,
>   expecting them to continue delivering interrupts but YMMV.
> 
> * You've reported that the hotplug port must be in D0 to enable and
>   disable power on the slot.  I think this is not required by the spec.
>   Thunderbolt hotplug ports do not support power control.  My suspicion
>   is that the ports on your machine must remain in D0 as long as the
>   slot is occupied, i.e. they must not runtime suspend to D3hot.  Can
>   this happen?  Yes.  I release the runtime PM ref once a slot has been
>   enabled or disabled.  The device remains runtime active as long as it
>   has active children.  If all children runtime suspend, the port will
>   go to D3hot, which might cause trouble if this implies that slot power
>   is turned off.  To test this you need a card whose Linux driver supports
>   runtime PM (e.g. Nvidia GPU, boot with nouveau.runpm=1).
> 
> * If the hotplug slot has runtime suspended to D3hot and there are ports
>   above it that also runtime suspend to D3hot, its config space is no
>   longer accessible and in-band interrupts won't come through.  A side-band
>   signaling method such as PME WAKE# is required to deliver interrupts from
>   this state.

It actually can use in-band PME messages too, at least if my interpretation of
this part of the spec is correct (or reflects the interpretation of the people
who design the chips in question to be more precise).

Thanks,
Rafael
