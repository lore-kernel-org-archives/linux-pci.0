Return-Path: <SRS0=PFnE=OC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE68C43441
	for <linux-pci@archiver.kernel.org>; Fri, 23 Nov 2018 02:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AD85206B2
	for <linux-pci@archiver.kernel.org>; Fri, 23 Nov 2018 02:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="MYhJUu0L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AD85206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439536AbeKWNVZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 23 Nov 2018 08:21:25 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:62207 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727343AbeKWNVZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Nov 2018 08:21:25 -0500
X-Greylist: delayed 335 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Nov 2018 08:21:22 EST
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id wAN2cus7032084;
        Fri, 23 Nov 2018 11:38:56 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com wAN2cus7032084
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1542940737;
        bh=RwCL9Ri+CN8GV/mcouXy7Bn2m5DMHOHs2NKrn7tRBFs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MYhJUu0L0a+CSKTHu66tCSIlEPx+cikVX1ZeeFJJJm+V/LS62+QKlo0YuU3BlAbbw
         AsWTdHqbqdveA+kVvHdFVvyOuwFaH8+owiGVG4pVsSpFbI97zO2nPbIrDm9G8w+JJA
         HQJBZ6OaYZqSTOmFr3ri2G48XmixRLG+GICPONonqugmiLwoeF6GXdpFb+zWI52b3n
         +Y/q6MvJjeUsBEWsY/sIEaEPQ+fX+mycQqY7B6OtENsc5C3eCOVeov8yPQZYqRumiY
         G/yEfSi/YD5kR1o+R1Vy4v9aP/E9epQ21KXaYMb/2lBHJJByu1kQlaB3xOQU5okA1+
         XTsn9lvMF8w/g==
X-Nifty-SrcIP: [209.85.217.42]
Received: by mail-vs1-f42.google.com with SMTP id h78so6377163vsi.6;
        Thu, 22 Nov 2018 18:38:56 -0800 (PST)
X-Gm-Message-State: AGRZ1gIUoHc7NwZzKr1LkWAtjqVALNLznVgPUJMKO8XTrjbpSZhPN6wO
        5fKXW8D+O+GNeHmH5clXWNZ9/ohYanfWGMoRK6Y=
X-Google-Smtp-Source: AJdET5f4wWYkg8NhA/njL96dQLq3mhUgERT/Zv/ehLhsyoNXgp6lt+kzLsJHDfpawOK7kvxkQQ7+Im2odf8doeLp64Y=
X-Received: by 2002:a67:a858:: with SMTP id r85mr5688337vse.215.1542940735781;
 Thu, 22 Nov 2018 18:38:55 -0800 (PST)
MIME-Version: 1.0
References: <20181115190538.17016-1-hch@lst.de> <20181115190538.17016-2-hch@lst.de>
In-Reply-To: <20181115190538.17016-2-hch@lst.de>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 23 Nov 2018 11:38:20 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT+gHJcxhb=ufzzHHcfWqNOAJXaOAp2aJP9dGYxBkqQFw@mail.gmail.com>
Message-ID: <CAK7LNAT+gHJcxhb=ufzzHHcfWqNOAJXaOAp2aJP9dGYxBkqQFw@mail.gmail.com>
Subject: Re: [PATCH 1/9] arm: remove EISA kconfig option
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
> No arm config enables EISA, and arm does not include drivers/eisa/Kconfig
> which provides support for things like PCI to EISA bridges, so it is most
> likely dead.

As I said before, this is absolutely dead.

Only the difference between arch/powerpc/Kconfig and arch/arm/Kconfig
is the presence of ---help--- property.


I squashed this to "eisa: consolidate EISA ..."


> Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/arm/Kconfig | 15 ---------------
>  1 file changed, 15 deletions(-)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 91be74d8df65..f24a7435d19a 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -163,21 +163,6 @@ config HAVE_PROC_CPU
>  config NO_IOPORT_MAP
>         bool
>
> -config EISA
> -       bool
> -       ---help---
> -         The Extended Industry Standard Architecture (EISA) bus was
> -         developed as an open alternative to the IBM MicroChannel bus.
> -
> -         The EISA bus provided some of the features of the IBM MicroChannel
> -         bus while maintaining backward compatibility with cards made for
> -         the older ISA bus.  The EISA bus saw limited use between 1988 and
> -         1995 when it was made obsolete by the PCI bus.
> -
> -         Say Y here if you are building a kernel for an EISA-based machine.
> -
> -         Otherwise, say N.
> -
>  config SBUS
>         bool
>
> --
> 2.19.1
>


--
Best Regards
Masahiro Yamada
