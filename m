Return-Path: <SRS0=mfjy=D6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD77EC55179
	for <linux-pci@archiver.kernel.org>; Fri, 23 Oct 2020 09:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58E0024640
	for <linux-pci@archiver.kernel.org>; Fri, 23 Oct 2020 09:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SDjfhsVk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S461431AbgJWJ05 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 23 Oct 2020 05:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S461430AbgJWJ05 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Oct 2020 05:26:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D717EC0613CE;
        Fri, 23 Oct 2020 02:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BKZIIgBf58AUlCS0IyOX4hD8ww+CQlcZeVUupxKyAS8=; b=SDjfhsVkH1skfqXSp285nlZJZZ
        Jgum0mk7MCgh0ZXMWoqRKRfuKqMMSNANAwztx604THcb6qRJAmNzhBC7XspJTmFqj+KGcnez5xTwQ
        EtauYCtW5yVOW9zKG/5I+49yTR8V6mPu2KYn1G7NuqTv9WWJ4zhExwJK3RVioZrDMX8aL64G0xhHC
        lnVJKXmfsUIErlOXeU/VX/Ycymcv03GqpKcWdoXfB38jFtsBCLinrONdhO9jSjp1IPej19zEDvW5g
        Y/VYRjSsxC5YHst5bD2EZoJn5rg19CQ/wnP3WIJttF6Is1khBp/iLAwkJ8NJE9nf5EcHGigpegRLx
        icmHtRTw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVtLW-0007yO-If; Fri, 23 Oct 2020 09:26:50 +0000
Date:   Fri, 23 Oct 2020 10:26:50 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Sherry Sun <sherry.sun@nxp.com>
Cc:     hch@infradead.org, sudeep.dutt@intel.com, ashutosh.dixit@intel.com,
        arnd@arndb.de, gregkh@linuxfoundation.org, kishon@ti.com,
        lorenzo.pieralisi@arm.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-imx@nxp.com
Subject: Re: [PATCH V3 2/4] misc: vop: do not allocate and reassign the used
 ring
Message-ID: <20201023092650.GB29066@infradead.org>
References: <20201022050638.29641-1-sherry.sun@nxp.com>
 <20201022050638.29641-3-sherry.sun@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201022050638.29641-3-sherry.sun@nxp.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 22, 2020 at 01:06:36PM +0800, Sherry Sun wrote:
> We don't need to allocate and reassign the used ring here and remove the
> used_address_updated flag.Since RC has allocated the entire vring,
> including the used ring. Simply add the corresponding offset can get the
> used ring address.

Someone needs to verify this vs the existing intel implementations.

> -	used = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
> -					get_order(vdev->used_size[index]));
> +	used = va + PAGE_ALIGN(sizeof(struct vring_desc) * le16_to_cpu(config.num) +

This adds an over 80 char line.

> +	vdev->used[index] = config.address + PAGE_ALIGN(sizeof(struct vring_desc) * le16_to_cpu(config.num) +

Again.

