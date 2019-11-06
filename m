Return-Path: <SRS0=bI25=Y6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0964C5DF64
	for <linux-pci@archiver.kernel.org>; Wed,  6 Nov 2019 18:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BEB32067B
	for <linux-pci@archiver.kernel.org>; Wed,  6 Nov 2019 18:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573063594;
	bh=dxOfDvU9MfAIucNSSmVGWkPofrzIf403hbq1yjzm/Rs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0p40hCdQZ+wTbKiRnj58FgKjshrRogqAxxrg553dA7WBoM9bthw3OVQ8ScX2aNtwh
	 nf4BK3ht2vqyXCtSR5ncldsHXPJBkNFUAWv/dKUBiP8hutgP2o3fkB0DVGFMkLIOhB
	 cOXcjJJZy+LTZXaZEOwnbP7MTc8S2sxP3WBTTq8Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfKFSGe (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 6 Nov 2019 13:06:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:56504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726616AbfKFSGd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 Nov 2019 13:06:33 -0500
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA63E217D7;
        Wed,  6 Nov 2019 18:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573063593;
        bh=dxOfDvU9MfAIucNSSmVGWkPofrzIf403hbq1yjzm/Rs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SOJFh/wr/SWR1aesR2LzHLuCftrP6Rfve9N2ylWuJTAGOQtxCehXklbdk9sFr7jIz
         ME3UZmDIUiLtbJ1FDjl9Jtlf6/jiYpHXUe+lG2usmd1EdIs2W8qxM4OOGM3CrlIPfI
         sDQkfdmTWEoMXBaEvR1fCfXBae52b6nGMTFj7Wxw=
Date:   Thu, 7 Nov 2019 03:06:30 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/3] PCI: vmd: Align IRQ lists with child device vectors
Message-ID: <20191106180630.GC29853@redsun51.ssa.fujisawa.hgst.com>
References: <1573040408-3831-1-git-send-email-jonathan.derrick@intel.com>
 <1573040408-3831-3-git-send-email-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573040408-3831-3-git-send-email-jonathan.derrick@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 06, 2019 at 04:40:07AM -0700, Jon Derrick wrote:
> In order to provide better affinity alignment along the entire storage
> stack, VMD IRQ lists can be assigned to in a manner where the underlying
> IRQ can be affinitized the same as the child (NVMe) device.
> 
> This patch changes the assignment of child device vectors in IRQ lists
> from a round-robin strategy to a matching-entry strategy. NVMe
> affinities are deterministic in a VMD domain when these devices have the
> same vector count as limited by the VMD MSI domain or cpu count. When
> one or more child devices are attached on a VMD domain, this patch
> aligns the NVMe submission-side affinity with the VMD completion-side
> affinity as it completes through the VMD IRQ list.

This really only works if the child devices have the same irq count as
the vmd device. If the vmd device has more interrupts than the child
devices, this will end up overloading the lower vmd interrupts without
even using the higher ones.
