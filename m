Return-Path: <SRS0=vzDi=QP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57ADFC169C4
	for <linux-pci@archiver.kernel.org>; Fri,  8 Feb 2019 10:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EC3A2086C
	for <linux-pci@archiver.kernel.org>; Fri,  8 Feb 2019 10:22:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfBHKW1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 8 Feb 2019 05:22:27 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48024 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbfBHKW1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 Feb 2019 05:22:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF9AFA78;
        Fri,  8 Feb 2019 02:22:26 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 44F5C3F557;
        Fri,  8 Feb 2019 02:22:25 -0800 (PST)
Date:   Fri, 8 Feb 2019 10:22:22 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Murali Karicheri <m-karicheri2@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/9] PCI: dwc: Add support to use non default
 msi_irq_chip
Message-ID: <20190208102222.GB13009@e107981-ln.cambridge.arm.com>
References: <20190207110924.30716-1-kishon@ti.com>
 <20190207110924.30716-7-kishon@ti.com>
 <20190207164853.GD21111@e107981-ln.cambridge.arm.com>
 <ff55a1e9-0998-685f-2d2c-e6cf522b0988@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff55a1e9-0998-685f-2d2c-e6cf522b0988@ti.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 08, 2019 at 10:16:59AM +0530, Kishon Vijay Abraham I wrote:
> Hi Lorenzo,
> 
> On 07/02/19 10:18 PM, Lorenzo Pieralisi wrote:
> > On Thu, Feb 07, 2019 at 04:39:21PM +0530, Kishon Vijay Abraham I wrote:
> >> Platforms using Designware IP uses dw_pci_msi_bottom_irq_chip for
> >> configuring the MSI controller logic within the Designware IP. However
> >> certain platforms like Keystone (K2G) which uses Desingware IP has
> >> it's own MSI controller logic. For handling such platforms,
> >> the irqchip ops uses msi_irq_ack, msi_set_irq, msi_clear_irq callback
> >> functions.
> >>
> >> Add support to use different msi_irq_chip with default as
> >> dw_pci_msi_bottom_irq_chip. This is in preparation to get rid off
> >> msi_irq_ack, msi_set_irq, msi_clear_irq and other Keystone specific
> >> dw_pcie_host_ops. This will also help to get rid of get_msi_addr and
> >> get_msi_data ops.
> >>
> >> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> >> ---
> >>  drivers/pci/controller/dwc/pcie-designware-host.c | 5 ++++-
> >>  drivers/pci/controller/dwc/pcie-designware.h      | 1 +
> >>  2 files changed, 5 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> >> index 721d60a5d9e4..042de09b0451 100644
> >> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> >> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> >> @@ -245,7 +245,7 @@ static int dw_pcie_irq_domain_alloc(struct irq_domain *domain,
> >>  
> >>  	for (i = 0; i < nr_irqs; i++)
> >>  		irq_domain_set_info(domain, virq + i, bit + i,
> >> -				    &dw_pci_msi_bottom_irq_chip,
> >> +				    pp->msi_irq_chip,
> >>  				    pp, handle_edge_irq,
> >>  				    NULL, NULL);
> >>  
> >> @@ -277,6 +277,9 @@ int dw_pcie_allocate_domains(struct pcie_port *pp)
> >>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> >>  	struct fwnode_handle *fwnode = of_node_to_fwnode(pci->dev->of_node);
> >>  
> >> +	if (!pp->msi_irq_chip)
> >> +		pp->msi_irq_chip = &dw_pci_msi_bottom_irq_chip;
> > 
> > I think it is better to initialize pp->msi_irq_chip outside
> > dw_pcie_allocate_domains(), it makes things clearer.
> > 
> > In:
> > 
> > dw_pcie_host_init() for dwc
> > 
> > or
> > 
> > msi_host_init() for platforms with that hook implemented.
> > 
> > Is there any gotcha I am missing ?
> 
> I added here only to avoid breaking "git bisect". Next patch adds
> ks_pcie_msi_irq_chip in msi_host_init of keystone. However till then it has to
> use dw_pci_msi_bottom_irq_chip. Adding anywhere else in dw_pcie_host_init would
> mean msi_irq_chip is uninitialized for keystone.
> 
> Maybe I can add that in the commit log and move it to dw_pcie_host_init?

I do not think you need to mention that in the commit log but move the
initialization of pp->msi_irq_chip in dw_pcie_host_init() in the next
patch, yes.

It is correct to keep bisectability, I should have read ahead.

Lorenzo
