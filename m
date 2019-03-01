Return-Path: <SRS0=yUVM=RE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53985C43381
	for <linux-pci@archiver.kernel.org>; Fri,  1 Mar 2019 14:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2079A20850
	for <linux-pci@archiver.kernel.org>; Fri,  1 Mar 2019 14:15:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387475AbfCAOPo (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 1 Mar 2019 09:15:44 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36578 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728443AbfCAOPo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 Mar 2019 09:15:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2BB07A78;
        Fri,  1 Mar 2019 06:15:43 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC2E33F720;
        Fri,  1 Mar 2019 06:15:41 -0800 (PST)
Date:   Fri, 1 Mar 2019 14:15:24 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Ley Foon Tan <ley.foon.tan@intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        lftan.linux@gmail.com
Subject: Re: [PATCH v6 1/3] PCI: altera: Add Stratix 10 PCIe support
Message-ID: <20190301141516.GA4783@e107981-ln.cambridge.arm.com>
References: <1551351172-25424-1-git-send-email-ley.foon.tan@intel.com>
 <1551351172-25424-2-git-send-email-ley.foon.tan@intel.com>
 <20190228105612.GA31404@red-moon>
 <1551401448.24631.15.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551401448.24631.15.camel@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 01, 2019 at 08:50:48AM +0800, Ley Foon Tan wrote:
> On Thu, 2019-02-28 at 10:56 +0000, Lorenzo Pieralisi wrote:
> > On Thu, Feb 28, 2019 at 06:52:50PM +0800, Ley Foon Tan wrote:
> > 
> > [...]
> > 
> > > 
> > > +static int s10_tlp_read_packet(struct altera_pcie *pcie, u32
> > > *value)
> > > +{
> > > +	int i;
> > > +	u32 ctrl;
> > > +	u32 comp_status;
> > > +	u32 dw[4];
> > > +	u32 count;
> > > +
> > > +	for (i = 0; i < TLP_LOOP; i++) {
> > > +		ctrl = cra_readl(pcie, S10_RP_RXCPL_STATUS);
> > > +		if (!(ctrl & RP_RXCPL_SOP)) {
> > > +			udelay(5);
> > > +			continue;
> > > +		}
> > > +
> > > +		/* Read first DW */
> > > +		dw[0] = cra_readl(pcie, S10_RP_RXCPL_REG);
> > > +		count = 1;
> > > +
> > > +		/* Poll for EOP */
> > > +		for (i = 0; i < TLP_LOOP && count <
> > > ARRAY_SIZE(dw); i++) {
> > > +			ctrl = cra_readl(pcie,
> > > S10_RP_RXCPL_STATUS);
> > > +			dw[count++] = cra_reeadl(pcie,
> > > S10_RP_RXCPL_REG);
> > > +			if (ctrl & RP_RXCPL_EOP) {
> > > +				comp_status =
> > > TLP_COMP_STATUS(dw[1]);
> > > +				if (comp_status)
> > > +					return
> > > PCIBIOS_DEVICE_NOT_FOUND;
> > > +
> > > +				if (value &&
> > > +				????????TLP_BYTE_COUNT(dw[1]) ==
> > > sizeof(u32) &&
> > > +				????????count == 4)
> > > +					*value = dw[3];
> > > +
> > > +				return PCIBIOS_SUCCESSFUL;
> > > +			}
> > Two more things.
> > 
> > - Why don't you need a udelay() in the inner loop ?
> It has received start of packet (SOP) when in the inner loop, next DW
> will come on next. So, I don't add udelay here.
> > - I think that count >= ARRAY_SIZE(dw) in the inner loop is an error
> > ?? condition and it should be flagged up with a warning before
> > exiting.
> Yes, please add this.
> > 
> > I can make these changes if you let me know your thoughts on this.
> Please go ahead and change this.

I rewrote the loop.

Please have a look at my branch not-to-merge/pci-altera, if that's
OK and it passes the kbot tests I will try to get it upstream.

Lorenzo

> Thanks.
> 
> Regards
> Ley Foon
> > 
> > Lorenzo
> > 
> > > 
> > > +		}
> > > +	}
> > > +
> > > +	return PCIBIOS_DEVICE_NOT_FOUND;
> > > +}
> > > +
> > > ??static void tlp_write_packet(struct altera_pcie *pcie, u32
> > > *headers,
> > > ??			??????????u32 data, bool align)
> > > ??{
> > > @@ -210,6 +306,15 @@ static void tlp_write_packet(struct
> > > altera_pcie *pcie, u32 *headers,
> > > ??	tlp_write_tx(pcie, &tlp_rp_regdata);
> > > ??}
> > > ??
> > > +static void s10_tlp_write_packet(struct altera_pcie *pcie, u32
> > > *headers,
> > > +				??u32 data, bool dummy)
> > > +{
> > > +	s10_tlp_write_tx(pcie, headers[0], RP_TX_SOP);
> > > +	s10_tlp_write_tx(pcie, headers[1], 0);
> > > +	s10_tlp_write_tx(pcie, headers[2], 0);
> > > +	s10_tlp_write_tx(pcie, data, RP_TX_EOP);
> > > +}
> > > +
> > > ??static int tlp_cfg_dword_read(struct altera_pcie *pcie, u8 bus,
> > > u32 devfn,
> > > ??			????????????int where, u8 byte_en, u32 *value)
> > > ??{
> > > @@ -219,9 +324,9 @@ static int tlp_cfg_dword_read(struct
> > > altera_pcie *pcie, u8 bus, u32 devfn,
> > > ??	headers[1] = TLP_CFG_DW1(pcie, TLP_READ_TAG, byte_en);
> > > ??	headers[2] = TLP_CFG_DW2(bus, devfn, where);
> > > ??
> > > -	tlp_write_packet(pcie, headers, 0, false);
> > > +	pcie->pcie_data->ops->tlp_write_pkt(pcie, headers, 0,
> > > false);
> > > ??
> > > -	return tlp_read_packet(pcie, value);
> > > +	return pcie->pcie_data->ops->tlp_read_pkt(pcie, value);
> > > ??}
> > > ??
> > > ??static int tlp_cfg_dword_write(struct altera_pcie *pcie, u8 bus,
> > > u32 devfn,
> > > @@ -236,11 +341,13 @@ static int tlp_cfg_dword_write(struct
> > > altera_pcie *pcie, u8 bus, u32 devfn,
> > > ??
> > > ??	/* check alignment to Qword */
> > > ??	if ((where & 0x7) == 0)
> > > -		tlp_write_packet(pcie, headers, value, true);
> > > +		pcie->pcie_data->ops->tlp_write_pkt(pcie, headers,
> > > +						????????value, true);
> > > ??	else
> > > -		tlp_write_packet(pcie, headers, value, false);
> > > +		pcie->pcie_data->ops->tlp_write_pkt(pcie, headers,
> > > +						????????value, false);
> > > ??
> > > -	ret = tlp_read_packet(pcie, NULL);
> > > +	ret = pcie->pcie_data->ops->tlp_read_pkt(pcie, NULL);
> > > ??	if (ret != PCIBIOS_SUCCESSFUL)
> > > ??		return ret;
> > > ??
> > > @@ -254,6 +361,53 @@ static int tlp_cfg_dword_write(struct
> > > altera_pcie *pcie, u8 bus, u32 devfn,
> > > ??	return PCIBIOS_SUCCESSFUL;
> > > ??}
> > > ??
> > > +static int s10_rp_read_cfg(struct altera_pcie *pcie, int where,
> > > +			??????int size, u32 *value)
> > > +{
> > > +	void *addr = S10_RP_CFG_ADDR(pcie, where);
> > > +
> > > +	switch (size) {
> > > +	case 1:
> > > +		*value = readb(addr);
> > > +		break;
> > > +	case 2:
> > > +		*value = readw(addr);
> > > +		break;
> > > +	default:
> > > +		*value = readl(addr);
> > > +		break;
> > > +	}
> > > +
> > > +	return PCIBIOS_SUCCESSFUL;
> > > +}
> > > +
> > > +static int s10_rp_write_cfg(struct altera_pcie *pcie, u8 busno,
> > > +			????????int where, int size, u32 value)
> > > +{
> > > +	void *addr = S10_RP_CFG_ADDR(pcie, where);
> > > +
> > > +	switch (size) {
> > > +	case 1:
> > > +		writeb(value, addr);
> > > +		break;
> > > +	case 2:
> > > +		writew(value, addr);
> > > +		break;
> > > +	default:
> > > +		writel(value, addr);
> > > +		break;
> > > +	}
> > > +
> > > +	/*
> > > +	??* Monitor changes to PCI_PRIMARY_BUS register on root
> > > port
> > > +	??* and update local copy of root bus number accordingly.
> > > +	??*/
> > > +	if (busno == pcie->root_bus_nr && where ==
> > > PCI_PRIMARY_BUS)
> > > +		pcie->root_bus_nr = value & 0xff;
> > > +
> > > +	return PCIBIOS_SUCCESSFUL;
> > > +}
> > > +
> > > ??static int _altera_pcie_cfg_read(struct altera_pcie *pcie, u8
> > > busno,
> > > ??				??unsigned int devfn, int where,
> > > int size,
> > > ??				??u32 *value)
> > > @@ -262,6 +416,10 @@ static int _altera_pcie_cfg_read(struct
> > > altera_pcie *pcie, u8 busno,
> > > ??	u32 data;
> > > ??	u8 byte_en;
> > > ??
> > > +	if (busno == pcie->root_bus_nr && pcie->pcie_data->ops-
> > > >rp_read_cfg)
> > > +		return pcie->pcie_data->ops->rp_read_cfg(pcie,
> > > where,
> > > +							??size,
> > > value);
> > > +
> > > ??	switch (size) {
> > > ??	case 1:
> > > ??		byte_en = 1 << (where & 3);
> > > @@ -302,6 +460,10 @@ static int _altera_pcie_cfg_write(struct
> > > altera_pcie *pcie, u8 busno,
> > > ??	u32 shift = 8 * (where & 3);
> > > ??	u8 byte_en;
> > > ??
> > > +	if (busno == pcie->root_bus_nr && pcie->pcie_data->ops-
> > > >rp_write_cfg)
> > > +		return pcie->pcie_data->ops->rp_write_cfg(pcie,
> > > busno,
> > > +						??????????where, size,
> > > value);
> > > +
> > > ??	switch (size) {
> > > ??	case 1:
> > > ??		data32 = (value & 0xff) << shift;
> > > @@ -365,7 +527,8 @@ static int altera_read_cap_word(struct
> > > altera_pcie *pcie, u8 busno,
> > > ??	int ret;
> > > ??
> > > ??	ret = _altera_pcie_cfg_read(pcie, busno, devfn,
> > > -				????????PCIE_CAP_OFFSET + offset,
> > > sizeof(*value),
> > > +				????????pcie->pcie_data->cap_offset +
> > > offset,
> > > +				????????sizeof(*value),
> > > ??				????????&data);
> > > ??	*value = data;
> > > ??	return ret;
> > > @@ -375,7 +538,8 @@ static int altera_write_cap_word(struct
> > > altera_pcie *pcie, u8 busno,
> > > ??				??unsigned int devfn, int offset,
> > > u16 value)
> > > ??{
> > > ??	return _altera_pcie_cfg_write(pcie, busno, devfn,
> > > -				????????????PCIE_CAP_OFFSET + offset,
> > > sizeof(value),
> > > +				????????????pcie->pcie_data->cap_offset
> > > + offset,
> > > +				????????????sizeof(value),
> > > ??				????????????value);
> > > ??}
> > > ??
> > > @@ -403,7 +567,7 @@ static void altera_wait_link_retrain(struct
> > > altera_pcie *pcie)
> > > ??	/* Wait for link is up */
> > > ??	start_jiffies = jiffies;
> > > ??	for (;;) {
> > > -		if (altera_pcie_link_up(pcie))
> > > +		if (pcie->pcie_data->ops->get_link_status(pcie))
> > > ??			break;
> > > ??
> > > ??		if (time_after(jiffies, start_jiffies +
> > > LINK_UP_TIMEOUT)) {
> > > @@ -418,7 +582,7 @@ static void altera_pcie_retrain(struct
> > > altera_pcie *pcie)
> > > ??{
> > > ??	u16 linkcap, linkstat, linkctl;
> > > ??
> > > -	if (!altera_pcie_link_up(pcie))
> > > +	if (!pcie->pcie_data->ops->get_link_status(pcie))
> > > ??		return;
> > > ??
> > > ??	/*
> > > @@ -540,12 +704,20 @@ static int altera_pcie_parse_dt(struct
> > > altera_pcie *pcie)
> > > ??	struct device *dev = &pcie->pdev->dev;
> > > ??	struct platform_device *pdev = pcie->pdev;
> > > ??	struct resource *cra;
> > > +	struct resource *hip;
> > > ??
> > > ??	cra = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> > > "Cra");
> > > ??	pcie->cra_base = devm_ioremap_resource(dev, cra);
> > > ??	if (IS_ERR(pcie->cra_base))
> > > ??		return PTR_ERR(pcie->cra_base);
> > > ??
> > > +	if (pcie->pcie_data->version == ALTERA_PCIE_V2) {
> > > +		hip = platform_get_resource_byname(pdev,
> > > IORESOURCE_MEM, "Hip");
> > > +		pcie->hip_base = devm_ioremap_resource(&pdev->dev, 
> > > hip);
> > > +		if (IS_ERR(pcie->hip_base))
> > > +			return PTR_ERR(pcie->hip_base);
> > > +	}
> > > +
> > > ??	/* setup IRQ */
> > > ??	pcie->irq = platform_get_irq(pdev, 0);
> > > ??	if (pcie->irq < 0) {
> > > @@ -562,6 +734,48 @@ static void altera_pcie_host_init(struct
> > > altera_pcie *pcie)
> > > ??	altera_pcie_retrain(pcie);
> > > ??}
> > > ??
> > > +static const struct altera_pcie_ops altera_pcie_ops_1_0 = {
> > > +	.tlp_read_pkt = tlp_read_packet,
> > > +	.tlp_write_pkt = tlp_write_packet,
> > > +	.get_link_status = altera_pcie_link_up,
> > > +};
> > > +
> > > +static const struct altera_pcie_ops altera_pcie_ops_2_0 = {
> > > +	.tlp_read_pkt = s10_tlp_read_packet,
> > > +	.tlp_write_pkt = s10_tlp_write_packet,
> > > +	.get_link_status = s10_altera_pcie_link_up,
> > > +	.rp_read_cfg = s10_rp_read_cfg,
> > > +	.rp_write_cfg = s10_rp_write_cfg,
> > > +};
> > > +
> > > +static const struct altera_pcie_data altera_pcie_1_0_data = {
> > > +	.ops = &altera_pcie_ops_1_0,
> > > +	.cap_offset = 0x80,
> > > +	.version = ALTERA_PCIE_V1,
> > > +	.cfgrd0 = TLP_FMTTYPE_CFGRD0,
> > > +	.cfgrd1 = TLP_FMTTYPE_CFGRD1,
> > > +	.cfgwr0 = TLP_FMTTYPE_CFGWR0,
> > > +	.cfgwr1 = TLP_FMTTYPE_CFGWR1,
> > > +};
> > > +
> > > +static const struct altera_pcie_data altera_pcie_2_0_data = {
> > > +	.ops = &altera_pcie_ops_2_0,
> > > +	.version = ALTERA_PCIE_V2,
> > > +	.cap_offset = 0x70,
> > > +	.cfgrd0 = S10_TLP_FMTTYPE_CFGRD0,
> > > +	.cfgrd1 = S10_TLP_FMTTYPE_CFGRD1,
> > > +	.cfgwr0 = S10_TLP_FMTTYPE_CFGWR0,
> > > +	.cfgwr1 = S10_TLP_FMTTYPE_CFGWR1,
> > > +};
> > > +
> > > +static const struct of_device_id altera_pcie_of_match[] = {
> > > +	{.compatible = "altr,pcie-root-port-1.0",
> > > +	??.data = &altera_pcie_1_0_data },
> > > +	{.compatible = "altr,pcie-root-port-2.0",
> > > +	??.data = &altera_pcie_2_0_data },
> > > +	{},
> > > +};
> > > +
> > > ??static int altera_pcie_probe(struct platform_device *pdev)
> > > ??{
> > > ??	struct device *dev = &pdev->dev;
> > > @@ -570,6 +784,7 @@ static int altera_pcie_probe(struct
> > > platform_device *pdev)
> > > ??	struct pci_bus *child;
> > > ??	struct pci_host_bridge *bridge;
> > > ??	int ret;
> > > +	const struct of_device_id *match;
> > > ??
> > > ??	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
> > > ??	if (!bridge)
> > > @@ -578,6 +793,12 @@ static int altera_pcie_probe(struct
> > > platform_device *pdev)
> > > ??	pcie = pci_host_bridge_priv(bridge);
> > > ??	pcie->pdev = pdev;
> > > ??
> > > +	match = of_match_device(altera_pcie_of_match, &pdev->dev);
> > > +	if (!match)
> > > +		return -ENODEV;
> > > +
> > > +	pcie->pcie_data = match->data;
> > > +
> > > ??	ret = altera_pcie_parse_dt(pcie);
> > > ??	if (ret) {
> > > ??		dev_err(dev, "Parsing DT failed\n");
> > > @@ -628,11 +849,6 @@ static int altera_pcie_probe(struct
> > > platform_device *pdev)
> > > ??	return ret;
> > > ??}
> > > ??
> > > -static const struct of_device_id altera_pcie_of_match[] = {
> > > -	{ .compatible = "altr,pcie-root-port-1.0", },
> > > -	{},
> > > -};
> > > -
> > > ??static struct platform_driver altera_pcie_driver = {
> > > ??	.probe		= altera_pcie_probe,
> > > ??	.driver = {
