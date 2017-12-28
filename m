Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay4.synopsys.com ([198.182.47.9]:52459 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753640AbdL1PdR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Dec 2017 10:33:17 -0500
Subject: Re: [PATCH v2] PCI: dwc: Use {upper,lower}_32_bits() macros for
 clarity
To: Stephen Boyd <sboyd@codeaurora.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC: Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <Gustavo.Pimentel@synopsys.com>
References: <20171227232540.22341-1-sboyd@codeaurora.org>
From: Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <f855815f-79a3-9be2-1513-2c9edc907079@synopsys.com>
Date: Thu, 28 Dec 2017 15:33:11 +0000
MIME-Version: 1.0
In-Reply-To: <20171227232540.22341-1-sboyd@codeaurora.org>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Hi Stephen,

Às 11:25 PM de 12/27/2017, Stephen Boyd escreveu:
> We have macros for getting the upper or lower 32 bits of a
> number. Use them here to shave a couple lines off the code
> and provide clarity.
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
> 
> Changes from v1:
>  * Update dw_msi_setup_msg() too
>  * Reword commit text slightly
> 
>  drivers/pci/dwc/pcie-designware-host.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/dwc/pcie-designware-host.c b/drivers/pci/dwc/pcie-designware-host.c
> index 81e2157a7cfb..454b8d244071 100644
> --- a/drivers/pci/dwc/pcie-designware-host.c
> +++ b/drivers/pci/dwc/pcie-designware-host.c
> @@ -89,10 +89,8 @@ void dw_pcie_msi_init(struct pcie_port *pp)
>  	msi_target = virt_to_phys((void *)pp->msi_data);
>  
>  	/* program the msi_data */
> -	dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_LO, 4,
> -			    (u32)(msi_target & 0xffffffff));
> -	dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_HI, 4,
> -			    (u32)(msi_target >> 32 & 0xffffffff));
> +	dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_LO, 4, lower_32_bits(msi_target));
> +	dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_HI, 4, upper_32_bits(msi_target));
>  }
>  
>  static void dw_pcie_msi_clear_irq(struct pcie_port *pp, int irq)
> @@ -189,8 +187,8 @@ static void dw_msi_setup_msg(struct pcie_port *pp, unsigned int irq, u32 pos)
>  	else
>  		msi_target = virt_to_phys((void *)pp->msi_data);
>  
> -	msg.address_lo = (u32)(msi_target & 0xffffffff);
> -	msg.address_hi = (u32)(msi_target >> 32 & 0xffffffff);
> +	msg.address_lo = lower_32_bits(msi_target);
> +	msg.address_hi = upper_32_bits(msi_target);
>  
>  	if (pp->ops->get_msi_data)
>  		msg.data = pp->ops->get_msi_data(pp, pos);
> 

Thanks for the patch.
Gustavo' patch-set targeting the update of the Interrupt API for
pcie-designware* already does this modification, so I would suggest that we wait
for Gustavo' patch to be stable and get the same modification.

Best regards,
Joao Pinto
