Return-Path: <SRS0=GXRf=72=sntech.de=heiko@kernel.org>
Return-Path: <SRS0=GXRf=72=sntech.de=heiko@kernel.org>
From: Heiko Stuebner <heiko@sntech.de>
To: Bjorn Helgaas <helgaas@kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>
Cc: Fabio Estevam <festevam@gmail.com>, bhelgaas@google.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: rockchip: Use gpiod_set_value_cansleep() to allow reset via expanders
Date: Thu, 24 Aug 2017 18:37:02 +0200
Message-ID: <1690109.dqujpfY2W8@phil>
In-Reply-To: <20170824163323.GG31858@bhelgaas-glaptop.roam.corp.google.com>
References: <1503187634-3823-1-git-send-email-festevam@gmail.com> <20170824163323.GG31858@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-pci.vger.kernel.org>

Am Donnerstag, 24. August 2017, 11:33:23 CEST schrieb Bjorn Helgaas:
> On Sat, Aug 19, 2017 at 09:07:14PM -0300, Fabio Estevam wrote:
> > The reset GPIO can be connected to a I2C or SPI IO expander, which may
> > sleep, so it is safer to use the gpiod_set_value_cansleep() variant
> > instead.
> > 
> > Signed-off-by: Fabio Estevam <festevam@gmail.com>
> 
> Waiting for Shawn's ack...

we might want to include him then, as I'm not sure if he patrols the
linux-pci list :-) . [I've added him]


> 
> > ---
> >  drivers/pci/host/pcie-rockchip.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
> > index 2eccd53..124b280 100644
> > --- a/drivers/pci/host/pcie-rockchip.c
> > +++ b/drivers/pci/host/pcie-rockchip.c
> > @@ -537,7 +537,7 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
> >  	int err, i;
> >  	u32 status;
> >  
> > -	gpiod_set_value(rockchip->ep_gpio, 0);
> > +	gpiod_set_value_cansleep(rockchip->ep_gpio, 0);
> >  
> >  	err = reset_control_assert(rockchip->aclk_rst);
> >  	if (err) {
> > @@ -682,7 +682,7 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
> >  	rockchip_pcie_write(rockchip, PCIE_CLIENT_LINK_TRAIN_ENABLE,
> >  			    PCIE_CLIENT_CONFIG);
> >  
> > -	gpiod_set_value(rockchip->ep_gpio, 1);
> > +	gpiod_set_value_cansleep(rockchip->ep_gpio, 1);
> >  
> >  	/* 500ms timeout value should be enough for Gen1/2 training */
> >  	err = readl_poll_timeout(rockchip->apb_base + PCIE_CLIENT_BASIC_STATUS1,
> 
> 
