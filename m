Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46874 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751903AbeBZJrr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 26 Feb 2018 04:47:47 -0500
Date: Mon, 26 Feb 2018 09:47:39 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Niklas Cassel <niklas.cassel@axis.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>, kishon@ti.com,
        Niklas Cassel <niklass@axis.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: designware-ep: Fix typo in error message
Message-ID: <20180226094739.GA19841@e107981-ln.cambridge.arm.com>
References: <20180201140224.28229-1-niklas.cassel@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180201140224.28229-1-niklas.cassel@axis.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 01, 2018 at 03:02:23PM +0100, Niklas Cassel wrote:
> Fix typo in error message. s/deb_base2/dbi_base2/
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
> ---
>  drivers/pci/dwc/pcie-designware-ep.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to pci/dwc for v4.17, thanks.

Lorenzo

> diff --git a/drivers/pci/dwc/pcie-designware-ep.c b/drivers/pci/dwc/pcie-designware-ep.c
> index 3a6feeff5f5b..9236b998327f 100644
> --- a/drivers/pci/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/dwc/pcie-designware-ep.c
> @@ -322,7 +322,7 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  	struct device_node *np = dev->of_node;
>  
>  	if (!pci->dbi_base || !pci->dbi_base2) {
> -		dev_err(dev, "dbi_base/deb_base2 is not populated\n");
> +		dev_err(dev, "dbi_base/dbi_base2 is not populated\n");
>  		return -EINVAL;
>  	}
>  
> -- 
> 2.14.2
> 
