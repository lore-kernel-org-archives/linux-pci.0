Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:12642 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753472AbbHJQGy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 10 Aug 2015 12:06:54 -0400
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
Subject: Re: [PATCH v4 00/12] DMA-API/PCI map_peer_resource support for peer-to-peer
Date: Mon, 10 Aug 2015 10:52:22 -0500
Message-ID: <1439221942-1799-1-git-send-email-wdavis@nvidia.com>
In-Reply-To: <1437601197-6481-1-git-send-email-wdavis@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> Hi,
> 
> This is the fourth version of a patchset to add the DMA APIs necessary to
> map and unmap a PCI device's BAR to and from another PCI device's IOVA
> domain. This enables PCI peer-to-peer traffic on x86 platforms where an
> IOMMU is enabled (this requires that peer-to-peer traffic be supported by
> the underlying chipset as well, of course).
> 

Bjorn, does this patch series adequately address the concerns with the
previous versions?

> Thanks,
> Will
> 
> v4:
> - added HAS_DMA_P2P Kconfig option to guard new APIs, which are only
>   supported on x86 with this patch series
> - added a new dma_peer_addr_t type to handle future platform support
>   where the dma_peer_addr_t needs to have the same width as the bus
>   address, which can be wider than the dma_addr_t returned by other
>   DMA APIs
> - added a new dma_peer_mapping_error() and associated PCI wrapper to
>   detect errors returned via dma_map_peer_resource() API and its
>   PCI wrapper
> - modified the interface of the new API to explicitly take the peer
>   device as an argument
> - renamed the (un)map_resource APIs to (un)map_peer_resource, since
>   they directly receive a 'peer' argument now
> - modified the new PCI interface to take the BAR index instead of the
>   actual struct resource
> - modified the pci-nommu implementation to perform topology and ACS
>   checks before allowing
> - modified both the AMD and Intel IOMMU implementations to require
>   that both devices be behind the same host bridge
> - exposed a couple of preexisting PCI utility functions to aid in the
>   topology checks for all of the x86 implementations
> 
> v3: http://www.spinics.net/lists/linux-pci/msg41703.html
> - changed dma_map_resource() to BUG() if the map_resource DMA op is not
>   provided, instead of returning 0
> - updated documentation to remove requirement to check for 0 return value
>   as an error
> - remove const keyword from struct dma_map_ops in new DMA APIs for
>   consistency with other APIs
> 
> v2: http://www.spinics.net/lists/linux-pci/msg41192.html
> - added documentation for the new DMA APIs
> - fixed physical-to-bus address conversion in the nommu implementation
> 
> v1: http://www.spinics.net/lists/linux-pci/msg40747.html
> 
> 
> 
> Will Davis (12):
>   lib/Kconfig: add HAS_DMA_P2P for peer-to-peer support
>   linux/types.h: Add dma_peer_addr_t type
>   dma-debug: add checking for map/unmap_peer_resource
>   DMA-API: Introduce dma_(un)map_peer_resource
>   dma-mapping: pci: add pci_(un)map_peer_resource
>   DMA-API: Add peer resource mapping documentation
>   pci: expose pci_find_host_bridge()
>   iommu/amd: Implement (un)map_peer_resource
>   iommu/vt-d: implement (un)map_peer_resource
>   pci: add pci_find_common_upstream_dev()
>   x86: add pci-nommu implementation of map_peer_resource
>   x86: declare support for DMA P2P
> 
>  Documentation/DMA-API-HOWTO.txt          | 46 ++++++++++++++-
>  Documentation/DMA-API.txt                | 36 ++++++++++--
>  arch/x86/Kconfig                         |  1 +
>  arch/x86/include/asm/dma-mapping.h       | 18 +++++-
>  arch/x86/kernel/pci-nommu.c              | 96 +++++++++++++++++++++++++++++++
>  drivers/iommu/amd_iommu.c                | 99 +++++++++++++++++++++++++++-----
>  drivers/iommu/intel-iommu.c              | 38 ++++++++++++
>  drivers/pci/host-bridge.c                | 19 +-----
>  drivers/pci/search.c                     | 25 ++++++++
>  include/asm-generic/dma-mapping-common.h | 43 ++++++++++++++
>  include/asm-generic/pci-dma-compat.h     | 23 ++++++++
>  include/linux/dma-debug.h                | 39 ++++++++++++-
>  include/linux/dma-mapping.h              | 12 ++++
>  include/linux/pci.h                      |  9 +++
>  include/linux/types.h                    | 13 ++++-
>  lib/Kconfig                              |  5 ++
>  lib/dma-debug.c                          | 86 ++++++++++++++++++++++++++-
>  17 files changed, 564 insertions(+), 44 deletions(-)
> 
> -- 
> 2.4.6

