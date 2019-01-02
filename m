Return-Path: <SRS0=YnKd=PK=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A06AC43387
	for <linux-pci@archiver.kernel.org>; Wed,  2 Jan 2019 21:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65AD7217D9
	for <linux-pci@archiver.kernel.org>; Wed,  2 Jan 2019 21:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546462927;
	bh=r+nNpdyESsvqcR8YB12gWUP8kDV5i0+9Dugr6DNWNF4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yekMj0zenEUnEIOiM2qIqH12Jjfsfi0AdfLFvIObU77/LxK3hw2JT/orSlkPvGBu+
	 d7Tuf7mPZS/YrvDUWPks3YtwNmUimlWuoACDIpXiyg/1HYWO4jsf8VO0x+L8ajkLSr
	 BlGaj2hLFNuEXF0CMMqYJLWt0W+XPQ/LcPAwdW2M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbfABVCG (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 2 Jan 2019 16:02:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:45434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726886AbfABVCG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Jan 2019 16:02:06 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98F6221479;
        Wed,  2 Jan 2019 21:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546462925;
        bh=r+nNpdyESsvqcR8YB12gWUP8kDV5i0+9Dugr6DNWNF4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W7dMeckxFv/9KwwhtYupaDELJoyeKLR3WuH6RhVCApJW79U2tFbVFNFZqnxXS4Erg
         waDdpFqpmvr5oFgEaibUUvCOqrWundqg+veOihHoM3zjGfEbx1dth/Xq/2bSh2sIhz
         fTmHexLW2cF3LaFO+yZ/EcAIUxHWPblL1cecHkfA=
Date:   Wed, 2 Jan 2019 15:02:02 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@fb.com>, Keith Busch <keith.busch@intel.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH V2 1/3] PCI/MSI: preference to returning -ENOSPC from
 pci_alloc_irq_vectors_affinity
Message-ID: <20190102210202.GC126384@google.com>
References: <20181229032650.27256-1-ming.lei@redhat.com>
 <20181229032650.27256-2-ming.lei@redhat.com>
 <20181231220059.GI159477@google.com>
 <20190101052458.GA17588@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190101052458.GA17588@ming.t460p>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 01, 2019 at 01:24:59PM +0800, Ming Lei wrote:
> On Mon, Dec 31, 2018 at 04:00:59PM -0600, Bjorn Helgaas wrote:
> > On Sat, Dec 29, 2018 at 11:26:48AM +0800, Ming Lei wrote:
...
> > > Users of pci_alloc_irq_vectors_affinity() may try to reduce irq
> > > vectors and allocate vectors again in case that -ENOSPC is returned, such
> > > as NVMe, so we need to respect the current interface and give preference to
> > > -ENOSPC.
> > 
> > I thought the whole point of the (min_vecs, max_vecs) tuple was to
> > avoid this sort of "reduce and try again" iteration in the callers.
> 
> As Keith replied, in case of NVMe, we have to keep min_vecs same with
> max_vecs.

Keith said:
> The min/max vecs doesn't work correctly when using the irq_affinity
> nr_sets because rebalancing the set counts is driver specific. To
> get around that, drivers using nr_sets have to set min and max to
> the same value and handle the "reduce and try again".

Sorry I saw that, but didn't follow it at first.  After a little
archaeology, I see that 6da4b3ab9a6e ("genirq/affinity: Add support
for allocating interrupt sets") added nr_sets and some validation
tests (if affd.nr_sets, min_vecs == max_vecs) for using it in the API.

That's sort of a wart on the API, but I don't know if we should live
with it or try to clean it up somehow.

At the very least, this seems like something that could be documented
somewhere in Documentation/PCI/MSI-HOWTO.txt, which mentions
PCI_IRQ_AFFINITY, but doesn't cover struct irq_affinity or
pci_alloc_irq_vectors_affinity() at all, let alone this wrinkle about
affd.nr_sets/min_vecs/max_vecs.

Obviously that would not be part of *this* patch.

Bjorn
