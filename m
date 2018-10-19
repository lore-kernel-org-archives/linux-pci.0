Return-Path: <SRS0=b7f5=M7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60608ECDE3D
	for <linux-pci@archiver.kernel.org>; Fri, 19 Oct 2018 04:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E203D21476
	for <linux-pci@archiver.kernel.org>; Fri, 19 Oct 2018 04:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="VXRplUIK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E203D21476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbeJSMvx (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 19 Oct 2018 08:51:53 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:54322 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbeJSMvw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Oct 2018 08:51:52 -0400
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id w9J4lRr6029379;
        Fri, 19 Oct 2018 13:47:27 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w9J4lRr6029379
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1539924448;
        bh=pK2P6jmLONh9Q8yuFfp8pJzDg/VUeqpoMwtgB6qewdU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VXRplUIK4zb19KBicxRtcRRptdwGB88HNVJs7XAfXOS+mE5eub90QsnIu4jGqcSeI
         RO9XdT02maCQ4q1uEbkzB2weLY1NKYLedai3GTyYCSHDkZptXzir5sbcnB1JawQrA1
         I2OVevpgcU4pk576e/a7aYP5NXc7B/9aWSHdHgoFPRQwLib8xniJIKH978gJS79ZMs
         o8gQOaI4CxNcSgAnrnJ1HVvSUqe0bNb4Cac78S0tO9q6Y2KWDfRUPa9HQAuwX1soqn
         FCNQSC4014J/UWpYchXd3GbAffyQGatGLXYOam8qpO8VqmPbOZ2rvbT+Ft0DmPyxYf
         3lZDAgHofK8Qg==
X-Nifty-SrcIP: [209.85.222.51]
Received: by mail-ua1-f51.google.com with SMTP id c89so7001444uac.10;
        Thu, 18 Oct 2018 21:47:27 -0700 (PDT)
X-Gm-Message-State: ABuFfojwwrSbPKz/tb07SAyX3yc2yI5ElqNgVr7+D0uSazl/hqAZRAJO
        OA5yXQQi9w7VrrSjhm0J+rrc55FPVYkrFrpf6F0=
X-Google-Smtp-Source: ACcGV63egybwc1VmwifyaWlL2Zohv2AYGtaS9ZfusuGtk4VPWN4ujFUTPB8/gWTYJ0GCetxJ8P+DKV/+RIQmG6bohGY=
X-Received: by 2002:ab0:4e8b:: with SMTP id l11mr15202740uah.93.1539924446735;
 Thu, 18 Oct 2018 21:47:26 -0700 (PDT)
MIME-Version: 1.0
References: <20181017080201.10866-1-hch@lst.de> <20181017080201.10866-8-hch@lst.de>
In-Reply-To: <20181017080201.10866-8-hch@lst.de>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 19 Oct 2018 13:46:50 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT0pzpMZC+X5KiofPCUH89hr716WCKQkNYronQa3byT9w@mail.gmail.com>
Message-ID: <CAK7LNAT0pzpMZC+X5KiofPCUH89hr716WCKQkNYronQa3byT9w@mail.gmail.com>
Subject: Re: [PATCH 7/8] eisa: consolidate EISA Kconfig entry in drivers/eisa
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

On Wed, Oct 17, 2018 at 5:03 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Let architectures opt into EISA support by selecting HAS_EISA and
> handle everything else in drivers/eisa.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Thomas Gleixner <tglx@linutronix.de>
> ---


> index 60e37b9a715d..c90a1a4d6079 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -59,6 +59,7 @@ config ARM
>         select HAVE_ARCH_TRACEHOOK
>         select HAVE_ARM_SMCCC if CPU_V7
>         select HAVE_EBPF_JIT if !CPU_ENDIAN_BE32
> +       select HAVE_EISA

I doubt this.

arch/arm/Kconfig previously did not include
driver/eisa/Kconfig.

No ARM platform enabled CONFIG_EISA either.


>         select HAVE_CONTEXT_TRACKING
>         select HAVE_C_RECORDMCOUNT
>         select HAVE_DEBUG_KMEMLEAK
> @@ -162,21 +163,6 @@ config HAVE_PROC_CPU
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


-- 
Best Regards
Masahiro Yamada
