Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:34664 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756197AbbFRQmW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 18 Jun 2015 12:42:22 -0400
Received: by igboe5 with SMTP id oe5so23207338igb.1
        for <linux-pci@vger.kernel.org>; Thu, 18 Jun 2015 09:42:22 -0700 (PDT)
Date: Thu, 18 Jun 2015 11:42:18 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Zhou Wang <wangzhou1@hisilicon.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	linux-pci@vger.kernel.org, gabriele.paoloni@huawei.com,
	yuanzhichang@hisilicon.com, zhangjukuo@huawei.com,
	liguozhu@hisilicon.com, Richard Zhu <Richard.Zhu@freescale.com>,
	Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH] PCI: designware: set PORT_LOGIC_SPEED_CHANGE before
 linkup
Message-ID: <20150618164218.GD7710@google.com>
References: <1433211273-226508-1-git-send-email-wangzhou1@hisilicon.com>
 <20150602193707.GJ3631@google.com>
 <5571825E.2090800@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5571825E.2090800@hisilicon.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 05, 2015 at 07:05:02PM +0800, Zhou Wang wrote:
> On 2015/6/3 3:37, Bjorn Helgaas wrote:
> > [+cc Richard, Lucas for imx6 questions below]
> > 
> > On Tue, Jun 02, 2015 at 10:14:33AM +0800, Zhou Wang wrote:
> >> When connected some PCIe3.0 cards(e.g. LSI 2208 PCIe-RAID card, Mellanox IB card),
> >> It will appear link unstable which will lead reading/writing fail.
> >>
> >> Here just move the setting of PORT_LOGIC_SPEED_CHANGE bit before starting
> >> building link. After doing this, it will work fine with above PCIe3.0 card.
> >>
> >> This patch is based on v4.1-rc4
> >>
> >> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
> >> ---
> >>  drivers/pci/host/pcie-designware.c | 8 ++++----
> >>  1 file changed, 4 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> >> index 2e9f84f..64ebc51 100644
> >> --- a/drivers/pci/host/pcie-designware.c
> >> +++ b/drivers/pci/host/pcie-designware.c
> >> @@ -498,10 +498,6 @@ int dw_pcie_host_init(struct pcie_port *pp)
> >>  	/* program correct class for RC */
> >>  	dw_pcie_wr_own_conf(pp, PCI_CLASS_DEVICE, 2, PCI_CLASS_BRIDGE_PCI);
> >>  
> >> -	dw_pcie_rd_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4, &val);
> >> -	val |= PORT_LOGIC_SPEED_CHANGE;
> >> -	dw_pcie_wr_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4, val);
> >> -
> >>  #ifdef CONFIG_PCI_MSI
> >>  	dw_pcie_msi_chip.dev = pp->dev;
> >>  	dw_pci.msi_ctrl = &dw_pcie_msi_chip;
> >> @@ -797,6 +793,10 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
> >>  	}
> >>  	dw_pcie_writel_rc(pp, val, PCIE_LINK_WIDTH_SPEED_CONTROL);
> >>  
> >> +	dw_pcie_readl_rc(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, &val);
> >> +	val |= PORT_LOGIC_SPEED_CHANGE;
> >> +	dw_pcie_writel_rc(pp, val, PCIE_LINK_WIDTH_SPEED_CONTROL);
> > 
> > It makes sense to me to do this at the same place we do the other write to
> > PCIE_LINK_WIDTH_SPEED_CONTROL.
> > 
> > 1) Can this be combined with the previous write, so we only need a single
> >    write to PCIE_LINK_WIDTH_SPEED_CONTROL, e.g., something like this?
> > 
> >     switch (pp->lanes) {
> >     case 1:
> >         val |= PORT_LOGIC_LINK_WIDTH_1_LANES;
> >         ...
> >     }
> >     val |= PORT_LOGIC_SPEED_CHANGE;
> >     dw_pcie_writel_rc(pp, val, PCIE_LINK_WIDTH_SPEED_CONTROL);
> > 
> 
> I think it is OK to put them together.
> 
> > 2) imx6_pcie_start_link() also writes PCIE_LINK_WIDTH_SPEED_CONTROL.  It
> >    has a loop to wait for the speed change to finish.  Does
> >    dw_pcie_setup_rc() need a similar loop?
> 
> imx6 has a loop there to make sure link is stable, because enumeration will start
> soon. Also in other drivers which are based on pcie-designware, we should check
> if speed change is done before enumeration. In pcie-designware, now it does not
> make this check.
> 
> Maybe we may not move PORT_LOGIC_SPEED_CHANGE set, but add a loop check after it
> to make sure the link is stable. Then related same setting in imx6 can be deleted.
> 
> I wonder if other PCIe hosts which is based on DW have met the same problem?
> 
> > 
> > 3) Since you are moving the PORT_LOGIC_SPEED_CHANGE write from
> >    dw_pcie_host_init() to dw_pcie_setup_rc(), it will now happen before
> >    imx6_pcie_start_link().  Does that mean we can remove the write from
> >    imx6_pcie_start_link() completely?
> > 
> 
> I think so.

Ping?  I'm dropping this for now since nobody acked it and we never quite
resolved the questions.

But it seems like something is broken and needs to be fixed, so please
post an updated version.

> >>  	/* setup RC BARs */
> >>  	dw_pcie_writel_rc(pp, 0x00000004, PCI_BASE_ADDRESS_0);
> >>  	dw_pcie_writel_rc(pp, 0x00000000, PCI_BASE_ADDRESS_1);
> >> -- 
> >> 1.9.1
> >>
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> > .
> > 
> 
> 
