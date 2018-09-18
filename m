Return-Path: <SRS0=7uyK=MA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD1DECE562
	for <linux-pci@archiver.kernel.org>; Tue, 18 Sep 2018 02:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 833D2214C5
	for <linux-pci@archiver.kernel.org>; Tue, 18 Sep 2018 02:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YOENmpFO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 833D2214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbeIRHab (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 18 Sep 2018 03:30:31 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:35687 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbeIRHab (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Sep 2018 03:30:31 -0400
Received: by mail-oi0-f66.google.com with SMTP id m11-v6so314509oic.2
        for <linux-pci@vger.kernel.org>; Mon, 17 Sep 2018 19:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QV1no5pYTas9K4Y4NpJHSo6Fa9gttO5sedjW+IN8UOI=;
        b=YOENmpFOm5LOiBCNRorx94vdc8Ur49xhLWS8h7duDPiPBq3JLZH5I4/t3kwpfkcrJp
         qDMexuA+DLz5uBZA5/GyiCnIy+ZXuhDbhtRt2uuGAX/UIw76Xf9IK8TMsUSgkxqpFrrq
         kq2MNWFY5p4IslZ/62j5DW6r5f/T/zYR6v1yAHbd+k+7ZVadLOD3+3TA2rDWCTv/1HMw
         TzkAeGPF1b4bCLCvD78d4VxtfsSryHJ14faC+QAS0+iFs/YosYA6DuVbEgD72bbHISBI
         EX1qcuZvk/ZyxiVPBepQ4enxH9miR3WdgX2jomGaYmFq/vtdbCH5fxmww19xIBgCrRpT
         QcYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QV1no5pYTas9K4Y4NpJHSo6Fa9gttO5sedjW+IN8UOI=;
        b=oJiEix3AUTt/mIi1wcCeRZ7CQiN/5QS3h5gN1/ajo/BCFgdnVxXrnqBkI9aDFj38lN
         7NFGFOlfr3iRtuyPxAKdWEIBo9fBQeCPLao/bNT17FLXfmVDMfpUhe0eU8BYoGn+i4Z3
         0+OFFxhWhNk8sLz+tNS1WdjfCOmJw5IkghFV+J8BbZ9x2AfUGDE9S8A0xztaD5hQnKfZ
         zAEESa6IYxsT+iwhuX0N7sdzljc6pZuAZ9iI2ySiSBHUjQtW29ETDveLDwftvClgF381
         WFiwaH0mHm/qsvwlI7RTVYSXoLKzZuDIGCnbo1DvqeppC32HO7bWeuB0EL94QnttzCTL
         CnsQ==
X-Gm-Message-State: APzg51CNUNbFqXKGJb540n490655WKlu++YcIk8Wi/erIvs6cbi0ThsN
        1erGQPV3x6Il5dKXVwD77v+LpZVr6en4FKUsrZ2tDQ==
X-Google-Smtp-Source: ANB0VdZlzdi3PhYaAd1cBPNbghHobjwIYiY+faNSVSEbryqfYFuUJGBx74j/BMTbL4KMbysJXgajzcdBwq+DEMb3RvA=
X-Received: by 2002:aca:aa8d:: with SMTP id t135-v6mr186658oie.218.1537236022548;
 Mon, 17 Sep 2018 19:00:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAMDZJNV6D_NCn5_n2DAnPH25DONAKRcc-GWwGbCXX098E+EJ1Q@mail.gmail.com>
 <20180917191503.GA54859@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180917191503.GA54859@bhelgaas-glaptop.roam.corp.google.com>
From:   Tonghao Zhang <xiangxia.m.yue@gmail.com>
Date:   Tue, 18 Sep 2018 10:00:11 +0800
Message-ID:
 <CAMDZJNUg+d6um2tp20OwyhSYG4WW8jSbwLhDAU8qOsqfkO=EfQ@mail.gmail.com>
Subject: Re: kernel panic becase pci register more than once
To:     helgaas@kernel.org
Cc:     linux-pci@vger.kernel.org, hch@lst.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
Message-ID: <20180918020011._D9KKnLxHs-if9fq_ubr4RR0uj753UMcQ34BKzclcVk@z>

On Tue, Sep 18, 2018 at 3:15 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Christoph]
>
> On Sun, Sep 09, 2018 at 04:26:37PM +0800, Tonghao Zhang wrote:
> > Hi all,
> > When I enable pci msi or msix more than once, the kernel will panic.
> > Now we just use the WARN_ON, should we add check for that has been
> > enabled.
> >
>
> This needs a signed-off-by before I can apply it.  See
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst#n416
OK
> A WARN_ON() shouldn't cause the kernel to panic.  Do you mean that it
> causes a backtrace?  I think that's the intended behavior, because
> calling this twice would be a driver bug, and we want to find and fix
> those bugs.
Yes, you are right, but we can return error code when drivers call this twice.
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
> >
> >         /* Check whether driver already requested for MSI irq */
> >         if (dev->msi_enabled) {
> > @@ -1028,7 +1030,8 @@ static int __pci_enable_msi_range(struct pci_dev
> > *dev, int minvec, int maxvec,
> >         if (!pci_msi_supported(dev, minvec))
> >                 return -EINVAL;
> >
> > -       WARN_ON(!!dev->msi_enabled);
> > +       if (dev->msi_enabled)
> > +               return -EINVAL;
> >
> >         /* Check whether driver already requested MSI-X irqs */
> >         if (dev->msix_enabled) {
