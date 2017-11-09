Return-Path: <SRS0=C7vb=CH=nvidia.com=vidyas@kernel.org>
Return-Path: <SRS0=C7vb=CH=nvidia.com=vidyas@kernel.org>
Subject: Re: [PATCH] PCI: tegra: limit MSI target address to 32-bit
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <treding@nvidia.com>, <bhelgaas@google.com>,
	<linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<kthota@nvidia.com>, <swarren@nvidia.com>, <mmaddireddy@nvidia.com>, "Michal
 Simek" <michal.simek@xilinx.com>, =?UTF-8?Q?S=c3=b6ren_Brinkmann?=
	<soren.brinkmann@xilinx.com>, Simon Horman <horms@verge.net.au>
References: <1509991387-15951-1-git-send-email-vidyas@nvidia.com>
 <20171108212558.GC21597@bhelgaas-glaptop.roam.corp.google.com>
From: Vidya Sagar <vidyas@nvidia.com>
Message-ID: <e993e1f8-b6b3-de07-759c-a56012e06a2a@nvidia.com>
Date: Thu, 9 Nov 2017 12:48:14 +0530
MIME-Version: 1.0
In-Reply-To: <20171108212558.GC21597@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
List-ID: <linux-pci.vger.kernel.org>



On Thursday 09 November 2017 02:55 AM, Bjorn Helgaas wrote:
> [+cc Michal, S=C3=B6ren, Simon]
>
> On Mon, Nov 06, 2017 at 11:33:07PM +0530, Vidya Sagar wrote:
>> limits MSI target address to only 32-bit region to enable
>> some of the PCIe end points where only 32-bit MSIs
>> are supported work properly.
>> One example being Marvel SATA controller
>>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> ---
>>   drivers/pci/host/pci-tegra.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
>> index 1987fec1f126..03d3dcdd06c2 100644
>> --- a/drivers/pci/host/pci-tegra.c
>> +++ b/drivers/pci/host/pci-tegra.c
>> @@ -1531,7 +1531,7 @@ static int tegra_pcie_enable_msi(struct tegra_pcie=
 *pcie)
>>   	}
>>  =20
>>   	/* setup AFI/FPCI range */
>> -	msi->pages =3D __get_free_pages(GFP_KERNEL, 0);
>> +	msi->pages =3D __get_free_pages(GFP_DMA, 0);
>>   	msi->phys =3D virt_to_phys((void *)msi->pages);
> Should this be GFP_DMA32?  See the comment above the GFP_DMA
> definition.
looking at the comments for both GFP_DMA32 and GFP_DMA, I thought GFP_DMA32
is the correct one to use, but, even with that I got >32-bit addresses.
GFP_DMA always gives addresses in <4GB boundary (i.e. 32-bit).
I didn't dig into it to find out why is this the case.
> Should we be using virt_to_phys() here?  Where exactly is the result
> ("msi->phys") used, i.e., what bus will that address appear on?  If it
> appears on the PCI side, this should probably use something like
> pcibios_resource_to_bus().
This address is written to two places.
First, into host's internal register to let it know that when an incoming
memory write comes with this address, raise an MSI interrupt instead of=20
forwarding it to
memory subsystem.
Second, into 'Message Address' field of 'Message Address Register for=20
MSI' register in
end point's configuration space (this is done by MSI framework) for end=20
point to know
which address to be used to generate MSI interrupt.
> Do rcar_pcie_enable_msi() and xilinx_pcie_enable_msi() have a similar
> problem?  They both use GFP_KERNEL, then virt_to_phys(), then write the
> result of virt_to_phys() using a 32-bit register write.
Well, if those systems deal with 64-bit addresses and when an end point=20
is connected which supports
only 32-bit MSI addresses, this problem will surface when=20
__get_free_pages() returns an address that
translates to a >32-bit address after virt_to_phys() call on it.
>
>>   	afi_writel(pcie, msi->phys >> soc->msi_base_shift, AFI_MSI_FPCI_BAR_S=
T);
>> --=20
>> 2.7.4
>>
