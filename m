Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:37739 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750885AbdEPFWX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 May 2017 01:22:23 -0400
Received: by mail-wm0-f54.google.com with SMTP id d127so104497546wmf.0
        for <linux-pci@vger.kernel.org>; Mon, 15 May 2017 22:22:23 -0700 (PDT)
From: Oza Pawandeep <oza.oza@broadcom.com>
To: Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        Oza Pawandeep <oza.pawandeep@gmail.com>,
        Oza Pawandeep <oza.oza@broadcom.com>
Subject: [PATCH v6 0/3] OF/PCI address PCI inbound memory limitations
Date: Tue, 16 May 2017 10:52:04 +0530
Message-Id: <1494912127-12890-1-git-send-email-oza.oza@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

It is possible that PCI device supports 64-bit DMA addressing,
and thus it's driver sets device's dma_mask to DMA_BIT_MASK(64),
however PCI host bridge may have limitations on the inbound 
transaction addressing.

This is particularly problematic on ARM/ARM64 SOCs where the 
IOMMU (i.e. SMMU) translates IOVA to PA for in-bound transactions
only after PCI Host has forwarded these transactions on SOC IO bus. 

This means, on such ARM/ARM64 SOCs the IOVA of in-bound transactions
has to honor the addressing restrictions of the PCI Host.

Current device framework and OF framework integration assumes
dma-ranges in a way where memory-mapped devices define their
dma-ranges. (child-bus-address, parent-bus-address, length).

of_dma_configure is specifically written to take care of memory
mapped devices but no implementation exists for pci devices.

For e.g. iproc based SOCs and other SOCs (such as rcar) have
PCI world dma-ranges.
dma-ranges = <0x43000000 0x00 0x00 0x00 0x00 0x80 0x00>;

This patchset
reserves the IOVA ranges for PCI masters based
on the PCI world dma-ranges.
fix of_dma_get_range to cater to PCI dma-ranges.
fix of_dma_get_range which currently returns size 0 for PCI devices.

IOVA allocation patch:
[PATCH 2/3] iommu/pci: reserve iova for PCI masters

Fix of_dma_get_range bug and address PCI master.
[PATCH 3/3] PCI/of fix of_dma_get_range; get PCI specific
this patch fixes the following problems of_dma_get_range.
1) return of wrong size as 0.
2) not handling absence of dma-ranges, which is valid for PCI master.
3) not handling multipe inbound windows.
4) in order to get largest possible dma_mask. this patch also
retuns the largest possible size based on dma-ranges,

Base patch for both of the above patches:
[PATCH 1/3] of/pci/dma: fix DMA configuration for PCI masters

Changes since v6:
- Robin's comments addressed.
Changes since v5:
Changes since v4:
Changes since v3:
Changes since v2:
- minor changes, redudant checkes removed
- removed internal review
Changes since v1:
- address Rob's comments.
- Add a get_dma_ranges() function to of_bus struct..
- Convert existing contents of of_dma_get_range function to
  of_bus_default_dma_get_ranges and adding that to the
  default of_bus struct.
- Make of_dma_get_range call of_bus_match() and then bus->get_dma_ranges.

Oza Pawandeep (3):
  of/pci/dma: fix DMA configuration for PCI masters
  iommu/pci: reserve IOVA for PCI masters
  PCI/of fix of_dma_get_range; get PCI specific dma-ranges

 drivers/iommu/dma-iommu.c |  35 ++++++++
 drivers/of/address.c      | 215 ++++++++++++++++++++++++++++++++--------------
 drivers/of/of_pci.c       |  95 ++++++++++++++++++++
 include/linux/of_pci.h    |   7 ++
 4 files changed, 288 insertions(+), 64 deletions(-)

-- 
1.9.1
