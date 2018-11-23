Return-Path: <SRS0=PFnE=OC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E0CC43441
	for <linux-pci@archiver.kernel.org>; Fri, 23 Nov 2018 02:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2EDC20820
	for <linux-pci@archiver.kernel.org>; Fri, 23 Nov 2018 02:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Boj2kU3b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2EDC20820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439519AbeKWNV5 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 23 Nov 2018 08:21:57 -0500
Received: from conssluserg-01.nifty.com ([210.131.2.80]:54957 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727343AbeKWNV5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Nov 2018 08:21:57 -0500
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id wAN2dWte018207;
        Fri, 23 Nov 2018 11:39:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com wAN2dWte018207
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1542940773;
        bh=VWjvovRoFgpdnSblsfRHe1lJMd1lOaF4s9MvxqgDVX4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Boj2kU3bRwBeSub/0bUGlYOfl67jl04CxoA2N3WZb0jRBnfXMgA3O6kk5EYaRvP++
         Tax5dA+NcjLS+Zm+IWLTzzY+hNrBL17kzYu82XZPoo/pPjAhzM8x//qW263R7/fYDW
         e+wURkL2MNEL104X3+iv6xa8xDqTA+uye2PqiCbZL5SGJOrwdGzA5BjsYbIyD2L3fW
         7K8Cr2sFxkK6xxbDDK1CnhQgR1lDZaJrLwxnKjQXrVPB9Z8BH0r79AC1pUsBdq9cYx
         x2OWuk4KrQ/HRxwVu+kDig0CGgZTEXs0LQzueyAB8W5nz6CdIm4BkrG3j0JNbxwt3n
         cLtAULCoL2ThQ==
X-Nifty-SrcIP: [209.85.217.45]
Received: by mail-vs1-f45.google.com with SMTP id z3so6367021vsf.7;
        Thu, 22 Nov 2018 18:39:32 -0800 (PST)
X-Gm-Message-State: AGRZ1gI2SOs42DTdsFFx5A7PBSvTFbxo1wgajOwFl3zFtUfb7yYr8el/
        QNiW2T91bejK/npq+CjrrWZoUk7/Gix0VYJgxWo=
X-Google-Smtp-Source: AJdET5e1srPuacSBSRnMpISFk7oo2hmgsX3nPv3251fAuBn7xd1X1soEXtNFB6//3SgosqKKtXuMKOS97o9NQ43BUOQ=
X-Received: by 2002:a67:f1d6:: with SMTP id v22mr5691305vsm.181.1542940771602;
 Thu, 22 Nov 2018 18:39:31 -0800 (PST)
MIME-Version: 1.0
References: <20181115190538.17016-1-hch@lst.de> <20181115190538.17016-3-hch@lst.de>
In-Reply-To: <20181115190538.17016-3-hch@lst.de>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 23 Nov 2018 11:38:55 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQrOHhd-=BHtc1PQ4SCo=fUPaqOQsbxzv+VF8Zu4bJohA@mail.gmail.com>
Message-ID: <CAK7LNAQrOHhd-=BHtc1PQ4SCo=fUPaqOQsbxzv+VF8Zu4bJohA@mail.gmail.com>
Subject: Re: [PATCH 2/9] alpha: force PCI on for non-jensen configs
To:     Christoph Hellwig <hch@lst.de>
Cc:     mporter@kernel.crashing.org, Alex Bounine <alex.bou9@gmail.com>,
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

On Fri, Nov 16, 2018 at 4:06 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Without PCI support the kernel won't even compile, so force it on.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---


I do not understand this patch
because alpha already enables PCI forcibly.

'No prompt' + 'default y' means always on.

config PCI
        bool
        depends on !ALPHA_JENSEN
        select GENERIC_PCI_IOMAP
        default y


I squashed this patch to "PCI: consolidate PCI config entry ..."
because you will replace it to FORCE_PCI anyway.







>  arch/alpha/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
> index 5b4f88363453..65f6d0bf69d4 100644
> --- a/arch/alpha/Kconfig
> +++ b/arch/alpha/Kconfig
> @@ -6,6 +6,7 @@ config ALPHA
>         select ARCH_MIGHT_HAVE_PC_SERIO
>         select ARCH_NO_PREEMPT
>         select ARCH_USE_CMPXCHG_LOCKREF
> +       select PCI if !ALPHA_JENSEN
>         select HAVE_AOUT
>         select HAVE_IDE
>         select HAVE_OPROFILE
> --
> 2.19.1
>


--
Best Regards
Masahiro Yamada
