Return-Path: <SRS0=tt2F=CI=gmail.com=arndbergmann@kernel.org>
Return-Path: <SRS0=tt2F=CI=gmail.com=arndbergmann@kernel.org>
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <20171110093737.GA25067@ulmo>
References: <1509991387-15951-1-git-send-email-vidyas@nvidia.com>
 <20171108212558.GC21597@bhelgaas-glaptop.roam.corp.google.com>
 <e993e1f8-b6b3-de07-759c-a56012e06a2a@nvidia.com> <20171109181435.GB7629@bhelgaas-glaptop.roam.corp.google.com>
 <7727b9bc-a44b-4cbe-1839-7e4dd7c2c186@nvidia.com> <20171110093737.GA25067@ulmo>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 10 Nov 2017 12:57:34 +0100
Message-ID: <CAK8P3a1uDqLzEZ9eF9V-e3Uo-frkmVbNw-OXv9dapPGPMP-Ocw@mail.gmail.com>
Subject: Re: [PATCH] PCI: tegra: limit MSI target address to 32-bit
To: Thierry Reding <treding@nvidia.com>
Cc: Vidya Sagar <vidyas@nvidia.com>, Bjorn Helgaas <helgaas@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>, linux-pci <linux-pci@vger.kernel.org>,
	kthota@nvidia.com, swarren@nvidia.com, mmaddireddy@nvidia.com,
	Michal Simek <michal.simek@xilinx.com>, =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>,
	Simon Horman <horms@verge.net.au>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Fri, Nov 10, 2017 at 10:37 AM, Thierry Reding <treding@nvidia.com> wrote:
> On Fri, Nov 10, 2017 at 12:11:05AM +0530, Vidya Sagar wrote:
>> On Thursday 09 November 2017 11:44 PM, Bjorn Helgaas wrote:
>> > [+cc Lorenzo]
>> > On Thu, Nov 09, 2017 at 12:48:14PM +0530, Vidya Sagar wrote:
>> > > On Thursday 09 November 2017 02:55 AM, Bjorn Helgaas wrote:
>> > > > On Mon, Nov 06, 2017 at 11:33:07PM +0530, Vidya Sagar wrote:
>> > > > > limits MSI target address to only 32-bit region to enable
>> > > > > some of the PCIe end points where only 32-bit MSIs
>> > > > > are supported work properly.
>> > > > > One example being Marvel SATA controller
>> > > > >
>> > > > > Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> > > > > ---
>> > > > >   drivers/pci/host/pci-tegra.c | 2 +-
>> > > > >   1 file changed, 1 insertion(+), 1 deletion(-)
>> > > > >
>> > > > > diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
>> > > > > index 1987fec1f126..03d3dcdd06c2 100644
>> > > > > --- a/drivers/pci/host/pci-tegra.c
>> > > > > +++ b/drivers/pci/host/pci-tegra.c
>> > > > > @@ -1531,7 +1531,7 @@ static int tegra_pcie_enable_msi(struct tegra_pcie *pcie)
>> > > > >       }
>> > > > >       /* setup AFI/FPCI range */
>> > > > > -     msi->pages = __get_free_pages(GFP_KERNEL, 0);
>> > > > > +     msi->pages = __get_free_pages(GFP_DMA, 0);
>> > > > >       msi->phys = virt_to_phys((void *)msi->pages);
>> > > > Should this be GFP_DMA32?  See the comment above the GFP_DMA
>> > > > definition.
>> > > looking at the comments for both GFP_DMA32 and GFP_DMA, I thought GFP_DMA32
>> > > is the correct one to use, but, even with that I got >32-bit addresses.
>> > > GFP_DMA always gives addresses in <4GB boundary (i.e. 32-bit).
>> > > I didn't dig into it to find out why is this the case.
>> > This sounds worth looking into (but maybe we don't need the
>> > __get_free_pages() at all; see below).  Maybe there's some underlying
>> > bug.  My laptop shows this, which looks like it might be related:
>> >
>> >    Zone ranges:
>> >      DMA      [mem 0x0000000000001000-0x0000000000ffffff]
>> >      DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
>> >      Normal   [mem 0x0000000100000000-0x00000004217fffff]
>> >      Device   empty
>> >
>> > What does your machine show?
>> I see following in my linux box
>>  Zone ranges:
>>    DMA      [mem 0x0000000000001000-0x0000000000ffffff]
>>    DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
>>    Normal   [mem 0x0000000100000000-0x000000106effffff]
>>    Device   empty
>>
>> and following in my T210 Tegra platform
>> Zone ranges:
>>   DMA      [mem 0x0000000080000000-0x00000000ffffffff]
>>   Normal   [mem 0x0000000100000000-0x000000017fffffff]
>
> This seems to be happening because 64-bit ARM doesn't have the
> ZONE_DMA32 Kconfig option, which seems to cause the DMA32 zone
> to default to the normal zone (see include/linux/gfp.h).
>
> That's very confusing in conjunction with the kerneldoc comment
> for GFP_DMA32 because it isn't actually guaranteed to give you
> 32-bit addresses for !ZONE_DMA32.
>
> Cc'ing Arnd who knows about these things.

I don't have a good answer unfortunately, but I agree there is clearly
something wrong with the behavior, AFAICT, ZONE_DMA32 should
really do what the name says.

When you look at the commit that introduced ZONE_DMA32, you
see that it used to be different, see commit a2f1b4249007
("[PATCH] x86_64: Add 4GB DMA32 zone"). ZONE_DMA32 used
to fall back to ZONE_DMA, but this got changed shortly after,
still in 2006.

      Arnd
