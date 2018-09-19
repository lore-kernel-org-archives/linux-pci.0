Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:53933 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731179AbeISUPK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Sep 2018 16:15:10 -0400
Date: Wed, 19 Sep 2018 16:37:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jim Quinlan <jim2101024@gmail.com>
Cc: linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Burton <paul.burton@mips.com>,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v5 10/12] ARM64: declare __phys_to_dma on
 ARCH_HAS_PHYS_TO_DMA
Message-ID: <20180919143700.GA29096@lst.de>
References: <1537367527-20773-1-git-send-email-jim2101024@gmail.com> <1537367527-20773-11-git-send-email-jim2101024@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1537367527-20773-11-git-send-email-jim2101024@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is useless on its own.  Please merge it into whatever patch
selects ARCH_HAS_PHYS_TO_DMA and actually implements the functions.
