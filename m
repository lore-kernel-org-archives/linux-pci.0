Return-Path: <SRS0=6A7A=Q3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5EDC43381
	for <linux-pci@archiver.kernel.org>; Wed, 20 Feb 2019 15:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FD2B2086A
	for <linux-pci@archiver.kernel.org>; Wed, 20 Feb 2019 15:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbfBTPU6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 20 Feb 2019 10:20:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:57006 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725804AbfBTPU5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 Feb 2019 10:20:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4BA7BAF8F;
        Wed, 20 Feb 2019 15:20:56 +0000 (UTC)
Date:   Wed, 20 Feb 2019 16:20:53 +0100
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 6/7] MIPS: SGI-IP27: use generic PCI driver
Message-Id: <20190220162053.abe9ffde0f6d347a281bbe49@suse.de>
In-Reply-To: <20190220151056.GA29614@infradead.org>
References: <20190124174728.28812-1-tbogendoerfer@suse.de>
        <20190124174728.28812-7-tbogendoerfer@suse.de>
        <20190128133215.GC744@infradead.org>
        <20190218115807.1a683d2c6824acd4ea78eb11@suse.de>
        <20190220151056.GA29614@infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 20 Feb 2019 07:10:56 -0800
Christoph Hellwig <hch@infradead.org> wrote:

> On Mon, Feb 18, 2019 at 11:58:07AM +0100, Thomas Bogendoerfer wrote:
> > This of course will break SH7786. To fix both cases how about making dma_pfn_offset
> >
> > a signed long ?
> 
> Yes, making it signed sounds like a good idea.

but at least my implementation looks a little bit ugly:

diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
index b7338702592a..b72b1cba8911 100644
--- a/include/linux/dma-direct.h
+++ b/include/linux/dma-direct.h
@@ -12,14 +12,20 @@ static inline dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr)
 {
        dma_addr_t dev_addr = (dma_addr_t)paddr;
 
-       return dev_addr - ((dma_addr_t)dev->dma_pfn_offset << PAGE_SHIFT);
+       if (dev->dma_pfn_offset > 0)
+               return dev_addr + ((dma_addr_t)dev->dma_pfn_offset << PAGE_SHIFT);
+
+       return dev_addr - ((dma_addr_t)-dev->dma_pfn_offset << PAGE_SHIFT);
 }
 
 static inline phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t dev_addr)
 {
        phys_addr_t paddr = (phys_addr_t)dev_addr;
 
-       return paddr + ((phys_addr_t)dev->dma_pfn_offset << PAGE_SHIFT);
+       if (dev->dma_pfn_offset > 0)
+               return paddr - ((phys_addr_t)dev->dma_pfn_offset << PAGE_SHIFT);
+
+       return paddr + ((phys_addr_t)-dev->dma_pfn_offset << PAGE_SHIFT);
 }
 
 static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)



For the v2 version of the IP27 rework I've used the mach-XXX include structure
of the MIPS tree to implement __phy_to_dma/__dma_to_phys for IP27. I'd prefer
it that way.

Thomas.

-- 
SUSE Linux GmbH
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
