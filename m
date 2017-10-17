Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 17 Oct 2017 10:17:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Cc: gregkh@linuxfoundation.org, hch@lst.de, robh+dt@kernel.org,
        m.szyprowski@samsung.com, mperttunen@nvidia.com,
        jonathanh@nvidia.com, thierry.reding@gmail.com, kishon@ti.com,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: Flag buses which demand DMA configuration
Message-ID: <20171017081701.GB19475@lst.de>
References: <bd1c6061a6a16f720e992a0f12933bdee6591aea.1507823375.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <bd1c6061a6a16f720e992a0f12933bdee6591aea.1507823375.git.robin.murphy@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Greg, do you want to take this or should I queue it up in the
dma-mapping tree?
