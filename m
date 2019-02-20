Return-Path: <SRS0=6A7A=Q3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66AACC4360F
	for <linux-pci@archiver.kernel.org>; Wed, 20 Feb 2019 15:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D2F92147A
	for <linux-pci@archiver.kernel.org>; Wed, 20 Feb 2019 15:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ekObypZW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbfBTPLC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 20 Feb 2019 10:11:02 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58562 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfBTPLC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Feb 2019 10:11:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QZINleA5fkfgNNqDZd8ggreydPxvq2wWVqc7AgffeKU=; b=ekObypZWDn3nTmFLxMWKGQ2Mm
        SdVRs7xAkFNT8ZUM6PD3v33gH3TNfWk+OC3s5pGNN2ZpXX50/TIeMXrcGqBHIkZpyJ7cDwNgkBBWL
        yXFXV8hDkeJu/BFQzVm/lS1MCOMNJOG2YzXGsGmRcbF350YCE1SdyCtpiLBRTAS1LkS3H3EMtzAwx
        uptz2theWDBT0K5TyKWSeuZQ6lux0rnoto0ON+m6uaplYSQAOm9DyEpNpYKr3H+0GJfKXfkQKOHa3
        ca99E5mz5r9cuIsqwoYZAj00toKAGoixpXYruTc/XtDD47Mt9sV8WD19z3ibU8JTISqWnt9l54s9R
        YvTqosd6w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gwTWS-0000n2-Rm; Wed, 20 Feb 2019 15:10:56 +0000
Date:   Wed, 20 Feb 2019 07:10:56 -0800
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
Message-ID: <20190220151056.GA29614@infradead.org>
References: <20190124174728.28812-1-tbogendoerfer@suse.de>
 <20190124174728.28812-7-tbogendoerfer@suse.de>
 <20190128133215.GC744@infradead.org>
 <20190218115807.1a683d2c6824acd4ea78eb11@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190218115807.1a683d2c6824acd4ea78eb11@suse.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 18, 2019 at 11:58:07AM +0100, Thomas Bogendoerfer wrote:
> This of course will break SH7786. To fix both cases how about making dma_pfn_offset
>
> a signed long ?

Yes, making it signed sounds like a good idea.
