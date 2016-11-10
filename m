Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:35332 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932295AbcKJMhL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Nov 2016 07:37:11 -0500
Subject: Re: [PATCH V5 3/3] ARM64 LPC: LPC driver implementation on Hip06
To: Arnd Bergmann <arnd@arndb.de>,
        <linux-arm-kernel@lists.infradead.org>
References: <1478576829-112707-1-git-send-email-yuanzhichang@hisilicon.com>
 <2825537.ADCNsGqGxn@wuerfel> <5824165A.4040303@hisilicon.com>
 <17821285.aIcTyCGn5n@wuerfel>
CC: "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        "minyard@acm.org" <minyard@acm.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        John Garry <john.garry@huawei.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xuwei (O)" <xuwei5@hisilicon.com>, Linuxarm <linuxarm@huawei.com>,
        "zourongrong@gmail.com" <zourongrong@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kantyzc@163.com" <kantyzc@163.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "liviu.dudau@arm.com" <liviu.dudau@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "zhichang.yuan02@gmail.com" <zhichang.yuan02@gmail.com>
From: "zhichang.yuan" <yuanzhichang@hisilicon.com>
Message-ID: <582469C8.9090609@hisilicon.com>
Date: Thu, 10 Nov 2016 20:36:24 +0800
MIME-Version: 1.0
In-Reply-To: <17821285.aIcTyCGn5n@wuerfel>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi, Arnd,

On 2016/11/10 17:12, Arnd Bergmann wrote:
> On Thursday, November 10, 2016 2:40:26 PM CET zhichang.yuan wrote:
>> On 2016/11/10 5:34, Arnd Bergmann wrote:
>>> On Wednesday, November 9, 2016 12:10:43 PM CET Gabriele Paoloni wrote:
>>>>> On Tuesday, November 8, 2016 11:47:09 AM CET zhichang.yuan wrote:
>>>>>> +       /*
>>>>>> +        * The first PCIBIOS_MIN_IO is reserved specifically for
>>>>> indirectIO.
>>>>>> +        * It will separate indirectIO range from pci host bridge to
>>>>>> +        * avoid the possible PIO conflict.
>>>>>> +        * Set the indirectIO range directly here.
>>>>>> +        */
>>>>>> +       lpcdev->io_ops.start = 0;
>>>>>> +       lpcdev->io_ops.end = PCIBIOS_MIN_IO - 1;
>>>>>> +       lpcdev->io_ops.devpara = lpcdev;
>>>>>> +       lpcdev->io_ops.pfin = hisilpc_comm_in;
>>>>>> +       lpcdev->io_ops.pfout = hisilpc_comm_out;
>>>>>> +       lpcdev->io_ops.pfins = hisilpc_comm_ins;
>>>>>> +       lpcdev->io_ops.pfouts = hisilpc_comm_outs;
>>>>>
>>>>> I have to look at patch 2 in more detail again, after missing a few
>>>>> review
>>>>> rounds. I'm still a bit skeptical about hardcoding a logical I/O port
>>>>> range here, and would hope that we can just go through the same
>>>>> assignment of logical port ranges that we have for PCI buses,
>>>>> decoupling
>>>>> the bus addresses from the linux-internal ones.
>>>>
>>>> The point here is that we want to avoid any conflict/overlap between
>>>> the LPC I/O space and the PCI I/O space. With the assignment above
>>>> we make sure that LPC never interfere with PCI I/O space.
>>>
>>> But we already abstract the PCI I/O space using dynamic registration.
>>> There is no need to hardcode the logical address for ISA, though
>>> I think we can hardcode the bus address to start at zero here.
>>
>> Do you means that we can pick up the maximal I/O address from all children's
>> device resources??
> 
> The driver should not look at the resources of its children, just
> register a range of addresses dynamically, as I suggested in an
> earlier review.
>
Sorry! I can't catch your idea yet:(

When to register the I/O range? Is it done just after the successfully
of_translate_address() during the children scanning?

If yes, when a child is scanning, there is no range data in arm64_extio_ops. The
addr_is_indirect_io() calling in of_get_isa_indirect_io() don't need. All we can
check is just whether the address to be translated is IO and is under a parent
device which has no 'ranges' property.

> 
> Your current version has
> 
>         if (arm64_extio_ops->pfout)                             \
>                 arm64_extio_ops->pfout(arm64_extio_ops->devpara,\
>                        addr, value, sizeof(type));             \
> 
> Instead, just subtract the start of the range from the logical
> port number to transform it back into a bus-local port number:
> 
>         if (arm64_extio_ops->pfout)                             \
>                 arm64_extio_ops->pfout(arm64_extio_ops->devpara,\
>                        addr - arm64_extio_ops->start, value, sizeof(type)); \
> 
I think there is some information needed sync.
In the old patch-set, we don't bypass the pci_address_to_pio() after
successfully of_translate_address(). In this way, we don't need to reserve any
PIO space for our LPC since the logical port are from the same mapping
algorithm. Based on this way, the port number in the device resource is logical
one, then we need to subtract the start of the resource to get back the
bus-local port.

>From V3, we don't apply the mapping based on pci_address_to_pio(), the
of_translate_address() return the bus-local port directly and store into
relevant device resource. So, in the current arm64_extio_ops->pfout(), the
reverse translation don't need anymore. The input "addr" is bus-local port now.


Thanks,
Zhichang


> We know that the ISA/LPC bus can only have up to 65536 ports,
> so you can register all of those, or possibly limit it further to
> 1024 or 4096 ports, whichever matches the bus implementation.
> 
> 	Arnd
> 
> .
> 

