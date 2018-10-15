Return-Path: <SRS0=/yaj=M3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C7AC28CF8
	for <linux-pci@archiver.kernel.org>; Mon, 15 Oct 2018 09:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA1B020853
	for <linux-pci@archiver.kernel.org>; Mon, 15 Oct 2018 09:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="gY76bZ24"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA1B020853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbeJORC0 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Oct 2018 13:02:26 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:22797 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbeJORC0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Oct 2018 13:02:26 -0400
X-Greylist: delayed 9728 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Oct 2018 13:02:25 EDT
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id w9F9Ho2s017372;
        Mon, 15 Oct 2018 18:17:50 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w9F9Ho2s017372
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1539595071;
        bh=uoMJsd1TMhHqhCJuIipgIP5V4I4WH9bU9cBtVDfn1UI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gY76bZ24pDlA8u2OLob2OYZq9kOJ4xT61NYdlhA/4YpITOegJ+jhbj23pfHP3aQ7B
         brvfqGc53lo8aMEJiDHm2qm6sZcpKCPGU52/CmG2c+4ujoEM06LHiNeuQP19wFAKr/
         lUVXPjv7jmgg9a5MhyYu5OyKryNQFoek6WemSDs8HInC/wlP+47BJnOd56Sq/yygJd
         t8QUH6e7vDeTJv/2L2EBluZMI/+K2gKE5Jim9OzKRmRL6azsysCqaeZhE4FhTQg5TH
         vf4ChWgWFLeXd4o93QFJndh5OTUa8MtubQFTd/rRB2AC/6cvZK8U7LvXe316yDv4u1
         XZRKjgoJ0xFBg==
X-Nifty-SrcIP: [209.85.217.48]
Received: by mail-vs1-f48.google.com with SMTP id r83so15842080vsc.4;
        Mon, 15 Oct 2018 02:17:50 -0700 (PDT)
X-Gm-Message-State: ABuFfoiLKx9Fo4Zr1Rc/i5xdPTgsjmb801Lt5pKRkQaKMF2PxmpuT9g6
        a7niCQbBe6r85TQ18FpmLMkabn7KGf78NqFp36g=
X-Google-Smtp-Source: ACcGV62sbBk1X3cOASnSTccR6Hp7nPkhT2EGMVkrmWla4johvZoop9rlDs1h4E7d2rMwg39fAEqefKOk/faVZO0ESks=
X-Received: by 2002:a67:5fc7:: with SMTP id t190mr6437461vsb.155.1539595069491;
 Mon, 15 Oct 2018 02:17:49 -0700 (PDT)
MIME-Version: 1.0
References: <20181013151016.31674-1-hch@lst.de> <20181013151016.31674-5-hch@lst.de>
 <CAK7LNAQy_NTu5=8R6C3Xc2VLrJo7tKOz-u1=3JfGtBa3Z+ZD9g@mail.gmail.com> <20181015085737.GC27159@lst.de>
In-Reply-To: <20181015085737.GC27159@lst.de>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 15 Oct 2018 18:17:13 +0900
X-Gmail-Original-Message-ID: <CAK7LNARbkmZ-Lq7W1R6r21dw0RTTyfGYNr5MLuufOVB2rqy2uQ@mail.gmail.com>
Message-ID: <CAK7LNARbkmZ-Lq7W1R6r21dw0RTTyfGYNr5MLuufOVB2rqy2uQ@mail.gmail.com>
Subject: Re: [PATCH 4/8] pci: consolidate PCI config entry in drivers/pci
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

On Mon, Oct 15, 2018 at 5:57 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Mon, Oct 15, 2018 at 03:37:05PM +0900, Masahiro Yamada wrote:
> > I think HAVE_ is a preferred prefix in this case according to this doc:
> > https://github.com/masahir0y/linux/blob/v4.19-rc4/Documentation/kbuild/kconfig-language.txt#L448
>
> Ok, I'll switch everything to HAVE_*
>
> > If you do this for entire powerpc,
> > the other 'select HAS_PCI' addtions to
> > arch/powerpc/platforms/*/Kconfig look redundant.
>
> I'll drop them.
>
> > > -config PCI
> > > -       bool "PCI support"
> > > -       select PCI_MSI
> >
> >
> > I think this 'select PCI_MSI' for riscv was lost.
>
> Indeed, fixed.
>
> > >  menu "Bus options (PCI etc.)"
> > >
> > > -config PCI
> > > -       bool "PCI support"
> > > -       default y
> >
> >
> > The default is y for x86 (and xtensa as well).
> >
> > With this patch, the default will be flipped.
> >
> > I think most of people want to use PCI for x86,
> > and this change will make people upset.
> >
> > Will you update arch/{x86,xtensa}/configs/*_defconfig?
>
> Yes.  Alternatively we could add a new ARCH_PCI_DEFAULT symbol,
> that architectures could select if they want PCI by default.  Does
> anyone thing this is a good idea?


No, I do not want to see such an ugly config option.

Instead, you can use 'imply' keyword to set the default y.

config X86
       ...
       imply    PCI



But, personally, I'd like the defconfig files updated.



-- 
Best Regards
Masahiro Yamada
