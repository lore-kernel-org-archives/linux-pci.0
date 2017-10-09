Return-Path: <SRS0=ZbXF=BI=gmail.com=sagar.tv@kernel.org>
Return-Path: <SRS0=ZbXF=BI=gmail.com=sagar.tv@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20171002201924.GC5407@bhelgaas-glaptop.roam.corp.google.com>
References: <20170923061740.6012-1-treding@nvidia.com> <CAN7O0+JyG3XT5SsWGsiZs0vrk0ha1vQ5N7rjYxs3tM_NvdONdw@mail.gmail.com>
 <20170928141912.GB28022@ulmo> <20170929025719.GZ15970@bhelgaas-glaptop.roam.corp.google.com>
 <20170929072207.GA12773@ulmo> <20171002201924.GC5407@bhelgaas-glaptop.roam.corp.google.com>
From: vidya sagar <sagar.tv@gmail.com>
Date: Mon, 9 Oct 2017 23:13:21 +0530
Message-ID: <CAN7O0+KGQHQqBBqHyTYV9j1KSetiv+YdeLgM52TBBBf5NXRYtw@mail.gmail.com>
Subject: Re: [PATCH] PCI: tegra: Use different MSI target address for Tegra20
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Hunter <jonathanh@nvidia.com>, Mikko Perttunen <mperttunen@nvidia.com>, linux-pci@vger.kernel.org,
	linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

I checked this patch and there seems to be some issue with generating
MSI interrupts having these addresses as MSI target addresses.

