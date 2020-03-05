Return-Path: <SRS0=ofoM=4W=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36610C3F2D1
	for <linux-pci@archiver.kernel.org>; Thu,  5 Mar 2020 16:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04B1B2146E
	for <linux-pci@archiver.kernel.org>; Thu,  5 Mar 2020 16:36:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UJibfdPp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbgCEQgd (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 5 Mar 2020 11:36:33 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56310 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbgCEQgd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Mar 2020 11:36:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IN0z5lvxX3vfG4LlR2OLwyz2tFIOaeyOpNZ/LAjxDFE=; b=UJibfdPpIN84IhGGV66FPK3zNA
        yzVJpxyXzBbrmM5EvaVqPmPWHjvZR+sV4xZ14YVEOnaN8OOkCuH8q0AT4VeUlWx807tTEAH18J6Bk
        JIm5SKt7rEZQ/hDAgkoqur9CPBKLhHBF0YRspnJbyni4rW7a0oT944GJJS+12KbkBkGC1Pl5FSBJz
        Uoh08v2WTHIfTMXi9KnTDqdE1vEo42kw5RuS+Jtq9QWJOxyAF4F7VkX3oViG/23kudgEKDkxvvzmm
        Z392HeGdJZ+fM7Twz/UX0YPWV3KCG1aAU+wMcKjeXQ0m7rUdsK6NwE13/Yc86vw33q6rAJ3JLag1t
        /FLdA+0A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j9tU5-0006i6-Lu; Thu, 05 Mar 2020 16:36:29 +0000
Date:   Thu, 5 Mar 2020 08:36:29 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, joro@8bytes.org, robh+dt@kernel.org,
        mark.rutland@arm.com, catalin.marinas@arm.com, will@kernel.org,
        robin.murphy@arm.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, Jonathan.Cameron@huawei.com,
        jacob.jun.pan@linux.intel.com, christian.koenig@amd.com,
        yi.l.liu@intel.com, zhangfei.gao@linaro.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dimitri Sivanich <sivanich@sgi.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v4 01/26] mm/mmu_notifiers: pass private data down to
 alloc_notifier()
Message-ID: <20200305163629.GA14299@infradead.org>
References: <20200224182401.353359-1-jean-philippe@linaro.org>
 <20200224182401.353359-2-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224182401.353359-2-jean-philippe@linaro.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 24, 2020 at 07:23:36PM +0100, Jean-Philippe Brucker wrote:
> -static struct mmu_notifier *gru_alloc_notifier(struct mm_struct *mm)
> +static struct mmu_notifier *gru_alloc_notifier(struct mm_struct *mm, void *privdata)

Pleae don't introduce any > 80 char lines.  Not here, and not anywhere
else in this patch or the series.
