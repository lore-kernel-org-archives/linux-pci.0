Return-Path: <SRS0=8ruR=SA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B564AC4360F
	for <linux-pci@archiver.kernel.org>; Fri, 29 Mar 2019 20:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D99F218EA
	for <linux-pci@archiver.kernel.org>; Fri, 29 Mar 2019 20:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553892780;
	bh=E/Evsnl8BXuaTHNd2dZWSF1UvHPGWs5+mvKtKxbXHnA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zGGcbYVeCYscHBaBNnP4z8C2BthBea9mjU/w2d3MBpDZRXgfhh8qXb07zFbiYOHFy
	 X2aWGueW4+VZqyTxEzZF4laUwD0wkWLAs10eQmNde6DIA16WARckYDJ5MYV4MBNWb6
	 qWHLnZlS5iUZUxUGhdn54q8KC6f0eyt/R562yGJM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730104AbfC2Uwy (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 29 Mar 2019 16:52:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:41108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730151AbfC2Uww (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 29 Mar 2019 16:52:52 -0400
Received: from localhost (odyssey.drury.edu [64.22.249.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6772218A3;
        Fri, 29 Mar 2019 20:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553892771;
        bh=E/Evsnl8BXuaTHNd2dZWSF1UvHPGWs5+mvKtKxbXHnA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CtVbDFbxy+mMLpBbTl5oHfzquq9lpr+Qfe91mltb0DgsGS3YBQUTOimCjGqdqtYA6
         C7t0oMVo8cueXsWQ1hc5imKunLthylokepvVmaXFtjHG289Nux5OGm5KI7Kx34hFbf
         zS0kr/cZS9yshWVatwCAxxzuEjjxwytzqtFa9yao=
Date:   Fri, 29 Mar 2019 15:52:49 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, kishon@ti.com, catalin.marinas@arm.com,
        will.deacon@arm.com, lorenzo.pieralisi@arm.com,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        mperttunen@nvidia.com, tiwai@suse.de, spujar@nvidia.com,
        skomatineni@nvidia.com, liviu.dudau@arm.com, krzk@kernel.org,
        heiko@sntech.de, horms+renesas@verge.net.au, olof@lixom.net,
        maxime.ripard@bootlin.com, andy.gross@linaro.org,
        bjorn.andersson@linaro.org, jagan@amarulasolutions.com,
        enric.balletbo@collabora.com, ezequiel@collabora.com,
        stefan.wahren@i2se.com, marc.w.gonzalez@free.fr,
        l.stach@pengutronix.de, tpiepho@impinj.com,
        hayashi.kunihiko@socionext.com, yue.wang@amlogic.com,
        shawn.lin@rock-chips.com, xiaowei.bao@nxp.com,
        devicetree@vger.kernel.org, mmaddireddy@nvidia.com,
        kthota@nvidia.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 09/10] PCI: tegra: Add Tegra194 PCIe support
Message-ID: <20190329203159.GG24180@google.com>
References: <1553613207-3988-1-git-send-email-vidyas@nvidia.com>
 <1553613207-3988-10-git-send-email-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553613207-3988-10-git-send-email-vidyas@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Vidya,

Wow, there's a lot of nice work here!  Thanks for that!

On Tue, Mar 26, 2019 at 08:43:26PM +0530, Vidya Sagar wrote:
> Add support for Synopsys DesignWare core IP based PCIe host controller
> present in Tegra194 SoC.

General comments:

  - There are a few multi-line comments that don't match the
    prevailing style:

        /*
	 * Text...
	 */

  - Comments and dev_info()/dev_err() messages are inconsistent about
    starting with upper-case or lower-case letters.

  - Use "MSI", "IRQ", "PCIe", "CPU", etc in comments and messages.

  - There are a few functions that use "&pdev->dev" many times; can
    you add a "struct device *dev = &pdev->dev" to reduce the
    redundancy?

> +#include "../../pcie/portdrv.h"

What's this for?  I didn't see any obvious uses of things from
portdrv.h, but I didn't actually try to build without it.

> +struct tegra_pcie_dw {
> +	struct device		*dev;
> +	struct resource		*appl_res;
> +	struct resource		*dbi_res;
> +	struct resource		*atu_dma_res;
> +	void __iomem		*appl_base;
> +	struct clk		*core_clk;
> +	struct reset_control	*core_apb_rst;
> +	struct reset_control	*core_rst;
> +	struct dw_pcie		pci;
> +	enum dw_pcie_device_mode mode;
> +
> +	bool disable_clock_request;
> +	bool power_down_en;
> +	u8 init_link_width;
> +	bool link_state;
> +	u32 msi_ctrl_int;
> +	u32 num_lanes;
> +	u32 max_speed;
> +	u32 init_speed;
> +	bool cdm_check;
> +	u32 cid;
> +	int pex_wake;
> +	bool update_fc_fixup;
> +	int n_gpios;
> +	int *gpios;
> +#if defined(CONFIG_PCIEASPM)
> +	u32 cfg_link_cap_l1sub;
> +	u32 event_cntr_ctrl;
> +	u32 event_cntr_data;
> +	u32 aspm_cmrt;
> +	u32 aspm_pwr_on_t;
> +	u32 aspm_l0s_enter_lat;
> +	u32 disabled_aspm_states;
> +#endif

The above could be indented the same as the rest of the struct?

> +	struct regulator	*pex_ctl_reg;
> +
> +	int			phy_count;
> +	struct phy		**phy;
> +
> +	struct dentry		*debugfs;
> +};

> +static void apply_bad_link_workaround(struct pcie_port *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct tegra_pcie_dw *pcie = dw_pcie_to_tegra_pcie(pci);
> +	u16 val;
> +
> +	/*
> +	 * NOTE:- Since this scenario is uncommon and link as
> +	 * such is not stable anyway, not waiting to confirm
> +	 * if link is really transiting to Gen-2 speed

s/transiting/transitioning/

I think there are other uses of "transit" when you mean "transition".

> +static int tegra_pcie_dw_rd_own_conf(struct pcie_port *pp, int where, int size,
> +				     u32 *val)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +
> +	/*
> +	 * This is an endpoint mode specific register happen to appear even
> +	 * when controller is operating in root port mode and system hangs
> +	 * when it is accessed with link being in ASPM-L1 state.
> +	 * So skip accessing it altogether
> +	 */
> +	if (where == PORT_LOGIC_MSIX_DOORBELL) {
> +		*val = 0x00000000;
> +		return PCIBIOS_SUCCESSFUL;
> +	} else {
> +		return dw_pcie_read(pci->dbi_base + where, size, val);
> +	}
> +}
> +
> +static int tegra_pcie_dw_wr_own_conf(struct pcie_port *pp, int where, int size,
> +				     u32 val)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +
> +	/* This is EP specific register and system hangs when it is
> +	 * accessed with link being in ASPM-L1 state.
> +	 * So skip accessing it altogether
> +	 */
> +	if (where == PORT_LOGIC_MSIX_DOORBELL)
> +		return PCIBIOS_SUCCESSFUL;
> +	else
> +		return dw_pcie_write(pci->dbi_base + where, size, val);

These two functions are almost identical and they could look more
similar.  This one has the wrong multi-line comment style, uses "EP"
instead of "endpoint", etc.  Use this style for the "if" since the
first case is really an error case:

  if (where == PORT_LOGIC_MSIX_DOORBELL) {
    ...
    return ...;
  }

  return dw_pcie_...();

> +static int tegra_pcie_dw_host_init(struct pcie_port *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct tegra_pcie_dw *pcie = dw_pcie_to_tegra_pcie(pci);
> +	int count = 200;
> +	u32 val, tmp, offset;
> +	u16 val_w;
> +
> +#if defined(CONFIG_PCIEASPM)
> +	pcie->cfg_link_cap_l1sub =
> +		dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_L1SS) +
> +		PCI_L1SS_CAP;
> +#endif
> +	val = dw_pcie_readl_dbi(pci, PCI_IO_BASE);
> +	val &= ~(IO_BASE_IO_DECODE | IO_BASE_IO_DECODE_BIT8);
> +	dw_pcie_writel_dbi(pci, PCI_IO_BASE, val);
> +
> +	val = dw_pcie_readl_dbi(pci, PCI_PREF_MEMORY_BASE);
> +	val |= CFG_PREF_MEM_LIMIT_BASE_MEM_DECODE;
> +	val |= CFG_PREF_MEM_LIMIT_BASE_MEM_LIMIT_DECODE;
> +	dw_pcie_writel_dbi(pci, PCI_PREF_MEMORY_BASE, val);
> +
> +	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 0);
> +
> +	/* Configure FTS */
> +	val = dw_pcie_readl_dbi(pci, PORT_LOGIC_ACK_F_ASPM_CTRL);
> +	val &= ~(N_FTS_MASK << N_FTS_SHIFT);
> +	val |= N_FTS_VAL << N_FTS_SHIFT;
> +	dw_pcie_writel_dbi(pci, PORT_LOGIC_ACK_F_ASPM_CTRL, val);
> +
> +	val = dw_pcie_readl_dbi(pci, PORT_LOGIC_GEN2_CTRL);
> +	val &= ~FTS_MASK;
> +	val |= FTS_VAL;
> +	dw_pcie_writel_dbi(pci, PORT_LOGIC_GEN2_CTRL, val);
> +
> +	/* Enable as 0xFFFF0001 response for CRS */
> +	val = dw_pcie_readl_dbi(pci, PORT_LOGIC_AMBA_ERROR_RESPONSE_DEFAULT);
> +	val &= ~(AMBA_ERROR_RESPONSE_CRS_MASK << AMBA_ERROR_RESPONSE_CRS_SHIFT);
> +	val |= (AMBA_ERROR_RESPONSE_CRS_OKAY_FFFF0001 <<
> +		AMBA_ERROR_RESPONSE_CRS_SHIFT);
> +	dw_pcie_writel_dbi(pci, PORT_LOGIC_AMBA_ERROR_RESPONSE_DEFAULT, val);
> +
> +	/* Set MPS to 256 in DEV_CTL */
> +	val = dw_pcie_readl_dbi(pci, CFG_DEV_STATUS_CONTROL);
> +	val &= ~PCI_EXP_DEVCTL_PAYLOAD;
> +	val |= (1 << CFG_DEV_STATUS_CONTROL_MPS_SHIFT);
> +	dw_pcie_writel_dbi(pci, CFG_DEV_STATUS_CONTROL, val);
> +
> +	/* Configure Max Speed from DT */
> +	val = dw_pcie_readl_dbi(pci, CFG_LINK_CAP);
> +	val &= ~PCI_EXP_LNKCAP_SLS;
> +	val |= pcie->max_speed;
> +	dw_pcie_writel_dbi(pci, CFG_LINK_CAP, val);
> +
> +	val = dw_pcie_readw_dbi(pci, CFG_LINK_CONTROL_2);
> +	val &= ~PCI_EXP_LNKCTL2_TLS;
> +	val |= pcie->init_speed;
> +	dw_pcie_writew_dbi(pci, CFG_LINK_CONTROL_2, val);
> +
> +	/* Configure Max lane width from DT */
> +	val = dw_pcie_readl_dbi(pci, CFG_LINK_CAP);
> +	val &= ~PCI_EXP_LNKCAP_MLW;
> +	val |= (pcie->num_lanes << PCI_EXP_LNKSTA_NLW_SHIFT);
> +	dw_pcie_writel_dbi(pci, CFG_LINK_CAP, val);
> +
> +	config_gen3_gen4_eq_presets(pcie);
> +
> +#if defined(CONFIG_PCIEASPM)
> +	/* Enable ASPM counters */
> +	val = EVENT_COUNTER_ENABLE_ALL << EVENT_COUNTER_ENABLE_SHIFT;
> +	val |= EVENT_COUNTER_GROUP_5 << EVENT_COUNTER_GROUP_SEL_SHIFT;
> +	dw_pcie_writel_dbi(pci, pcie->event_cntr_ctrl, val);
> +
> +	/* Program T_cmrt and T_pwr_on values */
> +	val = dw_pcie_readl_dbi(pci, pcie->cfg_link_cap_l1sub);
> +	val &= ~(PCI_L1SS_CAP_CM_RESTORE_TIME | PCI_L1SS_CAP_P_PWR_ON_VALUE);
> +	val |= (pcie->aspm_cmrt << PCI_L1SS_CAP_CM_RTM_SHIFT);
> +	val |= (pcie->aspm_pwr_on_t << PCI_L1SS_CAP_PWRN_VAL_SHIFT);
> +	dw_pcie_writel_dbi(pci, pcie->cfg_link_cap_l1sub, val);
> +
> +	/* Program L0s and L1 entrance latencies */
> +	val = dw_pcie_readl_dbi(pci, PORT_LOGIC_ACK_F_ASPM_CTRL);
> +	val &= ~L0S_ENTRANCE_LAT_MASK;
> +	val |= (pcie->aspm_l0s_enter_lat << L0S_ENTRANCE_LAT_SHIFT);
> +	val |= ENTER_ASPM;
> +	dw_pcie_writel_dbi(pci, PORT_LOGIC_ACK_F_ASPM_CTRL, val);
> +
> +	/* Program what ASPM states sould get advertised */

s/sould/should/

> +	if (pcie->disabled_aspm_states & 0x1)
> +		disable_aspm_l0s(pcie); /* Disable L0s */
> +	if (pcie->disabled_aspm_states & 0x2) {
> +		disable_aspm_l10(pcie); /* Disable L1 */
> +		disable_aspm_l11(pcie); /* Disable L1.1 */
> +		disable_aspm_l12(pcie); /* Disable L1.2 */
> +	}
> +	if (pcie->disabled_aspm_states & 0x4)
> +		disable_aspm_l11(pcie); /* Disable L1.1 */
> +	if (pcie->disabled_aspm_states & 0x8)
> +		disable_aspm_l12(pcie); /* Disable L1.2 */
> +#endif
> +	val = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
> +	val &= ~GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL;
> +	dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, val);
> +
> +	if (pcie->update_fc_fixup) {
> +		val = dw_pcie_readl_dbi(pci, CFG_TIMER_CTRL_MAX_FUNC_NUM_OFF);
> +		val |= 0x1 << CFG_TIMER_CTRL_ACK_NAK_SHIFT;
> +		dw_pcie_writel_dbi(pci, CFG_TIMER_CTRL_MAX_FUNC_NUM_OFF, val);
> +	}
> +
> +	/* CDM check enable */
> +	if (pcie->cdm_check) {
> +		val = dw_pcie_readl_dbi(pci,
> +					PORT_LOGIC_PL_CHK_REG_CONTROL_STATUS);
> +		val |= PORT_LOGIC_PL_CHK_REG_CHK_REG_CONTINUOUS;
> +		val |= PORT_LOGIC_PL_CHK_REG_CHK_REG_START;
> +		dw_pcie_writel_dbi(pci, PORT_LOGIC_PL_CHK_REG_CONTROL_STATUS,
> +				   val);
> +	}
> +
> +	dw_pcie_setup_rc(pp);
> +
> +	clk_set_rate(pcie->core_clk, GEN4_CORE_CLK_FREQ);
> +
> +	/* assert RST */
> +	val = readl(pcie->appl_base + APPL_PINMUX);
> +	val &= ~APPL_PINMUX_PEX_RST;
> +	writel(val, pcie->appl_base + APPL_PINMUX);
> +
> +	usleep_range(100, 200);
> +
> +	/* enable LTSSM */
> +	val = readl(pcie->appl_base + APPL_CTRL);
> +	val |= APPL_CTRL_LTSSM_EN;
> +	writel(val, pcie->appl_base + APPL_CTRL);
> +
> +	/* de-assert RST */
> +	val = readl(pcie->appl_base + APPL_PINMUX);
> +	val |= APPL_PINMUX_PEX_RST;
> +	writel(val, pcie->appl_base + APPL_PINMUX);
> +
> +	msleep(100);
> +
> +	val_w = dw_pcie_readw_dbi(pci, CFG_LINK_STATUS);
> +	while (!(val_w & PCI_EXP_LNKSTA_DLLLA)) {
> +		if (!count) {
> +			val = readl(pcie->appl_base + APPL_DEBUG);
> +			val &= APPL_DEBUG_LTSSM_STATE_MASK;
> +			val >>= APPL_DEBUG_LTSSM_STATE_SHIFT;
> +			tmp = readl(pcie->appl_base + APPL_LINK_STATUS);
> +			tmp &= APPL_LINK_STATUS_RDLH_LINK_UP;
> +			if (val == 0x11 && !tmp) {
> +				dev_info(pci->dev, "link is down in DLL");
> +				dev_info(pci->dev,
> +					 "trying again with DLFE disabled\n");
> +				/* disable LTSSM */
> +				val = readl(pcie->appl_base + APPL_CTRL);
> +				val &= ~APPL_CTRL_LTSSM_EN;
> +				writel(val, pcie->appl_base + APPL_CTRL);
> +
> +				reset_control_assert(pcie->core_rst);
> +				reset_control_deassert(pcie->core_rst);
> +
> +				offset =
> +				dw_pcie_find_ext_capability(pci,
> +							    PCI_EXT_CAP_ID_DLF)
> +				+ PCI_DLF_CAP;

This capability offset doesn't change, does it?  Could it be computed
outside the loop?

> +				val = dw_pcie_readl_dbi(pci, offset);
> +				val &= ~DL_FEATURE_EXCHANGE_EN;
> +				dw_pcie_writel_dbi(pci, offset, val);
> +
> +				tegra_pcie_dw_host_init(&pcie->pci.pp);

This looks like some sort of "wait for link up" retry loop, but a
recursive call seems a little unusual.  My 5 second analysis is that
the loop could run this 200 times, and you sure don't want the
possibility of a 200-deep call chain.  Is there way to split out the
host init from the link-up polling?

> +				return 0;
> +			}
> +			dev_info(pci->dev, "link is down\n");
> +			return 0;
> +		}
> +		dev_dbg(pci->dev, "polling for link up\n");
> +		usleep_range(1000, 2000);
> +		val_w = dw_pcie_readw_dbi(pci, CFG_LINK_STATUS);
> +		count--;
> +	}
> +	dev_info(pci->dev, "link is up\n");
> +
> +	tegra_pcie_enable_interrupts(pp);
> +
> +	return 0;
> +}

