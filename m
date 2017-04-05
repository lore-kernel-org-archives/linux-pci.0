Return-Path: <SRS0=vCIw=3N=rock-chips.com=shawn.lin@kernel.org>
Return-Path: <SRS0=vCIw=3N=rock-chips.com=shawn.lin@kernel.org>
Subject: Re: [PATCH] PCI: rockchip: Mark SLC bit as well as CCC bit for RC
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1489735493-148838-1-git-send-email-shawn.lin@rock-chips.com>
 <20170401151425.GA10456@bhelgaas-glaptop.roam.corp.google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linux-rockchip@lists.infradead.org, Wenrui Li <wenrui.li@rock-chips.com>,
 Brian Norris <briannorris@chromium.org>,
 Jeffy Chen <jeffy.chen@rock-chips.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <6d986a99-bde3-0d82-523b-a560405573ad@rock-chips.com>
Date: Wed, 5 Apr 2017 09:20:34 +0800
MIME-Version: 1.0
In-Reply-To: <20170401151425.GA10456@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On 2017/4/1 23:14, Bjorn Helgaas wrote:
> On Fri, Mar 17, 2017 at 03:24:53PM +0800, Shawn Lin wrote:
>> lspci traces CCC to see if the end-2-end supports common
>> clock, so the current code should work as we mark the CCC bit
>> of RC.
>
> I assume you're talking about lspci code here, where the bit is called
> PCI_EXP_LNKCTL_CLOCK.  The only use of PCI_EXP_LNKCTL_CLOCK in lspci
> is to decode it in cap_express_link().  I don't know what you mean by
> "tracing CCC", since lspci only decodes registers of one device at a
> time; it never follows the hierarchy from an endpoint up to a root
> port.
>
> I'm not sure how this lspci information is relevant to this patch.

Actually I meant lscpi found the common clock was cleared but we have
set it in RC's driver.

>
>> However, ASPM code actually check SLC bit of RC and try to
>> compare it with the downstream components' SLC instead.
>
> Here I think you're talking about pcie_aspm_configure_common_clock()
> in Linux.  That looks at PCI_EXP_LNKSTA_SLC on both ends of a link.
> If PCI_EXP_LNKSTA_SLC is set at both ends, we set PCI_EXP_LNKCTL_CCC
> on both ends; otherwise we clear PCI_EXP_LNKCTL_CCC on both ends.
> This follows the Implementation Note in PCIe r3.1, sec 7.8.7.
>
> Per that note, PCI_EXP_LNKSTA_SLC in the root port tells us whether
> the port "uses a clock that has a common source ... to the clock
> signal provided on the slot" below the port.
>
> This patch sets PCI_EXP_LNKSTA_SLC based on your knowledge of the
> platform topology, i.e., that the root port clock and the slot clock
> have the same source.  I assume this is *always* the case for every
> possible platform using Rockchip?

yes.

>
> If so, just say that, and you can go on to say that this enables the
> ASPM code to set PCI_EXP_LNKCTL_CCC if the downstream end also sets
> PCI_EXP_LNKSTA_SLC to indicate that it uses the clock provided on the
> slot, e.g., something like this:
>
>   All platforms using Rockchip use a common clock for the Root Port
>   and the slot connected to it.  Indicate this by setting the Slot
>   Clock Configuration (PCI_EXP_LNKSTA_SLC) bit in the Root Port's Link
>   Status.
>
>   Per the Implementation Note in the spec (PCIe r3.1, sec 7.8.7), if
>   the downstream component also sets PCI_EXP_LNKSTA_SLC, software may
>   set the Common Clock Configuration (PCI_EXP_LNKCTL_CCC) bits on both
>   ends of the Link.  This is done by pcie_aspm_configure_common_clock().
>

It sounds good.

>> So when
>> enabling ASPM, CCC will be cleared after failing to match SLC with
>> the corresponding bit of downstream components. On one hand, from the
>> code of pcie_aspm_configure_common_clock, we could find that what we
>> actually need to set is SLC.
>
>> On the other hand, we should also guarantee
>> that CCC should be marked w/o supporting ASPM.
>
> This patch doesn't change anything with PCI_EXP_LNKCTL_CCC.  I'd
> suggest that we should *not* set it here because we have no idea what
> (if anything) is at the other end of the link.  Per the implementation
> note, I think we should only set PCI_EXP_LNKCTL_CCC if both ends of
> the link have PCI_EXP_LNKSTA_SLC set.
>
> Are you suggesting that we should set PCI_EXP_LNKCTL_CCC on both ends
> of the link whenever possible, and that today we don't do that unless
> ASPM is enabled?  That sounds plausible to me, but that would be a
> generic PCIe enhancement, not anything Rockchip-specific, and of
> course, this patch doesn't make that happen.


It's okay to just set SLC in RC's driver and let aspm code decide the
CCC bit, so I will respin v2 to fix this for rockchip RC.

Then we could go on talking about another issue that should we need to
set PCI_EXP_LNKCTL_CCC on both ends if possbile? I think we need more
evidence from the spec which states that it could benefit for something
else than aspm's latency. However I didn't them.

>
>> This patch fixes this
>> issue.
>>
>> Cc: Brian Norris <briannorris@chromium.org>
>> Cc: jeffy.chen <jeffy.chen@rock-chips.com>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>> ---
>>
>>  drivers/pci/host/pcie-rockchip.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
>> index 26ddd35..7cd4d5c 100644
>> --- a/drivers/pci/host/pcie-rockchip.c
>> +++ b/drivers/pci/host/pcie-rockchip.c
>> @@ -596,7 +596,7 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
>>
>>  	/* Set RC's clock architecture as common clock */
>>  	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LCS);
>> -	status |= PCI_EXP_LNKCTL_CCC;
>> +	status |= (PCI_EXP_LNKCTL_CCC | PCI_EXP_LNKSTA_SLC << 16);
>>  	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LCS);
>>
>>  	/* Enable Gen1 training */
>> --
>> 1.9.1
>>
>>
>
>
>
