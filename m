Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:62290 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759205AbcAUMng convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jan 2016 07:43:36 -0500
From: "Lawrynowicz, Jacek" <jacek.lawrynowicz@intel.com>
To: 'Bjorn Helgaas' <helgaas@kernel.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>,
	"jroedel@suse.de" <jroedel@suse.de>
Subject: RE: [PATCH] pci: Add support for multiple DMA aliases
Date: Thu, 21 Jan 2016 12:43:33 +0000
Message-ID: <36D38C1F74839847A52A484C31F3E51A6213730A@irsmsx105.ger.corp.intel.com>
References: <1453118346-76897-1-git-send-email-jacek.lawrynowicz@intel.com>
 <1453133267-79756-1-git-send-email-jacek.lawrynowicz@intel.com>
 <20160119033315.GA6510@localhost> <20160119201254.GB6510@localhost>
 <1453237471.32741.267.camel@redhat.com> <20160119213901.GG14080@localhost>
 <36D38C1F74839847A52A484C31F3E51A62131B9D@irsmsx105.ger.corp.intel.com>
 <20160120174622.GC7973@localhost>
In-Reply-To: <20160120174622.GC7973@localhost>
Content-Type: text/plain; charset="iso-8859-2"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> Sent: Wednesday, January 20, 2016 6:46 PM
> To: Lawrynowicz, Jacek <jacek.lawrynowicz@intel.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>; linux-
> pci@vger.kernel.org; bhelgaas@google.com; dwmw2@infradead.org;
> jroedel@suse.de
> Subject: Re: [PATCH] pci: Add support for multiple DMA aliases
> 
> Hi Jacek,
> 
> On Wed, Jan 20, 2016 at 03:02:26PM +0000, Lawrynowicz, Jacek wrote:
> > > -----Original Message-----
> > > From: linux-pci-owner@vger.kernel.org [mailto:linux-pci-
> > > owner@vger.kernel.org] On Behalf Of Bjorn Helgaas
> > > Sent: Tuesday, January 19, 2016 10:39 PM
> > > To: Alex Williamson <alex.williamson@redhat.com>
> > > Cc: Lawrynowicz, Jacek <jacek.lawrynowicz@intel.com>; linux-
> > > pci@vger.kernel.org; bhelgaas@google.com; dwmw2@infradead.org;
> > > jroedel@suse.de
> > > Subject: Re: [PATCH] pci: Add support for multiple DMA aliases
> > >
> > > On Tue, Jan 19, 2016 at 02:04:31PM -0700, Alex Williamson wrote:
> > > > On Tue, 2016-01-19 at 14:12 -0600, Bjorn Helgaas wrote:
> > > > > [+cc Alex]
> > > > >
> > > > > On Mon, Jan 18, 2016 at 09:33:15PM -0600, Bjorn Helgaas wrote:
> > > > > > On Mon, Jan 18, 2016 at 05:07:47PM +0100, Jacek Lawrynowicz
> wrote:
> > > > > > > This patch solves IOMMU support issues with PCIe
> > > > > > > non-transparent bridges that use Requester ID look-up tables
> (LUT), e.g.
> > > > > > > PEX8733. Before exiting the bridge, packet's RID is
> > > > > > > rewritten according to LUT programmed by a driver. Modified
> > > > > > > packets are then passed to a destination bus and processed
> > > > > > > upstream. The problem is that such packets seem to come from
> > > > > > > non-existent nodes that are hidden behind NTB and are not
> > > > > > > discoverable by a destination node, so IOMMU discards them.
> > > > > > > Adding DMA alias for a given LUT entry allows IOMMU to
> > > > > > > create a proper mapping that
> > > enables inter-node communication.
> > > > > > >
> > > > > > > The current DMA alias implementation supports only single
> > > > > > > alias, so it's not possible to connect more than two nodes
> > > > > > > when IOMMU is enabled. This implementation enables all
> > > > > > > possible aliases on a given bus (256) that are stored in a
> > > > > > > bitset. Alias devfn is directly translated to a bit number.
> > > > > > > The bitset is not allocated for devices that have no need for DMA
> aliases.
> > > >
> > > > My only concern here is that pci_add_dma_alias() makes aliases
> > > > seem more dynamic than they really are.  For instance, when we add
> > > > a device to an IOMMU domain, we evaluate the aliases at that
> > > > point, if an NTB later adds a new lookup entry and specifies a new
> > > > alias, it's still not going to work.  Similarly, IOMMU groups are
> > > > evaluated as the device is added, so if an alias is to a physical
> > > > device and we need the cross reference to bind them together into
> > > > a single group, calling
> > > > pci_add_dma_alias() from a driver isn't going to work.
> > > >
> > > > The existing code had this problem too, it's just more obvious now
> > > > that we have a helper function and that the helper is exported for
> > > > use outside of the PCI core.  Thanks,
> > >
> > > Oh, that's a really good point.  I hadn't noticed the export.  Is
> > > there any reason pci_add_dma_alias() needs to be declared in
> > > include/linux/pci.h and exported to modules?
> > >
> > > I don't think the current patch requires the export, but I suppose
> > > you envision an NTB driver that might be a module?  I guess we can
> > > easily export it when that driver is merged if that seems the best
> solution.
> >
> > This export would be useful for Xeon Phi x200 which uses on a NTB
> > generating multiple RIDs. x200 is not yet ready for upstreming (x100
> > is already upstreamed) and having this export would make driver
> development less painful.
> 
> I don't really want to merge things that only exist to enable out-of-tree
> development, because (1) they're an extra maintenance burden for which
> we get risk without benefit, and (2) we can't see the out-of-tree code, so it's
> easy for people to make changes that accidentally break that code.
> 
> Looking at the patch again, I see that even without the export, there's no
> current benefit, and there are a couple things that should be fixed up:
> 
>   - Fix the comment that references dma_alias_devfn (since you removed
>     that field).
> 
>   - Add an interface that get_pci_alias_group() can use instead of
>     accessing the dma_alias_mask directly.
> 
>   - Figure out the scope and exportability of pci_add_dma_alias() and
>     the new boolean interface I'm suggesting.
> 
> So I'm going to drop this for now, and you can carry it along with your driver
> patches.  Then when we merge the driver, we should think about whether it
> makes sense to export pci_add_dma_alias(), or whether we can come up
> with an interface that is safer with regard to the issues Alex mentioned.
> 
> I think this patch makes a lot of sense, so I'm definitely not rejecting it.  But I
> think it will make even more sense in the context of the driver, when we can
> think about the lifetime of the aliases.
> (*You* know that already, but I don't, so I'm operating with a lot of missing
> information :))

I would understand rejecting the patch if it would be specific to out of the tree
driver. It make perfect sense from kernel development perspective but this
patch is not device specific and everyone previously agreed it improves current
dma alias handling. It's also small and without the export it has very little
maintenance impact.

Please reconsider merging the patch.

--
Jacek Lawrynowicz
Intel Technology Poland sp. z o.o.
KRS 101882 - ul. Slowackiego 173, 80-298 Gdansk



