Return-Path: <SRS0=pIj7=CI=arm.com=robin.murphy@kernel.org>
Return-Path: <SRS0=pIj7=CI=arm.com=robin.murphy@kernel.org>
Subject: Re: [PATCH] PCI: tegra: limit MSI target address to 32-bit
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Bjorn Helgaas <helgaas@kernel.org>
Cc: Vidya Sagar <vidyas@nvidia.com>, treding@nvidia.com, bhelgaas@google.com,
 linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org, kthota@nvidia.com,
 swarren@nvidia.com, mmaddireddy@nvidia.com,
 Michal Simek <michal.simek@xilinx.com>,
 =?UTF-8?Q?S=c3=b6ren_Brinkmann?= <soren.brinkmann@xilinx.com>,
 Simon Horman <horms@verge.net.au>
References: <1509991387-15951-1-git-send-email-vidyas@nvidia.com>
 <20171108212558.GC21597@bhelgaas-glaptop.roam.corp.google.com>
 <e993e1f8-b6b3-de07-759c-a56012e06a2a@nvidia.com>
 <20171109181435.GB7629@bhelgaas-glaptop.roam.corp.google.com>
 <20171110112201.GA25235@red-moon>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <3887d62c-98bb-04d5-5b40-96d5b7b43e63@arm.com>
Date: Fri, 10 Nov 2017 12:04:21 +0000
MIME-Version: 1.0
In-Reply-To: <20171110112201.GA25235@red-moon>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

On 10/11/17 11:22, Lorenzo Pieralisi wrote:
> [+Robin]
> 
> On Thu, Nov 09, 2017 at 12:14:35PM -0600, Bjorn Helgaas wrote:
>> [+cc Lorenzo]
>>
>> On Thu, Nov 09, 2017 at 12:48:14PM +0530, Vidya Sagar wrote:
>>> On Thursday 09 November 2017 02:55 AM, Bjorn Helgaas wrote:
>>>> On Mon, Nov 06, 2017 at 11:33:07PM +0530, Vidya Sagar wrote:
>>>>> limits MSI target address to only 32-bit region to enable
>>>>> some of the PCIe end points where only 32-bit MSIs
>>>>> are supported work properly.
>>>>> One example being Marvel SATA controller
>>>>>
>>>>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>>>>> ---
>>>>>   drivers/pci/host/pci-tegra.c | 2 +-
>>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
>>>>> index 1987fec1f126..03d3dcdd06c2 100644
>>>>> --- a/drivers/pci/host/pci-tegra.c
>>>>> +++ b/drivers/pci/host/pci-tegra.c
>>>>> @@ -1531,7 +1531,7 @@ static int tegra_pcie_enable_msi(struct tegra_pcie *pcie)
>>>>>   	}
>>>>>   	/* setup AFI/FPCI range */
>>>>> -	msi->pages = __get_free_pages(GFP_KERNEL, 0);
>>>>> +	msi->pages = __get_free_pages(GFP_DMA, 0);
>>>>>   	msi->phys = virt_to_phys((void *)msi->pages);
>>>
>>>> Should this be GFP_DMA32?  See the comment above the GFP_DMA
>>>> definition.
>>>
>>> looking at the comments for both GFP_DMA32 and GFP_DMA, I thought GFP_DMA32
>>> is the correct one to use, but, even with that I got >32-bit addresses.
>>> GFP_DMA always gives addresses in <4GB boundary (i.e. 32-bit).
>>> I didn't dig into it to find out why is this the case.
>>
>> This sounds worth looking into (but maybe we don't need the
>> __get_free_pages() at all; see below).  Maybe there's some underlying
>> bug.  My laptop shows this, which looks like it might be related:
>>
>>    Zone ranges:
>>      DMA      [mem 0x0000000000001000-0x0000000000ffffff]
>>      DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
>>      Normal   [mem 0x0000000100000000-0x00000004217fffff]
>>      Device   empty
>>
>> What does your machine show?

The great thing about ZONE_DMA is that it has completely different 
meanings per platform. ZONE_DMA32 is even worse as it's more or less 
just an x86 thing, and isn't implemented (thus does nothing) on most 
other architectures, including ARM/arm64 where Tegra is relevant.

