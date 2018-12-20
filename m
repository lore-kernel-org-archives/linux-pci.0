Return-Path: <SRS0=yvM8=O5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14360C43387
	for <linux-pci@archiver.kernel.org>; Thu, 20 Dec 2018 16:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEA1A218C3
	for <linux-pci@archiver.kernel.org>; Thu, 20 Dec 2018 16:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731764AbeLTQqL (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 20 Dec 2018 11:46:11 -0500
Received: from verein.lst.de ([213.95.11.211]:54138 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731411AbeLTQqL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Dec 2018 11:46:11 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 02B4C68AA6; Thu, 20 Dec 2018 17:46:09 +0100 (CET)
Date:   Thu, 20 Dec 2018 17:46:08 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Keith Busch <keith.busch@intel.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        linux-pci@vger.kernel.org, linux-ia64@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/15] dma-mapping: bypass indirect calls for dma-direct
Message-ID: <20181220164608.GA20000@lst.de>
References: <20181207190720.18517-1-hch@lst.de> <20181207190720.18517-16-hch@lst.de> <20181220164418.GA18777@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181220164418.GA18777@ulmo>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 20, 2018 at 05:44:18PM +0100, Thierry Reding wrote:
> On Fri, Dec 07, 2018 at 11:07:20AM -0800, Christoph Hellwig wrote:
> [...]
> > diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> > index 0b18cfbdde95..fc84c81029d9 100644
> > --- a/kernel/dma/mapping.c
> > +++ b/kernel/dma/mapping.c
> [...]
> > @@ -397,9 +404,9 @@ int dma_supported(struct device *dev, u64 mask)
> >  {
> >  	const struct dma_map_ops *ops = get_dma_ops(dev);
> >  
> > -	if (!ops)
> > -		return 0;
> > -	if (!ops->dma_supported)
> > +	if (dma_is_direct(ops))
> > +		return dma_direct_supported(dev, mask);
> > +	if (ops->dma_supported)
> >  		return 1;
> >  	return ops->dma_supported(dev, mask);
> >  }
> 
> Hi Christoph,
> 
> This hunk causes a crash on boot for me. It looks like a ! got lost in
> the rework here. The following patch fixes the crash for me and restores
> the logic of the op->dma_supported check.
> 
> Feel free to squash this patch into the above if you prefer that.

I don't want to rebase, so I'll pick this up ASAP.
