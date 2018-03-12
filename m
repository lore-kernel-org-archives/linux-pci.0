Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:32990 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932190AbeCLQo0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Mar 2018 12:44:26 -0400
Subject: Re: [PATCH] dma-mapping: move dma configuration to bus infrastructure
To: Nipun Gupta <nipun.gupta@nxp.com>, hch@lst.de,
        robin.murphy@arm.com, linux@armlinux.org.uk,
        gregkh@linuxfoundation.org, m.szyprowski@samsung.com,
        bhelgaas@google.com
Cc: dmitry.torokhov@gmail.com, rafael.j.wysocki@intel.com,
        jarkko.sakkinen@linux.intel.com, linus.walleij@linaro.org,
        johan@kernel.org, msuchanek@suse.de, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org
References: <1520868292-2479-1-git-send-email-nipun.gupta@nxp.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <6a76df69-8c6c-52a6-0afd-fd0b8d2ff703@codeaurora.org>
Date: Mon, 12 Mar 2018 12:44:22 -0400
MIME-Version: 1.0
In-Reply-To: <1520868292-2479-1-git-send-email-nipun.gupta@nxp.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 3/12/2018 11:24 AM, Nipun Gupta wrote:
> +	if (dma_dev->of_node) {
> +		ret = of_dma_configure(dev, dma_dev->of_node);
> +	} else if (has_acpi_companion(dma_dev)) {
> +		attr = acpi_get_dma_attr(to_acpi_device_node(dma_dev->fwnode));
> +		if (attr != DEV_DMA_NOT_SUPPORTED)
> +			ret = acpi_dma_configure(dev, attr);
> +	}
> +
> +	pci_put_host_bridge_device(bridge);
> +
> +	return ret;
> +}
> +
> +void pci_dma_deconfigure(struct device *dev)
> +{
> +	of_dma_deconfigure(dev);
> +	acpi_dma_deconfigure(dev);
> +}

Isn't this one or the other one but not both?

Something like:

if (dev->of_node)
	of_dma_deconfigure(dev);
else
	acpi_dma_deconfigure(dev);

should work.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
