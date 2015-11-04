Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:59176 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932356AbbKDItL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 4 Nov 2015 03:49:11 -0500
Message-ID: <5639C681.6060007@arm.com>
Date: Wed, 04 Nov 2015 08:49:05 +0000
From: Marc Zyngier <marc.zyngier@arm.com>
MIME-Version: 1.0
To: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"pawel.moll@arm.com" <pawel.moll@arm.com>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	"ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>,
	"galak@codeaurora.org" <galak@codeaurora.org>,
	Michal Simek <michals@xilinx.com>,
	Soren Brinkmann <sorenb@xilinx.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"arnd@arndb.de" <arnd@arndb.de>,
	"tinamdar@apm.com" <tinamdar@apm.com>,
	"treding@nvidia.com" <treding@nvidia.com>,
	"rjui@broadcom.com" <rjui@broadcom.com>,
	"Minghuan.Lian@freescale.com" <Minghuan.Lian@freescale.com>,
	"m-karicheri2@ti.com" <m-karicheri2@ti.com>,
	"hauke@hauke-m.de" <hauke@hauke-m.de>,
	"dhdang@apm.com" <dhdang@apm.com>,
	"sbranden@broadcom.com" <sbranden@broadcom.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Ravikiran Gummaluri <rgummal@xilinx.com>
Subject: Re: [PATCH v7] PCI: Xilinx-NWL-PCIe: Added support for Xilinx NWL
 PCIe Host Controller
References: <1446564227-4704-1-git-send-email-bharatku@xilinx.com> <5638DE62.6050605@arm.com> <8520D5D51A55D047800579B09414719801693C20@XAP-PVEXMBX01.xlnx.xilinx.com>
In-Reply-To: <8520D5D51A55D047800579B09414719801693C20@XAP-PVEXMBX01.xlnx.xilinx.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 04/11/15 06:38, Bharat Kumar Gogada wrote:
>>> +static struct msi_domain_info nwl_msi_domain_info = {
>>> +	.flags = (MSI_FLAG_USE_DEF_DOM_OPS |
>> MSI_FLAG_USE_DEF_CHIP_OPS |
>>> +		  MSI_FLAG_MULTI_PCI_MSI),
>>
>> If you're supporting multi-MSI, how do you ensure that all hwirqs are
>> contiguous as required by the spec? Clearly, your allocator doesn't provide
>> this guarantee.
>>
> Oh ok, then how can we know if one EP is requesting for multiple irq's, because in pci_enable_msi_range,
>  it does do while loop according to msi_capability_init return value 
> which in turn requests for multiple irq's. Is there any way to find out when single EP requesting for multiple MSI?

Please read what I've written: hwirqs *must* be contiguous for
multi-MSI. If the device requests 4 MSIs, they *must* be in the [x,x+3]
range. Your allocator only allocates one interrupt at time (ignoring the
nr_irqs parameter).

You shouldn't try to find what the device does, that's irrelevant at
that level.

>> Also, you still lack support for MSI-X (which would come for free...).
> 
> We don't support MSI-X in root port mode.

I don't believe you. If you support single MSI, you support MSI-X
(because that's mostly a property of the endpoint).

>>> +	.chip = &nwl_msi_irq_chip,
>>> +};
>>> +#endif
>>> +
>>> +	irq_domain_remove(pcie->legacy_irq_domain);
>>> +
>>> +#ifdef CONFIG_PCI_MSI
>>> +	irq_set_chained_handler_and_data(msi->irq_msi0, NULL, NULL);
>>> +	irq_set_chained_handler_and_data(msi->irq_msi1, NULL, NULL);
>>> +
>>> +	irq_domain_remove(msi->msi_domain);
>>> +	irq_domain_remove(msi->dev_domain);
>>> +#endif
>>> +
>>> +}
>>
>> Remove these #ifdefs. You can test the validity of these fields before calling
>> the various functions. You can also move this to a separate function.
> 
> Without #ifdefs if we compile driver for legacy, MSI structures will not be available and we get compile time error.

Legacy? Legacy interrupts? The msi structure is still there, you've
embedded it in your pcie structure. Let me spell it out for you:

static void nwl_msi_free_domain(struct nwl_pcie *pcie)
{
	struct nwl_msi *msi = &pcie->msi;

	if (msi->irq_msi0)
		irq_set_chained_handler_and_data(msi->irq_msi0, NULL, NULL);
	if (msi->irq_msi1)
		irq_set_chained_handler_and_data(msi->irq_msi1, NULL, NULL);

	if (msi->msi_domain)
		irq_domain_remove(msi->msi_domain);
	if (msi->dev_domain)
		irq_domain_remove(msi->dev_domain);
}

static void nwl_pcie_free_irq_domain(struct nwl_pcie *pcie)
{
	int i;
	u32 irq;

	for (i = 0; i < 4; i++) {
		irq = irq_find_mapping(pcie->legacy_irq_domain, i + 1);
		if (irq > 0)
			irq_dispose_mapping(irq);
	}

	irq_domain_remove(pcie->legacy_irq_domain);

	nwl_msi_free_domain(pcie);
}

>>> +
>>> +	/* setup AFI/FPCI range */
>>> +	msi->pages = __get_free_pages(GFP_KERNEL, 0);
>>> +	base = virt_to_phys((void *)msi->pages);
>>> +	nwl_bridge_writel(pcie, lower_32_bits(base), I_MSII_BASE_LO);
>>> +	nwl_bridge_writel(pcie, upper_32_bits(base), I_MSII_BASE_HI);
>>
>> I just read this, and I'm puzzled. Actually, puzzled is an understatement. Why
>> on Earth do you need to give RAM to your MSI HW?
>> This should be a device, not RAM. By the look of it, this could be absolutely
>> anything. Are you sure you have to supply RAM here?
>>
> This is required in our hardware, so that bridge identifies incoming MWr as MSI.

I'm asking why this has to be RAM. What is the actual requirement?

	M.
-- 
Jazz is not dead. It just smells funny...
