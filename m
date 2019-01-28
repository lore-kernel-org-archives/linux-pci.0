Return-Path: <SRS0=Vy8e=QE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD97C282CD
	for <linux-pci@archiver.kernel.org>; Mon, 28 Jan 2019 13:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3C2D20857
	for <linux-pci@archiver.kernel.org>; Mon, 28 Jan 2019 13:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MvkcRvh8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfA1N0j (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 28 Jan 2019 08:26:39 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56506 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbfA1N0j (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Jan 2019 08:26:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hrMzkDzLFVeIq1QspXrk2S726CwJy3HVhTazSf138ao=; b=MvkcRvh86IlzlP04wpWw28rYh
        czgNf+HTB5AtbkazUm3eRuGSYprMlgw3vmTDrGhF4duJUsSXJpT8wDPUnlxlmkLYOdy5lG9g6JR4a
        X7MUvqy+EOCT+ScF0akEdWAab6ICEkbkinW4ulcq5feOpgaikSbp1jgxElYRsHhh1e2KcEIIYXCn6
        mAn75ZoXwqJbC5Le9XBs5VQp4s8CEaGoeIzB8aPd+6vSmWiV1HDEtnrTgbaORN3oGTr4S/ybBaMJo
        qxDmNrBVMzZffud3BoGvlZRpdPwYhdtd2Lr8sFU2W2Xn2QAlAyFmlh87mPXXijWUoimPTzXJnjMIc
        NUP04MI7g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1go6vq-00087m-Cd; Mon, 28 Jan 2019 13:26:34 +0000
Date:   Mon, 28 Jan 2019 05:26:34 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 5/7] MIPS: SGI-IP27: rework HUB interrupts
Message-ID: <20190128132634.GB744@infradead.org>
References: <20190124174728.28812-1-tbogendoerfer@suse.de>
 <20190124174728.28812-6-tbogendoerfer@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124174728.28812-6-tbogendoerfer@suse.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

>  struct slice_data {
>  	unsigned long irq_enable_mask[2];
> -	int level_to_irq[LEVELS_PER_SLICE];
>  };

Any reaason to keep struct slice_data around at all?

> +	HUB_S(hd->irq_mask_addr[0], si->irq_enable_mask[0]);
> +	HUB_S(hd->irq_mask_addr[1], si->irq_enable_mask[1]);

I know the HUB_S name is pre-existing, but maybe you can throw in
a patch to give it a more descriptive name?  Or maybe just kill
it off entirely at least for new code and use __raw_readq
directly.

>  #endif
>  	{
> -		/* "map" swlevel to irq */
> -		struct slice_data *si = cpu_data[cpu].data;
> -
> -		irq = si->level_to_irq[swlevel];
> -		do_IRQ(irq);
> +		do_IRQ(swlevel + IP27_HUB_IRQ_BASE);
>  	}

Looks like we can just kill the { } and additional indentation here.
