Return-Path: <SRS0=XSei=MI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1037C43382
	for <linux-pci@archiver.kernel.org>; Wed, 26 Sep 2018 09:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 651E020842
	for <linux-pci@archiver.kernel.org>; Wed, 26 Sep 2018 09:07:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 651E020842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbeIZPTR (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 26 Sep 2018 11:19:17 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:58478 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727189AbeIZPTR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Sep 2018 11:19:17 -0400
X-UUID: 2d8760c218b84195a50847fd6a7fac91-20180926
Received: from mtkcas34.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <honghui.zhang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1012302702; Wed, 26 Sep 2018 17:06:59 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 26 Sep
 2018 17:06:58 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 26 Sep 2018 17:06:57 +0800
Message-ID: <1537952817.14753.4.camel@mhfsdcap03>
Subject: Re: [PATCH v4 1/4] PCI: mediatek: fixup mtk_pcie_find_port logical
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
Date:   Wed, 26 Sep 2018 17:06:57 +0800
In-Reply-To: <20180921160745.GB21644@e107981-ln.cambridge.arm.com>
References: <1536573023-6720-1-git-send-email-honghui.zhang@mediatek.com>
         <1536573023-6720-2-git-send-email-honghui.zhang@mediatek.com>
         <20180921160745.GB21644@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 2018-09-21 at 17:07 +0100, Lorenzo Pieralisi wrote:
> On Mon, Sep 10, 2018 at 05:50:20PM +0800, honghui.zhang@mediatek.com wrote:
> > From: Honghui Zhang <honghui.zhang@mediatek.com>
> > 
> > The Mediatek's host controller has two slots, each with it's own control
> > registers. The host driver need to identify which slot was connected
> > in order to access the device's configuration space. There's problem
> > for current host driver to find out which slot was connected to for
> > a given EP device.
> > 
> > Assuming each slot have connect with one EP device as below:
> > 
> >                 host bridge
> >   bus 0 --> __________|_______
> >            |                  |
> >            |                  |
> >          slot 0             slot 1
> >   bus 1 -->|        bus 2 --> |
> >            |                  |
> >          EP 0               EP 1
> > 
> > During PCI enumeration, system software will scan all the PCI device
> > starting from devfn 0. So it will get the proper port for slot0 and
> > slot1 device when using PCI_SLOT(devfn) for match. But it will get
> > the wrong slot for EP1: The devfn will be start from 0 when scanning
> > EP1 behind slot1, it will get port0 since the PCI_SLOT(EP1) is match
> > for port0's slot value. So the host driver should not using EP's devfn
> > but the slot's devfn(the slot which EP was connected to) for match.
> > 
> > This patch fix the mtk_pcie_find_port's logical by using the slot's
> > devfn for match.
> > 
> > Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
> > Acked-by: Ryder Lee <ryder.lee@mediatek.com>
> > ---
> >  drivers/pci/controller/pcie-mediatek.c | 19 +++++++++++++++++--
> >  1 file changed, 17 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> > index 861dda6..20b9088 100644
> > --- a/drivers/pci/controller/pcie-mediatek.c
> > +++ b/drivers/pci/controller/pcie-mediatek.c
> > @@ -337,11 +337,26 @@ static struct mtk_pcie_port *mtk_pcie_find_port(struct pci_bus *bus,
> >  {
> >  	struct mtk_pcie *pcie = bus->sysdata;
> >  	struct mtk_pcie_port *port;
> > +	struct pci_dev *dev;
> > +	struct pci_bus *pbus;
> >  
> > -	list_for_each_entry(port, &pcie->ports, list)
> > -		if (port->slot == PCI_SLOT(devfn))
> > +	list_for_each_entry(port, &pcie->ports, list) {
> > +		if (!bus->number && port->slot == PCI_SLOT(devfn))
> >  			return port;
> >  
> > +		if (bus->number) {
> > +			pbus = bus;
> > +
> > +			while (pbus->number) {
> > +				dev = pbus->self;
> > +				pbus = dev->bus;
> > +			}
> > +
> > +			if (port->slot == PCI_SLOT(dev->devfn))
> > +				return port;
> > +		}
> > +	}
> 
> 	/*
> 	 * Walk the bus hierarchy to get the devfn value
> 	 * of the port in the root bus.
> 	 */
> 	while (bus && bus->number) {
> 		devfn = bus->self->devfn;
> 		bus = bus->parent;
> 	}
> 
> 	list_for_each_entry(port, &pcie->ports, list) {
> 		if (port->slot == PCI_SLOT(devfn))
> 			return port;
> 
> 	return NULL;
> 
> Would it work ? Maybe it is a little easier to parse.
> 

Thanks, this is much better.

> I think this can even be made easier by using struct device_node* as
> comparison (and store it in port->slot instead of the port number), I
> think that the pci_dev representing the port should have the right
> of_node associated with it by core code, so it is just a matter of
> finding the first pci_dev parent with an of_node set and compare it
> against port->slot (that should be converted to a struct device_node*).
> 
> This ought to be tested and written but I think that's doable.
> 

Thanks, I will do my homework and figure a way out through this
solution.
Currently port->slot is used in too much place to be removed, I guess I
need to added a new parameter in the port struct to store the of_node
for compare.
I'm not sure which way is better, anyway, let me try the new solution.

thanks.

> Lorenzo


