Return-Path: <SRS0=h6uj=ZN=huawei.com=john.garry@kernel.org>
Return-Path: <SRS0=h6uj=ZN=huawei.com=john.garry@kernel.org>
Subject: Re: [PATCH V6 1/5] LIB: Indirect ISA/LPC port IO introduced
To: Bjorn Helgaas <helgaas@kernel.org>,
        "zhichang.yuan"
	<yuanzhichang@hisilicon.com>
References: <1485241525-201782-1-git-send-email-yuanzhichang@hisilicon.com>
 <1485241525-201782-2-git-send-email-yuanzhichang@hisilicon.com>
 <20170131000914.GA11331@bhelgaas-glaptop.roam.corp.google.com>
CC: <catalin.marinas@arm.com>, <will.deacon@arm.com>, <robh+dt@kernel.org>,
        <frowand.list@gmail.com>, <bhelgaas@google.com>, <rafael@kernel.org>,
        <mark.rutland@arm.com>, <brian.starkey@arm.com>, <olof@lixom.net>,
        <arnd@arndb.de>, <linux-arm-kernel@lists.infradead.org>,
        <lorenzo.pieralisi@arm.com>, <benh@kernel.crashing.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <devicetree@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <minyard@acm.org>,
        <liviu.dudau@arm.com>, <zourongrong@gmail.com>,
        <gabriele.paoloni@huawei.com>, <zhichang.yuan02@gmail.com>,
        <kantyzc@163.com>, <xuwei5@hisilicon.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <fec21b66-4ba7-3855-af53-a0e2856754a4@huawei.com>
Date: Tue, 31 Jan 2017 13:34:24 +0000
MIME-Version: 1.0
In-Reply-To: <20170131000914.GA11331@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
List-ID: <linux-pci.vger.kernel.org>

On 31/01/2017 00:09, Bjorn Helgaas wrote:
> On Tue, Jan 24, 2017 at 03:05:21PM +0800, zhichang.yuan wrote:
>> Low-pin-count interface is integrated into some SoCs. The accesses to those
>> peripherals under LPC make use of I/O ports rather than the memory mapped I/O.
>>
>> To drive these devices, this patch introduces a method named indirect-IO.
>
> It's slightly confusing to call this "indirect I/O" and then use
> "extio" for the filename and function prefix.  It'd be nice to use
> related names.

We will consider something more consistent.

>
>> +struct extio_node {
>> +	unsigned long bus_start;	/* bus start address */
>> +	unsigned long io_start;	/* io port token corresponding to bus_start */
>> +	size_t range_size;	/* size of the extio node operating range */
>> +	struct fwnode_handle *fwnode;
>> +	struct list_head list;
>> +	struct extio_ops *ops;	/* ops operating on this node */
>> +	void *devpara;	/* private parameter of the host device */
>> +};
>
> I wish we didn't have both struct io_range and struct extio_node.  It
> seems like they're both sort of trying to do the same thing.  Maybe
> this is the same as what Alex is saying.
>

I think so. I have just replied to Alex regarding this.

> Bjorn
>

Thanks,
John

> .
>
