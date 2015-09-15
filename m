Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:49721 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755014AbbIOJp5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 15 Sep 2015 05:45:57 -0400
Date: Tue, 15 Sep 2015 10:46:10 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
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
Message-ID: <20150915094610.GD11199@red-moon>
References: <20150904141903.GA22997@red-moon>
 <CAE9FiQXeByB6zakDKKC=P68fWD-sKiP1tzn-DWZ+kBsVnXZLxg@mail.gmail.com>
 <20150904164412.GD22997@red-moon>
 <CAE9FiQVB0swnTao3eS1kOLvwU-hm0aEpOTXP7wDKFGqtLQta5g@mail.gmail.com>
 <20150907091230.GB29293@red-moon>
 <20150914100929.GB18886@red-moon>
 <CAE9FiQV-eG42xzqVcO2Q+xT3jx-Oa7uC7fEuowvopx4Fp9F7hQ@mail.gmail.com>
 <20150914162834.GA11199@red-moon>
 <CAE9FiQWJfbMD1Akq6XD-Yedc+tNNF8o0obPGHt8f_WnWX0pLbA@mail.gmail.com>
 <CAE9FiQU6NTEdKJi58bNZU4u=+-rzB3mddp6vKGc4JjbZWoa9zQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAE9FiQU6NTEdKJi58bNZU4u=+-rzB3mddp6vKGc4JjbZWoa9zQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 15, 2015 at 12:58:20AM +0100, Yinghai Lu wrote:
