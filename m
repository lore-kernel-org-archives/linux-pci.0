Return-Path: <SRS0=v4Ee=YZ=chromium.org=briannorris@kernel.org>
Return-Path: <SRS0=v4Ee=YZ=chromium.org=briannorris@kernel.org>
Date: Wed, 11 Jan 2017 10:38:56 -0800
From: Brian Norris <briannorris@chromium.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
	linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
	Wenrui Li <wenrui.li@rock-chips.com>,
	Jeffy Chen <jeffy.chen@rock-chips.com>, devicetree@vger.kernel.org,
	Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v2] PCI: rockchip: Add quirk to disable RC's ASPM L0s
Message-ID: <20170111183855.GA85547@google.com>
References: <1481543487-33152-1-git-send-email-shawn.lin@rock-chips.com>
 <20170111182822.GC14532@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170111182822.GC14532@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

+ Heiko

On Wed, Jan 11, 2017 at 12:28:22PM -0600, Bjorn Helgaas wrote:
> On Mon, Dec 12, 2016 at 07:51:27PM +0800, Shawn Lin wrote:
> > diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
> > index f2dca7b..35988fc 100644
> > --- a/drivers/pci/host/pcie-rockchip.c
> > +++ b/drivers/pci/host/pcie-rockchip.c
> > @@ -140,6 +140,8 @@
> >  #define   PCIE_RC_CONFIG_DCR_CSPL_SHIFT		18
> >  #define   PCIE_RC_CONFIG_DCR_CSPL_LIMIT		0xff
> >  #define   PCIE_RC_CONFIG_DCR_CPLS_SHIFT		26
> > +#define PCIE_RC_CONFIG_LINK_CAP		(PCIE_RC_CONFIG_BASE + 0xcc)
> > +#define   PCIE_RC_CONFIG_LINK_CAP_L0S		BIT(10)
> >  #define PCIE_RC_CONFIG_LCS		(PCIE_RC_CONFIG_BASE + 0xd0)
> >  #define PCIE_RC_CONFIG_L1_SUBSTATE_CTRL2 (PCIE_RC_CONFIG_BASE + 0x90c)
> >  #define PCIE_RC_CONFIG_THP_CAP		(PCIE_RC_CONFIG_BASE + 0x274)
> > @@ -653,6 +655,13 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
> >  	status &= ~PCIE_RC_CONFIG_THP_CAP_NEXT_MASK;
> >  	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_THP_CAP);
> >  
> > +	/* Clear L0s from RC's link cap */
> > +	if (of_property_read_bool(dev->of_node, "apsm-no-l0s")) {
> 
> Did you test this?  This string ("apsm-no-l0s") doesn't match the
> "aspm-no-l0s" documented above.  The current tree doesn't contain either
> string in any DTS.

Ha, wow. FWIW in the tree I'm using, I have both this patch and a DTS
patch that uses the matching (but improperly-spelled) property. So *I*
have tested it. But I obviously didn't read it well enough. Or maybe I'm
mildly dyslexic?

Notably, Shawn sent a NON-matching DTS patch already here:

https://patchwork.kernel.org/patch/9477651/

So this definitely needs to get straightened out. Preferably by
s/apsm/aspm/ in this patch.

Regards,
Brian
