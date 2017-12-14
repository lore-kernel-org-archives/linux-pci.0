Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:4596 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753721AbdLNR4a (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Dec 2017 12:56:30 -0500
Subject: Re: [PATCH v2] PCI: tegra: Do not allocate MSI target memory
To: Thierry Reding <thierry.reding@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC: Jonathan Hunter <jonathanh@nvidia.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>
References: <20171214135620.13564-1-thierry.reding@gmail.com>
From: Vidya Sagar <vidyas@nvidia.com>
Message-ID: <2cc09bd5-63a4-6af8-245a-1f535bbe1ab1@nvidia.com>
Date: Thu, 14 Dec 2017 23:26:21 +0530
MIME-Version: 1.0
In-Reply-To: <20171214135620.13564-1-thierry.reding@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On Thursday 14 December 2017 07:26 PM, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>
> The PCI host bridge found on Tegra SoCs doesn't require the MSI target
> address to be backed by physical system memory. Writes are intercepted
> within the controller and never make it to the memory pointed to.
>
> Since no actual system memory is required, remove the allocation of a
> single page and hardcode the MSI target address with a special address
> on a per-SoC basis. Ideally this would be an address to an MMIO memory
> region (such as where the controller's register are located). However,
> those addresses don't work reliably across all Tegra generations. The
> only set of addresses that work consistently are those that point to
> external memory.
>
> This is not ideal, since those addresses could technically be used for
> DMA and hence be confusing. However, the first page of external memory
> is unlikely to be used and special enough to avoid confusion.
>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> Changes in v2:
> - use physical base address of system memory as MSI target address
>
> Vidya, Manikanta,
>
> I've tested this on all of Tegra20, Tegra30, Tegra124, Tegra210 and
> Tegra186, so I'm confident that this is finally a good set of addresses.
> However, it'd be good to get confirmation from you since we had
> conflicting test results the last time around.
>
> Thanks,
> Thierry
>
>   drivers/pci/host/pci-tegra.c | 41 +++++++++++++++++++++++++++++++++++------
>   1 file changed, 35 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
> index ee193767f77b..f2214ca1ad17 100644
> --- a/drivers/pci/host/pci-tegra.c
> +++ b/drivers/pci/host/pci-tegra.c
> @@ -236,7 +236,6 @@ struct tegra_msi {
>   	struct msi_controller chip;
>   	DECLARE_BITMAP(used, INT_PCI_MSI_NR);
>   	struct irq_domain *domain;
> -	unsigned long pages;
>   	struct mutex lock;
>   	u64 phys;
>   	int irq;
> @@ -246,6 +245,7 @@ struct tegra_msi {
>   struct tegra_pcie_soc {
>   	unsigned int num_ports;
>   	unsigned int msi_base_shift;
> +	u64 msi_target;
>   	u32 pads_pll_ctl;
>   	u32 tx_ref_sel;
>   	u32 pads_refclk_cfg0;
> @@ -1576,9 +1576,35 @@ static int tegra_pcie_enable_msi(struct tegra_pcie *pcie)
>   		goto err;
>   	}
>   
> -	/* setup AFI/FPCI range */
> -	msi->pages = __get_free_pages(GFP_KERNEL, 0);
> -	msi->phys = virt_to_phys((void *)msi->pages);
> +	/*
> +	 * The PCI host bridge on Tegra contains some logic that intercepts
> +	 * MSI writes, which means that the MSI target address doesn't have
> +	 * to point to actual physical memory. Rather than allocating one 4
> +	 * KiB page of system memory that's never used, we can simply pick
> +	 * an arbitrary address within a reserved area in the FPCI address
> +	 * map.
> +	 *
> +	 * Note that MSI writes are never committed to memory, so it doesn't
> +	 * really matter which address we pick. However, since the address
> +	 * may show up at some point and potentially confuse users, the best
> +	 * solution would be to pick an address that is obviously not within
> +	 * system memory. The FPCI address map contains a range that cannot
> +	 * be accessed by any Tegra CPU, but unfortunately that excludes the
> +	 * usage for 32-bit MSI capable devices.
> +	 *
> +	 * A good choice that supports both 32-bit and 64-bit MSI would be to
> +	 * pick a memory address within the PCI MMIO region that is currently
> +	 * not used for configuration space, downstream I/O, prefetchable or
> +	 * non prefetchable memory. However, it seems like not all chips will
> +	 * be able to intercept MSI writes to those addresses.
> +	 *
> +	 * The only reliable addresses that seem to work point to external
> +	 * memory. Pick the physical base address of system memory as the MSI
> +	 * target address. This is slightly less than ideal because it could
> +	 * technically, though unlikely, be used for DMA. However, since the
> +	 * MSI writes will be intercepted, this should be of little concern.
> +	 */
> +	msi->phys = soc->msi_target;
>   
>   	afi_writel(pcie, msi->phys >> soc->msi_base_shift, AFI_MSI_FPCI_BAR_ST);
>   	afi_writel(pcie, msi->phys, AFI_MSI_AXI_BAR_ST);
> @@ -1630,8 +1656,6 @@ static int tegra_pcie_disable_msi(struct tegra_pcie *pcie)
>   	afi_writel(pcie, 0, AFI_MSI_EN_VEC6);
>   	afi_writel(pcie, 0, AFI_MSI_EN_VEC7);
>   
> -	free_pages(msi->pages, 0);
> -
>   	if (msi->irq > 0)
>   		free_irq(msi->irq, pcie);
>   
> @@ -2140,6 +2164,7 @@ static void tegra_pcie_enable_ports(struct tegra_pcie *pcie)
>   static const struct tegra_pcie_soc tegra20_pcie = {
>   	.num_ports = 2,
>   	.msi_base_shift = 0,
> +	.msi_target = 0x00000000,
>   	.pads_pll_ctl = PADS_PLL_CTL_TEGRA20,
>   	.tx_ref_sel = PADS_PLL_CTL_TXCLKREF_DIV10,
>   	.pads_refclk_cfg0 = 0xfa5cfa5c,
> @@ -2155,6 +2180,7 @@ static const struct tegra_pcie_soc tegra20_pcie = {
>   static const struct tegra_pcie_soc tegra30_pcie = {
>   	.num_ports = 3,
>   	.msi_base_shift = 8,
> +	.msi_target = 0x80000000,
>   	.pads_pll_ctl = PADS_PLL_CTL_TEGRA30,
>   	.tx_ref_sel = PADS_PLL_CTL_TXCLKREF_BUF_EN,
>   	.pads_refclk_cfg0 = 0xfa5cfa5c,
> @@ -2171,6 +2197,7 @@ static const struct tegra_pcie_soc tegra30_pcie = {
>   static const struct tegra_pcie_soc tegra124_pcie = {
>   	.num_ports = 2,
>   	.msi_base_shift = 8,
> +	.msi_target = 0x80000000,
>   	.pads_pll_ctl = PADS_PLL_CTL_TEGRA30,
>   	.tx_ref_sel = PADS_PLL_CTL_TXCLKREF_BUF_EN,
>   	.pads_refclk_cfg0 = 0x44ac44ac,
> @@ -2186,6 +2213,7 @@ static const struct tegra_pcie_soc tegra124_pcie = {
>   static const struct tegra_pcie_soc tegra210_pcie = {
>   	.num_ports = 2,
>   	.msi_base_shift = 8,
> +	.msi_target = 0x80000000,
>   	.pads_pll_ctl = PADS_PLL_CTL_TEGRA30,
>   	.tx_ref_sel = PADS_PLL_CTL_TXCLKREF_BUF_EN,
>   	.pads_refclk_cfg0 = 0x90b890b8,
> @@ -2201,6 +2229,7 @@ static const struct tegra_pcie_soc tegra210_pcie = {
>   static const struct tegra_pcie_soc tegra186_pcie = {
>   	.num_ports = 3,
>   	.msi_base_shift = 8,
> +	.msi_target = 0x80000000,
When SMMU is enabled for PCIe, I think the IOVA region used is 
0x8000_0000 ~ 0xFFF0_0000
Wouldn't that be an issue then?
>   	.pads_pll_ctl = PADS_PLL_CTL_TEGRA30,
>   	.tx_ref_sel = PADS_PLL_CTL_TXCLKREF_BUF_EN,
>   	.pads_refclk_cfg0 = 0x80b880b8,
