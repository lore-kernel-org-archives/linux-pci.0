Return-Path: <SRS0=lbet=NL=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624A1ECDE44
	for <linux-pci@archiver.kernel.org>; Wed, 31 Oct 2018 15:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11D7E20664
	for <linux-pci@archiver.kernel.org>; Wed, 31 Oct 2018 15:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="kaeQUieA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11D7E20664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbeKAAcQ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 31 Oct 2018 20:32:16 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:39122 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbeKAAcQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 Oct 2018 20:32:16 -0400
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id w9VFXfph032013;
        Thu, 1 Nov 2018 00:33:41 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w9VFXfph032013
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1541000022;
        bh=7MVqzDRPdYZDW53V3e7ri//BecS61EPHkL2jRn69Nm0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kaeQUieAyfeKSQI4FWreOZvw1ljjQJ+ilSlGiDjO3btxpg0dnHi4sU6ZB09rd2Hwe
         8DxqhQZhh5KI7vyvt8T/t6cxulnjzCj+eJaRpjN+xyuHGPeU4IqO4kj36aiDJ81eIf
         fhZmuWFRYAFESA69yz7jFeBnu1bG5Jqf8QDV+p6WnfI3Hvok7f47Xb61j84KDwvdlG
         lWve812/SfzKpkAwVQCMVhyiq6OxOHbNeurgFFLXz2+fD1UUIRpKE+oNDN7E6PnFc7
         XFIrzjhFJ7KsZ0OGs3Zo55AI39wAy5y6K6jBqbOd3maoj9n7v4IyaP2dlSY3yD8PHo
         5rhs/PDS/1/eg==
X-Nifty-SrcIP: [209.85.221.169]
Received: by mail-vk1-f169.google.com with SMTP id j20so4009715vke.5;
        Wed, 31 Oct 2018 08:33:41 -0700 (PDT)
X-Gm-Message-State: AGRZ1gJqZ+KGtWx5ojmS5ny5K0r48M4ScM9pZNEsRXhVqtd5H3lOcsXP
        sdNk2JdAHob6p9QeSUKXJlVthxVO5EtmFIOgzA8=
X-Google-Smtp-Source: AJdET5cSKM07kpQyZQ73G/EvgXpVGTYb+L6+vGDKhCWRoPmOB0xQTbJTKCGHcBBdV8iKhtsZJhGWT++V5NCTdRKbt4o=
X-Received: by 2002:a1f:1d4b:: with SMTP id d72-v6mr1474118vkd.34.1541000020309;
 Wed, 31 Oct 2018 08:33:40 -0700 (PDT)
MIME-Version: 1.0
References: <20181019120952.32763-1-hch@lst.de> <20181019120952.32763-6-hch@lst.de>
 <20181019151019.GA5618@localhost>
In-Reply-To: <20181019151019.GA5618@localhost>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 1 Nov 2018 00:33:04 +0900
X-Gmail-Original-Message-ID: <CAK7LNARa7xqG1iyQb9PE271L8QTC7nsaVXSAofm0hzku8T5Xvg@mail.gmail.com>
Message-ID: <CAK7LNARa7xqG1iyQb9PE271L8QTC7nsaVXSAofm0hzku8T5Xvg@mail.gmail.com>
Subject: Re: [PATCH 5/9] powerpc: PCI_MSI needs PCI
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     Christoph Hellwig <hch@lst.de>, mporter@kernel.crashing.org,
        Alex Bounine <alex.bou9@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-pci@vger.kernel.org, linux-scsi <linux-scsi@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Oct 20, 2018 at 12:10 AM Josh Triplett <josh@joshtriplett.org> wrote:
>
> On Fri, Oct 19, 2018 at 02:09:48PM +0200, Christoph Hellwig wrote:
> > Various powerpc boards select the PCI_MSI config option without selecting
> > PCI, resulting in potentially not compilable configurations if the by
> > default enabled PCI option is disabled.  Explicitly select PCI to ensure
> > we always have valid configs.
> [...]
> > --- a/arch/powerpc/platforms/44x/Kconfig
> > +++ b/arch/powerpc/platforms/44x/Kconfig
> > @@ -24,6 +24,7 @@ config BLUESTONE
> >       default n
> >       select PPC44x_SIMPLE
> >       select APM821xx
> > +     select PCI
> >       select PCI_MSI
> >       select PPC4xx_MSI
> >       select PPC4xx_PCI_EXPRESS
> > @@ -78,6 +79,7 @@ config KATMAI
> >       select 440SPe
> >       select PCI
> >       select PPC4xx_PCI_EXPRESS
> > +     select PCI
> >       select PCI_MSI
>
> This case already had PCI selected a couple of lines above.


Good catch!

I dropped this hunk,
and applied to linux-kbuild.





> >       select PPC4xx_MSI
> >       help
> > @@ -219,6 +221,7 @@ config AKEBONO
> >       select SWIOTLB
> >       select 476FPE
> >       select PPC4xx_PCI_EXPRESS
> > +     select PCI
> >       select PCI_MSI
> >       select PPC4xx_HSTA_MSI
> >       select I2C
> > --
> > 2.19.1
> >



-- 
Best Regards
Masahiro Yamada
