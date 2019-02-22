Return-Path: <SRS0=XWMu=Q5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC1EEC43381
	for <linux-pci@archiver.kernel.org>; Fri, 22 Feb 2019 14:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A705020818
	for <linux-pci@archiver.kernel.org>; Fri, 22 Feb 2019 14:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RzvG4jCh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbfBVOtP (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 22 Feb 2019 09:49:15 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:49316 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbfBVOtO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Feb 2019 09:49:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=U52uwF3d8GBlR/1Mbgwoe1sx/P0nJ97QaArOdi6k+ng=; b=RzvG4jChDX62QYDUMCAi2f91G
        1KJs1V5tr0dvTho+lkOpALugFm6M8ge+JJwlsNt53Mg7bet3mwZoRvPSPz5G+yvwLeaKjnYrqM7oR
        XOZojJrhu8TGGmZg0lBx0wybmThbMVZRRxPxwGn3zbTh7to+Hg00kvjC+oxqSjvlgwL/iqvuMUwu7
        kRNJhSLoXSV7EllkMJBeB34QZLmg/GXI75vRrc17RMB1SstJcwapwO1JS/DTqVakfldLF43Ggzt8m
        tnGpSsVJ5tXrC2oznKehzz9m7wQNExhMpAFfDdh4lN1+As4sZxjkMWa2yXRVU37xm/ugGWAg4I6Dw
        p1tNmAbYA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gxC8R-00085g-K1; Fri, 22 Feb 2019 14:49:07 +0000
Date:   Fri, 22 Feb 2019 06:49:07 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc:     Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 00/10] MIPS: SGI-IP27 rework
Message-ID: <20190222144907.GB10643@infradead.org>
References: <20190219155728.19163-1-tbogendoerfer@suse.de>
 <20190221205038.hcov3n574a3zqip7@pburton-laptop>
 <20190222091418.7c0eeb0d5c11b68874d8fdc9@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222091418.7c0eeb0d5c11b68874d8fdc9@suse.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 22, 2019 at 09:14:18AM +0100, Thomas Bogendoerfer wrote:
> 
> I'm still fighting with git send-email to do proper collecting of addresses...
> And the mails to your @mips.com address bounced yesterday.

FYI, it also bounced for me yesterday (or the day before, depending on
the time zone).
