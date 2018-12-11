Return-Path: <SRS0=NFOj=OU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931FBC5CFFE
	for <linux-pci@archiver.kernel.org>; Tue, 11 Dec 2018 18:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F5052086D
	for <linux-pci@archiver.kernel.org>; Tue, 11 Dec 2018 18:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QcJfMxaK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F5052086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbeLKSbJ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 11 Dec 2018 13:31:09 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57424 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727163AbeLKSbE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Dec 2018 13:31:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LNKXLjHlX/XKCZkV6XvjHi+pcYeLvv1jUV7Qgn1EyX4=; b=QcJfMxaK1ZJgFzmrotE6d+pHw
        uL6Lx3Nb6nMAGuDV6LKaMTPJwutsIqdvp1vKjYLBhDVUm2auKhw1c2bNMb8N8/iH6IIQPfxSJoNAL
        eGVQ1FlvZ6JHLpAwQfIFLz0z+5w442XRk4jnmKf5L4kX7ihsimwC/Mr6owrlWMUqi1OenCQIw/JAv
        zfCHjMYAz+z1PNo3CJKQNd5ERg2B06GocLHb3SM9dNIj5wm3fOV7Y4+qynXY3q6C5rqoPTwCDkTCC
        nRsGGh4WaYtrNBxKc8nfFlIu5f9KKWzPkG+2qCi2AXGQqrXZQ7FubHj4XCol84S6yS0lyex54wWEk
        1MY8Azddw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gWmo9-0001ag-AH; Tue, 11 Dec 2018 18:31:01 +0000
Date:   Tue, 11 Dec 2018 10:31:01 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc:     iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, joro@8bytes.org, mst@redhat.com,
        mark.rutland@arm.com, kevin.tian@intel.com,
        tnowicki@caviumnetworks.com, marc.zyngier@arm.com,
        robin.murphy@arm.com, jasowang@redhat.com, will.deacon@arm.com,
        robh+dt@kernel.org, bhelgaas@google.com, frowand.list@gmail.com,
        kvmarm@lists.cs.columbia.edu
Subject: Re: [PATCH v6 0/7] Add virtio-iommu driver
Message-ID: <20181211183101.GA31936@infradead.org>
References: <20181211182104.18241-1-jean-philippe.brucker@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211182104.18241-1-jean-philippe.brucker@arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 11, 2018 at 06:20:57PM +0000, Jean-Philippe Brucker wrote:
> Implement the virtio-iommu driver, following specification v0.9 [1].
> 
> Only minor changes since v5 [2]. I fixed issues reported by Michael and
> added tags from Eric and Bharat. Thanks!
> 
> You can find Linux driver and kvmtool device on v0.9 branches [3],
> module and x86 support on virtio-iommu/devel. Also tested with Eric's
> QEMU device [4].

Just curious, what is the use case for it?
