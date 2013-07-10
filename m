Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:18214 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752792Ab3GJWLE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 10 Jul 2013 18:11:04 -0400
Subject: [RFC PATCH 0/2] pci/iommu: PCIe requester ID interface
To: bhelgaas@google.com
From: Alex Williamson <alex.williamson@redhat.com>
Cc: linux-pci@vger.kernel.org, joro@8bytes.org,
	iommu@lists.linux-foundation.org, acooks@gmail.com,
	ddutile@redhat.com, dwmw2@infradead.org
Date: Wed, 10 Jul 2013 16:10:32 -0600
Message-ID: <20130710215954.3045.89568.stgit@bling.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I took Bjorn's requester ID interface, or more appropriately my
interpretation of the interface, through a full (apparently) working
implementation.  This is the result.  It's quite a nice cleanup for
intel-iommu.  I think this kills two birds with one stone, we quirk
PCIe-to-PCI bridges that don't have a PCIe capability (bz44881) and we
also apply DMA quirks to all devices for dma_ops, which should fix
devices like Ricoh and Marvell chips that do DMA from the wrong
requester ID (still no ghost requester ID support, but that may be
easier to add now).

If this seems like the right direction I'll update other users of
pci_find_upstream_pcie_bridge() and abolish that function.  Thanks,

Alex

---

Alex Williamson (2):
      pci: Create PCIe requester ID interface
      iommu/intel: Make use of PCIe requester ID interface


 drivers/iommu/intel-iommu.c |  164 ++++++++++++++++-------------------------
 drivers/pci/search.c        |  170 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h         |    7 ++
