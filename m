Return-Path: <SRS0=Tpvo=MC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE784ECE561
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 06:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7564621525
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 06:40:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7564621525
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731305AbeITMWr (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 20 Sep 2018 08:22:47 -0400
Received: from verein.lst.de ([213.95.11.211]:57873 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731240AbeITMWr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Sep 2018 08:22:47 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 72D5E68D79; Thu, 20 Sep 2018 08:40:55 +0200 (CEST)
Date:   Thu, 20 Sep 2018 08:40:55 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Tonghao Zhang <xiangxia.m.yue@gmail.com>,
        linux-pci@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: kernel panic becase pci register more than once
Message-ID: <20180920064055.GH12913@lst.de>
References: <CAMDZJNV6D_NCn5_n2DAnPH25DONAKRcc-GWwGbCXX098E+EJ1Q@mail.gmail.com> <20180917191503.GA54859@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180917191503.GA54859@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 17, 2018 at 02:15:03PM -0500, Bjorn Helgaas wrote:
> A WARN_ON() shouldn't cause the kernel to panic.  Do you mean that it
> causes a backtrace?  I think that's the intended behavior, because
> calling this twice would be a driver bug, and we want to find and fix
> those bugs.
> 
> > diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> > index f2ef896..324840f 100644
> > --- a/drivers/pci/msi.c
> > +++ b/drivers/pci/msi.c
> > @@ -958,7 +958,9 @@ static int __pci_enable_msix(struct pci_dev *dev,
> > struct msix_entry *entries,
> >                         }
> >                 }
> >         }
> > -       WARN_ON(!!dev->msix_enabled);
> > +
> > +       if (dev->msix_enabled)
> > +               return -EINVAL;

This is a grave driver bug, so we should keep a trace.  Then again
handling even grave driver bugs more gracefull is a good idea, so I'd
vote for:

	if (WARN_ON_ONCE(dev->msix_enabled))
		return -EINVAL;
