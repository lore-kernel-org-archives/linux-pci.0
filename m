Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:34237 "EHLO
        mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753817AbcIUKIb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Sep 2016 06:08:31 -0400
Subject: Re: [PATCH V3 2/4] ARM64 LPC: LPC driver implementation on Hip06
To: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org
References: <1473855354-150093-1-git-send-email-yuanzhichang@hisilicon.com>
 <8360154.kzsE8V8pTW@wuerfel>
 <EE11001F9E5DDD47B7634E2F8A612F2E1F871F72@lhreml507-mbx>
 <26171742.fWcrANu6EP@wuerfel>
Cc: Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "minyard@acm.org" <minyard@acm.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        John Garry <john.garry@huawei.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yuanzhichang <yuanzhichang@hisilicon.com>,
        Linuxarm <linuxarm@huawei.com>,
        "xuwei (O)" <xuwei5@hisilicon.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "zourongrong@gmail.com" <zourongrong@gmail.com>,
        "liviu.dudau@arm.com" <liviu.dudau@arm.com>,
        "kantyzc@163.com" <kantyzc@163.com>
From: zhichang <zhichang.yuan02@gmail.com>
Message-ID: <e246c886-e0eb-b635-01ae-f00bbfcfb56b@gmail.com>
Date: Wed, 21 Sep 2016 18:09:11 +0800
MIME-Version: 1.0
In-Reply-To: <26171742.fWcrANu6EP@wuerfel>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi, Arnd,



On 2016年09月15日 20:24, Arnd Bergmann wrote:
> On Thursday, September 15, 2016 12:05:51 PM CEST Gabriele Paoloni wrote:
>>> -----Original Message-----
>>> On Thursday, September 15, 2016 8:02:27 AM CEST Gabriele Paoloni wrote:
>>>>
>>>> From <<3.1.1. Open Firmware Properties for Bus Nodes>> in
>>>> http://www.firmware.org/1275/bindings/isa/isa0_4d.ps
>>>>
>>>> I quote:
>>>> "There shall be an entry in the "ranges" property for each
>>>> of the Memory and/or I/O spaces if that address space is
>>>> mapped through the bridge."
>>>>
>>>> It seems to me that it is ok to have 1:1 address mapping and that
>>>> therefore of_translate_address() should fail if "ranges" is not
>>>> present.
>>>
>>> The key here is the definition of "mapped through the bridge".
>>> I can only understand this as "directly mapped", i.e. an I/O
>>> port of the child bus corresponds directly to a memory address
>>> on the parent bus, but this is not the case here.
>>>
>>> The problem with adding the mapping here is that it looks
>>> like it should be valid to create a page table entry for
>>> the address returned from the translation and access it through
>>> a pointer dereference, but that is clearly not possible.
>>
>> I understand that somehow we are abusing of the ranges property
>> here however the point is that with the current implementation ranges
>> is needed because otherwise the ipmi driver probe will fail here:
>>
>> of_ipmi_probe -> of_address_to_resource -> __of_address_to_resource
>> -> of_translate_address -> __of_translate_address
>>
>> Now we had a bit of discussion internally and to avoid
>> having ranges we came up with two possible solutions:
>>
>> 1) Using bit 3 of phys.hi cell in 2.2.1 of
>> http://www.firmware.org/1275/bindings/isa/isa0_4d.ps
>> This would mean reworking of_bus_isa_get_flags in 
>> http://lxr.free-electrons.com/source/drivers/of/address.c#L398
>> and setting a new flag to be checked in __of_address_to_resource
>>
>> 2) Adding a property in the bindings of each device that is
>> a child of our LPC bus and modify __of_address_to_resource
>> to check if the property is in the DT and eventually bypass
>> of_translate_address
>>
>> However in both 1) and 2) there are some issues:
>> in 1) we are not complying with the isa binding doc (we use
>> a bit that should be zero); in 2) we need to modify the
>> bindings documentation of the devices that are connected
>> to our LPC controller (therefore modifying other devices
>> bindings to fit our special case).
>>
>> I think that maybe having the 1:1 range mapping doesn't
>> reflect well the reality but it is the less painful
>> solution...
>>
>> What's your view?
> 
> We can check the 'i' bit for I/O space in of_bus_isa_get_flags,
> and that should be enough to translate the I/O port number.
> 
> The only part we need to change here is to not go through
> the crazy conversion all the way from PCI I/O space to a
> physical address and back to a (logical) port number
> that we do today with of_translate_address/pci_address_to_pio.
> 
Sorry for the late response! Several days' leave....
Do you want to bypass of_translate_address and pci_address_to_pio for the registered specific PIO?
I think the bypass for of_translate_address is ok, but worry some new issues will emerge without the
conversion between physical address and logical/linux port number.

When PCI host bridge which support IO operations is configured and enabled, the pci_address_to_pio will
populate the logical IO range from ZERO for the first host bridge. Our LPC will also use part of the IO range
started from ZERO. It will make in/out enter the wrong branch possibly.

In V2, the 0 - 0x1000 logical IO range is reserved for LPC use only. But it seems not so good. In this way,
PCI has no chance to use low 4K IO range(logical).

So, in V3, applying the conversion from physical/cpu address to logical/linux IO port for any IO ranges,
including the LPC, but recorded the logical IO range for LPC. When calling in/out with a logical port address,
we can check this port fall into LPC logical IO range and get back the real IO.

Do you have further comments about this??


> I can think of a several of ways to fix __of_address_to_resource
> to just do the right thing according to the ISA binding to
> make the normal drivers work.
> 
> The easiest solution is probably to hook into the
> "taddr == OF_BAD_ADDR" case in __of_address_to_resource
> and add a lookup for ISA buses there, and instead check
> if some special I/O port operations were registered
> for the port number, using an architecture specific
> function that arm64 implements. Other architectures
> like x86 that don't have a direct mapping between I/O
> ports and MMIO addresses would implement that same
> function differently.

What about add the specific quirk for Hip06 LPC in of_empty_ranges_quirk()??

you know, there are several cases in which of_translate_address return OF_BAD_ADDR.
And if we only check the special port range, it seems a bit risky. If some device want to use this port range
when no hip06 LPC is configured, the checking does not work. I think we should also check the relevant device.


Best,
Zhichang


> 
> 	Arnd
> 