> On Mon, Sep 14, 2015 at 10:36 AM, Yinghai Lu <yinghai@kernel.org> wrote:
> > On Mon, Sep 14, 2015 at 9:28 AM, Lorenzo Pieralisi
> > <lorenzo.pieralisi@arm.com> wrote:
> >> On Mon, Sep 14, 2015 at 05:05:50PM +0100, Yinghai Lu wrote:
> >>> We could just revert
> >>> dff22d2054b5 (" PCI: Call pci_read_bridge_bases() from core instead of
> >>> arch code")
> >>> instead.
> >>
> 
> > if arch code called pci_read_bridge_bases() via pcibios_fixup_bus(),
> > then it need to have
> > to call pcibios_allocate_bus_resources() later.
> >
> > but now arm (mips ?)  does not have calling pcibios_allocate_bus_resources().

pcibios_allocate_bus_resources() is an arch specific function and arm
and (and mips ?) does not need to create/call it because ARM reassigns
ALL resources in ALL platforms, hoping FW can provide a reasonable PCI
bridge apertures set-up on ARM is wishful thinking at present.

If PCI core code is written with that assumption (ie that arch code zeroes
the bridge apertures if they can't be claimed), pci_read_bridge_bases()
can't be moved to PCI core code at present, sad and simple.

I already asked many times why __pci_bus_size_bridges() cares about
the old bridge size on first scan and got no answer so I would ask Bjorn
to revert dff22d2054b5 (" PCI: Call pci_read_bridge_bases() from core
instead of arch code") or we apply an ARM specific plaster, we are making
no progress on this.

> Found other problem that is caused by
> dff22d2054b5 (" PCI: Call pci_read_bridge_bases() from core instead of
> arch code")
> 
> If that commit does not get reverted, will need to have attached patch

I see what you mean and I see why there is a reason to apply the patch
below if we do not revert dff22d2054b5 (" PCI: Call pci_read_bridge_bases()
from core instead of arch code"), but I am afraid the commit log has to
be rewritten to explain the problem in a way that properly describes
the issue, and that's not the first one I read in the last couple of
weeks to figure out how to fix this regression.

Thanks,
Lorenzo

> 
> 
> Subject: [PATCH] PCI: Skip reading bridge bases with existing ones on rescan
> 
> Noticed there is noisy print out pci bridge bases read out for
> existing devices that is caused by commit dff22d2054b5
> ("PCI: Call pci_read_bridge_bases() from core instead of arch code")
> 
> pci_bus 0000:06: scanning bus
> pcieport 0000:06:00.0: scanning [bus 07-09] behind bridge, pass 0
> pcieport 0000:06:00.0: PCI bridge to [bus 07-09]
> pcieport 0000:06:00.0:   bridge window [io  0x1000-0x2fff]
> pcieport 0000:06:00.0:   bridge window [mem 0xfda00000-0xfddfffff]
> pcieport 0000:06:00.0:   bridge window [mem 0xfc000000-0xfc3fffff 64bit pref]
> pci_bus 0000:07: scanning bus
> pcieport 0000:07:00.0: scanning [bus 08-08] behind bridge, pass 0
> pcieport 0000:07:00.0: PCI bridge to [bus 08]
> pcieport 0000:07:00.0:   bridge window [io  0x2000-0x2fff]
> pcieport 0000:07:00.0:   bridge window [mem 0xfdc00000-0xfddfffff]
> pcieport 0000:07:00.0:   bridge window [mem 0xfc200000-0xfc3fffff 64bit pref]
> pci_bus 0000:08: scanning bus
> pcieport 0000:07:00.1: scanning [bus 09-09] behind bridge, pass 0
> pcieport 0000:07:00.1: PCI bridge to [bus 09]
> pcieport 0000:07:00.1:   bridge window [io  0x1000-0x1fff]
> pcieport 0000:07:00.1:   bridge window [mem 0xfda00000-0xfdbfffff]
> pcieport 0000:07:00.1:   bridge window [mem 0xfc000000-0xfc1fffff 64bit pref]
> 
> Add is_added checking to avoid those wrong reading.
> 
> Fixes: dff22d2054b5 ("PCI: Call pci_read_bridge_bases() from core
> instead of arch code")
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> 
> ---
>  drivers/pci/probe.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> Index: linux-2.6/drivers/pci/probe.c
> ===================================================================
> --- linux-2.6.orig/drivers/pci/probe.c
> +++ linux-2.6/drivers/pci/probe.c
> @@ -455,6 +455,9 @@ void pci_read_bridge_bases(struct pci_bu
>      struct resource *res;
>      int i;
> 
> +    if (child->is_added)
> +        return;
> +
>      if (pci_is_root_bus(child))    /* It's a host bus, nothing to read */
>          return;

> Subject: [PATCH] PCI: Skip reading bridge bases with existing ones on rescan
> 
> Noticed there is noisy print out pci bridge bases read out for
> existing devices that is caused by commit dff22d2054b5
> ("PCI: Call pci_read_bridge_bases() from core instead of arch code")
> 
> pci_bus 0000:06: scanning bus
> pcieport 0000:06:00.0: scanning [bus 07-09] behind bridge, pass 0
> pcieport 0000:06:00.0: PCI bridge to [bus 07-09]
> pcieport 0000:06:00.0:   bridge window [io  0x1000-0x2fff]
> pcieport 0000:06:00.0:   bridge window [mem 0xfda00000-0xfddfffff]
> pcieport 0000:06:00.0:   bridge window [mem 0xfc000000-0xfc3fffff 64bit pref]
> pci_bus 0000:07: scanning bus
> pcieport 0000:07:00.0: scanning [bus 08-08] behind bridge, pass 0
> pcieport 0000:07:00.0: PCI bridge to [bus 08]
> pcieport 0000:07:00.0:   bridge window [io  0x2000-0x2fff]
> pcieport 0000:07:00.0:   bridge window [mem 0xfdc00000-0xfddfffff]
> pcieport 0000:07:00.0:   bridge window [mem 0xfc200000-0xfc3fffff 64bit pref]
> pci_bus 0000:08: scanning bus
> pcieport 0000:07:00.1: scanning [bus 09-09] behind bridge, pass 0
> pcieport 0000:07:00.1: PCI bridge to [bus 09]
> pcieport 0000:07:00.1:   bridge window [io  0x1000-0x1fff]
> pcieport 0000:07:00.1:   bridge window [mem 0xfda00000-0xfdbfffff]
> pcieport 0000:07:00.1:   bridge window [mem 0xfc000000-0xfc1fffff 64bit pref]
> 
> Add is_added checking to avoid those wrong reading.
> 
> Fixes: dff22d2054b5 ("PCI: Call pci_read_bridge_bases() from core instead of arch code")
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> 
> ---
>  drivers/pci/probe.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> Index: linux-2.6/drivers/pci/probe.c
> ===================================================================
> --- linux-2.6.orig/drivers/pci/probe.c
> +++ linux-2.6/drivers/pci/probe.c
> @@ -455,6 +455,9 @@ void pci_read_bridge_bases(struct pci_bu
>  	struct resource *res;
>  	int i;
>  
> +	if (child->is_added)
> +		return;
> +
>  	if (pci_is_root_bus(child))	/* It's a host bus, nothing to read */
>  		return;
>  

