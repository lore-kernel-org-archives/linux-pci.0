Return-Path: <SRS0=/yaj=M3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B2CC28CF8
	for <linux-pci@archiver.kernel.org>; Mon, 15 Oct 2018 06:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89D8A2087D
	for <linux-pci@archiver.kernel.org>; Mon, 15 Oct 2018 06:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="zdZrATFA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89D8A2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbeJOO1h (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Oct 2018 10:27:37 -0400
Received: from condef-09.nifty.com ([202.248.20.74]:40256 "EHLO
        condef-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbeJOO1g (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Oct 2018 10:27:36 -0400
Received: from conssluserg-05.nifty.com ([10.126.8.84])by condef-09.nifty.com with ESMTP id w9F6aRx1029886;
        Mon, 15 Oct 2018 15:36:27 +0900
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id w9F6aIMV032480;
        Mon, 15 Oct 2018 15:36:18 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w9F6aIMV032480
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1539585379;
        bh=WTSQTIo6lZvTTDeUHanOaS24TqjvzaMlov8TsHwIzBs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=zdZrATFANN/2Gsg0uxCwo3kTQxSkK2pKeslTA5wMSYlICoH3n2wlsZ+UnSPSf0b24
         1K279Ng4QtuVZpRY+yuDhZPkbZorJlkQ+NJKyenJaSqIGLTrzjsf8/D1u1f8PvZyuF
         2fcbqRfkc412xgfuJ1V2EwRQ0A13KcmkYSyh8xYCSdXDTMLUPBMk0D+8WImrLSFZG6
         kJ2BXPXEJCEne20dotXU+EzcpSjTdWCQG6PJfzcb4hmC5mWKHw7PaV5bhnP/Xuob8p
         3ibWeEmBhncPvwlCJdKXwrIhteucwJzqtoFFZS2Qe95aU84syH/vhCgxJmJEtkqXY7
         /cxhZnYStcvfg==
X-Nifty-SrcIP: [209.85.217.51]
Received: by mail-vs1-f51.google.com with SMTP id c10so15628037vsk.2;
        Sun, 14 Oct 2018 23:36:18 -0700 (PDT)
X-Gm-Message-State: ABuFfoi+QcxjAERBO8dJ/Mi0b/HVT6wkKZGSNnboSh0KF2ZtSQOdvKCC
        S7HJQV1d5g00XoW3OVBNJJUWFUaf/eDPPsTYcMk=
X-Google-Smtp-Source: ACcGV61bTrA4Ownqel0P+8B+UG8xFSuByfdf/oRyq6iCpmZPeHKuZIcjxmqqkrLsL+9ptlTNIYcxYD0BF+5qpcMN5yc=
X-Received: by 2002:a67:3793:: with SMTP id j19mr6061000vsi.215.1539585377442;
 Sun, 14 Oct 2018 23:36:17 -0700 (PDT)
MIME-Version: 1.0
References: <20181013151016.31674-1-hch@lst.de> <20181013151016.31674-3-hch@lst.de>
In-Reply-To: <20181013151016.31674-3-hch@lst.de>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 15 Oct 2018 15:35:41 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQxZcBNadLJhfrmxJGj-XJFVaya3Z1eexZp20vRPwrN7A@mail.gmail.com>
Message-ID: <CAK7LNAQxZcBNadLJhfrmxJGj-XJFVaya3Z1eexZp20vRPwrN7A@mail.gmail.com>
Subject: Re: [PATCH 2/8] powerpc: simplify CONFIG_PCI_QSPAN Kconfig magic
To:     Christoph Hellwig <hch@lst.de>
Cc:     mporter@kernel.crashing.org, alex.bou9@gmail.com,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-pci@vger.kernel.org, linux-scsi <linux-scsi@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Oct 14, 2018 at 12:11 AM Christoph Hellwig <hch@lst.de> wrote:
>
> The way how CONFIG_PCI_QSPAN selects the CONFIG_PCI default is highly
> unusual and gets in the way of moving CONFIG_PCI into
> drivers/pci/Kconfig.  Simplify it by just having it depend on
> CONFIG_PCI.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/powerpc/Kconfig | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index a80669209155..6fa6f92edb7f 100644
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
> @@ -971,7 +970,7 @@ config PCI_SYSCALL
>
>  config PCI_QSPAN
>         bool "QSpan PCI"
> -       depends on PPC_8xx
> +       depends on PPC_8xx && PCI
>         select PPC_I8259
>         help
>           Say Y here if you have a system based on a Motorola 8xx-series
> --
> 2.19.1
>



'git grep' did not get any other hit.

masahiro@pug:~/ref/linux$ git grep PCI_QSPAN
arch/powerpc/Kconfig:   default PCI_QSPAN if PPC_8xx
arch/powerpc/Kconfig:config PCI_QSPAN

With your patch, PCI_QSPAN will become
a dead config option.

How about removing it entirely?



--
Best Regards
Masahiro Yamada