Fun.

>>>> Should we be using virt_to_phys() here?  Where exactly is the
>>>> result ("msi->phys") used, i.e., what bus will that address appear
>>>> on?  If it appears on the PCI side, this should probably use
>>>> something like pcibios_resource_to_bus().
> 
> I had a quick chat with Robin (CC'ed, who has dealt/is dealing with most
> of the work this thread relates to) and I think that as things stand,
> for MSI physical addresses, an offset between PCI->host address shift is
> not really contemplated (ie 1:1 host<->pci is assumed).

I think the most correct way to generate an address would actually be 
via the DMA mapping API (i.e. dma_map_page() with the host bridge's PCI 
device), which would take any relevant offsets into account. It's a bit 
funky, but there's some method in the madness.

>>> This address is written to two places.  First, into host's internal
>>> register to let it know that when an incoming memory write comes
>>> with this address, raise an MSI interrupt instead of forwarding it
>>> to memory subsystem.  Second, into 'Message Address' field of
>>> 'Message Address Register for MSI' register in end point's
>>> configuration space (this is done by MSI framework) for end point to
>>> know which address to be used to generate MSI interrupt.
>>
>> Hmmm, ISTR some past discussion about this.  Here's a little: [1, 2].
>> And this commit [3] sounds like it describes a similar hardware
>> situation with Tegra where the host bridge intercepts the MSI target
>> address, so writes to it never reach system memory.  That means that
>> Tegra doesn't need to allocate system memory at all.
>>
>> Is your system similar?  Can you just statically allocate a little bus
>> address space, use that for the MSI target address, and skip the
>> __get_free_pages()?
> 
> IIUC, all these host bridges need is a physical address that is routed
> upstream to the host bridge by the PCIe tree (ie it is not part of the
> host bridge windows), as long as the host bridge intercepts it (and
> endpoints do _not_ reuse it for something else) that should be fine, as
> it has been pointed out in this thread, allocating a page is a solution
> - there may be others (which are likely to be platform specific).
> 
>>>> Do rcar_pcie_enable_msi() and xilinx_pcie_enable_msi() have a
>>>> similar problem?  They both use GFP_KERNEL, then virt_to_phys(),
>>>> then write the result of virt_to_phys() using a 32-bit register
>>>> write.
>>>
>>> Well, if those systems deal with 64-bit addresses and when an end
>>> point is connected which supports only 32-bit MSI addresses, this
>>> problem will surface when __get_free_pages() returns an address that
>>> translates to a >32-bit address after virt_to_phys() call on it.
>>
>> I'd like to hear from the R-Car and Xilinx folks about (1) whether
>> there's a potential issue with truncating a 64-bit address, and
>> (2) whether that hardware works like Tegra, where the MSI write never
>> reaches memory so we don't actually need to allocate a page.
>>
>> If all we need is to allocate a little bus address space for the MSI
>> target, I'd like to figure out a better way to do that than
>> __get_free_pages().  The current code seems a little buggy, and
>> it's getting propagated through several drivers.

The really neat version is to take a known non-memory physical address 
like the host controller's own MMIO region, which has no legitimate 
reason to ever be used as a DMA address. pcie-mediatek almost gets this 
right, but by using virt_to_phys() on an ioremapped address they end up 
with nonsense rather than the correct address (although realistically 
you would have to be extremely unlucky for said nonsense to collide with 
a real DMA address given to a PCI endpoint later). Following on from 
above, dma_map_resource() would be the foolproof way to get that right.

Robin.

> 
> I will look into this with Robin's help.
> 
> Thanks,
> Lorenzo
> 
>>>>>   	afi_writel(pcie, msi->phys >> soc->msi_base_shift, AFI_MSI_FPCI_BAR_ST);
>>
>> [1] https://lkml.kernel.org/r/20170824134451.GA31858@bhelgaas-glaptop.roam.corp.google.com
>> [2] https://lkml.kernel.org/r/86efs3wesi.fsf@arm.com
>> [3] http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=d7bd554f27c9
