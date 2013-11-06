Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45109 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751401Ab3KFInU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 6 Nov 2013 03:43:20 -0500
Message-ID: <527A0112.60908@ti.com>
Date: Wed, 6 Nov 2013 14:12:58 +0530
From: Kishon Vijay Abraham I <kishon@ti.com>
MIME-Version: 1.0
To: Pratyush Anand <pratyush.anand@gmail.com>
CC: Pratyush Anand <pratyush.anand@st.com>,
	Jingoo Han <jg1.han@samsung.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Mohit KUMAR DCG <Mohit.KUMAR@st.com>,
	Ajay KHANDELWAL <ajay.khandelwal@st.com>,
	Marek Vasut <marex@denx.de>,
	Tim Harvey <tharvey@gateworks.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [QUERY] Number of address translation regions in designware
References: <52652BF1.4040507@ti.com> <000001cecee5$cbeafa10$63c0ee30$%han@samsung.com> <52668991.1020208@ti.com> <20131023043610.GA5521@pratyush-vbox> <5267EF1E.1010101@ti.com> <20131029071015.GB2297@pratyush-vbox> <526F941B.8070300@ti.com> <CAHM4w1=YkiYv_N0qxQpbfqz3VHQrZ46j96x0tCvL6q-oOLXtKA@mail.gmail.com>
In-Reply-To: <CAHM4w1=YkiYv_N0qxQpbfqz3VHQrZ46j96x0tCvL6q-oOLXtKA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Tuesday 29 October 2013 09:44 PM, Pratyush Anand wrote:
> On Tue, Oct 29, 2013 at 4:25 PM, Kishon Vijay Abraham I <kishon@ti.com> wrote:
>> Hi Pratyush,
>>
>> On Tuesday 29 October 2013 12:40 PM, Pratyush Anand wrote:
>>> + Marek, Tim, arnd
>>>
>>> Hi Kishon,
>>>
>>> On Wed, Oct 23, 2013 at 11:45:34PM +0800, Kishon Vijay Abraham I wrote:
>>>> Hi Pratyush,
>>>>
>>>> On Wednesday 23 October 2013 10:06 AM, Pratyush Anand wrote:
>>>>> Hi Kishon,
>>>>>
>>>>> On Tue, Oct 22, 2013 at 10:20:01PM +0800, Kishon Vijay Abraham I wrote:
>>>>>> Hi Pratyush, Jingoo,
>>>>>>
>>>>>> On Tuesday 22 October 2013 10:46 AM, Jingoo Han wrote:
>>>>>>> On Monday, October 21, 2013 10:28 PM, Kishon Vijay Abraham I wrote:
>>>>>>>>
>>>>>>>> Currently I see in pcie-designware.c we use only 2 ATU regions. We re-use
>>>>>>>> INDEX0 for mem outbound and cfg0, and INDEX1 for cfg1 and io. So I'd like to
>>>>>>>> know if in your platform, do you have only 2 address translation regions? In
>>>>>>>> DRA7xx we have 16 outbound regions and 4 inbound regions.
>>>>>>>
>>>>>>> In Exynos, there are only 2 inbound and 2 outbound viewpoints.
>>>>>>>
>>>>>>>> Also the same designware IP can be used as a EP also no? Shouldn't we move it
>>>>>>>> out of drivers/pci/host and allow it to be configured as EP also?
>>>>>>>
>>>>>>> Currently, Exynos PCIe IP does not support EP mode.
>>>>>>
>>>>>> Thanks for the information. I think we can do some optimization w.r.t address
>>>>>> translation regions. Will post a RFC soon.
>>>>>>
>>>>>> One more query.
>>>>>> In dw_pcie_prog_viewport_cfg0/dw_pcie_prog_viewport_cfg1 functions, the *lower
>>>>>> target* is programmed to busdev. Is it for any specific reason?
>>>>>> I mean doing that will leave lot of holes in the PCIe address space.
>>>>>> IIUC, if we don't set that to busdev, consecutive pcie address space will be
>>>>>> used for each function no?
>>>>>
>>>>> Yes, I think even if CX_ATU_MIN_REGION_SIZE is 64KB in any controller,
>>>>> bus, dev and function number can be used to define target address.
>>>>
>>>> I meant for function 0 the configuration space will be from (0x0 t0 0xfff -
>>>> 4KB). If we use *busdev* for programming target, for function 1 the
>>>> configuration space will start at 0x10000 PCIe address which will leave a small
>>>> hole from (0x1000 to 0xffff). I'm not sure if it will have a big impact though.
>>>> Also till we haven't exhausted the 64KB space (minimum), we wouldn't be needing
>>>> to program a new viewport. That's good enough to accommodate 18 functions for
>>>> the number of devices.
>>>
>>> Yes, I agree with you that using *busdev* will create hole and we
>>> should avoid it. More on this at the end.
>>>
>>>>>
>>>>> So you are trying to allocate statically a separate viewport for each
>>>>> function's cfg0 transfer (whereever sufficient number of viewport is
>>>>> avilable)?
>>>>
>>>> Actually in DRA7xx, we face a different problem in that, we can't program the
>>>> translation region directly from the ranges. Because while programming the
>>>> address translation window, the most significant 4 bits are not used.
>>>>
>>>> For example if you see, the cpu address of memory window starts @ 0x20012000
>>>> but while programming the address translation window we have to give 0x00012000.
>>>>
>>>> My dt data looked like this.
>>>> ranges = <0x00000800 0 0x20001000 0x20001000 0 0x00001000
>>>>         0x81000000 0 0          0x20002000 0 0x00010000
>>>>         0x82000000 0 0x20012000 0x20012000 0 0xffee000>;
>>>>
>>>> translation = <(OUTBOUND | INDEX0) CFG0 0x0 0x00001000 0x0000fff 0x0 0x00001000
>>>>              (OUTBOUND | INDEX1) IO   0x0 0x00002000 0x000ffff 0x0 0x00002000
>>>>              (OUTBOUND | INDEX2) MEM  0x0 0x00012000 0xffee000 0x0 0x20012000
>>>>> ;
>>>
>>> I too have some doubt here..not very clear.. may be someone more
>>> expert can correct (I keep arnd in cc).... How should be the
>>> translation?
>>> In my opinion, input address of translation should be in "bus address
>>> domain"  ie address what PCIe sees and translated output for memory
>>
>> It actually depends on whether we are configuring inbound or outbound. IIUC,
>> what you just mentioned will be for configuring inbound translation window.
>>
>> For the outbound translation window, it'll be the other way round. *base* will
>> be the CPU address and target will be the PCIe address.
>
> Sure? At the the end you say base address is 0x000_0000 (bus address) and not

