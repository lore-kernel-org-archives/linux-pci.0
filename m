Return-Path: <SRS0=JYfi=M4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D88C04EBD
	for <linux-pci@archiver.kernel.org>; Tue, 16 Oct 2018 13:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9979420866
	for <linux-pci@archiver.kernel.org>; Tue, 16 Oct 2018 13:53:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9979420866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbeJPVoG (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 16 Oct 2018 17:44:06 -0400
Received: from foss.arm.com ([217.140.101.70]:36672 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726986AbeJPVoG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 16 Oct 2018 17:44:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A43C80D;
        Tue, 16 Oct 2018 06:53:31 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (unknown [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B0DF73F5B3;
        Tue, 16 Oct 2018 06:53:29 -0700 (PDT)
Date:   Tue, 16 Oct 2018 14:53:24 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Alan Douglas <adouglas@cadence.com>, kishon@ti.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        gustavo.pimentel@synopsys.com, cyrille.pitchen@bootlin.com
Subject: Re: [PATCH v4 4/4] PCI: cadence: Check link is up before sending IRQ
 from EP
Message-ID: <20181016135324.GA16390@e107981-ln.cambridge.arm.com>
References: <1539274617-1661-1-git-send-email-adouglas@cadence.com>
 <20181015213034.GF5906@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181015213034.GF5906@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 15, 2018 at 04:30:35PM -0500, Bjorn Helgaas wrote:
> On Thu, Oct 11, 2018 at 05:16:57PM +0100, Alan Douglas wrote:
> > If EP attempts to send an IRQ (legacy, MSI or MSI-X) while the
> > link is not up, return -EINVAL
> > 
> > Fixes: 37dddf14f1ae ("PCI: cadence: Add EndPoint Controller driver for Cadence PCIe controller")
> > Signed-off-by: Alan Douglas <adouglas@cadence.com>
> > ---
> >  drivers/pci/controller/pcie-cadence-ep.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/pcie-cadence-ep.c b/drivers/pci/controller/pcie-cadence-ep.c
> > index b762214..3667d70 100644
> > --- a/drivers/pci/controller/pcie-cadence-ep.c
> > +++ b/drivers/pci/controller/pcie-cadence-ep.c
> > @@ -370,6 +370,12 @@ static int cdns_pcie_ep_raise_irq(struct pci_epc *epc, u8 fn,
> >  				  u16 interrupt_num)
> >  {
> >  	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
> > +	u32 link_status;
> > +
> > +	/* Can't send an IRQ if the link is down. */
> > +	link_status = cdns_pcie_readl(&ep->pcie, CDNS_PCIE_LM_BASE);
> > +	if (!(link_status & 0x1))
> > +		return -EINVAL;
> 
> This looks racy.  What happens if the link goes down right after the
> CDNS_PCIE_LM_BASE read, but before we get here?

I agree with Bjorn, this check does not seem very useful and honestly
I think this patch should be dropped, I should not have queued it in
the first place.

I wonder whether something can actually be done in the EP subsystem
to handle this in a cleaner way.

Unless I hear a compelling reason to keep it in the patch queue I
would drop this patch.

Lorenzo
