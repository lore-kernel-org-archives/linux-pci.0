Return-Path: <SRS0=T4LS=ML=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C40C43143
	for <linux-pci@archiver.kernel.org>; Sat, 29 Sep 2018 05:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8080720879
	for <linux-pci@archiver.kernel.org>; Sat, 29 Sep 2018 05:56:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8080720879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbeI2MXR (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 29 Sep 2018 08:23:17 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:54234 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727393AbeI2MXR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 29 Sep 2018 08:23:17 -0400
X-UUID: 93ae8b3afb4f44e68c62794d269862fd-20180929
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 621870044; Sat, 29 Sep 2018 13:56:01 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sat, 29 Sep 2018 13:55:59 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sat, 29 Sep 2018 13:55:55 +0800
Message-ID: <1538200554.25778.4.camel@mtkswgap22>
Subject: Re: [PATCH v5 4/9] PCI: mediatek: Convert to use pci_host_probe()
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Honghui Zhang <honghui.zhang@mediatek.com>
CC:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ulf.hansson@linaro.org>,
        <marc.zyngier@arm.com>, <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>, <yingjoe.chen@mediatek.com>,
        <eddie.huang@mediatek.com>, <youlin.pei@mediatek.com>,
        <yt.shen@mediatek.com>, <sean.wang@mediatek.com>
Date:   Sat, 29 Sep 2018 13:55:54 +0800
In-Reply-To: <1538180205.14753.20.camel@mhfsdcap03>
References: <1538129080-8206-1-git-send-email-honghui.zhang@mediatek.com>
         <1538129080-8206-5-git-send-email-honghui.zhang@mediatek.com>
         <1538149277.23182.7.camel@mtkswgap22>
         <1538180205.14753.20.camel@mhfsdcap03>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-TM-SNTS-SMTP: 67E7F166831E3AA6CEB68F652C190C1D86E1435962AB698DF12921B8FE64E6982000:8
X-MTK:  N
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, 2018-09-29 at 08:16 +0800, Honghui Zhang wrote:
> On Fri, 2018-09-28 at 23:41 +0800, Ryder Lee wrote:
> > On Fri, 2018-09-28 at 18:04 +0800, honghui.zhang@mediatek.com wrote:
> > > From: Honghui Zhang <honghui.zhang@mediatek.com>
> > > 
> > > Part of mtk_pcie_register_host is an open-coded version of
> > > pci_host_probe(). So instead of duplicating this code, use
> > > pci_host_probe() directly and remove mtk_pcie_register_host.
> > > 
> > > Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
> > > ---
> > >  drivers/pci/controller/pcie-mediatek.c | 37 ++++++++--------------------------
> > >  1 file changed, 8 insertions(+), 29 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> > > index e2c4127..cbf4543 100644
> > > --- a/drivers/pci/controller/pcie-mediatek.c
> > > +++ b/drivers/pci/controller/pcie-mediatek.c
> > > @@ -1125,34 +1125,6 @@ static int mtk_pcie_request_resources(struct mtk_pcie *pcie)
> > >  	return 0;
> > >  }
> > >  
> > > -static int mtk_pcie_register_host(struct pci_host_bridge *host)
> > > -{
> > > -	struct mtk_pcie *pcie = pci_host_bridge_priv(host);
> > > -	struct pci_bus *child;
> > > -	int err;
> > 
> > To make the patch simple, could we keep these host->*. and return
> > pci_host_probe() directly?
> 
> Well, I guess it's not necessary to keep the mtk_pcie_register_host just
> wrap pci_host_probe(). Put those host->* directly in probe function is
> no harm, it will reduce one function call and related parameter passing.
> 
> I may update this patch to keep the mtk_pcie_register_host if you insist
> though I prefer the current way.
> 
> Thanks.

Okay. I'm fine with this.

> > > -	host->busnr = pcie->busn.start;
> > > -	host->dev.parent = pcie->dev;
> > > -	host->ops = pcie->soc->ops;
> > > -	host->map_irq = of_irq_parse_and_map_pci;
> > > -	host->swizzle_irq = pci_common_swizzle;
> > > -	host->sysdata = pcie;
> > > -
> > > -	err = pci_scan_root_bus_bridge(host);
> > > -	if (err < 0)
> > > -		return err;
> > > -
> > > -	pci_bus_size_bridges(host->bus);
> > > -	pci_bus_assign_resources(host->bus);
> > > -
> > > -	list_for_each_entry(child, &host->bus->children, node)
> > > -		pcie_bus_configure_settings(child);
> > > -
> > > -	pci_bus_add_devices(host->bus);
> > > -
> > > -	return 0;
> > > -}
> > > -
> > >  static int mtk_pcie_probe(struct platform_device *pdev)
> > >  {
> > >  	struct device *dev = &pdev->dev;
> > > @@ -1179,7 +1151,14 @@ static int mtk_pcie_probe(struct platform_device *pdev)
> > >  	if (err)
> > >  		goto put_resources;
> > >  
> > > -	err = mtk_pcie_register_host(host);
> > > +	host->busnr = pcie->busn.start;
> > > +	host->dev.parent = pcie->dev;
> > > +	host->ops = pcie->soc->ops;
> > > +	host->map_irq = of_irq_parse_and_map_pci;
> > > +	host->swizzle_irq = pci_common_swizzle;
> > > +	host->sysdata = pcie;
> > > +
> > > +	err = pci_host_probe(host);
> > >  	if (err)
> > >  		goto put_resources;
> > >  
> > 
> > 
> 
> 


