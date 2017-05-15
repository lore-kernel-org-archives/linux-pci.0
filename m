Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:35056 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751629AbdEOKcu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 May 2017 06:32:50 -0400
Subject: Re: [RFC 1/8] pci: adding new irq api to pci-designware
To: Marc Zyngier <marc.zyngier@arm.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>, <bhelgaas@google.com>,
        <l.stach@pengutronix.de>
References: <cover.1494606911.git.jpinto@synopsys.com>
 <d9664b857b0b9fe9cba6b8de5f0b6d365fe86f36.1494606911.git.jpinto@synopsys.com>
 <e0881846-21ca-8b5d-4162-caf77c336600@arm.com>
CC: <jingoohan1@gmail.com>, <m-karicheri2@ti.com>,
        <thomas.petazzoni@free-electrons.com>,
        <minghuan.Lian@freescale.com>, <mingkai.hu@freescale.com>,
        <tie-fei.zang@freescale.com>, <hongxing.zhu@nxp.com>,
        <niklas.cassel@axis.com>, <jesper.nilsson@axis.com>,
        <wangzhou1@hisilicon.com>, <gabriele.paoloni@huawei.com>,
        <svarbanov@mm-sol.com>, <linux-pci@vger.kernel.org>
From: Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <c8baa1ed-6211-26f9-cffc-366ca0305ad8@synopsys.com>
Date: Mon, 15 May 2017 11:32:26 +0100
MIME-Version: 1.0
In-Reply-To: <e0881846-21ca-8b5d-4162-caf77c336600@arm.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Hi Mark and Lucas,

Às 6:36 PM de 5/12/2017, Marc Zyngier escreveu:
> Joao,
> 
> You seem to have dropped a number of things I had mentioned on my
> previous review of this patch. See below:
> 
> On 12/05/17 17:56, Joao Pinto wrote:
>> This patch adds the new interrupt api to pecie-designware, keeping the old
>> one. A define was added to toggle between the two apis (for testing purposes).
>>
>> Signed-off-by: Joao Pinto <jpinto@synopsys.com>
>> ---
>>  drivers/pci/dwc/pcie-designware-host.c | 241 ++++++++++++++++++++++++++++++++-
>>  drivers/pci/dwc/pcie-designware.h      |   5 +
>>  2 files changed, 244 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/dwc/pcie-designware-host.c b/drivers/pci/dwc/pcie-designware-host.c
>> index 28ed32b..6810ea10b 100644
>> --- a/drivers/pci/dwc/pcie-designware-host.c
>> +++ b/drivers/pci/dwc/pcie-designware-host.c
>> @@ -11,6 +11,7 @@
>>   * published by the Free Software Foundation.
>>   */
>>  
>> +#include <linux/irqchip/chained_irq.h>
>>  #include <linux/irqdomain.h>
>>  #include <linux/of_address.h>
>>  #include <linux/of_pci.h>
>> @@ -19,6 +20,9 @@
>>  
>>  #include "pcie-designware.h"
>>  
>> +/* Temporary: Activate to use new IRQ API */
>> +/*#define CONFIG_PCIEDW_NEW_IRQ_API*/
> 
> You should be able to support both APIs at the same time until the last
> patch, without relying on a kernel configuration (we still want to be
> able to boot a single kernel that works both with the old and new methods).

I think that the APIs are mutual-exclusive. pcie-designware has to initialize of
one of them. Your idea is to have the new and the old API functions, but only
initialize pcie-designware with the old one until the last patch?

[...]

>> +
>> +	msg->address_lo = (u32)(msi_target & 0xffffffff);
>> +	msg->address_hi = (u32)(msi_target >> 32 & 0xffffffff);
> 
> Use lower_32_bit/upper_32_bit macros.

Right, I am going to update this.

[...]

>> +
>> +static void dw_pci_bottom_mask(struct irq_data *data)
>> +{
>> +	struct dw_pcie *pci = irq_data_get_irq_chip_data(data);
>> +	struct pcie_port *pp = &pci->pp;
>> +	unsigned int res, bit, val;
>> +
>> +	mutex_lock(&pp->lock);
> 
> This is wrong. You can also end-up here from interrupt context, so you
> need an spin_lock_irqsave().

Right, I am going to update this.

[...]

> 
>> +
>> +	if (pp->ops->msi_clear_irq)
>> +		pp->ops->msi_clear_irq(pp, data->hwirq);
> 
> Why do you need this? Can you have alternative implementations of
> mask/unmask?

msi_clear_irq and msi_set_irq are specific SoC operations to set and clear bits
in the interrupt register. In my opinion we should keep the current callbacks.

[...]

> 
>> +	else {
>> +		res = (data->hwirq / 32) * 12;
>> +		bit = data->hwirq % 32;
>> +
>> +		dw_pcie_rd_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4, &val);
> 
> No use reading back from the HW. Just maintain a cached version in your
> private structure and just use that.

Ok, I can do that.

[...]

>> +
>> +	bit = find_first_zero_bit(pp->msi_irq_in_use, pp->num_vectors);
>> +	if (bit >= pp->num_vectors) {
>> +		mutex_unlock(&pp->lock);
>> +		return -ENOSPC;
>> +	}
>> +
>> +	set_bit(bit, pp->msi_irq_in_use);
>> +
>> +	mutex_unlock(&pp->lock);
> 
> As mentioned by Lucas, you probably want to support Multi-MSI.
> 

This could be achieved by declaring data for each virq, correct?

for (i = 0; i < nr_irqs; i++) {
irq_domain_set_info(domain, virq + i, bit + i,
&dw_pci_msi_bottom_irq_chip,domain->host_data, handle_simple_irq,
NULL, NULL);
}

[...]

>> +
>> +	pp->irq_domain = irq_domain_add_linear(NULL, pp->num_vectors,
>> +					       &dw_pcie_msi_domain_ops, pci);
> 
> Please use irq_domain_create_linear and pass the fwnode there as well.
> 

Ok, I will do that.

[...]

>>  static inline irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
>>  {
>>
> 
> Thanks,
> 
> 	M.
> 

Thank you for you feeback!

Joao
