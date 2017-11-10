Return-Path: <SRS0=/Beh=CI=mobiveil.co.in=l.subrahmanya@kernel.org>
Return-Path: <SRS0=/Beh=CI=mobiveil.co.in=l.subrahmanya@kernel.org>
Reply-To: l.subrahmanya@mobiveil.co.in
Subject: Re: [PATCH] PCI: tegra: limit MSI target address to 32-bit
References: <1509991387-15951-1-git-send-email-vidyas@nvidia.com>
 <20171108212558.GC21597@bhelgaas-glaptop.roam.corp.google.com>
 <e993e1f8-b6b3-de07-759c-a56012e06a2a@nvidia.com>
 <20171109181435.GB7629@bhelgaas-glaptop.roam.corp.google.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Vidya Sagar <vidyas@nvidia.com>
Cc: treding@nvidia.com, bhelgaas@google.com, linux-tegra@vger.kernel.org,
 linux-pci@vger.kernel.org, kthota@nvidia.com, swarren@nvidia.com,
 mmaddireddy@nvidia.com, Michal Simek <michal.simek@xilinx.com>,
 =?UTF-8?Q?S=c3=b6ren_Brinkmann?= <soren.brinkmann@xilinx.com>,
 Simon Horman <horms@verge.net.au>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
From: subrahmanya_lingappa <l.subrahmanya@mobiveil.co.in>
Message-ID: <1686e861-79ac-75eb-b905-769253c6f79e@mobiveil.co.in>
Date: Fri, 10 Nov 2017 06:17:16 +0530
MIME-Version: 1.0
In-Reply-To: <20171109181435.GB7629@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Bjorn,

On 11/9/2017 11:44 PM, Bjorn Helgaas wrote:
> [+cc Lorenzo]
>
> On Thu, Nov 09, 2017 at 12:48:14PM +0530, Vidya Sagar wrote:
>> On Thursday 09 November 2017 02:55 AM, Bjorn Helgaas wrote:
>>> On Mon, Nov 06, 2017 at 11:33:07PM +0530, Vidya Sagar wrote:
>>>> limits MSI target address to only 32-bit region to enable
>>>> some of the PCIe end points where only 32-bit MSIs
>>>> are supported work properly.
>>>> One example being Marvel SATA controller
>>>>
>>>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>>>> ---
>>>>  drivers/pci/host/pci-tegra.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
>>>> index 1987fec1f126..03d3dcdd06c2 100644
>>>> --- a/drivers/pci/host/pci-tegra.c
>>>> +++ b/drivers/pci/host/pci-tegra.c
>>>> @@ -1531,7 +1531,7 @@ static int tegra_pcie_enable_msi(struct tegra_pcie *pcie)
>>>>  	}
>>>>  	/* setup AFI/FPCI range */
>>>> -	msi->pages = __get_free_pages(GFP_KERNEL, 0);
>>>> +	msi->pages = __get_free_pages(GFP_DMA, 0);
>>>>  	msi->phys = virt_to_phys((void *)msi->pages);
>>
>>> Should this be GFP_DMA32?  See the comment above the GFP_DMA
>>> definition.
>>
>> looking at the comments for both GFP_DMA32 and GFP_DMA, I thought GFP_DMA32
>> is the correct one to use, but, even with that I got >32-bit addresses.
>> GFP_DMA always gives addresses in <4GB boundary (i.e. 32-bit).
>> I didn't dig into it to find out why is this the case.
>
> This sounds worth looking into (but maybe we don't need the
> __get_free_pages() at all; see below).  Maybe there's some underlying
> bug.  My laptop shows this, which looks like it might be related:
>
>   Zone ranges:
>     DMA      [mem 0x0000000000001000-0x0000000000ffffff]
>     DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
>     Normal   [mem 0x0000000100000000-0x00000004217fffff]
>     Device   empty
>
> What does your machine show?
>
>>> Should we be using virt_to_phys() here?  Where exactly is the
>>> result ("msi->phys") used, i.e., what bus will that address appear
>>> on?  If it appears on the PCI side, this should probably use
>>> something like pcibios_resource_to_bus().
>>
>> This address is written to two places.  First, into host's internal
>> register to let it know that when an incoming memory write comes
>> with this address, raise an MSI interrupt instead of forwarding it
>> to memory subsystem.  Second, into 'Message Address' field of
>> 'Message Address Register for MSI' register in end point's
>> configuration space (this is done by MSI framework) for end point to
>> know which address to be used to generate MSI interrupt.
>
> Hmmm, ISTR some past discussion about this.  Here's a little: [1, 2].
> And this commit [3] sounds like it describes a similar hardware
> situation with Tegra where the host bridge intercepts the MSI target
> address, so writes to it never reach system memory.  That means that
> Tegra doesn't need to allocate system memory at all.
>
> Is your system similar?  Can you just statically allocate a little bus
> address space, use that for the MSI target address, and skip the
> __get_free_pages()?
>
>>> Do rcar_pcie_enable_msi() and xilinx_pcie_enable_msi() have a
>>> similar problem?  They both use GFP_KERNEL, then virt_to_phys(),
>>> then write the result of virt_to_phys() using a 32-bit register
>>> write.
>>
>> Well, if those systems deal with 64-bit addresses and when an end
>> point is connected which supports only 32-bit MSI addresses, this
>> problem will surface when __get_free_pages() returns an address that
>> translates to a >32-bit address after virt_to_phys() call on it.
>
> I'd like to hear from the R-Car and Xilinx folks about (1) whether
> there's a potential issue with truncating a 64-bit address, and
> (2) whether that hardware works like Tegra, where the MSI write never
> reaches memory so we don't actually need to allocate a page.
>

it is so, at least drivers/pci/host/pcie-xilinx.c driver, MSI data is 
never read from the msi_pages physical
memory allocated, data is always intercepted, caught and fed from one of 
the HW FIFO register XILINX_PCIE_REG_RPIFR2. Here too __get_free_pages 
was used to allocate msi_pages just to get a real memory address to 
program in the MSI address in PCIe endpoints config register.

MSI handling code from pcie-xilinx.c

	if (status & (XILINX_PCIE_INTR_INTX | XILINX_PCIE_INTR_MSI)) {
		.
		.

		/* Decode the IRQ number */
		if (val & XILINX_PCIE_RPIFR1_MSI_INTR) {
			val = pcie_read(port, XILINX_PCIE_REG_RPIFR2) &
				XILINX_PCIE_RPIFR2_MSG_DATA;
		} else {
			val = (val & XILINX_PCIE_RPIFR1_INTR_MASK) >>
				XILINX_PCIE_RPIFR1_INTR_SHIFT;
			val = irq_find_mapping(port->leg_domain, val);
		}
		
		.
		.
		
		/* Handle the interrupt */
		if (IS_ENABLED(CONFIG_PCI_MSI) ||
		    !(val & XILINX_PCIE_RPIFR1_MSI_INTR))
			generic_handle_irq(val);
	}

> If all we need is to allocate a little bus address space for the MSI
> target, I'd like to figure out a better way to do that than
> __get_free_pages().  The current code seems a little buggy, and
> it's getting propagated through several drivers.
>
>>>>  	afi_writel(pcie, msi->phys >> soc->msi_base_shift, AFI_MSI_FPCI_BAR_ST);
>
> [1] https://lkml.kernel.org/r/20170824134451.GA31858@bhelgaas-glaptop.roam.corp.google.com
> [2] https://lkml.kernel.org/r/86efs3wesi.fsf@arm.com
> [3] http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=d7bd554f27c9
>
