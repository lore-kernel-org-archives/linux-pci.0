Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH V5 3/3] ARM64 LPC: LPC driver implementation on Hip06
To: Arnd Bergmann <arnd@arndb.de>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>
References: <1478576829-112707-1-git-send-email-yuanzhichang@hisilicon.com>
 <17821285.aIcTyCGn5n@wuerfel>
 <EE11001F9E5DDD47B7634E2F8A612F2E1F8F5D75@lhreml507-mbx>
 <10334260.ztLXZ2Oynd@wuerfel>
CC: "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
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
        "bhelgaas@googl e.com" <bhelgaas@google.com>,
        "zhichang.yuan02@gmail.com" <zhichang.yuan02@gmail.com>
From: "zhichang.yuan" <yuanzhichang@hisilicon.com>
Message-ID: <582598ED.6080803@hisilicon.com>
Date: Fri, 11 Nov 2016 18:09:49 +0800
MIME-Version: 1.0
In-Reply-To: <10334260.ztLXZ2Oynd@wuerfel>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi, Arnd,

On 2016/11/11 0:07, Arnd Bergmann wrote:
> On Thursday, November 10, 2016 3:36:49 PM CET Gabriele Paoloni wrote:
>>
>> Where should we get the range from? For LPC we know that it is going
>> Work on anything that is not used by PCI I/O space, and this is 
>> why we use [0, PCIBIOS_MIN_IO]
> 
> It should be allocated the same way we allocate PCI config space
> segments. This is currently done with the io_range list in
> drivers/pci/pci.c, which isn't perfect but could be extended
> if necessary. Based on what others commented here, I'd rather
> make the differences between ISA/LPC and PCI I/O ranges smaller
> than larger.
> 
>>> Your current version has
>>>
>>>         if (arm64_extio_ops->pfout)                             \
>>>                 arm64_extio_ops->pfout(arm64_extio_ops->devpara,\
>>>                        addr, value, sizeof(type));             \
>>>
>>> Instead, just subtract the start of the range from the logical
>>> port number to transform it back into a bus-local port number:
>>
>> These accessors do not operate on IO tokens:
>>
>> If (arm64_extio_ops->start > addr || arm64_extio_ops->end < addr)
>> addr is not going to be an I/O token; in fact patch 2/3 imposes that
>> the I/O tokens will start at PCIBIOS_MIN_IO. So from 0 to PCIBIOS_MIN_IO
>> we have free physical addresses that the accessors can operate on.
> 
> Ah, I missed that part. I'd rather not use PCIBIOS_MIN_IO to refer to
> the logical I/O tokens, the purpose of that macro is really meant
> for allocating PCI I/O port numbers within the address space of
> one bus.
> 
> Note that it's equally likely that whichever next platform needs
> non-mapped I/O access like this actually needs them for PCI I/O space,
> and that will use it on addresses registered to a PCI host bridge.
> 
> If we separate the two steps:
> 
> a) assign a range of logical I/O port numbers to a bus
> b) register a set of helpers for redirecting logical I/O
>    port to a helper function
>
It seems that we need to add a new bus and the corresponding resource management
which can also cover current PCI pio mapping, is it right?

Thanks,
Zhichang

> then I think the code will get cleaner and more flexible.
> It should actually then be able to replace the powerpc
> specific implementation.
> 
> 	Arnd
> 
> .
> 
