Return-Path: <SRS0=s+SA=MR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA0BC00449
	for <linux-pci@archiver.kernel.org>; Fri,  5 Oct 2018 06:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 138502084D
	for <linux-pci@archiver.kernel.org>; Fri,  5 Oct 2018 06:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="O/xYv4U9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 138502084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbeJEN0X (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 5 Oct 2018 09:26:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52410 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726732AbeJEN0X (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 5 Oct 2018 09:26:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=suJfh0rUhV/rD9O1rrkRDbvpshB3r1eDJ1WvmDHYsEI=; b=O/xYv4U9z3BeTTy0+vYN69vGy
        XA77QJYGfXgHp0zim7K9rO8BNFZD7dT15RiKxCwX8GrQYNnjbMhL2oe/QMEBYoBbdJs8qtwPFHMj7
        01cUCnNkCfdrYY6FFAbaJCduCN91p7j3QSSYmgrQwm4z/2SE/bmsaEGshF4lnznGJv29KllrDnzqp
        3yhMeeTFh/FNmzde6T2cZvH0iAntPIwYr/57adq5ZThq7GVitcC6wlSebfEKlHYxSlk4ouG62pilv
        J5XcD6cfRqrxP8Y9K4e67KDMM5mWA7zWDotMav83g70KvpSL88CQb6mx8PYWhaN1QWfCqKf5i6Wab
        NBg9EDykw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g8Jbo-0001Ya-Np; Fri, 05 Oct 2018 06:29:08 +0000
Date:   Thu, 4 Oct 2018 23:29:08 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Doug Meyer <dmeyer@gigaio.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>
Subject: Re: [PATCH] PCI: Fix Switchtec DMA aliasing quirk dmesg noise
Message-ID: <20181005062908.GA4698@infradead.org>
References: <20181004232459.3421-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181004232459.3421-1-logang@deltatee.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> +SWITCHTEC_QUIRK(0x8531);  //PFX 24xG3

Please use /* * style comments.
