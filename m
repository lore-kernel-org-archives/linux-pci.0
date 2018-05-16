Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:46790 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752530AbeEPLYA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 May 2018 07:24:00 -0400
Date: Wed, 16 May 2018 12:23:53 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Stanimir Varbanov <svarbanov@mm-sol.com>,
        John Crispin <john@phrozen.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom: fix a bitwise vs logical NOT typo
Message-ID: <20180516112353.GA14579@e107981-ln.cambridge.arm.com>
References: <20180501072250.GA4269@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180501072250.GA4269@mwanda>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 01, 2018 at 10:22:50AM +0300, Dan Carpenter wrote:
> There is a typo here so we accidentally set "val" to zero when we
> intended just to clear BIT(0).
> 
> Fixes: 90d52d57ccac ("PCI: qcom: Add support for IPQ4019 PCIe controller")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> Not tested.
> 
> diff --git a/drivers/pci/dwc/pcie-qcom.c b/drivers/pci/dwc/pcie-qcom.c
> index 5897af7d3355..b65bbf7c284e 100644
> --- a/drivers/pci/dwc/pcie-qcom.c
> +++ b/drivers/pci/dwc/pcie-qcom.c
> @@ -869,7 +869,7 @@ static int qcom_pcie_init_2_4_0(struct qcom_pcie *pcie)
>  
>  	/* enable PCIe clocks and resets */
>  	val = readl(pcie->parf + PCIE20_PARF_PHY_CTRL);
> -	val &= !BIT(0);
> +	val &= ~BIT(0);
>  	writel(val, pcie->parf + PCIE20_PARF_PHY_CTRL);
>  
>  	/* change DBI base address */

Applied to pci/dwc for v4.18, thanks.

Lorenzo
