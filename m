Return-Path: <SRS0=IRPw=OW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D80EC65BAE
	for <linux-pci@archiver.kernel.org>; Thu, 13 Dec 2018 20:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12FB720851
	for <linux-pci@archiver.kernel.org>; Thu, 13 Dec 2018 20:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="g7tX9SBB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12FB720851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbeLMUI5 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 13 Dec 2018 15:08:57 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48720 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbeLMUI5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Dec 2018 15:08:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7nzAL3z7f4g+9WAy1nKklmAeRlS9+GIAuGoi38nwjWQ=; b=g7tX9SBB2b8bTFwhMc8QesK7W
        IWaBvFhrvd0Y8GDw9rupIq1NE6QoI4+rq989Jn2Fttm274vPwxMije3Xz7xsfBogC2LIlnAE6odAr
        yZLJ/gEvLBb9XAYJU0XUhrRfqvZUv3NVeDpT+d1BbuQ2wMfoflIkYSWQQgnWQpXANXRC5zQj598+A
        JtFdm9lcW0Y5ONEvgdV0rXmPahIWw91QGtnUxZtgO2ea7si9pmSxzumssBHnozhOlXKdQRL2LQifD
        TNLeNmIuvRsRBOTy7QPXI0xXVAbk1YWa3HP4mTW+YcW0phWJs54Q3MH3zGQeMMRHRF0JNi0rqDJML
        LezPQDhGQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gXXHq-0005jQ-8p; Thu, 13 Dec 2018 20:08:46 +0000
Date:   Thu, 13 Dec 2018 12:08:46 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>,
        linux-ia64@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        linux-pci@vger.kernel.org,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Tariq Toukan <tariqt@mellanox.com>
Subject: Re: [RFC] avoid indirect calls for DMA direct mappings v2
Message-ID: <20181213200846.GA21726@infradead.org>
References: <20181207190720.18517-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181207190720.18517-1-hch@lst.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I've pulled v2 with the ia64 into dma-mapping for-next.  This should
give us a little more than a week in linux-next to sort out any
issues.
