Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41091 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753999AbcDGOF5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 7 Apr 2016 10:05:57 -0400
Date: Thu, 7 Apr 2016 09:05:52 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Cc: Jisheng Zhang <jszhang@marvell.com>,
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"pratyush.anand@gmail.com" <pratyush.anand@gmail.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2] PCI: designware: move remaining rc setup code to
 dw_pcie_setup_rc()
Message-ID: <20160407140551.GA2648@localhost>
References: <1458128433-3020-1-git-send-email-jszhang@marvell.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E1ED40E52@lhreml503-mbs>
 <20160407103734.55e72da7@xhacker>
 <EE11001F9E5DDD47B7634E2F8A612F2E1ED43F95@lhreml503-mbs>
 <20160407163443.291fbd49@xhacker>
 <EE11001F9E5DDD47B7634E2F8A612F2E1ED44208@lhreml503-mbs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E1ED44208@lhreml503-mbs>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 07, 2016 at 10:06:45AM +0000, Gabriele Paoloni wrote:
> Hi Jisheng
> 
> > -----Original Message-----
> > From: Jisheng Zhang [mailto:jszhang@marvell.com]
> > Sent: 07 April 2016 09:35
> > To: Gabriele Paoloni
> > Cc: jingoohan1@gmail.com; pratyush.anand@gmail.com;
> > bhelgaas@google.com; linux-pci@vger.kernel.org; linux-
> > kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> > Subject: Re: [PATCH v2] PCI: designware: move remaining rc setup code
> > to dw_pcie_setup_rc()
> > 
> > Hi Gabriele,
> > 
> > On Thu, 7 Apr 2016 08:20:28 +0000 Gabriele Paoloni wrote:
> > 
> > > Hi Jisheng
> > >
> > > Thanks for your reply
> > >
> > > > -----Original Message-----
> > > > From: Jisheng Zhang [mailto:jszhang@marvell.com]
> > > > Sent: 07 April 2016 03:38
> > > > To: Gabriele Paoloni; jingoohan1@gmail.com;
> > pratyush.anand@gmail.com;
> > > > bhelgaas@google.com
> > > > Cc: linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> > arm-
> > > > kernel@lists.infradead.org
> > > > Subject: Re: [PATCH v2] PCI: designware: move remaining rc setup
> > code
> > > > to dw_pcie_setup_rc()
> > > >
> > > > Hi Gabriele,
> > > >
> > > > On Wed, 6 Apr 2016 14:50:29 +0000 Gabriele Paoloni wrote:
> > > >
> > > > > Hi, sorry to be late on this
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
> > > > > > owner@vger.kernel.org] On Behalf Of Jisheng Zhang
> > > > > > Sent: 16 March 2016 11:41
> > > > > > To: jingoohan1@gmail.com; pratyush.anand@gmail.com;
> > > > bhelgaas@google.com
> > > > > > Cc: linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org;
> > linux-
> > > > arm-
> > > > > > kernel@lists.infradead.org; Jisheng Zhang
> > > > > > Subject: [PATCH v2] PCI: designware: move remaining rc setup
> > code
> > > > to
> > > > > > dw_pcie_setup_rc()
> > > > > >
> > > > > > dw_pcie_setup_rc(), as its name indicates, setups the RC. But
> > > > current
> > > > > > dw_pcie_host_init() also contains some necessary rc setup code.
> > > > > >
> > > > > > Another reason: the host may lost power during suspend to ram,
> > the
> > > > RC
> > > > > > need to be re-setup after resume. The rc can't be correctly
> > resumed
> > > > > > without the rc setup code in dw_pcie_host_init().
> > > > > >
> > > > > > So this patch moves the code to dw_pcie_setup_rc() to address
> > the
> > > > above
> > > > > > two issues. After this patch, each pcie designware driver users
> > > > could
> > > > > > call dw_pcie_setup_rc() to re-setup rc when resume back.
> > > > >
> > > > > I think this patch breaks the Hisilicon driver...
> > > > >
> > > > > Our driver performs linkup setup in UEFI therefore we do not call
> > > > > dw_pcie_setup_rc(), we only call dw_pcie_host_init().
> > > >
> > > > Thanks for the information. So pcie-hisi rely on UEFI to do
> > something
> > > > similar
> > > > in dw_pcie_setup_rc(), this comes to a common driver implement
> > > > question: should
> > > > linux device driver rely on bootloader to configure HW device?
> > >
> > > I don't see any issue with this...
> > >
> > > >
> > > > Is it acceptable that pcie-hisi adds a call to dw_pcie_setup_rc()
> > in
> > > > hisi_add_pcie_port()?
> > >
> > > I don't think so...that would try to overwrite what is already set by
> > > the bootloader; so it is wrong in principle and maybe it can lead to
> > > undefined behaviours...
> > 
> > make sense! This commit is intend to re-setup the rc when waken from
> > s2ram (in
> > s2ram state, the host lost power)
> > 
> > I have no good solution but to introduce one function e.g
> > dw_pcie_setup_rc_after_linkup(), then move related code from
> > dw_pcie_host_init
> > to it, then let my host driver resume hook to call.
> > 
> > Hi Pratyush, Jingoo and Bjorn etc.
> > 
> > any suggestions are appreciated!
> 
> What about:
> 
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index a4cccd3..e461f5d 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -434,7 +434,6 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  	struct platform_device *pdev = to_platform_device(pp->dev);
>  	struct pci_bus *bus, *child;
>  	struct resource *cfg_res;
> -	u32 val;
>  	int i, ret;
>  	LIST_HEAD(res);
>  	struct resource_entry *win;
> @@ -544,25 +543,6 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  	if (pp->ops->host_init)
>  		pp->ops->host_init(pp);
>  
> -	/*
> -	 * If the platform provides ->rd_other_conf, it means the platform
> -	 * uses its own address translation component rather than ATU, so
> -	 * we should not program the ATU here.
> -	 */
> -	if (!pp->ops->rd_other_conf)
> -		dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX1,
> -					  PCIE_ATU_TYPE_MEM, pp->mem_base,
> -					  pp->mem_bus_addr, pp->mem_size);
> -
> -	dw_pcie_wr_own_conf(pp, PCI_BASE_ADDRESS_0, 4, 0);
> -
> -	/* program correct class for RC */
> -	dw_pcie_wr_own_conf(pp, PCI_CLASS_DEVICE, 2, PCI_CLASS_BRIDGE_PCI);
> -
> -	dw_pcie_rd_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4, &val);
> -	val |= PORT_LOGIC_SPEED_CHANGE;
> -	dw_pcie_wr_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4, val);
> -
>  	pp->root_bus_nr = pp->busn->start;
>  	if (IS_ENABLED(CONFIG_PCI_MSI)) {
>  		bus = pci_scan_root_bus_msi(pp->dev, pp->root_bus_nr,
> @@ -725,6 +705,29 @@ static struct pci_ops dw_pcie_ops = {
>  	.write = dw_pcie_wr_conf,
>  };
>  
> +void dw_pcie_setup_own_cfg(struct pcie_port *pp)
> +{
> +	u32 val;
> +	/*
> +	 * If the platform provides ->rd_other_conf, it means the platform
> +	 * uses its own address translation component rather than ATU, so
> +	 * we should not program the ATU here.
> +	 */
> +	if (!pp->ops->rd_other_conf)
> +		dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX1,
> +					  PCIE_ATU_TYPE_MEM, pp->mem_base,
> +					  pp->mem_bus_addr, pp->mem_size);
> +
> +	dw_pcie_wr_own_conf(pp, PCI_BASE_ADDRESS_0, 4, 0);
> +
> +	/* program correct class for RC */
> +	dw_pcie_wr_own_conf(pp, PCI_CLASS_DEVICE, 2, PCI_CLASS_BRIDGE_PCI);
> +
> +	dw_pcie_rd_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4, &val);
> +	val |= PORT_LOGIC_SPEED_CHANGE;
> +	dw_pcie_wr_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4, val);
> +}
> +
>  void dw_pcie_setup_rc(struct pcie_port *pp)
>  {
>  	u32 val;
> @@ -800,6 +803,8 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
>  	val |= PCI_COMMAND_IO | PCI_COMMAND_MEMORY |
>  		PCI_COMMAND_MASTER | PCI_COMMAND_SERR;
>  	dw_pcie_writel_rc(pp, val, PCI_COMMAND);
> +
> +	dw_pcie_setup_own_cfg(pp);
>  }
>  
>  MODULE_AUTHOR("Jingoo Han <jg1.han@samsung.com>");
> diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
> index f437f9b..caf0f5d 100644
> --- a/drivers/pci/host/pcie-designware.h
> +++ b/drivers/pci/host/pcie-designware.h
> @@ -85,5 +85,6 @@ int dw_pcie_wait_for_link(struct pcie_port *pp);
>  int dw_pcie_link_up(struct pcie_port *pp);
>  void dw_pcie_setup_rc(struct pcie_port *pp);
>  int dw_pcie_host_init(struct pcie_port *pp);
> +void dw_pcie_setup_own_cfg(struct pcie_port *pp);
>  
>  #endif /* _PCIE_DESIGNWARE_H */
> diff --git a/drivers/pci/host/pcie-hisi.c b/drivers/pci/host/pcie-hisi.c
> index 3e98d4e..8da29b2 100644
> --- a/drivers/pci/host/pcie-hisi.c
> +++ b/drivers/pci/host/pcie-hisi.c
> @@ -164,6 +164,7 @@ static int hisi_add_pcie_port(struct pcie_port *pp,
>  		dev_err(&pdev->dev, "failed to initialize host\n");
>  		return ret;
>  	}
> +	dw_pcie_setup_own_cfg(pp);
>  
>  	return 0;
>  }

What's the hisi plan for resuming after suspend-to-RAM?  How does the
RC get reprogrammed after it loses all its state?

What would break if hisi did call dw_pcie_setup_rc()?  I know you said
it would overwrite what the bootloader already did, which is true.

But hisi does call dw_pcie_host_init(), so it reads pp->mem (which
determines pp->mem_base) and pp->lanes from the DT.  Other drivers
then call dw_pcie_setup_rc() which programs the RC based on
pp->mem_base and pp->lanes.  So hisi assumes UEFI programmed the RC to
match the DT, while the other drivers read the DT and program the RC
to match.  The latter seems more robust because it enforces the
consistency rather than relying on it.

Bjorn
