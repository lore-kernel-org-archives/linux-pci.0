Return-Path: <SRS0=EJXn=O3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2808DC43387
	for <linux-pci@archiver.kernel.org>; Tue, 18 Dec 2018 22:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB98A218A2
	for <linux-pci@archiver.kernel.org>; Tue, 18 Dec 2018 22:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545173233;
	bh=cnK5XvLVRJ49GBJdmk7hCbJ8Up1l19H1A9AWUVBiAus=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KU9hZFbyxIycnxwJ0zfy/RctoUBWpaFwE32QhEDgQTBE6zSaucGMFWSiLFDBxAzrC
	 +cwFhNWMQ/rkUDV8VJAzZcTC2jonelzbFR619+uJHojjgf4PBYwW7N3oSiXr7gdwOH
	 6PCwVjV3a1OpKw3nDfhK9MMCYdYwzPfruS6kJq6o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbeLRWrM (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 18 Dec 2018 17:47:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:48764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727412AbeLRWrL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 18 Dec 2018 17:47:11 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1894221871;
        Tue, 18 Dec 2018 22:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545173230;
        bh=cnK5XvLVRJ49GBJdmk7hCbJ8Up1l19H1A9AWUVBiAus=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Awod3BNW073KN9DVtn3VhAkdFK+WH3vOTctETw/JfwkJwGZHl0RHyuR0Cjuo2tE/6
         1YBGfxDYGlVweug7AQGTYUl1MoAt97mRz+zaLmo7f3+yhhAy60hDXY/oaGpAy6xvUm
         EA1QJ8u+HjHA73K6yjpWDIepyjDKVHOhM9GaRpSI=
Date:   Tue, 18 Dec 2018 16:47:08 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Hanjie Lin <hanjie.lin@amlogic.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Yue Wang <yue.wang@amlogic.com>,
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
Subject: Re: [PATCH v8 2/2] PCI: amlogic: Add the Amlogic Meson PCIe
 controller driver
Message-ID: <20181218224708.GB22610@google.com>
References: <1545120286-129258-1-git-send-email-hanjie.lin@amlogic.com>
 <1545120286-129258-3-git-send-email-hanjie.lin@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545120286-129258-3-git-send-email-hanjie.lin@amlogic.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 18, 2018 at 04:04:46PM +0800, Hanjie Lin wrote:
> From: Yue Wang <yue.wang@amlogic.com>
> 
> The Amlogic Meson PCIe host controller is based on the Synopsys DesignWare
> PCI core. This patch adds the driver support for Meson PCIe controller.

I don't have any comments on the code itself; just the trivial things
below.  No need to repost for these unless you're changing something
else.

I thought it looked very pretty overall, thanks for paying attention
to that!

> +static int meson_size_to_payload(struct meson_pcie *mp, int size)
> +{
> +	struct device *dev = mp->pci.dev;
> +
> +	/*
> +	 * dwc supports 2^(val+7) payload size, which val is 0~5 default to 1.
> +	 * So if input size is not 2^order alignment or less than 2^7 or bigger
> +	 * than 2^12, just set to default size 2^(1+7).
> +	 */
> +	if (!is_power_of_2(size) || size < 128 || size > 4096) {
> +		dev_warn(dev, "playload size %d, set to default 256\n", size);

s/playload/payload/

> +static void meson_set_max_payload(struct meson_pcie *mp, int size)
> +{
> +	u32 val = 0;

Unnecessary initialization.

> +	int max_payload_size = meson_size_to_payload(mp, size);
> +
> +	val = meson_elb_readl(mp, PCIE_DEV_CTRL_DEV_STUS);

> +static int meson_pcie_rd_own_conf(struct pcie_port *pp, int where, int size,
> +				  u32 *val)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	int ret;
> +
> +	ret = dw_pcie_read(pci->dbi_base + where, size, val);
> +	if (ret != PCIBIOS_SUCCESSFUL)
> +		return ret;
> +
> +	/*
> +	 * There is a bug in the MESON AXG pcie controller whereby software
> +	 * cannot programme the PCI_CLASS_DEVICE register, so we must fabricate
> +	 * the return value in the config accessors.

s/pcie/PCIe/
s/programme/program/ (IIUC, "programme" is British and only used as a
noun, where here you need a verb)

> +static int meson_pcie_link_up(struct dw_pcie *pci)
> +{
> +	struct meson_pcie *mp = to_meson_pcie(pci);
> +	struct device *dev = pci->dev;
> +	u32 smlh_up = 0;
> +	u32 ltssm_up = 0;
> +	u32 rdlh_up = 0;

Unnecessary initialization of smlh_up, ltssm_up, and rdlh_up.

> +	u32 speed_okay = 0;
> +	u32 cnt = 0;
> +	u32 state12, state17;
> +
> +	do {
> +		state12 = meson_cfg_readl(mp, PCIE_CFG_STATUS12);
> +		state17 = meson_cfg_readl(mp, PCIE_CFG_STATUS17);
> +		smlh_up = IS_SMLH_LINK_UP(state12);
> +		rdlh_up = IS_RDLH_LINK_UP(state12);
> +		ltssm_up = IS_LTSSM_UP(state12);

> +	dev_err(dev, "Error: Wait linkup timeout.\n");

Message doesn't match others from driver (capitalization and trailing
period).

> +			dev_err(dev, "failed to get msi irq\n");

s/msi irq/MSI IRQ/

> +	ret = meson_add_pcie_port(mp, pdev);
> +	if (ret < 0) {
> +		dev_err(dev, "Add PCIE port failed, %d\n", ret);

s/PCIE/PCIe/

All the messages in this function are capitalized differently than
other messages in the driver.

Bjorn
