Return-Path: <SRS0=yh4A=M2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF94C6787C
	for <linux-pci@archiver.kernel.org>; Sun, 14 Oct 2018 07:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C92820843
	for <linux-pci@archiver.kernel.org>; Sun, 14 Oct 2018 07:40:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C92820843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbeJNPUc (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 14 Oct 2018 11:20:32 -0400
Received: from verein.lst.de ([213.95.11.211]:33716 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbeJNPUc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 14 Oct 2018 11:20:32 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 2E8B568C75; Sun, 14 Oct 2018 09:40:24 +0200 (CEST)
Date:   Sun, 14 Oct 2018 09:40:24 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Christoph Hellwig <hch@lst.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        linux-kbuild@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 5/8] pcmcia: allow PCMCIA support independent of the
 architecture
Message-ID: <20181014074024.GA17216@lst.de>
References: <20181013151016.31674-1-hch@lst.de> <20181013151016.31674-6-hch@lst.de> <20181014054252.GA24103@light.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181014054252.GA24103@light.dominikbrodowski.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Oct 14, 2018 at 07:42:52AM +0200, Dominik Brodowski wrote:
> On Sat, Oct 13, 2018 at 05:10:13PM +0200, Christoph Hellwig wrote:
> > There is nothing architecture specific in the PCMCIA core, so allow
> > building it everywhere.  The actual host controllers will depend on ISA,
> > PCI or a specific SOC.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Looks good to me, though I'm interested on any subtle (build) breakage when
> this gets exposure in -next. Will you push this patch upstream directly, or
> should it go in via the pcmcia tree? If it is the former, feel free to add

The patches in the series depend on each other (just in terms of
context).  I suspect the best would be to get it into the kbuild tree.

It has survived the build bot, which found some interesting issues in
the other patches (as well as the !UML dependency), but if more issues
show I can keep you in the loop.
