Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40324 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752260AbeGDQVg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 4 Jul 2018 12:21:36 -0400
Date: Wed, 4 Jul 2018 17:23:26 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Shawn Guo <shawn.guo@linaro.org>,
        Murali Karicheri <m-karicheri2@ti.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Jianguo Sun <sunjianguo1@huawei.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 3/9] PCI: keystone: Drop unnecessary root_bus_nr
 setting
Message-ID: <20180704162326.GD12996@red-moon>
References: <1530417291-30495-1-git-send-email-shawn.guo@linaro.org>
 <1530417291-30495-4-git-send-email-shawn.guo@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1530417291-30495-4-git-send-email-shawn.guo@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Jul 01, 2018 at 11:54:45AM +0800, Shawn Guo wrote:
> Function dw_pcie_host_init() already initializes the root_bus_nr field
> of 'struct pcie_port', so the -1 assignment prior to calling
> dw_pcie_host_init() in platform specific driver is not really needed.
> Drop it.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: Murali Karicheri <m-karicheri2@ti.com>
> ---
>  drivers/pci/controller/dwc/pci-keystone.c | 1 -
>  1 file changed, 1 deletion(-)

Hi Murali,

we would need your ACK to send this series upstream, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> index 3722a5f31e5e..e88bd221fffe 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> @@ -347,7 +347,6 @@ static int __init ks_add_pcie_port(struct keystone_pcie *ks_pcie,
>  		}
>  	}
>  
> -	pp->root_bus_nr = -1;
>  	pp->ops = &keystone_pcie_host_ops;
>  	ret = ks_dw_pcie_host_init(ks_pcie, ks_pcie->msi_intc_np);
>  	if (ret) {
> -- 
> 1.9.1
> 
