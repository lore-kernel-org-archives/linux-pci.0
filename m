Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.37.59]:50905 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751166AbeFTJY0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Jun 2018 05:24:26 -0400
Subject: Re: [PATCH v2] PCI: controller: dwc: Do not let PCIE_DW_PLAT_HOST
 default to yes
To: Geert Uytterhoeven <geert+renesas@glider.be>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20180619171917.19932-1-geert+renesas@glider.be>
From: Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Message-ID: <7d974ab2-27e9-98d7-36bb-91e87d92b7bf@synopsys.com>
Date: Wed, 20 Jun 2018 10:22:06 +0100
MIME-Version: 1.0
In-Reply-To: <20180619171917.19932-1-geert+renesas@glider.be>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Geert,

On 19/06/2018 18:19, Geert Uytterhoeven wrote:
> PCIE_DW_PLAT_HOST does not have any platform dependency, so it should
> not default to yes.

That's right, thanks.

Regards,
Gustavo

Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> 
> Fixes: 1d906b22076e12cf ("PCI: dwc: Add support for EP mode")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v2:
>   - Rebased on top of the big PCI controller move.
> ---
>  drivers/pci/controller/dwc/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index 16f52c626b4bd510..91b0194240a57e8f 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -58,7 +58,6 @@ config PCIE_DW_PLAT_HOST
>  	depends on PCI && PCI_MSI_IRQ_DOMAIN
>  	select PCIE_DW_HOST
>  	select PCIE_DW_PLAT
> -	default y
>  	help
>  	  Enables support for the PCIe controller in the Designware IP to
>  	  work in host mode. There are two instances of PCIe controller in
> 
