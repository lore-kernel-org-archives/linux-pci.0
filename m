Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:51729 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751827AbbIOQ3t (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 15 Sep 2015 12:29:49 -0400
Date: Tue, 15 Sep 2015 17:30:00 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Yinghai Lu <yinghai@kernel.org>,
	"oe5hpm@gmail.com" <oe5hpm@gmail.com>,
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
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: trouble with PCI: Call pci_read_bridge_bases() from core instead
 of arch code
Message-ID: <20150915163000.GA16240@red-moon>
References: <20150904164412.GD22997@red-moon>
 <CAE9FiQVB0swnTao3eS1kOLvwU-hm0aEpOTXP7wDKFGqtLQta5g@mail.gmail.com>
 <20150907091230.GB29293@red-moon>
 <20150914100929.GB18886@red-moon>
 <CAE9FiQV-eG42xzqVcO2Q+xT3jx-Oa7uC7fEuowvopx4Fp9F7hQ@mail.gmail.com>
 <20150914162834.GA11199@red-moon>
 <CAE9FiQWJfbMD1Akq6XD-Yedc+tNNF8o0obPGHt8f_WnWX0pLbA@mail.gmail.com>
 <CAE9FiQU6NTEdKJi58bNZU4u=+-rzB3mddp6vKGc4JjbZWoa9zQ@mail.gmail.com>
 <20150915094610.GD11199@red-moon>
 <CAErSpo5KaV7ERYcyZBzfvCEh40zSPJmymwXUCbAZkK=hb4DPSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAErSpo5KaV7ERYcyZBzfvCEh40zSPJmymwXUCbAZkK=hb4DPSw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 15, 2015 at 04:57:07PM +0100, Bjorn Helgaas wrote:
> On Tue, Sep 15, 2015 at 4:46 AM, Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
> > On Tue, Sep 15, 2015 at 12:58:20AM +0100, Yinghai Lu wrote:
> >> On Mon, Sep 14, 2015 at 10:36 AM, Yinghai Lu <yinghai@kernel.org> wrote:
> >> > On Mon, Sep 14, 2015 at 9:28 AM, Lorenzo Pieralisi
> >> > <lorenzo.pieralisi@arm.com> wrote:
> >> >> On Mon, Sep 14, 2015 at 05:05:50PM +0100, Yinghai Lu wrote:
> >> >>> We could just revert
> >> >>> dff22d2054b5 (" PCI: Call pci_read_bridge_bases() from core instead of
> >> >>> arch code")
> >> >>> instead.
> >> >>
> >>
> >> > if arch code called pci_read_bridge_bases() via pcibios_fixup_bus(),
> >> > then it need to have
> >> > to call pcibios_allocate_bus_resources() later.
> >> >
> >> > but now arm (mips ?)  does not have calling pcibios_allocate_bus_resources().
> >
> > pcibios_allocate_bus_resources() is an arch specific function and arm
> > and (and mips ?) does not need to create/call it because ARM reassigns
> > ALL resources in ALL platforms, hoping FW can provide a reasonable PCI
> > bridge apertures set-up on ARM is wishful thinking at present.
> >
> > If PCI core code is written with that assumption (ie that arch code zeroes
> > the bridge apertures if they can't be claimed), pci_read_bridge_bases()
> > can't be moved to PCI core code at present, sad and simple.
> >
> > I already asked many times why __pci_bus_size_bridges() cares about
> > the old bridge size on first scan and got no answer so I would ask Bjorn
> > to revert dff22d2054b5 (" PCI: Call pci_read_bridge_bases() from core
> > instead of arch code") or we apply an ARM specific plaster, we are making
> > no progress on this.
> >
> >> Found other problem that is caused by
> >> dff22d2054b5 (" PCI: Call pci_read_bridge_bases() from core instead of
> >> arch code")
> >>
> >> If that commit does not get reverted, will need to have attached patch
> >
> > I see what you mean and I see why there is a reason to apply the patch
> > below if we do not revert dff22d2054b5 (" PCI: Call pci_read_bridge_bases()
> > from core instead of arch code"), but I am afraid the commit log has to
> > be rewritten to explain the problem in a way that properly describes
> > the issue, and that's not the first one I read in the last couple of
> > weeks to figure out how to fix this regression.
> 
> I'm inclined to revert dff22d2054b5 ("PCI: Call
> pci_read_bridge_bases() from core instead of arch code") until we can
> figure this out.  I think the idea of moving that work from
> arch-specific code to the core is good, but it seems like it leads to
> more hacky workarounds than real cleanup right now.  What would break
> if we simply reverted it?  Would that reintroduce any problems?

None that I am aware of, I know Guenter required it for this series:

https://lkml.org/lkml/2015/7/30/861

but it was not merged so, as far as I understand, reverting the patch
should get things to normal. I think it unearthed a couple of niggles
in core code though that should be changed regardless (eg I still
think that __pci_bus_size_bridges() taking the "old" bridge aperture
size for granted is wrong and that's the only reason why bridge apertures
can only be read in arch code, that claims them and reset them if the
claiming fail).

> PCI enumeration and resource assignment is currently split, with some
> ACPI stuff in the middle:
> 
>   - PCI enumeration
>   - ACPI resource reservation
>   - PCI resource assignment
> 
> I think it would make sense to do some PCI resource validation and
> assignment during enumeration, but I don't think it's possible as long
> as we have that ACPI stuff in the middle.  Sometimes ACPI reports
> non-PCI devices in the middle of space we think is available for PCI
> (either from _CRS or our legacy "everything after top-of-RAM" idea),
> so we can't assign space to PCI devices until we know where those ACPI
> things are.

I think there are too many hidden assumptions in the code that assigns
resources owing to history and they are really difficult to untangle,
that's certain and that's why the resource validation and assignment,
that should be arch-agnostic, is very arch dependent at present.

Reading bridge bases in core code, which should be harmless, triggered
a couple of regressions already, imagine what happens if we started
claiming resources in core PCI code.

Resource validation can be done in core code IMO, it will take time
to figure it out though but it is something worth doing.

Thank you !
Lorenzo
