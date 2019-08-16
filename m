Return-Path: <SRS0=QF+3=WM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 774A1C3A59E
	for <linux-pci@archiver.kernel.org>; Fri, 16 Aug 2019 13:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F87F2171F
	for <linux-pci@archiver.kernel.org>; Fri, 16 Aug 2019 13:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbfHPNiU (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 16 Aug 2019 09:38:20 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:55400 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727327AbfHPNiU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Aug 2019 09:38:20 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 55B5125AD7E;
        Fri, 16 Aug 2019 23:38:18 +1000 (AEST)
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 51F7D94057D; Fri, 16 Aug 2019 15:38:16 +0200 (CEST)
Date:   Fri, 16 Aug 2019 15:38:16 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Marek Vasut <marek.vasut@gmail.com>
Cc:     linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH V3 2/3] PCI: rcar: Do not abort on too many inbound
 dma-ranges
Message-ID: <20190816133816.4l463artoaswknj2@verge.net.au>
References: <20190809175741.7066-1-marek.vasut@gmail.com>
 <20190809175741.7066-2-marek.vasut@gmail.com>
 <20190816132305.gyyml5r3xsimmoor@verge.net.au>
 <8f1871ed-4820-1985-0090-bb9e2d8803d8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f1871ed-4820-1985-0090-bb9e2d8803d8@gmail.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 16, 2019 at 03:28:04PM +0200, Marek Vasut wrote:
> On 8/16/19 3:23 PM, Simon Horman wrote:
> > On Fri, Aug 09, 2019 at 07:57:40PM +0200, marek.vasut@gmail.com wrote:
> >> From: Marek Vasut <marek.vasut+renesas@gmail.com>
> >>
> >> In case the "dma-ranges" DT property contains either too many ranges
> >> or the range start address is unaligned in such a way that populating
> >> the range into the controller requires multiple entries, a situation
> >> may occur where all ranges cannot be loaded into the controller.
> >>
> >> Currently, the driver refuses to probe in such a situation. Relax this
> >> behavior, load as many ranges as possible and warn if some ranges do
> >> not fit anymore.
> > 
> > What is the motivation for relaxing this?
> 
> U-Boot can fill the ranges in properly now, the list would be longer in
> such a case and the driver would fail to probe (because the list is
> longer than what the hardware can support).

Thanks, I think that would be worth adding to the changelog.

Regardless,

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

