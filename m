Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:44050 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752794AbdK2Xsq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Nov 2017 18:48:46 -0500
From: "Jingoo Han" <jingoohan1@gmail.com>
To: "'Stephen Boyd'" <sboyd@codeaurora.org>,
        "'Joao Pinto'" <Joao.Pinto@synopsys.com>
Cc: <linux-kernel@vger.kernel.org>,
        "'Bjorn Helgaas'" <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>
References: <20171129005334.16425-1-sboyd@codeaurora.org>
In-Reply-To: <20171129005334.16425-1-sboyd@codeaurora.org>
Subject: Re: [PATCH] PCI: dwc: Use {upper,lower}_32_bits() macros for clarity
Date: Wed, 29 Nov 2017 18:48:42 -0500
Message-ID: <000001d3696c$978b4e70$c6a1eb50$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, November 28, 2017 7:54 PM, Stephen Boyd wrote:
> 
> We have macros for getting the upper or lower 32 bits of a
> number. Use them here to shave a couple lines off the code.
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Acked-by: Jingoo Han <jingoohan1@gmail.com>

Best regards,
Jingoo Han

> ---
>  drivers/pci/dwc/pcie-designware-host.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/dwc/pcie-designware-host.c
> b/drivers/pci/dwc/pcie-designware-host.c
> index 157621175147..ae5abfddf8de 100644
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
> +	dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_LO, 4,
> lower_32_bits(msi_target));
> +	dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_HI, 4,
> upper_32_bits(msi_target));
>  }
> 
>  static void dw_pcie_msi_clear_irq(struct pcie_port *pp, int irq)
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
