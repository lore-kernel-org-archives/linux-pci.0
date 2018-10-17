Return-Path: <SRS0=Zwnb=M5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A36AECDE30
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 08:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6698121534
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 08:17:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6698121534
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbeJQQLk (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 17 Oct 2018 12:11:40 -0400
Received: from verein.lst.de ([213.95.11.211]:57260 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727008AbeJQQLk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Oct 2018 12:11:40 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 6663A68C88; Wed, 17 Oct 2018 10:17:06 +0200 (CEST)
Date:   Wed, 17 Oct 2018 10:17:06 +0200
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
Subject: Re: [PATCH 8/8] kconfig: remove CONFIG_MCA leftovers
Message-ID: <20181017081706.GA24869@lst.de>
References: <20181013151016.31674-1-hch@lst.de> <20181013151016.31674-9-hch@lst.de> <CAK7LNAQwyWUq_ohVMe9QLLbyHHQdjkrkM9DPd3pgYLz8UhG6rA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAQwyWUq_ohVMe9QLLbyHHQdjkrkM9DPd3pgYLz8UhG6rA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 16, 2018 at 02:20:23PM +0900, Masahiro Yamada wrote:
> On Sun, Oct 14, 2018 at 12:11 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> 
> 
> Can you use "powerpc:" or something
> for the subject line?
> 
> I'd like to see "kconfig:" only for patches
> that touch the scripts/kconfig/ directory.

Sorry, I missed this for v2.  Will fix it up for the next version
or let you fix it up if there isn't one.
