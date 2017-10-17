Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:42126 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932690AbdJQI2C (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Oct 2017 04:28:02 -0400
Date: Tue, 17 Oct 2017 10:28:09 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Robin Murphy <robin.murphy@arm.com>, robh+dt@kernel.org,
        m.szyprowski@samsung.com, mperttunen@nvidia.com,
        jonathanh@nvidia.com, thierry.reding@gmail.com, kishon@ti.com,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: Flag buses which demand DMA configuration
Message-ID: <20171017082809.GA4947@kroah.com>
References: <bd1c6061a6a16f720e992a0f12933bdee6591aea.1507823375.git.robin.murphy@arm.com>
 <20171017081701.GB19475@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171017081701.GB19475@lst.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 17, 2017 at 10:17:01AM +0200, Christoph Hellwig wrote:
> Looks fine:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> Greg, do you want to take this or should I queue it up in the
> dma-mapping tree?

You can take it, thanks!

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
