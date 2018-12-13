Return-Path: <SRS0=IRPw=OW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32871C67839
	for <linux-pci@archiver.kernel.org>; Thu, 13 Dec 2018 14:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0AEE20870
	for <linux-pci@archiver.kernel.org>; Thu, 13 Dec 2018 14:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YsXPSAlo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0AEE20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbeLMOR6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 13 Dec 2018 09:17:58 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41838 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727618AbeLMOR6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Dec 2018 09:17:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6vwhY13VjviJ/1byR6DWtc/nHp80B+kTdS/xVesDaLc=; b=YsXPSAloHhVnjrTDQBfFc+mK/
        izWe6aoivWOhPqY60UwNpvA9KRdQuVyo2PjUMDYbCvgN0VNBJ5f1T3iR/TkvGxt3A0ozY9ya2FGZ9
        zJbXLrZ297lRfCzBSaqDk64SRsnmJBxJSE57wLZ0k3HTPchAcTEgFITJ06uUMZYMNQiLKl2nqig2b
        rbA+4qi6aICGgNuePfF06AmvTeok/SgJfKiKKVpeQm+PTGgNYeUoksW1eCl594jECsFilbwJK2x8+
        xR3ER/2pczaGnC7u9vO4tiuxAMRD2hzCHJZDJKibVCbz0TSCsKKpPim05JnfnJPoMs4F5RXoEo6Ch
        bvG809crw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gXRoA-0006aS-Ff; Thu, 13 Dec 2018 14:17:46 +0000
Date:   Thu, 13 Dec 2018 06:17:46 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        "kevin.tian@intel.com" <kevin.tian@intel.com>,
        "tnowicki@caviumnetworks.com" <tnowicki@caviumnetworks.com>,
        "mst@redhat.com" <mst@redhat.com>,
        Marc Zyngier <Marc.Zyngier@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        Will Deacon <Will.Deacon@arm.com>,
        Robin Murphy <Robin.Murphy@arm.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "frowand.list@gmail.com" <frowand.list@gmail.com>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v6 0/7] Add virtio-iommu driver
Message-ID: <20181213141746.GA19757@infradead.org>
References: <20181211182104.18241-1-jean-philippe.brucker@arm.com>
 <20181212103545.GV16835@8bytes.org>
 <9110873f-d344-b6b9-c722-9accfc329db2@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9110873f-d344-b6b9-c722-9accfc329db2@arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 13, 2018 at 12:50:29PM +0000, Jean-Philippe Brucker wrote:
> * DMA ops for x86 (see "HACK" commit). I'd like to use dma-iommu but I'm
> not sure how to implement the glue that sets dma_ops properly.

http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-iommu-ops
