Return-Path: <SRS0=/yaj=M3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A3F0C28CF8
	for <linux-pci@archiver.kernel.org>; Mon, 15 Oct 2018 06:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40B282086A
	for <linux-pci@archiver.kernel.org>; Mon, 15 Oct 2018 06:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="0+qzGY6h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40B282086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbeJOO14 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Oct 2018 10:27:56 -0400
Received: from condef-09.nifty.com ([202.248.20.74]:40570 "EHLO
        condef-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbeJOO1z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Oct 2018 10:27:55 -0400
Received: from conssluserg-03.nifty.com ([10.126.8.82])by condef-09.nifty.com with ESMTP id w9F6cL7A030075;
        Mon, 15 Oct 2018 15:38:21 +0900
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id w9F6cE7D007531;
        Mon, 15 Oct 2018 15:38:14 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w9F6cE7D007531
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1539585495;
        bh=431UDDCt5Nrpvp4Xvgv5e4O/hkJL6PkGKYJoLHYjNgM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0+qzGY6hIxx91W4W0wzeYuIEW+1c2nDa8JZmFIAqdY8IlGhLJrPoE8EHdm/4LVZ+w
         ra7AhsQZw+n+wtOD6yodA1m0jxqcG3g28whGFs4Gdjg42T6fsmMmQWMbt0Lc7RuIQ3
         eqr6RrmOPPtZH8HSG8SYKMyv/GgP3kaRVlFE+tzCzBomefXLrpU4YeGGn/5ku5qnes
         J5s3OPh6imZkNHFJaXabpQ6CYA1JCooA8MNzeX6+vCLTz5pHjZyQfWgw2PqH6sjYRV
         Itn6ZydzKKUk8vJ5rdn6TBR9VvxlL058hLSJz7iAIA/GvjIczo4Ck4aLbk2nvAQbni
         l/fBybDbp8nvw==
X-Nifty-SrcIP: [209.85.222.48]
Received: by mail-ua1-f48.google.com with SMTP id f12so1619485uan.6;
        Sun, 14 Oct 2018 23:38:14 -0700 (PDT)
X-Gm-Message-State: ABuFfojhWkVLPumnNYQVL9bds9Qlc2z7JdPJGLKeP9PwR9muxIsT2XgA
        mVVPbgmP0DThis/iG7KghY4UPt2Dg9Xfv5hF1LE=
X-Google-Smtp-Source: ACcGV62svXsdBtzLs8uABQOtUzKDz7B4f1pAyar1hAZNMZHRjuPAGdZVj6HDpBWKhMCVhlq/+I/DSudKoxaUcLIw44Y=
X-Received: by 2002:ab0:115b:: with SMTP id g27mr6860514uac.89.1539585493703;
 Sun, 14 Oct 2018 23:38:13 -0700 (PDT)
MIME-Version: 1.0
References: <20181013151016.31674-1-hch@lst.de> <20181013151016.31674-8-hch@lst.de>
In-Reply-To: <20181013151016.31674-8-hch@lst.de>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 15 Oct 2018 15:37:37 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT8QhVhSiv1bNnp_HbFdLGd_y-YUQqSevZ5eSp4=ZRqhQ@mail.gmail.com>
Message-ID: <CAK7LNAT8QhVhSiv1bNnp_HbFdLGd_y-YUQqSevZ5eSp4=ZRqhQ@mail.gmail.com>
Subject: Re: [PATCH 7/8] eisa: consolidate EISA Kconfig entry in drivers/eisa
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
> Let architectures opt into EISA support by selecting HAS_EISA and
> handle everything else in drivers/eisa.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---


How about HAVE_EISA ?


You forgot to add
source "drivers/eisa/Kconfig" to drivers/Kconfig


You forgot to delete the one
from arch/alpha/Kconfig


>  arch/alpha/Kconfig     |  8 +++-----
>  arch/arm/Kconfig       | 16 +---------------
>  arch/mips/Kconfig      | 31 +++++--------------------------
>  arch/powerpc/Kconfig   |  3 ---
>  arch/x86/Kconfig       | 19 +------------------
>  drivers/eisa/Kconfig   | 21 ++++++++++++++++++++-
>  drivers/parisc/Kconfig | 11 +----------
>  7 files changed, 31 insertions(+), 78 deletions(-)
>
> diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
> index 73a7558c71bd..6a9be9cb74e6 100644
> --- a/arch/alpha/Kconfig
> +++ b/arch/alpha/Kconfig
> @@ -6,6 +6,9 @@ config ALPHA
>         select ARCH_MIGHT_HAVE_PC_SERIO
>         select ARCH_NO_PREEMPT
>         select ARCH_USE_CMPXCHG_LOCKREF
> +       select HAS_EISA if ALPHA_GENERIC || ALPHA_JENSEN || ALPHA_ALCOR || \
> +                               ALPHA_MIKASA || ALPHA_SABLE || ALPHA_LYNX || \
> +                               ALPHA_NORITAKE || ALPHA_RAWHIDE
>         select HAS_PCI if !ALPHA_JENSEN
>         select PCI if !ALPHA_JENSEN
>         select HAVE_AOUT
> @@ -518,11 +521,6 @@ config ALPHA_SRM
>
>           If unsure, say N.
>
> -config EISA
> -       bool
> -       depends on ALPHA_GENERIC || ALPHA_JENSEN || ALPHA_ALCOR || ALPHA_MIKASA || ALPHA_SABLE || ALPHA_LYNX || ALPHA_NORITAKE || ALPHA_RAWHIDE
> -       default y
> -


Better to add CONFIG_EISA=y to arch/alpha/defconfig
to not flip the default?



--
Best Regards
Masahiro Yamada
