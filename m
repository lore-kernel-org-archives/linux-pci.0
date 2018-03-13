Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:56444 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751903AbeCMHeu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Mar 2018 03:34:50 -0400
Date: Tue, 13 Mar 2018 08:34:48 +0100
From: Christoph Hellwig <hch@lst.de>
To: Nipun Gupta <nipun.gupta@nxp.com>
Cc: hch@lst.de, robin.murphy@arm.com, linux@armlinux.org.uk,
        gregkh@linuxfoundation.org, m.szyprowski@samsung.com,
        bhelgaas@google.com, dmitry.torokhov@gmail.com,
        rafael.j.wysocki@intel.com, jarkko.sakkinen@linux.intel.com,
        linus.walleij@linaro.org, johan@kernel.org, msuchanek@suse.de,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] dma-mapping: move dma configuration to bus
        infrastructure
Message-ID: <20180313073448.GA32269@lst.de>
References: <1520868292-2479-1-git-send-email-nipun.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1520868292-2479-1-git-send-email-nipun.gupta@nxp.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> +int amba_dma_configure(struct device *dev)
> +{
> +	enum dev_dma_attr attr;
> +	int ret = 0;
> +
> +	if (dev->of_node) {
> +		ret = of_dma_configure(dev, dev->of_node);
> +	} else if (has_acpi_companion(dev)) {
> +		attr = acpi_get_dma_attr(to_acpi_device_node(dev->fwnode));
> +		if (attr != DEV_DMA_NOT_SUPPORTED)
> +			ret = acpi_dma_configure(dev, attr);
> +	}
> +
> +	return ret;

This code sniplet is duplicated so many times that I think we should
just have some sort of dma_common_configure() for it that the various
busses can use.

> +void amba_dma_deconfigure(struct device *dev)
> +{
> +	of_dma_deconfigure(dev);
> +	acpi_dma_deconfigure(dev);
> +}

As mention in my previous reply I think we don't even need a deconfigure
callback at this point - just remove the ACPI and OF wrappers and
clear the dma ops.

Also in this series we should replace the force_dma flag by use of the
proper method, e.g. give a force parameter to of_dma_configure and the
new dma_common_configure helper that the busses that want it can set.
