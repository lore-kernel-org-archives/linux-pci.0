Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx02-sz.bfs.de ([194.94.69.103]:14550 "EHLO mx02-sz.bfs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750926AbdCQI0T (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 17 Mar 2017 04:26:19 -0400
Message-ID: <58CB9DA3.4040309@bfs.de>
Date: Fri, 17 Mar 2017 09:26:11 +0100
From: walter harms <wharms@bfs.de>
Reply-To: wharms@bfs.de
MIME-Version: 1.0
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Dan Carpenter <dan.carpenter@oracle.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [patch] PCI: dwc: uninitialized variable in dw_handle_msi_irq()
References: <20170217232618.GC26717@mwanda> <20170316194457.GB9739@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20170316194457.GB9739@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

It is my feeling that this realy improves the readability.

Acked-By: wharms@bfs.de

Am 16.03.2017 20:44, schrieb Bjorn Helgaas:
> On Sat, Feb 18, 2017 at 02:26:18AM +0300, Dan Carpenter wrote:
>> The bug is that "val" is unsigned long but we only initialize 32 bits
>> of it.  Then we test "if (val)" and that might be true not because we
>> set the bits but because some were never initialized.
>>
>> Fixes: f342d940ee0e ("PCI: exynos: Add support for MSI")
>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> I applied this to pci/host-designware for v4.12.
> 
> I also applied the patch below based on walter's suggestion:
> 
> 
> commit b67d3c69df8d6721f87bbc22a587914e0d4944a7
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Thu Mar 16 14:34:59 2017 -0500
> 
>     PCI: dwc: Unindent dw_handle_msi_irq() loop
>     
>     Use "continue" to skip rest of the loop when possible to save an indent
>     level.  No functional change intended.
>     
>     Suggested-by: walter harms <wharms@bfs.de>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> diff --git a/drivers/pci/dwc/pcie-designware-host.c b/drivers/pci/dwc/pcie-designware-host.c
> index 5ba334938b52..6cdd41f06dea 100644
> --- a/drivers/pci/dwc/pcie-designware-host.c
> +++ b/drivers/pci/dwc/pcie-designware-host.c
> @@ -63,17 +63,17 @@ irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
>  	for (i = 0; i < MAX_MSI_CTRLS; i++) {
>  		dw_pcie_rd_own_conf(pp, PCIE_MSI_INTR0_STATUS + i * 12, 4,
>  				    (u32 *)&val);
> -		if (val) {
> -			ret = IRQ_HANDLED;
> -			pos = 0;
> -			while ((pos = find_next_bit(&val, 32, pos)) != 32) {
> -				irq = irq_find_mapping(pp->irq_domain,
> -						       i * 32 + pos);
> -				dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_STATUS +
> -						    i * 12, 4, 1 << pos);
> -				generic_handle_irq(irq);
> -				pos++;
> -			}
> +		if (!val)
> +			continue;
> +
> +		ret = IRQ_HANDLED;
> +		pos = 0;
> +		while ((pos = find_next_bit(&val, 32, pos)) != 32) {
> +			irq = irq_find_mapping(pp->irq_domain, i * 32 + pos);
> +			dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_STATUS + i * 12,
> +					    4, 1 << pos);
> +			generic_handle_irq(irq);
> +			pos++;
>  		}
>  	}
>  
> 
>> ---
>> Static analysis.  Not tested.
>>
>> diff --git a/drivers/pci/dwc/pcie-designware.c b/drivers/pci/dwc/pcie-designware.c
>> index af8f6e92e885..5bfc377b83e4 100644
>> --- a/drivers/pci/dwc/pcie-designware.c
>> +++ b/drivers/pci/dwc/pcie-designware.c
>> @@ -257,17 +257,18 @@ static struct irq_chip dw_msi_irq_chip = {
>>  /* MSI int handler */
>>  irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
>>  {
>> -	unsigned long val;
>> +	u32 val;
>>  	int i, pos, irq;
>>  	irqreturn_t ret = IRQ_NONE;
>>  
>>  	for (i = 0; i < MAX_MSI_CTRLS; i++) {
>>  		dw_pcie_rd_own_conf(pp, PCIE_MSI_INTR0_STATUS + i * 12, 4,
>> -				(u32 *)&val);
>> +				    &val);
>>  		if (val) {
>>  			ret = IRQ_HANDLED;
>>  			pos = 0;
>> -			while ((pos = find_next_bit(&val, 32, pos)) != 32) {
>> +			while ((pos = find_next_bit((unsigned long *)&val, 32,
>> +						    pos)) != 32) {
>>  				irq = irq_find_mapping(pp->irq_domain,
>>  						i * 32 + pos);
>>  				dw_pcie_wr_own_conf(pp,
> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
