Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752855AbdKTVVx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 20 Nov 2017 16:21:53 -0500
Date: Mon, 20 Nov 2017 15:21:52 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Vidya Sagar <vidyas@nvidia.com>
Cc: treding@nvidia.com, bhelgaas@google.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        kthota@nvidia.com, swarren@nvidia.com, mmaddireddy@nvidia.com
Subject: Re: [PATCH V3 1/3] PCI: tegra: Apply sw fixups to support ASPM-L1
 Sub-States
Message-ID: <20171120212151.GC16362@bhelgaas-glaptop.roam.corp.google.com>
References: <1510492674-12786-1-git-send-email-vidyas@nvidia.com>
 <1510492674-12786-2-git-send-email-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1510492674-12786-2-git-send-email-vidyas@nvidia.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Nov 12, 2017 at 06:47:52PM +0530, Vidya Sagar wrote:
> Programs T_cmrt (Commmon Mode Restore Time) and T_pwr_on (Power On)

Please use the exact names used in the spec.  In this case, I think
that would be "Port Common_Mode_Restore_Time" and "Port T_POWER_ON"
(from the L1 PM Substates Capabilities Register, sec 7.33.2).
Searching the spec for "T_cmrt" isn't going to find anything useful.

These look like things that maybe should be in the DT because they
depend on external component values, so you might need different
values depending on what board the Tegra is on?  Same for clk_m?

