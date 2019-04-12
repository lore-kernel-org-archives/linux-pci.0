Return-Path: <SRS0=vi1x=SO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DADECC10F0E
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 22:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B2D02086D
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 22:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555108453;
	bh=O5U3eSLMuJ3jb7KoqaCOHpaX1Y5XwTwPpbqkPrMXr2U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zVezAoluBygxa8cEXpIpiepw5tXq05dUXHkTbRZP1ic/urobfEfk5VL5VYFMZ+aJ7
	 xgoa08Ar4YnuvV3cjZhk8g87WPv3GPAW9tS7WokBCt8GoLs/3B5OMyai2hxp8VpROY
	 JjA+M2CZUlOmpzzadxDeG7b3aT621DGcs9s1mweY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbfDLWeM (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 12 Apr 2019 18:34:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:58960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726765AbfDLWeL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Apr 2019 18:34:11 -0400
Received: from localhost (173-25-63-173.client.mchsi.com [173.25.63.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9DBB2073F;
        Fri, 12 Apr 2019 22:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555108451;
        bh=O5U3eSLMuJ3jb7KoqaCOHpaX1Y5XwTwPpbqkPrMXr2U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hf+DnBdtXvFJmGJqqJmNsczr4LLF86JH8RNKYAyIuaUhhlbvjD/yR+nO5d3rs/Fai
         Z7gcpEeXUH/SybJ8d8u4NaPd1YoEBJdVAaciGUpWi4W6Ej7709BTIL7aBU9Sl+aZby
         twkDtms0o9rNLTFZNtySk76+0iFnU8inH+gzkPAU=
Date:   Fri, 12 Apr 2019 17:34:09 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Srinath Mannam <srinath.mannam@broadcom.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        poza@codeaurora.org, Ray Jui <rjui@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] PCIe Host request to reserve IOVA
Message-ID: <20190412223409.GB126710@google.com>
References: <1555038815-31916-1-git-send-email-srinath.mannam@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555038815-31916-1-git-send-email-srinath.mannam@broadcom.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 12, 2019 at 08:43:32AM +0530, Srinath Mannam wrote:
> Few SOCs have limitation that their PCIe host can't allow few inbound
> address ranges. Allowed inbound address ranges are listed in dma-ranges
> DT property and this address ranges are required to do IOVA mapping.
> Remaining address ranges have to be reserved in IOVA mapping.

If I understand correctly, devices below these PCIe host bridges can
DMA only to the listed address ranges, and you prevent devices from
doing DMA to the holes between the listed ranges by reserving the
holes in dma-iommu.

Apparently there's something that makes sure driver dma_map_*() always
goes through dma-iommu?  I traced as far as seeing that dma-iommu
depends on CONFIG_IOMMU_DMA, and that arm64 selects CONFIG_IOMMU_DMA
if CONFIG_IOMMU_SUPPORT, but then the trail got cold.  I didn't see
what selects CONFIG_IOMMU_SUPPORT.

This does look like what Robin suggested, as far as I can tell.
Hopefully he'll take a look and give his reviewed-by.  Thanks for
persevering!

> PCIe Host driver of those SOCs has to list resource entries of allowed
> address ranges given in dma-ranges DT property in sorted order. This
> sorted list of resources will be processed and reserve IOVA address for
> inaccessible address holes while initializing IOMMU domain.
> 
> This patch set is based on Linux-5.0-rc2.
> 
> Changes from v3:
>   - Addressed Robin Murphy review comments.
>     - pcie-iproc: parse dma-ranges and make sorted resource list.
>     - dma-iommu: process list and reserve gaps between entries
> 
> Changes from v2:
>   - Patch set rebased to Linux-5.0-rc2
> 
> Changes from v1:
>   - Addressed Oza review comments.
> 
> Srinath Mannam (3):
>   PCI: Add dma_ranges window list
>   iommu/dma: Reserve IOVA for PCIe inaccessible DMA address
>   PCI: iproc: Add sorted dma ranges resource entries to host bridge
> 
>  drivers/iommu/dma-iommu.c           | 19 ++++++++++++++++
>  drivers/pci/controller/pcie-iproc.c | 44 ++++++++++++++++++++++++++++++++++++-
>  drivers/pci/probe.c                 |  3 +++
>  include/linux/pci.h                 |  1 +
>  4 files changed, 66 insertions(+), 1 deletion(-)
> 
> -- 
> 2.7.4
> 
