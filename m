Return-Path: <SRS0=b7f5=M7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2710ECDE43
	for <linux-pci@archiver.kernel.org>; Fri, 19 Oct 2018 12:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DF4C21479
	for <linux-pci@archiver.kernel.org>; Fri, 19 Oct 2018 12:02:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DF4C21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbeJSUHs (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 19 Oct 2018 16:07:48 -0400
Received: from verein.lst.de ([213.95.11.211]:45289 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726784AbeJSUHs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Oct 2018 16:07:48 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id F08B168C78; Fri, 19 Oct 2018 14:01:59 +0200 (CEST)
Date:   Fri, 19 Oct 2018 14:01:59 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matt Porter <mporter@kernel.crashing.org>,
        Alex Bounine <alex.bou9@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        scsi <linux-scsi@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: move bus (PCI, PCMCIA, EISA, rapdio) config to drivers/ v2
Message-ID: <20181019120159.GA14677@lst.de>
References: <20181017080201.10866-1-hch@lst.de> <CAMuHMdWMtxxu8iivcnT=uWTMHsp=iSq_QzXqDWQut5OHwTU8Sg@mail.gmail.com> <20181019070001.GA30556@lst.de> <CAMuHMdXLug_T4onn23JormmYZXDWVnEFYaoMzA90bpGFvk6Eow@mail.gmail.com> <20181019071057.GA31656@lst.de> <CAMuHMdXqPNOwcjWVmH08YSfZopc0pWLUj-r0s6g=q0oUdqWhWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXqPNOwcjWVmH08YSfZopc0pWLUj-r0s6g=q0oUdqWhWw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 19, 2018 at 09:22:08AM +0200, Geert Uytterhoeven wrote:
> Hi Christoph,
> 
> On Fri, Oct 19, 2018 at 9:10 AM Christoph Hellwig <hch@lst.de> wrote:
> > On Fri, Oct 19, 2018 at 09:07:51AM +0200, Geert Uytterhoeven wrote:
> > > Without this:
> > >   - It's hard to visually match your untagged cover letter with the
> > > actual patches,
> > >   - Your individual patches lack the version info, so people cannot see which
> > >     version review comments in an email reply apply to.
> >
> > All of that is trivially solved by mail threading.
> 
> You forgot to answer this question:
> 
> | Can you please clarify what exactly that would mess up?

It makes the already limited space in the subject line even shorted
(or harder to read depending on which way you go) for absolutely not
good reason.
