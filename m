Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx02-sz.bfs.de ([194.94.69.103]:36386 "EHLO mx02-sz.bfs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753181AbdBRMIJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 18 Feb 2017 07:08:09 -0500
Message-ID: <58A83923.3040903@bfs.de>
Date: Sat, 18 Feb 2017 13:08:03 +0100
From: walter harms <wharms@bfs.de>
Reply-To: wharms@bfs.de
MIME-Version: 1.0
To: Dan Carpenter <dan.carpenter@oracle.com>
CC: Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [patch] PCI: dwc: uninitialized variable in dw_handle_msi_irq()
References: <20170217232618.GC26717@mwanda>
In-Reply-To: <20170217232618.GC26717@mwanda>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



Am 18.02.2017 00:26, schrieb Dan Carpenter:
> The bug is that "val" is unsigned long but we only initialize 32 bits
> of it.  Then we test "if (val)" and that might be true not because we
> set the bits but because some were never initialized.
> 
> Fixes: f342d940ee0e ("PCI: exynos: Add support for MSI")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> Static analysis.  Not tested.
> 
> diff --git a/drivers/pci/dwc/pcie-designware.c b/drivers/pci/dwc/pcie-designware.c
> index af8f6e92e885..5bfc377b83e4 100644
> --- a/drivers/pci/dwc/pcie-designware.c
> +++ b/drivers/pci/dwc/pcie-designware.c
> @@ -257,17 +257,18 @@ static struct irq_chip dw_msi_irq_chip = {
>  /* MSI int handler */
>  irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
>  {
> -	unsigned long val;
> +	u32 val;
>  	int i, pos, irq;
>  	irqreturn_t ret = IRQ_NONE;
>  
>  	for (i = 0; i < MAX_MSI_CTRLS; i++) {
>  		dw_pcie_rd_own_conf(pp, PCIE_MSI_INTR0_STATUS + i * 12, 4,
> -				(u32 *)&val);
> +				    &val);
>  		if (val) {

why not
	if (!val) continue;

it would save an entire indent level and make things a bit more easy to read.


>  			ret = IRQ_HANDLED;
>  			pos = 0;
> -			while ((pos = find_next_bit(&val, 32, pos)) != 32) {
> +			while ((pos = find_next_bit((unsigned long *)&val, 32,
> +						    pos)) != 32) {
>  				irq = irq_find_mapping(pp->irq_domain,
>  						i * 32 + pos);

irq seems to be 0 when nothing is found. This can never happen ?

find_next_bit() feels a bit overpowered perhaps a simple loop
would be more effective and more easy to understand ?
something like:
	while ( val) {
	 if (val & 1 )
		found ...
	val>>=1;
	pos++;
	}

just my 2 cents,

re,
 wh


>  				dw_pcie_wr_own_conf(pp,
