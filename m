Return-Path: <SRS0=PFnE=OC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E16C43441
	for <linux-pci@archiver.kernel.org>; Fri, 23 Nov 2018 02:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27BFA20824
	for <linux-pci@archiver.kernel.org>; Fri, 23 Nov 2018 02:38:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="uxXKKh//"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27BFA20824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389876AbeKWNUc (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 23 Nov 2018 08:20:32 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:19399 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727343AbeKWNUc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Nov 2018 08:20:32 -0500
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id wAN2c8vF016514;
        Fri, 23 Nov 2018 11:38:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com wAN2c8vF016514
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1542940689;
        bh=rOnl2xHenEB34XvFlsbt4tdAlicrEGa19eMCQMOc4l8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uxXKKh//SYurRRN136VEZoWFvNIZmdy2tKDqWlbIS+ldFVkpUvP5Uk37hGHdRsnxg
         sdoiIoBK5fwQMm1FziauTF4tca5++E0iHi8ZOuHq44MOBvm/27nkC1RBwOvkm6IrM3
         FMKKQktvfHqPCH9wIhMUGATWJbB3nh5ti4c7qRr2E5SQMWJRuAgOz0V6ewKxPt6awL
         yL5AbJhHV2x/SjH1ZhTFZz9H/ktPen1zUA6ket/yRCZPs3ZB0sHmR9Oc7QkHn4vLL5
         FcutKg8jPKgC4yj5woBeoW6yl0jgZprlCcYq6MYgXfT/v/bSRjFE9RrWq7EckstGeP
         sSaI4uOnOLZfw==
X-Nifty-SrcIP: [209.85.222.51]
Received: by mail-ua1-f51.google.com with SMTP id u19so3665490uae.4;
        Thu, 22 Nov 2018 18:38:08 -0800 (PST)
X-Gm-Message-State: AA+aEWYPSDH3FPTj7Z9jaSi3WWt6WQN+ALTr1kg+SMgFqnILMErcD02U
        3cM8yTWAt3EnJA7fhxlq8Yv2ub+KPPj69wKEMt8=
X-Google-Smtp-Source: AFSGD/Wwp/hah0oo5/0GQfUnvJYH3gLpyQOzZskl7GmU9GiR52iN5Ksf/5RfdO7QvUq7yQYQLdpcoh0AU0XiIzXFmps=
X-Received: by 2002:ab0:6705:: with SMTP id q5mr5908002uam.89.1542940687691;
 Thu, 22 Nov 2018 18:38:07 -0800 (PST)
MIME-Version: 1.0
References: <20181115190538.17016-1-hch@lst.de> <20181115190538.17016-4-hch@lst.de>
 <20181119210141.nissqr6zaldt23xg@pburton-laptop> <20181119210538.p6xhyxf3s2diyv2v@pburton-laptop>
In-Reply-To: <20181119210538.p6xhyxf3s2diyv2v@pburton-laptop>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 23 Nov 2018 11:37:32 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ5DHbe7RwixEi6vf6y+LzB5so0=xyFMMpv+xmEnVA3Mw@mail.gmail.com>
Message-ID: <CAK7LNAQ5DHbe7RwixEi6vf6y+LzB5so0=xyFMMpv+xmEnVA3Mw@mail.gmail.com>
Subject: Re: [PATCH 3/9] MIPS: remove the HT_PCI config option
To:     Paul Burton <paul.burton@mips.com>
Cc:     Christoph Hellwig <hch@lst.de>, mporter@kernel.crashing.org,
        Alex Bounine <alex.bou9@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-pci@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-alpha@vger.kernel.org, Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 20, 2018 at 6:07 AM Paul Burton <paul.burton@mips.com> wrote:
>
> On Mon, Nov 19, 2018 at 01:01:41PM -0800, Paul Burton wrote:
> > On Thu, Nov 15, 2018 at 08:05:31PM +0100, Christoph Hellwig wrote:
> > > This option is always selected from LOONGSON_MACH3X.  Switch to just
> > > seleting PCI from that option and definining LOONGSON_PCIIO_BASE based
> > > on CONFIG_LOONGSON_MACH3X.
> > >
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > ---
> > >  arch/mips/Kconfig                                | 11 -----------
> > >  arch/mips/include/asm/mach-loongson64/loongson.h |  2 +-
> > >  arch/mips/loongson64/Kconfig                     |  2 +-
> > >  3 files changed, 2 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> > > index 8272ea4c7264..7d28c9dd75d0 100644
> > > --- a/arch/mips/Kconfig
> > > +++ b/arch/mips/Kconfig
> > > @@ -3040,17 +3040,6 @@ config PCI
> > >       your box. Other bus systems are ISA, EISA, or VESA. If you have PCI,
> > >       say Y, otherwise N.
> > >
> > > -config HT_PCI
> > > -   bool "Support for HT-linked PCI"
> > > -   default y
> > > -   depends on CPU_LOONGSON3
> > > -   select PCI
> > > -   select PCI_DOMAINS
> > > -   help
> > > -     Loongson family machines use Hyper-Transport bus for inter-core
> > > -     connection and device connection. The PCI bus is a subordinate
> > > -     linked at HT. Choose Y for Loongson-3 based machines.
> > > -
> > >  config PCI_DOMAINS
> > >     bool
> > >
> > > diff --git a/arch/mips/loongson64/Kconfig b/arch/mips/loongson64/Kconfig
> > > index c865b4b9b775..781a5156ab21 100644
> > > --- a/arch/mips/loongson64/Kconfig
> > > +++ b/arch/mips/loongson64/Kconfig
> > > @@ -76,7 +76,7 @@ config LOONGSON_MACH3X
> > >     select CPU_HAS_WB
> > >     select HW_HAS_PCI
> > >     select ISA
> > > -   select HT_PCI
> > > +   select PCI
> > >     select I8259
> > >     select IRQ_MIPS_CPU
> > >     select NR_CPUS_DEFAULT_4
> >
> > Should this also select PCI_DOMAINS to preserve the existing behavior?
> >
> > If not, could you explain why in the commit message?
>
> Ah, I see - PCI already selects PCI_DOMAINS. I think it would have been
> worth mentioning

OK, I added "PCI already selects PCI_DOMAINS"
in the commit description.



> but I don't mind if you don't think it a big enough
> deal to respin the patch, so:
>
>     Acked-by: Paul Burton <paul.burton@mips.com>
>
> Thanks,
>     Paul



-- 
Best Regards
Masahiro Yamada
