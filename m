Return-Path: <SRS0=yh4A=M2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B49C71122
	for <linux-pci@archiver.kernel.org>; Sun, 14 Oct 2018 06:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BCF820835
	for <linux-pci@archiver.kernel.org>; Sun, 14 Oct 2018 06:02:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BCF820835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dominikbrodowski.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbeJNNmT (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 14 Oct 2018 09:42:19 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:53640 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbeJNNmT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 14 Oct 2018 09:42:19 -0400
X-Greylist: delayed 856 seconds by postgrey-1.27 at vger.kernel.org; Sun, 14 Oct 2018 09:42:17 EDT
Received: from light.dominikbrodowski.net (isilmar.linta [10.0.0.1])
        by isilmar-4.linta.de (Postfix) with ESMTPS id 569C620092B;
        Sun, 14 Oct 2018 05:48:12 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id DE9D420E74; Sun, 14 Oct 2018 07:42:52 +0200 (CEST)
Date:   Sun, 14 Oct 2018 07:42:52 +0200
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        linux-kbuild@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 5/8] pcmcia: allow PCMCIA support independent of the
 architecture
Message-ID: <20181014054252.GA24103@light.dominikbrodowski.net>
References: <20181013151016.31674-1-hch@lst.de>
 <20181013151016.31674-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181013151016.31674-6-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Oct 13, 2018 at 05:10:13PM +0200, Christoph Hellwig wrote:
> There is nothing architecture specific in the PCMCIA core, so allow
> building it everywhere.  The actual host controllers will depend on ISA,
> PCI or a specific SOC.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me, though I'm interested on any subtle (build) breakage when
this gets exposure in -next. Will you push this patch upstream directly, or
should it go in via the pcmcia tree? If it is the former, feel free to add

	Acked-by: Dominik Brodowski <linux@dominikbrodowski.net>


Thanks,
	Dominik
