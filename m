Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:47668 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751012AbdHAKp5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Aug 2017 06:45:57 -0400
Subject: Re: [PATCH] PCI: designware: Fix dw_handle_msi_irq() on 64-bit BE
 configs
To: Ben Hutchings <ben@decadent.org.uk>,
        Bjorn Helgaas <bhelgaas@google.com>
CC: Dan Carpenter <dan.carpenter@oracle.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        <linux-pci@vger.kernel.org>
References: <20170720234613.GF18698@decadent.org.uk>
From: Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <ceccd4e5-c5f1-9a31-dfef-b86b4587b3b6@synopsys.com>
Date: Tue, 1 Aug 2017 11:45:53 +0100
MIME-Version: 1.0
In-Reply-To: <20170720234613.GF18698@decadent.org.uk>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Hi Ben,

Às 12:46 AM de 7/21/2017, Ben Hutchings escreveu:
> Commit 1b497e6493c4 "PCI: dwc: Fix uninitialized variable in
> dw_handle_msi_irq()" fixed one problem for 64-bit architectures but
> left another.  The find_next_bit() function assumes native ordering of
> bits within each word (unsigned long), so passing a pointer to a u32
> variable will cause it to scan the following 32 bits on a 64-bit
> big-endian configuration.  Alternately it could result in an alignment
> fault on some architectures.
> 
> Copy the status to an unsigned long variable before using
> find_next_bit().
> 
> Fixes: 1b497e6493c4 ("PCI: dwc: Fix uninitialized variable in ...")
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> ---
> This is compile-tested only.
> 
> Ben.
> 
>  drivers/pci/dwc/pcie-designware-host.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/dwc/pcie-designware-host.c b/drivers/pci/dwc/pcie-designware-host.c
> index d29c020da082..511fc9188f98 100644
> --- a/drivers/pci/dwc/pcie-designware-host.c
> +++ b/drivers/pci/dwc/pcie-designware-host.c
> @@ -57,6 +57,7 @@ static struct irq_chip dw_msi_irq_chip = {
>  irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
>  {
>  	u32 val;
> +	unsigned long bits;

Could you please declare the variable in a ordered fashion (after "int i, pos,
irq;")? I suggest to change the variable name to "status" and val would be a
temporary variable only.

>  	int i, pos, irq;
>  	irqreturn_t ret = IRQ_NONE;
>  
> @@ -65,11 +66,11 @@ irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
>  				    &val);
>  		if (!val)
>  			continue;
> +		bits = val;
>  
>  		ret = IRQ_HANDLED;
>  		pos = 0;
> -		while ((pos = find_next_bit((unsigned long *) &val, 32,
> -					    pos)) != 32) {
> +		while ((pos = find_next_bit(&bits, 32, pos)) != 32) {
>  			irq = irq_find_mapping(pp->irq_domain, i * 32 + pos);
>  			dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_STATUS + i * 12,
>  					    4, 1 << pos);
> 

Thanks,
Joao
