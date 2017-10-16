Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751935AbdJPW0f (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Oct 2017 18:26:35 -0400
Date: Mon, 16 Oct 2017 17:26:32 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Cassel <niklas.cassel@axis.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Niklas Cassel <niklass@axis.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/10] PCI: designware-ep: set_msi should only set MMC
 bits
Message-ID: <20171016222632.GL25517@bhelgaas-glaptop.roam.corp.google.com>
References: <20171013160914.3220-1-niklas.cassel@axis.com>
 <20171013160914.3220-3-niklas.cassel@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171013160914.3220-3-niklas.cassel@axis.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Would you mind capitalizing the first letter of the changelog summary,
i.e., to follow the convention of "git log --oneline
drivers/pci/dwc/pcie-designware-ep.c"?  I usually fix that up
manually, but it saves me time if you do it.

On Fri, Oct 13, 2017 at 06:09:05PM +0200, Niklas Cassel wrote:
> Previously, set_msi wrote all bits in the Message Control
> register, thus overwriting the 64 bit address capable bit.
> By clearing the 64 bit address capable bit, we break MSI
> on systems where the RC has set a 64 bit MSI address.

s/set_msi/dw_pcie_ep_set_msi()/ to be specific.

I think we overwrote PCI_MSI_FLAGS_64BIT (and PCI_MSI_FLAGS_ENABLE).

> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
> ---
>  drivers/pci/dwc/pcie-designware-ep.c | 4 +++-
>  drivers/pci/dwc/pcie-designware.h    | 1 +
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/dwc/pcie-designware-ep.c b/drivers/pci/dwc/pcie-designware-ep.c
> index d53d5f168363..c92ab87fd660 100644
> --- a/drivers/pci/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/dwc/pcie-designware-ep.c
> @@ -220,7 +220,9 @@ static int dw_pcie_ep_set_msi(struct pci_epc *epc, u8 encode_int)
>  	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  
> -	val = (encode_int << MSI_CAP_MMC_SHIFT);
> +	val = dw_pcie_readw_dbi(pci, MSI_MESSAGE_CONTROL);
> +	val &= ~MSI_CAP_MMC_MASK;
> +	val |= (encode_int << MSI_CAP_MMC_SHIFT) & MSI_CAP_MMC_MASK;
>  	dw_pcie_writew_dbi(pci, MSI_MESSAGE_CONTROL, val);
>  
>  	return 0;
> diff --git a/drivers/pci/dwc/pcie-designware.h b/drivers/pci/dwc/pcie-designware.h
> index 547352a317f8..36183906e1d2 100644
> --- a/drivers/pci/dwc/pcie-designware.h
> +++ b/drivers/pci/dwc/pcie-designware.h
> @@ -101,6 +101,7 @@
>  
>  #define MSI_MESSAGE_CONTROL		0x52
>  #define MSI_CAP_MMC_SHIFT		1
> +#define MSI_CAP_MMC_MASK		(7 << MSI_CAP_MMC_SHIFT)
>  #define MSI_CAP_MME_SHIFT		4
>  #define MSI_CAP_MME_MASK		(7 << MSI_CAP_MME_SHIFT)
>  #define MSI_MESSAGE_ADDR_L32		0x54

It looks like these are really other names for PCI_MSI_FLAGS_QMASK and
PCI_MSI_FLAGS_QSIZE.  I wish the DW code used those to make the
connection more obvious.

But I think this patch is correct as-is and that would be a different
patch.
