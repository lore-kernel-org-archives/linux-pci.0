Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:43377 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752895AbdJSOcB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 19 Oct 2017 10:32:01 -0400
Date: Thu, 19 Oct 2017 16:31:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>, robh+dt@kernel.org,
        m.szyprowski@samsung.com, mperttunen@nvidia.com,
        jonathanh@nvidia.com, thierry.reding@gmail.com, kishon@ti.com,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: Flag buses which demand DMA configuration
Message-ID: <20171019143159.GA23198@lst.de>
References: <bd1c6061a6a16f720e992a0f12933bdee6591aea.1507823375.git.robin.murphy@arm.com> <20171017081701.GB19475@lst.de> <20171017082809.GA4947@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171017082809.GA4947@kroah.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 17, 2017 at 10:28:09AM +0200, Greg KH wrote:
> On Tue, Oct 17, 2017 at 10:17:01AM +0200, Christoph Hellwig wrote:
> > Looks fine:
> > 
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > 
> > Greg, do you want to take this or should I queue it up in the
> > dma-mapping tree?
> 
> You can take it, thanks!
> 
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thanks, applied to the dma-mapping treefor 4.15.
