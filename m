Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:58308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754022AbcICRTZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 3 Sep 2016 13:19:25 -0400
Date: Sat, 3 Sep 2016 12:17:15 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, devicetree@vger.kernel.org,
        Wenrui Li <wenrui.li@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        linux-kernel@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 00/15] PCI: rockchip: Cleanups against v10
Message-ID: <20160903171715.GA30488@localhost>
References: <20160902154501.8650.99790.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <5d1e6d5f-c8d9-8fcd-41dd-cabc3027f66a@rock-chips.com>
 <20160903163419.GA23589@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160903163419.GA23589@localhost>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Sep 03, 2016 at 11:34:19AM -0500, Bjorn Helgaas wrote:
> On Sat, Sep 03, 2016 at 10:37:24AM +0800, Shawn Lin wrote:
> > Hi Bjorn,
> > 
> > On 2016/9/2 23:53, Bjorn Helgaas wrote:
> > >These are cleanups against 2098142ae87d, the current pci/host-rockchip
> > >head in my tree.
> > >
> > 
> > Thanks so much for you to help clean up this driver, since I think
> > it should be my duty to take over this.  Hope not too late for me to
> > help your cleanup. I think the v2 cannot compile gracefully without
> > the
> > appended patch. After fixing these compile errors, I backported this
> > driver entirely to my downstream 4.4 tree and it worked fine without
> > regression.
> > 
> > Once again, thanks for doing this. :)
> 
> No problem, thanks a lot for checking it out.  A lot of this stuff is
> things I'm trying to do to other drivers as well, and I wouldn't have
> noticed or bothered except that I've been trying to make all the
> drivers more consistent.
> 
> I applied your fixes and pushed it to pci/host-rockchip-wip again.

And I squashed everything and pushed the result to pci/host-rockchip.
Hopefully we're converging, so this is the branch I intend to merge to
-next.

> 
> > >---
> > >
> > >Bjorn Helgaas (15):
> > >      Remove unused symbols, unnecessary parens, other minor comments from
> > >      Rename pcie_read() and pcie_write() to rockchip_pcie_read() and
> > >      Always use "rockchip" as the pointer to per-device struct.
> > >      Rename struct rockchip_pcie_port to struct rockchip_pcie.
> > >      Use a local "dev" to avoid repetition of "rockchip->dev".
> > >      Add comment about why 32-bit read/modify/write isn't safe.
> > >      Simplify the confusing HIWORD_UPDATE scheme.
> > >      Remove duplicate CSR definition.
> > >      Move CSR bases into definition.
> > >      Group related CSR definitions together.
> > >      Rename PCIE_CORE_RC_CONF_SCC_SHIFT to match similar definitions.
> > >      Rename ROCKCHIP_PCIE_RPIFR1_INTR_MASK and ROCKCHIP_PCIE_RPIFR1_INTR_SHIFT
> > >      The register at PCIE_CLIENT_BASE presumably has a name of its own.  Add a
> > >      Simplify testing of link status and speed testing.
> > >      Move msleeps to address Guenter's comments.
> > >
> > >
> > > drivers/pci/host/pcie-rockchip.c |  842 ++++++++++++++++++--------------------
> > > 1 file changed, 391 insertions(+), 451 deletions(-)
> > >
> > >
> > >
> > 
> > 
> > -- 
> > Best Regards
> > Shawn Lin
> 
> > diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
> > index 754d24b..2bc1c35 100644
> > --- a/drivers/pci/host/pcie-rockchip.c
> > +++ b/drivers/pci/host/pcie-rockchip.c
> > @@ -931,7 +931,7 @@ static int rockchip_pcie_prog_ob_atu(struct rockchip_pcie *rockchip,
> >  	u32 ob_addr_0;
> >  	u32 ob_addr_1;
> >  	u32 ob_desc_0;
> > -	void __iomem *aw_offset;
> > +	u32 aw_offset;
> >  
> >  	if (region_no >= MAX_AXI_WRAPPER_REGION_NUM)
> >  		return -EINVAL;
> > @@ -955,13 +955,13 @@ static int rockchip_pcie_prog_ob_atu(struct rockchip_pcie *rockchip,
> >  	ob_addr_1 = upper_addr;
> >  	ob_desc_0 = (1 << 23 | type);
> >  
> > -	rockchip_pcie_writel(rockchip, ob_addr_0,
> > +	rockchip_pcie_write(rockchip, ob_addr_0,
> >  			     PCIE_CORE_OB_REGION_ADDR0 + aw_offset);
> > -	rockchip_pcie_writel(rockchip, ob_addr_1,
> > +	rockchip_pcie_write(rockchip, ob_addr_1,
> >  			     PCIE_CORE_OB_REGION_ADDR1 + aw_offset);
> > -	rockchip_pcie_writel(rockchip, ob_desc_0,
> > +	rockchip_pcie_write(rockchip, ob_desc_0,
> >  			     PCIE_CORE_OB_REGION_DESC0 + aw_offset);
> > -	rockchip_pcie_writel(rockchip, 0,
> > +	rockchip_pcie_write(rockchip, 0,
> >  			     PCIE_CORE_OB_REGION_DESC1 + aw_offset);
> >  
> >  	return 0;
> > @@ -973,7 +973,7 @@ static int rockchip_pcie_prog_ib_atu(struct rockchip_pcie *rockchip,
> >  {
> >  	u32 ib_addr_0;
> >  	u32 ib_addr_1;
> > -	void __iomem *aw_offset;
> > +	u32 aw_offset;
> >  
> >  	if (region_no > MAX_AXI_IB_ROOTPORT_REGION_NUM)
> >  		return -EINVAL;
> > @@ -988,8 +988,8 @@ static int rockchip_pcie_prog_ib_atu(struct rockchip_pcie *rockchip,
> >  	ib_addr_0 |= (lower_addr << 8) & PCIE_CORE_IB_REGION_ADDR0_LO_ADDR;
> >  	ib_addr_1 = upper_addr;
> >  
> > -	rockchip_pcie_writel(rockchip, ib_addr_0, PCIE_RP_IB_ADDR0 + aw_offset);
> > -	rockchip_pcie_writel(rockchip, ib_addr_1, PCIE_RP_IB_ADDR1 + aw_offset);
> > +	rockchip_pcie_write(rockchip, ib_addr_0, PCIE_RP_IB_ADDR0 + aw_offset);
> > +	rockchip_pcie_write(rockchip, ib_addr_1, PCIE_RP_IB_ADDR1 + aw_offset);
> >  
> >  	return 0;
> >  }
> 
