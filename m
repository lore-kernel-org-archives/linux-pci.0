Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:13318 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750965AbbIORLS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 15 Sep 2015 13:11:18 -0400
From: Will Davis <wdavis@nvidia.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Alex Williamson <alex.williamson@redhat.com>,
	Joerg Roedel <joro@8bytes.org>,
	<iommu@lists.linux-foundation.org>, <linux-pci@vger.kernel.org>,
	Konrad Wilk <konrad.wilk@oracle.com>,
	Mark Hounschell <markh@compro.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Terence Ripperda <tripperda@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Jerome Glisse <jglisse@redhat.com>,
	Will Davis <wdavis@nvidia.com>
Subject: [PATCH 00/22] DMA-API/PCI map_peer_resource support for peer-to-peer
Date: Tue, 15 Sep 2015 12:10:45 -0500
Message-ID: <1442337067-22964-1-git-send-email-wdavis@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

This is the sixth version of a patchset to add the DMA APIs necessary to
map and unmap a PCI device's BAR to and from another PCI device's IOVA
domain. This enables PCI peer-to-peer traffic on x86 platforms where an
IOMMU is enabled (this requires that peer-to-peer traffic be supported by
the underlying chipset as well, of course).

Thanks,
Will

v6:
- added stubs for remaining x86 dma_map_ops: calgary, gart, sta2x11,
  swiotlb, xen-swiotlb
- factored part of x86 PCI nommu implementation into a generic PCI
  helper, pci_resource_to_peer()
- split x86 dma_peer_mapping_error() implementation into a separate
  patch

v5: http://www.spinics.net/lists/linux-pci/msg43975.html
- moved topology and ACS checks into a separate
  pci_peer_traffic_supported() API, which determines whether PCI peer-
  to-peer traffic may work based on language in the PCI and PCI Express
  specifications (excerpts included in comments)
- added CONFIG_HAS_DMA_P2P guards to x86 PCI no-mmu implementation of
  map_peer_resource
- modified a few patch descriptions for style

v4: http://www.spinics.net/lists/linux-pci/msg43136.html
- added HAS_DMA_P2P Kconfig option to guard new APIs, which are only
  supported on x86 with this patch series
- added a new dma_peer_addr_t type to handle future platform support
  where the dma_peer_addr_t needs to have the same width as the bus
  address, which can be wider than the dma_addr_t returned by other
  DMA APIs
- added a new dma_peer_mapping_error() and associated PCI wrapper to
  detect errors returned via dma_map_peer_resource() API and its
  PCI wrapper
- modified the interface of the new API to explicitly take the peer
  device as an argument
- renamed the (un)map_resource APIs to (un)map_peer_resource, since
  they directly receive a 'peer' argument now
- modified the new PCI interface to take the BAR index instead of the
  actual struct resource
- modified the pci-nommu implementation to perform topology and ACS
  checks before allowing
- modified both the AMD and Intel IOMMU implementations to require
  that both devices be behind the same host bridge
- exposed a couple of preexisting PCI utility functions to aid in the
  topology checks for all of the x86 implementations

v3: http://www.spinics.net/lists/linux-pci/msg41703.html
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

Will Davis (22):
  lib/Kconfig: add HAS_DMA_P2P for peer-to-peer support
  linux/types.h: Add dma_peer_addr_t type
  dma-debug: add checking for map/unmap_peer_resource
  DMA-API: Introduce dma_(un)map_peer_resource
  dma-mapping: pci: add pci_(un)map_peer_resource
  DMA-API: Add peer resource mapping documentation
  PCI: Export pci_find_host_bridge()
  PCI: Add pci_find_common_upstream_dev()
  PCI: Add pci_peer_traffic_supported()
  PCI: Add pci_resource_to_peer()
  swiotlb: Add map_peer_resource stub
  x86, swiotlb: Add swiotlb_map_peer_resource() to swiotlb_dma_ops
  x86, platform: Add swiotlb_map_peer_resource() to sta2x11_dma_ops
  swiotlb-xen: add map_peer_resource stub
  pci-swiotlb-xen: add xen_swiotlb_map_peer_resource to
    xen_swiotlb_dma_ops
  iommu/amd: Implement (un)map_peer_resource
  iommu/vt-d: implement (un)map_peer_resource
  x86: add pci-nommu implementation of map_peer_resource
  x86: Calgary: Add map_peer_resource stub
  x86: gart: Add map_peer_resource stub
  x86: add dma_peer_mapping_error()
  x86: declare support for DMA P2P

 Documentation/DMA-API-HOWTO.txt          | 69 ++++++++++++++++++++++
 Documentation/DMA-API.txt                | 38 ++++++++++--
 arch/x86/Kconfig                         |  1 +
 arch/x86/include/asm/dma-mapping.h       | 18 +++++-
 arch/x86/kernel/amd_gart_64.c            | 16 ++++++
 arch/x86/kernel/pci-calgary_64.c         | 16 ++++++
 arch/x86/kernel/pci-nommu.c              | 30 ++++++++++
 arch/x86/kernel/pci-swiotlb.c            |  3 +
 arch/x86/pci/sta2x11-fixup.c             |  3 +
 arch/x86/xen/pci-swiotlb-xen.c           |  3 +
 drivers/iommu/amd_iommu.c                | 99 +++++++++++++++++++++++++++-----
 drivers/iommu/intel-iommu.c              | 38 ++++++++++++
 drivers/pci/host-bridge.c                | 19 +-----
 drivers/pci/pci.c                        | 99 ++++++++++++++++++++++++++++++++
 drivers/pci/search.c                     | 25 ++++++++
 drivers/xen/swiotlb-xen.c                | 20 +++++++
 include/asm-generic/dma-mapping-common.h | 43 ++++++++++++++
 include/asm-generic/pci-dma-compat.h     | 23 ++++++++
 include/linux/dma-debug.h                | 39 ++++++++++++-
 include/linux/dma-mapping.h              | 12 ++++
 include/linux/pci.h                      | 28 +++++++++
 include/linux/swiotlb.h                  |  8 +++
 include/linux/types.h                    | 13 ++++-
 include/xen/swiotlb-xen.h                | 11 ++++
 lib/Kconfig                              |  5 ++
 lib/dma-debug.c                          | 86 ++++++++++++++++++++++++++-
 lib/swiotlb.c                            | 17 ++++++
 27 files changed, 740 insertions(+), 42 deletions(-)

-- 
2.5.1

