Return-Path: <SRS0=YbMI=HR=rock-chips.com=shawn.lin@kernel.org>
Return-Path: <SRS0=YbMI=HR=rock-chips.com=shawn.lin@kernel.org>
Cc: shawn.lin@rock-chips.com, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/9] PCI: Add new helper for allocating irq domain for
 INTx
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1524817322-239028-1-git-send-email-shawn.lin@rock-chips.com>
 <1524817367-239076-1-git-send-email-shawn.lin@rock-chips.com>
 <20180427171812.GB8199@bhelgaas-glaptop.roam.corp.google.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <c1555892-1235-f8de-686c-ad17455af119@rock-chips.com>
Date: Sat, 28 Apr 2018 08:44:27 +0800
MIME-Version: 1.0
In-Reply-To: <20180427171812.GB8199@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=gbk; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On 2018/4/28 1:18, Bjorn Helgaas wrote:
> s/PCI: Add new helper for allocating irq domain for INTx/
>    PCI: Add pci_alloc_intx_irqd() for allocating IRQ domain
> 
> On Fri, Apr 27, 2018 at 04:22:47PM +0800, Shawn Lin wrote:
>> It seems host drivers which allocate irq domain for INTx
> 
> s/irq/IRQ/
> 
>> and the related code block looks highly similar to each other.
>> Add a new helper, pci_alloc_intx_irqd(), to avoid code duplication
>> as much as possible.
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>> ---
>>
>>   include/linux/pci.h | 74 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 74 insertions(+)
>>
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 73178a2..68a1994 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -31,6 +31,8 @@
>>   #include <linux/device.h>
>>   #include <linux/interrupt.h>
>>   #include <linux/io.h>
>> +#include <linux/irq.h>
>> +#include <linux/of_irq.h>
>>   #include <linux/resource_ext.h>
>>   #include <uapi/linux/pci.h>
>>   
>> @@ -1449,6 +1451,74 @@ static inline int pci_irqd_intx_xlate(struct irq_domain *d,
>>   	return 0;
>>   }
>>   
>> +static int pcie_intx_map(struct irq_domain *domain, unsigned int irq,
>> +				  irq_hw_number_t hwirq)
>> +{
>> +	irq_set_chip_and_handler(irq, &dummy_irq_chip, handle_simple_irq);
>> +	irq_set_chip_data(irq, domain->host_data);
>> +
>> +	return 0;
>> +}
>> +
>> +static struct irq_domain_ops pci_intx_domain_ops = {
>> +	.map = pcie_intx_map,
>> +};
>> +
>> +/**
>> + * pci_alloc_intx_irqd() - PCI helper for allocating INTx irq domain
> 
> s/PCI helper for allocating INTx irq domain/
>    Allocate INTx IRQ domain
> 
>> + * @dev: device associated with the PCI controller.
>> + * @host: pointer to host specific data struct
>> + * @general_xlate: flag for whether use pci_irqd_intx_xlate() helper
>> + * @intx_domain_ops: pointer to driver specific struct irq_domain_ops
>> + * @local_intc: pointer to driver specific interrupt controller node
>> + *
>> + * A simple helper for drivers to allocate irq domain for INTx. If
>> + * intx_domain_ops is NULL, use pci_intx_domain_ops by defalut. And if
>> + * local_intc is present, then use it firstly, otherwise, fallback to get
>> + * interrupt controller node from @dev.
> 
> s/irq/IRQ/
> s/defalut/default/
> 
>> + * Returns valid pointer of struct irq_domain on success, or PTR_ERR(-EINVAL)
>> + * if failure occurred.
>> + */
>> +static __maybe_unused struct irq_domain *pci_alloc_intx_irqd(struct device *dev,
>> +				void *host, bool general_xlate,
>> +				const struct irq_domain_ops *intx_domain_ops,
>> +				struct device_node *local_intc)
> 
> Why is this in the header file?  This is not a performance path and I
> don't want to deal with this __maybe_unused stuff.

Ah, I saw pci_irqd_intx_xlate() was here, and instinctively keep the
code close to it. Will move it to C file in v2.

> 
>> +{
>> +	struct device_node *intc = local_intc;
>> +	struct irq_domain *domain;
>> +	const struct irq_domain_ops *irqd_ops;
>> +	bool need_put = false;
>> +
>> +	if (!intc) {
>> +		intc = of_get_next_child(dev->of_node, NULL);
>> +		if (!intc) {
>> +			dev_err(dev, "missing child interrupt-controller node\n");
>> +			return ERR_PTR(-EINVAL);
>> +		}
>> +		need_put = true;
>> +	}
>> +
>> +	if (intx_domain_ops) {
>> +		irqd_ops = intx_domain_ops;
>> +	} else {
>> +		if (general_xlate)
>> +			pci_intx_domain_ops.xlate = &pci_irqd_intx_xlate;
>> +		irqd_ops = &pci_intx_domain_ops;
>> +	}
>> +
>> +	domain = irq_domain_add_linear(intc, PCI_NUM_INTX,
>> +				       irqd_ops, host);
>> +	if (!domain) {
>> +		dev_err(dev, "failed to get a INTx IRQ domain\n");
>> +		if (need_put)
>> +			of_node_put(intc);
>> +		return ERR_PTR(-EINVAL);
>> +	}
>> +
>> +	return domain;
>> +}
>> +
>>   #ifdef CONFIG_PCIEPORTBUS
>>   extern bool pcie_ports_disabled;
>>   #else
>> @@ -1683,6 +1753,10 @@ static inline int pci_irqd_intx_xlate(struct irq_domain *d,
>>   				      unsigned long *out_hwirq,
>>   				      unsigned int *out_type)
>>   { return -EINVAL; }
>> +
>> +static __maybe_unused struct irq_domain *pci_alloc_intx_irqd(struct device *dev,
>> +	void *host, bool general_xlate, const struct irq_domain_ops *ops)
>> +{ return ERR_PTR(-EINVAL); }
>>   #endif /* CONFIG_PCI */
>>   
>>   /* Include architecture-dependent settings and functions */
>> -- 
>> 1.9.1
>>
>>
> 
> 
> 
