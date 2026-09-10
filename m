Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F973D0BE4;
	Thu, 10 Sep 2026 07:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789025756; cv=none; b=O3K3724CBSdhieMDhdCH03qsg7joOwLsiikJbi4x7aPk8EvhLFR2GxZwIcX5vW/4OzrsFC6Nsyn0+V3Af4cNHEB2kjTVWs+ApOf31KmPE35Xc4mCqHSTPgfSnLhBydpNGZGaVcMU+aT41B/s5j4Q3x3oyWgz2IDcIeZ6M2ju6ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789025756; c=relaxed/simple;
	bh=9i1wCqX6HSLtBL5QuFdomp+x1QJOM659aThRFtaCzn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oRcuLD4FeP4t1Hr5KDv4yMOXTV/kSC8jBB6I2YHLCWGW9MIJ1howaRTjn/P3WLTrx0bl4lVExqVjlx0nDsiaOYY6gouDGGRzR01N1GxwRzjwGnX3laQK0QVljDpxMZx1tAggO/DZx9LeqFisLaT51Wp1NhCm1VIGE05fpAtapHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PS9YOzOU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PS9YOzOU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 156391F00893;
	Thu, 10 Sep 2026 07:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789025743;
	bh=cun19agpFs20dxL3PqVIu8DFsPGUzDnjytEHRGalrdg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PS9YOzOUhokYgSTYgeuVyHQh8Ky90pFxfmnTosxvSuHivxCOij2MrZ8o2b17l+l4K
	 kGW3FOAYy8iYyZcYiCkTJqulJ4CGRWVF34RXYv06Iz+lvoo9FXch3y5/578PkuxS+9
	 kFLlR/VNiy24zibsvgwhNeP/X1mVj3aw3RnSJahFCJtrR9uwxnQILqGcASPkG4ZkLg
	 D02M+VL0al39esKQDitrXCRhlXFj+Tvp7s4fDYzgTp2Clak9Ai0NWqTrMTMMdDW915
	 19W1t31YG8UFL7gr1bbNunSab7ICV2jiuArmOWbS55LHhVN5Y8fhcqCYlMI9QwqySm
	 96is6Zob3VX2A==
Date: Thu, 10 Sep 2026 09:35:34 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Bjorn Andersson <andersson@kernel.org>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, shengchao.guo@oss.qualcomm.com
Subject: Re: [PATCH v3 5/5] phy: qcom: qmp-pcie: Add Nord Gen5x16 PCIe
 multi-PHY support
Message-ID: <u7mzcesup3ubh2i46ynhubzmyh4v2oro2shzx23ubkkqelbvbv@rbfoswgjkdo2>
References: <20260909-nord-v3-0-b0a82721c547@oss.qualcomm.com>
 <20260909-nord-v3-5-b0a82721c547@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260909-nord-v3-5-b0a82721c547@oss.qualcomm.com>

On Wed, Sep 09, 2026 at 05:18:20PM +0530, Krishna Chaitanya Chundru wrote:
> Add support for the Nord Gen5x16 bifurcated QMP PCIe PHY.
> 
> Nord has a single PCIe PHY block split into four ports which can be
> used in multiple lane configurations: x16, x8+x8, x8+x4+x4 and
> x8+x4+x2+x2. The active topology is selected through the link mode
> configuration register, and the driver exposes the corresponding PHY
> instances based on that mode.
> 
> Unlike Glymur, where the PHY is initialized by firmware, Nord requires
> Linux to program the PHY registers. Add the PLL, TXRXZ, PCS and PCS
> lane initialization tables, along with the required power-up,
> power-down and soft-reset sequencing.
> 
> Add per-port and grouped PHY configurations for all supported Nord
> lane modes. Also add support for regular PHY resets in addition to the
> NOCSR resets, and attach the PHY power domains using the device
> created for the PHY itself (devm_phy_create()) rather than the parent
> multi-PHY platform device, so each PHY instance's GDSCs are managed
> against its own device.
> 

Can you split Nord addition and cleanup into separate patches?

> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-pcie-multiphy.c  | 938 +++++++++++++++++++--
>  drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6_40.h |  56 ++
>  drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_40.h      |  14 +
>  .../qualcomm/phy-qcom-qmp-qserdes-com-pcie-v6_40.h |  94 +++
>  .../phy-qcom-qmp-qserdes-txrxz-pcie-v6_40.h        | 194 +++++
>  5 files changed, 1222 insertions(+), 74 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie-multiphy.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie-multiphy.c
> index e93cba4369fb..122136ca9c7e 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie-multiphy.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie-multiphy.c
> @@ -3,6 +3,7 @@
>   * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>   */
>  
> +#include <linux/bits.h>
>  #include <linux/clk.h>
>  #include <linux/clk-provider.h>
>  #include <linux/delay.h>
> @@ -20,8 +21,16 @@
>  #include <linux/regulator/consumer.h>
>  #include <linux/reset.h>
>  #include <linux/slab.h>
> +#include <linux/string.h>
> +
> +#include <dt-bindings/phy/phy-qcom-qmp.h>
>  
>  #include "phy-qcom-qmp.h"
> +#include "phy-qcom-qmp-common.h"
> +#include "phy-qcom-qmp-pcs-v6_40.h"
> +#include "phy-qcom-qmp-pcs-pcie-v6_40.h"
> +#include "phy-qcom-qmp-qserdes-com-pcie-v6_40.h"
> +#include "phy-qcom-qmp-qserdes-txrxz-pcie-v6_40.h"
>  
>  #define PHY_INIT_COMPLETE_TIMEOUT_US		10000
>  
> @@ -30,8 +39,19 @@ enum qmp_pcie_glymur_link_mode {
>  	QMP_PCIE_GLYMUR_MODE_X4X4,
>  };
>  
> +enum qmp_pcie_nord_link_mode {
> +	QMP_PCIE_NORD_MODE_X16,
> +	QMP_PCIE_NORD_MODE_X8_X8,
> +	QMP_PCIE_NORD_MODE_X8_X4_X4,
> +	QMP_PCIE_NORD_MODE_X8_X4_X2_X2
> +};
> +
>  enum qphy_reg_layout {
>  	QPHY_PCS_STATUS,
> +	QPHY_PCS_START_CONTROL,
> +	QPHY_PCS_SW_RESET,
> +	QPHY_PCS_POWER_DOWN_CONTROL,
> +	QPHY_COM_BIAS_EN_CLKBUFLR_EN,
>  	QPHY_LAYOUT_SIZE
>  };
>  
> @@ -39,16 +59,48 @@ static const unsigned int pciephy_v8_50_regs_layout[QPHY_LAYOUT_SIZE] = {
>  	[QPHY_PCS_STATUS]		= QPHY_V8_50_PCS_STATUS1,
>  };
>  
> +static const unsigned int nord_pciephy_v6_40_regs_layout[QPHY_LAYOUT_SIZE] = {
> +	[QPHY_PCS_STATUS]		= QPHY_V6_40_PCS_STATUS1,
> +	[QPHY_PCS_START_CONTROL]	= QPHY_V6_40_PCS_START_CONTROL,
> +	[QPHY_PCS_SW_RESET]		= QPHY_V6_40_PCS_SW_RESET,
> +	[QPHY_PCS_POWER_DOWN_CONTROL]	= QPHY_V6_40_PCS_POWER_DOWN_CONTROL,
> +	[QPHY_COM_BIAS_EN_CLKBUFLR_EN]	= QSERDES_PCIE_V6_40_COM_BIAS_EN_CLKBUFLR_EN,
> +};
> +
>  struct qmp_pcie_offsets {
>  	u16 pcs;
> +	u16 pll;
> +	u16 txrxz;
> +	u16 pcs_lanez;
> +};
> +
> +struct qmp_phy_cfg_tbls {
> +	const struct qmp_phy_init_tbl *pll_common;
> +	int pll_common_num;
> +	const struct qmp_phy_init_tbl *txrxz;
> +	int txrxz_num;
> +	const struct qmp_phy_init_tbl *pcs;
> +	int pcs_num;
> +	const struct qmp_phy_init_tbl *pcs_lanez;
> +	int pcs_lanez_num;
> +	const struct qmp_phy_init_tbl *port_split_pre_pwrup;
> +	int port_split_pre_pwrup_num;
> +	const struct qmp_phy_init_tbl *port_split_post_cfg;
> +	int port_split_post_cfg_num;
>  };
>  
>  struct qmp_phy_cfg {
>  	const struct qmp_pcie_offsets *offsets;
> +	struct qmp_phy_cfg_tbls tbls;
> +	struct qmp_phy_init_tbl **pll_tbls;
> +	int *pll_nums;
> +	bool port_split;
>  	const char * const *reg_names;
>  	int num_regs;
>  	const char * const *pd_names;
>  	int num_pds;
> +	const char * const *reset_list;
> +	int num_resets;
>  	const char * const *nocsr_reset_list;
>  	int num_nocsr_resets;
>  	const char * const *vreg_list;
> @@ -64,9 +116,11 @@ struct qmp_phy_cfg {
>  struct qmp_pcie {
>  	struct device *dev;
>  	const struct qmp_phy_cfg *cfg;
> +	bool skip_init;
>  	void __iomem **base;
>  	struct clk_bulk_data *clks;
>  	struct clk_bulk_data *pipe_clks;
> +	struct reset_control_bulk_data *resets;
>  	struct reset_control_bulk_data *nocsr_resets;
>  	struct regulator_bulk_data *vregs;
>  	struct device **pd_devs;
> @@ -89,6 +143,10 @@ struct qmp_pcie_match_data {
>  	u32 num_modes;
>  };
>  
> +/* QSERDES_PCIE_V6_40_COM_BIAS_EN_CLKBUFLR_EN bits */
> +#define COM_BIAS_EN				BIT(0)
> +#define COM_BIAS_EN_MUX				BIT(1)
> +
>  static const char * const glymur_pciephy_clk_l[] = {
>  	"aux", "cfg_ahb", "ref", "rchng", "phy_b_aux",
>  };
> @@ -113,31 +171,19 @@ static const char * const glymur_vreg_l[] = {
>  	"vdda-phy", "vdda-pll", "vdda-refgen0p9", "vdda-refgen1p2",
>  };
>  
> -static const char * const glymur_pciephy_a_reg_l[] = {
> +static const char * const pciephy_port_a_reg_l[] = {
>  	"port_a",
>  };
>  
> -static const char * const glymur_pciephy_b_reg_l[] = {
> +static const char * const pciephy_port_b_reg_l[] = {
>  	"port_b",
>  };
>  
> -static const char * const glymur_pciephy_reg_l[] = {
> +static const char * const pciephy_port_ab_reg_l[] = {
>  	"port_a", "port_b",
>  };
>  
> -static const char * const glymur_pciephy_a_pd_l[] = {
> -	"port_a",
> -};
> -
> -static const char * const glymur_pciephy_b_pd_l[] = {
> -	"port_b",
> -};
> -
> -static const char * const glymur_pciephy_pd_l[] = {
> -	"port_a", "port_b",
> -};
> -
> -static const char * const glymur_pciephy_a_nocsr_reset_l[] = {
> +static const char * const pciephy_port_a_nocsr_reset_l[] = {
>  	"port_a_nocsr",
>  };
>  
> @@ -145,7 +191,7 @@ static const char * const glymur_pciephy_nocsr_reset_l[] = {
>  	"port_a_nocsr", "port_b_nocsr",
>  };
>  
> -static const char * const glymur_pciephy_b_nocsr_reset_l[] = {
> +static const char * const pciephy_port_b_nocsr_reset_l[] = {
>  	"port_b_nocsr",
>  };
>  
> @@ -155,12 +201,12 @@ static const struct qmp_pcie_offsets glymur_pcie_offsets_v8_50 = {
>  
>  static const struct qmp_phy_cfg glymur_qmp_gen5x4_pciephy_a_cfg = {
>  	.offsets		= &glymur_pcie_offsets_v8_50,
> -	.reg_names		= glymur_pciephy_a_reg_l,
> -	.num_regs		= ARRAY_SIZE(glymur_pciephy_a_reg_l),
> -	.pd_names		= glymur_pciephy_a_pd_l,
> -	.num_pds		= ARRAY_SIZE(glymur_pciephy_a_pd_l),
> -	.nocsr_reset_list	= glymur_pciephy_a_nocsr_reset_l,
> -	.num_nocsr_resets	= ARRAY_SIZE(glymur_pciephy_a_nocsr_reset_l),
> +	.reg_names		= pciephy_port_a_reg_l,
> +	.num_regs		= ARRAY_SIZE(pciephy_port_a_reg_l),
> +	.pd_names		= pciephy_port_a_reg_l,
> +	.num_pds		= ARRAY_SIZE(pciephy_port_a_reg_l),
> +	.nocsr_reset_list	= pciephy_port_a_nocsr_reset_l,
> +	.num_nocsr_resets	= ARRAY_SIZE(pciephy_port_a_nocsr_reset_l),
>  	.vreg_list		= glymur_vreg_l,
>  	.num_vregs		= ARRAY_SIZE(glymur_vreg_l),
>  	.regs			= pciephy_v8_50_regs_layout,
> @@ -173,12 +219,12 @@ static const struct qmp_phy_cfg glymur_qmp_gen5x4_pciephy_a_cfg = {
>  
>  static const struct qmp_phy_cfg glymur_qmp_gen5x4_pciephy_b_cfg = {
>  	.offsets		= &glymur_pcie_offsets_v8_50,
> -	.reg_names		= glymur_pciephy_b_reg_l,
> -	.num_regs		= ARRAY_SIZE(glymur_pciephy_b_reg_l),
> -	.pd_names		= glymur_pciephy_b_pd_l,
> -	.num_pds		= ARRAY_SIZE(glymur_pciephy_b_pd_l),
> -	.nocsr_reset_list	= glymur_pciephy_b_nocsr_reset_l,
> -	.num_nocsr_resets	= ARRAY_SIZE(glymur_pciephy_b_nocsr_reset_l),
> +	.reg_names		= pciephy_port_b_reg_l,
> +	.num_regs		= ARRAY_SIZE(pciephy_port_b_reg_l),
> +	.pd_names		= pciephy_port_b_reg_l,
> +	.num_pds		= ARRAY_SIZE(pciephy_port_b_reg_l),
> +	.nocsr_reset_list	= pciephy_port_b_nocsr_reset_l,
> +	.num_nocsr_resets	= ARRAY_SIZE(pciephy_port_b_nocsr_reset_l),
>  	.vreg_list		= glymur_vreg_l,
>  	.num_vregs		= ARRAY_SIZE(glymur_vreg_l),
>  	.regs			= pciephy_v8_50_regs_layout,
> @@ -191,10 +237,10 @@ static const struct qmp_phy_cfg glymur_qmp_gen5x4_pciephy_b_cfg = {
>  
>  static const struct qmp_phy_cfg glymur_qmp_gen5x8_pciephy_cfg = {
>  	.offsets		= &glymur_pcie_offsets_v8_50,
> -	.reg_names		= glymur_pciephy_reg_l,
> -	.num_regs		= ARRAY_SIZE(glymur_pciephy_reg_l),
> -	.pd_names		= glymur_pciephy_pd_l,
> -	.num_pds		= ARRAY_SIZE(glymur_pciephy_pd_l),
> +	.reg_names		= pciephy_port_ab_reg_l,
> +	.num_regs		= ARRAY_SIZE(pciephy_port_ab_reg_l),
> +	.pd_names		= pciephy_port_ab_reg_l,
> +	.num_pds		= ARRAY_SIZE(pciephy_port_ab_reg_l),
>  	.nocsr_reset_list	= glymur_pciephy_nocsr_reset_l,
>  	.num_nocsr_resets	= ARRAY_SIZE(glymur_pciephy_nocsr_reset_l),
>  	.vreg_list		= glymur_vreg_l,
> @@ -232,6 +278,645 @@ static const struct qmp_pcie_match_data glymur_qmp_gen5x8_match_data = {
>  	.num_modes	= ARRAY_SIZE(glymur_qmp_gen5x8_mode_cfgs),
>  };
>  
> +#define NORD_VREG_A "vdda-phy-a", "vdda-pll-a"
> +#define NORD_VREG_B "vdda-phy-b", "vdda-pll-b"
> +#define NORD_VREG_C "vdda-phy-c", "vdda-pll-c"
> +#define NORD_VREG_D "vdda-phy-d", "vdda-pll-d"

I agree with Shawn. These definitions provide no useful benefit and should be
dropped.

> +
> +static const char * const nord_pciephy_port_a_vreg_l[] = { NORD_VREG_A };
> +static const char * const nord_pciephy_port_b_vreg_l[] = { NORD_VREG_B };
> +static const char * const nord_pciephy_port_c_vreg_l[] = { NORD_VREG_C };
> +static const char * const nord_pciephy_port_d_vreg_l[] = { NORD_VREG_D };
> +
> +static const char * const nord_pciephy_port_cd_vreg_l[] = {
> +	NORD_VREG_C, NORD_VREG_D,
> +};
> +
> +static const char * const nord_pciephy_port_bcd_vreg_l[] = {
> +	NORD_VREG_B, NORD_VREG_C, NORD_VREG_D,
> +};
> +
> +static const char * const nord_pciephy_port_abcd_vreg_l[] = {
> +	NORD_VREG_A, NORD_VREG_B, NORD_VREG_C, NORD_VREG_D,
> +};
> +
> +#undef NORD_VREG_A
> +#undef NORD_VREG_B
> +#undef NORD_VREG_C
> +#undef NORD_VREG_D
> +
> +static const struct qmp_pcie_offsets nord_pcie_offsets_v6_40 = {
> +	.pll      = 0x8000,
> +	.pcs      = 0x9000,
> +	.txrxz    = 0xd000,
> +	.pcs_lanez = 0xe800,
> +};
> +
> +static const struct qmp_phy_init_tbl nord_qmp_pcie_pll_tbl[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CLK_FWD_CONFIG_1,            0x0f),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_SSC_STEP_SIZE1_MODE2,        0xab),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_SSC_STEP_SIZE2_MODE2,        0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CP_CTRL_MODE2,               0x06),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_PLL_RCTRL_MODE2,             0x16),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_PLL_CCTRL_MODE2,             0x36),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CORECLK_DIV_MODE2,           0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_LOCK_CMP1_MODE2,             0x0a),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_LOCK_CMP2_MODE2,             0x1a),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DEC_START_MODE2,             0x68),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DIV_FRAC_START1_MODE2,       0xab),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DIV_FRAC_START2_MODE2,       0xaa),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DIV_FRAC_START3_MODE2,       0x02),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_BIN_VCOCAL_CMP_CODE1_MODE2,  0xa4),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_BIN_VCOCAL_CMP_CODE2_MODE2,  0x18),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_SSC_STEP_SIZE1_MODE1,        0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_SSC_STEP_SIZE2_MODE1,        0x03),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CP_CTRL_MODE1,               0x06),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_PLL_RCTRL_MODE1,             0x16),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_PLL_CCTRL_MODE1,             0x36),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CORECLK_DIV_MODE1,           0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_LOCK_CMP1_MODE1,             0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_LOCK_CMP2_MODE1,             0x0d),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DEC_START_MODE1,             0x68),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DIV_FRAC_START1_MODE1,       0xab),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DIV_FRAC_START2_MODE1,       0xaa),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DIV_FRAC_START3_MODE1,       0x02),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_BIN_VCOCAL_CMP_CODE1_MODE1,  0x52),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_BIN_VCOCAL_CMP_CODE2_MODE1,  0x0c),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_HSCLK_SEL_1,                 0x3c),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_HSCLK_SEL_2,                 0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_BIN_VCOCAL_HSCLK_SEL_1,      0x3c),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_BIN_VCOCAL_HSCLK_SEL_2,      0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_SSC_STEP_SIZE1_MODE0,        0xe0),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_SSC_STEP_SIZE2_MODE0,        0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CP_CTRL_MODE0,               0x06),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_PLL_RCTRL_MODE0,             0x16),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_PLL_CCTRL_MODE0,             0x36),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CORECLK_DIV_MODE0,           0x0a),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_LOCK_CMP1_MODE0,             0x40),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_LOCK_CMP2_MODE0,             0x03),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DEC_START_MODE0,             0x41),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DIV_FRAC_START1_MODE0,       0xab),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DIV_FRAC_START2_MODE0,       0xaa),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DIV_FRAC_START3_MODE0,       0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_BIN_VCOCAL_CMP_CODE1_MODE0,  0xd4),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_BIN_VCOCAL_CMP_CODE2_MODE0,  0x03),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_HSCLK_HS_SWITCH_SEL_1,       0x16),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_HSCLK_HS_SWITCH_SEL_2,       0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_BG_TIMER,                    0x0a),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_VCO_TUNE_CTRL,               0x40),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_SSC_EN_CENTER,               0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_SSC_PER1,                    0x62),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_SSC_PER2,                    0x02),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_POST_DIV_MUX,                0xc0),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_BIAS_EN_CLKBUFLR_EN,         0x1f),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CLK_ENABLE1,                 0x90),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_SYS_CLK_CTRL,                0x82),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_PLL_IVCO,                    0x1f),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_PLL_IVCO_MODE1,              0x1f),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_PLL_IVCO_MODE2,              0x1f),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_SYSCLK_EN_SEL,               0x08),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_LOCK_CMP_EN,                 0x46),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_LOCK_CMP_CFG,                0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_VCO_TUNE_MAP,                0x24),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CLK_SELECT,                  0x34),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CORE_CLK_EN,                 0xe0),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CMN_CONFIG_1,                0x86),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CMN_MISC1,                   0x88),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CMN_MODE,                    0x14),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_VCO_DC_LEVEL_CTRL,           0x0f),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CMN_CONFIG_2,                0x10),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CLK_EP_DIV_MODE1,            0x14),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CLK_EP_DIV_MODE0,            0x32),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_PSM_CAL_EN,                  0x05),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_PLL_SPARE_FOR_ECO,           0x40),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DCC_CAL_1,                   0x40),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DCC_CAL_2,                   0x07),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DCC_CAL_3,                   0x60),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DCC_CAL_8,                   0x32),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_IP_CTRL_AND_DP_SEL,          0xaf),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CMN_IETRIM,                  0x0d),
> +};
> +
> +static struct qmp_phy_init_tbl nord_qmp_pcie_pll_a_ovl_tbl[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DCC_CAL_7,                   0x31),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DCC_CAL_9,                   0x31),
> +};
> +
> +static struct qmp_phy_init_tbl nord_qmp_pcie_pll_b_ovl_tbl[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DCC_CAL_7,                   0x32),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DCC_CAL_9,                   0x22),
> +};
> +
> +static struct qmp_phy_init_tbl nord_qmp_pcie_pll_c_ovl_tbl[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DCC_CAL_7,                   0x20),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DCC_CAL_9,                   0x31),
> +};
> +
> +static struct qmp_phy_init_tbl nord_qmp_pcie_pll_d_ovl_tbl[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DCC_CAL_7,                   0x22),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DCC_CAL_9,                   0x22),
> +};

