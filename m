Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:44674 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751440AbeDXOj0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Apr 2018 10:39:26 -0400
From: "Jingoo Han" <jingoohan1@gmail.com>
To: "'Gustavo Pimentel'" <gustavo.pimentel@synopsys.com>,
        <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <Joao.Pinto@synopsys.com>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>
Cc: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <cover.1524577064.git.gustavo.pimentel@synopsys.com> <6b2c7ec1835cf422af5703aa14c99dbad8c6ffb8.1524577064.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <6b2c7ec1835cf422af5703aa14c99dbad8c6ffb8.1524577064.git.gustavo.pimentel@synopsys.com>
Subject: Re: [PATCH v7 6/9] PCI: dwc: Define maximum number of vectors
Date: Tue, 24 Apr 2018 10:39:20 -0400
Message-ID: <000001d3dbda$0a135930$1e3a0b90$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, April 24, 2018 9:45 AM, Gustavo Pimentel wrote:
> 
> Adds a callback that defines the maximum number of vectors that can be use
> by the Root Complex.
> 
> Since this is a parameter associated to each SoC IP setting, makes sense
> to
> be configurable and easily visible to future modifications.
> 
> The designware IP supports a maximum of 256 vectors.
> 
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> Acked-by: Joao Pinto <jpinto@synopsys.com>

Acked-by: Jingoo Han <jingoohan1@gmail.com>

Best regards,
Jingoo Han


> ---
> Change v1->v2:
>  - Nothing changed, just to follow the patch set version.
> Change v2->v3:
>  - Nothing changed, just to follow the patch set version.
> Changes v3->v4:
>  - Nothing changed, just to follow the patch set version.
> Changes v4->v5:
>  - Nothing changed, just to follow the patch set version.
> Changes v5->v6:
>  - Nothing changed, just to follow the patch set version.
> Changes v6->v7:
>  - Nothing changed, just to follow the patch set version.
> 
>  drivers/pci/dwc/pcie-designware-plat.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/pci/dwc/pcie-designware-plat.c
> b/drivers/pci/dwc/pcie-designware-plat.c
> index efc315c..5937fed 100644
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
