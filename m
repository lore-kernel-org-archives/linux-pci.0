Return-Path: <SRS0=JYfi=M4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4275CC04EBF
	for <linux-pci@archiver.kernel.org>; Tue, 16 Oct 2018 05:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 061D320869
	for <linux-pci@archiver.kernel.org>; Tue, 16 Oct 2018 05:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="wKUwQx2/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 061D320869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbeJPNJv (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 16 Oct 2018 09:09:51 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:50213 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbeJPNJu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Oct 2018 09:09:50 -0400
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id w9G5L0OB026336;
        Tue, 16 Oct 2018 14:21:01 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w9G5L0OB026336
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1539667261;
        bh=FDIGmE5b5K9BmEWUF/OrPaKAb5bJ4bsEha3Y3EORDIQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wKUwQx2/7aUUkj6aNVBCk7JlQa/hx5qmnIOiipqx1nYUzBT1Ylk17jmg5SbzyJ2+X
         8hAR3pHmKBKgKpG29FYkn7uUmc3nXr+7mz6FUDyCH8Tq/yX21nIEb6j/A5MrUbMEsP
         QRnCdvBRs1yGFrc/ec9o9sFiG7yKonhZW98yEpFnrJqP2rpcsQgDpD5VEkeNTcDwBY
         Qs4JHmK/+tGqaYwY2h5Bj1LC5hLfOJc5DQReLucQ2fqHOP7PwrOrRjrwZz7qQpTXJJ
         LlxDPKotTjsKfWFfpAFgkaUxizlRPXTp/ncLEAhELy3uSe9xDigURJSAkB83RXNETi
         XQ15TCc8gVlwg==
X-Nifty-SrcIP: [209.85.222.52]
Received: by mail-ua1-f52.google.com with SMTP id o17so133699uad.8;
        Mon, 15 Oct 2018 22:21:00 -0700 (PDT)
X-Gm-Message-State: ABuFfoj+xBAV0AhnY549DScCoUoJbT4WWF2sZFyblnIUwBjbdBOX2Fi0
        lazQQ46SdXwjPP6IDlwwk2ASye+dgCNA3rKM6sk=
X-Google-Smtp-Source: ACcGV61ZnDsm1Nha0a5yHh0vPG6Piw2+qTgZ1yt8n6hzXeBJoavGmeMzDMu+IRdRHaaAVTWbfsMClBFk4YUYrnVrW8o=
X-Received: by 2002:ab0:7093:: with SMTP id m19mr8698603ual.55.1539667259783;
 Mon, 15 Oct 2018 22:20:59 -0700 (PDT)
MIME-Version: 1.0
References: <20181013151016.31674-1-hch@lst.de> <20181013151016.31674-9-hch@lst.de>
In-Reply-To: <20181013151016.31674-9-hch@lst.de>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 16 Oct 2018 14:20:23 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQwyWUq_ohVMe9QLLbyHHQdjkrkM9DPd3pgYLz8UhG6rA@mail.gmail.com>
Message-ID: <CAK7LNAQwyWUq_ohVMe9QLLbyHHQdjkrkM9DPd3pgYLz8UhG6rA@mail.gmail.com>
Subject: Re: [PATCH 8/8] kconfig: remove CONFIG_MCA leftovers
To:     Christoph Hellwig <hch@lst.de>
Cc:     mporter@kernel.crashing.org, Alex Bounine <alex.bou9@gmail.com>,
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
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---


Can you use "powerpc:" or something
for the subject line?

I'd like to see "kconfig:" only for patches
that touch the scripts/kconfig/ directory.




>  arch/powerpc/Kconfig | 4 ----
>  drivers/scsi/Kconfig | 6 +++---
>  2 files changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index f0ea460653cd..8b9edf7caf96 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -944,10 +944,6 @@ config FSL_GTM
>         help
>           Freescale General-purpose Timers support
>
> -# Yes MCA RS/6000s exist but Linux-PPC does not currently support any
> -config MCA
> -       bool
> -
>  config PCI_DOMAINS
>         def_bool PCI
>
> diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
> index 7c097006c54d..d3734c54aec9 100644
> --- a/drivers/scsi/Kconfig
> +++ b/drivers/scsi/Kconfig
> @@ -535,7 +535,7 @@ config SCSI_HPTIOP
>
>  config SCSI_BUSLOGIC
>         tristate "BusLogic SCSI support"
> -       depends on (PCI || ISA || MCA) && SCSI && ISA_DMA_API && VIRT_TO_BUS
> +       depends on (PCI || ISA) && SCSI && ISA_DMA_API && VIRT_TO_BUS
>         ---help---
>           This is support for BusLogic MultiMaster and FlashPoint SCSI Host
>           Adapters. Consult the SCSI-HOWTO, available from
> @@ -1142,12 +1142,12 @@ config SCSI_LPFC_DEBUG_FS
>
>  config SCSI_SIM710
>         tristate "Simple 53c710 SCSI support (Compaq, NCR machines)"
> -       depends on (EISA || MCA) && SCSI
> +       depends on EISA && SCSI
>         select SCSI_SPI_ATTRS
>         ---help---
>           This driver is for NCR53c710 based SCSI host adapters.
>
> -         It currently supports Compaq EISA cards and NCR MCA cards
> +         It currently supports Compaq EISA cards.
>
>  config SCSI_DC395x
>         tristate "Tekram DC395(U/UW/F) and DC315(U) SCSI support"
> --
> 2.19.1
>


-- 
Best Regards
Masahiro Yamada
