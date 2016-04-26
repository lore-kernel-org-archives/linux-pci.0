Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41259 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753176AbcDZSnp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 26 Apr 2016 14:43:45 -0400
Date: Tue, 26 Apr 2016 13:43:41 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Cc: pratyush.anand@gmail.com, jingoohan1@gmail.com,
	linuxarm@huawei.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: Designware: remove wrong RC memory base/limit
 configuration
Message-ID: <20160426184341.GF27803@localhost>
References: <1460804619-2972-1-git-send-email-gabriele.paoloni@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1460804619-2972-1-git-send-email-gabriele.paoloni@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Apr 16, 2016 at 12:03:39PM +0100, Gabriele Paoloni wrote:
> Currently dw_pcie_setup_rc configures memory base and memory
> limit in the type1 configuration header for the root complex.
> In doing so it uses the cpu address (pp->mem_base) rather than
> the bus address (pp->mem_bus_addr): this is wrong and it is
> useless since the configuration is overwritten later on when
> pci_bus_assign_resources() is called.
> 
> Therefore this patch just removes this configuration from
> dw_pcie_setup_rc.
> 
> Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>

Applied with Pratyush's ack to pci/host-designware for v4.7, thanks!

> ---
> 
> v1 -> v2 : removed unused variables in dw_pcie_setup_rc()
> 
> ---
>  drivers/pci/host/pcie-designware.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index a4cccd3..e3cb1f9 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -728,8 +728,6 @@ static struct pci_ops dw_pcie_ops = {
>  void dw_pcie_setup_rc(struct pcie_port *pp)
>  {
>  	u32 val;
> -	u32 membase;
> -	u32 memlimit;
>  
>  	/* set the number of lanes */
>  	dw_pcie_readl_rc(pp, PCIE_PORT_LINK_CONTROL, &val);
> @@ -788,12 +786,6 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
>  	val |= 0x00010100;
>  	dw_pcie_writel_rc(pp, val, PCI_PRIMARY_BUS);
>  
> -	/* setup memory base, memory limit */
> -	membase = ((u32)pp->mem_base & 0xfff00000) >> 16;
> -	memlimit = (pp->mem_size + (u32)pp->mem_base) & 0xfff00000;
> -	val = memlimit | membase;
> -	dw_pcie_writel_rc(pp, val, PCI_MEMORY_BASE);
> -
>  	/* setup command register */
>  	dw_pcie_readl_rc(pp, PCI_COMMAND, &val);
>  	val &= 0xffff0000;
> -- 
> 2.1.4
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
