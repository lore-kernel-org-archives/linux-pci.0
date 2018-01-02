Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750800AbeABWRa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Jan 2018 17:17:30 -0500
Date: Tue, 2 Jan 2018 16:17:24 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Romain Perier <romain.perier@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vinod.koul@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Aviad Krawczyk <aviad.krawczyk@huawei.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v17 0/4] Replace PCI pool by DMA pool API
Message-ID: <20180102221724.GE6211@bhelgaas-glaptop.roam.corp.google.com>
References: <20180102175356.7999-1-romain.perier@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180102175356.7999-1-romain.perier@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 02, 2018 at 06:53:52PM +0100, Romain Perier wrote:
> The current PCI pool API are simple macro functions direct expanded to
> the appropriate dma pool functions. The prototypes are almost the same
> and semantically, they are very similar. I propose to use the DMA pool
> API directly and get rid of the old API.
> 
> This set of patches, replaces the old API by the dma pool API
> and remove the defines.
> ...

> Romain Perier (4):
>   block: DAC960: Replace PCI pool old API
>   net: e100: Replace PCI pool old API
>   hinic: Replace PCI pool old API
>   PCI: Remove PCI pool macro functions
> 
>  drivers/block/DAC960.c                            | 38 +++++++++++------------
>  drivers/block/DAC960.h                            |  4 +--
>  drivers/net/ethernet/huawei/hinic/hinic_hw_cmdq.c | 10 +++---
>  drivers/net/ethernet/huawei/hinic/hinic_hw_cmdq.h |  2 +-
>  drivers/net/ethernet/intel/e100.c                 | 12 +++----
>  include/linux/pci.h                               |  9 ------
>  6 files changed, 32 insertions(+), 43 deletions(-)

Applied to pci/misc for v4.16, thanks!
