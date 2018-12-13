Return-Path: <SRS0=IRPw=OW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_MIXED_ES,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2BBBC65BAE
	for <linux-pci@archiver.kernel.org>; Thu, 13 Dec 2018 06:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92C6B20849
	for <linux-pci@archiver.kernel.org>; Thu, 13 Dec 2018 06:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ooLZruVn";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Kef/stNH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92C6B20849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbeLMGDd (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 13 Dec 2018 01:03:33 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:50222 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbeLMGDd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Dec 2018 01:03:33 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id F0B566074E; Thu, 13 Dec 2018 06:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544681012;
        bh=ioJxneB0UXSfBeDBCudZ8FHL9u3rcRZ2km24wL+D6CM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ooLZruVn/MEJj0KIzDa3wqtjYNwTmxdD/yJ4291nT42p2TmUuLGsXgdkdjvwVe9CS
         QbAXeNLFcPf2DOeqdJxPvqNUan+3C2m2hoCHpTWNhqAQEig4k9urXqGlJv0elyymg6
         GwGxoeaC3KIWtoUeQa+LB/89Y0cxd7QGQnaSSrN0=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id C149F602F8;
        Thu, 13 Dec 2018 06:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544681011;
        bh=ioJxneB0UXSfBeDBCudZ8FHL9u3rcRZ2km24wL+D6CM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Kef/stNHn7enrtHNp+Z+7DY99DqFRAH2Yj7nkUQZl8iBdLLFho8QMwOwosebz1NeX
         /06is/vRxv7djnyZR/5GE1uiezc6iQkBrws7bDz6lm7h59btAWbCq6EhgIrhK1/180
         xYTOlAMY3tL1gHm5BcC1YhBc0/t4iFWt+N/rEqyQ=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 13 Dec 2018 11:33:31 +0530
From:   poza@codeaurora.org
To:     Srinath Mannam <srinath.mannam@broadcom.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-pci-owner@vger.kernel.org
Subject: Re: [RFC PATCH 3/3] PCI: iproc: Add dma reserve resources to host
In-Reply-To: <1544593569-8923-4-git-send-email-srinath.mannam@broadcom.com>
References: <1544593569-8923-1-git-send-email-srinath.mannam@broadcom.com>
 <1544593569-8923-4-git-send-email-srinath.mannam@broadcom.com>