Above structs should be have 'const' qualifier.

> +
> +static const struct qmp_phy_init_tbl nord_qmp_pcie_txrxz_tbl[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_SIGDET_ENABLES,                     0x1c),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE2_B0,                   0xcd),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE2_B1,                   0x34),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE2_B2,                   0x55),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE2_B3,                   0x50),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE2_B4,                   0xac),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE2_B5,                   0xdb),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE2_B6,                   0x52),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE2_B7,                   0x3e),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE3_B0,                   0xce),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE3_B1,                   0x55),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE3_B2,                   0x6d),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE3_B3,                   0x60),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE3_B4,                   0x8c),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE3_B5,                   0x9d),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE3_B6,                   0x6d),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE3_B7,                   0x26),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE4_B0,                   0xfb),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE4_B1,                   0xea),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE4_B2,                   0xe8),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE4_B3,                   0x70),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE4_B4,                   0x9c),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE4_B5,                   0xf4),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE4_B6,                   0x6d),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE4_B7,                   0x3b),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_SUMMER_CAL_SPD_MODE_RATE_0123,   0x6f),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_TX_ADAPT_POST_THRESH1,              0x02),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_TX_ADAPT_POST_THRESH2,              0x0d),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_PHPRE_CTRL,                         0x20),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_TX_ADPT_CTRL,                       0x30),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE_0_1_B0,                0xff),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE_0_1_B1,                0x4a),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE_0_1_B2,                0x77),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE_0_1_B3,                0x50),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE_0_1_B4,                0x9a),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE_0_1_B5,                0x47),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE_0_1_B6,                0x52),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE_0_1_B7,                0x1d),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_LANE_MODE_1,                        0x05),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_LANE_MODE_2,                        0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_LANE_MODE_3,                        0x41),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_LANE_MODE_4,                        0x0f),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_PCIE_V6_40_TOP_LDO_CODE_CTRL1,           0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_PCIE_V6_40_TOP_LDO_CODE_CTRL2,           0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_PCIE_V6_40_TOP_LDO_CODE_CTRL3,           0x81),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_PCIE_V6_40_TOP_LDO_CODE_CTRL4,           0x8d),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_LOCK_CTRL,                      0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_DFE_TAP1_DAC_ENABLE,                0x1c),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_DFE_TAP2_DAC_ENABLE,                0x1c),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_DFE_TAP345_DAC_ENABLE,              0x18),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_DFE_TAP67_DAC_ENABLE,               0x10),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_CP_CUR_FLL_RATE0,               0x07),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_CP_CUR_FLL_RATE1,               0x07),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_CP_CUR_FLL_RATE2,               0x0a),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_CP_CUR_FLL_RATE3,               0x0a),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_CP_CUR_FLL_RATE4,               0x0a),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_CP_CUR_PLL_RATE0,               0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_CP_CUR_PLL_RATE1,               0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_CP_CUR_PLL_RATE2,               0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_CP_CUR_PLL_RATE3,               0x03),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_CP_CUR_PLL_RATE4,               0x03),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_FLL_DIV_RATIO_RATE_0123,        0x94),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_LOOP_CCODE_RATE_01,             0x66),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_LOOP_CCODE_RATE_23,             0x77),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_LOOP_CCODE_RATE4,               0x07),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_IQTUNE_CTRL,                    0x58),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_IQTUNE_MAN_INDEX,               0x0d),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_IQTUNE_ANA_CTRL,                0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_LOOP_FUNC_CTRL,                 0xd0),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KP_CAL_UPPER_FREQ_DIFF_BND1_RATE0,  0xff),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KP_CAL_UPPER_FREQ_DIFF_BND1_RATE1,  0xff),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KP_CAL_UPPER_FREQ_DIFF_BND1_RATE2,  0xff),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KP_CAL_UPPER_FREQ_DIFF_BND1_RATE3,  0xff),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KP_CAL_UPPER_FREQ_DIFF_BND1_RATE4,  0xff),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KP_CAL_LOWER_FREQ_DIFF_BND_RATE0,   0x15),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KP_CAL_LOWER_FREQ_DIFF_BND_RATE1,   0x15),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KP_CAL_LOWER_FREQ_DIFF_BND_RATE2,   0x10),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KP_CAL_LOWER_FREQ_DIFF_BND_RATE3,   0x07),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KP_CAL_LOWER_FREQ_DIFF_BND_RATE4,   0x0c),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KP_CODE_OVRD_RATE_2_3,              0x24),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_IVCM_CAL_CTRL2,                  0x83),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_IVCM_CAL_CTRL3,                  0x44),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_IVCM_CAL_CTRL4,                  0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_LOOP_RCODE_PLL_RATE_0_1,        0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_LOOP_RCODE_PLL_RATE_2_3,        0x11),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_LOOP_RCODE_PLL_RATE4,           0x02),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_LOOP_RCODE_FLL_RATE_0_1,        0x33),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_LOOP_RCODE_FLL_RATE_2_3,        0x33),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_LOOP_RCODE_FLL_RATE4,           0x03),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_LOOP_RCODE_FAST_RATE_0_1,       0x22),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_LOOP_RCODE_FAST_RATE_2_3,       0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_LOOP_RCODE_FAST_RATE4,          0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_IQTUNE_DIV2_CTRL_RATE0123,      0x7f),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_CTUNE_MEAS_CNT1_RATE0,      0x13),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_CTUNE_MEAS_CNT2_RATE0,      0x13),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_CTUNE_MEAS_CNT1_RATE1,      0x26),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_CTUNE_MEAS_CNT2_RATE1,      0x26),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_CTUNE_MEAS_CNT1_RATE2,      0x9c),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_CTUNE_MEAS_CNT2_RATE2,      0x3d),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_CTUNE_MEAS_CNT1_RATE3,      0x9c),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_CTUNE_MEAS_CNT2_RATE3,      0x3d),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_CTUNE_MEAS_CNT1_RATE4,      0x09),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_CTUNE_MEAS_CNT2_RATE4,      0x3d),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_EQU_ADAPTOR_CNTRL3,              0x0a),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_EQU_ADAPTOR_CNTRL4,              0xaa),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_EQU_ADAPTOR_CNTRL5,              0x0a),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_VGA_CAL_CNTRL1,                     0xe1),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_VGA_CAL_MAN_VAL_RATE0_1,            0xdd),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_VGA_CAL_MAN_VAL_RATE2_3,            0xdc),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_VGA_CAL_MAN_VAL_RATE4,              0x05),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_CAP_CODE_OVRD_MUXES,        0x11),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_CAP_CODE_RATE_0123,         0x55),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_CAP_CODE_RATE4,             0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KVCO_IDEAL_FREQ_DIFF1_RATE0,        0x4b),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KVCO_IDEAL_FREQ_DIFF2_RATE0,        0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KVCO_IDEAL_FREQ_DIFF1_RATE1,        0x4b),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KVCO_IDEAL_FREQ_DIFF2_RATE1,        0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KVCO_IDEAL_FREQ_DIFF1_RATE2,        0x35),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KVCO_IDEAL_FREQ_DIFF2_RATE2,        0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KVCO_IDEAL_FREQ_DIFF1_RATE3,        0x28),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KVCO_IDEAL_FREQ_DIFF1_RATE4,        0x14),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KVCO_INIT_RATE_0_1,                 0x11),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KVCO_INIT_RATE_2_3,                 0x22),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KVCO_INIT_RATE_4,                   0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KVCO_CODE_OVRD_RATE0,               0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KVCO_CODE_OVRD_RATE1,               0x03),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KVCO_CODE_OVRD_RATE2,               0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_FREQ_LOCK_DET_DLY_RATE0,            0xff),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_FREQ_LOCK_DET_DLY_RATE1,            0xff),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_FREQ_LOCK_DET_DLY_RATE2,            0xff),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_FREQ_LOCK_DET_DLY_RATE3,            0xff),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_FREQ_LOCK_DET_DLY_RATE4,            0xff),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_VCTRL_RATE_0_1,                 0x43),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_VCTRL_RATE_2_3,                 0x44),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_TYPE_CONFIG,                0x03),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CTLE_POST_CAL_OFFSET_RATE_0_1_2,    0x67),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_EN_LOWFREQ,                 0x1f),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RES_CODE_LANE_OFFSET_RX,            0x18),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_GM_CAL_RES_RATE0_1,                 0x88),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_GM_CAL_RES_RATE2_3,                 0x88),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_GM_CAL_RES_RATE4,                   0x09),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_VTHRESH_CAL_MAN_VAL_RATE4,          0x56),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CLKBUF_ENABLE,                      0x40),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_VCO_CTUNE_UPPER_BND_RATE0,          0x1e),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_VCO_CTUNE_UPPER_BND_RATE1,          0x1e),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_VCO_CTUNE_UPPER_BND_RATE2,          0x1e),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_VCO_CTUNE_UPPER_BND_RATE3,          0x1e),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_VCO_CTUNE_UPPER_BND_RATE4,          0x1e),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_SIGDET_CNTRL,                       0x2f),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_SIGDET_LVL,                         0x84),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_SIGDET_CAL_CTRL1,                   0x10),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_DIG_BKUP_CTRL15,                    0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_DIG_BKUP_CTRL16,                    0x52),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RESTRIM_CAL_CTRL,                   0x08),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RESTRIM_POST_CAL_OFFSET,            0x10),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RESTRIM_VREF_SEL,                   0x16),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_BLW_CTRL,                           0x3c),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_BLW_MAN_VAL_RATE3,                  0x17),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_BLW_MAN_VAL_RATE4,                  0x17),
> +};
> +
> +static const struct qmp_phy_init_tbl nord_qmp_pcie_pcs_tbl[] = {
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_POWER_STATE_CONFIG2,        0x3d),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_POWER_STATE_CONFIG5,        0xe4),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_POWER_STATE_CONFIG6,        0x1f),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_POWER_STATE_CONFIG7,        0x0d),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_MULTIPHY_CONFIG2,           0x01),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_PCS_TX_RX_CONFIG2,          0xe4),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_PCS_TX_RX_CONFIG3,          0x30),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_PCS_TX_RX_CONFIG5,          0x05),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_PCS_TX_RX_CONFIG6,          0x08),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_PCS_TX_RX_CONFIG7,          0x20),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_PCS_TX_RX_CONFIG8,          0x20),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_PCS_TX_RX_CONFIG10,         0x40),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_DIVTX_CLK_DCC_CAL_CONFIG2,  0x00),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_DIVTX_CLK_DCC_CAL_CONFIG3,  0x00),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_DIVTX_CLK_DCC_CAL_CONFIG4,  0x00),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_ENDPOINT_REFCLK_DRIVE,      0xc1),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_RX_SIGDET_LVL,              0x66),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_OSC_DTCT_ACTIONS,           0x00),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_LOCK_DETECT_CONFIG1,        0xff),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_ALIGN_DETECT_CONFIG1,       0x00),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_ALIGN_DETECT_CONFIG2,       0x04),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_ALIGN_DETECT_CONFIG3,       0x1f),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_ALIGN_DETECT_CONFIG7,       0x35),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_ALIGN_DETECT_CONFIG8,       0x3e),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_EQ_CONFIG1,                 0x06),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_EQ_CONFIG2,                 0x1c),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_G345_EQ_CONFIG1,            0x03),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_G345_EQ_CONFIG3,            0x00),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_G3_EQ_CONFIG1,              0x00),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_G3_EQ_CONFIG5,              0x90),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_G3_EQ_CONFIG7,              0x0d),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_G4_EQ_CONFIG1,              0x00),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_G4_EQ_CONFIG5,              0x90),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_G4_EQ_CONFIG7,              0x0d),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_G5_EQ_CONFIG1,              0x00),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_G5_EQ_CONFIG5,              0x90),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_G5_EQ_CONFIG7,              0x0d),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_TEST_CONTROL1,              0x08),
> +};
> +
> +static const struct qmp_phy_init_tbl nord_qmp_pcie_pcs_lanez_tbl[] = {
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_LANEZ_OUTSIG_MX_CTRL2,  0x00),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_LANEZ_OUTSIG_MX_CTRL5,  0x00),
> +};
> +
> +static const struct qmp_phy_init_tbl nord_qmp_pcie_port_split_pre_pwrup_tbl[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_PRE_STALL_LDO_BOOST_EN,  0x80),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_LDO_TIMER_CTRL,          0x91),
> +};
> +
> +static const struct qmp_phy_init_tbl nord_qmp_pcie_port_split_post_cfg_tbl[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_LDO_TIMER_CTRL,          0x11),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_PRE_STALL_LDO_BOOST_EN,  0x00),
> +};
> +
> +static const struct qmp_phy_cfg_tbls nord_qmp_pcie_tbls = {
> +	.pll_common     = nord_qmp_pcie_pll_tbl,
> +	.pll_common_num = ARRAY_SIZE(nord_qmp_pcie_pll_tbl),
> +	.txrxz     = nord_qmp_pcie_txrxz_tbl,
> +	.txrxz_num = ARRAY_SIZE(nord_qmp_pcie_txrxz_tbl),
> +	.pcs       = nord_qmp_pcie_pcs_tbl,
> +	.pcs_num   = ARRAY_SIZE(nord_qmp_pcie_pcs_tbl),
> +	.pcs_lanez     = nord_qmp_pcie_pcs_lanez_tbl,
> +	.pcs_lanez_num = ARRAY_SIZE(nord_qmp_pcie_pcs_lanez_tbl),
> +	.port_split_pre_pwrup     = nord_qmp_pcie_port_split_pre_pwrup_tbl,
> +	.port_split_pre_pwrup_num = ARRAY_SIZE(nord_qmp_pcie_port_split_pre_pwrup_tbl),
> +	.port_split_post_cfg      = nord_qmp_pcie_port_split_post_cfg_tbl,
> +	.port_split_post_cfg_num  = ARRAY_SIZE(nord_qmp_pcie_port_split_post_cfg_tbl),
> +};
> +
> +static struct qmp_phy_init_tbl *nord_qmp_pcie_pll_a[] = {
> +	nord_qmp_pcie_pll_a_ovl_tbl,
> +};
> +
> +static int nord_qmp_pcie_pll_a_nums[] = {
> +	ARRAY_SIZE(nord_qmp_pcie_pll_a_ovl_tbl),
> +};
> +
> +static struct qmp_phy_init_tbl *nord_qmp_pcie_pll_b[] = {
> +	nord_qmp_pcie_pll_b_ovl_tbl,
> +};
> +
> +static int nord_qmp_pcie_pll_b_nums[] = {
> +	ARRAY_SIZE(nord_qmp_pcie_pll_b_ovl_tbl),
> +};
> +
> +static struct qmp_phy_init_tbl *nord_qmp_pcie_pll_c[] = {
> +	nord_qmp_pcie_pll_c_ovl_tbl,
> +};
> +
> +static int nord_qmp_pcie_pll_c_nums[] = {
> +	ARRAY_SIZE(nord_qmp_pcie_pll_c_ovl_tbl),
> +};
> +
> +static struct qmp_phy_init_tbl *nord_qmp_pcie_pll_d[] = {
> +	nord_qmp_pcie_pll_d_ovl_tbl,
> +};
> +
> +static int nord_qmp_pcie_pll_d_nums[] = {
> +	ARRAY_SIZE(nord_qmp_pcie_pll_d_ovl_tbl),
> +};
> +
> +static struct qmp_phy_init_tbl *nord_qmp_pcie_pll_cd[] = {
> +	nord_qmp_pcie_pll_c_ovl_tbl, nord_qmp_pcie_pll_d_ovl_tbl,
> +};
> +
> +static int nord_qmp_pcie_pll_cd_nums[] = {
> +	ARRAY_SIZE(nord_qmp_pcie_pll_c_ovl_tbl), ARRAY_SIZE(nord_qmp_pcie_pll_d_ovl_tbl),
> +};
> +
> +static struct qmp_phy_init_tbl *nord_qmp_pcie_pll_bcd[] = {
> +	nord_qmp_pcie_pll_b_ovl_tbl, nord_qmp_pcie_pll_c_ovl_tbl, nord_qmp_pcie_pll_d_ovl_tbl,
> +};
> +
> +static int nord_qmp_pcie_pll_bcd_nums[] = {
> +	ARRAY_SIZE(nord_qmp_pcie_pll_b_ovl_tbl), ARRAY_SIZE(nord_qmp_pcie_pll_c_ovl_tbl),
> +	ARRAY_SIZE(nord_qmp_pcie_pll_d_ovl_tbl),
> +};
> +
> +static struct qmp_phy_init_tbl *nord_qmp_pcie_pll_abcd[] = {
> +	nord_qmp_pcie_pll_a_ovl_tbl, nord_qmp_pcie_pll_b_ovl_tbl,
> +	nord_qmp_pcie_pll_c_ovl_tbl, nord_qmp_pcie_pll_d_ovl_tbl,
> +};
> +
> +static int nord_qmp_pcie_pll_abcd_nums[] = {
> +	ARRAY_SIZE(nord_qmp_pcie_pll_a_ovl_tbl), ARRAY_SIZE(nord_qmp_pcie_pll_b_ovl_tbl),
> +	ARRAY_SIZE(nord_qmp_pcie_pll_c_ovl_tbl), ARRAY_SIZE(nord_qmp_pcie_pll_d_ovl_tbl),
> +};

