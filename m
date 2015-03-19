Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f51.google.com ([209.85.218.51]:36274 "EHLO
	mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755158AbbCSPBh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 19 Mar 2015 11:01:37 -0400
Received: by oigv203 with SMTP id v203so66987305oig.3
        for <linux-pci@vger.kernel.org>; Thu, 19 Mar 2015 08:01:37 -0700 (PDT)
Date: Thu, 19 Mar 2015 10:01:34 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Murali Karicheri <m-karicheri2@ti.com>
Cc: grant.likely@linaro.org, robh+dt@kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, arnd@arndb.de,
	Suravee.Suthikulpanit@amd.com, will.deacon@arm.com,
	joro@8bytes.org, linux@arm.linux.org.uk
Subject: Re: [PATCH v1] of/pci : fix of_pci_dma_configure parent ptr NULL
Message-ID: <20150319150134.GA26935@google.com>
References: <1426092003-16925-1-git-send-email-m-karicheri2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1426092003-16925-1-git-send-email-m-karicheri2@ti.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 11, 2015 at 12:40:03PM -0400, Murali Karicheri wrote:
> On some platforms such as that based on x86, ia64 etc, root bus is
> created with parent node passed in as NULL to pci_create_root_bus().
> On these platforms, the patch series "PCI: get DMA configuration from
> parent device" when applied causes kernel crash. So add a check for this
> in of_pci_dma_configure()
> 
> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
> Acked-by: Rob Herring<robh@kernel.org>

Since I hadn't merged the original patch yet, I just folded this fix into
it.  The series is on pci/iommu, and I merged it for "next".  Thanks for
your patience. 

Bjorn

> ---
>  drivers/of/of_pci.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
> index 86d3c38..a8e485c 100644
> --- a/drivers/of/of_pci.c
> +++ b/drivers/of/of_pci.c
> @@ -129,6 +129,10 @@ void of_pci_dma_configure(struct pci_dev *pci_dev)
>  	struct device *dev = &pci_dev->dev;
>  	struct device *bridge = pci_get_host_bridge_device(pci_dev);
>  
> +	/* Some platforms can have bridge->parent set to NULL */
> +	if (!bridge->parent)
> +		return;
> +
>  	of_dma_configure(dev, bridge->parent->of_node);
>  	pci_put_host_bridge_device(bridge);
>  }
> -- 
> 1.7.9.5
> 
