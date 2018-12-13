Return-Path: <SRS0=IRPw=OW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4092C65BAE
	for <linux-pci@archiver.kernel.org>; Thu, 13 Dec 2018 10:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91ECC20880
	for <linux-pci@archiver.kernel.org>; Thu, 13 Dec 2018 10:46:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91ECC20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbeLMKq4 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 13 Dec 2018 05:46:56 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:39031 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbeLMKq4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Dec 2018 05:46:56 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1gXOW5-0000m9-Ln; Thu, 13 Dec 2018 11:46:53 +0100
Message-ID: <1544698012.3137.28.camel@pengutronix.de>
Subject: Re: [v3] PCI: imx: make msi work without pcieportbus
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Richard Zhu <hongxing.zhu@nxp.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Thu, 13 Dec 2018 11:46:52 +0100
In-Reply-To: <1544696723-1673-1-git-send-email-hongxing.zhu@nxp.com>
References: <1544696723-1673-1-git-send-email-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am Donnerstag, den 13.12.2018, 10:43 +0000 schrieb Richard Zhu:
> MSI_EN of iMX PCIe RC would be asserted when
> PCIEPORTBUS driver is selected.
> Thus, the MSI works fine on iMX PCIe before.
> Assert it unconditionally when MSI is enabled.
> Otherwise, the MSI wouldn't be triggered although
> the EP is present and the MSIs are assigned.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
> Changes v1 -> v2:
> * Assert the MSI_EN unconditionally when MSI is supported.
> Changes v2 -> v3:
> * Remove the IS_ENABLED(CONFIG_PCI_MSI) since the driver
> depends on PCI_MSI_IRQ_DOMAIN
> * Extended with a check for pci_msi_enabled() to see
> if the user explicitly want legacy IRQs
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 26087b3..1c59a93 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -74,6 +74,7 @@ struct imx6_pcie {
> >  #define PHY_PLL_LOCK_WAIT_USLEEP_MAX	200
>  
>  /* PCIe Root Complex registers (memory-mapped) */
> > +#define PCI_MSI_CAP				0x50
> >  #define PCIE_RC_LCR				0x7c
> >  #define PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN1	0x1
> >  #define PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN2	0x2
> @@ -926,6 +927,7 @@ static int imx6_pcie_probe(struct platform_device *pdev)
> >  	struct resource *dbi_base;
> >  	struct device_node *node = dev->of_node;
> >  	int ret;
> > +	u16 val;
>  
> >  	imx6_pcie = devm_kzalloc(dev, sizeof(*imx6_pcie), GFP_KERNEL);
> >  	if (!imx6_pcie)
> @@ -1071,6 +1073,12 @@ static int imx6_pcie_probe(struct platform_device *pdev)
> >  	if (ret < 0)
> >  		return ret;
>  
> > +	if (pci_msi_enabled()) {
> > +		val = dw_pcie_readw_dbi(pci, PCI_MSI_CAP + PCI_MSI_FLAGS);
> > +		val |= PCI_MSI_FLAGS_ENABLE;
> > +		dw_pcie_writew_dbi(pci, PCI_MSI_CAP + PCI_MSI_FLAGS, val);
> > +	}
> +
> >  	return 0;
>  }
>  
