Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay4.synopsys.com ([198.182.47.9]:59303 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752941AbeDQS4V (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Apr 2018 14:56:21 -0400
Subject: Re: [PATCH v5 07/10] PCI: dwc: Define maximum number of vectors
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <Joao.Pinto@synopsys.com>, <jingoohan1@gmail.com>, <kishon@ti.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <cover.1523973931.git.gustavo.pimentel@synopsys.com>
 <a71f296a31b14009e2db9608280102a0fa56b1d8.1523973931.git.gustavo.pimentel@synopsys.com>
From: Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <0cf5b436-7c7e-93b4-c13d-2490e19b9a41@synopsys.com>
Date: Tue, 17 Apr 2018 19:56:15 +0100
MIME-Version: 1.0
In-Reply-To: <a71f296a31b14009e2db9608280102a0fa56b1d8.1523973931.git.gustavo.pimentel@synopsys.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Gustavo,

Às 3:34 PM de 4/17/2018, Gustavo Pimentel escreveu:
> Adds a callback that defines the maximum number of vectors that can be use
> by the Root Complex.
> 
> Since this is a parameter associated to each SoC IP setting, makes sense to
> be configurable and easily visible to future modifications.
> 
> The designware IP supports a maximum of 256 vectors.
> 
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> ---
> Change v1->v2:
>  - Nothing changed, just to follow the patch set version.
> Change v2->v3:
>  - Nothing changed, just to follow the patch set version.
> Changes v3->v4:
>  - Nothing changed, just to follow the patch set version.
> Changes v4->v5:
>  - Nothing changed, just to follow the patch set version.
> 
>  drivers/pci/dwc/pcie-designware-plat.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/pci/dwc/pcie-designware-plat.c b/drivers/pci/dwc/pcie-designware-plat.c
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
> 

Yes, in our reference plat driver we should target all the available IRQs. Thanks!

Acked-by: Joao Pinto <jpinto@synopsys.com>
