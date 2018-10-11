Return-Path: <SRS0=UcfF=MX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F0FC32788
	for <linux-pci@archiver.kernel.org>; Thu, 11 Oct 2018 13:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97C6620652
	for <linux-pci@archiver.kernel.org>; Thu, 11 Oct 2018 13:40:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97C6620652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbeJKVHS (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Oct 2018 17:07:18 -0400
Received: from foss.arm.com ([217.140.101.70]:37552 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727056AbeJKVHS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Oct 2018 17:07:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CCF321596;
        Thu, 11 Oct 2018 06:40:03 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A0D43F5BC;
        Thu, 11 Oct 2018 06:40:02 -0700 (PDT)
Date:   Thu, 11 Oct 2018 14:39:59 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Alan Douglas <adouglas@cadence.com>
Cc:     "kishon@ti.com" <kishon@ti.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "cyrille.pitchen@bootlin.com" <cyrille.pitchen@bootlin.com>
Subject: Re: [PATCH v3 5/5] PCI: cadence: Add MSI-X capability to EP driver
Message-ID: <20181011133959.GB3574@e107981-ln.cambridge.arm.com>
References: <1537284105-23519-1-git-send-email-adouglas@cadence.com>
 <20180920101516.GA838@e107981-ln.cambridge.arm.com>
 <MWHPR07MB350242FB438E947E62C3A684D8130@MWHPR07MB3502.namprd07.prod.outlook.com>
 <BN6PR07MB3491660B49601BD32F412E92D8160@BN6PR07MB3491.namprd07.prod.outlook.com>
 <MWHPR07MB3502A33F294B978C1045176ED8E10@MWHPR07MB3502.namprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR07MB3502A33F294B978C1045176ED8E10@MWHPR07MB3502.namprd07.prod.outlook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 11, 2018 at 12:27:22PM +0000, Alan Douglas wrote:
> Hi Lorenzo,
> 
> I need to make significant changes to PATCH 5/5 in this series, 
> this is the patch that actually adds the MSI-X support.  
> The  memory region to use for MSI-X BAR should be part of
> the EP resources, so I need to make some changes to device tree
> bindings.
> 
> Patches 1,2,3 and 4 will be unchanged, and are fixes, so 
> does it cause you any problem if I move these to a separate
> patch series so that they are not tied to the MSI-X implementation?

Do you want me to pull (1,2,3,4) as they are so that you can send
patch 5 standalone ?

Lorenzo

> 
> Regards,
> Alan
> On  25 September 2018 16:19, Alan Douglas wrote:
> > On 20 September 2018 17:12, Alan Douglas wrote:
> > > To: 'Lorenzo Pieralisi' <lorenzo.pieralisi@arm.com>
> > > Cc: kishon@ti.com; bhelgaas@google.com; linux-pci@vger.kernel.org; gustavo.pimentel@synopsys.com; cyrille.pitchen@bootlin.com
> > > Subject: RE: [PATCH v3 5/5] PCI: cadence: Add MSI-X capability to EP driver
> > >
> > > Hi,
> > > On 20 September 2018 11:15, Lorenzo Pieralisi wrote:
> > > > On Tue, Sep 18, 2018 at 04:21:45PM +0100, Alan Douglas wrote:
> > > > > Add set_msix and get_msix functions to driver, and handle
> > > > > PCI_EPC_IRQ_MSIX request in raise_irq.  BAR4 is used for
> > > > > the MSI-X vectors.
> > > >
> > > > https://marc.info/?l=linux-pci&m=150905742808166&w=2
> > > >
> > > I will add more explanation in v4, and check for other issues I missed.
> > >
> > > >
> > > > > Signed-off-by: Alan Douglas <adouglas@cadence.com>
> > > > > ---
> > > > >  drivers/pci/controller/pcie-cadence-ep.c | 129 ++++++++++++++++++++++++++++++-
> > > > >  drivers/pci/controller/pcie-cadence.h    |   7 ++
> > > > >  2 files changed, 135 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/pci/controller/pcie-cadence-ep.c b/drivers/pci/controller/pcie-cadence-ep.c
> > > > > index 1248d75..dbe76ab 100644
> > > > > --- a/drivers/pci/controller/pcie-cadence-ep.c
> > > > > +++ b/drivers/pci/controller/pcie-cadence-ep.c
> > > > > @@ -16,6 +16,7 @@
> > > > >  #define CDNS_PCIE_EP_MIN_APERTURE		128	/* 128 bytes */
> > > > >  #define CDNS_PCIE_EP_IRQ_PCI_ADDR_NONE		0x1
> > > > >  #define CDNS_PCIE_EP_IRQ_PCI_ADDR_LEGACY	0x3
> > > > > +#define CDNS_PCIE_EP_MSIX_BAR			0x4
> > > > >
> > > > >  /**
> > > > >   * struct cdns_pcie_ep - private data for this PCIe endpoint controller driver
> > > > > @@ -255,6 +256,65 @@ static int cdns_pcie_ep_get_msi(struct pci_epc *epc, u8 fn)
> > > > >  	return mme;
> > > > >  }
> > > > >
> > > > > +static int cdns_pcie_ep_get_msix(struct pci_epc *epc, u8 func_no)
> > > > > +{
> > > > > +	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
> > > > > +	struct cdns_pcie *pcie = &ep->pcie;
> > > > > +	u32 cap = CDNS_PCIE_EP_FUNC_MSIX_CAP_OFFSET;
> > > > > +	u32 val, reg;
> > > > > +
> > > > > +	reg = cap + PCI_MSIX_FLAGS;
> > > > > +	val = cdns_pcie_ep_fn_readw(pcie, func_no, reg);
> > > > > +	if (!(val & PCI_MSIX_FLAGS_ENABLE))
> > > > > +		return -EINVAL;
> > > > > +
> > > > > +	val &= PCI_MSIX_FLAGS_QSIZE;
> > > > > +
> > > > > +	return val;
> > > > > +}
> > > > > +
> > > > > +static int cdns_pcie_ep_set_msix(struct pci_epc *epc, u8 fn, u16 interrupts)
> > > > > +{
> > > > > +	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
> > > > > +	struct cdns_pcie *pcie = &ep->pcie;
> > > > > +	u32 cap = CDNS_PCIE_EP_FUNC_MSIX_CAP_OFFSET;
> > > > > +	u32 val, reg, tblsize, b, cfg, ap, ctrl;
> > > > > +
> > > > > +	/* Check that the BAR has already been configured, and is large
> > > > > +	 * enough, and fail if not.
> > > > > +	 */
> > > > > +	b = CDNS_PCIE_EP_MSIX_BAR;
> > > > > +	if (b < BAR_4)
> > > > > +		reg = CDNS_PCIE_LM_EP_FUNC_BAR_CFG0(fn);
> > > > > +	else
> > > > > +		reg = CDNS_PCIE_LM_EP_FUNC_BAR_CFG1(fn);
> > > > > +	cfg = cdns_pcie_readl(pcie, reg);
> > > > > +	ctrl = CDNS_PCIE_LM_EP_FUNC_BAR_CFG_VAL(b, cfg);
> > > > > +	if (!(ctrl & CDNS_PCIE_LM_BAR_CFG_CTRL_MEM_32BITS))
> > > > > +		return -EINVAL;
> > > > > +	ap = CDNS_PCIE_LM_EP_FUNC_BAR_APERTURE_VAL(b, cfg);
> > > > > +	tblsize = fls64(interrupts * 32 - 1);
> > > > > +	/* Need (1<<tblsize)*2 bytes for vector table + PBA table */
> > > > > +	if (ap + 6 <  tblsize)
> > > >
> > > > This is cryptic, you have to explain what it does (inclusive of that
> > > > hardcoded 6 value).
> > > >
> > > I'll expand that, and replace 6 with (CDNS_PCIE_EP_MIN_APERTURE - 1)
> > > I mean that the BAR has to be at least twice the size of the vector table,
> > > to allow for PBA as well.  BAR size is 2^(aperture + 7)
> > >
> > > > > +		return -EINVAL;
> > > > > +
> > > > > +	reg = cap + PCI_MSIX_FLAGS;
> > > > > +	val = cdns_pcie_ep_fn_readw(pcie, fn, reg);
> > > > > +	val &= ~PCI_MSIX_FLAGS_QSIZE;
> > > > > +	val |= interrupts;
> > > > > +	cdns_pcie_ep_fn_writew(pcie, fn, reg, val);
> > > > > +
> > > > > +	/* Set MSIX BAR and offset */
> > > > > +	reg = cap + PCI_MSIX_TABLE;
> > > > > +	cdns_pcie_ep_fn_writel(pcie, fn, reg, b);
> > > > > +
> > > > > +	/* Set PBA BAR and offset.  BAR must match MSIX BAR */
> > > > > +	reg = cap + PCI_MSIX_PBA;
> > > > > +	cdns_pcie_ep_fn_writel(pcie, fn, reg, (1UL << tblsize) | b);
> > > > > +
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > > > >  static void cdns_pcie_ep_assert_intx(struct cdns_pcie_ep *ep, u8 fn,
> > > > >  				     u8 intx, bool is_asserted)
> > > > >  {
> > > > > @@ -366,8 +426,69 @@ static int cdns_pcie_ep_send_msi_irq(struct cdns_pcie_ep *ep, u8 fn,
> > > > >  	return 0;
> > > > >  }
> > > > >
> > > > > +static int cdns_pcie_ep_send_msix_irq(struct cdns_pcie_ep *ep, u8 fn,
> > > > > +				      u16 interrupt_num)
> > > > > +{
> > > > > +	struct cdns_pcie *pcie = &ep->pcie;
> > > > > +	u32 cap = CDNS_PCIE_EP_FUNC_MSIX_CAP_OFFSET;
> > > > > +	u16 flags;
> > > > > +	u64 pci_addr_mask = 0xff;
> > > > > +	u16 tbl_offset = 0;
> > > > > +	u32 bar_addr_upper, bar_addr_lower;
> > > > > +	u32 msg_addr_upper, msg_addr_lower;
> > > > > +	u32 msg_data;
> > > > > +	u64 tbl_addr, msg_addr;
> > > > > +	void __iomem *msix_tbl;
> > > > > +
> > > > > +	/* Check whether the MSI-X feature has been enabled by the PCI host. */
> > > > > +	flags = cdns_pcie_ep_fn_readw(pcie, fn, cap + PCI_MSIX_FLAGS);
> > > > > +	if (!(flags & PCI_MSIX_FLAGS_ENABLE))
> > > > > +		return -EINVAL;
> > > > > +	/* We want local address, not address on host. Table is at offset 0 */
> > > > > +	bar_addr_lower = cdns_pcie_readl(pcie,
> > > > > +		CDNS_PCIE_AT_IB_EP_FUNC_BAR_ADDR0(fn, CDNS_PCIE_EP_MSIX_BAR));
> > > > > +	bar_addr_upper = cdns_pcie_readl(pcie,
> > > > > +		CDNS_PCIE_AT_IB_EP_FUNC_BAR_ADDR1(fn, CDNS_PCIE_EP_MSIX_BAR));
> > > > > +
> > > > > +	tbl_addr = ((u64)bar_addr_upper) << 32 | bar_addr_lower;
> > > > > +	tbl_addr += (tbl_offset + ((interrupt_num - 1) * PCI_MSIX_ENTRY_SIZE));
> > > > > +	tbl_addr &= PCI_BASE_ADDRESS_MEM_MASK;
> > > > > +	msix_tbl = phys_to_virt(tbl_addr);
> > > >
> > > > phys_to_virt() coupled with iounmap() below, this does not look OK
> > > > to me.
> > > I missed that, I propose to change this to ioremap_nocache() / iounmap()
> > > It was working for me in testing because the BAR is already mapped and iounmap()
> > > didn't have any effect.
> > > >
> > > > IIUC you want to map the BAR in the EP system address space to read the
> > > > tables entries, where the BAR content is set by the host system but
> > > > phys_to_virt() is not the way to do it.
> > > >
> > > > Please explain to me if my reading of the code is correct.
> > > Yes, I want to map the BAR in EP system address space.
> > > The physical address (in EP space) for the BAR is in the inbound address
> > > translation registers  which are read into bar_addr_lower & bar_addr_upper.
> > > I want to map this into EP system address space, so will use ioremap_nocache()
> > > instead unless you propose otherwise.
> > Actually, I found some problems to use ioremap_nocache(), I run into a WARN_ON in
> > ioremap_caller() because the BAR memory is in RAM.  It is allocated using
> > dma_alloc_coherent() in pci_epf_alloc_space()
> > 
> > So, my problem is to get the virtual address of the memory from the physical address.
> > I don't have the virtual address that was returned by dma_alloc_coherent(), I can't
> > get this from the endpoint driver core, but I don't see a way to convert the
> > physical address to DMA address.  phys_to_virt() seems to work in my setup, but
> > I understand that this is not suitable from your comments, and from reading the DMA
> > documentation.  dma_map_resource() looks close to what I want, but I see it can't be
> > used for RAM either.
> > 
> > I'm now searching for another solution to this, but looks like I may need to find a way
> > to get the original virtual address returned by dma_alloc_coherent().  If you have any
> > other suggestions they will be welcome!
> > >
> > > Thanks for your review,
> > > Alan
> > > >
> > > > Lorenzo
> > > >
> > > > > +	if (!msix_tbl)
> > > > > +		return -EINVAL;
> > > > > +
> > > > > +	msg_addr_lower = readl(msix_tbl + PCI_MSIX_ENTRY_LOWER_ADDR);
> > > > > +	msg_addr_upper = readl(msix_tbl + PCI_MSIX_ENTRY_UPPER_ADDR);
> > > > > +	msg_addr = ((u64)msg_addr_upper) << 32 | msg_addr_lower;
> > > > > +
> > > > > +	msg_data = readl(msix_tbl + PCI_MSIX_ENTRY_VECTOR_CTRL);
> > > > > +	if (msg_data & 0x1)
> > > > > +		return -EINVAL;
> > > > > +
> > > > > +	msg_data = readl(msix_tbl + PCI_MSIX_ENTRY_DATA);
> > > > > +
> > > > > +	iounmap(msix_tbl);
> > > > > +
> > > > > +	/* Set the outbound region if needed. */
> > > > > +	if (unlikely(ep->irq_pci_addr != (msg_addr & ~pci_addr_mask) ||
> > > > > +		     ep->irq_pci_fn != fn)) {
> > > > > +		/* First region was reserved for IRQ writes. */
> > > > > +		cdns_pcie_set_outbound_region(pcie, fn, 0,
> > > > > +					      false,
> > > > > +					      ep->irq_phys_addr,
> > > > > +					      msg_addr & ~pci_addr_mask,
> > > > > +					      pci_addr_mask + 1);
> > > > > +		ep->irq_pci_addr = (msg_addr & ~pci_addr_mask);
> > > > > +		ep->irq_pci_fn = fn;
> > > > > +	}
> > > > > +	writel(msg_data, ep->irq_cpu_addr + (msg_addr & pci_addr_mask));
> > > > > +
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > > > >  static int cdns_pcie_ep_raise_irq(struct pci_epc *epc, u8 fn,
> > > > > -				  enum pci_epc_irq_type type, u8 interrupt_num)
> > > > > +				  enum pci_epc_irq_type type,
> > > > > +				  u16 interrupt_num)
> > > > >  {
> > > > >  	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
> > > > >  	u32 link_status;
> > > > > @@ -384,6 +505,9 @@ static int cdns_pcie_ep_raise_irq(struct pci_epc *epc, u8 fn,
> > > > >  	case PCI_EPC_IRQ_MSI:
> > > > >  		return cdns_pcie_ep_send_msi_irq(ep, fn, interrupt_num);
> > > > >
> > > > > +	case PCI_EPC_IRQ_MSIX:
> > > > > +		return cdns_pcie_ep_send_msix_irq(ep, fn, interrupt_num);
> > > > > +
> > > > >  	default:
> > > > >  		break;
> > > > >  	}
> > > > > @@ -430,6 +554,8 @@ static int cdns_pcie_ep_start(struct pci_epc *epc)
> > > > >  	.unmap_addr	= cdns_pcie_ep_unmap_addr,
> > > > >  	.set_msi	= cdns_pcie_ep_set_msi,
> > > > >  	.get_msi	= cdns_pcie_ep_get_msi,
> > > > > +	.set_msix	= cdns_pcie_ep_set_msix,
> > > > > +	.get_msix	= cdns_pcie_ep_get_msix,
> > > > >  	.raise_irq	= cdns_pcie_ep_raise_irq,
> > > > >  	.start		= cdns_pcie_ep_start,
> > > > >  };
> > > > > @@ -501,6 +627,7 @@ static int cdns_pcie_ep_probe(struct platform_device *pdev)
> > > > >  	}
> > > > >
> > > > >  	epc_set_drvdata(epc, ep);
> > > > > +	epc->features |= EPC_FEATURE_MSIX_AVAILABLE;
> > > > >
> > > > >  	if (of_property_read_u8(np, "max-functions", &epc->max_functions) < 0)
> > > > >  		epc->max_functions = 1;
> > > > > diff --git a/drivers/pci/controller/pcie-cadence.h b/drivers/pci/controller/pcie-cadence.h
> > > > > index 4bb2733..946f6ee 100644
> > > > > --- a/drivers/pci/controller/pcie-cadence.h
> > > > > +++ b/drivers/pci/controller/pcie-cadence.h
> > > > > @@ -52,6 +52,12 @@
> > > > >  	(GENMASK(7, 5) << ((b) * 8))
> > > > >  #define  CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_CTRL(b, c) \
> > > > >  	(((c) << ((b) * 8 + 5)) & CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_CTRL_MASK(b))
> > > > > +#define CDNS_PCIE_LM_EP_FUNC_BAR_CFG_VAL(b, c) \
> > > > > +	(((c) & CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_CTRL_MASK((b) % 4)) \
> > > > > +						>> (((b) % 4) * 8 + 5))
> > > > > +#define CDNS_PCIE_LM_EP_FUNC_BAR_APERTURE_VAL(b, c) \
> > > > > +	(((c) & CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_APERTURE_MASK((b) % 4)) \
> > > > > +							>> (((b) % 4) * 8))
> > > > >
> > > > >  /* Endpoint Function Configuration Register */
> > > > >  #define CDNS_PCIE_LM_EP_FUNC_CFG	(CDNS_PCIE_LM_BASE + 0x02c0)
> > > > > @@ -93,6 +99,7 @@
> > > > >  #define CDNS_PCIE_EP_FUNC_BASE(fn)	(((fn) << 12) & GENMASK(19, 12))
> > > > >
> > > > >  #define CDNS_PCIE_EP_FUNC_MSI_CAP_OFFSET	0x90
> > > > > +#define CDNS_PCIE_EP_FUNC_MSIX_CAP_OFFSET	0xb0
> > > > >
> > > > >  /*
> > > > >   * Root Port Registers (PCI configuration space for the root port function)
> > > > > --
> > > > > 1.9.0
> > > > >
