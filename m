Return-Path: <SRS0=s/JU=GV=linux.intel.com=mika.westerberg@kernel.org>
Return-Path: <SRS0=s/JU=GV=linux.intel.com=mika.westerberg@kernel.org>
Date: Sat, 31 Mar 2018 12:20:17 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <lenb@kernel.org>, Mario.Limonciello@dell.com,
	Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <yehezkel.bernat@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v3 1/5] PCI: Make sure all bridges reserve at least one
 bus number
Message-ID: <20180331092017.GS2703@lahna.fi.intel.com>
References: <20180226132112.81447-1-mika.westerberg@linux.intel.com>
 <20180226132112.81447-2-mika.westerberg@linux.intel.com>
 <20180327185742.GB7759@bhelgaas-glaptop.roam.corp.google.com>
 <20180328114346.GZ2703@lahna.fi.intel.com>
 <20180328180906.GI7759@bhelgaas-glaptop.roam.corp.google.com>
 <20180329115911.GN2703@lahna.fi.intel.com>
 <20180331082903.GA21051@wunner.de>
 <20180331085852.GQ2703@lahna.fi.intel.com>
 <20180331091245.GA10720@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180331091245.GA10720@wunner.de>
List-ID: <linux-pci.vger.kernel.org>

On Sat, Mar 31, 2018 at 11:12:45AM +0200, Lukas Wunner wrote:
> On Sat, Mar 31, 2018 at 11:58:52AM +0300, Mika Westerberg wrote:
> > On Sat, Mar 31, 2018 at 10:29:03AM +0200, Lukas Wunner wrote:
> > > On Thu, Mar 29, 2018 at 02:59:11PM +0300, Mika Westerberg wrote:
> > > > On Wed, Mar 28, 2018 at 01:09:06PM -0500, Bjorn Helgaas wrote:
> > > > > The same issue could happen on any system where we use acpiphp, so I
> > > > > don't think Thunderbolt is really relevant here, and it's easy to
> > > > > confuse things by mentioning it.
> > > > 
> > > > This issue can happen regardless whether acpiphp is used or not.
> > > 
> > > If the platform has yielded hotplug control to the OS via _OSC,
> > > I don't see how the platform could hot-add devices.  So surely
> > > reserving a bus number for a bridge without anything below it
> > > can be constrained to the !pciehp_is_native(bridge) case?
> > 
> > Nothing prevents ACPI Notify() happening while native PCIe hotplug is
> > used on non-hotplug ports (the ones not controlled by pciehp). And it
> > cannot be constrained to !pciehp_is_native(bridge) because it is the
> > root port that has the _OSC but below it can be non-hotplug ports where
> > ACPI Notify() is used to bring in additional devices.
> 
> That sounds like a violation of the spec to me.
> 
> ACPI 6.1 table 6-178 says if OS is granted control over PCIe hotplug,
> the firmware "must ensure that all hot plug events are routed to device
> interrupts", which wouldn't be the case for Notify() because the
> interrupt generated is an SCI, not an MSI or INTx interrupt for the
> hotplug port itself.
> 
> Moreover, "after control is transferred to the OS, firmware must not
> update the state of hot plug slots, including the state of the
> indicators and power controller."
> 
> Maybe I've misunderstood the spec all the time, my understanding was
> that if OS is granted control, the firmware won't do anything with
> hotplug ports below the host bridge, period.

The whole point here is that those are *not* hotplug slots just regular
downstream ports.
