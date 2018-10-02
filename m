Return-Path: <SRS0=XHdA=MO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5135EC43143
	for <linux-pci@archiver.kernel.org>; Tue,  2 Oct 2018 10:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 089E1208AE
	for <linux-pci@archiver.kernel.org>; Tue,  2 Oct 2018 10:59:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 089E1208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbeJBRmf (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 2 Oct 2018 13:42:35 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34434 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726244AbeJBRmf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Oct 2018 13:42:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F8AE7A9;
        Tue,  2 Oct 2018 03:59:53 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.Emea.Arm.com [10.4.13.117])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 88C2E3F5B7;
        Tue,  2 Oct 2018 03:59:50 -0700 (PDT)
Date:   Tue, 2 Oct 2018 11:59:45 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     honghui.zhang@mediatek.com
Cc:     bhelgaas@google.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryder.lee@mediatek.com,
        ulf.hansson@linaro.org, marc.zyngier@arm.com,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        yingjoe.chen@mediatek.com, eddie.huang@mediatek.com,
        youlin.pei@mediatek.com, yt.shen@mediatek.com,
        sean.wang@mediatek.com
Subject: Re: [PATCH v5 1/9] PCI: mediatek: Using slot's devfn for compare to
 fix mtk_pcie_find_port logic
Message-ID: <20181002105945.GA27736@e107981-ln.cambridge.arm.com>
References: <1538129080-8206-1-git-send-email-honghui.zhang@mediatek.com>
 <1538129080-8206-2-git-send-email-honghui.zhang@mediatek.com>
 <20181001143641.GB13049@red-moon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181001143641.GB13049@red-moon>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 01, 2018 at 03:36:41PM +0100, Lorenzo Pieralisi wrote:
> On Fri, Sep 28, 2018 at 06:04:32PM +0800, honghui.zhang@mediatek.com wrote:
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
> > This patch fix the mtk_pcie_find_port's logic by using the slot's
> > devfn for match if finding device connected to the subordinate bus.
> > 
> > Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
> > ---
> >  drivers/pci/controller/pcie-mediatek.c | 17 ++++++++++++++++-
> >  1 file changed, 16 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> > index 9999dae..264e03f 100644
> > --- a/drivers/pci/controller/pcie-mediatek.c
> > +++ b/drivers/pci/controller/pcie-mediatek.c
> > @@ -337,10 +337,25 @@ static struct mtk_pcie_port *mtk_pcie_find_port(struct pci_bus *bus,
> >  {
> >  	struct mtk_pcie *pcie = bus->sysdata;
> >  	struct mtk_pcie_port *port;
> > +	struct pci_dev *dev = NULL;
> > +
> > +	/*
> > +	 * Walk the bus hierarchy to get the devfn value
> > +	 * of the port in the root bus.
> > +	 */
> > +	while (bus && bus->number) {
> > +		dev = bus->self;
> > +		bus = dev->bus;
> 
> If you add:
> 
> devfn = dev->devfn;
> 
> here
> 
> > +	}
> > +
> > +	list_for_each_entry(port, &pcie->ports, list) {
> > +		/* Using slot's devfn to compare for subordinary bus. */
> > +		if (dev)
> > +			devfn = dev->devfn;
> 
> You can remove this ugly hunk altogether (and dev initialization
> to NULL).

Hi Honghui,

if you can make this change I would merge this series, it has been
been in the mailing lists for a while, I can make that change too
just let me know please.

Thanks,
Lorenzo
