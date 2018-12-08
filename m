Return-Path: <SRS0=kTIb=OR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B6A7C04EB8
	for <linux-pci@archiver.kernel.org>; Sat,  8 Dec 2018 16:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F13F220700
	for <linux-pci@archiver.kernel.org>; Sat,  8 Dec 2018 16:06:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F13F220700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbeLHQG7 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 8 Dec 2018 11:06:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56504 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbeLHQG7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 8 Dec 2018 11:06:59 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 20E76C057F21;
        Sat,  8 Dec 2018 16:06:58 +0000 (UTC)
Received: from localhost (ovpn-200-34.brq.redhat.com [10.40.200.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5ABA1608C3;
        Sat,  8 Dec 2018 16:06:49 +0000 (UTC)
Date:   Sat, 8 Dec 2018 17:06:48 +0100
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tariq Toukan <tariqt@mellanox.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Toke =?UTF-8?B?SMO4aWxhbmQtSsO4?= =?UTF-8?B?cmdlbnNlbg==?= 
        <toke@toke.dk>, Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Keith Busch <keith.busch@intel.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        linux-pci@vger.kernel.org, linux-ia64@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org, brouer@redhat.com
Subject: Re: [RFC] avoid indirect calls for DMA direct mappings v2
Message-ID: <20181208170648.296fb8a1@redhat.com>
In-Reply-To: <20181207190720.18517-1-hch@lst.de>
References: <20181207190720.18517-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Sat, 08 Dec 2018 16:06:58 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri,  7 Dec 2018 11:07:05 -0800
Christoph Hellwig <hch@lst.de> wrote:

> Hi all,
> 
> a while ago Jesper reported major performance regressions due to the
> spectre v2 mitigations in his XDP forwarding workloads.  A large part
> of that is due to the DMA mapping API indirect calls.
> 
> It turns out that the most common implementation of the DMA API is the
> direct mapping case, and now that we have merged almost all duplicate
> implementations of that into a single generic one is easily feasily to
> direct calls for this fast path.
> 
> This series adds consolidate the DMA mapping code by merging the
> swiotlb case into the dma direct case, and then treats NULL dma_ops
> as an indicator that that we should directly call the direct mapping
> case.  This recovers a large part of the retpoline induces XDP slowdown.
> 
> This works is based on the dma-mapping tree, so you probably want to
> want this git tree for testing:
> 
>     git://git.infradead.org/users/hch/misc.git dma-direct-calls.2
> 
> Gitweb:
> 
>     http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-direct-calls.2

You can add my:
 Tested-by: Jesper Dangaard Brouer <brouer@redhat.com>
or
 Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>

I'm very happy that you work on this.  And I've done micro-benchmark
testing of the patchset (and branch dma-direct-calls), which I've made
avail here:
 https://github.com/xdp-project/xdp-project/blob/master/areas/dma/dma01_test_hellwig_direct_dma.org

My XDP performance is back, minus the BPF-indirect call, and
net_rx_action napi->poll, and net_device->ndo_xdp_xmit calls.  I
verified that manually disabling retpoline for these remaining netstack
retpoline-calls restore the performance full (well minus 1.5 nanosec).

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer
