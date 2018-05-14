Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42964 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753234AbeENNlz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 14 May 2018 09:41:55 -0400
Date: Mon, 14 May 2018 14:41:48 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: bhelgaas@google.com, m-karicheri2@ti.com,
        linux-pci@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>
Subject: Re: [PATCH] PCI: keystone: Do not treat link up message as error
Message-ID: <20180514134148.GA12029@e107981-ln.cambridge.arm.com>
References: <1525885056-7528-1-git-send-email-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1525885056-7528-1-git-send-email-festevam@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 09, 2018 at 01:57:36PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> The "Link already up" message does not indicate any error, so
> change it to dev_info() level instead.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
>  drivers/pci/dwc/pci-keystone.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to pci/dwc for v4.18, thanks.

Lorenzo

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
> -- 
> 2.7.4
> 
