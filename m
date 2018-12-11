Return-Path: <SRS0=NFOj=OU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0169C07E85
	for <linux-pci@archiver.kernel.org>; Tue, 11 Dec 2018 14:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B9B920849
	for <linux-pci@archiver.kernel.org>; Tue, 11 Dec 2018 14:41:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B9B920849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbeLKOlE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 11 Dec 2018 09:41:04 -0500
Received: from foss.arm.com ([217.140.101.70]:48672 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbeLKOlE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 11 Dec 2018 09:41:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A9B9A1596;
        Tue, 11 Dec 2018 06:41:03 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B6563F575;
        Tue, 11 Dec 2018 06:41:01 -0800 (PST)
Date:   Tue, 11 Dec 2018 14:40:59 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     "Z.q. Hou" <zhiqiang.hou@nxp.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        Roy Zang <roy.zang@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>
Subject: Re: [PATCHv2 2/4] PCI: dwc: fix 4GiB outbound window size truncated
 to zero issue
Message-ID: <20181211144059.GB526@e107981-ln.cambridge.arm.com>
References: <20181107100854.28389-1-Zhiqiang.Hou@nxp.com>
 <20181107100854.28389-3-Zhiqiang.Hou@nxp.com>
 <20181205160153.GA18567@e107981-ln.cambridge.arm.com>
 <AM6PR04MB57813C419469B58F3C7DC37C84A90@AM6PR04MB5781.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR04MB57813C419469B58F3C7DC37C84A90@AM6PR04MB5781.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 06, 2018 at 01:25:17AM +0000, Z.q. Hou wrote:
> Hi Lorenzo,
> 
> Thanks a lot for your comments!
> 
> > -----Original Message-----
> > From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Sent: 2018??12??6?? 0:02
> > To: Z.q. Hou <zhiqiang.hou@nxp.com>
> > Cc: linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org;
> > bhelgaas@google.com; jingoohan1@gmail.com;
> > gustavo.pimentel@synopsys.com; Roy Zang <roy.zang@nxp.com>; Mingkai Hu
> > <mingkai.hu@nxp.com>; M.h. Lian <minghuan.lian@nxp.com>
> > Subject: Re: [PATCHv2 2/4] PCI: dwc: fix 4GiB outbound window size
> > truncated to zero issue
> > 
> > On Wed, Nov 07, 2018 at 10:09:10AM +0000, Z.q. Hou wrote:
> > > From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > >
> > > The current type of mem_size is 'u32', so when resource_size() return
> > > 4G it will be truncated to zero. This patch fix it by changing its
> > > type to 'u64'.
> > >
> > > Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > > Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> > > ---
> > > V2:
> > >  - Reworded the subject.
> > >
> > >  drivers/pci/controller/dwc/pcie-designware.c | 4 ++--
> > > drivers/pci/controller/dwc/pcie-designware.h | 4 ++--
> > >  2 files changed, 4 insertions(+), 4 deletions(-)
> > 
> > I would like to add a Fixes: tag.
> > 
> > is
> > 
> > edd45e396829 ("PCI: dwc: designware: Move _unroll configurations to a
> > separate function")
> > 
> > the commit you are fixing ?
> 
> Yes, will add the Fixes, and I think it fixes the original patch: 340cba6092c2 ("pci: Add PCIe driver for Samsung Exynos").

I will add it myself.

Thanks,
Lorenzo

> > Thanks,
> > Lorenzo
> > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware.c
> > > b/drivers/pci/controller/dwc/pcie-designware.c
> > > index 2153956a0b20..7ac5989c23ef 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > > @@ -106,7 +106,7 @@ static void dw_pcie_writel_ob_unroll(struct
> > > dw_pcie *pci, u32 index, u32 reg,
> > >
> > >  static void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, int
> > index,
> > >  					     int type, u64 cpu_addr,
> > > -					     u64 pci_addr, u32 size)
> > > +					     u64 pci_addr, u64 size)
> > >  {
> > >  	u32 retries, val;
> > >
> > > @@ -141,7 +141,7 @@ static void
> > > dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, int index,  }
> > >
> > >  void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
> > > -			       u64 cpu_addr, u64 pci_addr, u32 size)
> > > +			       u64 cpu_addr, u64 pci_addr, u64 size)
> > >  {
> > >  	u32 retries, val;
> > >
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware.h
> > > b/drivers/pci/controller/dwc/pcie-designware.h
> > > index 9f1a5e399b70..a438c3879aa9 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > > @@ -153,7 +153,7 @@ struct pcie_port {
> > >  	u32			io_size;
> > >  	u64			mem_base;
> > >  	phys_addr_t		mem_bus_addr;
> > > -	u32			mem_size;
> > > +	u64			mem_size;
> > >  	struct resource		*cfg;
> > >  	struct resource		*io;
> > >  	struct resource		*mem;
> > > @@ -238,7 +238,7 @@ int dw_pcie_link_up(struct dw_pcie *pci);  int
> > > dw_pcie_wait_for_link(struct dw_pcie *pci);  void
> > > dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index,
> > >  			       int type, u64 cpu_addr, u64 pci_addr,
> > > -			       u32 size);
> > > +			       u64 size);
> > >  int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int bar,
> > >  			     u64 cpu_addr, enum dw_pcie_as_type as_type);  void
> > > dw_pcie_disable_atu(struct dw_pcie *pci, int index,
> > > --
> > > 2.17.1
> > >
> 
> Thanks,
> Zhiqiang
