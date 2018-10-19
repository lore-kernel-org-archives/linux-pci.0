Return-Path: <SRS0=b7f5=M7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97CF4ECDE43
	for <linux-pci@archiver.kernel.org>; Fri, 19 Oct 2018 07:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53D562087A
	for <linux-pci@archiver.kernel.org>; Fri, 19 Oct 2018 07:00:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53D562087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbeJSPEt (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 19 Oct 2018 11:04:49 -0400
Received: from verein.lst.de ([213.95.11.211]:43660 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726465AbeJSPEt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Oct 2018 11:04:49 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 41DD268C78; Fri, 19 Oct 2018 09:00:02 +0200 (CEST)
Date:   Fri, 19 Oct 2018 09:00:01 +0200
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
Message-ID: <20181019070001.GA30556@lst.de>
References: <20181017080201.10866-1-hch@lst.de> <CAMuHMdWMtxxu8iivcnT=uWTMHsp=iSq_QzXqDWQut5OHwTU8Sg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWMtxxu8iivcnT=uWTMHsp=iSq_QzXqDWQut5OHwTU8Sg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 17, 2018 at 10:30:49AM +0200, Geert Uytterhoeven wrote:
> Please use "git format-patch -v<N> --cover" to prepare patch series
> for sending with git-send-email.
> 
>   "-v<N>" to prefix all patches with version number <N>,
>   "--cover" to have a "[PATCH 0/<M>]" prefix in the cover letter.

We had that discussion before and I strongly disagree with messing
up the subject lines like that.  The git-send-email defaults are
perfectly fine.
