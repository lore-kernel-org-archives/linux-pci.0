Return-Path: <SRS0=jDI6=QI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E53C282DA
	for <linux-pci@archiver.kernel.org>; Fri,  1 Feb 2019 19:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF3FC218FC
	for <linux-pci@archiver.kernel.org>; Fri,  1 Feb 2019 19:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549049011;
	bh=JtARWa6vpPVpmOwV28/tNYlqwDtzd5HB+Ho9W0fbgHA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=S3RGgfFfGu+kCZTEJIqpE/2WNnCRkBa203gw7Gyrkf3hwTGlNtpe/taJZ28DN7xrp
	 Is69vX8q4oHh4PUAAZfj7ReQEt26V1epz0VWQ4Ls38KpfWU//1QBOQE2EK49Lm4iCY
	 ER0mgSxa2DLEgL1RXQqtdY83nQArn4calj0ihEUU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728770AbfBATX0 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 1 Feb 2019 14:23:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:52422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbfBATX0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 Feb 2019 14:23:26 -0500
Received: from localhost (unknown [64.22.249.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18029218AF;
        Fri,  1 Feb 2019 19:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549049005;
        bh=JtARWa6vpPVpmOwV28/tNYlqwDtzd5HB+Ho9W0fbgHA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CmFeMfVcyxKOdM6/skBqi1WDLq0vkzZwo4xa159bncZ+BsA/V2SzKAzydWdzCe696
         XgTL3ZgHvGEJv2/DYRn7skuLZO13fy9/q7iT/nWs73eLwaGrxZg/D/ZLLKNiynUVvY
         jo54/u0yOi3uLLc2gB9tz3q9Gbz2UoL9w0RDC7Og=
Date:   Fri, 1 Feb 2019 13:23:23 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>, g@google.com
Cc:     linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com,
        linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kselftest@vger.kernel.org, Jon Mason <jdmason@kudzu.us>,
        Joerg Roedel <joro@8bytes.org>,
        Allen Hubbe <allenbh@gmail.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Eric Pilmore <epilmore@gigaio.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH 2/9] PCI/MSI: Support allocating virtual MSI interrupts
Message-ID: <20190201192323.GS229773@google.com>
References: <20190131185656.17972-1-logang@deltatee.com>
 <20190131185656.17972-3-logang@deltatee.com>
 <20190131223932.GR229773@google.com>
 <74993e67-cdc5-234a-d26c-5c0177a0299a@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74993e67-cdc5-234a-d26c-5c0177a0299a@deltatee.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 31, 2019 at 03:52:09PM -0700, Logan Gunthorpe wrote:
> On 2019-01-31 3:39 p.m., Bjorn Helgaas wrote:
> >> diff --git a/include/linux/msi.h b/include/linux/msi.h
> >> index 784fb52b9900..6458ab049852 100644
> >> --- a/include/linux/msi.h
> >> +++ b/include/linux/msi.h
> >> @@ -88,6 +88,7 @@ struct msi_desc {
> >>  				__u8	multi_cap	: 3;
> >>  				__u8	maskbit		: 1;
> >>  				__u8	is_64		: 1;
> >> +				__u8    is_virtual      : 1;
> > 
> > You did the right thing by using the same style as what's already
> > here, but does anybody know why are we using __u8 and __u16 here?
> > 
> > Those typedefs are in include/uapi/asm-generic/int-l64.h, which
> > suggests they're for things exported to user space, but I don't think
> > that's the case here, so I'm wondering if we could someday replace
> > these with u8 and u16.  Obviously that wouldn't be part of *this*
> > series.
> 
> Yes, I was also confused by this. But I always follow the "when-in-rome"
> rule. 

Thanks for following the "when-in-rome" rule.  That seems so obvious
that it wouldn't even need to be written down, but it is often
ignored.

> My understanding is the same as yours is that __u8 should be used
> for userspace compatibility which doesn't apply here. If there is
> consensus on this being wrong, I'd be happy to write a cleanup patch
> that fixes it separate from this series.

That'd be awesome.  There are also a couple more in pci-driver.c that
could be fixed at the same time.

Bjorn
