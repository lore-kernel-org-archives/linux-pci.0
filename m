Return-Path: <SRS0=JAmU=TD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA2D6C43219
	for <linux-pci@archiver.kernel.org>; Fri,  3 May 2019 15:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8622C2075C
	for <linux-pci@archiver.kernel.org>; Fri,  3 May 2019 15:53:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbfECPxO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 3 May 2019 11:53:14 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36020 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728246AbfECPxO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 3 May 2019 11:53:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 28935374;
        Fri,  3 May 2019 08:53:14 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2300B3F557;
        Fri,  3 May 2019 08:53:11 -0700 (PDT)
Date:   Fri, 3 May 2019 16:53:06 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Srinath Mannam <srinath.mannam@broadcom.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Eric Auger <eric.auger@redhat.com>, poza@codeaurora.org,
        Ray Jui <rjui@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/3] PCIe Host request to reserve IOVA
Message-ID: <20190503155306.GA6461@e121166-lin.cambridge.arm.com>
References: <1556892334-16270-1-git-send-email-srinath.mannam@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556892334-16270-1-git-send-email-srinath.mannam@broadcom.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 03, 2019 at 07:35:31PM +0530, Srinath Mannam wrote:
> This patch set will reserve IOVA addresses for DMA memory holes.
> 
> The IPROC host controller allows only a few ranges of physical address
> as inbound PCI addresses which are listed through dma-ranges DT property.
> Added dma_ranges list field of PCI host bridge structure to hold these
> allowed inbound address ranges in sorted order.
> 
> Process this list and reserve IOVA addresses that are not present in its
> resource entries (ie DMA memory holes) to prevent allocating IOVA
> addresses that cannot be allocated as inbound addresses.
> 
> This patch set is based on Linux-5.1-rc3.
> 
> Changes from v5:
>   - Addressed Robin Murphy, Lorenzo review comments.
>     - Error handling in dma ranges list processing.
>     - Used commit messages given by Lorenzo to all patches.
> 
> Changes from v4:
>   - Addressed Bjorn, Robin Murphy and Auger Eric review comments.
>     - Commit message modification.
>     - Change DMA_BIT_MASK to "~(dma_addr_t)0".
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
>  drivers/iommu/dma-iommu.c           | 35 ++++++++++++++++++++++++++---
>  drivers/pci/controller/pcie-iproc.c | 44 ++++++++++++++++++++++++++++++++++++-
>  drivers/pci/probe.c                 |  3 +++
>  include/linux/pci.h                 |  1 +
>  4 files changed, 79 insertions(+), 4 deletions(-)

I have applied the series to pci/iova-dma-ranges, targeting v5.2,
thanks.

Lorenzo
