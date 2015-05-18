Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:12589 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752380AbbERSib (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 18 May 2015 14:38:31 -0400
From: <wdavis@nvidia.com>
To: <joro@8bytes.org>, <bhelgaas@google.com>
CC: <iommu@lists.linux-foundation.org>, <linux-pci@vger.kernel.org>,
	<tripperda@nvidia.com>, <jhubbard@nvidia.com>,
	<jglisse@redhat.com>, <konrad.wilk@oracle.com>,
	Will Davis <wdavis@nvidia.com>
Subject: [PATCH v2 0/7] IOMMU/DMA map_resource support for peer-to-peer
Date: Mon, 18 May 2015 13:24:57 -0500
Message-ID: <1431973504-5903-1-git-send-email-wdavis@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Will Davis <wdavis@nvidia.com>

Hi,

This is a second attempt at adding the DMA APIs necessary to map and unmap
a struct resource to and from a PCI device's IOVA domain. This allows a
PCI device to access a peer device's BAR resource when a hardware IOMMU is
enabled.

Thanks,
Will

Changelog:

v2:
- added documentation for the new DMA APIs
- fixed physical-to-bus address conversion in the nommu implementation

v1: http://www.spinics.net/lists/linux-pci/msg40747.html

Will Davis (7):
  dma-debug: add checking for map/unmap_resource
  DMA-API: Introduce dma_(un)map_resource
  dma-mapping: pci: add pci_(un)map_resource
  DMA-API: Add dma_(un)map_resource() documentation
  iommu/amd: Implement (un)map_resource
  iommu/vt-d: implement (un)map_resource
  x86: add pci-nommu implementation of map_resource

 Documentation/DMA-API-HOWTO.txt          | 39 +++++++++++++++-
 Documentation/DMA-API.txt                | 36 ++++++++++++---
 arch/x86/kernel/pci-nommu.c              | 32 ++++++++++++++
 drivers/iommu/amd_iommu.c                | 76 ++++++++++++++++++++++++++------
 drivers/iommu/intel-iommu.c              | 18 ++++++++
 include/asm-generic/dma-mapping-broken.h |  9 ++++
 include/asm-generic/dma-mapping-common.h | 34 ++++++++++++++
 include/asm-generic/pci-dma-compat.h     | 14 ++++++
 include/linux/dma-debug.h                | 20 +++++++++
 include/linux/dma-mapping.h              |  7 +++
 lib/dma-debug.c                          | 47 ++++++++++++++++++++
 11 files changed, 312 insertions(+), 20 deletions(-)

-- 
2.4.0

