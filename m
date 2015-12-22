Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH v7 3/4] gicv2m: Refactor to prepare for ACPI support
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1449766530-16935-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <1449766530-16935-4-git-send-email-Suravee.Suthikulpanit@amd.com>
 <20151216221208.GC27791@localhost> <56720095.70004@amd.com>
 <20151217165713.GA23549@localhost>
CC: <marc.zyngier@arm.com>, <tglx@linutronix.de>,
	<jason@lakedaemon.net>, <rjw@rjwysocki.net>, <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <Catalin.Marinas@arm.com>,
	<hanjun.guo@linaro.org>, <tomasz.nowicki@linaro.org>,
	<graeme.gregory@linaro.org>, <dhdang@apm.com>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
From: Suravee Suthikulanit <suravee.suthikulpanit@amd.com>
Message-ID: <5679D6EF.6000002@amd.com>
Date: Tue, 22 Dec 2015 17:04:15 -0600
MIME-Version: 1.0
In-Reply-To: <20151217165713.GA23549@localhost>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 12/17/2015 10:57 AM, Bjorn Helgaas wrote:
> On Wed, Dec 16, 2015 at 06:23:49PM -0600, Suravee Suthikulanit wrote:
>> Hi Bjorn,
>>
>> Thanks for your review. Please see my comments below.
>>
>> On 12/16/2015 4:12 PM, Bjorn Helgaas wrote:
>>> On Thu, Dec 10, 2015 at 08:55:29AM -0800, Suravee Suthikulpanit wrote:
>>>> This patch replaces the struct device_node with struct fwnode_handle
>>>> since this structure is common between DT and ACPI.
>>>>
>>>> It also refactors gicv2m_init_one() to prepare for ACPI support.
>>>> The only functional change is removing the node name from pr_info.
>>>>
>>>> Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
>>>> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>>>
>>>> @@ -359,10 +355,10 @@ static int __init gicv2m_init_one(struct device_node *node,
>>>>   	}
>>>>
>>>>   	list_add_tail(&v2m->entry, &v2m_nodes);
>>>> -	pr_info("Node %s: range[%#lx:%#lx], SPI[%d:%d]\n", node->name,
>>>> -		(unsigned long)v2m->res.start, (unsigned long)v2m->res.end,
>>>> -		v2m->spi_start, (v2m->spi_start + v2m->nr_spis));
>>>>
>>>> +	pr_info("range[%#lx:%#lx], SPI[%d:%d]\n",
>>>> +		(unsigned long)res->start, (unsigned long)res->end,
>>>> +		v2m->spi_start, (v2m->spi_start + v2m->nr_spis));
>>>
>>> You didn't change this, but I don't think this message has enough
>>> context.  It's pretty cryptic all by itself.  It'd be nice if it could
>>> at least include a device name, e.g., if you could use dev_info().
>>
>> Here is the example of the information printed:
>> [    0.000000] GICv2m: range[0xe1180000:0xe1181000], SPI[64:320]
>>
>> Basically, the v2m is just an extension of the GIC. Here, we are
>> printing the memory range that it is covering, which can be used to
>> identify different V2m frame and the associate interrupt range
>> (SPI). The node name is not really providing any values. So, we are
>> removing it.
>
> I noticed the pr_fmt definition later; that adds some useful context I
> didn't know about.  I guess there's no struct device for the GIC?  I
> don't see one in struct device_node.  Seems like this piece of
> hardware that apparently responds to a memory range *could* have a
> struct device,but I'm a little fuzzy on how we handle ACPI and OF
> device descriptions in that regard.

For DT, v2m is advertised as a sub-node inside GIC. So, both of them has 
the struct device_node references. IIUC, GIC node is match as irqchip, 
and not as a traditional platform bus device.

Similarly, for ACPI, v2m is advertised as a sub-table inside MADT, and 
we are using the fwnode_handle to reference to.

> I hadn't noticed the memory range part; maybe you could use %pR there?

I guess we could have :) I can send a separate patch to clean this up.

> Just to double-check, there's no off-by-one error in the SPI range, is
> there?  The pattern I usually expect is "start, start + nr_items - 1".

In that case, this should have been [64:319]. I'll send a small patch to 
clean this up.

> I'm just kibbitzing here; this isn't PCI code, and you don't need my
> ack, so just consider these as random observations.
>
> Bjorn
>

Thanks for sharing your observation. It's always been good ones :)

Suravee
