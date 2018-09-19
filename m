Return-Path: <SRS0=bOp+=MB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAFFBECE564
	for <linux-pci@archiver.kernel.org>; Wed, 19 Sep 2018 14:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EDCE20877
	for <linux-pci@archiver.kernel.org>; Wed, 19 Sep 2018 14:41:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EDCE20877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731926AbeISUTb (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 19 Sep 2018 16:19:31 -0400
Received: from verein.lst.de ([213.95.11.211]:53964 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731917AbeISUTb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Sep 2018 16:19:31 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 22E1F68D83; Wed, 19 Sep 2018 16:41:19 +0200 (CEST)
Date:   Wed, 19 Sep 2018 16:41:19 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v5 11/12] ARM64: add dma remap for BrcmSTB PCIe
Message-ID: <20180919144119.GB29096@lst.de>
References: <1537367527-20773-1-git-send-email-jim2101024@gmail.com> <1537367527-20773-12-git-send-email-jim2101024@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537367527-20773-12-git-send-email-jim2101024@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
Message-ID: <20180919144119.dwwG1qMP0miwbd1WR9iamvvoHZAW9yBs25XMJ1RuGpM@z>

On Wed, Sep 19, 2018 at 10:32:06AM -0400, Jim Quinlan wrote:
> +#if defined(CONFIG_ARM64)

Please use plain #ifdef where possible.

> +dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr)
> +{
> +	return brcm_phys_to_dma(dev, paddr);
> +}
> +
> +phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t dev_addr)
> +{
> +	return brcm_dma_to_phys(dev, dev_addr);
> +}
> +#endif

How is this going to work for a kernel with BrcmSTB built in, but running
on a more standard arm64 SOC?

I suspect we really just want a set of ranges hanging off struct device
(conditional on a config option).  Each SoC can then fill it at boot
time, and if it is non-NULL the DMA code will use it instead of
calling __phys_to_dma and __dma_to_phys.  In fact the single range
version could probably just replace the existing dma_pfn_offset
field.
