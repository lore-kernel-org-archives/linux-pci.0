Return-Path: <linux@roeck-us.net>
Return-Path: <linux@roeck-us.net>
Date: Fri, 2 Sep 2016 10:27:56 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Brian Norris <briannorris@chromium.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Heiko Stuebner <heiko@sntech.de>,
	Doug Anderson <dianders@chromium.org>,
	Wenrui Li <wenrui.li@rock-chips.com>,
	Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [v10,2/2] PCI: Rockchip: Add Rockchip PCIe controller support
Message-ID: <20160902172756.GA13563@roeck-us.net>
References: <1471570498-3284-1-git-send-email-shawn.lin@rock-chips.com>
 <20160831181754.GA7460@roeck-us.net>
 <9075a2c1-c787-986f-31b4-4d5b7c92b771@rock-chips.com>
 <20160901163455.GA9471@localhost>
 <20160901165757.GA3253@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160901165757.GA3253@localhost>
List-ID: <linux-pci.vger.kernel.org>

On Thu, Sep 01, 2016 at 09:57:58AM -0700, Brian Norris wrote:
> On Thu, Sep 01, 2016 at 11:34:55AM -0500, Bjorn Helgaas wrote:
> > I can't conveniently build it, so I'm sure I've broken things.  I
> 
> Indeed, you have :)
> 
> > pushed the current work-in-progress branch to pci/host-rockchip-wip.
> > After we fix build errors and other thinkos, I'll rename it and put it
> > in -next.
> 
> I'll append a patch that gets things building and working for me. With
> that:
> 
> Tested-by: Brian Norris <briannorris@chromium.org>
> 
> I haven't examined all the changes in detail, but they mostly seem
> reasonable.
> 
> > I'll also post the broken-out patches for the changes I made on top of
> > the previous v10 (2098142ae87d).  I'll eventually squash them all into
> > the original commit so we don't have the clutter in the logs.
> 
> diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
> index 6623598679f2..ac846bab7396 100644
> --- a/drivers/pci/host/pcie-rockchip.c
> +++ b/drivers/pci/host/pcie-rockchip.c
> @@ -128,9 +128,9 @@
>  #define PCIE_CLIENT_CONF_ENABLE		(0x00010000 | 0x0001)
>  #define PCIE_CLIENT_LINK_TRAIN_ENABLE	(0x00020000 | 0x0002)
>  #define PCIE_CLIENT_ARI_ENABLE		(0x00080000 | 0x0008)
> -#define PCIE_CLIENT_CONF_LANE_NUM(x)	(0x00300000 | (((x >> 1) & 3) << 4)
> +#define PCIE_CLIENT_CONF_LANE_NUM(x)	(0x00300000 | (((x >> 1) & 3) << 4))

I would suggest to use (x) for those.

>  #define PCIE_CLIENT_MODE_RC		(0x00400000 | 0x0040)
> -#define PCIE_CLIENT_GEN_SEL(x)		(0x00800000 | ((x & 1) << 7)
> +#define PCIE_CLIENT_GEN_SEL(x)		(0x00800000 | ((x & 1) << 7))
>  #define  PCIE_CLIENT_GEN_SEL_0		0
>  #define  PCIE_CLIENT_GEN_SEL_2		1
>  
> @@ -643,14 +643,13 @@ static irqreturn_t rockchip_pcie_client_irq_handler(int irq, void *arg)
>  static void rockchip_pcie_legacy_int_handler(struct irq_desc *desc)
>  {
>  	struct irq_chip *chip = irq_desc_get_chip(desc);
> -	struct rockchip_pcie *rockchip;
> +	struct rockchip_pcie *rockchip = irq_desc_get_handler_data(desc);
>  	struct device *dev = rockchip->dev;
>  	u32 reg;
>  	u32 hwirq;
>  	u32 virq;
>  
>  	chained_irq_enter(chip, desc);
> -	rockchip = irq_desc_get_handler_data(desc);
>  
>  	reg = rockchip_pcie_read(rockchip, PCIE_CLIENT_INT_STATUS);
>  	reg = (reg & ROCKCHIP_PCIE_RPIFR1_INTR_MASK) >>