Message-ID: <117bb87c4567d14f189642b685dd8813@codeaurora.org>
X-Sender: poza@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2018-12-12 11:16, Srinath Mannam wrote:
> IPROC host has the limitation that it can use
> only those address ranges given by dma-ranges
> property as inbound address.
> So that the memory address holes in dma-ranges
> should be reserved to allocate as DMA address.
> 
> All such reserved addresses are created as resource
> entries and add to dma_resv list of pci host bridge.
> 
> These dma reserve resources created by parsing
> dma-ranges parameter.
> 
> Ex:
> dma-ranges = < \
>   0x43000000 0x00 0x80000000 0x00 0x80000000 0x00 0x80000000 \
>   0x43000000 0x08 0x00000000 0x08 0x00000000 0x08 0x00000000 \
>   0x43000000 0x80 0x00000000 0x80 0x00000000 0x40 0x00000000>
> 
> In the above example of dma-ranges, memory address from
> 0x0 - 0x80000000,
> 0x100000000 - 0x800000000,
> 0x1000000000 - 0x8000000000 and
> 0x10000000000 - 0xffffffffffffffff.
> are not allowed to use as inbound addresses.
> So that we need to add these address range to dma_resv
> list to reserve their IOVA address ranges.
> 
> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> ---
>  drivers/pci/controller/pcie-iproc.c | 49 
> +++++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-iproc.c
> b/drivers/pci/controller/pcie-iproc.c
> index 3160e93..43e465a 100644
> --- a/drivers/pci/controller/pcie-iproc.c
> +++ b/drivers/pci/controller/pcie-iproc.c
> @@ -1154,25 +1154,74 @@ static int iproc_pcie_setup_ib(struct 
> iproc_pcie *pcie,
>  	return ret;
>  }
> 
> +static int
> +iproc_pcie_add_dma_resv_range(struct device *dev, struct list_head 
> *resources,
> +			      uint64_t start, uint64_t end)
> +{
> +	struct resource *res;
> +
> +	res = devm_kzalloc(dev, sizeof(struct resource), GFP_KERNEL);
> +	if (!res)
> +		return -ENOMEM;
> +
> +	res->start = (resource_size_t)start;
> +	res->end = (resource_size_t)end;
> +	pci_add_resource_offset(resources, res, 0);
> +
> +	return 0;
> +}
> +
>  static int iproc_pcie_map_dma_ranges(struct iproc_pcie *pcie)
>  {
> +	struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
>  	struct of_pci_range range;
>  	struct of_pci_range_parser parser;
>  	int ret;
> +	uint64_t start, end;
> +	LIST_HEAD(resources);
> 
>  	/* Get the dma-ranges from DT */
>  	ret = of_pci_dma_range_parser_init(&parser, pcie->dev->of_node);
>  	if (ret)
>  		return ret;
> 
> +	start = 0;
>  	for_each_of_pci_range(&parser, &range) {
> +		end = range.pci_addr;
> +		/* dma-ranges list expected in sorted order */
> +		if (end < start) {
> +			ret = -EINVAL;
> +			goto out;
> +		}
>  		/* Each range entry corresponds to an inbound mapping region */
>  		ret = iproc_pcie_setup_ib(pcie, &range, IPROC_PCIE_IB_MAP_MEM);
>  		if (ret)
>  			return ret;
> +
> +		if (end - start) {
> +			ret = iproc_pcie_add_dma_resv_range(pcie->dev,
> +							    &resources,
> +							    start, end);
> +			if (ret)
> +				goto out;
> +		}
> +		start = range.pci_addr + range.size;
>  	}
> 
> +	end = ~0;
Hi Srinath,

this series is based on following patch sets.

https://lkml.org/lkml/2017/5/16/19
https://lkml.org/lkml/2017/5/16/23
https://lkml.org/lkml/2017/5/16/21,

some comments to be adapted from the patch-set I did.

end = ~0;
you should consider DMA_MASK, to see iproc controller is in 32 bit or 64 
bit system.
please check following code snippet.

if (tmp_dma_addr < DMA_BIT_MASK(sizeof(dma_addr_t) * 8)) {
+			lo = iova_pfn(iovad, tmp_dma_addr);
+			hi = iova_pfn(iovad,
+				      DMA_BIT_MASK(sizeof(dma_addr_t) * 8) - 1);
+			reserve_iova(iovad, lo, hi);
+		}

Also if this controller is integrated to 64bit platform, but decide to 
restrict DMA to 32 bit for some reason, the code should address such 
scenarios.
so it is always safe to do

#define BITS_PER_BYTE 8
DMA_BIT_MASK(sizeof(dma_addr_t) * BITS_PER_BYTE)
so please use kernle macro to find the end of DMA region.


Also ideally according to SBSA v5

8.3 PCI Express device view of memory

Transactions from a PCI express device will either directly address the 
memory system of the base server system
or be presented to a SMMU for optional address translation and 
permission policing.
In systems that are compatible with level 3 or above of the SBSA, the 
addresses sent by PCI express devices
must be presented to the memory system or SMMU unmodified. In a system 
where the PCI express does not use
an SMMU, the PCI express devices have the same view of physical memory 
as the PEs. In a system with a
SMMU for PCI express there are no transformations to addresses being 
sent by PCI express devices before they
are presented as an input address to the SMMU.

which is a limitation of iproc controller, please list the limitation in 
detail as it violates SBSA.

Regards,
Oza.

> +	if (end - start) {
> +		ret = iproc_pcie_add_dma_resv_range(pcie->dev, &resources,
> +						    start, end);
> +		if (ret)
> +			goto out;
> +	}
> +
> +	list_splice_init(&resources, &host->dma_resv);
> +
>  	return 0;
> +out:
> +	pci_free_resource_list(&resources);
> +	return ret;
>  }
> 
>  static int iproce_pcie_get_msi(struct iproc_pcie *pcie,





