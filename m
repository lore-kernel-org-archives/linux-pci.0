Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from db3ehsobe001.messaging.microsoft.com ([213.199.154.139]:24203
	"EHLO db3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751088Ab2FYL3g (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 25 Jun 2012 07:29:36 -0400
Date: Mon, 25 Jun 2012 13:29:34 +0200
From: Joerg Roedel <joerg.roedel@amd.com>
To: Alex Williamson <alex.williamson@redhat.com>
CC: <dwmw2@infradead.org>, <iommu@lists.linux-foundation.org>,
	<bhelgaas@google.com>, <benh@kernel.crashing.org>, <aik@ozlabs.ru>,
	<david@gibson.dropbear.id.au>, <konrad.wilk@oracle.com>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<gregkh@linuxfoundation.org>, <ddutile@redhat.com>,
	<liuj97@gmail.com>
Subject: Re: [PATCH v2 0/7] IOMMU: Groups support
Message-ID: <20120625112934.GU2624@amd.com>
References: <20120530201424.31527.33142.stgit@bling.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20120530201424.31527.33142.stgit@bling.home>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 30, 2012 at 02:18:29PM -0600, Alex Williamson wrote:
> Alex Williamson (7):
>       iommu: Remove group_mf
>       intel-iommu: Make use of DMA quirks and ACS checks in IOMMU groups
>       amd_iommu: Make use of DMA quirks and ACS checks in IOMMU groups
>       intel-iommu: Support IOMMU groups
>       amd_iommu: Support IOMMU groups
>       iommu: IOMMU Groups
>       driver core: Add iommu_group tracking to struct device
> 
> 
>  .../ABI/testing/sysfs-kernel-iommu_groups          |   14 
>  Documentation/kernel-parameters.txt                |    1 
>  arch/ia64/include/asm/iommu.h                      |    2 
>  arch/ia64/kernel/pci-dma.c                         |    1 
>  arch/x86/include/asm/iommu.h                       |    1 
>  arch/x86/kernel/pci-dma.c                          |   11 
>  drivers/iommu/amd_iommu.c                          |   70 ++
>  drivers/iommu/intel-iommu.c                        |   89 ++-
>  drivers/iommu/iommu.c                              |  578 +++++++++++++++++++-
>  include/linux/device.h                             |    2 
>  include/linux/iommu.h                              |  104 +++-
>  11 files changed, 767 insertions(+), 106 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-kernel-iommu_groups

Applied and pushed all of them. Thanks a lot, Alex.

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632

