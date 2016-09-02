Return-Path: <heiko@sntech.de>
Return-Path: <heiko@sntech.de>
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Brian Norris <briannorris@chromium.org>, Shawn Lin <shawn.lin@rock-chips.com>, Guenter Roeck <linux@roeck-us.net>, Bjorn Helgaas <bhelgaas@google.com>, Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, Doug Anderson <dianders@chromium.org>, Wenrui Li <wenrui.li@rock-chips.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [v10,2/2] PCI: Rockchip: Add Rockchip PCIe controller support
Date: Fri, 02 Sep 2016 18:28:29 +0200
Message-ID: <2006737.sL15e15fY3@diego>
In-Reply-To: <20160902154409.GA8370@localhost>
References: <1471570498-3284-1-git-send-email-shawn.lin@rock-chips.com> <20160901174852.GC9471@localhost> <20160902154409.GA8370@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-pci.vger.kernel.org>

Am Freitag, 2. September 2016, 10:44:09 schrieb Bjorn Helgaas:
> On Thu, Sep 01, 2016 at 12:48:52PM -0500, Bjorn Helgaas wrote:
> > On Thu, Sep 01, 2016 at 10:14:01AM -0700, Brian Norris wrote:
> > > The use of HIWORD_UPDATE can indeed be a bit confusing, IMO, but this is
> > > really a common Rockchip-ism that, once you read several of their
> > > drivers, can make a little more sense. If you grep around, it's in at
> > > least their clock, ethernet, SDHCI, PHY, and DP/DRM drivers. I might
> > > defer to Heiko (upstream maintainer of Rockchip code) for a decision.
> > > Maybe there's some intermediate ground where we keep the HIWORK_UPDATE()
> > > logic (it does make sure we get the 16-bit shift right, I think) while
> > > still refactoring a few other bits (like PCIE_CLIENT_CONF_LANE_NUM() and
> > > PCIE_CLIENT_GEN_SEL() for wrapping HIWORK_UPDATE()?).
> 
> Here's a second proposal.  It retains HIWORD_UPDATE (though the structure
> is different) so grep finds it along with the other Rockchip ones.
> 
> I'll post updated actual patches; this is just to give the idea:
> 
> -/*
> -  * The higher 16-bit of this register is used for write protection
> -  * only if BIT(x + 16) set to 1 the BIT(x) can be written.
> -  */
> -#define HIWORD_UPDATE(val, mask, shift) \
> -	((val) << (shift) | (mask) << ((shift) + 16))
> 
> -#define PCIE_CLIENT_CONF_ENABLE			BIT(0)
> -#define PCIE_CLIENT_CONF_ENABLE_SHIFT		0
> -#define PCIE_CLIENT_CONF_ENABLE_MASK		0x1
> -#define PCIE_CLIENT_LINK_TRAIN_ENABLE		1
> -#define PCIE_CLIENT_LINK_TRAIN_SHIFT		1
> -#define PCIE_CLIENT_LINK_TRAIN_MASK		0x1
> -#define PCIE_CLIENT_ARI_ENABLE			BIT(0)
> -#define PCIE_CLIENT_ARI_ENABLE_SHIFT		3
> -#define PCIE_CLIENT_ARI_ENABLE_MASK		0x1
> -#define PCIE_CLIENT_CONF_LANE_NUM(x)		(x / 2)
> -#define PCIE_CLIENT_CONF_LANE_NUM_SHIFT		4
> -#define PCIE_CLIENT_CONF_LANE_NUM_MASK		0x3
> -#define PCIE_CLIENT_MODE_RC			BIT(0)
> -#define PCIE_CLIENT_MODE_SHIFT			6
> -#define PCIE_CLIENT_MODE_MASK			0x1
> -#define PCIE_CLIENT_GEN_SEL_2			1
> -#define PCIE_CLIENT_GEN_SEL_SHIFT		7
> -#define PCIE_CLIENT_GEN_SEL_MASK		0x1
> 
> +/*
> + * The upper 16 bits of the PCIE_CLIENT registers are a write mask for the
> + * lower 16 bits.  This allows atomic updates of the register without
> + * locking.
> + */
> +#define HIWORD_UPDATE(mask, val)	((mask << 16) | val)
> +
> +#define ENCODE_LANES(x)			(((x >> 1) & 3) << 4)
> +
> +#define PCIE_CLIENT_CONF_ENABLE		HIWORD_UPDATE(0x0001, 0x0001)
> +#define PCIE_CLIENT_LINK_TRAIN_ENABLE	HIWORD_UPDATE(0x0002, 0x0002)
> +#define PCIE_CLIENT_CONF_LANE_NUM(x)	HIWORD_UPDATE(0x0030, ENCODE_LANES(x))
> +#define PCIE_CLIENT_GEN_SEL_2		HIWORD_UPDATE(0x0040, 0x0040)
> 
>  	rockchip_pcie_write(rockchip,
> -		   HIWORD_UPDATE(PCIE_CLIENT_CONF_ENABLE,
> -				 PCIE_CLIENT_CONF_ENABLE_MASK,
> -				 PCIE_CLIENT_CONF_ENABLE_SHIFT) |
> -		   HIWORD_UPDATE(PCIE_CLIENT_CONF_LANE_NUM(rockchip->lanes),
> -				 PCIE_CLIENT_CONF_LANE_NUM_MASK,
> -				 PCIE_CLIENT_CONF_LANE_NUM_SHIFT) |
> -		   HIWORD_UPDATE(PCIE_CLIENT_MODE_RC,
> -				 PCIE_CLIENT_MODE_MASK,
> -				 PCIE_CLIENT_MODE_SHIFT) |
> -		   HIWORD_UPDATE(PCIE_CLIENT_ARI_ENABLE,
> -				 PCIE_CLIENT_ARI_ENABLE_MASK,
> -				 PCIE_CLIENT_ARI_ENABLE_SHIFT) |
> -		   HIWORD_UPDATE(PCIE_CLIENT_GEN_SEL_2,
> -				 PCIE_CLIENT_GEN_SEL_MASK,
> -				 PCIE_CLIENT_GEN_SEL_SHIFT),
> -		   PCIE_CLIENT_BASE);
> +			    PCIE_CLIENT_CONF_ENABLE |
> +			    PCIE_CLIENT_LINK_TRAIN_ENABLE |
> +			    PCIE_CLIENT_ARI_ENABLE |
> +			    PCIE_CLIENT_CONF_LANE_NUM(rockchip->lanes) |
> +			    PCIE_CLIENT_MODE_RC |
> +			    PCIE_CLIENT_GEN_SEL_2,
> +				PCIE_CLIENT_BASE);

I like this new approach :-)
Improves the readability in the code but also future readability of the defined 
constants, when comparing with register descriptions


Thanks
Heiko