Again, missing 'const' qualifier in above structs.

> +
> +#define NORD_PORT_A "port_a"
> +#define NORD_PORT_B "port_b"
> +#define NORD_PORT_C "port_c"
> +#define NORD_PORT_D "port_d"
> +
> +static const char * const nord_pciephy_port_c_reg_l[] = { NORD_PORT_C };
> +static const char * const nord_pciephy_port_d_reg_l[] = { NORD_PORT_D };
> +static const char * const nord_pciephy_port_cd_reg_l[] = { NORD_PORT_C, NORD_PORT_D };
> +static const char * const nord_pciephy_port_bcd_reg_l[] = { NORD_PORT_B, NORD_PORT_C, NORD_PORT_D };
> +static const char * const nord_pciephy_port_abcd_reg_l[] = {
> +	NORD_PORT_A, NORD_PORT_B, NORD_PORT_C, NORD_PORT_D
> +};
> +
> +static const char * const nord_pciephy_port_a_clk_l[] = { "aux_a", "cfg_ahb_a", "rchng_a", "ref" };
> +static const char * const nord_pciephy_port_b_clk_l[] = {
> +	"aux_a", "aux_b", "cfg_ahb_b", "rchng_b", "ref",
> +};
> +
> +static const char * const nord_pciephy_port_c_clk_l[] = {
> +	"aux_a", "aux_c", "cfg_ahb_c", "rchng_c", "ref",
> +};
> +
> +static const char * const nord_pciephy_port_d_clk_l[] = {
> +	"aux_a", "aux_d", "cfg_ahb_d", "rchng_d", "ref",
> +};
> +
> +static const char * const nord_pciephy_port_cd_clk_l[] = {
> +	"aux_a", "aux_c", "cfg_ahb_c", "rchng_c", "aux_d", "cfg_ahb_d", "rchng_d", "ref",
> +};
> +
> +static const char * const nord_pciephy_port_bcd_clk_l[] = {
> +	"aux_a", "aux_b", "cfg_ahb_b", "rchng_b",
> +	"aux_c", "cfg_ahb_c", "rchng_c",
> +	"aux_d", "cfg_ahb_d", "rchng_d", "ref",
> +};
> +
> +static const char * const nord_pciephy_port_abcd_clk_l[] = {
> +	"aux_a", "cfg_ahb_a", "rchng_a",
> +	"aux_b", "cfg_ahb_b", "rchng_b",
> +	"aux_c", "cfg_ahb_c", "rchng_c",
> +	"aux_d", "cfg_ahb_d", "rchng_d", "ref",
> +};
> +
> +static const char * const nord_pciephy_port_a_pipeclk_l[] = { "pipe_a" };
> +static const char * const nord_pciephy_port_b_pipeclk_l[] = { "pipe_b" };
> +static const char * const nord_pciephy_port_c_pipeclk_l[] = { "pipe_c" };
> +static const char * const nord_pciephy_port_d_pipeclk_l[] = { "pipe_d" };
> +
> +static const char * const nord_pciephy_port_c_nocsr_reset_l[] = { NORD_PORT_C "_nocsr" };
> +static const char * const nord_pciephy_port_d_nocsr_reset_l[] = { NORD_PORT_D "_nocsr" };
> +static const char * const nord_pciephy_port_cd_nocsr_reset_l[] = {
> +	NORD_PORT_C "_nocsr", NORD_PORT_D "_nocsr",
> +};
> +static const char * const nord_pciephy_port_bcd_nocsr_reset_l[] = {
> +	NORD_PORT_B "_nocsr", NORD_PORT_C "_nocsr", NORD_PORT_D "_nocsr",
> +};
> +
> +static const char * const nord_pciephy_port_abcd_nocsr_reset_l[] = {
> +	NORD_PORT_A "_nocsr", NORD_PORT_B "_nocsr", NORD_PORT_C "_nocsr", NORD_PORT_D "_nocsr",
> +};
> +
> +#undef NORD_PORT_A
> +#undef NORD_PORT_B
> +#undef NORD_PORT_C
> +#undef NORD_PORT_D
> +
> +static const char * const nord_pciephy_port_c_pd_l[] = { "port_a", "port_c" };
> +static const char * const nord_pciephy_port_d_pd_l[] = { "port_a", "port_d" };
> +static const char * const nord_pciephy_port_cd_pd_l[] = {
> +	"port_a", "port_c", "port_d",
> +};
> +
> +static const char * const nord_pciephy_port_bcd_pd_l[] = {
> +	"port_a", "port_b", "port_c", "port_d",
> +};
> +
> +#define NORD_QMP_PCIE_PORT_CFG(_port, _reg_l, _pd_l, _reset_l, _nocsr_reset_l, _pipeclk_l, \
> +				_port_split)					\
> +static const struct qmp_phy_cfg nord_qmp_pcie_port_##_port##_cfg = {		\
> +	.offsets		= &nord_pcie_offsets_v6_40,			\
> +	.tbls			= nord_qmp_pcie_tbls,				\
> +	.pll_tbls		= nord_qmp_pcie_pll_##_port,			\
> +	.pll_nums		= nord_qmp_pcie_pll_##_port##_nums,		\
> +	.port_split		= _port_split,					\
> +	.reg_names		= _reg_l,					\
> +	.num_regs		= ARRAY_SIZE(_reg_l),				\
> +	.pd_names		= _pd_l,					\
> +	.num_pds		= ARRAY_SIZE(_pd_l),				\
> +	.reset_list		= _reset_l,					\
> +	.num_resets		= ARRAY_SIZE(_reset_l),				\
> +	.nocsr_reset_list	= _nocsr_reset_l,				\
> +	.num_nocsr_resets	= ARRAY_SIZE(_nocsr_reset_l),			\
> +	.vreg_list		= nord_pciephy_port_##_port##_vreg_l,		\
> +	.num_vregs		= ARRAY_SIZE(nord_pciephy_port_##_port##_vreg_l),	\
> +	.regs			= nord_pciephy_v6_40_regs_layout,	\
> +	.phy_status		= PHYSTATUS_4_20,				\
> +	.clk_list		= nord_pciephy_port_##_port##_clk_l,		\
> +	.num_clks		= ARRAY_SIZE(nord_pciephy_port_##_port##_clk_l),	\
> +	.pipe_clk_list		= _pipeclk_l,					\
> +	.num_pipe_clks		= 1,						\
> +}
> +
> +NORD_QMP_PCIE_PORT_CFG(a, pciephy_port_a_reg_l, pciephy_port_a_reg_l, pciephy_port_a_reg_l,
> +			pciephy_port_a_nocsr_reset_l, nord_pciephy_port_a_pipeclk_l, true);
> +NORD_QMP_PCIE_PORT_CFG(b, pciephy_port_b_reg_l, pciephy_port_ab_reg_l, pciephy_port_b_reg_l,
> +			pciephy_port_b_nocsr_reset_l, nord_pciephy_port_b_pipeclk_l, true);
> +NORD_QMP_PCIE_PORT_CFG(c, nord_pciephy_port_c_reg_l, nord_pciephy_port_c_pd_l,
> +			nord_pciephy_port_c_reg_l, nord_pciephy_port_c_nocsr_reset_l,
> +			nord_pciephy_port_c_pipeclk_l, true);
> +NORD_QMP_PCIE_PORT_CFG(d, nord_pciephy_port_d_reg_l, nord_pciephy_port_d_pd_l,
> +			nord_pciephy_port_d_reg_l, nord_pciephy_port_d_nocsr_reset_l,
> +			nord_pciephy_port_d_pipeclk_l, true);
> +NORD_QMP_PCIE_PORT_CFG(cd, nord_pciephy_port_cd_reg_l, nord_pciephy_port_cd_pd_l,
> +			nord_pciephy_port_cd_reg_l, nord_pciephy_port_cd_nocsr_reset_l,
> +			nord_pciephy_port_c_pipeclk_l, true);
> +NORD_QMP_PCIE_PORT_CFG(bcd, nord_pciephy_port_bcd_reg_l, nord_pciephy_port_bcd_pd_l,
> +			nord_pciephy_port_bcd_reg_l, nord_pciephy_port_bcd_nocsr_reset_l,
> +			nord_pciephy_port_b_pipeclk_l, true);
> +NORD_QMP_PCIE_PORT_CFG(abcd, nord_pciephy_port_abcd_reg_l, nord_pciephy_port_bcd_pd_l,
> +			nord_pciephy_port_abcd_reg_l, nord_pciephy_port_abcd_nocsr_reset_l,
> +			nord_pciephy_port_a_pipeclk_l, false);
> +
> +#undef NORD_QMP_PCIE_PORT_CFG
> +

Please avoid doing this undef.

> +static const struct qmp_phy_cfg * const nord_qmp_gen5x16_mode_x16_cfgs[] = {
> +	&nord_qmp_pcie_port_abcd_cfg,
> +};
> +

[...]

>  MODULE_DEVICE_TABLE(of, qmp_pcie_multiphy_of_match_table);
> @@ -739,5 +1529,5 @@ static struct platform_driver qmp_pcie_multiphy_driver = {
>  module_platform_driver(qmp_pcie_multiphy_driver);
>  
>  MODULE_AUTHOR("Qiang Yu <qiang.yu@oss.qualcomm.com>");
> -MODULE_DESCRIPTION("Qualcomm QMP PCIe Multi-PHY driver for Glymur");
> +MODULE_DESCRIPTION("Qualcomm QMP PCIe Multi-PHY driver for Glymur and Nord");

Drop the SoC names in description.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
