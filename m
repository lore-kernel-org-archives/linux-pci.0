Return-Path: <SRS0=286E=MV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09936C00449
	for <linux-pci@archiver.kernel.org>; Tue,  9 Oct 2018 03:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B67E82075E
	for <linux-pci@archiver.kernel.org>; Tue,  9 Oct 2018 03:08:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B67E82075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725828AbeJIKXQ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 9 Oct 2018 06:23:16 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:21647 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725749AbeJIKXQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Oct 2018 06:23:16 -0400
X-UUID: 5096bdfdada14104b1f0fd2f11514021-20181009
X-UUID: 5096bdfdada14104b1f0fd2f11514021-20181009
Received: from mtkcas32.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <honghui.zhang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 746380465; Tue, 09 Oct 2018 11:08:17 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 9 Oct
 2018 11:08:16 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 9 Oct 2018 11:08:15 +0800
Message-ID: <1539054495.6246.31.camel@mhfsdcap03>
Subject: Re: [PATCH v6 2/9] PCI: mediatek: Fixup class ID for MT7622 as
 PCI_CLASS_BRIDGE_PCI
From:   Honghui Zhang <honghui.zhang@mediatek.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     <bhelgaas@google.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ryder.lee@mediatek.com>,
        <ulf.hansson@linaro.org>, <marc.zyngier@arm.com>,
        <matthias.bgg@gmail.com>, <devicetree@vger.kernel.org>,
        <yingjoe.chen@mediatek.com>, <eddie.huang@mediatek.com>,
        <youlin.pei@mediatek.com>, <yt.shen@mediatek.com>,
        <sean.wang@mediatek.com>
Date:   Tue, 9 Oct 2018 11:08:15 +0800
In-Reply-To: <20181008172337.GA13538@e107981-ln.cambridge.arm.com>
References: <1538969088-7136-1-git-send-email-honghui.zhang@mediatek.com>
         <1538969088-7136-3-git-send-email-honghui.zhang@mediatek.com>
         <20181008172337.GA13538@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 2018-10-08 at 18:23 +0100, Lorenzo Pieralisi wrote:
> On Mon, Oct 08, 2018 at 11:24:41AM +0800, honghui.zhang@mediatek.com wrote:
> > From: Honghui Zhang <honghui.zhang@mediatek.com>
> > 
> > The PCIe controller of MT7622 has TYPE 1 configuration space type, but
> > the HW default class type values is invalid.
> > 
> > The commit 101c92dc80c8 ("PCI: mediatek: Set up vendor ID and class
> > type for MT7622") have set the class ID for MT7622 as
> > PCI_CLASS_BRIDGE_HOST, but it's not workable for MT7622:
> > 
> > In __pci_bus_assign_resources, the framework only setup bridge's
> > resource window only if class type is PCI_CLASS_BRIDGE_PCI. Or it
> > will leave the subordinary PCIe device's MMIO window un-touched.
> > 
> > Fixup the class type to PCI_CLASS_BRIDGE_PCI as most of the controller
> > driver do.
> 
> I think that this patch is correct but the commit log fails to pin point
> the problem. The IP you are programming is a root port, that's why you
> have to have the proper class code, the patch looks fine but I would
> like to peek Bjorn's brain on this since it is a fundamental concept.
> 

I'm a bit confused with the concepts of PCI_CLASS_BRIDGE_HOST and
PCI_CLASS_BRIDGE_PCI, from PCI express spec,
4.0r1.0(PCI_Express_Base_4.0r1.0_September-27-2017-c), Host Bridge is
"part of a Root Complex that connects a host CPU or CPUs to a
Hierarchy". While Root Complex defines as "A defined System Element that
includes at least one Host Bridge, Root port, or Root complex Integrated
Endpoint".

But according to my understanding, most of the root port IPs integrated
with a "PCI_CLASS_BRIDGE_PCI", which has type 1 configuration space and
could be saw as a pci device when using lspci.

And for MT7622, it integrated with block of internal control registers,
type 1 configuration space, and is considered as a root complex.

I'm not sure which CLASS type it should have:
From PCI_Code-ID_r_1_10__v8-Nov_2017, class type of
0x0604(PCI_CLASS_BRIDGE_PCI) is defined as a PCI-to-PCI bridge, not
literally suitable for MT7622(which is a root complex)(In my personal
opinion). But it is the only workable CLASS type for MT7622 in current
kernel.

> If the kernel does not assign resources unless it detects a
> PCI_CLASS_BRIDGE_PCI this means that for components that are
> actually PCI_CLASS_BRIDGE_HOST their register set must come
> preprogrammed unless I am missing something.
> 

In the function pci_request_resource_alignment, it will by pass the
resource assignment for PCI_CLASS_BRIDGE_HOST, though I'm not figured
out why.

> I would like to get to the bottom of this since it is a fundamental
> enumeration concept.
> 

Do you like me to re-write the commit message for this patch and put the
above information in? Or just not mention the PCI_CLASS_BRIDGE_HOST
assign resource routine?

Thanks

> Thanks,
> Lorenzo
> 
> > 
> > Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
> > Acked-by: Ryder Lee <ryder.lee@mediatek.com>
> > ---
> >  drivers/pci/controller/pcie-mediatek.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> > index 288b8e2..bcdac9b 100644
> > --- a/drivers/pci/controller/pcie-mediatek.c
> > +++ b/drivers/pci/controller/pcie-mediatek.c
> > @@ -432,7 +432,7 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
> >  		val = PCI_VENDOR_ID_MEDIATEK;
> >  		writew(val, port->base + PCIE_CONF_VEND_ID);
> >  
> > -		val = PCI_CLASS_BRIDGE_HOST;
> > +		val = PCI_CLASS_BRIDGE_PCI;
> >  		writew(val, port->base + PCIE_CONF_CLASS_ID);
> >  	}
> >  
> > -- 
> > 2.6.4
> > 


