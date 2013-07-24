Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f44.google.com ([209.85.219.44]:38622 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752699Ab3GXXYa (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 24 Jul 2013 19:24:30 -0400
Received: by mail-oa0-f44.google.com with SMTP id l10so2618810oag.31
        for <linux-pci@vger.kernel.org>; Wed, 24 Jul 2013 16:24:30 -0700 (PDT)
Date: Wed, 24 Jul 2013 17:24:27 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	"open list:INTEL IOMMU (VT-d)" <iommu@lists.linux-foundation.org>,
	Andrew Cooks <acooks@gmail.com>,
	Don Dutile <ddutile@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>
Subject: Re: [RFC PATCH v2 1/2] pci: Create PCIe requester ID interface
Message-ID: <20130724232427.GA9272@google.com>
References: <20130711204439.1701.90503.stgit@bling.home>
 <20130711210326.1701.56478.stgit@bling.home>
 <20130723223533.GB19765@google.com>
 <1374621703.15429.98.camel@ul30vt.home>
 <CAErSpo6bcGCjqdxn-bz_vjo+HsAiOxDu=--mD7veEZ9f7k+gyA@mail.gmail.com>
 <1374689548.5208.62.camel@ul30vt.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1374689548.5208.62.camel@ul30vt.home>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 24, 2013 at 12:12:28PM -0600, Alex Williamson wrote:
> On Wed, 2013-07-24 at 10:47 -0600, Bjorn Helgaas wrote:
> > On Tue, Jul 23, 2013 at 5:21 PM, Alex Williamson
> > <alex.williamson@redhat.com> wrote:
> > > On Tue, 2013-07-23 at 16:35 -0600, Bjorn Helgaas wrote:
> > >> On Thu, Jul 11, 2013 at 03:03:27PM -0600, Alex Williamson wrote:
> >   As the DMA
> > transaction propagates through the fabric, it may be tagged by bridges
> > with different requester IDs.
> > 
> > The requester IDs are needed outside PCI (by IOMMU drivers), but I'm
> > not sure the intermediate pci_devs are.
> 
> A u16 requester ID doesn't mean much on it's own though, it's not
> necessarily even unique.  A requester ID associated with the context of
> a pci_dev is unique and gives us a reference point if we need to perform
> another operation on that requester ID.

A u16 requester ID better mean something to an IOMMU -- it's all the
IOMMU can use to look up the correct mapping.  That's why we have to
give the iterator something to define the scope to iterate over.  The
same requester ID could mean something totally unrelated in a
different scope, e.g., below a different IOMMU.

> > Returning both a pci_dev and a requester ID makes it more complicated.
> >  At the hardware level, transactions contain only a requester ID, and
> > bridges can either drop it, pass it unchanged, or assign a new one.  I
> > think the code will be simpler if we just model that.
> 
> I'm not convinced.  Patch 2/2 makes use of both the returned pci_dev and
> the returned requester ID and it's a huge simplification overall.

The IOMMU driver makes mappings so DMA from device A can reach a
buffer.  It needs to know about device A, and it needs to know what
source IDs might appear on those DMA transactions.  Why would it need
to know anything about any bridges between A and the IOMMU?

> > My thought was to pass a pci_dev (the originator of the DMA, which I
> > would call the "requester") and a callback.  The callback would accept
> > the requester pci_dev (always the same requester device) and a
> > requester ID.
> > 
> > This would call @fn for each possible requester ID for transactions
> > from the device.  IOMMU drivers should only need the requester ID to
> > manage mappings; they shouldn't need a pci_dev corresponding to any
> > intermediate bridges.
> 
> This implementation is almost the same with the only change being that
> the pci_dev passed to the callback is the one most closely associated
> with the requester ID.  For the IOMMU driver, it doesn't matter since
> it's only using the requester ID, but why would the callback care about
> the original requester?  If it needed to do something device specific,
> it's going to care about the closest device to the requester ID.

If this can be done without passing a pci_dev at all to the callback,
that would be even better.  If a caller needed the original pci_dev,
it could always pass it via the "void *data".

I don't see the point of passing a "device closest to the requester
ID."  What would the IOMMU do with that?  As far as the IOMMU is
concerned, the requester ID could be an arbitrary number completely
unrelated to a pci_dev.

> > >> > +struct pci_dev *pci_get_visible_pcie_requester(struct pci_dev *requestee,
> > >> > +                                          struct pci_dev *bridge,
> > >> > +                                          u16 *requester_id);
> > >>
> > >> The structure of this interface implies that there is only one visible
> > >> requester ID, but the whole point of this patch is that a transaction from
> > >> @requestee may appear with one of several requester IDs.  So which one will
> > >> this return?
> > >
> > > I thought the point of this patch was to have an integrated interface
> > > for finding the requester ID and doing something across all devices with
> > > that requester ID
> > 
> > Oh, here's the difference in our understanding.  "Doing something
> > across all devices with that requester ID" sounds like identifying the
> > set of devices that have to be handled as a group by the IOMMU.
> > That's certainly an issue, but I wasn't considering it at all.
> > 
> > I was only concerned with the question of a single device that
> > requires multiple IOMMU mappings because DMA requests might use any of
> > several source IDs.  This is mentioned in sec 3.6.1.1 of the VT-d
> > spec, i.e., "requests arriving with the source-id in the original
> > PCI-X transaction or the source-id provided by the bridge. ...
> > software must program multiple context entries, each corresponding to
> > the possible set of source-ids."
> > 
> > My thought was that the IOMMU driver would use
> > pcie_for_each_requester_id() and have the callback set up a mapping
> > for one requester ID each time it was called.
> 
> Which is exactly what pcie_for_each_requester() does, but I try to solve
> the problem of a single device that needs multiple context entries the
> same as a bridge that masks multiple devices.

I'm not sure I understand your point yet, but I think it's better to
think of this as computing the set of requester IDs we might see from
a given device.  If we think of it as finding the set of devices that
use a given requester ID, then we have to worry about that set being
modified by hotplug.

> > > and thereby remove pci_find_upstream_pcie_bridge(),
> > > provide a way to quirk broken PCIe-to-PCI bridge and quirk dma_ops for
> > > devices that use the wrong requester ID.  In what case does a device
> > > appear to have multiple requester IDs?  We have cases where devices use
> > > the wrong requester ID, but AFAIK they only use a single wrong requester
> > > ID.
> > 
> > I think the example in sec 3.6.1.1 answers this, doesn't it?
> 
> It does, in summary we have to be prepared that a transaction from a
> device behind a PCIe-to-PCI/X bridge may use either the device requester
> ID (bus|devfn) or the bridge (subordinate|0) requester ID.  This is why
> pcie_for_each_requester() makes sense to me, we iterate across all
> requesters that may use the same requester ID.

Let's say device A and B use the same requester ID because they're
behind a bridge.  What happens if we map a buffer for A and then
hot-remove B?  Here's what I think your proposal would do:

  map buffer for A
    callback for A
    callback for B
  hot-remove B
  unmap buffer for A
    callback for A

We never do an unmap callback for B, so if we did anything while
mapping, it will never be undone.

> If we had a
> pcie_for_each_requester_id() how would we handle that?  Do we call it
> once for the (bus|devfn) requester ID of the device we're trying to map
> and then call it again for the (subordinate|0) requester ID of the
> bridge?  That's almost how pci_find_upstream_pcie_bridge() is used and
> it ends up putting a lot of the logic into the driver.  

That *is* what I'm proposing (calling the callback once for each
possible requester ID that could be seen on DMA from the device).  In
my opinion, the problem with pci_find_upstream_pcie_bridge() is that
you only get one device back from it, and the driver has to roll its
own looping.

> How do we write
> a pcie_for_each_requester_id() function that can uniquely identify a PCI
> hierarchy to traverse in the presences of multiple domains?  

I must be missing something in your question.  If we give
pcie_for_each_requester_id() the requester pci_dev, that uniquely
identifies the PCI hierarchy.  Then it's just a question of how far up
the hierarchy we need to go, and the bridge (or bus) argument tells us
that.

Bjorn
