Return-Path: <SRS0=Nkm2=NM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6592C6786F
	for <linux-pci@archiver.kernel.org>; Thu,  1 Nov 2018 05:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88AF820657
	for <linux-pci@archiver.kernel.org>; Thu,  1 Nov 2018 05:48:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88AF820657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbeKAOuD (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 1 Nov 2018 10:50:03 -0400
Received: from verein.lst.de ([213.95.11.211]:42421 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727533AbeKAOuC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Nov 2018 10:50:02 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id E4D6E6F9B7; Thu,  1 Nov 2018 06:48:31 +0100 (CET)
Date:   Thu, 1 Nov 2018 06:48:31 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
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
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH 6/9] PCI: consolidate PCI config entry in drivers/pci
Message-ID: <20181101054831.GA4589@lst.de>
References: <20181019120952.32763-1-hch@lst.de> <20181019120952.32763-7-hch@lst.de> <20181019122228.GJ30658@n2100.armlinux.org.uk> <CAK7LNATZ8LagrTrTae_QCQbSuTW7_y6sDrdTHfTyONPrsYDs4A@mail.gmail.com> <CAK7LNASUArREw1AWUzcOoQCe5=4jyifbs+x2CdCK+qXJ+woAdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNASUArREw1AWUzcOoQCe5=4jyifbs+x2CdCK+qXJ+woAdw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 01, 2018 at 01:05:26AM +0900, Masahiro Yamada wrote:
> > How about letting CONFIG_ARM to select HAVE_PCI ?
> >
> 
> 
> I applied 1/9, 3/9, 4/9, 5/9.
> (I think 2/9 should be squashed to 9/9)
> 
> As Russell pointed out, we need to avoid
> the unmet dependency.

Yes, I think the HAVE_PCI is probably the nicest way, but we'll
need to wait what Russell as the maintainer wants.

> Are you planning to send
> the updated version for 6/9 through - 9/9 ?
> 
> If so, could you please rebase 6/9
> so that it is cleanly applicable ?

Will do once I find some time after rc1.
