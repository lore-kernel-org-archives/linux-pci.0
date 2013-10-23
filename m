Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35026 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751222Ab3JWPpn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 23 Oct 2013 11:45:43 -0400
Message-ID: <5267EF1E.1010101@ti.com>
Date: Wed, 23 Oct 2013 21:15:34 +0530
From: Kishon Vijay Abraham I <kishon@ti.com>
MIME-Version: 1.0
To: Pratyush Anand <pratyush.anand@st.com>
CC: Jingoo Han <jg1.han@samsung.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Mohit KUMAR DCG <Mohit.KUMAR@st.com>,
	Ajay KHANDELWAL <ajay.khandelwal@st.com>
Subject: Re: [QUERY] Number of address translation regions in designware
References: <52652BF1.4040507@ti.com> <000001cecee5$cbeafa10$63c0ee30$%han@samsung.com> <52668991.1020208@ti.com> <20131023043610.GA5521@pratyush-vbox>
In-Reply-To: <20131023043610.GA5521@pratyush-vbox>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Pratyush,

On Wednesday 23 October 2013 10:06 AM, Pratyush Anand wrote:
> Hi Kishon,
> 
> On Tue, Oct 22, 2013 at 10:20:01PM +0800, Kishon Vijay Abraham I wrote:
>> Hi Pratyush, Jingoo,
>>
>> On Tuesday 22 October 2013 10:46 AM, Jingoo Han wrote:
>>> On Monday, October 21, 2013 10:28 PM, Kishon Vijay Abraham I wrote:
>>>>
>>>> Currently I see in pcie-designware.c we use only 2 ATU regions. We re-use
>>>> INDEX0 for mem outbound and cfg0, and INDEX1 for cfg1 and io. So I'd like to
>>>> know if in your platform, do you have only 2 address translation regions? In
>>>> DRA7xx we have 16 outbound regions and 4 inbound regions.
>>>
>>> In Exynos, there are only 2 inbound and 2 outbound viewpoints.
>>>
>>>> Also the same designware IP can be used as a EP also no? Shouldn't we move it
>>>> out of drivers/pci/host and allow it to be configured as EP also?
>>>
>>> Currently, Exynos PCIe IP does not support EP mode.
>>
>> Thanks for the information. I think we can do some optimization w.r.t address
>> translation regions. Will post a RFC soon.
>>
>> One more query.
>> In dw_pcie_prog_viewport_cfg0/dw_pcie_prog_viewport_cfg1 functions, the *lower
>> target* is programmed to busdev. Is it for any specific reason?
>> I mean doing that will leave lot of holes in the PCIe address space.
>> IIUC, if we don't set that to busdev, consecutive pcie address space will be
>> used for each function no?
> 
> Yes, I think even if CX_ATU_MIN_REGION_SIZE is 64KB in any controller,
> bus, dev and function number can be used to define target address.

I meant for function 0 the configuration space will be from (0x0 t0 0xfff -
4KB). If we use *busdev* for programming target, for function 1 the
configuration space will start at 0x10000 PCIe address which will leave a small
hole from (0x1000 to 0xffff). I'm not sure if it will have a big impact though.
Also till we haven't exhausted the 64KB space (minimum), we wouldn't be needing
to program a new viewport. That's good enough to accommodate 18 functions for
the number of devices.
> 
> So you are trying to allocate statically a separate viewport for each
> function's cfg0 transfer (whereever sufficient number of viewport is
> avilable)?

Actually in DRA7xx, we face a different problem in that, we can't program the
translation region directly from the ranges. Because while programming the
address translation window, the most significant 4 bits are not used.

For example if you see, the cpu address of memory window starts @ 0x20012000
but while programming the address translation window we have to give 0x00012000.

My dt data looked like this.
ranges = <0x00000800 0 0x20001000 0x20001000 0 0x00001000
	  0x81000000 0 0	  0x20002000 0 0x00010000
	  0x82000000 0 0x20012000 0x20012000 0 0xffee000>;

translation = <(OUTBOUND | INDEX0) CFG0 0x0 0x00001000 0x0000fff 0x0 0x00001000
	       (OUTBOUND | INDEX1) IO   0x0 0x00002000 0x000ffff 0x0 0x00002000
	       (OUTBOUND | INDEX2) MEM  0x0 0x00012000 0xffee000 0x0 0x20012000
>;
(btw that translation is a wip I tried to get pcie working in dra7x).

Since I wanted to do the translation configuration from dt data, I was thinking
whether it is necessary to program the viewport dynamically.

But now I think some sort of dynamic programming would be needed, considering
the limitation on few SoCs.

Thanks
Kishon

> 
> If viewport is programmed dynamically at each cfg transfer, then
> whether you use bus and dev only or function also, will it really make
> any difference in saving of address space?
> 
> Regards
> Pratyush
> 
>>
>> Thanks
>> Kishon

