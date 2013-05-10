Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37000 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754670Ab3EJVTI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 10 May 2013 17:19:08 -0400
Subject: [PATCH 0/3] pci/iommu: Quirk non-compliant PCIe-to-PCI bridges
To: bhelgaas@google.com, stephen@networkplumber.org
From: Alex Williamson <alex.williamson@redhat.com>
Cc: linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
	dwmw2@infradead.org, ddutile@redhat.com
Date: Fri, 10 May 2013 15:18:39 -0600
Message-ID: <20130510210937.32592.21950.stgit@bling.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This series tries to address:

https://bugzilla.kernel.org/show_bug.cgi?id=44881

Where pci_find_upstream_pcie_bridge() gets lost trying to find the
upstream PCIe-to-PCI bridge for a device because the bridge doesn't
expose a PCIe capability.  To do this, we add a pci_is_pcie_bridge
function which includes a quirk to look to the next upstream device
as a sanity check.  We can then replace pci_find_upstream_pcie_bridge
with a function that's a bit more generic and less tied to intel-iommu
eccentricities.

This works on my VT-d system, but I don't have any of the offending
bridges.  Appreciate testing from those who do.  I'll link this series
to the bz above for more testing.  Thanks,

Alex

---

Alex Williamson (3):
      pci: Add PCI walk function and PCIe bridge test
      intel-iommu: Convert to pci_walk_up_to_first_match
      pci: Remove pci_find_pcie_upstream_bridge


 drivers/iommu/intel-iommu.c         |   77 ++++++++++++++++++++++-------------
 drivers/iommu/intel_irq_remapping.c |   13 ++++--
 drivers/pci/search.c                |   74 ++++++++++++++++++++++------------
 include/linux/pci.h                 |   26 +++++++++---
 4 files changed, 124 insertions(+), 66 deletions(-)
