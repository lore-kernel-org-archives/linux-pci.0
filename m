Return-Path: <SRS0=agom=SC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E809C43381
	for <linux-pci@archiver.kernel.org>; Sun, 31 Mar 2019 12:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3740420830
	for <linux-pci@archiver.kernel.org>; Sun, 31 Mar 2019 12:40:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfCaMk3 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 31 Mar 2019 08:40:29 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:36968 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726807AbfCaMk3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 31 Mar 2019 08:40:29 -0400
X-UUID: 0783840e59b04b2d9ca14dc223875ca3-20190331
X-UUID: 0783840e59b04b2d9ca14dc223875ca3-20190331
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 96863905; Sun, 31 Mar 2019 20:40:10 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Sun, 31 Mar
 2019 20:40:08 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sun, 31 Mar 2019 20:40:08 +0800
Message-ID: <1554036008.10179.174.camel@mhfsdcap03>
Subject: Re: [PATCH] PCI: mediatek: get optional clock by
 devm_clk_get_optional()
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Ryder Lee <ryder.lee@mediatek.com>
CC:     Honghui Zhang <honghui.zhang@mediatek.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Sun, 31 Mar 2019 20:40:08 +0800
In-Reply-To: <1554027049.21644.0.camel@mtkswgap22>
References: <1553940051-10367-1-git-send-email-chunfeng.yun@mediatek.com>
         <1554027049.21644.0.camel@mtkswgap22>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Ryder,

On Sun, 2019-03-31 at 18:10 +0800, Ryder Lee wrote:
> On Sat, 2019-03-30 at 18:00 +0800, Chunfeng Yun wrote:
> > Use devm_clk_get_optional() to get optional clock
> > 
> > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > ---
> >  drivers/pci/controller/pcie-mediatek.c | 46 ++++++--------------------
> >  1 file changed, 11 insertions(+), 35 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> > index 0b6c72804e03..9a66a018489b 100644
> > --- a/drivers/pci/controller/pcie-mediatek.c
> > +++ b/drivers/pci/controller/pcie-mediatek.c
> > @@ -915,49 +915,25 @@ static int mtk_pcie_parse_port(struct mtk_pcie *pcie,
> >  
> >  	/* sys_ck might be divided into the following parts in some chips */
> >  	snprintf(name, sizeof(name), "ahb_ck%d", slot);
> > -	port->ahb_ck = devm_clk_get(dev, name);
> > -	if (IS_ERR(port->ahb_ck)) {
> > -		if (PTR_ERR(port->ahb_ck) == -EPROBE_DEFER)
> > -			return -EPROBE_DEFER;
> > -
> > -		port->ahb_ck = NULL;
> > -	}
> > +	port->ahb_ck = devm_clk_get_optional(dev, name);
> > +	if (IS_ERR(port->ahb_ck))
> > +		return PTR_ERR(port->ahb_ck);
> >  
> >  	snprintf(name, sizeof(name), "axi_ck%d", slot);
> > -	port->axi_ck = devm_clk_get(dev, name);
> > -	if (IS_ERR(port->axi_ck)) {
> > -		if (PTR_ERR(port->axi_ck) == -EPROBE_DEFER)
> > -			return -EPROBE_DEFER;
> > -
> > -		port->axi_ck = NULL;
> > -	}
> > +	port->axi_ck = devm_clk_get_optional(dev, name);
> > +		return PTR_ERR(port->axi_ck);
> >  
> >  	snprintf(name, sizeof(name), "aux_ck%d", slot);
> > -	port->aux_ck = devm_clk_get(dev, name);
> > -	if (IS_ERR(port->aux_ck)) {
> > -		if (PTR_ERR(port->aux_ck) == -EPROBE_DEFER)
> > -			return -EPROBE_DEFER;
> > -
> > -		port->aux_ck = NULL;
> > -	}
> > +	port->aux_ck = devm_clk_get_optional(dev, name);
> > +		return PTR_ERR(port->aux_ck);
> >  
> >  	snprintf(name, sizeof(name), "obff_ck%d", slot);
> > -	port->obff_ck = devm_clk_get(dev, name);
> > -	if (IS_ERR(port->obff_ck)) {
> > -		if (PTR_ERR(port->obff_ck) == -EPROBE_DEFER)
> > -			return -EPROBE_DEFER;
> > -
> > -		port->obff_ck = NULL;
> > -	}
> > +	port->obff_ck = devm_clk_get_optional(dev, name);
> > +		return PTR_ERR(port->obff_ck);
> >  
> >  	snprintf(name, sizeof(name), "pipe_ck%d", slot);
> > -	port->pipe_ck = devm_clk_get(dev, name);
> > -	if (IS_ERR(port->pipe_ck)) {
> > -		if (PTR_ERR(port->pipe_ck) == -EPROBE_DEFER)
> > -			return -EPROBE_DEFER;
> > -
> > -		port->pipe_ck = NULL;
> > -	}
> > +	port->pipe_ck = devm_clk_get_optional(dev, name);
> > +		return PTR_ERR(port->pipe_ck);
> >  
> >  	snprintf(name, sizeof(name), "pcie-rst%d", slot);
> >  	port->reset = devm_reset_control_get_optional_exclusive(dev, name);
> 
> if (IS_ERR(...)) ?
Very sorry for my stupid mistake:(
will send new version

> 


