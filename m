Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relmlor2.renesas.com ([210.160.252.172]:22124 "EHLO
	relmlie1.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751213AbbKIPUc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 9 Nov 2015 10:20:32 -0500
From: Phil Edworthy <phil.edworthy@renesas.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Wolfram Sang <wsa@the-dreams.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Simon Horman <horms@verge.net.au>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Thierry Reding <treding@nvidia.com>,
	Ley Foon Tan <lftan@altera.com>,
	Jingoo Han <jg1.han@samsung.com>
Subject: RE: [PATCH] PCI: pcie-rcar: Fix OF node passed to MSI irq domain
Date: Mon, 9 Nov 2015 15:20:24 +0000
Message-ID: <PS1PR06MB11804ED428472FC1FD776F6EF5150@PS1PR06MB1180.apcprd06.prod.outlook.com>
References: <1446542899-25137-1-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1446542899-25137-1-git-send-email-phil.edworthy@renesas.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

cc'ing others (Tegra, Altera, Designware) who may have the same bug

On 03 November 2015 09:28, Phil Edworthy wrote:
> The OF node passed to irq_domain_add_linear() should be a
> pointer to interrupt controller's device tree node, or NULL,
> but not the PCI controller's node.
> 
> This fixes an oops in msi_domain_alloc_irqs() when it tries
> to call msi_check().
> 
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> ---
>  drivers/pci/host/pcie-rcar.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
> index 2377bf0..c6fa562 100644
> --- a/drivers/pci/host/pcie-rcar.c
> +++ b/drivers/pci/host/pcie-rcar.c
> @@ -709,7 +709,7 @@ static int rcar_pcie_enable_msi(struct rcar_pcie *pcie)
>  	msi->chip.setup_irq = rcar_msi_setup_irq;
>  	msi->chip.teardown_irq = rcar_msi_teardown_irq;
> 
> -	msi->domain = irq_domain_add_linear(pcie->dev->of_node,
> INT_PCI_MSI_NR,
> +	msi->domain = irq_domain_add_linear(NULL, INT_PCI_MSI_NR,
>  					    &msi_domain_ops, &msi->chip);
>  	if (!msi->domain) {
>  		dev_err(&pdev->dev, "failed to create IRQ domain\n");
> --
> 1.9.1