> +static void tegra_pcie_dw_scan_bus(struct pcie_port *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct tegra_pcie_dw *pcie = dw_pcie_to_tegra_pcie(pci);
> +	u32 speed;
> +
> +	if (!tegra_pcie_dw_link_up(pci))
> +		return;
> +
> +	speed = (dw_pcie_readw_dbi(pci, CFG_LINK_STATUS) & PCI_EXP_LNKSTA_CLS);
> +	clk_set_rate(pcie->core_clk, pcie_gen_freq[speed - 1]);

I don't understand what's happening here.  This is named
tegra_pcie_dw_scan_bus(), but it doesn't actually scan anything.
Maybe it's just a bad name for the dw_pcie_host_ops hook
(ks_pcie_v3_65_scan_bus() is the only other .scan_bus()
implementation, and it doesn't scan anything either).

dw_pcie_host_init() calls pci_scan_root_bus_bridge(), which actually
*does* scan the bus, but it does it before calling
pp->ops->scan_bus().  I'd say by the time we get to
pci_scan_root_bus_bridge(), the device-specific init should be all
done and we should be using only generic PCI core interfaces.

Maybe this stuff could/should be done in the ->host_init() hook?  The
code between ->host_init() and ->scan_bus() is all generic code with
no device-specific stuff, so I don't know why we need both hooks.

> +static int tegra_pcie_enable_phy(struct tegra_pcie_dw *pcie)
> +{
> +	int phy_count = pcie->phy_count;
> +	int ret;
> +	int i;
> +
> +	for (i = 0; i < phy_count; i++) {
> +		ret = phy_init(pcie->phy[i]);
> +		if (ret < 0)
> +			goto err_phy_init;
> +
> +		ret = phy_power_on(pcie->phy[i]);
> +		if (ret < 0) {
> +			phy_exit(pcie->phy[i]);
> +			goto err_phy_power_on;
> +		}
> +	}
> +
> +	return 0;
> +
> +	while (i >= 0) {
> +		phy_power_off(pcie->phy[i]);
> +err_phy_power_on:
> +		phy_exit(pcie->phy[i]);
> +err_phy_init:
> +		i--;
> +	}

Wow, jumping into the middle of that loop is clever ;)  Can't decide
what I think of it, but it's certainly clever!

> +	return ret;
> +}
> +
> +static int tegra_pcie_dw_parse_dt(struct tegra_pcie_dw *pcie)
> +{
> +	struct device_node *np = pcie->dev->of_node;
> +	int ret;
> +
> +#if defined(CONFIG_PCIEASPM)
> +	ret = of_property_read_u32(np, "nvidia,event-cntr-ctrl",
> +				   &pcie->event_cntr_ctrl);
> +	if (ret < 0) {
> +		dev_err(pcie->dev, "fail to read event-cntr-ctrl: %d\n", ret);
> +		return ret;
> +	}

The fact that you return error here if DT lacks the
"nvidia,event-cntr-ctrl" property, but only if CONFIG_PCIEASPM=y,
means that you have a revlock between the DT and the kernel: if you
update the kernel to enable CONFIG_PCIEASPM, you may also have to
update your DT.

Maybe that's OK, but I think it'd be nicer if you always required the
presence of these properties, even if you only actually *use* them
when CONFIG_PCIEASPM=y.

> +static int tegra_pcie_dw_probe(struct platform_device *pdev)
> +{
> +	struct tegra_pcie_dw *pcie;
> +	struct pcie_port *pp;
> +	struct dw_pcie *pci;
> +	struct phy **phy;
> +	struct resource	*dbi_res;
> +	struct resource	*atu_dma_res;
> +	const struct of_device_id *match;
> +	const struct tegra_pcie_of_data *data;
> +	char *name;
> +	int ret, i;
> +
> +	pcie = devm_kzalloc(&pdev->dev, sizeof(*pcie), GFP_KERNEL);
> +	if (!pcie)
> +		return -ENOMEM;
> +
> +	pci = &pcie->pci;
> +	pci->dev = &pdev->dev;
> +	pci->ops = &tegra_dw_pcie_ops;
> +	pp = &pci->pp;
> +	pcie->dev = &pdev->dev;
> +
> +	match = of_match_device(of_match_ptr(tegra_pcie_dw_of_match),
> +				&pdev->dev);
> +	if (!match)
> +		return -EINVAL;

Logically could be the first thing in the function since it doesn't
depend on anything.

> +	data = (struct tegra_pcie_of_data *)match->data;
> +	pcie->mode = (enum dw_pcie_device_mode)data->mode;
> +
> +	ret = tegra_pcie_dw_parse_dt(pcie);
> +	if (ret < 0) {
> +		dev_err(pcie->dev, "device tree parsing failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	if (gpio_is_valid(pcie->pex_wake)) {
> +		ret = devm_gpio_request(pcie->dev, pcie->pex_wake,
> +					"pcie_wake");
> +		if (ret < 0) {
> +			if (ret == -EBUSY) {
> +				dev_err(pcie->dev,
> +					"pex_wake already in use\n");
> +				pcie->pex_wake = -EINVAL;

This looks strange.  "pex_wake == -EINVAL" doesn't look right, and
you're about to pass it to gpio_direction_input(), which looks wrong.

> +			} else {
> +				dev_err(pcie->dev,
> +					"pcie_wake gpio_request failed %d\n",
> +					ret);
> +				return ret;
> +			}
> +		}
> +
> +		ret = gpio_direction_input(pcie->pex_wake);
> +		if (ret < 0) {
> +			dev_err(pcie->dev,
> +				"setting pcie_wake input direction failed %d\n",
> +				ret);
> +			return ret;
> +		}
> +		device_init_wakeup(pcie->dev, true);
> +	}
> +
> +	pcie->pex_ctl_reg = devm_regulator_get(&pdev->dev, "vddio-pex-ctl");
> +	if (IS_ERR(pcie->pex_ctl_reg)) {
> +		dev_err(&pdev->dev, "fail to get regulator: %ld\n",
> +			PTR_ERR(pcie->pex_ctl_reg));
> +		return PTR_ERR(pcie->pex_ctl_reg);
> +	}
> +
> +	pcie->core_clk = devm_clk_get(&pdev->dev, "core_clk");
> +	if (IS_ERR(pcie->core_clk)) {
> +		dev_err(&pdev->dev, "Failed to get core clock\n");
> +		return PTR_ERR(pcie->core_clk);
> +	}
> +
> +	pcie->appl_res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> +						      "appl");
> +	if (!pcie->appl_res) {
> +		dev_err(&pdev->dev, "missing appl space\n");
> +		return PTR_ERR(pcie->appl_res);
> +	}
> +	pcie->appl_base = devm_ioremap_resource(&pdev->dev, pcie->appl_res);
> +	if (IS_ERR(pcie->appl_base)) {
> +		dev_err(&pdev->dev, "mapping appl space failed\n");
> +		return PTR_ERR(pcie->appl_base);
> +	}
> +
> +	pcie->core_apb_rst = devm_reset_control_get(pcie->dev, "core_apb_rst");
> +	if (IS_ERR(pcie->core_apb_rst)) {
> +		dev_err(pcie->dev, "PCIE : core_apb_rst reset is missing\n");

This error message looks different from the others ("PCIE :" prefix).

> +		return PTR_ERR(pcie->core_apb_rst);
> +	}
> +
> +	phy = devm_kcalloc(pcie->dev, pcie->phy_count, sizeof(*phy),
> +			   GFP_KERNEL);
> +	if (!phy)
> +		return PTR_ERR(phy);
> +
> +	for (i = 0; i < pcie->phy_count; i++) {
> +		name = kasprintf(GFP_KERNEL, "pcie-p2u-%u", i);
> +		if (!name) {
> +			dev_err(pcie->dev, "failed to create p2u string\n");
> +			return -ENOMEM;
> +		}
> +		phy[i] = devm_phy_get(pcie->dev, name);
> +		kfree(name);
> +		if (IS_ERR(phy[i])) {
> +			ret = PTR_ERR(phy[i]);
> +			dev_err(pcie->dev, "phy_get error: %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	pcie->phy = phy;
> +
> +	dbi_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
> +	if (!dbi_res) {
> +		dev_err(&pdev->dev, "missing config space\n");
> +		return PTR_ERR(dbi_res);
> +	}
> +	pcie->dbi_res = dbi_res;
> +
> +	pci->dbi_base = devm_ioremap_resource(&pdev->dev, dbi_res);
> +	if (IS_ERR(pci->dbi_base)) {
> +		dev_err(&pdev->dev, "mapping dbi space failed\n");
> +		return PTR_ERR(pci->dbi_base);
> +	}
> +
> +	/* Tegra HW locates DBI2 at a fixed offset from DBI */
> +	pci->dbi_base2 = pci->dbi_base + 0x1000;
> +
> +	atu_dma_res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> +						   "atu_dma");
> +	if (!atu_dma_res) {
> +		dev_err(&pdev->dev, "missing atu_dma space\n");
> +		return PTR_ERR(atu_dma_res);
> +	}
> +	pcie->atu_dma_res = atu_dma_res;
> +	pci->atu_base = devm_ioremap_resource(&pdev->dev, atu_dma_res);
> +	if (IS_ERR(pci->atu_base)) {
> +		dev_err(&pdev->dev, "mapping atu space failed\n");
> +		return PTR_ERR(pci->atu_base);
> +	}
> +
> +	pcie->core_rst = devm_reset_control_get(pcie->dev, "core_rst");
> +	if (IS_ERR(pcie->core_rst)) {
> +		dev_err(pcie->dev, "PCIE : core_rst reset is missing\n");

Different message format again.

> +		return PTR_ERR(pcie->core_rst);
> +	}
> +
> +	pp->irq = platform_get_irq_byname(pdev, "intr");
> +	if (!pp->irq) {
> +		dev_err(pcie->dev, "failed to get intr interrupt\n");
> +		return -ENODEV;
> +	}
> +
> +	ret = devm_request_irq(&pdev->dev, pp->irq, tegra_pcie_irq_handler,
> +			       IRQF_SHARED, "tegra-pcie-intr", pcie);
> +	if (ret) {
> +		dev_err(pcie->dev, "failed to request \"intr\" irq\n");

It'd be nice to include the actual IRQ, i.e., "IRQ %d", pp->irq.

> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, pcie);
> +
> +	if (pcie->mode == DW_PCIE_RC_TYPE) {
> +		ret = tegra_pcie_config_rp(pcie);
> +		if (ret == -ENOMEDIUM)
> +			ret = 0;
> +	}
> +
> +	return ret;
> +}

> +static void tegra_pcie_downstream_dev_to_D0(struct tegra_pcie_dw *pcie)
> +{
> +	struct pci_dev *pdev = NULL;

Unnecessary initialization.

> +	struct pci_bus *child;
> +	struct pcie_port *pp = &pcie->pci.pp;
> +
> +	list_for_each_entry(child, &pp->bus->children, node) {
> +		/* Bring downstream devices to D0 if they are not already in */
> +		if (child->parent == pp->bus) {
> +			pdev = pci_get_slot(child, PCI_DEVFN(0, 0));
> +			pci_dev_put(pdev);
> +			if (!pdev)
> +				break;

I don't really like this dance with iterating over the bus children,
comparing parent to pp->bus, pci_get_slot(), pci_dev_put(), etc.

I guess the idea is to bring only the directly-downstream devices to
D0, not to do it for things deeper in the hierarchy?

Is this some Tegra-specific wrinkle?  I don't think other drivers do
this.

I see that an earlier patch added "bus" to struct pcie_port.  I think
it would be better to somehow connect to the pci_host_bridge struct.
Several other drivers already do this; see uses of
pci_host_bridge_from_priv().

That would give you the bus, as well as flags like no_ext_tags,
native_aer, etc, which this driver, being a host bridge driver that's
responsible for this part of the firmware/OS interface, may
conceivably need.

Rather than pci_get_slot(), couldn't you iterate over bus->devices and
just skip the non-PCI_DEVFN(0, 0) devices?

> +
> +			if (pci_set_power_state(pdev, PCI_D0))
> +				dev_err(pcie->dev, "D0 transition failed\n");
> +		}
> +	}
> +}

> +static int tegra_pcie_dw_remove(struct platform_device *pdev)
> +{
> +	struct tegra_pcie_dw *pcie = platform_get_drvdata(pdev);
> +
> +	if (pcie->mode == DW_PCIE_RC_TYPE) {

Return early if it's not RC and unindent the rest of the function.

> +		if (!pcie->link_state && pcie->power_down_en)
> +			return 0;
> +
> +		debugfs_remove_recursive(pcie->debugfs);
> +		pm_runtime_put_sync(pcie->dev);
> +		pm_runtime_disable(pcie->dev);
> +	}
> +
> +	return 0;
> +}

> +static int tegra_pcie_dw_runtime_suspend(struct device *dev)
> +{
> +	struct tegra_pcie_dw *pcie = dev_get_drvdata(dev);
> +
> +	tegra_pcie_downstream_dev_to_D0(pcie);
> +
> +	pci_stop_root_bus(pcie->pci.pp.bus);
> +	pci_remove_root_bus(pcie->pci.pp.bus);

Why are you calling these?  No other drivers do this except in their
.remove() methods.  Is there something special about Tegra, or is this
something the other drivers *should* be doing?

> +	tegra_pcie_dw_pme_turnoff(pcie);
> +
> +	reset_control_assert(pcie->core_rst);
> +	tegra_pcie_disable_phy(pcie);
> +	reset_control_assert(pcie->core_apb_rst);
> +	clk_disable_unprepare(pcie->core_clk);
> +	regulator_disable(pcie->pex_ctl_reg);
> +	config_plat_gpio(pcie, 0);
> +
> +	if (pcie->cid != CTRL_5)
> +		tegra_pcie_bpmp_set_ctrl_state(pcie, false);
> +
> +	return 0;
> +}
> +
> +static int tegra_pcie_dw_runtime_resume(struct device *dev)
> +{
> +	struct tegra_pcie_dw *pcie = dev_get_drvdata(dev);
> +	struct dw_pcie *pci = &pcie->pci;
> +	struct pcie_port *pp = &pci->pp;
> +	int ret = 0;
> +
> +	ret = tegra_pcie_config_controller(pcie, false);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* program to use MPS of 256 whereever possible */

s/whereever/wherever/

> +	pcie_bus_config = PCIE_BUS_SAFE;
> +
> +	pp->root_bus_nr = -1;
> +	pp->ops = &tegra_pcie_dw_host_ops;
> +
> +	/* Disable MSI interrupts for PME messages */

Superfluous comment; it repeats the function name.

> +static int tegra_pcie_dw_suspend_noirq(struct device *dev)
> +{
> +	struct tegra_pcie_dw *pcie = dev_get_drvdata(dev);
> +	int ret = 0;
> +
> +	if (!pcie->link_state)
> +		return 0;
> +
> +	/* save MSI interrutp vector*/

s/interrutp/interrupt/
s/vector/vector /

> +static int tegra_pcie_dw_resume_noirq(struct device *dev)
> +{
> +	struct tegra_pcie_dw *pcie = dev_get_drvdata(dev);
> +	int ret;
> +
> +	if (!pcie->link_state)
> +		return 0;
> +
> +	if (gpio_is_valid(pcie->pex_wake) && device_may_wakeup(dev)) {
> +		ret = disable_irq_wake(gpio_to_irq(pcie->pex_wake));
> +		if (ret < 0)
> +			dev_err(dev, "disable wake irq failed: %d\n", ret);
> +	}
> +
> +	ret = tegra_pcie_config_controller(pcie, true);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = tegra_pcie_dw_host_init(&pcie->pci.pp);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to init host: %d\n", ret);
> +		goto fail_host_init;
> +	}
> +
> +	/* restore MSI interrutp vector*/

s/interrutp/interrupt/
s/vector/vector /

> +static void tegra_pcie_dw_shutdown(struct platform_device *pdev)
> +{
> +	struct tegra_pcie_dw *pcie = platform_get_drvdata(pdev);
> +
> +	if (pcie->mode == DW_PCIE_RC_TYPE) {

  if (pcie->mode != DW_PCIE_RC_TYPE)
    return;

Then you can unindent the whole function.

> +		if (!pcie->link_state && pcie->power_down_en)
> +			return;
> +
> +		debugfs_remove_recursive(pcie->debugfs);
> +		tegra_pcie_downstream_dev_to_D0(pcie);
> +
> +		/* Disable interrupts */

Superfluous comment.

> +		disable_irq(pcie->pci.pp.irq);
