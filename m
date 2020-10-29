Return-Path: <SRS0=7A2k=EE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 543BBC4363A
	for <linux-pci@archiver.kernel.org>; Thu, 29 Oct 2020 15:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0983020732
	for <linux-pci@archiver.kernel.org>; Thu, 29 Oct 2020 15:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbgJ2P7W (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 29 Oct 2020 11:59:22 -0400
Received: from verein.lst.de ([213.95.11.211]:49371 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727290AbgJ2P7W (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Oct 2020 11:59:22 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7DE1567373; Thu, 29 Oct 2020 16:59:18 +0100 (CET)
Date:   Thu, 29 Oct 2020 16:59:18 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Jim Quinlan <james.quinlan@broadcom.com>,
        Christoph Hellwig <hch@lst.de>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-mapping: Fix 32-bit overflow with CONFIG_ARM_LPAE=n
Message-ID: <20201029155918.GA23872@lst.de>
References: <20201026152755.3738293-1-geert+renesas@glider.be> <20201027075551.GB22487@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027075551.GB22487@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 27, 2020 at 08:55:51AM +0100, Christoph Hellwig wrote:
> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> Rob and Frank: do you want to take this through the OF tree, or should
> I queue it up in the dma-mapping tree that caused the problem?

I've picked this up in the dma-mapping tree so that we don't miss
rc2.
