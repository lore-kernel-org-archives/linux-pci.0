Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.134]:38546 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863AbcGMBqU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Jul 2016 21:46:20 -0400
Subject: Re: [PATCH v6 1/2] Documentation: bindings: add dt doc for Rockchip
 PCIe controller
To: Brian Norris <briannorris@chromium.org>
References: <1467789398-13501-1-git-send-email-shawn.lin@rock-chips.com>
 <20160707003912.GB100467@google.com>
 <59b328c9-3a21-36fa-7f28-4ba24d77fef0@rock-chips.com>
 <20160713013117.GA130126@google.com>
Cc: shawn.lin@rock-chips.com, devicetree@vger.kernel.org,
	Heiko Stuebner <heiko@sntech.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
	Wenrui Li <wenrui.li@rock-chips.com>,
	linux-kernel@vger.kernel.org,
	Doug Anderson <dianders@chromium.org>,
	linux-rockchip@lists.infradead.org,
	Rob Herring <robh+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <95a7ffdd-becc-bb3f-c026-d07c691b7a53@rock-chips.com>
Date: Wed, 13 Jul 2016 09:45:43 +0800
MIME-Version: 1.0
In-Reply-To: <20160713013117.GA130126@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

在 2016/7/13 9:31, Brian Norris 写道:
> Hi Shawn,
>
> On Wed, Jul 13, 2016 at 09:10:15AM +0800, Shawn Lin wrote:
>> 在 2016/7/7 8:39, Brian Norris 写道:
>>> On Wed, Jul 06, 2016 at 03:16:37PM +0800, Shawn Lin wrote:
>>>> +	#interrupt-cells = <1>;
>>>> +	interrupt-map-mask = <0 0 0 7>;
>>>> +	interrupt-map = <0 0 0 1 &pcie0_intc 1>,
>>>> +			<0 0 0 2 &pcie0_intc 2>,
>>>> +			<0 0 0 3 &pcie0_intc 3>,
>>>> +			<0 0 0 4 &pcie0_intc 4>;
>>>
>>> I'm a little lost on this one, so forgive my ignorance; how did you
>>> determine the last value in each entry (i.e., the 1, 2, 3, and 4 IRQ
>>> numbers for pcie0_intc)? IIUC, those are supposed to represent indeces
>>> into the IRQ status register found in the PCIe interrupt status
>>> register, and so they should be 0-based (i.e., 0, 1, 2, 3). And then
>>> you'd have:
>>>
>>> 	interrupt-map = <0 0 0 1 &pcie0_intc 0>,
>>> 			<0 0 0 2 &pcie0_intc 1>,
>>> 			<0 0 0 3 &pcie0_intc 2>,
>>> 			<0 0 0 4 &pcie0_intc 3>;
>>>
>>> But then, I never got this sub-node binding to work quite right, so I
>>> may be missing something.
>>>
>>> EDIT: ooh, I see what's going on! I'll comment on the driver as well,
>>> but it looks like you're translating the register status to a HW IRQ
>>> number with 'ffs(reg)', which yields a 1-based index. I think it is most
>>> sensible to use a 0-based index (i.e., 'ffs(reg) - 1'). Now, that only
>>> will work if you get the whole interrupt-map + interrupt-controller
>>> thing right (i.e., using a subnode for the interrupt controller) --
>>> otherwise, IRQ mapping might not work right. I suspect that's one reason
>>> the original driver writer might have used 1-based indexing in the first
>>> place.
>>
>> yes, I got it but.....what's the difference?
>
> At some level, it's a matter of preference. But when you're talking
> about the rk3399 PCIe "interrupt controller" domain, it seems that you
> should be talking about HW bits in the controller -- i.e., you have a
> 4-bit interrupt status bitfield, that we typically call [0:3]. If you
> use [1:4], then you have to remember to subtract 1 mentally when mapping
> to the actual HW bit. I believe that confusion (since bitfields normally
> count from 0) might have helped cause the infinite loop bug I noticed
> too. And I also think that counting from 0 helps clarify the fact that
> your interrupt controller indexing is an independent numbering from the
> PCI interrupt numbering, even though they happen to map 1:1.

If that's the fact of how we should numbering our index base, we should
probably start if from 5 as the layout of INTx is
PCIE_CLIENT_INT_STATUS[5:8]... ?

>
> But then, PCI INTx numbering is kinda weird already, as it starts from
> 1. So maybe it's just as valid to say our domain starts from 1 as well.
>
>> You still need to get the whole interrupt-map + interrupt-controller
>> things right and the code(ffs(reg) - 1)if applied your suggestion.
>
> Yes, of course. And I already sent you patches that do that.
>
>> Look at most of the docs for pcie bindings, I saw they also take
>> 0-base index, how about?
>
> I don't know which ones you're referring to. I see that altera-pcie.txt
> supports interrupt indeces counting from 1, but that's probably because
> they're using the same broken binding that was in your ~v3 patches
> (where the pcie node has both 'interrupt-controller' and
> 'interrupt-map', with phandles to itself), so they had no other choice.
>
> If you still think it makes more sense to count from 1, then I won't
> stop you.

I don't have a hard opinion for the index base as I think it's trivial.
So if it's more sensible to you, I will apply your suggestion.

>
> Regards,
> Brian
>
>
>


-- 
Best Regards
Shawn Lin

