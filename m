Return-Path: <SRS0=6dzI=RC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B25D2C4360F
	for <linux-pci@archiver.kernel.org>; Wed, 27 Feb 2019 17:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8312420842
	for <linux-pci@archiver.kernel.org>; Wed, 27 Feb 2019 17:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728751AbfB0RK5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 27 Feb 2019 12:10:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:36136 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726181AbfB0RK5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 27 Feb 2019 12:10:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3F0DEAFCB;
        Wed, 27 Feb 2019 17:10:56 +0000 (UTC)
Date:   Wed, 27 Feb 2019 18:10:55 +0100
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 08/10] MIPS: SGI-IP27: use generic PCI driver
Message-Id: <20190227181055.365f5f19ee724010ba37a81a@suse.de>
In-Reply-To: <20190222144628.GA10643@infradead.org>
References: <20190219155728.19163-1-tbogendoerfer@suse.de>
        <20190219155728.19163-9-tbogendoerfer@suse.de>
        <20190222144628.GA10643@infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 22 Feb 2019 06:46:29 -0800
Christoph Hellwig <hch@infradead.org> wrote:

> > diff --git a/arch/mips/include/asm/dma-direct.h b/arch/mips/include/asm/dma-direct.h
> > index b5c240806e1b..bd11e7934df1 100644
> > --- a/arch/mips/include/asm/dma-direct.h
> > +++ b/arch/mips/include/asm/dma-direct.h
> > @@ -2,6 +2,8 @@
> >  #ifndef _MIPS_DMA_DIRECT_H
> >  #define _MIPS_DMA_DIRECT_H 1
> >  
> > +#include <dma-direct.h>
> > +
> >  static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
> >  {
> >  	if (!dev->dma_mask)
> 
> How is your mach dma-direct.h scheme going to work, given that
> we already have non-inline declarations of __phys_to_dma / __dma_to_phys
> in this file?

the compiler is fine with the declarations, that's why I left the non-inline
prototypes as they are

> Also this really should go into a separate commit, and we should either
> have all of these functions inline or none.  Having all of them out
> of line seemed a lot saner to me to avoid all the mach header mess.

hmm, so your inline version in include/linux/dma-direct.h is ok, while
doing the same for MIPS in an other header files isn't ? Sounds inconsistent
to me.

Anyway I'll move __phys_to_dma/__dma_to_phy into a fitting/new .c file in
the next version of the series.

Thomas.

-- 
SUSE Linux GmbH
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
