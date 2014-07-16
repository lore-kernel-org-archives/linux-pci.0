Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:58590 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759059AbaGPAI2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 15 Jul 2014 20:08:28 -0400
Date: Wed, 16 Jul 2014 09:08:24 +0900
From: Simon Horman <horms@verge.net.au>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
	Thierry Reding <treding@nvidia.com>,
	linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: rcar: Fix GPL v2 license string typo
Message-ID: <20140716000824.GA25244@verge.net.au>
References: <20140715225503.22578.32174.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20140715225652.22578.86359.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140715225652.22578.86359.stgit@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 15, 2014 at 04:56:52PM -0600, Bjorn Helgaas wrote:
> The proper MODULE_LICENSE() string for the GPL v2 is "GPL v2", not "GPLv2".
> 
> Based-on-work-by: Thierry Reding <treding@nvidia.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Acked-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  drivers/pci/host/pcie-rcar.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
> index f7d3de32c9a0..a393cc60b5a3 100644
> --- a/drivers/pci/host/pcie-rcar.c
> +++ b/drivers/pci/host/pcie-rcar.c
> @@ -1003,4 +1003,4 @@ module_platform_driver(rcar_pcie_driver);
>  
>  MODULE_AUTHOR("Phil Edworthy <phil.edworthy@renesas.com>");
>  MODULE_DESCRIPTION("Renesas R-Car PCIe driver");
> -MODULE_LICENSE("GPLv2");
> +MODULE_LICENSE("GPL v2");
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
