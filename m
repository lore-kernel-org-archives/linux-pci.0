Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:38665 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933163AbcINOvK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Sep 2016 10:51:10 -0400
Subject: Re: [PATCH V3 2/4] ARM64 LPC: LPC driver implementation on Hip06
To: Arnd Bergmann <arnd@arndb.de>,
        <linux-arm-kernel@lists.infradead.org>
References: <1473855354-150093-1-git-send-email-yuanzhichang@hisilicon.com>
 <1473855354-150093-3-git-send-email-yuanzhichang@hisilicon.com>
 <5140357.dcW9ibtZJ6@wuerfel>
CC: <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <devicetree@vger.kernel.org>, <lorenzo.pieralisi@arm.com>,
        <benh@kernel.crashing.org>, <minyard@acm.org>,
        <linux-pci@vger.kernel.org>, <gabriele.paoloni@huawei.com>,
        <john.garry@huawei.com>, <will.deacon@arm.com>,
        <xuwei5@hisilicon.com>, <linux-serial@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <zourongrong@gmail.com>,
        <liviu.dudau@arm.com>, <kantyzc@163.com>,
        <zhichang.yuan02@gmail.com>
From: "zhichang.yuan" <yuanzhichang@hisilicon.com>
Message-ID: <57D963C4.4010406@hisilicon.com>
Date: Wed, 14 Sep 2016 22:50:44 +0800
MIME-Version: 1.0
In-Reply-To: <5140357.dcW9ibtZJ6@wuerfel>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 2016/9/14 20:33, Arnd Bergmann wrote:
> On Wednesday, September 14, 2016 8:15:52 PM CEST Zhichang Yuan wrote:
> 
>> +Required properties:
>> +- compatible: should be "hisilicon,low-pin-count"
>> +- #address-cells: must be 2 which stick to the ISA/EISA binding doc.
>> +- #size-cells: must be 1 which stick to the ISA/EISA binding doc.
>> +- reg: base address and length of the register set for the device.
>> +- ranges: define a 1:1 mapping between the I/O space of the child device and
>> +	  the parent.
> 
> Do we still need the "ranges" here? The property in your example seems
> wrong.

I think "ranges" is needed.
without this, of_translate_address --> __of_translate_address --> of_translate_one will fail when translating the child's IO resource.

> 
>> +	ranges = <0x01 0xe4 0x0 0xe4 0x1000>;
> 
> You translate I/O port 0x00e4 through 0x10e4 to CPU address 0x0e4?
The hip06 LPC is defined as isa type.
So, 0x01 0xe4 is the local IO address of 0xe4. With this ranges, 0xe4 of child will be 1:1 mapped as 0xe4.
It means no translation.

> 
>> +/**
>> + * hisilpc_children_map_sysio - setup the mapping between system Io and
>> + *			physical IO
>> + *
>> + * @child: the device whose IO is handling
>> + * @data: some device specific data. For ACPI device, should be NULL.
>> + *
>> + * Returns >=0 means the mapping is successfully created;
>> + * others mean some failures.
>> + */
>> +static int hisilpc_children_map_sysio(struct device * child, void * data)
>> +{
>> +	struct resource *iores;
>> +	unsigned long cpuio;
>> +	struct extio_ops *opsnode;
>> +	int ret;
>> +	struct hisilpc_dev *lpcdev;
>> +
>> +	if (!child || !child->parent)
>> +		return -EINVAL;
>> +
>> +	iores = platform_get_resource_byname(to_platform_device(child),
>> +					IORESOURCE_IO, "dev_io");
>> +	if (!iores)
>> +		return -ENODEV;
>> +
>> +	/*
>> +	 * can not use devm_kzalloc to allocate slab for child before its driver
>> +	 * start probing. Here allocate the slab with the name of parent.
>> +	 */
>> +	opsnode = devm_kzalloc(child->parent, sizeof(*opsnode), GFP_KERNEL);
>> +	if (!opsnode)
>> +		return -ENOMEM;
>> +
>> +	cpuio = data ? *((unsigned long *)data) : 0;
>> +
>> +	opsnode->start = iores->start;
>> +	opsnode->end = iores->end;
>> +	opsnode->ptoffset = cpuio ? (cpuio - iores->start) : 0;
>> +
>> +	dev_info(child, "map sys port[%lx - %lx] offset=0x%lx",
>> +				(unsigned long)iores->start,
>> +				(unsigned long)iores->end,
>> +				opsnode->ptoffset);
>> +
>> +	opsnode->pfin = hisilpc_comm_inb;
>> +	opsnode->pfout = hisilpc_comm_outb;
>> +
>> +	lpcdev = platform_get_drvdata(to_platform_device(child->parent));
>> +	opsnode->devpara = lpcdev;
>> +
>> +	/* only apply indirect-IO to ipmi child device */
> 
> I don't get this part. The bus driver should not care what its
> children are, just register and PIO ranges that the bus can handle
> in theory, i.e. from 0x000 to 0xfff.

Just as we discussed in V2, the legacy PIO range is specific to some device, such as for ipmi bt, 0xe4 - 0xe7 will be populated.
I don't want to occupy a larger PIO range in which only small part PIOs are used by our LPC. At this moment, two PIO ranges are using
through the device property configuration, 0xe4-0xe7, 0x2f8-0x2ff.
If we configure 0-0x1000 for the LPC to cover those two ranges, most PIO are wasted and other PIO device on other buses lose the chance to use the PIO below 0x1000.
Otherwise, PIO conflict will happen. So, My idea is only occupied the PIO ranges which are really needed for the children.

And there are probably multiple child devices under LPC, the global arm64_extio_ops only can cover one PIO range. It is fortunate only ipmi driver can not support I/O
operation registering, serial driver has serial_in/serial_out to be registered. So, only the PIO range for ipmi device is stored in arm64_extio_ops and the indirect-IO
works well for ipmi device.

If we think it is nearly no chance that LPC PIO range conflict with other buses, we can allocate 0xe4 - 0x2ff to LPC and store it to arm64_extio_ops. In this case,
the special processing for ipmi device is not needed.

Best,
Zhichang

> 
> 	Arnd
> 
> 
> .
> 

