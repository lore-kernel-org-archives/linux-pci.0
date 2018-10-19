Return-Path: <SRS0=b7f5=M7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD37ECDE3D
	for <linux-pci@archiver.kernel.org>; Fri, 19 Oct 2018 12:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5476520644
	for <linux-pci@archiver.kernel.org>; Fri, 19 Oct 2018 12:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="rI/Nr7pP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5476520644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbeJSVF2 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 19 Oct 2018 17:05:28 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:50746 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727199AbeJSVF2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Oct 2018 17:05:28 -0400
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id w9JCxNoa008056;
        Fri, 19 Oct 2018 21:59:23 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w9JCxNoa008056
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1539953964;
        bh=TzNt9vFzOmeru9+0ICk7t+QXt1OoO7XrIfBO4dZLhZA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rI/Nr7pP7Ia7xtwh+JypN6pe08zYyemauTat478xqXU9YnkP0t6mftcWukmsYyLrk
         QUtjhRMRF6nXV/9sUVJEk/ANyrwh4EGcSvWyKfDIzcU1vHEGitDqpt4Tk7mhZw9qaf
         ASY4jOo8JDRJfUf1llqtlXTjYfZNiyBcKuKpCRrlEdpGtiUauq1D96s76Ox3rlOAEN
         gCufX9cbf0/lcAUMr6ZAuJ2gZ6ZH+8tyw4pAm0wuMxLJ0i0SpHLOMs5GPCPPMDaJ91
         3l8zsH6pHzawJZXL3T8c5tepvW68/Q8dXyXIPFyvwX32c73OXIgrMsH5X2Q9l50Q/q
         X2z0QjZidKkfg==
X-Nifty-SrcIP: [209.85.221.172]
Received: by mail-vk1-f172.google.com with SMTP id o196so6951724vka.12;
        Fri, 19 Oct 2018 05:59:23 -0700 (PDT)
X-Gm-Message-State: ABuFfojwA94A7WplDyMkiXmLO1/3r8nFPoBEH8uE9amV0QeosCQfZDRC
        I3vGKgGHncxE8PHbyAEEpy8l2Xd2itwlX8fLRAQ=
X-Google-Smtp-Source: ACcGV62BIuydGNY+mLEeiEF2HWEKzurX1J12Va0O1ytVraXQTMcjAw4Oe1mR8XsTknT0Do4e63p51yoUpggMgMjGtdM=
X-Received: by 2002:a1f:a014:: with SMTP id j20mr7965499vke.64.1539953962704;
 Fri, 19 Oct 2018 05:59:22 -0700 (PDT)
MIME-Version: 1.0
References: <20181019120952.32763-1-hch@lst.de> <20181019120952.32763-7-hch@lst.de>
 <20181019122228.GJ30658@n2100.armlinux.org.uk>
In-Reply-To: <20181019122228.GJ30658@n2100.armlinux.org.uk>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 19 Oct 2018 21:58:46 +0900
X-Gmail-Original-Message-ID: <CAK7LNATZ8LagrTrTae_QCQbSuTW7_y6sDrdTHfTyONPrsYDs4A@mail.gmail.com>
Message-ID: <CAK7LNATZ8LagrTrTae_QCQbSuTW7_y6sDrdTHfTyONPrsYDs4A@mail.gmail.com>
Subject: Re: [PATCH 6/9] PCI: consolidate PCI config entry in drivers/pci
To:     Russell King <linux@armlinux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Alex Bounine <alex.bou9@gmail.com>,
        mporter@kernel.crashing.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 19, 2018 at 9:23 PM Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:

> > index a68b34183107..b185794549be 100644
> > --- a/arch/arm/mach-pxa/Kconfig
> > +++ b/arch/arm/mach-pxa/Kconfig
> > @@ -125,7 +125,7 @@ config MACH_ARMCORE
> >       bool "CompuLab CM-X255/CM-X270 modules"
> >       select ARCH_HAS_DMA_SET_COHERENT_MASK if PCI
> >       select IWMMXT
> > -     select MIGHT_HAVE_PCI
> > +     select HAVE_PCI
> >       select NEED_MACH_IO_H if PCI
> >       select PXA25x
> >       select PXA27x
>
> This is wrong.  "MIGHT_HAVE_PCI" is _not_ the same as "HAVE_PCI" - we
> have a bunch of platforms that mandatorily have PCI and these select
> PCI directly.  "MIGHT_HAVE_PCI" controls the _visibility_ of the PCI
> menu option, but does not prevent it being selected.  Your patch will
> cause Kconfig to complain for those which mandatorily have PCI but
> do not set HAVE_PCI.


Good catch!
But, adding a bunch of 'select HAVE_PCI' along with 'select PCI' is ugly.

Do you have any suggestion?

How about letting CONFIG_ARM to select HAVE_PCI ?

-- 
Best Regards
Masahiro Yamada
