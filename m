Return-Path: <SRS0=XWMu=Q5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B234C43381
	for <linux-pci@archiver.kernel.org>; Fri, 22 Feb 2019 14:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BC19206A3
	for <linux-pci@archiver.kernel.org>; Fri, 22 Feb 2019 14:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mTzntWJI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbfBVOqe (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 22 Feb 2019 09:46:34 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:49208 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbfBVOqe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Feb 2019 09:46:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=JzqUHyCrNh04EqJQcVSQhI7Qsm8u5DVvpzN7Q1oiZ8k=; b=mTzntWJI0SJeZcMrBaLvd0ldK
        J3HnINVu5/mc5x9BqnG7I4lcr+Vp8LeIX8HP9upZeAQDZQrnw1KDs01TRLGmM6J5me2aq8pTcq7a5
        +suqPvsPqHv7GYYgNMp/iYNmuSwTz3H3EoopeAOmdbxN2WEJfhujGNfEpoPfsuKg4q2b6+ZIPvhMu
        fH1Y3jY+jWQ8xZMOKOMu5pFzuxDUu9s7D7yDHvXB6uyX+sm4Pq/o5N/kY7Ax/3xKQ5aF/0PMSvDQH
        yHWsRfz3HudWeyt90N8E7puy66pRc7ZScHbwKJPkivPokcOVt6FYDL96eahcmfmOWF8Mz6CbxrB35
        ft8COwoBg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gxC5t-0007yd-Az; Fri, 22 Feb 2019 14:46:29 +0000
Date:   Fri, 22 Feb 2019 06:46:29 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 08/10] MIPS: SGI-IP27: use generic PCI driver
Message-ID: <20190222144628.GA10643@infradead.org>
References: <20190219155728.19163-1-tbogendoerfer@suse.de>
 <20190219155728.19163-9-tbogendoerfer@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190219155728.19163-9-tbogendoerfer@suse.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> diff --git a/arch/mips/include/asm/dma-direct.h b/arch/mips/include/asm/dma-direct.h
> index b5c240806e1b..bd11e7934df1 100644
> --- a/arch/mips/include/asm/dma-direct.h
> +++ b/arch/mips/include/asm/dma-direct.h
> @@ -2,6 +2,8 @@
>  #ifndef _MIPS_DMA_DIRECT_H
>  #define _MIPS_DMA_DIRECT_H 1
>  
> +#include <dma-direct.h>
> +
>  static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
>  {
>  	if (!dev->dma_mask)

How is your mach dma-direct.h scheme going to work, given that
we already have non-inline declarations of __phys_to_dma / __dma_to_phys
in this file?

Also this really should go into a separate commit, and we should either
have all of these functions inline or none.  Having all of them out
of line seemed a lot saner to me to avoid all the mach header mess.

Also there seem to be a lot of randomw whitespace / brace cleanups
in this patch.  Shouldn't those be split out as well?
