Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:57357 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965239AbeGBKZg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Jul 2018 06:25:36 -0400
Message-ID: <1530527122.22468.83.camel@pengutronix.de>
Subject: Re: [PATCH v3 2/9] PCI: imx6: Drop unnecessary root_bus_nr setting
From: Lucas Stach <l.stach@pengutronix.de>
To: Shawn Guo <shawn.guo@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Jianguo Sun <sunjianguo1@huawei.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
        Richard Zhu <hongxing.zhu@nxp.com>
Date: Mon, 02 Jul 2018 12:25:22 +0200
In-Reply-To: <1530417291-30495-3-git-send-email-shawn.guo@linaro.org>
References: <1530417291-30495-1-git-send-email-shawn.guo@linaro.org>
         <1530417291-30495-3-git-send-email-shawn.guo@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Sonntag, den 01.07.2018, 11:54 +0800 schrieb Shawn Guo:
> Function dw_pcie_host_init() already initializes the root_bus_nr
> field
> of 'struct pcie_port', so the -1 assignment prior to calling
> dw_pcie_host_init() in platform specific driver is not really needed.
> Drop it.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: Richard Zhu <hongxing.zhu@nxp.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c
> b/drivers/pci/controller/dwc/pci-imx6.c
> index 80f604602783..4a9a673b4777 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -667,7 +667,6 @@ static int imx6_add_pcie_port(struct imx6_pcie
> *imx6_pcie,
>  		}
>  	}
>  
> -	pp->root_bus_nr = -1;
>  	pp->ops = &imx6_pcie_host_ops;
>  
>  	ret = dw_pcie_host_init(pp);
