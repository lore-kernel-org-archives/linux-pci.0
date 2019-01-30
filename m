Return-Path: <SRS0=6RWV=QG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40AEC282D7
	for <linux-pci@archiver.kernel.org>; Wed, 30 Jan 2019 09:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB63121873
	for <linux-pci@archiver.kernel.org>; Wed, 30 Jan 2019 09:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NjuaUyU7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730363AbfA3JRK (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 30 Jan 2019 04:17:10 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58886 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfA3JRJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Jan 2019 04:17:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PkkRrH7Upoq4Qs5K73ZsT40YYfKo1vrfTnkSOGPXaak=; b=NjuaUyU7G/RQx2NHQ5Wzvm+DT
        2B4zkjV/NFMgartmyl2XVNLBduYK8e/7ut80VVYoMtvL2KMv+9JMlb9QLIGQBTAXmInTCWmweXS62
        dwMQwTWmKHf3RBK2GaKDSWSvRQtW7D2OAwwZMGsx1vH2Git2v2whu8YDZo/IYuWiW7HPZBxadXq0Y
        GyBu3WakPbpGyUKCtaY39ReWA4DGzWDz7gKEi18Du6KorP8bjUkSVnyakgGg3FnjWOteXVpZy8Se0
        oupSKfK7f9ddCb+wyBtiPKHgYCqCwYdFaiDEZgju8Q2L1rBmaIMI0JxTCP7+BhxdA9+wd4BGR/nY+
        1/Ho4IRig==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1golzW-0004Dc-6L; Wed, 30 Jan 2019 09:17:06 +0000
Date:   Wed, 30 Jan 2019 01:17:06 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 6/7] MIPS: SGI-IP27: use generic PCI driver
Message-ID: <20190130091706.GA3617@infradead.org>
References: <20190124174728.28812-1-tbogendoerfer@suse.de>
 <20190124174728.28812-7-tbogendoerfer@suse.de>
 <20190128133215.GC744@infradead.org>
 <20190129162445.8584b58862068c0a7693718c@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129162445.8584b58862068c0a7693718c@suse.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 29, 2019 at 04:24:45PM +0100, Thomas Bogendoerfer wrote:
> > From an abstraction point of view this doesn't really belong into
> > a bridge driver as it is a global exported function.  I guess we can
> > keep it here with a fixme comment, but we should probably move this
> > into a method call instead.
> 
> or put the nodeid into the bus struct ?

Doesn't sound to bad to me, you'll just have to update a fair
amount of arch implementations.

> I'm all for it. I looked at the examples for using dma_pfn_offset and the
> only one coming close to usefull for me is arch/sh/drivers/pci/pcie-sh7786.c
> It overloads pcibios_bus_add_device() to set dma_pfn_offset, which doesn't
> look much nicer. What about having a dma_pfn_offset in struct pci_bus
> which all device inherit from ?

Or add a add_dev callback, similar to what I did for a previous series
that we didn't end up needing after all:

http://git.infradead.org/users/hch/misc.git/commitdiff/06d9b4fc7deed336edc1292fe2e661729e98ec39