This address is not actually a bus address (note it has only 28bits). 
Rather it's used only to program the address translation unit of 
desigware (for DRA7x).
Both the cpu address and pcie address is the same.
> 0x2000_0000 (parent bus address). It contradicts what you say above, no?
>>> transaction should be in "parent bus address domain" ie what CPUs
>>> see. If my understanding is correct, then pcie designware driver needs
>>> fixes at some places.
>>>
>>> I am not much used to DT, but if I understood correctly, in your case
>>> parent bus address and bus address are different.
>>>
>>> pp->mem_base = bus address  = range.pci_addr = 0x0000000000012000
>>> pp->config.mem_bus_addr = parent bus address = range.cpu_addr = 0x20012000
>>
>> Not like that. It's the same.
>> In DRA7, the cpu sees 32bit address, but the pcie controller can see only 28bit
>> address. So whenever the cpu issues a read/write request, the 4 most
>> significant bits are used by L3 to determine the target controller.
>> For example, the cpu reserves 0x2000_0000 - 0x2FFF_FFFF for PCIe controller but
>> the PCIe controller will see only (0x000_0000 - 0xFFF_FFF). So for programming
>> the outbound translation window the *base* should be programmed as 0x000_0000.
>> Whenever we try to write to say 0x2000_0000, it will be translated to whatever
>> we have programmed in the translation window with base as 0x000_0000.
>
> What you say here is also my understanding.
> Only question then remains, what should be translated address? All
> translated address must lie in the address range programmed in EP's
> BAR, then only EP will able to receive that mem transaction, no?

right.
> All EP's BAR address will lie in the range of pp->mem.start and
> pp->mem.end, am I correct here?

I'm not sure how the PCI core code sets the BAR of the EP. I have to 
check it.
> And, pp->mem.start is range.cpu_addr, therefore I said that if target address
> is programmed as cpu_address, it should work fine.

Agreed.

Thanks
Kishon
