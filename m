Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:45846 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754944AbeENQUc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 14 May 2018 12:20:32 -0400
Date: Mon, 14 May 2018 17:20:26 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: bhelgaas@google.com, Joao.Pinto@synopsys.com, jingoohan1@gmail.com,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: Define maximum number of vectors
Message-ID: <20180514162026.GA14611@e107981-ln.cambridge.arm.com>
References: <cec63daa3d1090699816819c39292577016dab03.1526310065.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cec63daa3d1090699816819c39292577016dab03.1526310065.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 14, 2018 at 04:06:33PM +0100, Gustavo Pimentel wrote:
> Add a callback to define the maximum number of vectors used by the RC.
> 
> Since this is a parameter associated to each SoC IP setting, makes sense
> to be configurable and easily visible to future modifications.
> 
> Set DesignWare driver vectors number maximum to 256.
> 
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> Acked-by: Joao Pinto <jpinto@synopsys.com>
> Acked-by: Jingoo Han <jingoohan1@gmail.com>
> ---
>  drivers/pci/dwc/pcie-designware-plat.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Applied to pci/dwc for v4.18, thanks.

Lorenzo

> diff --git a/drivers/pci/dwc/pcie-designware-plat.c b/drivers/pci/dwc/pcie-designware-plat.c
> index 5416aa8..80a2782 100644
> --- a/drivers/pci/dwc/pcie-designware-plat.c
> +++ b/drivers/pci/dwc/pcie-designware-plat.c
> @@ -38,8 +38,14 @@ static int dw_plat_pcie_host_init(struct pcie_port *pp)
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
>  static int dw_plat_add_pcie_port(struct pcie_port *pp,
> -- 
> 2.7.4
> 
> 
