Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:55368 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751287AbdJPMIg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Oct 2017 08:08:36 -0400
Subject: Re: [PATCH 01/10] PCI: dwc: use DMA-API for allocating MSI data
To: Jingoo Han <jingoohan1@gmail.com>,
        'Joao Pinto' <Joao.Pinto@synopsys.com>,
        'Bjorn Helgaas' <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
References: <20171013160914.3220-1-niklas.cassel@axis.com>
 <20171013160914.3220-2-niklas.cassel@axis.com>
 <000001d34442$640e85c0$2c2b9140$@gmail.com>
From: Niklas Cassel <niklas.cassel@axis.com>
Message-ID: <f7e99774-192b-5362-c6c5-dc8324499f45@axis.com>
Date: Mon, 16 Oct 2017 14:08:33 +0200
MIME-Version: 1.0
In-Reply-To: <000001d34442$640e85c0$2c2b9140$@gmail.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/13/2017 06:43 PM, Jingoo Han wrote:
> On Friday, October 13, 2017 12:09 PM, Niklas Cassel wrote:
>>
>> Since it is a PCIe endpoint device, rather than the CPU, that is supposed
>> to write to this location, the proper way to get the address to this this
>> location is really to use the DMA API, rather than virt_to_phys.
>>
>> Using virt_to_phys might work on some systems, but by using the DMA API,
>> we know that it will work on all systems.
>>
>> This is essentially the same thing as allocating a buffer in a driver,
>> to which the endpoint will write to. To do this, we use the DMA API.
> 

Hello Jingoo.

> I have no objection. However, did you test your patch?

I've tested the patch on the ARTPEC-6 and the ARTPEC-7 SoC,
one which has a 64-bit dma_addr_t, one which has a 32-bit dma_addr_t.

However, since device drivers use dma_map_page all the time,
for this exact purpose, I don't think there should be a problem.
(Famous last words..)

> In my opinion, your company does not handle DWC PCIe controller, right?

Right, we are not Synopsys ;)

> If so, you need to get tested-by from other people.

I agree, a couple of Tested-by would be a good idea.

Joao and Kishon, if you have the time, could you please help me
out and see MSI still works on your platform with this patch?


Regards,
Niklas


> 
> Best regards,
> Jingoo Han
> 
>>
>> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
>> ---
>>  drivers/pci/dwc/pcie-designware-host.c | 23 ++++++++++++++++-------
>>  drivers/pci/dwc/pcie-designware.h      |  3 ++-
>>  2 files changed, 18 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/pci/dwc/pcie-designware-host.c
>> b/drivers/pci/dwc/pcie-designware-host.c
>> index 81e2157a7cfb..f6d152ea2a03 100644
>> --- a/drivers/pci/dwc/pcie-designware-host.c
>> +++ b/drivers/pci/dwc/pcie-designware-host.c
>> @@ -83,16 +83,25 @@ irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
>>
>>  void dw_pcie_msi_init(struct pcie_port *pp)
>>  {
>> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>> +	struct device *dev = pci->dev;
>> +	struct page *page;
>>  	u64 msi_target;
>>
>> -	pp->msi_data = __get_free_pages(GFP_KERNEL, 0);
>> -	msi_target = virt_to_phys((void *)pp->msi_data);
>> +	page = alloc_page(GFP_KERNEL | GFP_DMA32);
>> +	pp->msi_data = dma_map_page(dev, page, 0, PAGE_SIZE,
>> DMA_FROM_DEVICE);
>> +	if (dma_mapping_error(dev, pp->msi_data)) {
>> +		dev_err(dev, "failed to map msi data\n");
>> +		__free_page(page);
>> +		return;
>> +	}
>> +	msi_target = (u64)pp->msi_data;
>>
>>  	/* program the msi_data */
>>  	dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_LO, 4,
>> -			    (u32)(msi_target & 0xffffffff));
>> +			    lower_32_bits(msi_target));
>>  	dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_HI, 4,
>> -			    (u32)(msi_target >> 32 & 0xffffffff));
>> +			    upper_32_bits(msi_target));
>>  }
>>
>>  static void dw_pcie_msi_clear_irq(struct pcie_port *pp, int irq)
>> @@ -187,10 +196,10 @@ static void dw_msi_setup_msg(struct pcie_port *pp,
>> unsigned int irq, u32 pos)
>>  	if (pp->ops->get_msi_addr)
>>  		msi_target = pp->ops->get_msi_addr(pp);
>>  	else
>> -		msi_target = virt_to_phys((void *)pp->msi_data);
>> +		msi_target = (u64)pp->msi_data;
>>
>> -	msg.address_lo = (u32)(msi_target & 0xffffffff);
>> -	msg.address_hi = (u32)(msi_target >> 32 & 0xffffffff);
>> +	msg.address_lo = lower_32_bits(msi_target);
>> +	msg.address_hi = upper_32_bits(msi_target);
>>
>>  	if (pp->ops->get_msi_data)
>>  		msg.data = pp->ops->get_msi_data(pp, pos);
>> diff --git a/drivers/pci/dwc/pcie-designware.h b/drivers/pci/dwc/pcie-
>> designware.h
>> index e5d9d77b778e..547352a317f8 100644
>> --- a/drivers/pci/dwc/pcie-designware.h
>> +++ b/drivers/pci/dwc/pcie-designware.h
>> @@ -17,6 +17,7 @@
>>  #include <linux/irq.h>
>>  #include <linux/msi.h>
>>  #include <linux/pci.h>
>> +#include <linux/dma-mapping.h>
>>
>>  #include <linux/pci-epc.h>
>>  #include <linux/pci-epf.h>
>> @@ -168,7 +169,7 @@ struct pcie_port {
>>  	const struct dw_pcie_host_ops *ops;
>>  	int			msi_irq;
>>  	struct irq_domain	*irq_domain;
>> -	unsigned long		msi_data;
>> +	dma_addr_t		msi_data;
>>  	DECLARE_BITMAP(msi_irq_in_use, MAX_MSI_IRQS);
>>  };
>>
>> --
>> 2.11.0
> 
> 
