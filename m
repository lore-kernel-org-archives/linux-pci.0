Return-Path: <SRS0=j7M/=MU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5976FC6787E
	for <linux-pci@archiver.kernel.org>; Mon,  8 Oct 2018 03:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 156D620834
	for <linux-pci@archiver.kernel.org>; Mon,  8 Oct 2018 03:02:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 156D620834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbeJHKMX (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 8 Oct 2018 06:12:23 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:48095 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725760AbeJHKMX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Oct 2018 06:12:23 -0400
X-UUID: 011a7058029c4c6a960bbd9c2bd86b2f-20181008
X-UUID: 011a7058029c4c6a960bbd9c2bd86b2f-20181008
Received: from mtkcas35.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
        (envelope-from <honghui.zhang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 2089238376; Mon, 08 Oct 2018 11:02:22 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 8 Oct
 2018 11:02:19 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 8 Oct 2018 11:02:17 +0800
Message-ID: <1538967737.6246.5.camel@mhfsdcap03>
Subject: Re: [PATCH v5 1/9] PCI: mediatek: Using slot's devfn for compare to
 fix mtk_pcie_find_port logic
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
Date:   Mon, 8 Oct 2018 11:02:17 +0800
In-Reply-To: <20181002105945.GA27736@e107981-ln.cambridge.arm.com>
References: <1538129080-8206-1-git-send-email-honghui.zhang@mediatek.com>
         <1538129080-8206-2-git-send-email-honghui.zhang@mediatek.com>
         <20181001143641.GB13049@red-moon>
         <20181002105945.GA27736@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 2018-10-02 at 11:59 +0100, Lorenzo Pieralisi wrote:
> On Mon, Oct 01, 2018 at 03:36:41PM +0100, Lorenzo Pieralisi wrote:
> > On Fri, Sep 28, 2018 at 06:04:32PM +0800, honghui.zhang@mediatek.com wrote:
> > > From: Honghui Zhang <honghui.zhang@mediatek.com>
> > > 
> > > The Mediatek's host controller has two slots, each with it's own control
> > > registers. The host driver need to identify which slot was connected
> > > in order to access the device's configuration space. There's problem
> > > for current host driver to find out which slot was connected to for
> > > a given EP device.
> > > 
> > > Assuming each slot have connect with one EP device as below:
> > > 
> > >                 host bridge
> > >   bus 0 --> __________|_______
> > >            |                  |
> > >            |                  |
> > >          slot 0             slot 1
> > >   bus 1 -->|        bus 2 --> |
> > >            |                  |
> > >          EP 0               EP 1
> > > 
> > > During PCI enumeration, system software will scan all the PCI device
> > > starting from devfn 0. So it will get the proper port for slot0 and
> > > slot1 device when using PCI_SLOT(devfn) for match. But it will get
> > > the wrong slot for EP1: The devfn will be start from 0 when scanning
> > > EP1 behind slot1, it will get port0 since the PCI_SLOT(EP1) is match
> > > for port0's slot value. So the host driver should not using EP's devfn
> > > but the slot's devfn(the slot which EP was connected to) for match.
> > > 
> > > This patch fix the mtk_pcie_find_port's logic by using the slot's
> > > devfn for match if finding device connected to the subordinate bus.
> > > 
> > > Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
> > > ---
> > >  drivers/pci/controller/pcie-mediatek.c | 17 ++++++++++++++++-
> > >  1 file changed, 16 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> > > index 9999dae..264e03f 100644
> > > --- a/drivers/pci/controller/pcie-mediatek.c
> > > +++ b/drivers/pci/controller/pcie-mediatek.c
> > > @@ -337,10 +337,25 @@ static struct mtk_pcie_port *mtk_pcie_find_port(struct pci_bus *bus,
> > >  {
> > >  	struct mtk_pcie *pcie = bus->sysdata;
> > >  	struct mtk_pcie_port *port;
> > > +	struct pci_dev *dev = NULL;
> > > +
> > > +	/*
> > > +	 * Walk the bus hierarchy to get the devfn value
> > > +	 * of the port in the root bus.
> > > +	 */
> > > +	while (bus && bus->number) {
> > > +		dev = bus->self;
> > > +		bus = dev->bus;
> > 
> > If you add:
> > 
> > devfn = dev->devfn;
> > 
> > here
> > 
> > > +	}
> > > +
> > > +	list_for_each_entry(port, &pcie->ports, list) {
> > > +		/* Using slot's devfn to compare for subordinary bus. */
> > > +		if (dev)
> > > +			devfn = dev->devfn;
> > 
> > You can remove this ugly hunk altogether (and dev initialization
> > to NULL).
> 
> Hi Honghui,
> 
> if you can make this change I would merge this series, it has been
> been in the mailing lists for a while, I can make that change too
> just let me know please.
> 

Hi, Lorenzo, sorry for the late reply.

I tried your advise and it works fine.

I will send another version to fix this, as well as to add a fix tag in
the commit message of patch 6.

thanks

> Thanks,
> Lorenzo


