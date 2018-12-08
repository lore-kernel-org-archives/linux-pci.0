Return-Path: <SRS0=kTIb=OR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE1FC04EB8
	for <linux-pci@archiver.kernel.org>; Sat,  8 Dec 2018 16:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D21A220892
	for <linux-pci@archiver.kernel.org>; Sat,  8 Dec 2018 16:51:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D21A220892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbeLHQvB (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 8 Dec 2018 11:51:01 -0500
Received: from verein.lst.de ([213.95.11.211]:40737 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726172AbeLHQvA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 8 Dec 2018 11:51:00 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id D906168AA6; Sat,  8 Dec 2018 17:50:58 +0100 (CET)
Date:   Sat, 8 Dec 2018 17:50:58 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
Subject: Re: [RFC] avoid indirect calls for DMA direct mappings v2
Message-ID: <20181208165058.GA14874@lst.de>
References: <20181207190720.18517-1-hch@lst.de> <20181208170648.296fb8a1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181208170648.296fb8a1@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Dec 08, 2018 at 05:06:48PM +0100, Jesper Dangaard Brouer wrote:
> You can add my:
>  Tested-by: Jesper Dangaard Brouer <brouer@redhat.com>
> or
>  Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>
> 
> I'm very happy that you work on this.  And I've done micro-benchmark
> testing of the patchset (and branch dma-direct-calls), which I've made
> avail here:
>  https://github.com/xdp-project/xdp-project/blob/master/areas/dma/dma01_test_hellwig_direct_dma.org
> 
> My XDP performance is back, minus the BPF-indirect call, and
> net_rx_action napi->poll, and net_device->ndo_xdp_xmit calls.  I
> verified that manually disabling retpoline for these remaining netstack
> retpoline-calls restore the performance full (well minus 1.5 nanosec).

Thanks a lot for all the testing (and the initial report).  I'd love to
still gets this in for 4.21 if we can, but for that I'd need a lot
more folks to carefull review it, especially the swiotlb and ia64 bits.
So if we don't get that early next week I feel we might have to punt
it to the next merge window.
