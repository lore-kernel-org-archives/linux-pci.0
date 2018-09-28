Return-Path: <SRS0=ex/N=MK=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B293C43143
	for <linux-pci@archiver.kernel.org>; Fri, 28 Sep 2018 21:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F5C12073F
	for <linux-pci@archiver.kernel.org>; Fri, 28 Sep 2018 21:48:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UDrVigNG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F5C12073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbeI2ENy (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 29 Sep 2018 00:13:54 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46089 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725266AbeI2ENy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 29 Sep 2018 00:13:54 -0400
Received: by mail-lf1-f65.google.com with SMTP id q2-v6so6013404lfc.13;
        Fri, 28 Sep 2018 14:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aXMoAqM9r4NaN21CI8lgLEpYGKDp9ejOhdEFf2jry4k=;
        b=UDrVigNGakKD4/2ayNH5DDSzkxezOVk6v4KNgh99OUp4Ey+DhEWAKsHFrIzeshiNa1
         89uN7ISSKS7pimmnagJ4p0dJKw5q4p6J2wOmXNAzPsmQCSCd03/d78gLjAWB5E2+E79L
         UQExrPfpvDt9eOVnf4bqr2UQOm9sNn1qe5haYv6SNvka16x+i4NBgIj+nKC5fB88DUV2
         F6wZrS2q3nLt93ZyPAaygxWOiu8elavHK2N8BZzO8J3vMxj7U5fSJnE4bfy+5uTJNfFt
         w8UdcGXEZN8f8+EvlAvjWHd/vUyIDrcxRodv/gdcYvf4FRgLNd18/m+vi2giAPx7YsLm
         S+jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aXMoAqM9r4NaN21CI8lgLEpYGKDp9ejOhdEFf2jry4k=;
        b=R/3Ea/Kt71uNt0FI1i1kOOBMbeJuDxB2ACiveDghpp7OyQY6hCaJPOVgYkBzN7Wqvk
         utaXk1iIdzvset3DE6kFK5AIqM4Scj0rDZesAfFqlImxeut8MkVO9aNdDiHhGw1rOMnI
         i7KDOv4G2/8jRIqF2qd02dJJduGOmWm9P/6hPKuUKFR7w9NwMdqzYXbY7Mxa+wHuxzoN
         QIPV6yNR7NPTEpod6uN6cbkIgV+0UsdfURASwFjzQ3XOhZo81IalLkXGzs+Yw3dcXaWX
         SUUUZCf50Yhmr1Xfi6sr0FptAVuLO2nOVBdc0zcIRDtTj9lZmbHJiudWkgt/qt4IK7OT
         SP5A==
X-Gm-Message-State: ABuFfoh1a3pF8txaualbYckm9oZdbDaA3FBPKDhvpqzOKNuw4xgRZRs9
        nLCKVON+lRwBgxfbtE+dt+sVBSLeft+uPMZ5xlY=
X-Google-Smtp-Source: ACcGV62Rps4gGqqHgUTqH4D7uYfGbRQseCkclr7u4Y/WS5FoeKHU1tao+6bHcVO0XYrHUaPL7BqNM5lr3+7xzMGBJ1Y=
X-Received: by 2002:a19:e44b:: with SMTP id b72-v6mr251910lfh.77.1538171292608;
 Fri, 28 Sep 2018 14:48:12 -0700 (PDT)
MIME-Version: 1.0
References: <1537367527-20773-1-git-send-email-jim2101024@gmail.com>
 <1537367527-20773-7-git-send-email-jim2101024@gmail.com> <20180926220703.4ocppooccuot55i5@pburton-laptop>
In-Reply-To: <20180926220703.4ocppooccuot55i5@pburton-laptop>
From:   Jim Quinlan <jim2101024@gmail.com>
Date:   Fri, 28 Sep 2018 17:48:00 -0400
Message-ID: <CANCKTBs--M6FHHp4YMcTGox+OeKanz2-QJ8-1_R99XHq2iR37g@mail.gmail.com>
Subject: Re: [PATCH v5 06/12] MIPS: BMIPS: add dma remap for BrcmSTB PCIe
To:     Paul Burton <paul.burton@mips.com>
Cc:     linux-kernel@vger.kernel.org, Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 26, 2018 at 6:07 PM Paul Burton <paul.burton@mips.com> wrote:
>
> Hi Jim,
>
> On Wed, Sep 19, 2018 at 10:32:01AM -0400, Jim Quinlan wrote:
> > The design of the Broadcom PCIe RC controller requires us to remap its
> > DMA addresses for inbound traffic.  We do this by modifying the
> > definitions of __phys_to_dma() and __dma_to_phys().
> >
> > In arch/mips/bmips/dma.c, these functions are already in use to remap
> > DMA addresses for the 338x SOC chips.  We leave this code alone -- and
> > give its mapping priority -- but if it is not in use, the PCIe DMA
> > mapping is in effect.
> >
> > One might think that the two DMA remapping systems of dma.c could be
> > combined, but they cannot: one governs only DMA addresses for the PCIe
> > controller of BrcmSTB ARM/ARM64/MIPs chips, while the other governs
> > the PCIe controller *and* other peripherals for only MIPs 338x
> > chips.
> >
> > Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> > ---
> >  arch/mips/bmips/dma.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
>
> Please copy me/linux-mips on the whole series next time - I seem to have
> only received patches 6, 8 & 9 which means I have no idea whether they
> have dependencies & if so whether those dependencies have been accepted
> or rejected. I also have no clue whether these patches make sense to
> take through the MIPS tree or if it would make more sense for someone
> else to take them with acks.
Hi Paul,
I had problem with the first time I sent this out and someone said I
should reduce me email list so I used the "git email --cc_cmd
get_mainters.pl".  I'll switch back to an aggregate email list.

>
> > diff --git a/arch/mips/bmips/dma.c b/arch/mips/bmips/dma.c
> > index 3d13c77..292994f 100644
> > --- a/arch/mips/bmips/dma.c
> > +++ b/arch/mips/bmips/dma.c
> > @@ -18,6 +18,7 @@
> >  #include <linux/slab.h>
> >  #include <linux/types.h>
> >  #include <asm/bmips.h>
> > +#include <soc/brcmstb/common.h>
> >
> >  /*
> >   * BCM338x has configurable address translation windows which allow the
> > @@ -44,6 +45,10 @@ dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t pa)
> >  {
> >       struct bmips_dma_range *r;
> >
> > +#ifdef CONFIG_PCIE_BRCMSTB
> > +     if (!bmips_dma_ranges)
> > +             return brcm_phys_to_dma(dev, pa);
> > +#endif
> >       for (r = bmips_dma_ranges; r && r->size; r++) {
> >               if (pa >= r->child_addr &&
> >                   pa < (r->child_addr + r->size))
>
> I can't tell because I presume brcm_phys_to_dma() is added in one of
> those patches I wasn't copied on, but perhaps you could avoid the #ifdef
> by just returning brcm_phys_to_dma(dev, pa) after the loop?

Yes, will rectify in next version.

>
> > @@ -56,6 +61,10 @@ phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t dma_addr)
> >  {
> >       struct bmips_dma_range *r;
> >
> > +#ifdef CONFIG_PCIE_BRCMSTB
> > +     if (!bmips_dma_ranges)
> > +             return (unsigned long)brcm_dma_to_phys(dev, dma_addr);
> > +#endif
> >       for (r = bmips_dma_ranges; r && r->size; r++) {
> >               if (dma_addr >= r->parent_addr &&
> >                   dma_addr < (r->parent_addr + r->size))
>
> And similar here.
>
Okay, thanks,
Jim
> Thanks,
>     Paul
