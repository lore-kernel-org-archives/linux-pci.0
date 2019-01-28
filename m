Return-Path: <SRS0=Vy8e=QE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE01C282CF
	for <linux-pci@archiver.kernel.org>; Mon, 28 Jan 2019 13:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 024A02147A
	for <linux-pci@archiver.kernel.org>; Mon, 28 Jan 2019 13:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eMH2iz9a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfA1NdV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 28 Jan 2019 08:33:21 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57610 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbfA1NdV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Jan 2019 08:33:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UDuf/5rGamUsYQzyqVCnd/3/j79KclFANZkff9RCf8I=; b=eMH2iz9aLZaVe2PsjQixwZX3G
        v6eIw93/XRnY6ShybRbazneQZY12Tk4ROzMcb2KuyLQfMoKPwFYxj5BXQ6QaOBXglrFUuLAxTRT2Y
        xEnST3UMFau6D9YaqsXis1Zi46tmX8gipTpJZm8XOvq9EcBHVMbvJDKisWo+NtnOK33ooH/1tgJCj
        uB1p+59oPzddrLTYGg7HYc5Wy2PHqb5n9NksnTLVktUOkoM1tPZEDYm7uDQ8UCbojZO8DJU8AA9SX
        p5GrUqkZlsKQIu/fCI4qx1u1XH7bq/C6xehcyPalp3HQn1HugXjkxmvIVls6qp69+ZBvcUk6FVybi
        sJWdFa+Nw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1go72M-0001Kn-2H; Mon, 28 Jan 2019 13:33:18 +0000
Date:   Mon, 28 Jan 2019 05:33:17 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 7/7] MIPS: SGI-IP27: abstract chipset irq from bridge
Message-ID: <20190128133317.GD744@infradead.org>
References: <20190124174728.28812-1-tbogendoerfer@suse.de>
 <20190124174728.28812-8-tbogendoerfer@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124174728.28812-8-tbogendoerfer@suse.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Shouldnt this just use chained irqchip drivers instead?
