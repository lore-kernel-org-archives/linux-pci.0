Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:33496 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750787AbaGDHB0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 4 Jul 2014 03:01:26 -0400
Message-ID: <53B65141.5080002@huawei.com>
Date: Fri, 4 Jul 2014 15:01:21 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Brian Becker <brian.johnathan.b@gmail.com>
CC: Ilia Mirkin <imirkin@alum.mit.edu>,
	Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>,
	"nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>
Subject: Re: How to check for proper MSI support?
References: <CAKb7UviGCtebGwyHbXRLZhDOiDAez+eKkxPe9jz5kc-3R1kUvQ@mail.gmail.com>	<53B4F0F7.9020403@huawei.com>	<CALhae2jRz8hL0bwySAbP7r+vJGOG5aif4GA_Yjp0inGAwz5JEA@mail.gmail.com>	<53B612FE.4080105@huawei.com>	<CAKb7UviVFQYwYdp_dgxK7jJ5Ny9yG1y8LATydxtVtkzRh+aOKw@mail.gmail.com>	<53B61B03.3070308@huawei.com>	<CAKb7UvjFuu4Hm1pfmY-NMFORfv-+fx4oYeJicRoE8UTL_4Wp4A@mail.gmail.com>	<53B625D9.9080500@huawei.com>	<CAKb7UviYak+Jt6+RGFZc=OtNh2DVJaCvxnBpRRkw7zVn8u+9Vw@mail.gmail.com>	<53B642BA.3090007@huawei.com> <CALhae2iz0aC0qOJfg2utiwokO42b-Qn+qSUp2pWykZe0jpXp5Q@mail.gmail.com>
In-Reply-To: <CALhae2iz0aC0qOJfg2utiwokO42b-Qn+qSUp2pWykZe0jpXp5Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2014/7/4 14:26, Brian Becker wrote:
> I am booting a kernel with CONFIG_ACPI=n on a platform which does not
> support ACPI.

Hmmm, so my suggestion is
1. Add quirk to detect 430FX chipset, if detected, disable MSI in this platform.
or

2. Append boot argument pci=nomsi in OS command line when the OS running on your old platform.

Maybe other guys has some advices. :)




> 
> On Fri, Jul 4, 2014 at 1:59 AM, Yijing Wang <wangyijing@huawei.com> wrote:
>>>>> There is a NVIDIA G96 GPU (which is PCIe only) hanging off of a PCIe
>>>>> <-> PCI bridge (all on one card), which is plugged into a motherboard
>>>>> with the 430FX chipset (PCI 2.0 supported).
>>>>>
>>>>> The GPU PCI device, of course, has full support for MSI. However my
>>>>> understanding is that MSI won't actually work here. This is confirmed
>>>>> by the fact that if we let nouveau enable MSI, the device doesn't work
>>>>> (presumably due to lack of interrupt delivery, although I admit to not
>>>>> having debugged it that far). How do I, as a nouveau driver developer,
>>>>> know not to call pci_enable_msi? Or alternatively how can
>>>>> pci_enable_msi be taught not to succeed in this case?
>>>>
>>>> You can set bus_flags or global pci_msi_enable flag by add quirk function.
>>>> You can refer to examples in drivers/pci/quirk.c
>>>>
>>>> Linux support some broken chipsets or devices to disable msi during device initialization by add quirk.
>>>
>>> So let me get this straight -- you're suggesting I add a quirk for
>>> every PCI chipset that doesn't support MSI? There are probably
>>> hundreds of these... anything made before 1999 or so, and probably a
>>> bunch since then too. There _has_ to be a way to do this generically.
>>> Is the PCI spec version anywhere in the root hub?
>>
>> There is no register to identify PCI spec version in PCI config space registers.
>> If your platform boot up with ACPI, you can setting ACPI FADT boot flag to disable MSI,
>> you can refer to this in ACPI 5.2.9.3 chapter "Fixed ACPI Description Table Boot Architecture Flags"
>>
>>
>>>
>>> Perhaps we can check if every bridge on the way to the CPU has the MSI
>>> capability (including the root hub)? (And naturally _that_ won't
>>> work... on my sandybridge laptop, the host bridge doesn't have the MSI
>>> cap but the system most definitely supports MSI.)
>>>
>>> Adding Bjorn... perhaps you know? Some of the info has been stripped
>>> out by now, you can see the full lspci -vvvxxx at
>>> http://marc.info/?l=linux-pci&m=140443441730503&w=2
>>>
>>>   -ilia
>>>
>>> .
>>>
>>
>>
>> --
>> Thanks!
>> Yijing
>>
> 
> .
> 


-- 
Thanks!
Yijing

