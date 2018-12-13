Return-Path: <SRS0=IRPw=OW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03352C65BAE
	for <linux-pci@archiver.kernel.org>; Thu, 13 Dec 2018 08:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1A082075B
	for <linux-pci@archiver.kernel.org>; Thu, 13 Dec 2018 08:46:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1A082075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tkos.co.il
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbeLMIqU (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 13 Dec 2018 03:46:20 -0500
Received: from guitar.tcltek.co.il ([192.115.133.116]:50431 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725949AbeLMIqU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Dec 2018 03:46:20 -0500
Received: from tarshish (unknown [10.0.8.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id C4DD044083B;
        Thu, 13 Dec 2018 10:46:17 +0200 (IST)
References: <1544687042-16595-1-git-send-email-hongxing.zhu@nxp.com> <87zht96e15.fsf@tkos.co.il> <AM0PR0402MB357061ADF5FAFD253C1A5B8A8CA00@AM0PR0402MB3570.eurprd04.prod.outlook.com>
User-agent: mu4e 1.0; emacs 25.2.2
From:   Baruch Siach <baruch@tkos.co.il>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     "bhelgaas\@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi\@arm.com" <lorenzo.pieralisi@arm.com>,
        "l.stach\@pengutronix.de" <l.stach@pengutronix.de>,
        "andrew.smirnov\@gmail.com" <andrew.smirnov@gmail.com>,
        "linux-pci\@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel\@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [v2] PCI: imx: make msi work without pcieportbus
In-reply-to: <AM0PR0402MB357061ADF5FAFD253C1A5B8A8CA00@AM0PR0402MB3570.eurprd04.prod.outlook.com>
Date:   Thu, 13 Dec 2018 10:46:17 +0200
Message-ID: <87y38t6ch2.fsf@tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Richard,

Richard Zhu writes:
>> -----Original Message-----
>> From: Baruch Siach [mailto:baruch@tkos.co.il]
>> Sent: 2018年12月13日 16:13
>> To: Richard Zhu <hongxing.zhu@nxp.com>
>> Cc: bhelgaas@google.com; lorenzo.pieralisi@arm.com;
>> l.stach@pengutronix.de; andrew.smirnov@gmail.com;
>> linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org;
>> linux-arm-kernel@lists.infradead.org
>> Subject: Re: [v2] PCI: imx: make msi work without pcieportbus
>>
>> Richard Zhu writes:
>> > MSI_EN of iMX PCIe RC would be asserted when PCIEPORTBUS driver is
>> > selected.
>> > Thus, the MSI works fine on iMX PCIe before.
>> > Assert it unconditionally when MSI is supported.
>> > Otherwise, the MSI wouldn't be triggered although the EP is present
>> > and the MSIs are assigned.
>> >
>> > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
>> > ---
>> >  drivers/pci/controller/dwc/pci-imx6.c | 7 +++++++
>> >  1 file changed, 7 insertions(+)
>> >
>> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c
>> > b/drivers/pci/controller/dwc/pci-imx6.c
>> > index 26087b3..d3e4296 100644
>> > --- a/drivers/pci/controller/dwc/pci-imx6.c
>> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
>> > @@ -74,6 +74,7 @@ struct imx6_pcie {
>> >  #define PHY_PLL_LOCK_WAIT_USLEEP_MAX	200
>> >
>> >  /* PCIe Root Complex registers (memory-mapped) */
>> > +#define PCI_MSI_CAP				0x50
>> >  #define PCIE_RC_LCR				0x7c
>> >  #define PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN1	0x1
>> >  #define PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN2	0x2
>> > @@ -926,6 +927,7 @@ static int imx6_pcie_probe(struct platform_device
>> *pdev)
>> >  	struct resource *dbi_base;
>> >  	struct device_node *node = dev->of_node;
>> >  	int ret;
>> > +	u16 val;
>> >
>> >  	imx6_pcie = devm_kzalloc(dev, sizeof(*imx6_pcie), GFP_KERNEL);
>> >  	if (!imx6_pcie)
>> > @@ -1070,6 +1072,11 @@ static int imx6_pcie_probe(struct
>> platform_device *pdev)
>> >  	ret = imx6_add_pcie_port(imx6_pcie, pdev);
>> >  	if (ret < 0)
>> >  		return ret;
>> > +	if (IS_ENABLED(CONFIG_PCI_MSI)) {
>>
>> CONFIG_PCI_IMX6 depends on CONFIG_PCI_MSI_IRQ_DOMAIN that in turn
>> depends on CONFIG_PCI_MSI. So this condition should always be true. If so,
>> you can drop this one as well.
> [Richard Zhu] Thanks.
> Can we have the double check here?
> Thus, it's aligned to the MSI enable codes in the other place of the driver.
> For example:
> ...
> 	        if (IS_ENABLED(CONFIG_PCI_MSI))
>                 dw_pcie_msi_init(pp);
> ...
> Secondly, the driver has a better portability with the double check here.
> How do you think about it?

Kernel driver are not meant to be "portable" as far as I understand. But
I'll let the PCI maintainers comment on that. For reference, mainline
kernel makes CONFIG_PCI_MSI a hard dependency of pci-imx6 since commit
3ee803641e76 ("PCI/MSI: irqchip: Fix PCI_MSI dependencies") in v4.8.

In my opinion, if the driver actually compiles and is usable without
CONFIG_PCI_MSI then Kconfig dependencies should reflect that.

>> > +		val = dw_pcie_readw_dbi(pci, PCI_MSI_CAP + PCI_MSI_FLAGS);
>> > +		val |= PCI_MSI_FLAGS_ENABLE;
>> > +		dw_pcie_writew_dbi(pci, PCI_MSI_CAP + PCI_MSI_FLAGS, val);
>> > +	}
>> >
>> >  	return 0;
>> >  }

baruch

--
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
