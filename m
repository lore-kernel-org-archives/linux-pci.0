Return-Path: <SRS0=/yaj=M3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B137FC7112A
	for <linux-pci@archiver.kernel.org>; Mon, 15 Oct 2018 08:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83E2820644
	for <linux-pci@archiver.kernel.org>; Mon, 15 Oct 2018 08:57:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83E2820644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbeJOQmA (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Oct 2018 12:42:00 -0400
Received: from verein.lst.de ([213.95.11.211]:41038 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726273AbeJOQmA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 15 Oct 2018 12:42:00 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id EA52268C8E; Mon, 15 Oct 2018 10:57:37 +0200 (CEST)
Date:   Mon, 15 Oct 2018 10:57:37 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Christoph Hellwig <hch@lst.de>, mporter@kernel.crashing.org,
        alex.bou9@gmail.com,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-pci@vger.kernel.org, linux-scsi <linux-scsi@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 4/8] pci: consolidate PCI config entry in drivers/pci
Message-ID: <20181015085737.GC27159@lst.de>
References: <20181013151016.31674-1-hch@lst.de> <20181013151016.31674-5-hch@lst.de> <CAK7LNAQy_NTu5=8R6C3Xc2VLrJo7tKOz-u1=3JfGtBa3Z+ZD9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAQy_NTu5=8R6C3Xc2VLrJo7tKOz-u1=3JfGtBa3Z+ZD9g@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 15, 2018 at 03:37:05PM +0900, Masahiro Yamada wrote:
> I think HAVE_ is a preferred prefix in this case according to this doc:
> https://github.com/masahir0y/linux/blob/v4.19-rc4/Documentation/kbuild/kconfig-language.txt#L448

Ok, I'll switch everything to HAVE_*

> If you do this for entire powerpc,
> the other 'select HAS_PCI' addtions to
> arch/powerpc/platforms/*/Kconfig look redundant.

I'll drop them.

> > -config PCI
> > -       bool "PCI support"
> > -       select PCI_MSI
> 
> 
> I think this 'select PCI_MSI' for riscv was lost.

Indeed, fixed.

> >  menu "Bus options (PCI etc.)"
> >
> > -config PCI
> > -       bool "PCI support"
> > -       default y
> 
> 
> The default is y for x86 (and xtensa as well).
> 
> With this patch, the default will be flipped.
> 
> I think most of people want to use PCI for x86,
> and this change will make people upset.
> 
> Will you update arch/{x86,xtensa}/configs/*_defconfig?

Yes.  Alternatively we could add a new ARCH_PCI_DEFAULT symbol,
that architectures could select if they want PCI by default.  Does
anyone thing this is a good idea?
