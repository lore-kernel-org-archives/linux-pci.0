Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH V5 3/3] ARM64 LPC: LPC driver implementation on Hip06
To: Arnd Bergmann <arnd@arndb.de>,
        <linux-arm-kernel@lists.infradead.org>
References: <1478576829-112707-1-git-send-email-yuanzhichang@hisilicon.com>
 <1555494.4IFvGxvsfe@wuerfel>
 <EE11001F9E5DDD47B7634E2F8A612F2E1F8F1A7A@lhreml507-mbx>
 <2825537.ADCNsGqGxn@wuerfel>
CC: Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "minyard@acm.org" <minyard@acm.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        John Garry <john.garry@huawei.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xuwei (O)" <xuwei5@hisilicon.com>, Linuxarm <linuxarm@huawei.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "zourongrong@gmail.com" <zourongrong@gmail.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "liviu.dudau@arm.com" <liviu.dudau@arm.com>,
        "kantyzc@163.com" <kantyzc@163.com>,
        "zhichang.yuan02@gmail.com" <zhichang.yuan02@gmail.com>
From: "zhichang.yuan" <yuanzhichang@hisilicon.com>
Message-ID: <5824165A.4040303@hisilicon.com>
Date: Thu, 10 Nov 2016 14:40:26 +0800
MIME-Version: 1.0
In-Reply-To: <2825537.ADCNsGqGxn@wuerfel>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi, Arnd,

On 2016/11/10 5:34, Arnd Bergmann wrote:
> On Wednesday, November 9, 2016 12:10:43 PM CET Gabriele Paoloni wrote:
>>> On Tuesday, November 8, 2016 11:47:09 AM CET zhichang.yuan wrote:
>>>> +       /*
>>>> +        * The first PCIBIOS_MIN_IO is reserved specifically for
>>> indirectIO.
>>>> +        * It will separate indirectIO range from pci host bridge to
>>>> +        * avoid the possible PIO conflict.
>>>> +        * Set the indirectIO range directly here.
>>>> +        */
>>>> +       lpcdev->io_ops.start = 0;
>>>> +       lpcdev->io_ops.end = PCIBIOS_MIN_IO - 1;
>>>> +       lpcdev->io_ops.devpara = lpcdev;
>>>> +       lpcdev->io_ops.pfin = hisilpc_comm_in;
>>>> +       lpcdev->io_ops.pfout = hisilpc_comm_out;
>>>> +       lpcdev->io_ops.pfins = hisilpc_comm_ins;
>>>> +       lpcdev->io_ops.pfouts = hisilpc_comm_outs;
>>>
>>> I have to look at patch 2 in more detail again, after missing a few
>>> review
>>> rounds. I'm still a bit skeptical about hardcoding a logical I/O port
>>> range here, and would hope that we can just go through the same
>>> assignment of logical port ranges that we have for PCI buses,
>>> decoupling
>>> the bus addresses from the linux-internal ones.
>>
>> The point here is that we want to avoid any conflict/overlap between
>> the LPC I/O space and the PCI I/O space. With the assignment above
>> we make sure that LPC never interfere with PCI I/O space.
> 
> But we already abstract the PCI I/O space using dynamic registration.
> There is no need to hardcode the logical address for ISA, though
> I think we can hardcode the bus address to start at zero here.

Do you means that we can pick up the maximal I/O address from all children's
device resources??

Thanks,
Zhichang

> 
> 	Arnd
> 
> .
> 
