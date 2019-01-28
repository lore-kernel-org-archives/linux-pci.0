Return-Path: <SRS0=Vy8e=QE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C85BBC282CF
	for <linux-pci@archiver.kernel.org>; Mon, 28 Jan 2019 16:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D98020663
	for <linux-pci@archiver.kernel.org>; Mon, 28 Jan 2019 16:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QX+ww8Ih"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390422AbfA1Qar (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:30:47 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34040 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389950AbfA1Q1Y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Jan 2019 11:27:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=afkxU8B163R9+1TjnSSrQMJVy78j3isfMsboWHelv9c=; b=QX+ww8IhFhtKeBdohM4Kq9igW
        cB/F+MuWirXcCakdZmAGmIAYsYsVZCgmN+q1t2DYLvz/fC2inctyZzkIueewtIbVXYAjI5+8VHtV1
        SSXN2gkocydYgcqFuUoaUXRVbp2gxE5uyQU4Ls+yrxnJuum/5NmHlqfkao0TPZWScVsstDuKdhJA2
        vlp1p1o035UBEGAa7KNXV/qFsRvEqRGpZXRLgFJ5zZ2cAqd26VXwt4dlb1oYza1lfNRhYJJ7aYuFk
        p+89DSDOOOwsG+YCghkQX2apFUtQxpiMFQNcry/WLmCqeRL7CzZi6aXifoMklSIisb3l39rKwYcs+
        8D6E/XNUQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1go9kn-0000nL-Ky; Mon, 28 Jan 2019 16:27:21 +0000
Date:   Mon, 28 Jan 2019 08:27:21 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 7/7] MIPS: SGI-IP27: abstract chipset irq from bridge
Message-ID: <20190128162721.GA25378@infradead.org>
References: <20190124174728.28812-1-tbogendoerfer@suse.de>
 <20190124174728.28812-8-tbogendoerfer@suse.de>
 <20190128133317.GD744@infradead.org>
 <20190128150135.66f85834ab80813e6dc5ddf5@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128150135.66f85834ab80813e6dc5ddf5@suse.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 28, 2019 at 03:01:35PM +0100, Thomas Bogendoerfer wrote:
> On Mon, 28 Jan 2019 05:33:17 -0800
> Christoph Hellwig <hch@infradead.org> wrote:
> 
> > Shouldnt this just use chained irqchip drivers instead?
> 
> you mean using irq_set_chained_handler() ? If yes, this IMHO doesn't look usefull
> because it's used for adding a secondary interrupt controller. But what I need
> is telling bridge ASIC to direct the xtalk IRQ packet to a specific HUB/HEART/BEDROCK
> from the HUB/HEART/BEDROCK specific code. And want to avoid dragging in bridge details
> to that specific code.

Yes, but don't we have nested interrupt controllers here?  Even if they
don't really do much in the fast path the setup does look chained to me.
Then again I'm not really an expert in the irq handling code nor in this
hardware, so maybe Thomas or Marc might have a better idea.

