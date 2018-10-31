Return-Path: <SRS0=lbet=NL=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 066F5C0044C
	for <linux-pci@archiver.kernel.org>; Wed, 31 Oct 2018 16:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B05B320830
	for <linux-pci@archiver.kernel.org>; Wed, 31 Oct 2018 16:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="JqvdN7ba"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B05B320830
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbeKABEt (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 31 Oct 2018 21:04:49 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:43616 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728048AbeKABEs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 Oct 2018 21:04:48 -0400
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id w9VG63AO018968;
        Thu, 1 Nov 2018 01:06:04 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w9VG63AO018968
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1541001964;
        bh=rm4KBd9Y1DjyNm7gMyiNo8tn1N+1kLxAGdNLudCccdI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JqvdN7baYjxm3y4SffjP5dcqILVQxN1PONQylmH4GekjpfMQrGc0Gs20G1DxmPwwf
         2Ulw9WdymD1ePio94lpLlfQ1YS4kpIsF+0a4a5KtZ+7jTPhbfudfn7NsiqwCCotI9g
         1Bib5DRqKCQVrpddlKGJ6PZM/kUk3uUImVBaun4a/pyHQLn1ja3reeDiQBXUORPBIZ
         DYNxeCtBchszGB1DRll9bVzF3cxEoEmK04Xa4I9jSgsmhPLyLxBgkVbuXt7bDfQKHT
         U0mzY7fNxM2rWftsNgEhMYlolBjnLDPS2q9ZIEqNibzyyVveuQX4NBZnIWcYhvMpTR
         FQHlP5fw5dFZg==
X-Nifty-SrcIP: [209.85.222.49]
Received: by mail-ua1-f49.google.com with SMTP id c5so4460886uak.4;
        Wed, 31 Oct 2018 09:06:04 -0700 (PDT)
X-Gm-Message-State: AGRZ1gLpP87rj7DH89BBn0AR/vNNVOMIj1RN2wbr/m8/L4SMBinv4kyg
        etAxGBPaJ3YuBP8Ljo6HW8XMecA+ovNs2arbGww=
X-Google-Smtp-Source: AJdET5cPwAWbY9PNn2LZNg5TFvXRL1rtx5qnkG8+zSU8HbppT4T4TbtM5UymtdBlQNISyrl8mdSfRVTcQzB5blYEUyo=
X-Received: by 2002:ab0:5444:: with SMTP id o4mr1665827uaa.55.1541001962702;
 Wed, 31 Oct 2018 09:06:02 -0700 (PDT)
MIME-Version: 1.0
References: <20181019120952.32763-1-hch@lst.de> <20181019120952.32763-7-hch@lst.de>
 <20181019122228.GJ30658@n2100.armlinux.org.uk> <CAK7LNATZ8LagrTrTae_QCQbSuTW7_y6sDrdTHfTyONPrsYDs4A@mail.gmail.com>
In-Reply-To: <CAK7LNATZ8LagrTrTae_QCQbSuTW7_y6sDrdTHfTyONPrsYDs4A@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 1 Nov 2018 01:05:26 +0900
X-Gmail-Original-Message-ID: <CAK7LNASUArREw1AWUzcOoQCe5=4jyifbs+x2CdCK+qXJ+woAdw@mail.gmail.com>
Message-ID: <CAK7LNASUArREw1AWUzcOoQCe5=4jyifbs+x2CdCK+qXJ+woAdw@mail.gmail.com>
Subject: Re: [PATCH 6/9] PCI: consolidate PCI config entry in drivers/pci
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Alex Bounine <alex.bou9@gmail.com>,
        mporter@kernel.crashing.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Russell King <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Christoph,


On Fri, Oct 19, 2018 at 9:58 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> On Fri, Oct 19, 2018 at 9:23 PM Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
>
> > > index a68b34183107..b185794549be 100644
> > > --- a/arch/arm/mach-pxa/Kconfig
> > > +++ b/arch/arm/mach-pxa/Kconfig
> > > @@ -125,7 +125,7 @@ config MACH_ARMCORE
> > >       bool "CompuLab CM-X255/CM-X270 modules"
> > >       select ARCH_HAS_DMA_SET_COHERENT_MASK if PCI
> > >       select IWMMXT
> > > -     select MIGHT_HAVE_PCI
> > > +     select HAVE_PCI
> > >       select NEED_MACH_IO_H if PCI
> > >       select PXA25x
> > >       select PXA27x
> >
> > This is wrong.  "MIGHT_HAVE_PCI" is _not_ the same as "HAVE_PCI" - we
> > have a bunch of platforms that mandatorily have PCI and these select
> > PCI directly.  "MIGHT_HAVE_PCI" controls the _visibility_ of the PCI
> > menu option, but does not prevent it being selected.  Your patch will
> > cause Kconfig to complain for those which mandatorily have PCI but
> > do not set HAVE_PCI.
>
>
> Good catch!
> But, adding a bunch of 'select HAVE_PCI' along with 'select PCI' is ugly.
>
> Do you have any suggestion?
>
> How about letting CONFIG_ARM to select HAVE_PCI ?
>


I applied 1/9, 3/9, 4/9, 5/9.
(I think 2/9 should be squashed to 9/9)

As Russell pointed out, we need to avoid
the unmet dependency.


Are you planning to send
the updated version for 6/9 through - 9/9 ?

If so, could you please rebase 6/9
so that it is cleanly applicable ?


Thanks.


--
Best Regards
Masahiro Yamada
