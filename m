Return-Path: <SRS0=Vy8e=QE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1418FC282C8
	for <linux-pci@archiver.kernel.org>; Mon, 28 Jan 2019 13:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD6422147A
	for <linux-pci@archiver.kernel.org>; Mon, 28 Jan 2019 13:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h0peRGBy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfA1Ndo (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 28 Jan 2019 08:33:44 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57646 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbfA1Ndo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Jan 2019 08:33:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BQAbDTdJwdOOW82nOfAOiRyJqZt+DDRMYSPeNql1AE4=; b=h0peRGByJvJqH6vHU8SBNfBxV
        0RB62rmAX25LvqvGJKbkOBYfLo4xyhPpd++X9kXIgF0AnqFgaZehugq1k4iE3uMqJ102jiPeio4VS
        pAPFpd6VAMS6uxhaXbJWvHkUt2epCmmSByuiHwprPwChxV+HxXFSQIA7zrlj8U3L4oZdQcJeOBQb+
        dTrm/3SPpHEn1uhx5zcRabKeyJDEbynaqQwv3xFm8rFdfzBouxOaLEMomLyaLJnX9AHBOAprAUXmt
        afrL1FzFEAVZeNKRM8SdOxMzgDPb9hnXH8rj/0OXfQfPHyNUttc53jUpzFfqr8B3MU2klzGPD42Wd
        jki8W3f+Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1go72j-0001Lz-FS; Mon, 28 Jan 2019 13:33:41 +0000
Date:   Mon, 28 Jan 2019 05:33:41 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 2/7] MIPS: SGI-IP27: clean up bridge access and header
 files
Message-ID: <20190128133341.GA5140@infradead.org>
References: <20190124174728.28812-1-tbogendoerfer@suse.de>
 <20190124174728.28812-3-tbogendoerfer@suse.de>
 <20190128132003.GA744@infradead.org>
 <20190128142440.591d2115ac7844863713aa77@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128142440.591d2115ac7844863713aa77@suse.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 28, 2019 at 02:24:40PM +0100, Thomas Bogendoerfer wrote:
> I totally agreed. I only moved the original defintion around while cleaning
> up the header file. Right now there is no code using it. Should I remove it
> and access macros as soon there is a need for it ?

Sounds good.
