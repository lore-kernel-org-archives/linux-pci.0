Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:10224 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752875AbbE2R2F (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 29 May 2015 13:28:05 -0400
From: <wdavis@nvidia.com>
To: Joerg Roedel <joro@8bytes.org>, Bjorn Helgaas <bhelgaas@google.com>
CC: Terence Ripperda <tripperda@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Jerome Glisse <jglisse@redhat.com>,
	Mark Hounschell <markh@compro.net>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Jonathan Corbet <corbet@lwn.net>,
	"David S. Miller" <davem@davemloft.net>,
	Yijing Wang <wangyijing@huawei.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Dave Jiang <dave.jiang@intel.com>,
	<iommu@lists.linux-foundation.org>, <linux-pci@vger.kernel.org>,
	Will Davis <wdavis@nvidia.com>
Subject: [PATCH v3 0/7] IOMMU/DMA map_resource support for peer-to-peer
Date: Fri, 29 May 2015 12:14:39 -0500
Message-ID: <1432919686-32306-1-git-send-email-wdavis@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Will Davis <wdavis@nvidia.com>

Hi,

This is the third version of a patchset to add the DMA APIs necessary to
map and unmap a struct resource to and from a PCI device's IOVA domain.
This allows a PCI device to access a peer device's BAR resource when a
hardware IOMMU is enabled.

Thanks,
Will

Changelog:

v3:
- changed dma_map_resource() to BUG() if the map_resource DMA op is not
  provided, instead of returning 0
- updated documentation to remove requirement to check for 0 return value
  as an error
- remove const keyword from struct dma_map_ops in new DMA APIs for
  consistency with other APIs

v2: http://www.spinics.net/lists/linux-pci/msg41192.html
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

 Documentation/DMA-API-HOWTO.txt          | 36 ++++++++++++++-
 Documentation/DMA-API.txt                | 31 ++++++++++---
 arch/x86/kernel/pci-nommu.c              | 32 ++++++++++++++
 drivers/iommu/amd_iommu.c                | 76 ++++++++++++++++++++++++++------
 drivers/iommu/intel-iommu.c              | 18 ++++++++
 include/asm-generic/dma-mapping-broken.h |  9 ++++
 include/asm-generic/dma-mapping-common.h | 34 ++++++++++++++
 include/asm-generic/pci-dma-compat.h     | 14 ++++++
 include/linux/dma-debug.h                | 20 +++++++++
 include/linux/dma-mapping.h              |  7 +++
 lib/dma-debug.c                          | 47 ++++++++++++++++++++
 11 files changed, 304 insertions(+), 20 deletions(-)

-- 
2.4.0

