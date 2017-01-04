Return-Path: <SRS0=IKS2=YS=gmail.com=valmikibow@kernel.org>
Return-Path: <SRS0=IKS2=YS=gmail.com=valmikibow@kernel.org>
Subject: Re: Need clarity on PCIe MSI interrupt in device tree
To: Marc Zyngier <marc.zyngier@arm.com>, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <2fea5a0c-7410-97fd-91d1-ae6a06ab1a52@gmail.com>
 <fb1ae45f-1682-c523-ed02-48ca1b890791@arm.com>
Cc: helgaas@kernel.org, arnd@arndb.de, mark.rutland@arm.com
From: valmiki <valmikibow@gmail.com>
Message-ID: <9f95d60a-6684-3205-eeb0-df86cfe430e4@gmail.com>
Date: Wed, 4 Jan 2017 22:58:59 +0530
MIME-Version: 1.0
In-Reply-To: <fb1ae45f-1682-c523-ed02-48ca1b890791@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Thans Marc

On 1/4/2017 1:59 PM, Marc Zyngier wrote:
> On 04/01/17 03:17, valmiki wrote:
>> Hi,
>>
>> I have confusion on MSI interrupt flags in PCIe documetation.
>>
>> MSI interrupts are edge triggered, but i see some controllers use
>> Ex:tegra <0 99 0x4>, here interrupt flags show 0x4 which means level
>> sensitive as per include/dt-bindings/interrupt-controller/irq.h.
>>
>> May i know why is it like this, why MSI depicted as level sensitive in
>> device tree.
>
> They are not. MSIs are *not* present in the device tree at all.
>
> What you have here is the cascade interrupt from an MSI controller to
> another interrupt controller (probably a GICv2), and that particular
> interrupt is level triggered. Which is perfectly fine if that's the
> signalling method between the two controllers.
>
> This doesn't in any way reflect how MSIs are signalled.
>
> Thanks,
>
> 	M.
>
