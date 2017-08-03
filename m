Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751736AbdHCVkq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Aug 2017 17:40:46 -0400
Date: Thu, 3 Aug 2017 16:40:43 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-kernel@vger.kernel.org,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 051/102] PCI: dwc: pcie-qcom: explicitly request
 exclusive reset control
Message-ID: <20170803214043.GB20308@bhelgaas-glaptop.roam.corp.google.com>
References: <20170719152646.25903-1-p.zabel@pengutronix.de>
 <20170719152646.25903-52-p.zabel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170719152646.25903-52-p.zabel@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 19, 2017 at 05:25:55PM +0200, Philipp Zabel wrote:
> Commit a53e35db70d1 ("reset: Ensure drivers are explicit when requesting
> reset lines") started to transition the reset control request API calls
> to explicitly state whether the driver needs exclusive or shared reset
> control behavior. Convert all drivers requesting exclusive resets to the
> explicit API call so the temporary transition helpers can be removed.
> 
> No functional changes.
> 
> Cc: Stanimir Varbanov <svarbanov@mm-sol.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-arm-msm@vger.kernel.org
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>

Applied to pci/host-qcom for v4.14, thanks!

Stanimir, holler if you see any issues.

> ---
>  drivers/pci/dwc/pcie-qcom.c | 40 ++++++++++++++++++++++------------------
>  1 file changed, 22 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/pci/dwc/pcie-qcom.c b/drivers/pci/dwc/pcie-qcom.c
> index 68c5f2ab5bc8f..90f7796a7cffe 100644
> --- a/drivers/pci/dwc/pcie-qcom.c
> +++ b/drivers/pci/dwc/pcie-qcom.c
> @@ -212,23 +212,23 @@ static int qcom_pcie_get_resources_v0(struct qcom_pcie *pcie)
>  	if (IS_ERR(res->phy_clk))
>  		return PTR_ERR(res->phy_clk);
>  
> -	res->pci_reset = devm_reset_control_get(dev, "pci");
> +	res->pci_reset = devm_reset_control_get_exclusive(dev, "pci");
>  	if (IS_ERR(res->pci_reset))
>  		return PTR_ERR(res->pci_reset);
>  
> -	res->axi_reset = devm_reset_control_get(dev, "axi");
> +	res->axi_reset = devm_reset_control_get_exclusive(dev, "axi");
>  	if (IS_ERR(res->axi_reset))
>  		return PTR_ERR(res->axi_reset);
>  
> -	res->ahb_reset = devm_reset_control_get(dev, "ahb");
> +	res->ahb_reset = devm_reset_control_get_exclusive(dev, "ahb");
>  	if (IS_ERR(res->ahb_reset))
>  		return PTR_ERR(res->ahb_reset);
>  
> -	res->por_reset = devm_reset_control_get(dev, "por");
> +	res->por_reset = devm_reset_control_get_exclusive(dev, "por");
>  	if (IS_ERR(res->por_reset))
>  		return PTR_ERR(res->por_reset);
>  
> -	res->phy_reset = devm_reset_control_get(dev, "phy");
> +	res->phy_reset = devm_reset_control_get_exclusive(dev, "phy");
>  	return PTR_ERR_OR_ZERO(res->phy_reset);
>  }
>  
> @@ -393,7 +393,7 @@ static int qcom_pcie_get_resources_v1(struct qcom_pcie *pcie)
>  	if (IS_ERR(res->slave_bus))
>  		return PTR_ERR(res->slave_bus);
>  
> -	res->core = devm_reset_control_get(dev, "core");
> +	res->core = devm_reset_control_get_exclusive(dev, "core");
>  	return PTR_ERR_OR_ZERO(res->core);
>  }
>  
> @@ -623,51 +623,55 @@ static int qcom_pcie_get_resources_v3(struct qcom_pcie *pcie)
>  	if (IS_ERR(res->slave_clk))
>  		return PTR_ERR(res->slave_clk);
>  
> -	res->axi_m_reset = devm_reset_control_get(dev, "axi_m");
> +	res->axi_m_reset = devm_reset_control_get_exclusive(dev, "axi_m");
>  	if (IS_ERR(res->axi_m_reset))
>  		return PTR_ERR(res->axi_m_reset);
>  
> -	res->axi_s_reset = devm_reset_control_get(dev, "axi_s");
> +	res->axi_s_reset = devm_reset_control_get_exclusive(dev, "axi_s");
>  	if (IS_ERR(res->axi_s_reset))
>  		return PTR_ERR(res->axi_s_reset);
>  
> -	res->pipe_reset = devm_reset_control_get(dev, "pipe");
> +	res->pipe_reset = devm_reset_control_get_exclusive(dev, "pipe");
>  	if (IS_ERR(res->pipe_reset))
>  		return PTR_ERR(res->pipe_reset);
>  
> -	res->axi_m_vmid_reset = devm_reset_control_get(dev, "axi_m_vmid");
> +	res->axi_m_vmid_reset = devm_reset_control_get_exclusive(dev,
> +								 "axi_m_vmid");
>  	if (IS_ERR(res->axi_m_vmid_reset))
>  		return PTR_ERR(res->axi_m_vmid_reset);
>  
> -	res->axi_s_xpu_reset = devm_reset_control_get(dev, "axi_s_xpu");
> +	res->axi_s_xpu_reset = devm_reset_control_get_exclusive(dev,
> +								"axi_s_xpu");
>  	if (IS_ERR(res->axi_s_xpu_reset))
>  		return PTR_ERR(res->axi_s_xpu_reset);
>  
> -	res->parf_reset = devm_reset_control_get(dev, "parf");
> +	res->parf_reset = devm_reset_control_get_exclusive(dev, "parf");
>  	if (IS_ERR(res->parf_reset))
>  		return PTR_ERR(res->parf_reset);
>  
> -	res->phy_reset = devm_reset_control_get(dev, "phy");
> +	res->phy_reset = devm_reset_control_get_exclusive(dev, "phy");
>  	if (IS_ERR(res->phy_reset))
>  		return PTR_ERR(res->phy_reset);
>  
> -	res->axi_m_sticky_reset = devm_reset_control_get(dev, "axi_m_sticky");
> +	res->axi_m_sticky_reset = devm_reset_control_get_exclusive(dev,
> +								   "axi_m_sticky");
>  	if (IS_ERR(res->axi_m_sticky_reset))
>  		return PTR_ERR(res->axi_m_sticky_reset);
>  
> -	res->pipe_sticky_reset = devm_reset_control_get(dev, "pipe_sticky");
> +	res->pipe_sticky_reset = devm_reset_control_get_exclusive(dev,
> +								  "pipe_sticky");
>  	if (IS_ERR(res->pipe_sticky_reset))
>  		return PTR_ERR(res->pipe_sticky_reset);
>  
> -	res->pwr_reset = devm_reset_control_get(dev, "pwr");
> +	res->pwr_reset = devm_reset_control_get_exclusive(dev, "pwr");
>  	if (IS_ERR(res->pwr_reset))
>  		return PTR_ERR(res->pwr_reset);
>  
> -	res->ahb_reset = devm_reset_control_get(dev, "ahb");
> +	res->ahb_reset = devm_reset_control_get_exclusive(dev, "ahb");
>  	if (IS_ERR(res->ahb_reset))
>  		return PTR_ERR(res->ahb_reset);
>  
> -	res->phy_ahb_reset = devm_reset_control_get(dev, "phy_ahb");
> +	res->phy_ahb_reset = devm_reset_control_get_exclusive(dev, "phy_ahb");
>  	if (IS_ERR(res->phy_ahb_reset))
>  		return PTR_ERR(res->phy_ahb_reset);
>  
> -- 
> 2.11.0
> 
