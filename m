Return-Path: <SRS0=/keI=R5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7844FC43381
	for <linux-pci@archiver.kernel.org>; Tue, 26 Mar 2019 20:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45F692084B
	for <linux-pci@archiver.kernel.org>; Tue, 26 Mar 2019 20:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553632671;
	bh=j8Ouo7uvXL1htCDFNVRNXz6DNock5QSI6x3n0YkjgZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qX5WRdMUF+kHhhZUJ1F3G9iMFUGc7dioI2sRNNH154Uu47YogqDIut8K6KyxAj13/
	 tBD9RTbm+SUTO/+QyDIu8dYzSsbG2GcRe/PsCp8QENqHb6efRTd+CK0lTSYp08ndMb
	 E2Wjr+v3Wz4L6rjzRXJf3xhEu16F7GImxhrjdBvw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732042AbfCZUhu (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 26 Mar 2019 16:37:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:56472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726207AbfCZUhu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Mar 2019 16:37:50 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C70520823;
        Tue, 26 Mar 2019 20:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553632669;
        bh=j8Ouo7uvXL1htCDFNVRNXz6DNock5QSI6x3n0YkjgZs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZUCS/AYn6EfzxXn226JHU35PTiJ3BXvfBOk9pqeNwNk+oROyQtGjauBkw4PQUDPUG
         LGJRM5QejVGggeUS1vU/+9/CDNkhTDqM+OXKYoPF7gCFYLHRKBLec8svZ4RGc95r5T
         YbrS1LGhi8WpLxODLG8XFY4cFBxkK/clKZo5/I8U=
Date:   Tue, 26 Mar 2019 15:37:47 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Cc:     linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux@yadro.com
Subject: Re: [PATCH RFC v4 10/21] PCI: Fix assigning of fixed prefetchable
 resources
Message-ID: <20190326203747.GR24180@google.com>
References: <20190311133122.11417-1-s.miroshnichenko@yadro.com>
 <20190311133122.11417-11-s.miroshnichenko@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311133122.11417-11-s.miroshnichenko@yadro.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 11, 2019 at 04:31:11PM +0300, Sergey Miroshnichenko wrote:
> Allow matching them to non-prefetchable windows, as it is done for movable
> resources.

Please make the commit log complete in itself, without requiring the
subject.  It's OK if you have to repeat the subject.

IIUC, this is actually a bug fix and is not strictly related to
movable resources.  We should be able to have a IORESOURCE_PCI_FIXED
prefetchable BAR in a non-prefetchable window.

I suppose movable windows exposes this case because as currently
implemented, it marks many more BARs as IORESOURCE_PCI_FIXED.  I think
we should use something other than IORESOURCE_PCI_FIXED for that case,
so maybe this patch will end up being unnecessary?

> Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
> ---
>  drivers/pci/setup-bus.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 3644feb13179..be7d4e6d7b65 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1301,15 +1301,20 @@ static void assign_fixed_resource_on_bus(struct pci_bus *b, struct resource *r)
>  {
>  	int i;
>  	struct resource *parent_r;
> -	unsigned long mask = IORESOURCE_IO | IORESOURCE_MEM |
> -			     IORESOURCE_PREFETCH;
> +	unsigned long mask = IORESOURCE_TYPE_BITS;
>  
>  	pci_bus_for_each_resource(b, parent_r, i) {
>  		if (!parent_r)
>  			continue;
>  
> -		if ((r->flags & mask) == (parent_r->flags & mask) &&
> -		    resource_contains(parent_r, r))
> +		if ((r->flags & mask) != (parent_r->flags & mask))
> +			continue;
> +
> +		if (parent_r->flags & IORESOURCE_PREFETCH &&
> +		    !(r->flags & IORESOURCE_PREFETCH))
> +			continue;
> +
> +		if (resource_contains(parent_r, r))
>  			request_resource(parent_r, r);
>  	}
>  }
> -- 
> 2.20.1
> 
