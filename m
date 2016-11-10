Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:14151 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753743AbcKJIde (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Nov 2016 03:33:34 -0500
Subject: Re: [PATCH V5 1/3] ARM64 LPC: Indirect ISA port IO introduced
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <1478576829-112707-1-git-send-email-yuanzhichang@hisilicon.com>
 <1478576829-112707-2-git-send-email-yuanzhichang@hisilicon.com>
 <20161108120323.GC15297@leverpostej>
 <1478647002.7430.69.camel@kernel.crashing.org>
CC: <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <robh+dt@kernel.org>, <bhelgaas@google.com>, <olof@lixom.net>,
        <arnd@arndb.de>, <linux-arm-kernel@lists.infradead.org>,
        <lorenzo.pieralisi@arm.com>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <devicetree@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <minyard@acm.org>, <liviu.dudau@arm.com>, <zourongrong@gmail.com>,
        <john.garry@huawei.com>, <gabriele.paoloni@huawei.com>,
        <zhichang.yuan02@gmail.com>, <kantyzc@163.com>,
        <xuwei5@hisilicon.com>, <marc.zyngier@arm.com>
From: "zhichang.yuan" <yuanzhichang@hisilicon.com>
Message-ID: <582430C6.60307@hisilicon.com>
Date: Thu, 10 Nov 2016 16:33:10 +0800
MIME-Version: 1.0
In-Reply-To: <1478647002.7430.69.camel@kernel.crashing.org>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi, Ben,


On 2016/11/9 7:16, Benjamin Herrenschmidt wrote:
> On Tue, 2016-11-08 at 12:03 +0000, Mark Rutland wrote:
>> On Tue, Nov 08, 2016 at 11:47:07AM +0800, zhichang.yuan wrote:
>>>
>>> For arm64, there is no I/O space as other architectural platforms, such as
>>> X86. Most I/O accesses are achieved based on MMIO. But for some arm64 SoCs,
>>> such as Hip06, when accessing some legacy ISA devices connected to LPC, those
>>> known port addresses are used to control the corresponding target devices, for
>>> example, 0x2f8 is for UART, 0xe4 is for ipmi-bt. It is different from the
>>> normal MMIO mode in using.
>>
>> This has nothing to do with arm64. Hardware with this kind of indirect
>> bus access could be integrated with a variety of CPU architectures. It
>> simply hasn't been, yet.
> 
> On some ppc's we also use similar indirect access methods for IOs. We
> have a generic infrastructure for re-routing some memory or IO regions
> to hooks.
> 
I am interested on the generic infrastructure on PPC.
Could you point out where those drivers are?
want to take a look..

Thanks,
Zhichang

> On POWER8, our PCIe doesn't do IO at all, but we have an LPC bus behind
> firmware calls ;-) We use that infrastructure to plumb in the LPC bus.
> 
>>> To drive these devices, this patch introduces a method named indirect-IO.
>>> In this method the in/out pair in arch/arm64/include/asm/io.h will be
>>> redefined. When upper layer drivers call in/out with those known legacy port
>>> addresses to access the peripherals, the hooking functions corrresponding to
>>> those target peripherals will be called. Through this way, those upper layer
>>> drivers which depend on in/out can run on Hip06 without any changes.
>>
>> As above, this has nothing to do with arm64, and as such, should live in
>> generic code, exactly as we would do if we had higher-level ISA
>> accessor ops.
>>
>> Regardless, given the multi-instance case, I don't think this is
>> sufficient in general (and I think we need higher-level ISA accessors
>> to handle the indirection).
> 
> Multi-instance with IO is tricky to do generically because archs already
> have all sort of hacks to deal with the fact that inb/outb don't require
> an explicit ioremap, so an IO resource can take all sort of shape depending
> on the arch.
> 
> Overall it boils down to applying some kind of per-instance "offset" to
> the IO port number though.
> 

