Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:46680 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751644AbcDONIJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 15 Apr 2016 09:08:09 -0400
Date: Fri, 15 Apr 2016 08:08:03 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	David Daney <david.daney@cavium.com>,
	Will Deacon <will.deacon@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Russell King <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 2/3] drivers: pci: host-generic: claim bus resources
 on PCI_PROBE_ONLY set-ups
Message-ID: <20160415130803.GA2105@localhost>
References: <1456843449-19393-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1456843449-19393-3-git-send-email-lorenzo.pieralisi@arm.com>
 <20160412044311.GB11361@localhost>
 <20160412154810.GA32109@red-moon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160412154810.GA32109@red-moon>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 12, 2016 at 04:48:10PM +0100, Lorenzo Pieralisi wrote:
> On Mon, Apr 11, 2016 at 11:43:11PM -0500, Bjorn Helgaas wrote:
> > Hi Lorenzo,
> > 
> > On Tue, Mar 01, 2016 at 02:44:08PM +0000, Lorenzo Pieralisi wrote:
> > > The PCI host generic driver does not reassign bus resources on systems
> > > that require the BARs set-up to be immutable (ie PCI_PROBE_ONLY) since
> > > that would trigger system failures. Nonetheless, PCI bus resources
> > > allocated to PCI bridge and devices must be claimed in order to be
> > > validated and inserted in the kernel resource tree, but the current
> > > driver omits the resources claiming and relies on arch specific kludges
> > > to prevent probing failure (ie preventing resources enablement on
> > > PCI_PROBE_ONLY systems).
> > > 
> > > This patch adds code to the PCI host generic driver that correctly
> > > claims bus resources upon probe on systems that are required to
> > > prevent reassignment after bus enumeration, so that the allocated
> > > resources can be enabled successfully upon PCI device drivers probing,
> > > without resorting to arch back-ends workarounds.
> > > 
> > > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > Acked-by: Will Deacon <will.deacon@arm.com>
> > > Cc: Arnd Bergmann <arnd@arndb.de>
> > > Cc: David Daney <david.daney@cavium.com>
> > > Cc: Will Deacon <will.deacon@arm.com>
> > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > ---
> > >  drivers/pci/host/pci-host-generic.c | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/pci/host/pci-host-generic.c b/drivers/pci/host/pci-host-generic.c
> > > index 1652bc7..e529825 100644
> > > --- a/drivers/pci/host/pci-host-generic.c
> > > +++ b/drivers/pci/host/pci-host-generic.c
> > > @@ -252,7 +252,10 @@ static int gen_pci_probe(struct platform_device *pdev)
> > >  
> > >  	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
> > >  
> > > -	if (!pci_has_flag(PCI_PROBE_ONLY)) {
> > > +
> > > +	if (pci_has_flag(PCI_PROBE_ONLY)) {
> > > +		pci_bus_claim_resources(bus);
> > > +	} else {
> > >  		pci_bus_size_bridges(bus);
> > >  		pci_bus_assign_resources(bus);
> > >  
> > 
> > The next patch removes the arm and arm64 pcibios_enable_device()
> > implementations, which implies that arm and arm64 only need the generic
> > version, which simply calls pci_enable_resources().  That assumes r->parent
> > is set.
> > 
> > After this patch, we'll call pci_bus_claim_resources() for the
> > PCI_PROBE_ONLY case, and that sets r->parent for all the resources.
> > 
> > Where does r->parent get set in the non-PCI_PROBE_ONLY case?  Obviously
> > that path *works*, because you're not changing anything there.  I'd just
> > like to have a hint that makes this change more obvious.
> 
> On all ARM/ARM64 PCI controllers drivers I am aware of (apart from the
> kvmtool PCI host controller which does require PCI_PROBE_ONLY, so we need
> this patch), resources are always reassigned and the core code reassigning
> them takes care of assigning their parent pointers too, to answer your
> question.

Here's what I find confusing.  Consider these three cases:

  1) Firmware programs no BARs and we reassign everything.  We call
  pci_bus_assign_resources(), and the pci_assign_resource() ...
  allocate_resource() path makes sure everything is claimed.  This is
  apparently the normal arm/arm64 path, and it already works.

  2) Firmware programs all BARs and we set PCI_PROBE_ONLY.  After this
  series, we'll claim the resources and remove the PCI_PROBE_ONLY
  special case in pcibios_enable_device().  This is great!

  3) Firmware programs all BARs but we don't set PCI_PROBE_ONLY.  We
  call pci_bus_assign_resources(), but I think it does nothing because
  everything is already assigned.  The resources are not claimed and
  pci_enable_resources() will fail.

This last case 3) is the problem.  I'm guessing this case doesn't
currently occur on arm/arm64, but it's the normal case on x86, and it
seems perverse that things work if firmware does nothing, but they
don't work if firmware does more setup.

So I think we should add some sort of arm/arm64-specific
pci_claim_resource() path similar to the pcibios_allocate_resources()
stuff on x86.

> As for this patch series, given that:
> 
> commit (in -next) 903589ca7165 ("ARM: 8554/1: kernel: pci: remove
> pci=firmware command line parameter handling") removes the PCI_PROBE_ONLY
> handling from the (ARM) command line, the PCI host generic becomes the
> last ARM/ARM64 host controller that requires PCI_PROBE_ONLY to function
> (depending on DT settings).
> 
> The idea behind adding pci_bus_claim_resources (patch 1) to core code
> was that it could be reused by other arches too, I do not have evidence
> though, I have to prove it, so I'd rather squash patch 1 into this one
> and make the code claiming resources local to the PCI host generic,
> I can't add a generic PCI core API just for one host controller
> (IMHO we should add an API that allows us to claim bus resources and
> realloc the ones for which claiming fail - which may mean releasing
> bridges resources and realloc/resize them - code is in the kernel already
> I have to write that API).
> 
> The code claiming resources on x86, IA64 and PowerPC looks extremely
> similar but it has to be proven that a generic function has a chance
> to work, so patch 1 is not really justified at present.

I don't really object to patch 1, but you're right that it's possible
we could do a better job later.  I would certainly like to get that
sort of code (including the pcibios_allocate_resources() stuff I just
mentioned) out of the arches and into the core somehow.

> If you have no objections I will squash patch 1 into this one (moving
> the respective code in PCI host generic driver), and I would not merge
> this series till the commit above in -next gets in the kernel (which
> makes sure that PCI_PROBE_ONLY can't be set on the command line, that's
> fundamental to this series, at least on ARM, on ARM64 DT is the only way
> PCI_PROBE_ONLY can be set and only on host controllers that check the
> chosen node property - ie PCI host generic, that we are patching).

If there's a stable branch containing 903589ca7165 ("ARM: 8554/1:
kernel: pci: remove pci=firmware command line parameter handling"), I
can pull that and merge your series on top of it.

Bjorn
