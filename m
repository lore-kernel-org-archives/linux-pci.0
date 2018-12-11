Return-Path: <SRS0=NFOj=OU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C6C1C07E85
	for <linux-pci@archiver.kernel.org>; Tue, 11 Dec 2018 06:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1DD92082F
	for <linux-pci@archiver.kernel.org>; Tue, 11 Dec 2018 06:51:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1DD92082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbeLKGvO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 11 Dec 2018 01:51:14 -0500
Received: from verein.lst.de ([213.95.11.211]:53407 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725923AbeLKGvO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 11 Dec 2018 01:51:14 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 57EC368DD2; Tue, 11 Dec 2018 07:51:12 +0100 (CET)
Date:   Tue, 11 Dec 2018 07:51:12 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Keith Busch <keith.busch@intel.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        linux-pci@vger.kernel.org, linux-ia64@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] avoid indirect calls for DMA direct mappings v2
Message-ID: <20181211065112.GA13668@lst.de>
References: <20181207190720.18517-1-hch@lst.de> <20181210215113.GA22180@agluck-desk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181210215113.GA22180@agluck-desk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 10, 2018 at 01:51:13PM -0800, Luck, Tony wrote:
> But the ia64 build fails with:

Yes, I just got the same complaint form the buildbot, unfortunately
I don't have a good ia64 cross compiler locally given that Debian
is lacking one, and the one provided by the buildbot doesn't build on
Debian either..

This should fix it:

diff --git a/arch/ia64/mm/init.c b/arch/ia64/mm/init.c
index 2c51733f1dfd..a007afaa556c 100644
--- a/arch/ia64/mm/init.c
+++ b/arch/ia64/mm/init.c
@@ -8,6 +8,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 
+#include <linux/dma-noncoherent.h>
 #include <linux/efi.h>
 #include <linux/elf.h>
 #include <linux/memblock.h>
