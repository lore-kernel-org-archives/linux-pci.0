Return-Path: <guohanjun@huawei.com>
Return-Path: <guohanjun@huawei.com>
Subject: Re: [PATCH V8 5/8] irqchip/gicv3-its: Refactor ITS DT init code to
 prepare for ACPI
To: Tomasz Nowicki <tn@semihalf.com>, Bjorn Helgaas <helgaas@kernel.org>
References: <1470909998-16710-1-git-send-email-tn@semihalf.com>
 <1470909998-16710-6-git-send-email-tn@semihalf.com>
 <57B4213E.3060201@huawei.com> <20160817155832.GA25421@localhost>
 <00af2bfa-0869-75e0-8a9a-4d7e0cafb687@semihalf.com>
CC: <marc.zyngier@arm.com>, <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <rjw@rjwysocki.net>, <rafael@kernel.org>, <Lorenzo.Pieralisi@arm.com>,
        <will.deacon@arm.com>, <catalin.marinas@arm.com>,
        <hanjun.guo@linaro.org>, <shijie.huang@arm.com>,
        <robert.richter@caviumnetworks.com>, <mw@semihalf.com>,
        <linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linaro-acpi@lists.linaro.org>, <andrea.gallo@linaro.org>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <al.stone@linaro.org>, <graeme.gregory@linaro.org>,
        <ddaney.cavm@gmail.com>, <okaya@codeaurora.org>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <57B55BEA.6070702@huawei.com>
Date: Thu, 18 Aug 2016 14:55:38 +0800
MIME-Version: 1.0
In-Reply-To: <00af2bfa-0869-75e0-8a9a-4d7e0cafb687@semihalf.com>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-pci.vger.kernel.org>

On 2016/8/18 14:42, Tomasz Nowicki wrote:
> On 17.08.2016 17:58, Bjorn Helgaas wrote:
>> On Wed, Aug 17, 2016 at 04:33:02PM +0800, Hanjun Guo wrote:
>>> On 2016/8/11 18:06, Tomasz Nowicki wrote:
>>>> In order to add ACPI support we need to isolate ACPI&DT common code and
>>>> move DT logic to corresponding functions. To achieve this we are using
>>>> firmware agnostic handle which can be unpacked to either DT or ACPI node.
>>>>
>>>> No functional changes other than a very minor one:
>>>> 1. Terminate its_init call with -ENODEV for non-DT case which allows
>>>> to remove hack from its-gic-v3.c.
>>>> 2. Fix ITS base register address type (from 'unsigned long' to 'phys_addr_t'),
>>>> as a bonus we get nice string formatting.
>>>> 3. Since there is only one of ITS parent domain convert it to static global
>>>> variable and drop the parameter from its_probe_one. Users can refer to it
>>>> in more convenient way then.
>>> [...]
>>>> -static int __init its_probe(struct device_node *node,
>>>> -                struct irq_domain *parent)
>>>> +static int __init its_probe_one(struct resource *res,
>>>> +                struct fwnode_handle *handle, int numa_node)
>>>>  {
>>>> -    struct resource res;
>>>>      struct its_node *its;
>>>>      void __iomem *its_base;
>>>>      u32 val;
>>>>      u64 baser, tmp;
>>>>      int err;
>>>>
>>>> -    err = of_address_to_resource(node, 0, &res);
>>>> -    if (err) {
>>>> -        pr_warn("%s: no regs?\n", node->full_name);
>>>> -        return -ENXIO;
>>>> -    }
>>>> -
>>>> -    its_base = ioremap(res.start, resource_size(&res));
>>>> +    its_base = ioremap(res->start, resource_size(res));
>>>>      if (!its_base) {
>>>> -        pr_warn("%s: unable to map registers\n", node->full_name);
>>>> +        pr_warn("ITS@%pa: Unable to map ITS registers\n", &res->start);
>>>>          return -ENOMEM;
>>>>      }
>>>>
>>>>      val = readl_relaxed(its_base + GITS_PIDR2) & GIC_PIDR2_ARCH_MASK;
>>>>      if (val != 0x30 && val != 0x40) {
>>>> -        pr_warn("%s: no ITS detected, giving up\n", node->full_name);
>>>> +        pr_warn("ITS@%pa: No ITS detected, giving up\n", &res->start);
>>>>          err = -ENODEV;
>>>>          goto out_unmap;
>>>>      }
>>>>
>>>>      err = its_force_quiescent(its_base);
>>>>      if (err) {
>>>> -        pr_warn("%s: failed to quiesce, giving up\n",
>>>> -            node->full_name);
>>>> +        pr_warn("ITS@%pa: Failed to quiesce, giving up\n", &res->start);
>>>>          goto out_unmap;
>>>>      }
>>>>
>>>> -    pr_info("ITS: %s\n", node->full_name);
>>>> +    pr_info("ITS@%pa\n", &res->start);
>>>                 ^^
>>>
>>> When I was testing this patch set I found message printed as below:
>>>
>>> [    0.000000] ITS@0x00000000c6000000
>>
>> I think it'd be nicer to print the resource with %pR so we see the
>> type and size in a way that matches other physical address usage.
>
> The intention was to keep previous message layout but while we are here, %pR usage for this one pr_info seems nice to me.
>
>>
>> I don't know whether there is or should be a struct device associated
>> with the ITS.  The its_probe_one() function looks similar to regular
>> driver probe functions, so maybe there should be.
>>
>> If there were a struct device associated with the ITS, it'd be nicer
>> to use dev_info() as well, of course.
>
> Indeed dev_info() would be nice but there is no struct device for ITS.

Yes, it's configured in the MADT table not in the DSDT, which has no struct
device associated with it.

Thanks
Hanjun
