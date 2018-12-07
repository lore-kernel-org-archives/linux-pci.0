Return-Path: <SRS0=SqGm=OQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95AC6C07E85
	for <linux-pci@archiver.kernel.org>; Fri,  7 Dec 2018 19:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E24A2083D
	for <linux-pci@archiver.kernel.org>; Fri,  7 Dec 2018 19:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pLLm5Fy0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E24A2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbeLGTHk (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 7 Dec 2018 14:07:40 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48284 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbeLGTHk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Dec 2018 14:07:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SzjGjFo6eCmae/ZCig3ght1FUR+8zrQ2bs45B5ePvs4=; b=pLLm5Fy04HyA+9kH9tAUbeHln
        pFj4vAtpALOSQTXFKSqOm14FCLSrd9pUOvhLAAKUiKk990f13IUgd6/KC3C2+lYwbMwfbj1yTRXdT
        4TpPMKBMuwgI9wLZ/yKtT0CQUj3ItBB3ATxuBpvcmRgr8QITWNjmauBGEugh6a0lc7JmDewPQUE/f
        kTLlmToyuVnHWx1dk5712lESVuZmTQeVTWVh2Py+OIaRg5qVHc8c3S9+1dvcCeDrLUi8RRM86x3J7
        YOmn434KsPTvJNNFs2tS5QfQX31WuLxShjWMU0E4f7iqLvnMj+RFeEzqQEQ6CHBdPheoe7HNC1bIY
        NGoHy4aCQ==;
Received: from [199.255.44.128] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gVLTD-0006cf-Fi; Fri, 07 Dec 2018 19:07:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     Tariq Toukan <tariqt@mellanox.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Keith Busch <keith.busch@intel.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        linux-pci@vger.kernel.org, linux-ia64@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC] avoid indirect calls for DMA direct mappings v2
Date:   Fri,  7 Dec 2018 11:07:05 -0800
Message-Id: <20181207190720.18517-1-hch@lst.de>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi all,

a while ago Jesper reported major performance regressions due to the
spectre v2 mitigations in his XDP forwarding workloads.  A large part
of that is due to the DMA mapping API indirect calls.

It turns out that the most common implementation of the DMA API is the
direct mapping case, and now that we have merged almost all duplicate
implementations of that into a single generic one is easily feasily to
direct calls for this fast path.

This series adds consolidate the DMA mapping code by merging the
swiotlb case into the dma direct case, and then treats NULL dma_ops
as an indicator that that we should directly call the direct mapping
case.  This recovers a large part of the retpoline induces XDP slowdown.

This works is based on the dma-mapping tree, so you probably want to
want this git tree for testing:

    git://git.infradead.org/users/hch/misc.git dma-direct-calls.2

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-direct-calls.2

Changes since v1:
 - now also includes all the prep patches relative to the dma-mapping
   for-next tree
 - move various slow path functions out of line
 - use a NULL dma ops as the indicate to use the direct mapping path
 - remove dma_direct_ops now that we always call it without the indirection
 - move the dummy dma ops to common code
 - explicitly st the dummy dma ops for devices that are indicates as not
   DMA capable by firmware
