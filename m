Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752851AbcLSVUs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 19 Dec 2016 16:20:48 -0500
Date: Mon, 19 Dec 2016 15:20:44 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>
Cc: rwright@hpe.com, iommu@lists.linux-foundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: possible dmar_init_reserved_ranges() error
Message-ID: <20161219212044.GA21774@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi guys,

I have some questions about dmar_init_reserved_ranges().  On systems
where CPU physical address space is not identity-mapped to PCI bus
address space, e.g., where the PCI host bridge windows have _TRA
offsets, I'm not sure we're doing the right thing.

Assume we have a PCI host bridge with _TRA that maps CPU addresses
0x80000000-0x9fffffff to PCI bus addresses 0x00000000-0x1fffffff, with
two PCI devices below it:

  PCI host bridge domain 0000 [bus 00-3f]
  PCI host bridge window [mem 0x80000000-0x9fffffff] (bus 0x00000000-0x1fffffff]
  00:00.0: BAR 0 [mem 0x80000000-0x8ffffffff] (0x00000000-0x0fffffff on bus)
  00:01.0: BAR 0 [mem 0x90000000-0x9ffffffff] (0x10000000-0x1fffffff on bus)

The IOMMU init code in dmar_init_reserved_ranges() reserves the PCI
MMIO space for all devices:

  pci_iommu_init()
    intel_iommu_init()
      dmar_init_reserved_ranges()
        reserve_iova(0x80000000-0x8ffffffff)
        reserve_iova(0x90000000-0x9ffffffff)

This looks odd because we're reserving CPU physical addresses, but
the IOVA space contains *PCI bus* addresses.  On most x86 systems they
would be the same, but not on all.

Assume the driver for 00:00.0 maps a page of main memory for DMA.  It
may receive a dma_addr_t of 0x10000000:

  00:00.0: intel_map_page() returns dma_addr_t 0x10000000
  00:00.0: issues DMA to 0x10000000

What happens here?  The DMA access should go to main memory.  In
conventional PCI it would be a peer-to-peer access to device 00:01.0.
Is there enough PCIe smarts (ACS or something?) to do otherwise?

The dmar_init_reserved_ranges() comment says "Reserve all PCI MMIO to
avoid peer-to-peer access."  Without _TRA, CPU addresses and PCI bus
addresses would be identical, and I think these reserve_iova() calls
*would* prevent this situation.  So maybe we're just missing a
pcibios_resource_to_bus() here?

Bjorn
