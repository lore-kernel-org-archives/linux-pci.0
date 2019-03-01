Return-Path: <SRS0=yUVM=RE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B87C10F03
	for <linux-pci@archiver.kernel.org>; Fri,  1 Mar 2019 11:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52FCB20851
	for <linux-pci@archiver.kernel.org>; Fri,  1 Mar 2019 11:30:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731937AbfCALad (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 1 Mar 2019 06:30:33 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33444 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbfCALad (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 Mar 2019 06:30:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F9BEEBD;
        Fri,  1 Mar 2019 03:30:33 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0BCAD3F5C1;
        Fri,  1 Mar 2019 03:30:30 -0800 (PST)
Date:   Fri, 1 Mar 2019 11:30:26 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     honghui.zhang@mediatek.com
Cc:     bhelgaas@google.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryder.lee@mediatek.com,
        rafael.j.wysocki@intel.com, fred@fredlawl.com, poza@codeaurora.org,
        youlin.pei@mediatek.com, jianjun.wang@mediatek.com
Subject: Re: [PATCH v3 0/2] PCI: mediatek: enable whole MMIO range and
 enlarge the PCIe2AHB window size
Message-ID: <20190301113026.GA17669@e107981-ln.cambridge.arm.com>
References: <1548999367-11733-1-git-send-email-honghui.zhang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548999367-11733-1-git-send-email-honghui.zhang@mediatek.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 01, 2019 at 01:36:05PM +0800, honghui.zhang@mediatek.com wrote:
> From: Honghui Zhang <honghui.zhang@mediatek.com>
> 
> Two patches:
> patch 1 enable whole MMIO range which also fix the complain of scripts/coccinelle/api/resource_size.cocci
> patch 2 enlarge the PCIe2AHB window size to support fully access of 4GB DRAM from EP DMA.
> 
> v3:
>  - update the changlog title for patch1 and update commit message following Bjorn's suggestion
>  - move the "|" into the previous line.
> 
> v2:
>  - Fix the checkpatch complains for patch 1.
>  - update the commit message and change title of patch 1 for changelog conventions.
>  - Add patch 2.
> 
> Honghui Zhang (2):
>   PCI: mediatek: Enable the whole memory mapped IO range
>   PCI: mediatek: Enlarge PCIe2AHB window size to support 4GB DRAM
> 
>  drivers/pci/controller/pcie-mediatek.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)

I have basically rewritten the commit logs and applied the
patches to pci/mediatek for v5.1 (pending testing), please
have a look.

Lorenzo
