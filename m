Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58044 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752493AbeDIQEF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 9 Apr 2018 12:04:05 -0400
Date: Mon, 9 Apr 2018 17:03:56 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: bhelgaas@google.com, Joao.Pinto@synopsys.com, jingoohan1@gmail.com,
        kishon@ti.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 6/9] PCI: dwc: Define maximum number of vectors
Message-ID: <20180409160356.GA14533@e107981-ln.cambridge.arm.com>
References: <cover.1523266508.git.gustavo.pimentel@synopsys.com>
 <bf7062c863f33b2951acc586b1f22d3497ee2f10.1523266508.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <bf7062c863f33b2951acc586b1f22d3497ee2f10.1523266508.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 09, 2018 at 10:41:15AM +0100, Gustavo Pimentel wrote:
> Adds a callback that defines the maximum number of vectors that can be use
> by the Root Complex.
> 
> Since this is a parameter associated to each SoC IP setting, makes sense to
> be configurable and easily visible to future modifications.
> 
> The designware IP supports a maximum of 256 vectors.

I think that a DT property instead of a callback would have made more
sense - I struggle to see the point in defining a callback to initialize
a variable, this can be done in the generic dwc code (and a DT binding).

Lorenzo

> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> ---
> Change v1->v2:
> - Nothing changed, just to follow the patch set version.
> 
>  drivers/pci/dwc/pcie-designware-plat.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/pci/dwc/pcie-designware-plat.c b/drivers/pci/dwc/pcie-designware-plat.c
> index 5382a7a..94da252 100644
> --- a/drivers/pci/dwc/pcie-designware-plat.c
> +++ b/drivers/pci/dwc/pcie-designware-plat.c
> @@ -48,8 +48,14 @@ static int dw_plat_pcie_host_init(struct pcie_port *pp)
>  	return 0;
>  }
>  
> +static void dw_plat_set_num_vectors(struct pcie_port *pp)
> +{
> +	pp->num_vectors = MAX_MSI_IRQS;
> +}
> +
>  static const struct dw_pcie_host_ops dw_plat_pcie_host_ops = {
>  	.host_init = dw_plat_pcie_host_init,
> +	.set_num_vectors = dw_plat_set_num_vectors,
>  };
>  
>  static int dw_plat_pcie_establish_link(struct dw_pcie *pci)
> -- 
> 2.7.4
> 
> 