On Tue, Oct 3, 2017 at 1:49 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Fri, Sep 29, 2017 at 09:22:07AM +0200, Thierry Reding wrote:
>> On Thu, Sep 28, 2017 at 09:57:19PM -0500, Bjorn Helgaas wrote:
>> > On Thu, Sep 28, 2017 at 04:19:12PM +0200, Thierry Reding wrote:
>> > > On Mon, Sep 25, 2017 at 10:44:29AM +0530, vidya sagar wrote:
>> > > > Inline...
>> > > >
>> > > > On Sat, Sep 23, 2017 at 11:47 AM, Thierry Reding
>> > > > <thierry.reding@gmail.com> wrote:
>> > > > >
>> > > > > The Tegra20 PCIe controller has a different address range for MSI, so
>> > > > > select a different target address.
>> > > > >
>> > > > > Fixes: d7bd554f27c9 ("PCI: tegra: Do not allocate MSI target memory")
>> > > > > Signed-off-by: Thierry Reding <treding@nvidia.com>
>> > > > > ---
>> > > > >  drivers/pci/host/pci-tegra.c | 12 +++++++++++-
>> > > > >  1 file changed, 11 insertions(+), 1 deletion(-)
>> > > > >
>> > > > > diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
>> > > > > index e8e1ddbaabc9..5b02ea59524b 100644
>> > > > > --- a/drivers/pci/host/pci-tegra.c
>> > > > > +++ b/drivers/pci/host/pci-tegra.c
>> > > > > @@ -1563,8 +1563,18 @@ static int tegra_pcie_enable_msi(struct tegra_pcie *pcie)
>> > > > >          * none of the Tegra SoCs that contain this PCI host bridge can
>> > > > >          * address more than 16 GiB of system memory, the last 4 KiB of
>> > > > >          * these 1012 GiB is a good candidate.
>> > > > > +        *
>> > > > > +        * Unfortunately, Tegra20 is slightly different in that the physical
>> > > > > +        * address for this MSI region is limited to the lower 32 bits of the
>> > > > > +        * address map, so the address that we pick is going to have to be
>> > > > > +        * located somewhere within the region addressable by the CPU and
>> > > > > +        * on-SoC controllers. To be on the safe side, we select an address
>> > > > > +        * from a region that is marked unused (0xf0010000 - 0xfffeffff).
>> > > > >          */
>> > > > > -       msi->phys = 0xfcfffff000;
>> > > > > +       if (soc->msi_base_shift > 0)
>> > > > > +               msi->phys = 0xfcfffff000;
>> > > > > +       else
>> > > > > +               msi->phys = 0x00f0010000;
>> > > >
>> > > > Can we use this for later Tegra chip versions as well?
>> > > > Reason being, if an end point's config space says that it cannot
>> > > > support >32-bit MSI addresses (Marvel SATA controller being one
>> > > > example), with the current code, we still allocate an address of
>> > > > >32-bits, resulting in end point not being able to generate MSI
>> > > > interrupt (as it discards >32-bits where generating upstream memory
>> > > > write transaction for MSI)
>> > >
>> > > Looks like the universal fix for this may not be trivial, so perhaps in
>> > > the meantime this one could go in in order to restore MSI for TrimSlice
>> > > (and other Tegra20 boards)?
>> > >
>> > > Bjorn: do you have any objections to taking this into v4.13 via a stable
>> > > backport? 32-bit only MSI were never guaranteed to work because prior to
>> > > this patch the address was taken from an allocated page, which may or
>> > > may not have been > 4 GiB.
>> > >
>> > > We could then go and fix 32-bit MSI hopefully in time for 4.14, but it'd
>> > > be a shame if v4.13 keeps being broken just because we're trying to
>> > > settle on the right solution for 32-bit MSI.
>> >
>> > I don't know your hardware, so I don't have any suggestions about your
>> > strategy for choosing addresses.
>> >
>> > To me it looks slightly obscure to use "soc->msi_base_shift == 0" to
>> > identify SoCs that can only use 32-bit MSI, but maybe that makes sense
>> > if you know the hardware.
>>
>> I should probably clarify this change. msi_base_shift == 0 applies only
>> to Tegra20. This is because the implementation of the PCI host bridge on
>> Tegra20 has a bug that doesn't actually shift the address written to the
>> AFI_MSI_FPCI_BAR_ST by 8 bits to the left for matching. This was fixed
>> in Tegra30 (and later), hence why we have this special case in the
>> driver. It works around the issue on Tegra20.
>>
>> A side-effect of that is that MSIs on Tegra20 can only go to the lower
>> 32 bits of the physical address space, whereas later chips can address
>> the full 40 bits.
>>
>> As Vidya points out, using any MSI target address > 4 GiB causes devices
>> with 32-bit MSI only capability to not work because they will truncate
>> the address and therefore the MSI controller won't be able to match at
>> any time.
>>
>> So a proper fix is to select an MSI target address < 4 GiB for all the
>> chips, which would fix the regression *and* enable 32-bit MSI. However,
>> currently the only known regression is on TrimSlice (Tegra20), where a
>> change in MSI target address will fix the regression.
>>
>> For all other SoCs, commit d7bd554f27c9 ("PCI: tegra: Do not allocate
>> MSI target memory") technically regresses for 32-bit MSI only capable
>> endpoints. However, since before that commit the MSI target address was
>> derived from an allocated page, 32-bit MSI were not guaranteed to work
>> either. On any system with > 2 GiB of RAM the MSI target page is likely
>> to be located in a region that 32-bit MSI could not address.
>>
>> > The stable backport policy is that the fix must first exist in Linus'
>> > tree.  The normal path is for fixes to be merged for v4.15, so they
>> > wouldn't appear in Linus' tree until after v4.14 releases.
>> >
>> > If I merge a fix via for-linus, it could be merged to Linus' tree
>> > before v4.14 and could be backported to v4.13 before v4.14.  But we'd
>> > have to make a case for doing that, e.g., this fixes a regression or
>> > something we broke during the v4.14 merge window, or it's some other
>> > serious bug fix.
>>
>> The offending commit d7bd554f27c9 ("PCI: tegra: Do not allocate MSI
>> target memory") was introduced in v4.13 and it causes a regression on
>> Tegra20, in particular the TrimSlice board. Other devices could be
>> affected, but the TrimSlice is the only one I'm aware of that people
>> still care about and use.
>>
>> I think this meets all the criteria for merging via for-linus. I'd like
>> to see this fixed in v4.14 and backported to v4.13. I think we have two
>> options at this point: one is to apply this fix, which addresses the
>> TrimSlice regression but doesn't fix a potential regression on Tegra30
>> and later (I'm not aware of any being reported, though). I have a local
>> patch (attached), which should also fix that. An alternative would be to
>> revert the offending commit (it reverts cleanly on linux-next). In both
>> cases the fix/revert should be backported to v4.13.
>
> Ok, I see three options and I can't tell which one you're suggesting:
>
>   1) Apply "this fix" (I assume this is your original patch that tests
>   msi_base_shift)
>
>   2) Apply the patch below that adds a .msi_target field
>
>   3) Revert d7bd554f27c9
>
> I'd like your proposal, with a changelog that includes the rationale
> for including in v4.14 and the stable backport indication.
>
> I'm going to mark the patches in this thread as "changes requested" so
> patchwork will pick up whatever resolution you propose.
>
>> Vidya, Jon, Mikko: can you test the attached patch? It works for me on
>> Tegra20 (TrimSlice), Tegra30 (Beaver), Tegra124 (Jetson TK1) and
>> Tegra210 (Jetson TX1, with a Realtek NIC attached). It'd be good to get
>> some broader coverage, though.
>>
>> Thierry
>> --- >8 ---
>> From 36108b8facc443170f91d64bb8d6bed79f5de0ba Mon Sep 17 00:00:00 2001
>> From: Thierry Reding <treding@nvidia.com>
>> Date: Wed, 27 Sep 2017 11:42:31 +0200
>> Subject: [PATCH] PCI: tegra: Enable the use of 32-bit MSI
>>
>> Using a value above the 32-bit boundary as MSI target address prevents
>> devices that are only 32-bit MSI capable from using MSI for signalling
>> interrupts.
>>
>> Fix this by relocating the MSI target address to somewhere within the
>> region in the address map reserved for PCI. Addresses were chosen to
>> be located in unused regions in the default configurations. While some
>> configuration could redefine the regions to include the new MSI target
>> addresses, doing so shouldn't cause any issues because this memory is
>> not actually accessed by MSI.
>>
>> Reported-by: Vidya Sagar <vidias@nvidia.com>
>> Signed-off-by: Thierry Reding <treding@nvidia.com>
>> ---
>>  drivers/pci/host/pci-tegra.c | 38 ++++++++++++++++++++------------------
>>  1 file changed, 20 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
>> index 5b02ea59524b..1026f9dbbbd7 100644
>> --- a/drivers/pci/host/pci-tegra.c
>> +++ b/drivers/pci/host/pci-tegra.c
>> @@ -242,6 +242,7 @@ struct tegra_msi {
>>  struct tegra_pcie_soc {
>>       unsigned int num_ports;
>>       unsigned int msi_base_shift;
>> +     u64 msi_target;
>>       u32 pads_pll_ctl;
>>       u32 tx_ref_sel;
>>       u32 pads_refclk_cfg0;
>> @@ -1554,27 +1555,24 @@ static int tegra_pcie_enable_msi(struct tegra_pcie *pcie)
>>        * MSI writes, which means that the MSI target address doesn't have
>>        * to point to actual physical memory. Rather than allocating one 4
>>        * KiB page of system memory that's never used, we can simply pick
>> -      * an arbitrary address within an area reserved for system memory
>> -      * in the FPCI address map.
>> +      * an arbitrary address within a reserved area in the FPCI address
>> +      * map.
>>        *
>> -      * However, in order to avoid confusion, we pick an address that
>> -      * doesn't map to physical memory. The FPCI address map reserves a
>> -      * 1012 GiB region for system memory and memory-mapped I/O. Since
>> -      * none of the Tegra SoCs that contain this PCI host bridge can
>> -      * address more than 16 GiB of system memory, the last 4 KiB of
>> -      * these 1012 GiB is a good candidate.
>> +      * Note that MSI writes are never committed to memory, so it doesn't
>> +      * really matter which address we pick. However, since the address
>> +      * may show up at some point and potentially confuse users, the best
>> +      * solution would be to pick an address that is obviously not within
>> +      * system memory. The FPCI address map contains a range that cannot
>> +      * be accessed by any Tegra CPU, but unfortunately that excludes the
>> +      * usage for 32-bit MSI capable devices.
>>        *
>> -      * Unfortunately, Tegra20 is slightly different in that the physical
>> -      * address for this MSI region is limited to the lower 32 bits of the
>> -      * address map, so the address that we pick is going to have to be
>> -      * located somewhere within the region addressable by the CPU and
>> -      * on-SoC controllers. To be on the safe side, we select an address
>> -      * from a region that is marked unused (0xf0010000 - 0xfffeffff).
>> +      * Instead, in order to support both 32-bit and 64-bit MSI, choose a
>> +      * memory address within the PCI MMIO region that is currently not
>> +      * used for configuration space, downstream I/O, prefetchable or non
>> +      * prefetchable memory. This is hard-coded on a per-chip basis and
>> +      * is hopefully clear enough not to confuse anyone.
>>        */
>> -     if (soc->msi_base_shift > 0)
>> -             msi->phys = 0xfcfffff000;
>> -     else
>> -             msi->phys = 0x00f0010000;
>> +     msi->phys = soc->msi_target;
>>
>>       afi_writel(pcie, msi->phys >> soc->msi_base_shift, AFI_MSI_FPCI_BAR_ST);
>>       afi_writel(pcie, msi->phys, AFI_MSI_AXI_BAR_ST);
>> @@ -2097,6 +2095,7 @@ static void tegra_pcie_enable_ports(struct tegra_pcie *pcie)
>>  static const struct tegra_pcie_soc tegra20_pcie = {
>>       .num_ports = 2,
>>       .msi_base_shift = 0,
>> +     .msi_target = 0x81fff000,
>>       .pads_pll_ctl = PADS_PLL_CTL_TEGRA20,
>>       .tx_ref_sel = PADS_PLL_CTL_TXCLKREF_DIV10,
>>       .pads_refclk_cfg0 = 0xfa5cfa5c,
>> @@ -2111,6 +2110,7 @@ static const struct tegra_pcie_soc tegra20_pcie = {
>>  static const struct tegra_pcie_soc tegra30_pcie = {
>>       .num_ports = 3,
>>       .msi_base_shift = 8,
>> +     .msi_target = 0x01fff000,
>>       .pads_pll_ctl = PADS_PLL_CTL_TEGRA30,
>>       .tx_ref_sel = PADS_PLL_CTL_TXCLKREF_BUF_EN,
>>       .pads_refclk_cfg0 = 0xfa5cfa5c,
>> @@ -2126,6 +2126,7 @@ static const struct tegra_pcie_soc tegra30_pcie = {
>>  static const struct tegra_pcie_soc tegra124_pcie = {
>>       .num_ports = 2,
>>       .msi_base_shift = 8,
>> +     .msi_target = 0x01fff000,
>>       .pads_pll_ctl = PADS_PLL_CTL_TEGRA30,
>>       .tx_ref_sel = PADS_PLL_CTL_TXCLKREF_BUF_EN,
>>       .pads_refclk_cfg0 = 0x44ac44ac,
>> @@ -2140,6 +2141,7 @@ static const struct tegra_pcie_soc tegra124_pcie = {
>>  static const struct tegra_pcie_soc tegra210_pcie = {
>>       .num_ports = 2,
>>       .msi_base_shift = 8,
>> +     .msi_target = 0x01fff000,
>>       .pads_pll_ctl = PADS_PLL_CTL_TEGRA30,
>>       .tx_ref_sel = PADS_PLL_CTL_TXCLKREF_BUF_EN,
>>       .pads_refclk_cfg0 = 0x90b890b8,
>> --
>> 2.14.1
>
>
