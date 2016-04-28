Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Thu, 28 Apr 2016 10:12:12 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Tomasz Nowicki <tn@semihalf.com>, arnd@arndb.de,
	will.deacon@arm.com, catalin.marinas@arm.com, rafael@kernel.org,
	hanjun.guo@linaro.org, okaya@codeaurora.org,
	jiang.liu@linux.intel.com, jchandra@broadcom.com,
	robert.richter@caviumnetworks.com, mw@semihalf.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
	jcm@redhat.com
Subject: Re: [PATCH V6 02/13] pci, acpi: Provide generic way to assign bus
 domain number.
Message-ID: <20160428150815.GB15598@localhost>
References: <1460740008-19489-1-git-send-email-tn@semihalf.com>
 <1460740008-19489-3-git-send-email-tn@semihalf.com>
 <20160427022649.GD6789@localhost>
 <20160427111758.GA6234@red-moon>
 <20160427164453.GB17629@localhost>
 <20160427173118.GA26653@red-moon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160427173118.GA26653@red-moon>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Apr 27, 2016 at 06:31:29PM +0100, Lorenzo Pieralisi wrote:
> On Wed, Apr 27, 2016 at 11:44:53AM -0500, Bjorn Helgaas wrote:
> > On Wed, Apr 27, 2016 at 12:17:58PM +0100, Lorenzo Pieralisi wrote:
> > > On Tue, Apr 26, 2016 at 09:26:49PM -0500, Bjorn Helgaas wrote:
> > > > On Fri, Apr 15, 2016 at 07:06:37PM +0200, Tomasz Nowicki wrote:


> > Today we call pci_bus_assign_domain_nr() from the PCI core (from
> > pci_create_root_bus()).  This is only implemented for
> > PCI_DOMAINS_GENERIC, but even so, it fiddles around to figure out
> > whether to get the domain from DT or to assign a new one.
> > 
> > That seems backwards to me.  The host bridge drivers already know
> > where the domain should come from (ACPI _SEG, DT, etc.) and in the
> > long term, I think they should be responsible for looking up or
> > assigning a domain number *before* they call pci_create_root_bus().
> 
> Yes, the question still is how pci_create_root_bus() can get that
> value (I am pretty certain this was heavily debated in the past, which
> does not mean we can't give it another try).

Right, we don't have a good mechanism for passing more info into
pci_create_root_bus().  Maybe the caller could fill in a struct so we
have a chance to extend it without having to change all the existing
callers.

I wonder if there's a design pattern we can copy, e.g., would
something like the scsi_host_alloc(), scsi_add_host(),
scsi_scan_host() model work here?

> > > > > +void pci_bus_assign_domain_nr(struct pci_bus *bus, struct device *parent)
> > > > > +{
> > > > > +	bus->domain_nr = acpi_disabled ? of_pci_bus_domain_nr(parent) :
> > > > > +					 acpi_pci_bus_domain_nr(parent);
> > 
> > We have the pci_bus * here, so to_pci_host_bridge(bus->bridge) gives
> > us the struct pci_host_bridge.  I can't remember why we put domain_nr
> > in the struct pci_bus instead of in the struct pci_host_bridge.  It
> > seems like pci_host_bridge is the more logical place for it, because
> > every bus below the host bridge must have the same domain by
> > definition.
> > 
> > Would it be feasible to either (a) move domain_nr to the
> > pci_host_bridge, or (b) change acpi_pci_bus_domain_nr() so it uses the
> > struct pci_bus * or the struct device * to find the struct
> > acpi_pci_root where segment has already been stored by
> > acpi_pci_root_add()?
> 
> (b) is what JC implemented even though it works differently for
> different hosts since it all depends on what's in bus->sysdata.
> 
> It can certainly be done in a generic way (that works on X86 and IA64
> too), let's give it more thought.
> 
> > Another wrinkle is the quirk added by 1f09b09b4de0 ("x86/PCI: Ignore
> > _SEG on HP xw9300").  x86 doesn't use PCI_DOMAINS_GENERIC yet, so this
> > patch wouldn't break it, but I hope x86 can use PCI_DOMAINS_GENERIC in
> > the future, and then it will be a problem if we evaluate _SEG again.
> 
> Yes, I share your concern here and I thought about that, if that's the
> end goal let's find a solution that works across arches (or we temporarily
> use JC's code and we then generalize it).

I would ultimately like all arches to use PCI_DOMAINS_GENERIC, because
I don't think there's anything intrisically arch-specific about where
we store the domain number.  The means of discovering or assigning a
domain number might be arch-specific, but I think it would be cleanest
if the host bridge driver handled that.

Bjorn
