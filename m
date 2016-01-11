Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:47454 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760068AbcAKOn0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 11 Jan 2016 09:43:26 -0500
Date: Mon, 11 Jan 2016 08:43:23 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Fabio Estevam <fabio.estevam@nxp.com>
Cc: bhelgaas@google.com, jingoohan1@gmail.com,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: designware: Remove unused variable
Message-ID: <20160111144323.GB25540@localhost>
References: <1452512470-20890-1-git-send-email-fabio.estevam@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1452512470-20890-1-git-send-email-fabio.estevam@nxp.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jan 11, 2016 at 09:41:10AM -0200, Fabio Estevam wrote:
> Commit 50a1a3b06dddaa5b ("PCI: designware: Simplify control flow")
> causes the following build warning:
> 
> drivers/pci/host/pcie-designware.c:683:6: warning: unused variable 'ret' [-Wunused-variable]
> 
> Remove the unused 'ret' varaible.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Thanks guys, sorry about this oversight.  I folded this into the original
patch.

> ---
>  drivers/pci/host/pcie-designware.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index 9a666db..2171682 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -680,7 +680,6 @@ static int dw_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
>  			int where, int size, u32 val)
>  {
>  	struct pcie_port *pp = bus->sysdata;
> -	int ret;
>  
>  	if (dw_pcie_valid_config(pp, bus, PCI_SLOT(devfn)) == 0)
>  		return PCIBIOS_DEVICE_NOT_FOUND;
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
