Return-Path: <SRS0=OdYA=3L=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79292C2D0DB
	for <linux-pci@archiver.kernel.org>; Wed, 22 Jan 2020 16:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C7702465B
	for <linux-pci@archiver.kernel.org>; Wed, 22 Jan 2020 16:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579712183;
	bh=g8BjkDQDC30b7DKasbB08kfebxsj4k8XiUA4G5pHC3Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nb6t8imPzmV7/lcJMa1yAm+XRf+YWUzFi81dEPa1KmCmN7t/RLcEtm1rw/Ova4I0X
	 nx3hyy6NdM1AlgPYhB3xhD+VjA21yfY4MelORP7IJ6+rmpbTYU820fwhTfkt3bn/vh
	 cGL21d0jXJ4jAF/6L3kjlfvwrfCgd27AAjxMQ4xg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbgAVQ4W (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 22 Jan 2020 11:56:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:38632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbgAVQ4W (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 22 Jan 2020 11:56:22 -0500
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B76B321569;
        Wed, 22 Jan 2020 16:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579712182;
        bh=g8BjkDQDC30b7DKasbB08kfebxsj4k8XiUA4G5pHC3Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nnUW1fE8OXhV0av6FW7Ow9kKcf4rGHzbm2nyMgYOAOoFNHDrocAndE7jh9EWr2pdq
         G7lAonmVT+Xcl2y6Xx3nAUPTtkzkTRAXR3Lo6T9y70nMvTXREebvRWAXVImSYLco9n
         sK9xUHar2FrV7OiW65Ci0MZrmrWTvjts6avXClt4=
Date:   Thu, 23 Jan 2020 01:56:14 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        iommu@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v5 6/7] PCI: vmd: Stop overriding dma_map_ops
Message-ID: <20200122165614.GA6571@redsun51.ssa.fujisawa.hgst.com>
References: <1579613871-301529-1-git-send-email-jonathan.derrick@intel.com>
 <1579613871-301529-7-git-send-email-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579613871-301529-7-git-send-email-jonathan.derrick@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 21, 2020 at 06:37:50AM -0700, Jon Derrick wrote:
> Devices on the VMD domain use the VMD endpoint's requester ID and have
> been relying on the VMD endpoint's DMA operations. The problem with this
> was that VMD domain devices would use the VMD endpoint's attributes when
> doing DMA and IOMMU mapping. We can be smarter about this by only using
> the VMD endpoint when mapping and providing the correct child device's
> attributes during DMA operations.
> 
> This patch removes the dma_map_ops redirect.
> 
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>
