Return-Path: <lukas@wunner.de>
Return-Path: <lukas@wunner.de>
Date: Fri, 12 Aug 2016 18:16:09 +0200
From: Lukas Wunner <lukas@wunner.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Linux PM <linux-pm@vger.kernel.org>,
	Andreas Noever <andreas.noever@gmail.com>
Subject: Re: [PATCH v2 10/13] PCI: Avoid going from D3cold to D3hot for
 system sleep
Message-ID: <20160812161609.GA8060@wunner.de>
References: <cover.1463134231.git.lukas@wunner.de>
 <CAJZ5v0hPbeaUotiFxg_BbkS86HEz=u0ThkdwJju5WyXOuDgd6A@mail.gmail.com>
 <20160807090347.GA5679@wunner.de>
 <2182119.Z8Tk7onsTO@vostro.rjw.lan>
 <20160811132003.GA7369@wunner.de>
 <CAJZ5v0g86L+nL6SxfBMQ84NNpUzz0X83bvP=E5WdSs1TozpY8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJZ5v0g86L+nL6SxfBMQ84NNpUzz0X83bvP=E5WdSs1TozpY8w@mail.gmail.com>
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 12, 2016 at 02:50:04AM +0200, Rafael J. Wysocki wrote:
> On Thu, Aug 11, 2016 at 3:20 PM, Lukas Wunner <lukas@wunner.de> wrote:
> > So I would like to find a common ground and something you feel
> > comfortable to ack. The problem I see with your suggested approach
> > of subclassing struct dev_pm_domain in a struct pci_pm_domain is
> > that I can easily envision Apple putting some custom methods in the
> > DSDT to power a non-PCI device up and down. They're starting to use
> > SPI and UART to attach devices in newer machines.
> 
> Those devices have no standard power state definitions.
> 
> The problem you have here really is PCI-specific, because you want to
> use PCI PM along with the non-standard methods.

If I introduce a struct pci_pm_domain like you suggested, it would mean
that *all* PCI devices using dev_pm_domain_set() have to be changed,
else the container_of() wouldn't work. The resulting code bloat alone
inhibits me from implementing this. Plus, it's a tripwire for anyone
wishing to assign a dev_pm_domain to their PCI device.

> > Hence my suggestion to add a flag to struct dev_pm_domain, even
> > though at the moment that flag would only be queried by the PCI core.
> > I don't care if this is called can_power_off or power_manageable or
> > whatever.
> 
> struct dev_pm_domain is way too generic for that though, as I'm sure
> there are users of it where the can_power_off thing wouldn't make any
> sense whatever.

That seems like a small tradeoff compared to introducing a struct
pci_pm_domain.

If you dislike a can_power_off flag in struct dev_pm_domain, that only
leaves the option to add a one-liner to pci_target_state(), unless I'm
missing something.

BTW there seems to be a contradiction in your statements on wakeup devices:

On Mon, Aug 08, 2016 at 01:32:54AM +0200, Rafael J. Wysocki wrote:
> On Sunday, August 07, 2016 11:03:47 AM Lukas Wunner wrote:
> > The reasoning is that going from D3cold to D3hot before system sleep
> > just never makes sense, no matter if the device got there by standard
> > or nonstandard means.
>
> That may not be true in theory.
>
> If this is a wakeup device, it may not be able to generate wakeup signals
> from D3cold while the system is in the target system state, although it might
> be able to generate those signals when the system is in S0 (in the ACPI case).

However earlier you wrote:

On Mon, Jul 18, 2016 at 03:39:15PM +0200, Rafael J. Wysocki wrote:
> On Saturday, June 18, 2016 12:14:07 AM Lukas Wunner wrote:
> > On Fri, Jun 17, 2016 at 04:09:24PM -0500, Bjorn Helgaas wrote:
> > > Is there a reason you don't want to do this check for devices that
> > > may wakeup?
> >
> > Fear of breaking things. It would mean that a device would be left in
> > D3cold even though it may not be able to signal wakeup from that power
> > state.
>
> Then it should not be put into D3_cold at run time too if it is wakeup-capable.

So on the one hand, you warn that a wakeup-capable device may have been
put into D3cold at runtime but needs to be woken before system sleep
because it might otherwise not be able to signal wakeup.

On the other hand you say that such devices should not be put into D3cold
at runtime at all.

Which one is it?

Thanks,

Lukas
