Return-Path: <SRS0=b7f5=M7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D098ECDE3D
	for <linux-pci@archiver.kernel.org>; Fri, 19 Oct 2018 07:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ACC120869
	for <linux-pci@archiver.kernel.org>; Fri, 19 Oct 2018 07:07:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ACC120869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbeJSPLn (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 19 Oct 2018 11:11:43 -0400
Received: from verein.lst.de ([213.95.11.211]:43728 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726340AbeJSPLm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Oct 2018 11:11:42 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id B96EC68C76; Fri, 19 Oct 2018 09:06:54 +0200 (CEST)
Date:   Fri, 19 Oct 2018 09:06:54 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Christoph Hellwig <hch@lst.de>, mporter@kernel.crashing.org,
        Alex Bounine <alex.bou9@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-pci@vger.kernel.org, linux-scsi <linux-scsi@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 7/8] eisa: consolidate EISA Kconfig entry in
 drivers/eisa
Message-ID: <20181019070654.GC30556@lst.de>
References: <20181017080201.10866-1-hch@lst.de> <20181017080201.10866-8-hch@lst.de> <CAK7LNAT0pzpMZC+X5KiofPCUH89hr716WCKQkNYronQa3byT9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAT0pzpMZC+X5KiofPCUH89hr716WCKQkNYronQa3byT9w@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 19, 2018 at 01:46:50PM +0900, Masahiro Yamada wrote:
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -59,6 +59,7 @@ config ARM
> >         select HAVE_ARCH_TRACEHOOK
> >         select HAVE_ARM_SMCCC if CPU_V7
> >         select HAVE_EBPF_JIT if !CPU_ENDIAN_BE32
> > +       select HAVE_EISA
> 
> I doubt this.
> 
> arch/arm/Kconfig previously did not include
> driver/eisa/Kconfig.
> 
> No ARM platform enabled CONFIG_EISA either.

But it did offer the EISA option.  I guess I can remove this in
a separate commit and see if anyone screams.
