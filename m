Return-Path: <SRS0=yvM8=O5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9040C43387
	for <linux-pci@archiver.kernel.org>; Thu, 20 Dec 2018 15:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1BEB2186A
	for <linux-pci@archiver.kernel.org>; Thu, 20 Dec 2018 15:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545318536;
	bh=u7C8+QJIgZn2KTlrtx/D76/p3INt0xn1OcrxfyZdLh4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Fsw1T8H+px5d9oh1cLHIPSlQElqIwRArL0CrQEEeIJEgiEUV0ZN6yM6EeaPk27fXn
	 +t4sSEMy2VDpir3hEXUPDNPadRL+TDWe0OylA7oBNqjUvtw4GLGPmeborg8X4pfrAq
	 sBD2KCyI1PIlcsJQ3ZOCb6MaYQq3RI3dn04+hbyo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730536AbeLTPIv (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 20 Dec 2018 10:08:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:45426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729339AbeLTPIv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Dec 2018 10:08:51 -0500
Received: from localhost (173-25-171-118.client.mchsi.com [173.25.171.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 113FE21720;
        Thu, 20 Dec 2018 15:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545318530;
        bh=u7C8+QJIgZn2KTlrtx/D76/p3INt0xn1OcrxfyZdLh4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t3lTejcIcSe52bezwm4dS/kKRDpfBUNXZY6ndRj4ppLrkT9ALXnNvD43FijXONCt3
         tTs+i8Pg0gpjtu5zXPli1Jaj1UTlI2SWdHQBtyOZ1CVTtp/S/d266a21gtj67vwQaS
         bcwSEJtnaJLctE1ybZDPd0uUJTIeu+zwNJ/tmerA=
Date:   Thu, 20 Dec 2018 09:08:48 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     hch@lst.de, linux-pci@vger.kernel.org, catalin.marinas@arm.com,
        rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        will.deacon@arm.com, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org, gregkh@linuxfoundation.org,
        lenb@kernel.org, linux-arm-kernel@lists.infradead.org,
        m.szyprowski@samsung.com
Subject: Re: [PATCH 2/2] ACPI / scan: Refactor _CCA enforcement
Message-ID: <20181220150848.GA183878@google.com>
References: <cover.1544199754.git.robin.murphy@arm.com>
 <fe956f04bfe7f8293f6205ee224b087046e40a91.1544199754.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe956f04bfe7f8293f6205ee224b087046e40a91.1544199754.git.robin.murphy@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 07, 2018 at 04:31:35PM +0000, Robin Murphy wrote:
> Rather than checking the DMA attribute at each callsite, just pass it
> through for acpi_dma_configure() to handle directly. That can then deal
> with the relatively exceptional DEV_DMA_NOT_SUPPORTED case by explicitly
> installing dummy DMA ops instead of just skipping setup entirely. This
> will then free up the dev->dma_ops == NULL case for some valuable
> fastpath optimisations.
> 
> CC: Rafael J. Wysocki <rjw@rjwysocki.net>
> CC: Len Brown <lenb@kernel.org>
> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> CC: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

FWIW, if this hasn't been applied already (I think you targeted a DMA
tree):

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/acpi/scan.c      | 5 +++++
>  drivers/base/platform.c  | 3 +--
>  drivers/pci/pci-driver.c | 3 +--
>  3 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index bd1c59fb0e17..b75ae34ed188 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1456,6 +1456,11 @@ int acpi_dma_configure(struct device *dev, enum dev_dma_attr attr)
>  	const struct iommu_ops *iommu;
>  	u64 dma_addr = 0, size = 0;
>  
> +	if (attr == DEV_DMA_NOT_SUPPORTED) {
> +		set_dma_ops(dev, &dma_dummy_ops);
> +		return 0;
> +	}
> +
>  	iort_dma_setup(dev, &dma_addr, &size);
>  
>  	iommu = iort_iommu_configure(dev);
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 41b91af95afb..c6daca875c17 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -1138,8 +1138,7 @@ int platform_dma_configure(struct device *dev)
>  		ret = of_dma_configure(dev, dev->of_node, true);
>  	} else if (has_acpi_companion(dev)) {
>  		attr = acpi_get_dma_attr(to_acpi_device_node(dev->fwnode));
> -		if (attr != DEV_DMA_NOT_SUPPORTED)
> -			ret = acpi_dma_configure(dev, attr);
> +		ret = acpi_dma_configure(dev, attr);
>  	}
>  
>  	return ret;
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index bef17c3fca67..f899a28b90f8 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -1602,8 +1602,7 @@ static int pci_dma_configure(struct device *dev)
>  		struct acpi_device *adev = to_acpi_device_node(bridge->fwnode);
>  		enum dev_dma_attr attr = acpi_get_dma_attr(adev);
>  
> -		if (attr != DEV_DMA_NOT_SUPPORTED)
> -			ret = acpi_dma_configure(dev, attr);
> +		ret = acpi_dma_configure(dev, attr);
>  	}
>  
>  	pci_put_host_bridge_device(bridge);
> -- 
> 2.19.1.dirty
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
