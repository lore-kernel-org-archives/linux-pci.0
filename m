Return-Path: <SRS0=PFnE=OC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E1BC43441
	for <linux-pci@archiver.kernel.org>; Fri, 23 Nov 2018 02:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99CC1206B2
	for <linux-pci@archiver.kernel.org>; Fri, 23 Nov 2018 02:35:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="aAwRi9iX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99CC1206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392976AbeKWNR5 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 23 Nov 2018 08:17:57 -0500
Received: from conssluserg-06.nifty.com ([210.131.2.91]:37035 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727343AbeKWNR5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Nov 2018 08:17:57 -0500
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id wAN2ZBE4027902;
        Fri, 23 Nov 2018 11:35:11 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com wAN2ZBE4027902
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1542940512;
        bh=RrugNZBXEysMhtL3UZ+37m+8Wd+NK/UsR7hC/dwXJf0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aAwRi9iXfhqyD0Xo2QewRjbyKQkUY/xfCM4Jsy2mz7hl5WbmwaYvpwM6x6gyztC8H
         Io/oWeo88sDyfJ+U9ePSmPWYTLxLmt1ivAZCLy1rT8Kr9C2huheoPPz804EhAw6NGx
         BWdGF93YVQG1iGg78tBSUt0D+ZZpm4Sw9gn3VKJpufGqNnEIpaQPyLNBzbV/EixRUa
         yan/cN0vJgNe6bAlDtMy4uFA/ztD2H1KGCeU6J+D/fdLQABRI8sLimhTR5bipkfAMF
         aKqb04VJWH/35JjXutou7ekKeq5fFROIx1RyTuTh6FJYJiOOax/lg31C8Zk+cUAgLR
         MszXcN/VvKXNA==
X-Nifty-SrcIP: [209.85.217.54]
Received: by mail-vs1-f54.google.com with SMTP id v10so6354034vsv.12;
        Thu, 22 Nov 2018 18:35:11 -0800 (PST)
X-Gm-Message-State: AGRZ1gLvtVqi/9IpsN3Nbm+iyx+umE1qDHCRnDmaW1jYnOXwfBdLU0XP
        lho5LZJtS+Aeo1/YTElfENB+ySQlwL88Ku788mM=
X-Google-Smtp-Source: AJdET5cIw+vbbs97NyNbwhbBUn15tsgvQyNHCrBWj31uLObQRxlkco6LuTOOVkaJBTEBijL6YB6Yzgf83zElAgHI88Q=
X-Received: by 2002:a67:385a:: with SMTP id f87mr5827099vsa.179.1542940510387;
 Thu, 22 Nov 2018 18:35:10 -0800 (PST)
MIME-Version: 1.0
References: <20181115190538.17016-1-hch@lst.de> <20181115190538.17016-10-hch@lst.de>
In-Reply-To: <20181115190538.17016-10-hch@lst.de>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 23 Nov 2018 11:34:34 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ01oHpZHJ2Zb49o7pUU_vB5+-262MhueTLQg+t29W3nw@mail.gmail.com>
Message-ID: <CAK7LNAQ01oHpZHJ2Zb49o7pUU_vB5+-262MhueTLQg+t29W3nw@mail.gmail.com>
Subject: Re: [PATCH 9/9] eisa: consolidate EISA Kconfig entry in drivers/eisa
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
> Let architectures opt into EISA support by selecting HAS_EISA and

I locally fixed the commit log (HAS_EISA -> HAVE_EISA)
so that it matches to the code.

Thanks.



> handle everything else in drivers/eisa.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Thomas Gleixner <tglx@linutronix.de>
> ---

--
Best Regards
Masahiro Yamada
