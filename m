Return-Path: <SRS0=agom=SC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 717FBC43381
	for <linux-pci@archiver.kernel.org>; Sun, 31 Mar 2019 05:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2952E2146F
	for <linux-pci@archiver.kernel.org>; Sun, 31 Mar 2019 05:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="er+Ud9Ii"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725878AbfCaFSv (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 31 Mar 2019 01:18:51 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38389 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfCaFSu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 31 Mar 2019 01:18:50 -0400
Received: by mail-pg1-f195.google.com with SMTP id j26so3115655pgl.5;
        Sat, 30 Mar 2019 22:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7yCHN/dP49k1XA/WvpBMtocSjKIdauF79STUzpbwTvE=;
        b=er+Ud9IiAB9TSUyqZG16FVg+kZTAbl7Xkj6wF12ttMAiLqStF0b1vVktv47Htf6wFI
         IBsK8bom9+gK17NsvHxdFIXzlIJltjswRfiBpHjqrzTXtquNwyEW6Si1uYNxcgwVJvwf
         Fvu8btEN7iT9rScfabpHWEFKZ6xlCx8EoBIp7LQbEzphEmXjjDNAatpXooStjFUsg5dq
         71XaIwA9c6N7l680N21XqvyAGweXlmkuMSiYOtW8Sdb/T1D+iH+WFudFY8egBhFLcf35
         Rzld9FlK0zoC4YqYibGn2+ptVETO4IgBTdTqo/tJQc24WX3I6BMnOZq+hFUcBL6FqRDp
         ihew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7yCHN/dP49k1XA/WvpBMtocSjKIdauF79STUzpbwTvE=;
        b=DA3bM3NOxFLtrsic7UMwrBWw/azI8BpbiF2OTYM96bE2iGdtcIUfuHlofi0Cg2wIEa
         bZ4ytvbV8ObkeQshYHJlJO8pOIQBYtzRG+7dcWrCl8knrQWav+2nL9mBP1iE4rYDKAWJ
         RnaoDQcJ2zJvqkX5Xy9CXLNsZdsw24NIZYL5KDfILnZ5Sk1ixfRsxqbIDxLkUn+WqDCT
         hAPvDqwrvwyIrnGMhW8HgtDy+cmLKWmgsGJfJrlQQvzblqs2PoMp3Dvj8zDQaHxLzFnM
         hwq4a5bTVCCAAqSw+yfcStj11HvcslYP1Z+r6A9vwOWOJHc6bLjFAmqAr8bMjQjMbVco
         1gag==
X-Gm-Message-State: APjAAAXIyP/zt/YUwhJAHcQRnILnveNd9hEgj25+i200JkJzdxnzcFCe
        /MR0pm2exABWm6OL09m6XZ4=
X-Google-Smtp-Source: APXvYqwMRIrGrt+S6wMHa2XEqWy/iRguehCnxDCdQuYs+pidhnp31c1bepV25Wl6zoGSyxtX+6jGzQ==
X-Received: by 2002:a65:63c2:: with SMTP id n2mr18341384pgv.439.1554009529999;
        Sat, 30 Mar 2019 22:18:49 -0700 (PDT)
Received: from mail.google.com ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id b15sm8948103pgg.90.2019.03.30.22.18.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Mar 2019 22:18:49 -0700 (PDT)
Date:   Sun, 31 Mar 2019 05:18:47 +0000
From:   Changbin Du <changbin.du@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/12] pci doc: convert PCI/MSI-HOWTO.txt to rst format
Message-ID: <20190331051846.nrjvqjkp7ocdbycv@mail.google.com>
References: <20190329160413.4293-1-changbin.du@gmail.com>
 <20190329160413.4293-6-changbin.du@gmail.com>
 <20190330040009.GY10344@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190330040009.GY10344@bombadil.infradead.org>
User-Agent: NeoMutt/20180716-508-7c9a6d
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 29, 2019 at 09:00:09PM -0700, Matthew Wilcox wrote:
> On Sat, Mar 30, 2019 at 12:04:06AM +0800, Changbin Du wrote:
> > @@ -1,13 +1,18 @@
> > -		The MSI Driver Guide HOWTO
> > -	Tom L Nguyen tom.l.nguyen@intel.com
> > -			10/03/2003
> > -	Revised Feb 12, 2004 by Martine Silbermann
> > -		email: Martine.Silbermann@hp.com
> > -	Revised Jun 25, 2004 by Tom L Nguyen
> > -	Revised Jul  9, 2008 by Matthew Wilcox <willy@linux.intel.com>
> > -		Copyright 2003, 2008 Intel Corporation
> > +.. SPDX-License-Identifier: GPL-2.0
> > +.. include:: <isonum.txt>
> > +
> > +==========================
> > +The MSI Driver Guide HOWTO
> > +==========================
> > +
> > +:Authors: - Tom L Nguyen <tom.l.nguyen@intel.com> 10/03/2003
> > +          - Revised Feb 12, 2004 by Martine Silbermann <Martine.Silbermann@hp.com>
> > +	  - Revised Jun 25, 2004 by Tom L Nguyen
> > +	  - Revised Jul  9, 2008 by Matthew Wilcox <willy@linux.intel.com>
> > +	    Copyright 2003, 2008 Intel Corporation
> 
> The copyright line doesn't work quite the way it should in the rendered HTML.
> 
> It seems to me it should be:
> 
> :Copyright: 2003, 2008 Intel Corporation
> 
> Tom has used an ambiguous date format; given it appeared in the tree
> in December 2003, I suspect he's used middle-endian format.  It doesn't
> really seem relevant to have the dates here any more, so we could skip
> including them.  Also, none of these email addresses work, so perhaps
> just drop those too.
> 
> :Authors: Tom L Nguyen; Martine Silbermann; Matthew Wilcox
>
yeah, looks better. Thanks.

> >  1. About this guide
> > +===================
> 
> Should we drop the numbering of sections as part of this conversion?
> I'd be inclined to.
>
yes, sphix can generate the numbering.

> >  4.2 Using MSI
> > +-------------
> >  
> >  Most of the hard work is done for the driver in the PCI layer.  The driver
> >  simply has to request that the PCI layer set up the MSI capability for this
> >  device.
> >  
> >  To automatically use MSI or MSI-X interrupt vectors, use the following
> > -function:
> > +function::
> >  
> >    int pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
> >  		unsigned int max_vecs, unsigned int flags);
> 
> This should really be turned into kernel-doc and moved to pci.h, but
> that seems like an awfully large amount of work to ask you to do when
> you're already doing so much to improve the situation.
> 
> This is also a really bad document.  It has three audiences; people
> configuring their kernel, people writing device drivers and people trying
> to debug why their kernel doesn't work.  Again, that's not on you to
> fix, but it's pretty frustrating to see so much good information so
> badly organised.
I agree. But content improvment is out of this topic. So I will just
do the conversion in this serias.

-- 
Cheers,
Changbin Du
