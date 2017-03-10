Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932697AbdCJUPB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 10 Mar 2017 15:15:01 -0500
Date: Fri, 10 Mar 2017 14:14:52 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Joerg Roedel <joro@8bytes.org>
Cc: Sinan Kaya <okaya@codeaurora.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        iommu@lists.linux-foundation.org
Subject: Re: Partial BAR Address Allocation
Message-ID: <20170310201452.GH19517@bhelgaas-glaptop.roam.corp.google.com>
References: <35c6bec9-58e8-a1f7-5a85-d80c23480d32@codeaurora.org>
 <20170222184440.GA2132@bhelgaas-glaptop.roam.corp.google.com>
 <43c1ff36-fc50-8ea4-02fe-7b1d573a1efd@codeaurora.org>
 <20170222233944.GB4359@bhelgaas-glaptop.roam.corp.google.com>
 <20170306110439.GC27724@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170306110439.GC27724@8bytes.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 06, 2017 at 12:04:39PM +0100, Joerg Roedel wrote:
> On Wed, Feb 22, 2017 at 05:39:44PM -0600, Bjorn Helgaas wrote:
> > [+cc Joerg, iommu list]
> > 
> > On Wed, Feb 22, 2017 at 03:44:53PM -0500, Sinan Kaya wrote:
> > > On 2/22/2017 1:44 PM, Bjorn Helgaas wrote:
> > > > There is no way for a driver to say "I only need this memory BAR and
> > > > not the other ones."  The reason is because the PCI_COMMAND_MEMORY bit
> > > > enables *all* the memory BARs; there's no way to enable memory BARs
> > > > selectively.  If we enable memory BARs and one of them is unassigned,
> > > > that unassigned BAR is enabled, and the device will respond at
> > > > whatever address the register happens to contain, and that may cause
> > > > conflicts.
> 
> Hmm, maybe I am missing something, but isn't this only a problem if the
> 'unassigned' BAR as an address configured that also falls into the
> Bridge-Window of the parent bridge? Otherwise no requests should be
> routed to the BAR anyway, right?

I guess it's true that we could safely enable a memory BAR if the
upstream bridge would never route anything to it.

But it would depend on the size of the BAR and the upstream bridge's
configuration, so it doesn't feel like it would really be reliable in
general.

> > But if there *is* address translation in the PIO direction, we can
> > have conflicts because the bridge can translate CPU-side PIO accesses
> > to arbitrary PCI bus addresses.
> 
> I am not aware of any hardware that does translation on the PIO space.
> The IOMMUs I know of don't care about PIO at all.

Right, address translation in the PIO direction would be done by the
host bridge, not the IOMMU.  There are a fair number of bridges that
do this -- basically all the callers of pci_add_resource_offset().
They just apply a constant offset, often by chopping off some
high-order bits of the CPU address.

Bjorn
