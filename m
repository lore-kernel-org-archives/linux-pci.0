Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52976 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752548Ab3E1Skq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 28 May 2013 14:40:46 -0400
Subject: [PATCH v2 0/2] iommu/intel: Quirk non-compliant PCIe-to-PCI bridges
To: iommu@lists.linux-foundation.org, dwmw2@infradead.org,
	joro@8bytes.org
From: Alex Williamson <alex.williamson@redhat.com>
Cc: stephen@networkplumber.org, linux-pci@vger.kernel.org,
	ddutile@redhat.com
Date: Tue, 28 May 2013 12:40:11 -0600
Message-ID: <20130528183527.3318.5365.stgit@bling.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This series tries to address:

https://bugzilla.kernel.org/show_bug.cgi?id=44881

Where pci_find_upstream_pcie_bridge() gets lost trying to find the
upstream PCIe-to-PCI bridge for a device because the bridge doesn't
expose a PCIe capability.  To do this, we add a iommu_pci_is_pcie_bridge
function which includes a quirk to look to the next upstream device
as a sanity check.  We can then replace pci_find_upstream_pcie_bridge
with a function that's a bit more generic and less tied to intel-iommu
eccentricities.

v2 uses the same logic as v1, but moves the search and match code to
IOMMU-core since PCI-core doesn't want it.  v1 has several reports
from users that this solves the problem they have in the above bz.
Thanks,

Alex

---

Alex Williamson (2):
      iommu: Quirked PCIe bridge test and search function
      intel-iommu: Convert to iommu_pci_find_upstream + iommu_pci_is_pcie_bridge


 drivers/iommu/Kconfig               |    5 ++
 drivers/iommu/Makefile              |    1 
 drivers/iommu/intel-iommu.c         |   77 ++++++++++++++++++++++-------------
 drivers/iommu/intel_irq_remapping.c |   15 +++++--
 drivers/iommu/pci.c                 |   69 +++++++++++++++++++++++++++++++
 drivers/iommu/pci.h                 |   23 ++++++++++
 6 files changed, 157 insertions(+), 33 deletions(-)
 create mode 100644 drivers/iommu/pci.c