> values to get them reflected in ASPM-L1 Sub-States capability registers
> Also adjusts internal counter values according to 19.2 MHz clk_m value
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> V2:
> * no change in this patch
> 
> V3:
> * no change in this patch
> 
>  drivers/pci/host/pci-tegra.c | 59 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
> 
> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
> index adae03d671ab..6d68f49f152e 100644
> --- a/drivers/pci/host/pci-tegra.c
> +++ b/drivers/pci/host/pci-tegra.c
> @@ -40,6 +40,7 @@
>  #include <linux/of_pci.h>
>  #include <linux/of_platform.h>
>  #include <linux/pci.h>
> +#include <linux/pci-aspm.h>
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
>  #include <linux/reset.h>
> @@ -191,6 +192,27 @@
>  #define RP_PRIV_XP_DL	0x494
>  #define  RP_PRIV_XP_DL_GEN2_UPD_FC_TSHOLD	(0x1ff << 1)
>  
> +#define RP_L1_PM_SUBSTATES_CTL				0xC00
> +#define RP_L1_PM_SUBSTATES_CTL_CM_RTIME_MASK		(0xFF << 8)
> +#define RP_L1_PM_SUBSTATES_CTL_CM_RTIME_SHIFT		8
> +#define RP_L1_PM_SUBSTATES_CTL_T_PWRN_SCL_MASK		(0x3 << 16)
> +#define RP_L1_PM_SUBSTATES_CTL_T_PWRN_SCL_SHIFT		16
> +#define RP_L1_PM_SUBSTATES_CTL_T_PWRN_VAL_MASK		(0x1F << 19)
> +#define RP_L1_PM_SUBSTATES_CTL_T_PWRN_VAL_SHIFT		19
> +#define RP_L1_PM_SUBSTATES_CTL_HIDE_CAP			(0x1 << 24)
> +
> +#define RP_L1_PM_SUBSTATES_1_CTL			0xC04
> +#define RP_L1_PM_SUBSTATES_1_CTL_PWR_OFF_DLY_MASK	0x1FFF
> +#define RP_L1_PM_SUBSTATES_1_CTL_PWR_OFF_DLY		0x26
> +
> +#define RP_L1_PM_SUBSTATES_2_CTL			0xC08
> +#define RP_L1_PM_SUBSTATES_2_CTL_T_L1_2_DLY_MASK	0x1FFF
> +#define RP_L1_PM_SUBSTATES_2_CTL_T_L1_2_DLY		0x4D
> +#define RP_L1_PM_SUBSTATES_2_CTL_MICROSECOND_MASK	(0xFF << 13)
> +#define RP_L1_PM_SUBSTATES_2_CTL_MICROSECOND		(0x13 << 13)
> +#define RP_L1_PM_SUBSTATES_2_CTL_MICROSECOND_COMP_MASK	(0xF << 21)
> +#define RP_L1_PM_SUBSTATES_2_CTL_MICROSECOND_COMP	(0x2 << 21)
> +
>  #define RP_RX_HDR_LIMIT	0xe00
>  #define  RP_RX_HDR_LIMIT_PW_MASK	(0xff << 8)
>  #define  RP_RX_HDR_LIMIT_PW		(0x0e << 8)
> @@ -327,6 +349,7 @@ struct tegra_pcie_soc {
>  	bool RAW_violation_fixup;
>  	bool program_deskew_time;
>  	bool updateFC_threshold;
> +	bool has_aspm_l1ss;
>  };
>  
>  static inline struct tegra_msi *to_tegra_msi(struct msi_controller *chip)
> @@ -2251,6 +2274,37 @@ static void tegra_pcie_apply_sw_fixup(struct tegra_pcie_port *port)
>  		value |= RP_VEND_XP_UPDATE_FC_THRESHOLD_T210;
>  		writel(value, port->base + RP_VEND_XP);
>  	}
> +
> +	if (soc->has_aspm_l1ss) {
> +		/* Set Common Mode Restore Time to 30us */
> +		value = readl(port->base + RP_L1_PM_SUBSTATES_CTL);
> +		value &= ~RP_L1_PM_SUBSTATES_CTL_CM_RTIME_MASK;
> +		value |= (0x1E << RP_L1_PM_SUBSTATES_CTL_CM_RTIME_SHIFT);
> +		writel(value, port->base + RP_L1_PM_SUBSTATES_CTL);
> +
> +		/* set T_Power_On to 70us */
> +		value = readl(port->base + RP_L1_PM_SUBSTATES_CTL);
> +		value &= ~(RP_L1_PM_SUBSTATES_CTL_T_PWRN_SCL_MASK |
> +			RP_L1_PM_SUBSTATES_CTL_T_PWRN_VAL_MASK);
> +		value |= (1 << RP_L1_PM_SUBSTATES_CTL_T_PWRN_SCL_SHIFT) |
> +			(7 << RP_L1_PM_SUBSTATES_CTL_T_PWRN_VAL_SHIFT);
> +		writel(value, port->base + RP_L1_PM_SUBSTATES_CTL);
> +
> +		/* Following is based on clk_m being 19.2 MHz */
> +		value = readl(port->base + RP_L1_PM_SUBSTATES_1_CTL);
> +		value &= ~RP_L1_PM_SUBSTATES_1_CTL_PWR_OFF_DLY_MASK;
> +		value |= RP_L1_PM_SUBSTATES_1_CTL_PWR_OFF_DLY;
> +		writel(value, port->base + RP_L1_PM_SUBSTATES_1_CTL);
> +
> +		value = readl(port->base + RP_L1_PM_SUBSTATES_2_CTL);
> +		value &= ~RP_L1_PM_SUBSTATES_2_CTL_T_L1_2_DLY_MASK;
> +		value |= RP_L1_PM_SUBSTATES_2_CTL_T_L1_2_DLY;
> +		value &= ~RP_L1_PM_SUBSTATES_2_CTL_MICROSECOND_MASK;
> +		value |= RP_L1_PM_SUBSTATES_2_CTL_MICROSECOND;
> +		value &= ~RP_L1_PM_SUBSTATES_2_CTL_MICROSECOND_COMP_MASK;
> +		value |= RP_L1_PM_SUBSTATES_2_CTL_MICROSECOND_COMP;
> +		writel(value, port->base + RP_L1_PM_SUBSTATES_2_CTL);
> +	}
>  }
>  /*
>   * FIXME: If there are no PCIe cards attached, then calling this function
> @@ -2391,6 +2445,7 @@ static const struct tegra_pcie_soc tegra20_pcie = {
>  	.RAW_violation_fixup = false,
>  	.program_deskew_time = false,
>  	.updateFC_threshold = false,
> +	.has_aspm_l1ss = false,
>  };
>  
>  static const struct tegra_pcie_soc tegra30_pcie = {
> @@ -2412,6 +2467,7 @@ static const struct tegra_pcie_soc tegra30_pcie = {
>  	.RAW_violation_fixup = false,
>  	.program_deskew_time = false,
>  	.updateFC_threshold = false,
> +	.has_aspm_l1ss = false,
>  };
>  
>  static const struct tegra_pcie_soc tegra124_pcie = {
> @@ -2432,6 +2488,7 @@ static const struct tegra_pcie_soc tegra124_pcie = {
>  	.RAW_violation_fixup = true,
>  	.program_deskew_time = false,
>  	.updateFC_threshold = false,
> +	.has_aspm_l1ss = false,
>  };
>  
>  static const struct tegra_pcie_soc tegra210_pcie = {
> @@ -2460,6 +2517,7 @@ static const struct tegra_pcie_soc tegra210_pcie = {
>  	.RAW_violation_fixup = false,
>  	.program_deskew_time = true,
>  	.updateFC_threshold = true,
> +	.has_aspm_l1ss = true,
>  };
>  
>  static const struct tegra_pcie_soc tegra186_pcie = {
> @@ -2481,6 +2539,7 @@ static const struct tegra_pcie_soc tegra186_pcie = {
>  	.RAW_violation_fixup = false,
>  	.program_deskew_time = false,
>  	.updateFC_threshold = false,
> +	.has_aspm_l1ss = true,
>  };
>  
>  static const struct of_device_id tegra_pcie_of_match[] = {
> -- 
> 2.7.4
> 
