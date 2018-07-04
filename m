Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:40256 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752381AbeGDQTZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 4 Jul 2018 12:19:25 -0400
Date: Wed, 4 Jul 2018 17:21:14 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Shawn Guo <shawn.guo@linaro.org>, Jingoo Han <jingoohan1@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Jianguo Sun <sunjianguo1@huawei.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Lucas Stach <l.stach@pengutronix.de>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 1/9] PCI: exynos: Drop unnecessary root_bus_nr setting
Message-ID: <20180704162114.GC12996@red-moon>
References: <1530417291-30495-1-git-send-email-shawn.guo@linaro.org>
 <1530417291-30495-2-git-send-email-shawn.guo@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1530417291-30495-2-git-send-email-shawn.guo@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Jul 01, 2018 at 11:54:43AM +0800, Shawn Guo wrote:
> Function dw_pcie_host_init() already initializes the root_bus_nr field
> of 'struct pcie_port', so the -1 assignment prior to calling
> dw_pcie_host_init() in platform specific driver is not really needed.
> Drop it.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> ---
>  drivers/pci/controller/dwc/pci-exynos.c | 1 -
>  1 file changed, 1 deletion(-)

Jingoo we would need your ACK here, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
> index 4cc1e5df8c79..cee5f2f590e2 100644
> --- a/drivers/pci/controller/dwc/pci-exynos.c
> +++ b/drivers/pci/controller/dwc/pci-exynos.c
> @@ -421,7 +421,6 @@ static int __init exynos_add_pcie_port(struct exynos_pcie *ep,
>  		}
>  	}
>  
> -	pp->root_bus_nr = -1;
>  	pp->ops = &exynos_pcie_host_ops;
>  
>  	ret = dw_pcie_host_init(pp);
> -- 
> 1.9.1
> 
