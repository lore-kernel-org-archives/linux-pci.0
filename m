Return-Path: <SRS0=PFnE=OC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B050C43441
	for <linux-pci@archiver.kernel.org>; Fri, 23 Nov 2018 02:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62BB020824
	for <linux-pci@archiver.kernel.org>; Fri, 23 Nov 2018 02:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Xt7kCeKg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62BB020824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405119AbeKWNY1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 23 Nov 2018 08:24:27 -0500
Received: from conssluserg-06.nifty.com ([210.131.2.91]:45660 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727343AbeKWNY1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Nov 2018 08:24:27 -0500
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id wAN2fuXt031803;
        Fri, 23 Nov 2018 11:41:56 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com wAN2fuXt031803
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1542940917;
        bh=R157I6Dkx5Z2mskSmJELm97OIhgSrKrMbLwBuT6BgNs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Xt7kCeKg4GGBt+J3Snq2vwZlT+w8OiyFUD7LWOLXE5pvAZr8vzbRl4gtGpxjZCgvi
         jiI/tA6CFqnVBKV1A6ulng70p2WogPviu97lII0SBGEgEg7FDkVyWTQg3xtV41cvNy
         irGsOah7EPQzmlJgDxvwFEWAcyj43ZT1HYhwCO1euFFysGiGDsk9YBCokok4CAVjma
         ycb6MK+CPmqHkkD3Kio2yXGaHmbvv3Khf4KNlWwTVZzIgxtNOKNqTjsb0HZ13QjSTH
         V6sMtEtCbpCtQpon8IUwPymVv5ZHSRqjuuwFy83PmULgph7fKMvSmzssp7rtmewnSW
         s0c1V/zGJqR7Q==
X-Nifty-SrcIP: [209.85.222.52]
Received: by mail-ua1-f52.google.com with SMTP id j3so3675037uap.3;
        Thu, 22 Nov 2018 18:41:56 -0800 (PST)
X-Gm-Message-State: AA+aEWZGX2Db8gx5SEpZTS2g9ziZHaabhlGtiw/IW2xYlEWgGsHZQx2O
        UutQ9DaLJK+XmbMr5aWGBX4fG6tKHYLaNs2A/xo=
X-Google-Smtp-Source: AFSGD/U0y52k6OkO8mAFNr3ssfm0dIj5t/ic8hflM6hOWd/Ort5n5jrqwIFsps2z1+GeSvz9QtDEt9YhLpwhox0mNvE=
X-Received: by 2002:a9f:3f41:: with SMTP id i1mr5501205uaj.42.1542940915649;
 Thu, 22 Nov 2018 18:41:55 -0800 (PST)
MIME-Version: 1.0
References: <20181115190538.17016-1-hch@lst.de> <20181115190538.17016-6-hch@lst.de>
In-Reply-To: <20181115190538.17016-6-hch@lst.de>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 23 Nov 2018 11:41:19 +0900
X-Gmail-Original-Message-ID: <CAK7LNASYobpeAMqenZXycNieWErRFkNHz6xQUzEruJ0-nNwfdA@mail.gmail.com>
Message-ID: <CAK7LNASYobpeAMqenZXycNieWErRFkNHz6xQUzEruJ0-nNwfdA@mail.gmail.com>
Subject: Re: [PATCH 5/9] PCI: consolidate the PCI_DOMAINS and
 PCI_DOMAINS_GENERIC config options
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

On Fri, Nov 16, 2018 at 4:07 AM Christoph Hellwig <hch@lst.de> wrote:

> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index a8128a1946a2..95812fc4958c 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -21,6 +21,15 @@ menuconfig PCI
>           support for PCI-X and the foundations for PCI Express support.
>           Say 'Y' here unless you know what you are doing.
>
> +config PCI_DOMAINS
> +       depends on PCI
> +       bool
> +
> +config PCI_DOMAINS_GENERIC
> +       depends on PCI
> +       select PCI_DOMAINS
> +       bool
> +
>  source "drivers/pci/pcie/Kconfig"
>
>  config PCI_MSI


I reordered this so it 'bool' comes first.

config PCI_DOMAINS
       bool
       depends on PCI


config PCI_DOMAINS_GENERIC
       bool
       depends on PCI
       select PCI_DOMAINS


Of course, it is just a matter of slight taste.
I just wanted the code to look consistent.




-- 
Best Regards
Masahiro Yamada
