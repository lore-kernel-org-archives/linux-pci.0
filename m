Return-Path: <SRS0=SeHV=OM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425CFC07E85
	for <linux-pci@archiver.kernel.org>; Mon,  3 Dec 2018 16:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 120DD2145D
	for <linux-pci@archiver.kernel.org>; Mon,  3 Dec 2018 16:42:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 120DD2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbeLCQmD (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 3 Dec 2018 11:42:03 -0500
Received: from foss.arm.com ([217.140.101.70]:41584 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726662AbeLCQmD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 3 Dec 2018 11:42:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A8EB31682;
        Mon,  3 Dec 2018 08:41:58 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6ED583F59C;
        Mon,  3 Dec 2018 08:41:55 -0800 (PST)
Date:   Mon, 3 Dec 2018 16:41:50 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Hanjie Lin <hanjie.lin@amlogic.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Yue Wang <yue.wang@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        Yixun Lan <yixun.lan@amlogic.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>
Subject: Re: [PATCH v6 2/2] PCI: amlogic: Add the Amlogic Meson PCIe
 controller driver
Message-ID: <20181203164150.GA11855@e107981-ln.cambridge.arm.com>
References: <1542876836-191355-1-git-send-email-hanjie.lin@amlogic.com>
 <1542876836-191355-3-git-send-email-hanjie.lin@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542876836-191355-3-git-send-email-hanjie.lin@amlogic.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 22, 2018 at 04:53:54PM +0800, Hanjie Lin wrote:

[...]

> +static int meson_pcie_rd_own_conf(struct pcie_port *pp, int where, int size,
> +				  u32 *val)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +
> +	/*
> +	 * there is a bug of MESON AXG pcie controller that software can not
> +	 * programe PCI_CLASS_DEVICE register, so we must return a fake right
> +	 * value to ensure driver could probe successfully.
> +	 */
> +	if (where == PCI_CLASS_REVISION) {
> +		*val = readl(pci->dbi_base + PCI_CLASS_REVISION);
> +		/* keep revision id */
> +		*val &= PCI_CLASS_REVISION_MASK;
> +		*val |= PCI_CLASS_BRIDGE_PCI << 16;
> +		return PCIBIOS_SUCCESSFUL;
> +	}

As I said before, this looks broken. If this code (or other drivers with
the same broken assumptions, eg dwc/pcie-qcom.c) carries out a, say,
byte sized config access of eg PCI_CLASS_DEVICE you will get junk out of
it according to your comment above.

I would like to pick Bjorn's brain on this to see what we can really do
to fix this (and other) drivers.

Thanks,
Lorenzo

> +	return dw_pcie_read(pci->dbi_base + where, size, val);
> +}
> +
> +static int meson_pcie_wr_own_conf(struct pcie_port *pp, int where,
> +				  int size, u32 val)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +
> +	return dw_pcie_write(pci->dbi_base + where, size, val);
> +}
> +
> +static int meson_pcie_link_up(struct dw_pcie *pci)
> +{
> +	struct meson_pcie *mp = to_meson_pcie(pci);
> +	struct device *dev = pci->dev;
> +	u32 smlh_up = 0;
> +	u32 ltssm_up = 0;
> +	u32 rdlh_up = 0;
> +	u32 speed_okay = 0;
> +	u32 cnt = 0;
> +	u32 state12, state17;
> +
> +	while (smlh_up == 0 || rdlh_up == 0 || ltssm_up == 0 ||
> +	       speed_okay == 0) {
> +		udelay(20);
> +
> +		state12 = meson_cfg_readl(mp, PCIE_CFG_STATUS12);
> +		state17 = meson_cfg_readl(mp, PCIE_CFG_STATUS17);
> +		smlh_up = IS_SMLH_LINK_UP(state12);
> +		rdlh_up = IS_RDLH_LINK_UP(state12);
> +		ltssm_up = IS_LTSSM_UP(state12);
> +
> +		if (PM_CURRENT_STATE(state17) < PCIE_GEN3)
> +			speed_okay = 1;
> +
> +		if (smlh_up)
> +			dev_dbg(dev, "smlh_link_up is on\n");
> +		if (rdlh_up)
> +			dev_dbg(dev, "rdlh_link_up is on\n");
> +		if (ltssm_up)
> +			dev_dbg(dev, "ltssm_up is on\n");
> +		if (speed_okay)
> +			dev_dbg(dev, "speed_okay\n");
> +
> +		cnt++;
> +
> +		if (cnt >= WAIT_LINKUP_TIMEOUT) {
> +			dev_err(dev, "Error: Wait linkup timeout.\n");
> +			return 0;
> +		}
> +	}
> +
> +	return 1;
> +}
> +
> +static int meson_pcie_host_init(struct pcie_port *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct meson_pcie *mp = to_meson_pcie(pci);
> +	int ret;
> +
> +	ret = meson_pcie_establish_link(mp);
> +	if (ret)
> +		return ret;
> +
> +	meson_pcie_enable_interrupts(mp);
> +
> +	return 0;
> +}
> +
> +static const struct dw_pcie_host_ops meson_pcie_host_ops = {
> +	.rd_own_conf = meson_pcie_rd_own_conf,
> +	.wr_own_conf = meson_pcie_wr_own_conf,
> +	.host_init = meson_pcie_host_init,
> +};
> +
> +static int meson_add_pcie_port(struct meson_pcie *mp,
> +			       struct platform_device *pdev)
> +{
> +	struct dw_pcie *pci = &mp->pci;
> +	struct pcie_port *pp = &pci->pp;
> +	struct device *dev = &pdev->dev;
> +	int ret;
> +
> +	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> +		pp->msi_irq = platform_get_irq(pdev, 0);
> +		if (pp->msi_irq < 0) {
> +			dev_err(dev, "failed to get msi irq\n");
> +			return pp->msi_irq;
> +		}
> +	}
> +
> +	pp->ops = &meson_pcie_host_ops;
> +	pci->dbi_base = mp->mem_res.elbi_base;
> +
> +	ret = dw_pcie_host_init(pp);
> +	if (ret) {
> +		dev_err(dev, "failed to initialize host\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct dw_pcie_ops dw_pcie_ops = {
> +	.link_up = meson_pcie_link_up,
> +};
> +
> +static int meson_pcie_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct dw_pcie *pci;
> +	struct meson_pcie *mp;
> +	int ret;
> +
> +	mp = devm_kzalloc(dev, sizeof(*mp), GFP_KERNEL);
> +	if (!mp)
> +		return -ENOMEM;
> +
> +	pci = &mp->pci;
> +	pci->dev = dev;
> +	pci->ops = &dw_pcie_ops;
> +
> +	mp->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
> +	if (IS_ERR(mp->reset_gpio)) {
> +		dev_err(dev, "Get reset gpio failed\n");
> +		return PTR_ERR(mp->reset_gpio);
> +	}
> +
> +	ret = meson_pcie_get_resets(mp);
> +	if (ret) {
> +		dev_err(dev, "Get reset resource failed, %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = meson_pcie_get_mems(pdev, mp);
> +	if (ret) {
> +		dev_err(dev, "Get memory resource failed, %d\n", ret);
> +		return ret;
> +	}
> +
> +	meson_pcie_power_on(mp);
> +	meson_pcie_reset(mp);
> +
> +	ret = meson_pcie_probe_clocks(mp);
> +	if (ret) {
> +		dev_err(dev, "Init clock resources failed, %d\n", ret);
> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, mp);
> +
> +	ret = meson_add_pcie_port(mp, pdev);
> +	if (ret < 0) {
> +		dev_err(dev, "Add PCIE port failed, %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id meson_pcie_of_match[] = {
> +	{
> +		.compatible = "amlogic,axg-pcie",
> +	},
> +	{},
> +};
> +
> +static struct platform_driver meson_pcie_driver = {
> +	.probe = meson_pcie_probe,
> +	.driver = {
> +		.name = "meson-pcie",
> +		.of_match_table = meson_pcie_of_match,
> +	},
> +};
> +
> +builtin_platform_driver(meson_pcie_driver);
> -- 
> 2.7.4
> 
