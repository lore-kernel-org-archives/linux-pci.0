Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH V5 1/3] ARM64 LPC: Indirect ISA port IO introduced
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "zhichang.yuan" <yuanzhichang@hisilicon.com>
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
        <gabriele.paoloni@huawei.com>, <zhichang.yuan02@gmail.com>,
        <kantyzc@163.com>, <xuwei5@hisilicon.com>, <marc.zyngier@arm.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <79d73f93-1cf8-19db-ca5c-8fb6257edd6c@huawei.com>
Date: Mon, 21 Nov 2016 12:58:28 +0000
MIME-Version: 1.0
In-Reply-To: <1478647002.7430.69.camel@kernel.crashing.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 08/11/2016 23:16, Benjamin Herrenschmidt wrote:
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
> On POWER8, our PCIe doesn't do IO at all, but we have an LPC bus behind
> firmware calls ;-) We use that infrastructure to plumb in the LPC bus.
>
Hi,

I would like to mention another topic on supporting LPC, and this is 
regard to eSPI support.
eSPI is seen as the successor for LPC, and some BMCs already support it.

I had a chat with Arnd on this, and the idea to model LPC as a SPI bus 
adpater (and also eSPI).

However it seems to me that most platforms will/should support eSPI as a 
transparent bridge, same as LPC on x86. So I don't think that this is 
much point in modelling LPC/eSPI as a bus.

So we shall continue with indriect-IO support...

Thanks,
John
