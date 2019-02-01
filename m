Return-Path: <SRS0=jDI6=QI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6909C169C4
	for <linux-pci@archiver.kernel.org>; Fri,  1 Feb 2019 02:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8246620863
	for <linux-pci@archiver.kernel.org>; Fri,  1 Feb 2019 02:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbfBACr5 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 31 Jan 2019 21:47:57 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:48273 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728043AbfBACr4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 Jan 2019 21:47:56 -0500
X-UUID: 7a2024893b634559a250203f2d96e0e2-20190201
X-UUID: 7a2024893b634559a250203f2d96e0e2-20190201
Received: from mtkcas36.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <honghui.zhang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1645939208; Fri, 01 Feb 2019 10:47:48 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 1 Feb
 2019 10:47:46 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 1 Feb 2019 10:47:46 +0800
Message-ID: <1548989266.4980.39.camel@mhfsdcap03>
Subject: Re: [PATCH v2 1/2] PCI: mediatek: Use resource_size function on
 resource object
From:   Honghui Zhang <honghui.zhang@mediatek.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <lorenzo.pieralisi@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ryder.lee@mediatek.com>,
        <youlin.pei@mediatek.com>, <poza@codeaurora.org>,
        <fred@fredlawl.com>, <rafael.j.wysocki@intel.com>,
        <jianjun.wang@mediatek.com>
Date:   Fri, 1 Feb 2019 10:47:46 +0800
In-Reply-To: <20190131213647.GP229773@google.com>
References: <1548921713-5355-1-git-send-email-honghui.zhang@mediatek.com>
         <1548921713-5355-2-git-send-email-honghui.zhang@mediatek.com>
         <20190131213647.GP229773@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 2019-01-31 at 15:36 -0600, Bjorn Helgaas wrote:
> On Thu, Jan 31, 2019 at 04:01:52PM +0800, honghui.zhang@mediatek.com wrote:
> > From: Honghui Zhang <honghui.zhang@mediatek.com>
> > 
> > scripts/coccinelle/api/resource_size.cocci complain about the
> > following warning:
> > 
> > pcie-mediatek.c:720:13-16: WARNING: Suspicious code. resource_size is maybe missing with mem
> > 
> > Use resource_size(mem) instead of mem->end - mem->start to eliminate the
> > complain. Since the MMIO window size for both MT2712 and MT7622 are all
> > 0x1000_0000, this change also fix the AHB2PCIe window size smaller than
> > HW MMIO window size issue by change the values of fls(size) from
> > fls(0xfff_ffff) to fls(0x1000_0000).
> 
> Good, I'm glad this actually fixes a bug.  The warning was actually
> useful!
> 
> Since that's the case, the *bug* is the important thing (not the
> warning), and the subject line should be about the bug fix.  The fact
> that it also happens to remove a warning is really just incidental.
> 
> You say "the AHB2PCIe window size smaller than HW MMIO window size
> issue" as though it should be familiar to us.  But it's not :)
> 

Oh, My bad.

The HW design assigned a bus address range(typically start from
0x2000_0000 to 0x2fff_ffff for both mt2712 and mt7622) for PCIe usage.
This means, when CPU or other HW access address in this range, PCIe RC
HW should response to this access. Normally it will translate those
access request to TLPs and send to EP side. Tt's like the total memory
resource which could be allocated by EP's BAR and RC's itself BAR.

Although those address range is available for allocated, but it should
be enabled by this PCIE_AHB_TRANS_BASE register, what size should be
enabled is determined by AHB2PCIE_SIZE bits in this register.

In previous code we did not enable the full size of HW assigned address
range, if the EP's BAR requested size is bigger than the size we enabled
and smaller than the HW available size. The access request from CPU
which address is bigger than the address we enabled but smaller that HW
available address, then RC will block those request and those request
will never get to EP side by TLPs.

Previous code never run into a system error in production because even
half of those range(128MB) is bigger enough for typical EP device's BAR
request(4MB).

But all those HW assigned bus range should be enabled. And it's Okay to
do that. RC will never forward a request to EP when this request is not
suitable for EP's BAR range.


> So the changelog needs to start by explaining what the AHB2PCIe window
> size issue is, mention what user-visible problem that causes, then
> explain how you're fixing it by using resource_size().
> 
> Then you can mention that this also incidentally removes a coccinelle
> warning.
> 

Okay, thanks for your advise.

> Bjorn
> 
> > Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
> > ---
> >  drivers/pci/controller/pcie-mediatek.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> > index 55e471c..01126b8 100644
> > --- a/drivers/pci/controller/pcie-mediatek.c
> > +++ b/drivers/pci/controller/pcie-mediatek.c
> > @@ -654,7 +654,6 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
> >  	struct resource *mem = &pcie->mem;
> >  	const struct mtk_pcie_soc *soc = port->pcie->soc;
> >  	u32 val;
> > -	size_t size;
> >  	int err;
> >  
> >  	/* MT7622 platforms need to enable LTSSM and ASPM from PCIe subsys */
> > @@ -706,8 +705,8 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
> >  		mtk_pcie_enable_msi(port);
> >  
> >  	/* Set AHB to PCIe translation windows */
> > -	size = mem->end - mem->start;
> > -	val = lower_32_bits(mem->start) | AHB2PCIE_SIZE(fls(size));
> > +	val = lower_32_bits(mem->start)
> > +	      | AHB2PCIE_SIZE(fls(resource_size(mem)));
> 
> Nit: I think it's more typical to put the "|" on the first line.

Okay, will update this in next version.

Thanks for your comments.

> 
> >  	writel(val, port->base + PCIE_AHB_TRANS_BASE0_L);
> >  
> >  	val = upper_32_bits(mem->start);
> > -- 
> > 2.6.4
> > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


