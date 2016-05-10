Return-Path: <lorenzo.pieralisi@arm.com>
Return-Path: <lorenzo.pieralisi@arm.com>
Date: Tue, 10 May 2016 11:07:28 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Tomasz Nowicki <tn@semihalf.com>, arnd@arndb.de,
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
Subject: Re: [PATCH V6 01/13] pci, acpi, x86, ia64: Move ACPI host bridge
 device companion assignment to core code.
Message-ID: <20160510100728.GA15552@red-moon>
References: <1460740008-19489-1-git-send-email-tn@semihalf.com>
 <1460740008-19489-2-git-send-email-tn@semihalf.com>
 <292578579.uIxhMjkdfG@vostro.rjw.lan>
 <20160510015336.GA29582@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160510015336.GA29582@localhost>
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 09, 2016 at 08:53:36PM -0500, Bjorn Helgaas wrote:
> On Tue, May 10, 2016 at 12:56:37AM +0200, Rafael J. Wysocki wrote:
> > On Friday, April 15, 2016 07:06:36 PM Tomasz Nowicki wrote:
> > > Currently we have two platforms (x86 & ia64) capable of PCI ACPI host
> > > bridge initialization. They both use arch-specific sysdata to pass down
> > > parent device reference and both rely on NULL parent in pci_create_root_bus()
> > > to validate sysdata content.
> > 
> > No, this is not relied on for that.  It is just NULL, because we don't
> > have a physical parent device representation for the PCI host bridge.
> > 
> > > It looks hacky and prevents us from getting some firmware specific
> > > info for PCI host controller based on its acpi_device structure
> > > in generic pci_create_root_bus() function.
> > 
> > You can't get that info without adding ACPI-specific code to that function
> > anyway.
> > 
> > > However, we overcome that blocker by passing down parent device via
> > > pci_create_root_bus parameter (as the ACPI device type).
> > 
> > Which is completely wrong.
> > 
> > > Then we use ACPI_COMPANION_SET in core code
> > > for ACPI boot method only. ACPI_COMPANION_SET is safe to run for all
> > > cases DT, ACPI and DT&ACPI.
> > > 
> > > Since now PCI core code is setting ACPI companion device for us,
> > > x86 & ia64 specific ACPI companion device setting turns out to be dead now.
> > > We can get rid of it, including related companion reference from
> > > PCI sysdata structure. Aslo, PCI_CONTROLLER macro cannot return valid
> > > companion device anymore. Therefore we need to convert its usage to
> > > ACPI_COMPANION.
> 
> I think getting rid of arch-specific sysdata is a good goal (at least
> for things like the domain and ACPI companion that are really not
> arch-specific).
> 
> But I'm afraid I've been guilty of allowing the perfect to be the
> enemy of the good.  I think it will be more useful in the end if we
> can get as much of this work in v4.7 as possible, even if there's more
> polishing we'd like to do later.
> 
> What if we keep the x86 and ia64 handling of ACPI_COMPANION the way it
> is today, and do it the same way for arm64?  Then later, after we
> merge Arnd's work to make a generic pci_register_host() or similar, I
> suspect we might be able to unify the ACPI_COMPANION stuff more
> easily.  If the driver (acpi/pci_root.c) allocates the struct
> pci_host_bridge, then maybe it will be able to fill in the domain and
> set up the ACPI_COMPANION before it calls the scan interface.

Ok, JC already solved that problem like this:

http://www.spinics.net/lists/arm-kernel/msg478167.html
http://www.spinics.net/lists/arm-kernel/msg478169.html

Since ARM64 relies on PCI_DOMAINS_GENERIC (DT) I do not see any other
way of pulling it off quickly (and in a really generic way), sysdata
is the only way of handling it in ACPI unless we start clutching
at straws (which we already did with the ACPI companion hacks).

Thanks,
Lorenzo
