Return-Path: <SRS0=vmzI=QL=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFBB3C282C4
	for <linux-pci@archiver.kernel.org>; Mon,  4 Feb 2019 12:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5C0E2082F
	for <linux-pci@archiver.kernel.org>; Mon,  4 Feb 2019 12:27:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730463AbfBDM1u (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 4 Feb 2019 07:27:50 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55030 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729681AbfBDM1u (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 Feb 2019 07:27:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 783CA15AB;
        Mon,  4 Feb 2019 04:27:49 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CEAD33F675;
        Mon,  4 Feb 2019 04:27:47 -0800 (PST)
Date:   Mon, 4 Feb 2019 12:27:45 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Stefan Agner <stefan@agner.ch>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        l.stach@pengutronix.de, tpiepho@impinj.com,
        leonard.crestez@nxp.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] PCI: dwc: allow to limit registers set length
Message-ID: <20190204122744.GB16219@e107981-ln.cambridge.arm.com>
References: <20181204165528.15534-1-stefan@agner.ch>
 <20190130175415.GA7715@e107981-ln.cambridge.arm.com>
 <f4f731d928293406e093ae9b23583510@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4f731d928293406e093ae9b23583510@agner.ch>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 31, 2019 at 10:08:11AM +0100, Stefan Agner wrote:
> On 30.01.2019 18:54, Lorenzo Pieralisi wrote:
> > On Tue, Dec 04, 2018 at 05:55:26PM +0100, Stefan Agner wrote:
> >> Add length to the struct dw_pcie and check that the accessors
> >> dw_pcie_(rd|wr)_conf() do not read/write beyond that point.
> >>
> >> Suggested-by: Trent Piepho <tpiepho@impinj.com>
> >> Signed-off-by: Stefan Agner <stefan@agner.ch>
> >> ---
> >> Changes in v4:
> >> - Move length check to dw_pcie_rd_conf
> >>
> >>  .../pci/controller/dwc/pcie-designware-host.c    | 16 ++++++++++++++--
> >>  drivers/pci/controller/dwc/pcie-designware.h     |  1 +
> >>  2 files changed, 15 insertions(+), 2 deletions(-)
> > 
> > Hi Stefan,
> > 
> > I wanted to ask you if this series should be considered for v5.1
> > inclusion, it is in the PCI backlog. If it is, let me have a look
> > and if it is OK to go I will likely ask you to rebase it.
> 
> Yes please. With this last change I did not see any regression anymore
> so far.
> 
> Andrey Smirnov picked up the second patch: "PCI: imx6: introduce
> drvdata". Not sure what the plan is with his patchset, if it gets merged
> into v5.1 too then I probably better drop this patch and rebase ontop of
> his series.

You can now rebase it on top of my pci/dwc branch and send a v5, I
will mark this series as superseded in the PCI patch queue.

Lorenzo

> Stefan
> 
> > 
> > Thanks,
> > Lorenzo
> > 
> >> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> >> index 692dd1b264fb..9fc0f7bd99f0 100644
> >> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> >> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> >> @@ -606,14 +606,20 @@ static int dw_pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
> >>  			   int size, u32 *val)
> >>  {
> >>  	struct pcie_port *pp = bus->sysdata;
> >> +	struct dw_pcie *pci;
> >>
> >>  	if (!dw_pcie_valid_device(pp, bus, PCI_SLOT(devfn))) {
> >>  		*val = 0xffffffff;
> >>  		return PCIBIOS_DEVICE_NOT_FOUND;
> >>  	}
> >>
> >> -	if (bus->number == pp->root_bus_nr)
> >> +	if (bus->number == pp->root_bus_nr) {
> >> +		pci = to_dw_pcie_from_pp(pp);
> >> +		if (pci->dbi_length && where + size > pci->dbi_length)
> >> +			return PCIBIOS_BAD_REGISTER_NUMBER;
> >> +
> >>  		return dw_pcie_rd_own_conf(pp, where, size, val);
> >> +	}
> >>
> >>  	return dw_pcie_rd_other_conf(pp, bus, devfn, where, size, val);
> >>  }
> >> @@ -622,12 +628,18 @@ static int dw_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
> >>  			   int where, int size, u32 val)
> >>  {
> >>  	struct pcie_port *pp = bus->sysdata;
> >> +	struct dw_pcie *pci;
> >>
> >>  	if (!dw_pcie_valid_device(pp, bus, PCI_SLOT(devfn)))
> >>  		return PCIBIOS_DEVICE_NOT_FOUND;
> >>
> >> -	if (bus->number == pp->root_bus_nr)
> >> +	if (bus->number == pp->root_bus_nr) {
> >> +		pci = to_dw_pcie_from_pp(pp);
> >> +		if (pci->dbi_length && where + size > pci->dbi_length)
> >> +			return PCIBIOS_BAD_REGISTER_NUMBER;
> >> +
> >>  		return dw_pcie_wr_own_conf(pp, where, size, val);
> >> +	}
> >>
> >>  	return dw_pcie_wr_other_conf(pp, bus, devfn, where, size, val);
> >>  }
> >> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> >> index 9943d8c68335..9cd7bdc94200 100644
> >> --- a/drivers/pci/controller/dwc/pcie-designware.h
> >> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> >> @@ -229,6 +229,7 @@ struct dw_pcie {
> >>  	void __iomem		*dbi_base2;
> >>  	/* Used when iatu_unroll_enabled is true */
> >>  	void __iomem		*atu_base;
> >> +	int			dbi_length;
> >>  	u32			num_viewport;
> >>  	u8			iatu_unroll_enabled;
> >>  	struct pcie_port	pp;
> >> --
> >> 2.19.1
> >>
