Return-Path: <SRS0=Hy4z=SU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 196EDC10F14
	for <linux-pci@archiver.kernel.org>; Thu, 18 Apr 2019 23:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB426206B6
	for <linux-pci@archiver.kernel.org>; Thu, 18 Apr 2019 23:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555631312;
	bh=0BYxge2vHiinJrCTJtR2FiPW4myDFCQ17XL1+bP3YXU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pNB6XxIptu/APfxP6oazA1lcdmdaSImZFXQtCbYxC1O8cE0i9RwtfmYrtnx8w6xTE
	 0fUCNb8b34+ulsjv/NvzmZompm5a5f0E/d7524n5KPbD7pQon4JGXSxlgXmcqi1VgQ
	 wMnMBpQI8QUrpy3OwqZOOFhJo1ZJ1w3kwC2uF4kg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbfDRXsc (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 18 Apr 2019 19:48:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:36482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbfDRXsb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 18 Apr 2019 19:48:31 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57DAE2171F;
        Thu, 18 Apr 2019 23:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555631310;
        bh=0BYxge2vHiinJrCTJtR2FiPW4myDFCQ17XL1+bP3YXU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c6uc45bHDbhcK0g052RfmkGM6XiHY0UASZ3UzJLylH7m/T90yErzvBRt4Yvj/z5UR
         V/WvbquJhzkKgEelY+1ROGTjzb7EibKqJ8WxN+b3oc52+KNcsQj/Hl5RqVNf+Ag967
         NmZyJVXnJePilIQgJVinTLnnU1atmSESp0fPfcZM=
Date:   Thu, 18 Apr 2019 18:48:28 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Srinath Mannam <srinath.mannam@broadcom.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        poza@codeaurora.org, Ray Jui <rjui@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Scott Branden <sbranden@broadcom.com>
Subject: Re: [PATCH v4 0/3] PCIe Host request to reserve IOVA
Message-ID: <20190418234828.GG126710@google.com>
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

[+cc Scott]

On Fri, Apr 12, 2019 at 08:43:32AM +0530, Srinath Mannam wrote:
> Few SOCs have limitation that their PCIe host can't allow few inbound
> address ranges. Allowed inbound address ranges are listed in dma-ranges
> DT property and this address ranges are required to do IOVA mapping.
> Remaining address ranges have to be reserved in IOVA mapping.
> 
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

To make progress on this, I think we need an ack from Joerg for the
dma-iommu.c part, an ack from Ray or Scott for the pcie-iproc.c part,
and an ack from Robin for the thing as a whole.

Then I would say Lorenzo should take a look and merge if he approves, since
pcie-iproc.c contains the most changes.

Bjorn
