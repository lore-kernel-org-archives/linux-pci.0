Return-Path: <SRS0=lbet=NL=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 773D1C0044C
	for <linux-pci@archiver.kernel.org>; Wed, 31 Oct 2018 15:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2813520664
	for <linux-pci@archiver.kernel.org>; Wed, 31 Oct 2018 15:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="O/k2mZY4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2813520664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbeKAA0q (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 31 Oct 2018 20:26:46 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:32965 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727638AbeKAA0p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 Oct 2018 20:26:45 -0400
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id w9VFS7Ex029562;
        Thu, 1 Nov 2018 00:28:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w9VFS7Ex029562
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1540999688;
        bh=6/0JrO5Fsi7fcZEs3g6nojQbiitMFQ8VGesiOyT1KNE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=O/k2mZY484Z5v22jO5eHcNKYZgJcRAbXaOTJqm48DZz/DGAMOdfJ9jewOJsDJFmqK
         EaR8Q51Naq1mxyyh7R4q/SCW8C2Y6GzYGwfn9zjhstAuQql+4F3Kpd+9HCGTba/UN1
         gbo2LbgiF9ttTLmDKYVJNyQyULe8ZtyEAagXRHreLjQtynZKgOPf8H+Q9A00yfzcV0
         38FyP+4eNAH22S5nT9JQrfwOf+wvF9BWlL/Htk54NTHr/t2SI8lUEbSkm41xyL1Mv6
         eDxHc0cSEZkWF+KzVZy3Q7c0PufZA8S9KR74XkEUFlvdAx/8L/Lo2Z4fWH8G+gS0H2
         adXJB1lz9JI0A==
X-Nifty-SrcIP: [209.85.217.47]
Received: by mail-vs1-f47.google.com with SMTP id e126so10241686vsc.9;
        Wed, 31 Oct 2018 08:28:08 -0700 (PDT)
X-Gm-Message-State: AGRZ1gJ0AKdYb4/ezCClIYo+McivMDj7X9V09QH/i9PyYH23CSsK2zRt
        gYG8fyMxY1zygM2pnaLe7McY8EF+wEBOtYeBOIE=
X-Google-Smtp-Source: AJdET5eLO5x7laBy+4Wwo3163CPWmgrOSV8/YNW9hS+mzsS8i41q/U+PHCF2htix5TYv7HMghOtrm80EBg4e/8Bdn0c=
X-Received: by 2002:a67:6101:: with SMTP id v1mr1536207vsb.54.1540999687154;
 Wed, 31 Oct 2018 08:28:07 -0700 (PDT)
MIME-Version: 1.0
References: <20181019120952.32763-1-hch@lst.de> <20181019120952.32763-4-hch@lst.de>
In-Reply-To: <20181019120952.32763-4-hch@lst.de>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 1 Nov 2018 00:27:30 +0900
X-Gmail-Original-Message-ID: <CAK7LNATPnn=8B2jisxfwOg5KWr1YSkBJEtiquzK9GQ8s-D2Q9g@mail.gmail.com>
Message-ID: <CAK7LNATPnn=8B2jisxfwOg5KWr1YSkBJEtiquzK9GQ8s-D2Q9g@mail.gmail.com>
Subject: Re: [PATCH 3/9] powerpc: remove CONFIG_PCI_QSPAN
To:     Christoph Hellwig <hch@lst.de>
Cc:     mporter@kernel.crashing.org, Alex Bounine <alex.bou9@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-pci@vger.kernel.org, linux-scsi <linux-scsi@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 19, 2018 at 9:10 PM Christoph Hellwig <hch@lst.de> wrote:
>
> This option isn't actually used anywhere.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---


Applied to linux-kbuild.




>  arch/powerpc/Kconfig | 9 ---------
>  1 file changed, 9 deletions(-)
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index a80669209155..e8c8970248bc 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -955,7 +955,6 @@ config PCI
>         bool "PCI support" if PPC_PCI_CHOICE
>         default y if !40x && !CPM2 && !PPC_8xx && !PPC_83xx \
>                 && !PPC_85xx && !PPC_86xx && !GAMECUBE_COMMON
> -       default PCI_QSPAN if PPC_8xx
>         select GENERIC_PCI_IOMAP
>         help
>           Find out whether your system includes a PCI bus. PCI is the name of
> @@ -969,14 +968,6 @@ config PCI_DOMAINS
>  config PCI_SYSCALL
>         def_bool PCI
>
> -config PCI_QSPAN
> -       bool "QSpan PCI"
> -       depends on PPC_8xx
> -       select PPC_I8259
> -       help
> -         Say Y here if you have a system based on a Motorola 8xx-series
> -         embedded processor with a QSPAN PCI interface, otherwise say N.
> -
>  config PCI_8260
>         bool
>         depends on PCI && 8260
> --
> 2.19.1
>


-- 
Best Regards
Masahiro Yamada
