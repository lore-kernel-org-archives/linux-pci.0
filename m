Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:53698 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933436AbeGBIkk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Jul 2018 04:40:40 -0400
Subject: Re: [PATCH v3 6/9] PCI: designware-plat: Drop unnecessary root_bus_nr
 setting
To: Shawn Guo <shawn.guo@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Jianguo Sun <sunjianguo1@huawei.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Jingoo Han <jingoohan1@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <1530417291-30495-1-git-send-email-shawn.guo@linaro.org>
 <1530417291-30495-7-git-send-email-shawn.guo@linaro.org>
From: Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Message-ID: <0ee69537-f2d2-f59f-be3c-1027fefd67f7@synopsys.com>
Date: Mon, 2 Jul 2018 09:38:29 +0100
MIME-Version: 1.0
In-Reply-To: <1530417291-30495-7-git-send-email-shawn.guo@linaro.org>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Shawn,

On 01/07/2018 04:54, Shawn Guo wrote:
> Function dw_pcie_host_init() already initializes the root_bus_nr field
> of 'struct pcie_port', so the -1 assignment prior to calling
> dw_pcie_host_init() in platform specific driver is not really needed.
> Drop it.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: Joao Pinto <Joao.Pinto@synopsys.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-plat.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-plat.c b/drivers/pci/controller/dwc/pcie-designware-plat.c
> index 5937fed4c938..6e048c0b67f2 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-plat.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-plat.c
> @@ -118,7 +118,6 @@ static int dw_plat_add_pcie_port(struct dw_plat_pcie *dw_plat_pcie,
>  			return pp->msi_irq;
>  	}
>  
> -	pp->root_bus_nr = -1;
>  	pp->ops = &dw_plat_pcie_host_ops;
>  
>  	ret = dw_pcie_host_init(pp);
> 

Looks good :)
Thanks

Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>

Regards,
Gustavo
