Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:34710 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932553AbeGBIrj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Jul 2018 04:47:39 -0400
Date: Mon, 2 Jul 2018 10:47:36 +0200
From: Jesper Nilsson <jesper.nilsson@axis.com>
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Jianguo Sun <sunjianguo1@huawei.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Jesper Nilsson <jespern@axis.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 5/9] PCI: artpec6: Drop unnecessary root_bus_nr setting
Message-ID: <20180702084736.GH4333@axis.com>
References: <1530417291-30495-1-git-send-email-shawn.guo@linaro.org>
 <1530417291-30495-6-git-send-email-shawn.guo@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1530417291-30495-6-git-send-email-shawn.guo@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Jul 01, 2018 at 11:54:47AM +0800, Shawn Guo wrote:
> Function dw_pcie_host_init() already initializes the root_bus_nr field
> of 'struct pcie_port', so the -1 assignment prior to calling
> dw_pcie_host_init() in platform specific driver is not really needed.
> Drop it.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

> ---
>  drivers/pci/controller/dwc/pcie-artpec6.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-artpec6.c b/drivers/pci/controller/dwc/pcie-artpec6.c
> index 321b56cfd5d0..128b182648b3 100644
> --- a/drivers/pci/controller/dwc/pcie-artpec6.c
> +++ b/drivers/pci/controller/dwc/pcie-artpec6.c
> @@ -399,7 +399,6 @@ static int artpec6_add_pcie_port(struct artpec6_pcie *artpec6_pcie,
>  		}
>  	}
>  
> -	pp->root_bus_nr = -1;
>  	pp->ops = &artpec6_pcie_host_ops;
>  
>  	ret = dw_pcie_host_init(pp);
> -- 
> 1.9.1

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
