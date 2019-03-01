Return-Path: <SRS0=yUVM=RE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B9CDC43381
	for <linux-pci@archiver.kernel.org>; Fri,  1 Mar 2019 01:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38C1820842
	for <linux-pci@archiver.kernel.org>; Fri,  1 Mar 2019 01:58:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbfCAB6e (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 28 Feb 2019 20:58:34 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:60690 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726210AbfCAB6e (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Feb 2019 20:58:34 -0500
X-UUID: 3afb1b9fcb8a4f02b2e55e961c9a6586-20190301
X-UUID: 3afb1b9fcb8a4f02b2e55e961c9a6586-20190301
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <honghui.zhang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1758431329; Fri, 01 Mar 2019 09:58:29 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 1 Mar
 2019 09:58:27 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 1 Mar 2019 09:58:27 +0800
Message-ID: <1551405506.32061.18.camel@mhfsdcap03>
Subject: Re: [PATCH v3 2/2] PCI: mediatek: Enlarge PCIe2AHB window size to
 support 4GB DRAM
From:   Honghui Zhang <honghui.zhang@mediatek.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     <bhelgaas@google.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ryder.lee@mediatek.com>,
        <rafael.j.wysocki@intel.com>, <fred@fredlawl.com>,
        <poza@codeaurora.org>, <youlin.pei@mediatek.com>,
        <jianjun.wang@mediatek.com>
Date:   Fri, 1 Mar 2019 09:58:26 +0800
In-Reply-To: <20190228174257.GA26501@e107981-ln.cambridge.arm.com>
References: <1548999367-11733-1-git-send-email-honghui.zhang@mediatek.com>
         <1548999367-11733-3-git-send-email-honghui.zhang@mediatek.com>
         <20190228174257.GA26501@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 2019-02-28 at 17:42 +0000, Lorenzo Pieralisi wrote:
> On Fri, Feb 01, 2019 at 01:36:07PM +0800, honghui.zhang@mediatek.com wrote:
> > From: Honghui Zhang <honghui.zhang@mediatek.com>
> > 
> > The PCIE_AXI_WINDOW0 defines the translate window size for the request
> > from EP side. Request outside of this window will be treated as
> > unsupported request.
> > 
> > Enlarge this window size from fls(0xffffffff) to 2^33 to support 8GB
> > translate address range then EP DMA is capable of fully access 4GB
> > DRAM range(physical DRAM is start from 0x40000000).
> 
> I have rewritten both patches logs with the aim of merging them even if
> it is quite late in the cycle, first you have to explain something to
> me.
> 

Thanks very much for this.

> fls(0xffffffff) = 0x1f, which by your logic -> 2^31
> 
> What does it mean given what you say above ? That PCI devices can't
> do _any_ DMA in the current setting (given the DRAM start address) ?
> 

I'm afraid so.
From the HW datasheet I got from our HW designer, the description for
this pcie2axi_win_size filed is
" Possible values are 12 to 36 which means 2^12 to 2^36 bytes, leaving
this filed to 0 causes window to be disabled."

Current setting set the window size as 2^31, which means the request
from EP side could only access the address range from 0 to 0x8000_0000.
Considering the DRAM start from 0x4000_0000, that means only the first
1GB(0x4000_0000 ~ 0x8000_0000) could be accessed by EP side DMA.

This has not run into an error for our current usage, I guess because
MT2712 and MT7622 have several type boards, most of are only have 2GB
physical memory, and our test sample is not bigger enough to cover the
case that EP DMA will access fully DRAM. Or most EP device does not have
an built-in DMA engine, they may relay on the host side's MMIO(memory
mapped IO) operations.
 
Take MT2712 as example, in arch/arm64/boot/dts/mediatek/mt2712-evb.dts,
the physical memory size is defined as 0x80000000 and is described by
below node:

memory@400000000 {
	device_type = "memory";
	reg = <0 0x400000000 0 0x800000000>
}

Thanks.

> Lorenzo
> 
> > Reported-by: Bjorn Helgaas <bhelgaas@google.com>
> > Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
> > ---
> >  drivers/pci/controller/pcie-mediatek.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> > index c42fe5c..0b6c728 100644
> > --- a/drivers/pci/controller/pcie-mediatek.c
> > +++ b/drivers/pci/controller/pcie-mediatek.c
> > @@ -90,6 +90,12 @@
> >  #define AHB2PCIE_SIZE(x)	((x) & GENMASK(4, 0))
> >  #define PCIE_AXI_WINDOW0	0x448
> >  #define WIN_ENABLE		BIT(7)
> > +/*
> > + * Define PCIe to AHB window size as 2^33 to support max 8GB address space
> > + * translate, support least 4GB DRAM size access from EP DMA(physical DRAM
> > + * start from 0x40000000).
> > + */
> > +#define PCIE2AHB_SIZE	0x21
> >  
> >  /* PCIe V2 configuration transaction header */
> >  #define PCIE_CFG_HEADER0	0x460
> > @@ -713,7 +719,7 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
> >  	writel(val, port->base + PCIE_AHB_TRANS_BASE0_H);
> >  
> >  	/* Set PCIe to AXI translation memory space.*/
> > -	val = fls(0xffffffff) | WIN_ENABLE;
> > +	val = PCIE2AHB_SIZE | WIN_ENABLE;
> >  	writel(val, port->base + PCIE_AXI_WINDOW0);
> >  
> >  	return 0;
> > -- 
> > 2.6.4
> > 


