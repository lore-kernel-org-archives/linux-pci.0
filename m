Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fllnx209.ext.ti.com ([198.47.19.16]:22668 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750950AbeEKQrF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 May 2018 12:47:05 -0400
Subject: Re: [PATCH] PCI: keystone: Do not treat link up message as error
To: Fabio Estevam <festevam@gmail.com>, <lorenzo.pieralisi@arm.com>
CC: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>
References: <1525885056-7528-1-git-send-email-festevam@gmail.com>
From: Murali Karicheri <m-karicheri2@ti.com>
Message-ID: <1bc54a18-4ddc-e885-c262-ddb9871ad121@ti.com>
Date: Fri, 11 May 2018 12:49:52 -0400
MIME-Version: 1.0
In-Reply-To: <1525885056-7528-1-git-send-email-festevam@gmail.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/09/2018 12:57 PM, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> The "Link already up" message does not indicate any error, so
> change it to dev_info() level instead.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
>  drivers/pci/dwc/pci-keystone.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/dwc/pci-keystone.c b/drivers/pci/dwc/pci-keystone.c
> index d55ae07..3722a5f 100644
> --- a/drivers/pci/dwc/pci-keystone.c
> +++ b/drivers/pci/dwc/pci-keystone.c
> @@ -89,7 +89,7 @@ static int ks_pcie_establish_link(struct keystone_pcie *ks_pcie)
>  	dw_pcie_setup_rc(pp);
>  
>  	if (dw_pcie_link_up(pci)) {
> -		dev_err(dev, "Link already up\n");
> +		dev_info(dev, "Link already up\n");
>  		return 0;
>  	}
>  
> 
Acked-by: Murali Karicheri <m-karicheri2@ti.com>
