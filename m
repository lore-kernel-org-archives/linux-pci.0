Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:15602 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750950AbdJ2Jne (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 29 Oct 2017 05:43:34 -0400
Subject: Re: [PATCH 09/12] PCI: tegra: Enable PCIe xclk clock clamping
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <jonathanh@nvidia.com>
CC: <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <kthota@nvidia.com>
References: <1509132569-9398-1-git-send-email-mmaddireddy@nvidia.com>
 <1509132569-9398-10-git-send-email-mmaddireddy@nvidia.com>
From: Vidya Sagar <vidyas@nvidia.com>
Message-ID: <f5173fb7-1c4a-f3bb-92a6-25034dfb3573@nvidia.com>
Date: Sun, 29 Oct 2017 15:13:15 +0530
MIME-Version: 1.0
In-Reply-To: <1509132569-9398-10-git-send-email-mmaddireddy@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On Saturday 28 October 2017 12:59 AM, Manikanta Maddireddy wrote:
> This patch enables PCIe xlck clock clamping by pad control. Pad control
> asserts UPHY lane sleep signal when L1 entry signal received from PCIe.
> UPHY sleep signal assertion is done per lane. Default clamp threshold
> margin is not enough to assert all UPHY lane sleep signals. Increase
> the clamp threshold in Tegra124, 132, 210 and 186.
>
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
>   drivers/pci/host/pci-tegra.c | 28 ++++++++++++++++++++++++++--
>   1 file changed, 26 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
> index 6028d5f3d5bb..8fbc5950785a 100644
> --- a/drivers/pci/host/pci-tegra.c
> +++ b/drivers/pci/host/pci-tegra.c
> @@ -224,8 +224,14 @@
>   #define  RP_VEND_CTL2_PCA_ENABLE (1 << 7)
>   
>   #define RP_PRIV_MISC	0x00000fe0
> -#define  RP_PRIV_MISC_PRSNT_MAP_EP_PRSNT (0xe << 0)
> -#define  RP_PRIV_MISC_PRSNT_MAP_EP_ABSNT (0xf << 0)
> +#define  RP_PRIV_MISC_PRSNT_MAP_EP_PRSNT		(0xe << 0)
> +#define  RP_PRIV_MISC_PRSNT_MAP_EP_ABSNT		(0xf << 0)
> +#define  RP_PRIV_MISC_CTLR_CLK_CLAMP_THRESHOLD_MASK	(0x7f << 16)
> +#define  RP_PRIV_MISC_CTLR_CLK_CLAMP_THRESHOLD		(0xf << 16)
> +#define  RP_PRIV_MISC_CTLR_CLK_CLAMP_ENABLE		(1 << 23)
> +#define  RP_PRIV_MISC_TMS_CLK_CLAMP_THRESHOLD_MASK	(0x7f << 24)
> +#define  RP_PRIV_MISC_TMS_CLK_CLAMP_THRESHOLD		(0xf << 24)
> +#define  RP_PRIV_MISC_TMS_CLK_CLAMP_ENABLE		(1 << 31)
>   
BIT macro is preferred here.
>   #define RP_LINK_CONTROL_STATUS			0x00000090
>   #define  RP_LINK_CONTROL_STATUS_DL_LINK_ACTIVE	0x20000000
> @@ -300,6 +306,7 @@ struct tegra_pcie_soc {
>   	bool force_pca_enable;
>   	bool program_uphy;
>   	bool program_ectl_settings;
> +	bool update_clamp_threshold;
>   };
>   
>   static inline struct tegra_msi *to_tegra_msi(struct msi_controller *chip)
> @@ -2156,6 +2163,7 @@ static void tegra_pcie_enable_rp_features(struct tegra_pcie_port *port)
>   
>   static void tegra_pcie_apply_sw_fixup(struct tegra_pcie_port *port)
>   {
> +	const struct tegra_pcie_soc *soc = port->pcie->soc;
>   	unsigned long value;
>   
>   	/* Optimal settings to enhance bandwidth */
> @@ -2170,6 +2178,17 @@ static void tegra_pcie_apply_sw_fixup(struct tegra_pcie_port *port)
>   	value = readl(port->base + RP_VEND_XP_BIST);
>   	value |= RP_VEND_XP_BIST_GOTO_L1_L2_AFTER_DLLP_DONE;
>   	writel(value, port->base + RP_VEND_XP_BIST);
> +
> +	value = readl(port->base + RP_PRIV_MISC);
> +	value |= (RP_PRIV_MISC_CTLR_CLK_CLAMP_ENABLE |
> +			 RP_PRIV_MISC_TMS_CLK_CLAMP_ENABLE);
> +	if (soc->update_clamp_threshold) {
> +		value &= ~(RP_PRIV_MISC_CTLR_CLK_CLAMP_THRESHOLD_MASK |
> +				RP_PRIV_MISC_TMS_CLK_CLAMP_THRESHOLD_MASK);
> +		value |= (RP_PRIV_MISC_CTLR_CLK_CLAMP_THRESHOLD |
> +				RP_PRIV_MISC_TMS_CLK_CLAMP_THRESHOLD);
> +	}
> +	writel(value, port->base + RP_PRIV_MISC);
>   }
>   /*
>    * FIXME: If there are no PCIe cards attached, then calling this function
> @@ -2306,6 +2325,7 @@ static const struct tegra_pcie_soc tegra20_pcie = {
>   	.force_pca_enable = false,
>   	.program_uphy = true,
>   	.program_ectl_settings = false,
> +	.update_clamp_threshold = false,
>   };
>   
>   static const struct tegra_pcie_soc tegra30_pcie = {
> @@ -2323,6 +2343,7 @@ static const struct tegra_pcie_soc tegra30_pcie = {
>   	.force_pca_enable = false,
>   	.program_uphy = true,
>   	.program_ectl_settings = false,
> +	.update_clamp_threshold = false,
>   };
>   
>   static const struct tegra_pcie_soc tegra124_pcie = {
> @@ -2339,6 +2360,7 @@ static const struct tegra_pcie_soc tegra124_pcie = {
>   	.force_pca_enable = false,
>   	.program_uphy = true,
>   	.program_ectl_settings = false,
> +	.update_clamp_threshold = true,
>   };
>   
>   static const struct tegra_pcie_soc tegra210_pcie = {
> @@ -2363,6 +2385,7 @@ static const struct tegra_pcie_soc tegra210_pcie = {
>   	.force_pca_enable = true,
>   	.program_uphy = true,
>   	.program_ectl_settings = true,
> +	.update_clamp_threshold = true,
>   };
>   
>   static const struct tegra_pcie_soc tegra186_pcie = {
> @@ -2380,6 +2403,7 @@ static const struct tegra_pcie_soc tegra186_pcie = {
>   	.force_pca_enable = false,
>   	.program_uphy = false,
>   	.program_ectl_settings = false,
> +	.update_clamp_threshold = false,
>   };
>   
>   static const struct of_device_id tegra_pcie_of_match[] = {
