Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qc0-f178.google.com ([209.85.216.178]:53546 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753315AbaLBACQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 1 Dec 2014 19:02:16 -0500
Received: by mail-qc0-f178.google.com with SMTP id b13so9710377qcw.9
        for <linux-pci@vger.kernel.org>; Mon, 01 Dec 2014 16:02:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1417078449-9556-1-git-send-email-thierry.reding@gmail.com>
References: <1417078449-9556-1-git-send-email-thierry.reding@gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 1 Dec 2014 17:01:53 -0700
Message-ID: <CAErSpo4XDv6Yn475eU7xyPoT6c2P9mckD-tmGtqCXcB1XYYRMw@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: tegra: Use physical range for I/O mapping
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Liviu Dudau <liviu.dudau@arm.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Nov 27, 2014 at 1:54 AM, Thierry Reding
<thierry.reding@gmail.com> wrote:
> From: Thierry Reding <treding@nvidia.com>
>
> Commit 0b0b0893d49b ("of/pci: Fix the conversion of IO ranges into IO
> resources") changed how I/O resources are parsed from DT. Rather than
> containing the physical address of the I/O region, the addresses will
> now be in I/O address space.
>
> On Tegra the union of all ranges is used to expose a top-level memory-
> mapped resource for the PCI host bridge. This helps to make /proc/iomem
> more readable.
>
> Combining both of the above, the union would now include the I/O space
> region. This causes a regression on Tegra20, where the physical base
> address of the PCIe controller (and therefore of the union) is located
> at physical address 0x80000000. Since I/O space starts at 0, the union
> will now include all of system RAM which starts at 0x00000000.
>
> This commit fixes this by keeping two copies of the I/O range: one that
> represents the range in the CPU's physical address space, the other for
> the range in the I/O address space. This allows the translation setup
> within the driver to reuse the physical addresses. The code registering
> the I/O region with the PCI core uses both ranges to establish the
> mapping.
>
> Fixes: 0b0b0893d49b ("of/pci: Fix the conversion of IO ranges into IO resources")
> Reported-by: Marc Zyngier <marc.zyngier@arm.com>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Applied to for-linus for v3.18 with:

  Tested-by: Marc Zyngier <marc.zyngier@arm.com>
  Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Thanks!

> ---
> Marc, any chance of getting a Tested-by from you on this? I think you
> said you were seeing this on Harmony and I'm pretty sure this should fix
> the issue for you as well.
>
> Bjorn, this fixes a regression on Tegra20 (it's hidden on later Tegra
> generations because the PCIe controller has moved to the first 1 GiB of
> physical address space) that was introduced in 3.18-rc1, so it would be
> good to get this in before the final 3.18 release.
>
> Changes in v2:
> - remove cleanup not essential to fix the regression (will be part of a
>   follow-up patch)
>
>  drivers/pci/host/pci-tegra.c | 28 ++++++++++++++++++++--------
>  1 file changed, 20 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
> index 3d43874319be..19bb19c7db4a 100644
> --- a/drivers/pci/host/pci-tegra.c
> +++ b/drivers/pci/host/pci-tegra.c
> @@ -276,6 +276,7 @@ struct tegra_pcie {
>
>         struct resource all;
>         struct resource io;
> +       struct resource pio;
>         struct resource mem;
>         struct resource prefetch;
>         struct resource busn;
> @@ -658,7 +659,6 @@ static int tegra_pcie_setup(int nr, struct pci_sys_data *sys)
>  {
>         struct tegra_pcie *pcie = sys_to_pcie(sys);
>         int err;
> -       phys_addr_t io_start;
>
>         err = devm_request_resource(pcie->dev, &pcie->all, &pcie->mem);
>         if (err < 0)
> @@ -668,14 +668,12 @@ static int tegra_pcie_setup(int nr, struct pci_sys_data *sys)
>         if (err)
>                 return err;
>
> -       io_start = pci_pio_to_address(pcie->io.start);
> -
>         pci_add_resource_offset(&sys->resources, &pcie->mem, sys->mem_offset);
>         pci_add_resource_offset(&sys->resources, &pcie->prefetch,
>                                 sys->mem_offset);
>         pci_add_resource(&sys->resources, &pcie->busn);
>
> -       pci_ioremap_io(nr * SZ_64K, io_start);
> +       pci_ioremap_io(pcie->pio.start, pcie->io.start);
>
>         return 1;
>  }
> @@ -786,7 +784,6 @@ static irqreturn_t tegra_pcie_isr(int irq, void *arg)
>  static void tegra_pcie_setup_translations(struct tegra_pcie *pcie)
>  {
>         u32 fpci_bar, size, axi_address;
> -       phys_addr_t io_start = pci_pio_to_address(pcie->io.start);
>
>         /* Bar 0: type 1 extended configuration space */
>         fpci_bar = 0xfe100000;
> @@ -799,7 +796,7 @@ static void tegra_pcie_setup_translations(struct tegra_pcie *pcie)
>         /* Bar 1: downstream IO bar */
>         fpci_bar = 0xfdfc0000;
>         size = resource_size(&pcie->io);
> -       axi_address = io_start;
> +       axi_address = pcie->io.start;
>         afi_writel(pcie, axi_address, AFI_AXI_BAR1_START);
>         afi_writel(pcie, size >> 12, AFI_AXI_BAR1_SZ);
>         afi_writel(pcie, fpci_bar, AFI_FPCI_BAR1);
> @@ -1690,8 +1687,23 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
>
>                 switch (res.flags & IORESOURCE_TYPE_BITS) {
>                 case IORESOURCE_IO:
> -                       memcpy(&pcie->io, &res, sizeof(res));
> -                       pcie->io.name = np->full_name;
> +                       memcpy(&pcie->pio, &res, sizeof(res));
> +                       pcie->pio.name = np->full_name;
> +
> +                       /*
> +                        * The Tegra PCIe host bridge uses this to program the
> +                        * mapping of the I/O space to the physical address,
> +                        * so we override the .start and .end fields here that
> +                        * of_pci_range_to_resource() converted to I/O space.
> +                        * We also set the IORESOURCE_MEM type to clarify that
> +                        * the resource is in the physical memory space.
> +                        */
> +                       pcie->io.start = range.cpu_addr;
> +                       pcie->io.end = range.cpu_addr + range.size - 1;
> +                       pcie->io.flags = IORESOURCE_MEM;
> +                       pcie->io.name = "I/O";
> +
> +                       memcpy(&res, &pcie->io, sizeof(res));
>                         break;
>
>                 case IORESOURCE_MEM:
> --
> 2.1.3
>
