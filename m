Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932952AbcL0XoW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Dec 2016 18:44:22 -0500
Date: Tue, 27 Dec 2016 17:44:17 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        g@bhelgaas-glaptop.roam.corp.google.com
Cc: rwright@hpe.com, iommu@lists.linux-foundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: possible dmar_init_reserved_ranges() error
Message-ID: <20161227234417.GA24366@bhelgaas-glaptop.roam.corp.google.com>
References: <20161219212044.GA21774@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161219212044.GA21774@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Dec 19, 2016 at 03:20:44PM -0600, Bjorn Helgaas wrote:
> Hi guys,
> 
> I have some questions about dmar_init_reserved_ranges().  On systems
> where CPU physical address space is not identity-mapped to PCI bus
> address space, e.g., where the PCI host bridge windows have _TRA
> offsets, I'm not sure we're doing the right thing.
> 
> Assume we have a PCI host bridge with _TRA that maps CPU addresses
> 0x80000000-0x9fffffff to PCI bus addresses 0x00000000-0x1fffffff, with
> two PCI devices below it:
> 
>   PCI host bridge domain 0000 [bus 00-3f]
>   PCI host bridge window [mem 0x80000000-0x9fffffff] (bus 0x00000000-0x1fffffff]
>   00:00.0: BAR 0 [mem 0x80000000-0x8ffffffff] (0x00000000-0x0fffffff on bus)
>   00:01.0: BAR 0 [mem 0x90000000-0x9ffffffff] (0x10000000-0x1fffffff on bus)
> 
> The IOMMU init code in dmar_init_reserved_ranges() reserves the PCI
> MMIO space for all devices:
> 
>   pci_iommu_init()
>     intel_iommu_init()
>       dmar_init_reserved_ranges()
>         reserve_iova(0x80000000-0x8ffffffff)
>         reserve_iova(0x90000000-0x9ffffffff)
> 
> This looks odd because we're reserving CPU physical addresses, but
> the IOVA space contains *PCI bus* addresses.  On most x86 systems they
> would be the same, but not on all.

While we're looking at this, here's another question.  We do basically
this:

  dmar_init_reserved_ranges()
  {
    ...
    for_each_pci_dev(pdev) {
      for (i = 0; i < PCI_NUM_RESOURCES; i++) {
        r = &pdev->resource[i];
        reserve_iova(r)

But I assume it's possible to have more than one IOTLB in a system,
so you could have some PCI devices under one IOTLB and others under a
different IOTLB.  So it seems like we should reserve only the IOVA
space used by the devices under *this* IOTLB.

Also, we may hot-add a device under the IOTLB, and I don't see where
we reserve the IOVA space it uses.

I think the best thing to do would be to reserve the host bridge
apertures related to each IOTLB.  That would resolve both questions.
It looks like iova_reserve_pci_windows() does this in the
iommu_dma_init_domain() path.

Bjorn
