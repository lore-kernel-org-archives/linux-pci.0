Return-Path: <SRS0=ZkQy=HP=linux.intel.com=mika.westerberg@kernel.org>
Return-Path: <SRS0=ZkQy=HP=linux.intel.com=mika.westerberg@kernel.org>
Date: Thu, 26 Apr 2018 15:23:33 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <lenb@kernel.org>, Mario.Limonciello@dell.com,
	Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH v5 2/9] PCI: Take bridge window alignment into account
 when distributing resources
Message-ID: <20180426122333.GE2173@lahna.fi.intel.com>
References: <20180416103453.46232-1-mika.westerberg@linux.intel.com>
 <20180416103453.46232-3-mika.westerberg@linux.intel.com>
 <20180425223853.GA225403@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180425223853.GA225403@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Wed, Apr 25, 2018 at 05:38:54PM -0500, Bjorn Helgaas wrote:
> On Mon, Apr 16, 2018 at 01:34:46PM +0300, Mika Westerberg wrote:
> > When hot-adding a PCIe switch the way we currently distribute resources
> > does not always work well because devices connected to the switch might
> > need to have their MMIO resources aligned to something else than the
> > default 1 MB boundary. For example Intel Gigabit ET2 quad port server
> > adapter includes PCIe switch leading to 4 x GbE NIC devices that want
> > to have their MMIO resources aligned to 2 MB boundary instead.
> > 
> > The current resource distribution code does not take this alignment into
> > account and might try to add too much resources for the extension
> > hotplug bridge(s). The resulting bridge window is too big which makes
> > the resource assignment operation fail, and we are left with a bridge
> > window with minimal amount (1 MB) of MMIO space.
> > 
> > Here is what happens when an Intel Gigabit ET2 quad port server adapter
> > is hot-added:
> > 
> >   pci 0000:39:00.0: BAR 14: assigned [mem 0x53300000-0x6a0fffff]
> >                                           ^^^^^^^^^^
> >   pci 0000:3a:01.0: BAR 14: assigned [mem 0x53400000-0x547fffff]
> >                                           ^^^^^^^^^^
> > The above shows that the downstream bridge (3a:01.0) window is aligned
> > to 2 MB instead of 1 MB as is the upstream bridge (39:00.0) window. The
> > remaining MMIO space (0x15a00000) is assigned to the hotplug bridge
> > (3a:04.0) but it fails:
> > 
> >   pci 0000:3a:04.0: BAR 14: no space for [mem size 0x15a00000]
> >   pci 0000:3a:04.0: BAR 14: failed to assign [mem size 0x15a00000]
> > 
> > The MMIO resource is calculated as follows:
> > 
> >   start = 0x54800000
> >   end = 0x54800000 + 0x15a00000 - 1 = 0x6a1fffff
> > 
> > This results bridge window [mem 0x54800000 - 0x6a1fffff] and it ends
> > after the upstream bridge window [mem 0x53300000-0x6a0fffff] explaining
> > the above failure. Because of this Linux falls back to the default
> > allocation of 1 MB as can be seen from 'lspci' output:
> > 
> >  39:00.0 Memory behind bridge: 53300000-6a0fffff [size=366M]
> >    3a:01.0 Memory behind bridge: 53400000-547fffff [size=20M]
> >    3a:04.0 Memory behind bridge: 53300000-533fffff [size=1M]
> > 
> > The hotplug bridge 3a:04.0 only occupies 1 MB MMIO window which is
> > clearly not enough for extending the PCIe topology later if more devices
> > are to be hot-added.
> > 
> > Fix this by substracting properly aligned non-hotplug downstream bridge
> > window size from the remaining resources used for extension. After this
> > change the resource allocation looks like:
> > 
> >   39:00.0 Memory behind bridge: 53300000-6a0fffff [size=366M]
> >     3a:01.0 Memory behind bridge: 53400000-547fffff [size=20M]
> >     3a:04.0 Memory behind bridge: 54800000-6a0fffff [size=345M]
> > 
> > This matches the expectation. All the extra MMIO resource space (345 MB)
> > is allocated to the extension hotplug bridge (3a:04.0).
> 
> Sorry, I've spent a lot of time trying to trace through this code, and
> I'm still hopelessly confused.  Can you post the complete "lspci -vv"
> output and the dmesg log (including the hot-add event) somewhere and
> include a URL to it?

I sent you the logs and lspci output both with and without this patch
when I connect a full chain of 6 Thunderbolt devices where 3 of them
include those NICs with 4 ethernet ports. The resulting topology
includes total of 6 + 3 + 1 PCIe switches.

> I think I understand the problem you're solving:
> 
>   - You have 366M, 1M-aligned, available for things on bus 3a
>   - You assign 20M, 2M-aligned to 3a:01.0
>   - This leaves 346M for other things on bus 3a, but it's not all
>     contiguous because the 20M is in the middle.
>   - The remaining 346M might be 1M on one side and 345M on the other
>     (and there are many other possibilities, e.g., 3M + 343M, 5M +
>     341M, ..., 345M + 1M).
>   - The current code tries to assign all 346M to 3a:04.0, which
>     fails because that space is not contiguous, so it falls back to
>     allocating 1M, which works but is insufficient for future
>     hot-adds.

My understanding is that the 20M is aligned to 2M so we need to take
that into account when we distribute the remaining space which makes it
345 instead of 346 which it would be without the alignment.

> Obviously this patch makes *this* situation work: it assigns 345M to
> 3a:04.0 and (I assume) leaves the 1M unused.  But I haven't been able
> to convince myself that this patch works *in general*.

I've tested this patch with full chain of devices with all my three
Intel Gigabit ET2 quad port server adapters connected there along with
other devices and the issue does not happen.

> For example, what if we assigned the 20M from the end of the 366M
> window instead of the beginning, so the 345M piece is below the 20M
> and there's 1M left above it?  That is legal and should work, but I
> suspect this patch would ignore the 345M piece and again assign 1M to
> 3a:04.0.

It should work so that it first allocates resources for the non-hotplug
bridges and after that everything else is put to hotplug bridges.

> Or what if there are several hotplug bridges on bus 3a?  This example
> has two, but there could be many more.
> 
> Or what if there are normal bridges as well as hotplug bridges on bus
> 3a?  Or if they're in arbitrary orders?

Thunderbolt host router with two ports has such configuration where
there are two hotplug ports and two normal ports (there could be more)
and it is hot-added as well. At least that works. With the other
arbitrary scenarios, it is hard to say without actually testing it on a
real hardware.

> > Fixes: 1a5767725cec ("PCI: Distribute available resources to hotplug-capable bridges")
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Cc: stable@vger.kernel.org
> 
> Given my confusion about this, I doubt this satisfies the stable
> kernel "obviously correct" rule.

Fair enough.

> s/substracting/subtracting/ above

OK, thanks.

Also I'm fine dropping this patch altogether and just file a kernel
bugzilla with this information attached. Maybe someone else can provide
a better fix eventually. This is not really common situation anyway
because typically you have only PCIe endpoints included in a Thunderbolt
device (not PCIe switches with a bunch of endpoints connected).
Furthermore, I tried the same in Windows and it does not handle it
properly either ;-)
