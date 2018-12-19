Return-Path: <SRS0=4gsO=O4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1457C43387
	for <linux-pci@archiver.kernel.org>; Wed, 19 Dec 2018 06:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 758E82184A
	for <linux-pci@archiver.kernel.org>; Wed, 19 Dec 2018 06:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbeLSGmJ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 19 Dec 2018 01:42:09 -0500
Received: from verein.lst.de ([213.95.11.211]:45213 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725290AbeLSGmJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Dec 2018 01:42:09 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 9559C67358; Wed, 19 Dec 2018 07:42:06 +0100 (CET)
Date:   Wed, 19 Dec 2018 07:42:06 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Guillaume Tucker <guillaume.tucker@collabora.com>,
        Christoph Hellwig <hch@lst.de>,
        iommu@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Keith Busch <keith.busch@intel.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        linux-pci@vger.kernel.org, linux-ia64@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        ezequiel Garcia <ezequiel@collabora.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [15/15] dma-mapping: bypass indirect calls for dma-direct
Message-ID: <20181219064206.GA27018@lst.de>
References: <20181207190720.18517-16-hch@lst.de> <2e779fa7-dc9f-7ed8-252a-5d20c5deca9c@collabora.com> <92096de9-7183-dbe8-2169-0143190591fa@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92096de9-7183-dbe8-2169-0143190591fa@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 18, 2018 at 08:42:46PM +0000, Robin Murphy wrote:
>> [   16.046084] rk_iommu ff8f3f00.iommu: DMA map error for DT
>
> Yup, with this patch as-is, anything which isn't behind an IOMMU will be 
> erroneously banned from DMA entirely - see here:
>
> https://lore.kernel.org/lkml/20181214142435.GA18448@lst.de/

FYI, I'm still waiting for a review on that..
