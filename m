Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.134]:50513 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758918AbdDSBk2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Apr 2017 21:40:28 -0400
Subject: Re: Question about max bus number for PCIe root bridge
To: Bjorn Helgaas <bhelgaas@google.com>
References: <aee3cf45-382b-0e18-72fe-b4078aabc409@rock-chips.com>
 <CAErSpo7us72gc1VBj6aMfPz92QbrEUFfqZt594yVEneGvG6A9A@mail.gmail.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Andreas Noever <andreas.noever@gmail.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <a1291c28-2730-456d-9670-f41c14cad582@rock-chips.com>
Date: Wed, 19 Apr 2017 09:40:23 +0800
MIME-Version: 1.0
In-Reply-To: <CAErSpo7us72gc1VBj6aMfPz92QbrEUFfqZt594yVEneGvG6A9A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

在 2017/4/18 21:46, Bjorn Helgaas 写道:
> [+cc Andreas]
>
>
> On Tue, Apr 18, 2017 at 4:45 AM, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>> Hi Bjorn,
>>
>> Sorry to bother you. :)
>>
>> pcie-rockchip uses of_pci_get_host_bridge_resources to assign the
>> maximum number of buses for the root bridge. Currently we set it to
>> be 0xff. Now we have a PCIe switch connected to the root port. However,
>> when enumerating the topology, I see it panic down to:
>>
>> [    0.502875] PCI host bridge /pcie@f8000000 ranges:
>> [    0.502905]   MEM 0xfa000000..0xfa5fffff -> 0xfa000000
>> [    0.502921]    IO 0xfa600000..0xfa6fffff -> 0xfa600000
>> [    0.503168] rockchip-pcie f8000000.pcie: PCI host bridge to bus 0000:00
>> [    0.503189] pci_bus 0000:00: root bus resource [bus 00-10]
>> [    0.503204] pci_bus 0000:00: root bus resource [mem
>> 0xfa000000-0xfa5fffff]
>> [    0.503221] pci_bus 0000:00: root bus resource [io  0x0000-0xfffff] (bus
>> address [0xfa600000-0xfa6fffff])
>> [    0.503598] pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]),
>> reconfiguring
>> [    0.504104] pci 0000:01:00.0: bridge configuration invalid ([bus 00-00]),
>> reconfiguring
>> [    0.515549] pci 0000:02:00.0: bridge configuration invalid ([bus 02-ff]),
>> reconfiguring
>>
>> .....
>>
>> [    0.695096] pci 0000:1f:00.0: bridge configuration invalid ([bus 1f-ff]),
>> reconfiguring
>> [    0.695242] bus->number = 0x20, PCI_SLOT(devfn) = 0x0 PCI_FUNC(devfn) =
>> 0x0, where = 0x0
>> [    0.695255] busdev = 0x2000000
>> [    0.695270] Unable to handle kernel paging request at virtual address
>> ffffff8012000000
>> [    0.858703] pgd = ffffff8009319000
>> [    0.859004] [ffffff8012000000] *pgd=00000000f7ffe003,
>> *pud=00000000f7ffe003, *pmd=0000000000000000
>> [    0.859803] Internal error: Oops: 96000006 [#1] PREEMPT SMP
>> [    0.860292] Modules linked in:
>>
>> We only have the axi address range from 0xf8000000 to 0xfa000000
>> defined in the DT. So the max bus resource is 0x2000000. The PCI
>> core was trying to scan the bus whose bus number is 0x20. So the bus
>> resource calculated by PCIE_ECAM_ADDR is larger than what we have. Now
>> I change the max bus number to 0x10 by modifying the third argument of
>> of_pci_get_host_bridge_resources . But I still see the PCI core are
>> trying to scan the bus whose bus numbers are larger than the
>> limitation, namely 0x10.
>>
>> So my question is:
>>
>> what is the meaning of "maximum number of buses for this bridge", the
>> comment before of_pci_get_host_bridge_resources. In my case, isn't it
>> applied to the bridge connected to the root port?
>
> A DT host bridge description *should* contain a "bus-range" property
> that tells us what buses are reachable via the host bridge.  However,
> many do not, and the the "busno" and "bus_max" parameters are a way to
> specify a default bus number range when there is no "bus-range" DT
> property.
>
> You're right that this range, whether from "bus-range" or from a
> default range supplied by the caller of
> of_pci_get_host_bridge_resources(), should limit the bus numbers we
> scan below the host bridge, but we do not enforce that.

So this looks to me that the bus-range is almost pointless as we don't
enforce that. More seriously, it's broken as I assume the reason for
the host drivers who want to limit the bus-range is that they have the
same limitation for bus resource like mine. They(any ARCHs without
enough bus resource) just luckily didn't trip over it.

>
> Andreas Noever did add code to enforce this:
>
>   fc1b253141b3 ("PCI: Don't scan random busses in pci_scan_bridge()")
>   1820ffdccb9b ("PCI: Make sure bus number resources stay within their
> parents bounds")
>

Thanks for sharing these, and I applied the two patches from Andreas.
So now the PCIe core could scan the child bus properly under the
limitation. But the endpoint connected to the switch still couldn't be
present. I was trying to connect the switch+endpoint to my Ubuntu PC
to see how it works. And I think the BIOS did the scan and linux PCIe
core inherits the topology from BIOS.

The tree looks like:

-[0000:00]-+-00.0
            +-01.0-[01-07]----00.0-[02-07]--+-01.0-[03]--
            |                               +-02.0-[04]--
            |                               +-03.0-[05]--
            |                               +-04.0-[06]--
            |                               \-05.0-[07]----00.0
            +-02.0
            +-03.0
            +-14.0
            +-16.0
            +-16.3
            +-19.0
            +-1a.0
            +-1b.0
            +-1d.0
            +-1f.0
            +-1f.2
            \-1f.3


The endpoint was in 07:00.0 which means the BIOS scan the tree and 
assige bus 7 to the endpoint. So I assume the topology isn't so deep
as what linux PCIe core does. What now I see is that linux PCIe are
scanning the child bus from 1 to 0x1f(assigned from DT), and break out
without finding the endpoint. So I feel that the aforementioned patches
weren't enough to solve the issue.

Any idea? :)


> but it ended up breaking a couple systems because of an issue with an
> LSI device and a CardBus bridge issue, so we reverted them.
>
> I wish we had a better solution than reverting those commits, because
> I think Andreas' patches were the right thing to do.
>
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=fc1b253141b3
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=1820ffdccb9b
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=7a0b33d4a45d
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=12d8706963f0
>
>
>
