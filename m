Return-Path: <SRS0=XVho=CZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E814C43461
	for <linux-pci@archiver.kernel.org>; Wed, 16 Sep 2020 17:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D943206B6
	for <linux-pci@archiver.kernel.org>; Wed, 16 Sep 2020 17:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbgIPRkt (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 16 Sep 2020 13:40:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:56306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727329AbgIPRkk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Sep 2020 13:40:40 -0400
Received: from gaia (unknown [46.69.195.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CE28206A2;
        Wed, 16 Sep 2020 14:51:14 +0000 (UTC)
Date:   Wed, 16 Sep 2020 15:51:11 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        George Cherian <george.cherian@marvell.com>,
        Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v2 3/3] asm-generic/io.h: Fix !CONFIG_GENERIC_IOMAP
 pci_iounmap() implementation
Message-ID: <20200916145111.GB3122@gaia>
References: <20200915093203.16934-1-lorenzo.pieralisi@arm.com>
 <cover.1600254147.git.lorenzo.pieralisi@arm.com>
 <a9daf8d8444d0ebd00bc6d64e336ec49dbb50784.1600254147.git.lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9daf8d8444d0ebd00bc6d64e336ec49dbb50784.1600254147.git.lorenzo.pieralisi@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 16, 2020 at 12:06:58PM +0100, Lorenzo Pieralisi wrote:
> For arches that do not select CONFIG_GENERIC_IOMAP, the current
> pci_iounmap() function does nothing causing obvious memory leaks
> for mapped regions that are backed by MMIO physical space.
> 
> In order to detect if a mapped pointer is IO vs MMIO, a check must made
> available to the pci_iounmap() function so that it can actually detect
> whether the pointer has to be unmapped.
> 
> In configurations where CONFIG_HAS_IOPORT_MAP && !CONFIG_GENERIC_IOMAP,
> a mapped port is detected using an ioport_map() stub defined in
> asm-generic/io.h.
> 
> Use the same logic to implement a stub (ie __pci_ioport_unmap()) that
> detects if the passed in pointer in pci_iounmap() is IO vs MMIO to
> iounmap conditionally and call it in pci_iounmap() fixing the issue.
> 
> Leave __pci_ioport_unmap() as a NOP for all other config options.
> 
> Reported-by: George Cherian <george.cherian@marvell.com>
> Link: https://lore.kernel.org/lkml/20200905024811.74701-1-yangyingliang@huawei.com
> Link: https://lore.kernel.org/lkml/20200824132046.3114383-1-george.cherian@marvell.com
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: George Cherian <george.cherian@marvell.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  include/asm-generic/io.h | 39 +++++++++++++++++++++++++++------------
>  1 file changed, 27 insertions(+), 12 deletions(-)

This works for me. The only question I have is whether pci_iomap.h is
better than io.h for __pci_ioport_unmap(). These headers are really
confusing.

Either way:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
