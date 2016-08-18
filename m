Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:42042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754374AbcHSBGO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 18 Aug 2016 21:06:14 -0400
Date: Thu, 18 Aug 2016 15:18:43 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ley Foon Tan <lftan@altera.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Ley Foon Tan <lftan.linux@gmail.com>
Subject: Re: [PATCH] PCI: altera: Retrain link in rootport mode only
Message-ID: <20160818201843.GI27353@localhost>
References: <1471250179-24198-1-git-send-email-lftan@altera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1471250179-24198-1-git-send-email-lftan@altera.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 15, 2016 at 04:36:19PM +0800, Ley Foon Tan wrote:
> Altera PCIe IP can be configured as rootport or device and they might have
> same vendor ID. It will cause the system hang issue if Altera PCIe is in
> endpoint mode and work with other PCIe rootport that from other vendors.
> So, add the rootport mode checking in link retrain fixup function.
> 
> Signed-off-by: Ley Foon Tan <lftan@altera.com>
> ---
>  drivers/pci/host/pcie-altera.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/host/pcie-altera.c b/drivers/pci/host/pcie-altera.c
> index 58eef99..6477738 100644
> --- a/drivers/pci/host/pcie-altera.c
> +++ b/drivers/pci/host/pcie-altera.c
> @@ -139,6 +139,9 @@ static void altera_pcie_retrain(struct pci_dev *dev)
>  	u16 linkcap, linkstat;
>  	struct altera_pcie *pcie = dev->bus->sysdata;
>  
> +	if (!pci_is_root_bus(dev->bus))
> +		return;

It seems like it would be more direct to check for
"pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT"?

>  	if (!altera_pcie_link_is_up(pcie))
>  		return;
>  
> -- 
> 1.8.2.1
> 
