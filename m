Return-Path: <SRS0=NgI7=SB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 619C2C43381
	for <linux-pci@archiver.kernel.org>; Sat, 30 Mar 2019 04:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2227820663
	for <linux-pci@archiver.kernel.org>; Sat, 30 Mar 2019 04:00:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A7Y7hpNS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725774AbfC3EAO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 30 Mar 2019 00:00:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59544 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbfC3EAO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 30 Mar 2019 00:00:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=b0PRcjySJV9g1FLkDfsLDA2NdAo7Q/GRjEeeMMiAxdw=; b=A7Y7hpNSQV+NhTG6k2jDAjRyR
        QI/WlkpramYnv9xxxWujcOrHeNNZVn+plyD8iMlTR2BSjxcwAihl5igBz67Hqdk4BMKirbMxmu0D+
        zSahQyvorrTWTJ185ccoYkbChs4UIEhm+6gyOmk0iWdMO7et/XNLs3QgN2t3ZsB5Sfxge6I8kdJAn
        wK6GDjqHm89eGmyJ9TWZ2579qJ6FPMd7p71k8MTNWX6mOzMcOQQka7a2Mv4jbq3Y1LURxXnV5PNyZ
        QOR+/SG63aa0j8nboZyi1JEX5wu3FfnV8tDaC7x01JmENRBKCBgaHwKa7dsRdXMGAqLZTarjMmRyr
        osWeVJ/Sw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hA5A9-0007Sf-KP; Sat, 30 Mar 2019 04:00:09 +0000
Date:   Fri, 29 Mar 2019 21:00:09 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/12] pci doc: convert PCI/MSI-HOWTO.txt to rst format
Message-ID: <20190330040009.GY10344@bombadil.infradead.org>
References: <20190329160413.4293-1-changbin.du@gmail.com>
 <20190329160413.4293-6-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190329160413.4293-6-changbin.du@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Mar 30, 2019 at 12:04:06AM +0800, Changbin Du wrote:
> @@ -1,13 +1,18 @@
> -		The MSI Driver Guide HOWTO
> -	Tom L Nguyen tom.l.nguyen@intel.com
> -			10/03/2003
> -	Revised Feb 12, 2004 by Martine Silbermann
> -		email: Martine.Silbermann@hp.com
> -	Revised Jun 25, 2004 by Tom L Nguyen
> -	Revised Jul  9, 2008 by Matthew Wilcox <willy@linux.intel.com>
> -		Copyright 2003, 2008 Intel Corporation
> +.. SPDX-License-Identifier: GPL-2.0
> +.. include:: <isonum.txt>
> +
> +==========================
> +The MSI Driver Guide HOWTO
> +==========================
> +
> +:Authors: - Tom L Nguyen <tom.l.nguyen@intel.com> 10/03/2003
> +          - Revised Feb 12, 2004 by Martine Silbermann <Martine.Silbermann@hp.com>
> +	  - Revised Jun 25, 2004 by Tom L Nguyen
> +	  - Revised Jul  9, 2008 by Matthew Wilcox <willy@linux.intel.com>
> +	    Copyright 2003, 2008 Intel Corporation

The copyright line doesn't work quite the way it should in the rendered HTML.

It seems to me it should be:

:Copyright: 2003, 2008 Intel Corporation

Tom has used an ambiguous date format; given it appeared in the tree
in December 2003, I suspect he's used middle-endian format.  It doesn't
really seem relevant to have the dates here any more, so we could skip
including them.  Also, none of these email addresses work, so perhaps
just drop those too.

:Authors: Tom L Nguyen; Martine Silbermann; Matthew Wilcox

>  1. About this guide
> +===================

Should we drop the numbering of sections as part of this conversion?
I'd be inclined to.

>  4.2 Using MSI
> +-------------
>  
>  Most of the hard work is done for the driver in the PCI layer.  The driver
>  simply has to request that the PCI layer set up the MSI capability for this
>  device.
>  
>  To automatically use MSI or MSI-X interrupt vectors, use the following
> -function:
> +function::
>  
>    int pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
>  		unsigned int max_vecs, unsigned int flags);

This should really be turned into kernel-doc and moved to pci.h, but
that seems like an awfully large amount of work to ask you to do when
you're already doing so much to improve the situation.

This is also a really bad document.  It has three audiences; people
configuring their kernel, people writing device drivers and people trying
to debug why their kernel doesn't work.  Again, that's not on you to
fix, but it's pretty frustrating to see so much good information so
badly organised.
