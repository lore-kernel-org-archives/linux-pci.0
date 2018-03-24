Return-Path: <SRS0=8W8s=GO=h08.hostsharing.net=foo00@kernel.org>
Return-Path: <SRS0=8W8s=GO=h08.hostsharing.net=foo00@kernel.org>
Date: Sat, 24 Mar 2018 13:15:41 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Len Brown <lenb@kernel.org>, Keith Busch <keith.busch@intel.com>,
	Linux PCI <linux-pci@vger.kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 1/2] PCI/DPC: Disable interrupt generation during suspend
Message-ID: <20180324121541.GA15525@wunner.de>
References: <20180320104508.GF2703@lahna.fi.intel.com>
 <20180320113556.GA24197@wunner.de>
 <20180322104517.GA20389@wunner.de>
 <20180322165317.GI2703@lahna.fi.intel.com>
 <20180322173903.GA15503@wunner.de>
 <20180322193630.GB252023@bhelgaas-glaptop.roam.corp.google.com>
 <20180323111856.GO2703@lahna.fi.intel.com>
 <20180323210857.GA210003@bhelgaas-glaptop.roam.corp.google.com>
 <CAJZ5v0iFSgC4gbWCi09Nr4rwa7r4QfAQ__Oz88cagMZ3Z_NnKg@mail.gmail.com>
 <20180323220127.GD210003@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20180323220127.GD210003@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Fri, Mar 23, 2018 at 05:01:27PM -0500, Bjorn Helgaas wrote:
> On Fri, Mar 23, 2018 at 10:11:53PM +0100, Rafael J. Wysocki wrote:
> > On Fri, Mar 23, 2018 at 10:08 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Fri, Mar 23, 2018 at 01:18:56PM +0200, Mika Westerberg wrote:
> > >> On Thu, Mar 22, 2018 at 02:36:30PM -0500, Bjorn Helgaas wrote:
> > >> > I hope we can avoid adding suspend_late/resume_early callbacks in
> > >> > struct pcie_port_service_driver, and I also hope we can avoid adding
> > >> > device links.  Those both sound pretty complicated.
> > >> >
> > >> > Can you do something like the patch below, which does something
> > >> > similar for PME?
> > >>
> > >> AFAICT the core PCI PM code follows the same ordering than what PM core
> > >> does so it may be possible that not all service drivers get
> > >> resumed/suspended before other children (PCI buses). Basically this
> > >> would be the same than just using core PM ops in DPC driver (in which
> > >> case DPC specific things are still kept in DPC driver not in PCI core).
> > >
> > > I'm not sure I follow this.  I assume the core PCI PM code guarantees
> > > that a bridge is suspended after its children and resumed before them.
> > > Are you saying that's not the case?
> > 
> > if this is a PCIe port, then there are two categories of childres:
> > port services and the PCI devices below it.
> > 
> > There are no ordering constraints between the former and the latter,
> > which appears to be a problem here.
> 
> It seems like a pretty fundamental problem if port services can be
> suspended before PCI devices below the port.  I assume that would have
> to be fixed somehow in the PCI core and the port driver, but this
> patch only touches the DPC service driver.
> 
> I'd really like to get rid of the port services driver altogether, and
> this ordering issue seems like a good reason to do that.

As it is, there is nothing to fix.

The port services driver enforces that the services are resumed before
PCI child devices (and after them on suspend) by iterating over the
services' ->resume / ->suspend callbacks, see pcie_port_device_resume()
and pcie_port_device_suspend(), which in turn are the port's ->resume /
->suspend callbacks.

There is (or was, before your reorganization this cycle) an inconsistency
in the handling of ->resume / ->suspend stages vis-à-vis the ->resume_noirq /
->runtime_resume / ->runtime_>suspend / ->runtime_idle stages.  The latter
are handled directly by portdrv callbacks whereas the former are handled
by per-service callbacks which we iterate over.

I cooked up these commits two years ago to make the handling more consistent
but ended up not needing them:
https://github.com/l1k/linux/commit/4f59372f830899e89fea9ba7c090680900d5998e
https://github.com/l1k/linux/commit/ce63b6ed01602e77c56043ee6dfa52ca9d257f88

Thanks,

Lukas
