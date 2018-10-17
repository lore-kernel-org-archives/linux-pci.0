Return-Path: <SRS0=Zwnb=M5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD96ECDE30
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 13:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92819214C2
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 13:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gpOy63Kh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92819214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbeJQVaq (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 17 Oct 2018 17:30:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57066 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbeJQVap (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Oct 2018 17:30:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0BfilibB3RXQDWvBsWQCsW+aY4f4I222495HAeE72i0=; b=gpOy63KhluEpIewNLunX7U1Y9
        7UrzDghZKgq2Gk+4EbNcO0aIcY60gSD68bLfLEvKUIOw5u1oNO9uZ6bXx6CQfGZxFZFx3qiSbbS5b
        8/9Xsi8MqXj93CSccPH0rS46MQf2A2njOXiY0p8rVsF8NHT0mZFVBSKnQWnHUr3n4LYGhy5WO4r/M
        uoheC8dj4x6UyWZsM2zw635AuLnDJ2qT73E06kJ8+EaFMqqoexs0MgyT+CWuNbDUiKutWHa/kWw21
        Qb5v8M/72O6DVpUMKp7hDknPzoIcBze93VdU4OC0OJxpsNKcYciA9ZkXloSs5I7HWsPi+3llZID0m
        4sjQKBnug==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gClyV-0001LQ-9l; Wed, 17 Oct 2018 13:34:59 +0000
Date:   Wed, 17 Oct 2018 06:34:59 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     logang@deltatee.com, linux-pci@vger.kernel.org
Subject: Re: [bug report] PCI/P2PDMA: Support peer-to-peer memory
Message-ID: <20181017133459.GA4070@infradead.org>
References: <20181017084529.hizjk6bdxsgpuvn5@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181017084529.hizjk6bdxsgpuvn5@kili.mountain>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> 		if (!pdev->p2pdma)
> 
> In other words, I don't understand why we are testing "publish"...
> 
>    682			return;
>    683	
>    684		pdev->p2pdma->p2pmem_published = publish;
>                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. or simplify it even further to:

	if (pdev->p2pdma)
		pdev->p2pdma->p2pmem_published = publish;
