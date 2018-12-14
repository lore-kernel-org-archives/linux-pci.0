Return-Path: <SRS0=mLR+=OX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF422C43387
	for <linux-pci@archiver.kernel.org>; Fri, 14 Dec 2018 21:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02200208C2
	for <linux-pci@archiver.kernel.org>; Fri, 14 Dec 2018 21:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544822143;
	bh=epMPbSPRuf7RitDOFQKrJneIizjhTYG75QIZawR1XFU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TDwVEJwcfsysdFGp4R8KWURyUFBOKjlUdNKNHEp3+crVzpXVMUVtSRAxtN6GA5h5h
	 rsAeMnZrkd2WPGknF0naUQGwUhcMUx2xKUGy1F+m+/HSjS/nC0bYDQKnXlGFmCOVOh
	 M5E13mI0cWgITHPdqbgzOaydWT82A5iYUevHnxes=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730866AbeLNVPh (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 14 Dec 2018 16:15:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:58438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730734AbeLNVPg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Dec 2018 16:15:36 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D398D2080F;
        Fri, 14 Dec 2018 21:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544822136;
        bh=epMPbSPRuf7RitDOFQKrJneIizjhTYG75QIZawR1XFU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=edjWIx2P68JwTuSuxHs9TnEhNSFkivUorcpjCFv/NctmF5/s1rm/61S7eekHcQRfg
         IeFWqIhBpeC5OrB131LImu6jD/4zBGiWoPo0Ab6nhpUhzs/2QGXAmuYJd/PyRl4ZrZ
         BIZ+ILeg3lX1bq9memQee2kSr/pyn+Wr1qdHPl8U=
Date:   Fri, 14 Dec 2018 15:15:33 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Keith Busch <keith.busch@intel.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        linux-pci@vger.kernel.org, linux-ia64@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/15] ACPI / scan: Refactor _CCA enforcement
Message-ID: <20181214211533.GE20725@google.com>
References: <20181207190720.18517-1-hch@lst.de>
 <20181207190720.18517-14-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181207190720.18517-14-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 07, 2018 at 11:07:18AM -0800, Christoph Hellwig wrote:
> From: Robin Murphy <robin.murphy@arm.com>
> 
> Rather than checking the DMA attribute at each callsite, just pass it
> through for acpi_dma_configure() to handle directly. That can then deal
> with the relatively exceptional DEV_DMA_NOT_SUPPORTED case by explicitly
> installing dummy DMA ops instead of just skipping setup entirely. This
> will then free up the dev->dma_ops == NULL case for some valuable
> fastpath optimisations.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/acpi/scan.c      | 5 +++++
>  drivers/base/platform.c  | 3 +--
>  drivers/pci/pci-driver.c | 3 +--

Acked-by: Bjorn Helgaas <bhelgaas@google.com>	# drivers/pci part

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
> index eae841935a45..c1ddf191711e 100644
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
> index bef17c3fca67..1b58e058b13f 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -1602,8 +1602,7 @@ static int pci_dma_configure(struct device *dev)
>  		struct acpi_device *adev = to_acpi_device_node(bridge->fwnode);
>  		enum dev_dma_attr attr = acpi_get_dma_attr(adev);
>  
> -		if (attr != DEV_DMA_NOT_SUPPORTED)
> -			ret = acpi_dma_configure(dev, attr);
> +		ret = acpi_dma_configure(dev, acpi_get_dma_attr(adev));
>  	}
>  
>  	pci_put_host_bridge_device(bridge);
> -- 
> 2.19.1
> 
