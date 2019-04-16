Return-Path: <SRS0=aMvC=SS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A9EC10F13
	for <linux-pci@archiver.kernel.org>; Tue, 16 Apr 2019 13:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B5AF21841
	for <linux-pci@archiver.kernel.org>; Tue, 16 Apr 2019 13:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbfDPNgJ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 16 Apr 2019 09:36:09 -0400
Received: from foss.arm.com ([217.140.101.70]:55074 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727180AbfDPNgJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 16 Apr 2019 09:36:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9394CEBD;
        Tue, 16 Apr 2019 06:36:08 -0700 (PDT)
Received: from red-moon (unknown [10.1.197.39])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 35A6B3F59C;
        Tue, 16 Apr 2019 06:36:06 -0700 (PDT)
Date:   Tue, 16 Apr 2019 14:36:04 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-kernel@axis.com
Subject: Re: [PATCH v2 23/26] PCI: designware-ep: Configure RESBAR to
 advertise the smallest size
Message-ID: <20190416133604.GA14705@red-moon>
References: <20190325083501.8088-1-kishon@ti.com>
 <20190325083501.8088-24-kishon@ti.com>
 <20190413160053.GI126710@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190413160053.GI126710@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Apr 13, 2019 at 11:00:53AM -0500, Bjorn Helgaas wrote:
> On Mon, Mar 25, 2019 at 02:04:58PM +0530, Kishon Vijay Abraham I wrote:
> > Configure RESBAR capability to advertise the smallest size (1MB) for
> > couple of reasons. A) Host side resource allocation of BAR fails for
> > larger sizes. B) Endpoint function driver does not allocate memory
> > for all supported sizes in RESBAR capability.
> > If and when there is a usecase required to add more flexibility using
> > RESBAR, this can be revisited.
> 
> The #define used in the code below is "REBAR"; maybe spell it out
> once and then use REBAR instead of RESBAR?

I think we should just name the capability as it is (Resizable BAR) the
kernel defines are there already anyway. I will rewrite the log
accordingly.

Lorenzo

> > Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> > ---
> >  .../pci/controller/dwc/pcie-designware-ep.c   | 34 +++++++++++++++++++
> >  1 file changed, 34 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > index 74477ad7467f..0c208b9bda43 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > @@ -504,10 +504,32 @@ void dw_pcie_ep_exit(struct dw_pcie_ep *ep)
> >  	pci_epc_mem_exit(epc);
> >  }
> >  
> > +static unsigned int dw_pcie_ep_find_ext_capability(struct dw_pcie *pci, int cap)
> > +{
> > +	u32 header;
> > +	int pos = PCI_CFG_SPACE_SIZE;
> > +
> > +	while (pos) {
> > +		header = dw_pcie_readl_dbi(pci, pos);
> > +		if (PCI_EXT_CAP_ID(header) == cap)
> > +			return pos;
> > +
> > +		pos = PCI_EXT_CAP_NEXT(header);
> > +		if (!pos)
> > +			break;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> >  {
> > +	int i;
> >  	int ret;
> > +	u32 reg;
> >  	void *addr;
> > +	unsigned int nbars;
> > +	unsigned int offset;
> >  	struct pci_epc *epc;
> >  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> >  	struct device *dev = pci->dev;
> > @@ -591,6 +613,18 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> >  
> >  	ep->msix_cap = dw_pcie_ep_find_capability(pci, PCI_CAP_ID_MSIX);
> >  
> > +	offset = dw_pcie_ep_find_ext_capability(pci, PCI_EXT_CAP_ID_REBAR);
> > +	if (offset) {
> > +		reg = dw_pcie_readl_dbi(pci, offset + PCI_REBAR_CTRL);
> > +		nbars = (reg & PCI_REBAR_CTRL_NBAR_MASK) >>
> > +			PCI_REBAR_CTRL_NBAR_SHIFT;
> > +
> > +		dw_pcie_dbi_ro_wr_en(pci);
> > +		for (i = 0; i < nbars; i++, offset += PCI_REBAR_CTRL)
> > +			dw_pcie_writel_dbi(pci, offset + PCI_REBAR_CAP, 0x0);
> > +		dw_pcie_dbi_ro_wr_dis(pci);
> > +	}
> > +
> >  	dw_pcie_setup(pci);
> >  
> >  	return 0;
> > -- 
> > 2.17.1
> > 
