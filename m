Return-Path: <SRS0=/yaj=M3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4818AC28CF8
	for <linux-pci@archiver.kernel.org>; Mon, 15 Oct 2018 08:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18B752086A
	for <linux-pci@archiver.kernel.org>; Mon, 15 Oct 2018 08:47:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18B752086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbeJOQbl (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Oct 2018 12:31:41 -0400
Received: from verein.lst.de ([213.95.11.211]:40956 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726273AbeJOQbl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 15 Oct 2018 12:31:41 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 88D1068C8E; Mon, 15 Oct 2018 10:47:21 +0200 (CEST)
Date:   Mon, 15 Oct 2018 10:47:21 +0200
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
Subject: Re: [PATCH 2/8] powerpc: simplify CONFIG_PCI_QSPAN Kconfig magic
Message-ID: <20181015084721.GB27159@lst.de>
References: <20181013151016.31674-1-hch@lst.de> <20181013151016.31674-3-hch@lst.de> <CAK7LNAQxZcBNadLJhfrmxJGj-XJFVaya3Z1eexZp20vRPwrN7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAQxZcBNadLJhfrmxJGj-XJFVaya3Z1eexZp20vRPwrN7A@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 15, 2018 at 03:35:41PM +0900, Masahiro Yamada wrote:
> 'git grep' did not get any other hit.
> 
> masahiro@pug:~/ref/linux$ git grep PCI_QSPAN
> arch/powerpc/Kconfig:   default PCI_QSPAN if PPC_8xx
> arch/powerpc/Kconfig:config PCI_QSPAN
> 
> With your patch, PCI_QSPAN will become
> a dead config option.
> 
> How about removing it entirely?

Yes, it should just go away.  Thanks!
