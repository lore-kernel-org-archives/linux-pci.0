Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kapsi.fi ([91.232.154.25]:59604 "EHLO mail.kapsi.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751702AbdJ3KGK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Oct 2017 06:06:10 -0400
Subject: Re: [PATCH V2 09/12] PCI: tegra: Enable PCIe xclk clock clamping
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        thierry.reding@gmail.com, bhelgaas@google.com,
        jonathanh@nvidia.com, vidyas@nvidia.com
References: <1509337143-25963-1-git-send-email-mmaddireddy@nvidia.com>
 <1509337143-25963-10-git-send-email-mmaddireddy@nvidia.com>
Cc: linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        kthota@nvidia.com
From: Mikko Perttunen <cyndis@kapsi.fi>
Message-ID: <61bed209-ec8f-cafb-5214-6f55e68c0610@kapsi.fi>
Date: Mon, 30 Oct 2017 12:06:08 +0200
MIME-Version: 1.0
In-Reply-To: <1509337143-25963-10-git-send-email-mmaddireddy@nvidia.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 30.10.2017 06:19, Manikanta Maddireddy wrote:
> This patch enables PCIe xlck clock clamping by pad control. Pad control
> asserts UPHY lane sleep signal when L1 entry signal received from PCIe.
> UPHY sleep signal assertion is done per lane. Default clamp threshold
> margin is not enough to assert all UPHY lane sleep signals. Increase
> the clamp threshold in Tegra124, 132, 210 and 186.
>
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
> V2:
> * no change in this patch
>
>  drivers/pci/host/pci-tegra.c | 28 ++++++++++++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
> index 7f1e34e670d7..3c625ccfa539 100644
> --- a/drivers/pci/host/pci-tegra.c
> +++ b/drivers/pci/host/pci-tegra.c
> @@ -224,8 +224,14 @@
>  #define  RP_VEND_CTL2_PCA_ENABLE (1 << 7)
>
>  #define RP_PRIV_MISC	0x00000fe0
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
>  #define RP_LINK_CONTROL_STATUS			0x00000090
>  #define  RP_LINK_CONTROL_STATUS_DL_LINK_ACTIVE	0x20000000
> @@ -300,6 +306,7 @@ struct tegra_pcie_soc {
>  	bool force_pca_enable;
>  	bool program_uphy;
>  	bool program_ectl_settings;
> +	bool update_clamp_threshold;
>  };
>
>  static inline struct tegra_msi *to_tegra_msi(struct msi_controller *chip)
> @@ -2156,6 +2163,7 @@ static void tegra_pcie_enable_rp_features(struct tegra_pcie_port *port)
>
>  static void tegra_pcie_apply_sw_fixup(struct tegra_pcie_port *port)
>  {
> +	const struct tegra_pcie_soc *soc = port->pcie->soc;
>  	unsigned long value;
>
>  	/* Optimal settings to enhance bandwidth */
> @@ -2170,6 +2178,17 @@ static void tegra_pcie_apply_sw_fixup(struct tegra_pcie_port *port)
>  	value = readl(port->base + RP_VEND_XP_BIST);
>  	value |= RP_VEND_XP_BIST_GOTO_L1_L2_AFTER_DLLP_DONE;
>  	writel(value, port->base + RP_VEND_XP_BIST);
> +
> +	value = readl(port->base + RP_PRIV_MISC);
> +	value |= (RP_PRIV_MISC_CTLR_CLK_CLAMP_ENABLE |
> +			 RP_PRIV_MISC_TMS_CLK_CLAMP_ENABLE);
> +	if (soc->update_clamp_threshold) {
> +		value &= ~(RP_PRIV_MISC_CTLR_CLK_CLAMP_THRESHOLD_MASK |
> +				RP_PRIV_MISC_TMS_CLK_CLAMP_THRESHOLD_MASK);
> +		value |= (RP_PRIV_MISC_CTLR_CLK_CLAMP_THRESHOLD |
> +				RP_PRIV_MISC_TMS_CLK_CLAMP_THRESHOLD);

Parentheses not needed in the OR operation.

We're starting to accumulate enough stuff here that maybe a separate 
function is warranted after all :) However, I'm not sure about the 
apply_sw_fixup name. It sounds like we're applying a fix for some broken 
software. So maybe something like tegra_pcie_apply_port_configuration or 
such?

> +	}
> +	writel(value, port->base + RP_PRIV_MISC);
>  }
>  /*
>   * FIXME: If there are no PCIe cards attached, then calling this function
> @@ -2306,6 +2325,7 @@ static const struct tegra_pcie_soc tegra20_pcie = {
>  	.force_pca_enable = false,
>  	.program_uphy = true,
>  	.program_ectl_settings = false,
> +	.update_clamp_threshold = false,
>  };
>
>  static const struct tegra_pcie_soc tegra30_pcie = {
> @@ -2323,6 +2343,7 @@ static const struct tegra_pcie_soc tegra30_pcie = {
>  	.force_pca_enable = false,
>  	.program_uphy = true,
>  	.program_ectl_settings = false,
> +	.update_clamp_threshold = false,
>  };
>
>  static const struct tegra_pcie_soc tegra124_pcie = {
> @@ -2339,6 +2360,7 @@ static const struct tegra_pcie_soc tegra124_pcie = {
>  	.force_pca_enable = false,
>  	.program_uphy = true,
>  	.program_ectl_settings = false,
> +	.update_clamp_threshold = true,
>  };
>
>  static const struct tegra_pcie_soc tegra210_pcie = {
> @@ -2363,6 +2385,7 @@ static const struct tegra_pcie_soc tegra210_pcie = {
>  	.force_pca_enable = true,
>  	.program_uphy = true,
>  	.program_ectl_settings = true,
> +	.update_clamp_threshold = true,
>  };
>
>  static const struct tegra_pcie_soc tegra186_pcie = {
> @@ -2380,6 +2403,7 @@ static const struct tegra_pcie_soc tegra186_pcie = {
>  	.force_pca_enable = false,
>  	.program_uphy = false,
>  	.program_ectl_settings = false,
> +	.update_clamp_threshold = false,
>  };
>
>  static const struct of_device_id tegra_pcie_of_match[] = {
>
