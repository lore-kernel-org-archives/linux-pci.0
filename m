Return-Path: <SRS0=XSei=MI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77757C43382
	for <linux-pci@archiver.kernel.org>; Wed, 26 Sep 2018 09:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F22B214D5
	for <linux-pci@archiver.kernel.org>; Wed, 26 Sep 2018 09:08:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F22B214D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbeIZPUr (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 26 Sep 2018 11:20:47 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:4379 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727189AbeIZPUq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Sep 2018 11:20:46 -0400
X-UUID: 16e19449049f48fbb69caf40fc3c6f27-20180926
Received: from mtkcas32.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <honghui.zhang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 2062409185; Wed, 26 Sep 2018 17:08:43 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 26 Sep
 2018 17:08:41 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 26 Sep 2018 17:08:40 +0800
Message-ID: <1537952920.14753.6.camel@mhfsdcap03>
Subject: Re: [PATCH v4 2/4] PCI: mediatek: enable msi after clock enabled
From:   Honghui Zhang <honghui.zhang@mediatek.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     <marc.zyngier@arm.com>, <bhelgaas@google.com>,
        <matthias.bgg@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <yingjoe.chen@mediatek.com>, <eddie.huang@mediatek.com>,
        <ryder.lee@mediatek.com>, <ulf.hansson@linaro.org>,
        <hongkun.cao@mediatek.com>, <youlin.pei@mediatek.com>,
        <yong.wu@mediatek.com>, <yt.shen@mediatek.com>,
        <sean.wang@mediatek.com>, <xinping.qian@mediatek.com>
Date:   Wed, 26 Sep 2018 17:08:40 +0800
In-Reply-To: <20180921164612.GA27651@e107981-ln.cambridge.arm.com>
References: <1536573023-6720-1-git-send-email-honghui.zhang@mediatek.com>
         <1536573023-6720-3-git-send-email-honghui.zhang@mediatek.com>
         <20180921164612.GA27651@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 2018-09-21 at 17:46 +0100, Lorenzo Pieralisi wrote:
> On Mon, Sep 10, 2018 at 05:50:21PM +0800, honghui.zhang@mediatek.com wrote:
> > From: Honghui Zhang <honghui.zhang@mediatek.com>
> > 
> > The clocks was not enabled when enable MSI. This patch fix this
> > issue by calling mtk_pcie_enable_msi in mtk_pcie_startup_port_v2
> > since the clock was all enabled at that time.
> > 
> > The function of mtk_pcie_startup_port_v2's define location is
> > re-arranged to avoid mtk_pcie_enable_msi's forward declaration.
> > 
> > Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
> > Reviewed-by: Ryder Lee <ryder.lee@mediatek.com>
> > ---
> >  drivers/pci/controller/pcie-mediatek.c | 143 +++++++++++++++++----------------
> >  1 file changed, 72 insertions(+), 71 deletions(-)
> 
> Can you read:
> 
> https://marc.info/?l=linux-pci&m=150905742808166&w=2
> 
> follow it and adapt this patch and the others accordingly please ?
> 
Sorry, I mixed those patches together. I will split a new patch to do
the code re-arrangement to avoid forward declaration.

Thanks.
> Thanks,
> Lorenzo
> 
> > diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> > index 20b9088..5aba43a 100644
> > --- a/drivers/pci/controller/pcie-mediatek.c
> > +++ b/drivers/pci/controller/pcie-mediatek.c
> > @@ -398,75 +398,6 @@ static struct pci_ops mtk_pcie_ops_v2 = {
> >  	.write = mtk_pcie_config_write,
> >  };
> >  
> > -static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
> > -{
> > -	struct mtk_pcie *pcie = port->pcie;
> > -	struct resource *mem = &pcie->mem;
> > -	const struct mtk_pcie_soc *soc = port->pcie->soc;
> > -	u32 val;
> > -	size_t size;
> > -	int err;
> > -
> > -	/* MT7622 platforms need to enable LTSSM and ASPM from PCIe subsys */
> > -	if (pcie->base) {
> > -		val = readl(pcie->base + PCIE_SYS_CFG_V2);
> > -		val |= PCIE_CSR_LTSSM_EN(port->slot) |
> > -		       PCIE_CSR_ASPM_L1_EN(port->slot);
> > -		writel(val, pcie->base + PCIE_SYS_CFG_V2);
> > -	}
> > -
> > -	/* Assert all reset signals */
> > -	writel(0, port->base + PCIE_RST_CTRL);
> > -
> > -	/*
> > -	 * Enable PCIe link down reset, if link status changed from link up to
> > -	 * link down, this will reset MAC control registers and configuration
> > -	 * space.
> > -	 */
> > -	writel(PCIE_LINKDOWN_RST_EN, port->base + PCIE_RST_CTRL);
> > -
> > -	/* De-assert PHY, PE, PIPE, MAC and configuration reset	*/
> > -	val = readl(port->base + PCIE_RST_CTRL);
> > -	val |= PCIE_PHY_RSTB | PCIE_PERSTB | PCIE_PIPE_SRSTB |
> > -	       PCIE_MAC_SRSTB | PCIE_CRSTB;
> > -	writel(val, port->base + PCIE_RST_CTRL);
> > -
> > -	/* Set up vendor ID and class code */
> > -	if (soc->need_fix_class_id) {
> > -		val = PCI_VENDOR_ID_MEDIATEK;
> > -		writew(val, port->base + PCIE_CONF_VEND_ID);
> > -
> > -		val = PCI_CLASS_BRIDGE_HOST;
> > -		writew(val, port->base + PCIE_CONF_CLASS_ID);
> > -	}
> > -
> > -	/* 100ms timeout value should be enough for Gen1/2 training */
> > -	err = readl_poll_timeout(port->base + PCIE_LINK_STATUS_V2, val,
> > -				 !!(val & PCIE_PORT_LINKUP_V2), 20,
> > -				 100 * USEC_PER_MSEC);
> > -	if (err)
> > -		return -ETIMEDOUT;
> > -
> > -	/* Set INTx mask */
> > -	val = readl(port->base + PCIE_INT_MASK);
> > -	val &= ~INTX_MASK;
> > -	writel(val, port->base + PCIE_INT_MASK);
> > -
> > -	/* Set AHB to PCIe translation windows */
> > -	size = mem->end - mem->start;
> > -	val = lower_32_bits(mem->start) | AHB2PCIE_SIZE(fls(size));
> > -	writel(val, port->base + PCIE_AHB_TRANS_BASE0_L);
> > -
> > -	val = upper_32_bits(mem->start);
> > -	writel(val, port->base + PCIE_AHB_TRANS_BASE0_H);
> > -
> > -	/* Set PCIe to AXI translation memory space.*/
> > -	val = fls(0xffffffff) | WIN_ENABLE;
> > -	writel(val, port->base + PCIE_AXI_WINDOW0);
> > -
> > -	return 0;
> > -}
> > -
> >  static void mtk_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
> >  {
> >  	struct mtk_pcie_port *port = irq_data_get_irq_chip_data(data);
> > @@ -643,8 +574,6 @@ static int mtk_pcie_init_irq_domain(struct mtk_pcie_port *port,
> >  		ret = mtk_pcie_allocate_msi_domains(port);
> >  		if (ret)
> >  			return ret;
> > -
> > -		mtk_pcie_enable_msi(port);
> >  	}
> >  
> >  	return 0;
> > @@ -711,6 +640,78 @@ static int mtk_pcie_setup_irq(struct mtk_pcie_port *port,
> >  	return 0;
> >  }
> >  
> > +static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
> > +{
> > +	struct mtk_pcie *pcie = port->pcie;
> > +	struct resource *mem = &pcie->mem;
> > +	const struct mtk_pcie_soc *soc = port->pcie->soc;
> > +	u32 val;
> > +	size_t size;
> > +	int err;
> > +
> > +	/* MT7622 platforms need to enable LTSSM and ASPM from PCIe subsys */
> > +	if (pcie->base) {
> > +		val = readl(pcie->base + PCIE_SYS_CFG_V2);
> > +		val |= PCIE_CSR_LTSSM_EN(port->slot) |
> > +		       PCIE_CSR_ASPM_L1_EN(port->slot);
> > +		writel(val, pcie->base + PCIE_SYS_CFG_V2);
> > +	}
> > +
> > +	/* Assert all reset signals */
> > +	writel(0, port->base + PCIE_RST_CTRL);
> > +
> > +	/*
> > +	 * Enable PCIe link down reset, if link status changed from link up to
> > +	 * link down, this will reset MAC control registers and configuration
> > +	 * space.
> > +	 */
> > +	writel(PCIE_LINKDOWN_RST_EN, port->base + PCIE_RST_CTRL);
> > +
> > +	/* De-assert PHY, PE, PIPE, MAC and configuration reset	*/
> > +	val = readl(port->base + PCIE_RST_CTRL);
> > +	val |= PCIE_PHY_RSTB | PCIE_PERSTB | PCIE_PIPE_SRSTB |
> > +	       PCIE_MAC_SRSTB | PCIE_CRSTB;
> > +	writel(val, port->base + PCIE_RST_CTRL);
> > +
> > +	/* Set up vendor ID and class code */
> > +	if (soc->need_fix_class_id) {
> > +		val = PCI_VENDOR_ID_MEDIATEK;
> > +		writew(val, port->base + PCIE_CONF_VEND_ID);
> > +
> > +		val = PCI_CLASS_BRIDGE_HOST;
> > +		writew(val, port->base + PCIE_CONF_CLASS_ID);
> > +	}
> > +
> > +	/* 100ms timeout value should be enough for Gen1/2 training */
> > +	err = readl_poll_timeout(port->base + PCIE_LINK_STATUS_V2, val,
> > +				 !!(val & PCIE_PORT_LINKUP_V2), 20,
> > +				 100 * USEC_PER_MSEC);
> > +	if (err)
> > +		return -ETIMEDOUT;
> > +
> > +	/* Set INTx mask */
> > +	val = readl(port->base + PCIE_INT_MASK);
> > +	val &= ~INTX_MASK;
> > +	writel(val, port->base + PCIE_INT_MASK);
> > +
> > +	if (IS_ENABLED(CONFIG_PCI_MSI))
> > +		mtk_pcie_enable_msi(port);
> > +
> > +	/* Set AHB to PCIe translation windows */
> > +	size = mem->end - mem->start;
> > +	val = lower_32_bits(mem->start) | AHB2PCIE_SIZE(fls(size));
> > +	writel(val, port->base + PCIE_AHB_TRANS_BASE0_L);
> > +
> > +	val = upper_32_bits(mem->start);
> > +	writel(val, port->base + PCIE_AHB_TRANS_BASE0_H);
> > +
> > +	/* Set PCIe to AXI translation memory space.*/
> > +	val = fls(0xffffffff) | WIN_ENABLE;
> > +	writel(val, port->base + PCIE_AXI_WINDOW0);
> > +
> > +	return 0;
> > +}
> > +
> >  static void __iomem *mtk_pcie_map_bus(struct pci_bus *bus,
> >  				      unsigned int devfn, int where)
> >  {
> > -- 
> > 2.6.4
> > 


