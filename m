Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFE13B8938;
	Wed,  8 Apr 2026 13:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775656530; cv=none; b=k2KcMr7TNZEy7SO0ou6bCqyVZf1/vifg579OFiywz7ylLFd3vpJHDb3aD9Kny48dt++R2PQJB+c/1SDZMlNlArXcR5XWln+ZznP+V75t0StUIREUUnCjFKireBV5OqqgUW0GwK+GmSHdx4VNFTpgREkBEi/wkonagHVihuVrK7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775656530; c=relaxed/simple;
	bh=bWhTBkh9lG0OYn3p1uqGUIvyw6GLsmFHsj0//fglkRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M7qp2G3/hCf2nwv9pALkmEH4qvgcr+NzH01sHt5i5OZ03w2Fj3QO5SOEQ028aPNBm4fbqIs+mgufGW4N3vtWdxD9pUROGFDL5qUPf43iwPE+uQTFB+3oXVcHwepbg92fTsaEzYUA4ocSn1zXbTkDGixTRgolXt818L0b30jPqtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xyh+eGOS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xyh+eGOS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA82DC19421;
	Wed,  8 Apr 2026 13:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775656529;
	bh=bWhTBkh9lG0OYn3p1uqGUIvyw6GLsmFHsj0//fglkRI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xyh+eGOS1uEhknb6elYjvxe9plsLEQA0ndZ/lEoPUYioAiP5zQvjd2bNOOWvI5MCL
	 dZfs0TsU9xwBVF5m6omQOw13bGHGgud/VvcptZASu3QkiKC8BCoEO+mkYwyUCwzz1J
	 jes4D92bC7QMF7a9IOOGoVb3U8JTx4tCUFf4SaCvo5DDyZDEcXE3XDiP3Rq4W/skR9
	 zf/ld081YahQDRuyOUmAPBGZFFE1GEOdZjtyqIvCZrXGAXsLZBOzMXh6jasUlbgBvO
	 1D/CXQGw4lO4f54mBTQyiNhYZU2Klfd6QJQ5LTHEYWyQ09Dks+38g79+7twLd8/bex
	 //beLRzRUVylA==
Date: Wed, 8 Apr 2026 19:25:19 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Sherry Sun <sherry.sun@nxp.com>
Cc: "robh@kernel.org" <robh@kernel.org>, 
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, 
	Frank Li <frank.li@nxp.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, 
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, 
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>, 
	"bhelgaas@google.com" <bhelgaas@google.com>, Hongxing Zhu <hongxing.zhu@nxp.com>, 
	"l.stach@pengutronix.de" <l.stach@pengutronix.de>, "imx@lists.linux.dev" <imx@lists.linux.dev>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V11 04/12] PCI: imx6: Add support for parsing the reset
 property in new Root Port binding
Message-ID: <t5x45nyn6lw7cofzj2rec5j6z2ml6kve2hvzeeastdrv4hilsu@ujhkmltpp5ky>
References: <20260407104154.2842132-1-sherry.sun@nxp.com>
 <20260407104154.2842132-5-sherry.sun@nxp.com>
 <7ewnbwdo5qtasbxj4uel6a6uthczq2l6udbvoqqkwm776lvseb@v54ri2gknwxn>
 <VI0PR04MB12114AAA709016DADF0B45DA6925BA@VI0PR04MB12114.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <VI0PR04MB12114AAA709016DADF0B45DA6925BA@VI0PR04MB12114.eurprd04.prod.outlook.com>

On Wed, Apr 08, 2026 at 08:34:03AM +0000, Sherry Sun wrote:
> > On Tue, Apr 07, 2026 at 06:41:46PM +0800, Sherry Sun wrote:
> > > The current DT binding for pci-imx6 specifies the 'reset-gpios'
> > > property in the host bridge node. However, the PERST# signal logically
> > > belongs to individual Root Ports rather than the host bridge itself.
> > > This becomes important when supporting PCIe KeyE connector and PCI
> > > power control framework for pci-imx6 driver, which requires properties
> > > to be specified in Root Port nodes.
> > >
> > > Add support for parsing 'reset-gpios' from Root Port child nodes using
> > > the common helper pci_host_common_parse_ports(), and update the reset
> > > GPIO handling to use the parsed port list from bridge->ports. To
> > > maintain DT backwards compatibility, fallback to the legacy method of
> > > parsing the host bridge node if the reset property is not present in
> > > the Root Port node.
> > >
> > > Since now the reset GPIO is obtained with GPIOD_ASIS flag, it may be
> > > in input mode, using gpiod_direction_output() instead of
> > > gpiod_set_value_cansleep() to ensure the reset GPIO is properly
> > > configured as output before setting its value.
> > >
> > > Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> > > ---
> > >  drivers/pci/controller/dwc/pci-imx6.c | 75
> > > +++++++++++++++++++++------
> > >  1 file changed, 60 insertions(+), 15 deletions(-)
> > >
> > > diff --git a/drivers/pci/controller/dwc/pci-imx6.c
> > > b/drivers/pci/controller/dwc/pci-imx6.c
> > > index d99da7e42590..dd8f9c0fcec4 100644
> > > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > > @@ -34,6 +34,7 @@
> > >  #include <linux/pm_runtime.h>
> > >
> > >  #include "../../pci.h"
> > > +#include "../pci-host-common.h"
> > >  #include "pcie-designware.h"
> > >
> > >  #define IMX8MQ_GPR_PCIE_REF_USE_PAD		BIT(9)
> > > @@ -152,7 +153,6 @@ struct imx_lut_data {
> > >
> > >  struct imx_pcie {
> > >  	struct dw_pcie		*pci;
> > > -	struct gpio_desc	*reset_gpiod;
> > >  	struct clk_bulk_data	*clks;
> > >  	int			num_clks;
> > >  	bool			supports_clkreq;
> > > @@ -1224,6 +1224,32 @@ static void imx_pcie_disable_device(struct
> > pci_host_bridge *bridge,
> > >  	imx_pcie_remove_lut(imx_pcie, pci_dev_id(pdev));  }
> > >
> > > +static int imx_pcie_parse_legacy_binding(struct imx_pcie *pcie) {
> > > +	struct device *dev = pcie->pci->dev;
> > > +	struct pci_host_bridge *bridge = pcie->pci->pp.bridge;
> > > +	struct pci_host_port *port;
> > > +	struct gpio_desc *reset;
> > > +
> > > +	reset = devm_gpiod_get_optional(dev, "reset", GPIOD_ASIS);
> > > +	if (IS_ERR(reset))
> > > +		return PTR_ERR(reset);
> > > +
> > > +	if (!reset)
> > > +		return 0;
> > > +
> > > +	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
> > > +	if (!port)
> > > +		return -ENOMEM;
> > > +
> > > +	port->reset = reset;
> > > +	INIT_LIST_HEAD(&port->list);
> > > +	list_add_tail(&port->list, &bridge->ports);
> > > +
> > > +	return devm_add_action_or_reset(dev,
> > pci_host_common_delete_ports,
> > > +					&bridge->ports);
> > > +}
> > > +
> > >  static void imx_pcie_vpcie_aux_disable(void *data)  {
> > >  	struct regulator *vpcie_aux = data;
> > > @@ -1233,13 +1259,22 @@ static void imx_pcie_vpcie_aux_disable(void
> > > *data)
> > >
> > >  static void imx_pcie_assert_perst(struct imx_pcie *imx_pcie, bool
> > > assert)  {
> > > -	if (assert) {
> > > -		gpiod_set_value_cansleep(imx_pcie->reset_gpiod, 1);
> > > -	} else {
> > > -		if (imx_pcie->reset_gpiod) {
> > > -			msleep(PCIE_T_PVPERL_MS);
> > > -			gpiod_set_value_cansleep(imx_pcie->reset_gpiod, 0);
> > > -			msleep(PCIE_RESET_CONFIG_WAIT_MS);
> > > +	struct dw_pcie *pci = imx_pcie->pci;
> > > +	struct pci_host_bridge *bridge = pci->pp.bridge;
> > > +	struct pci_host_port *port;
> > > +
> > > +	if (!bridge)
> > > +		return;
> > > +
> > > +	list_for_each_entry(port, &bridge->ports, list) {
> > > +		if (assert) {
> > > +			gpiod_direction_output(port->reset, 1);
> > > +		} else {
> > > +			if (port->reset) {
> > > +				msleep(PCIE_T_PVPERL_MS);
> > > +				gpiod_direction_output(port->reset, 0);
> > > +				msleep(PCIE_RESET_CONFIG_WAIT_MS);
> > > +			}
> > 
> > Sashiko flagged this loop:
> > 
> > ```
> > Does this loop multiply the initialization delays?
> > If a controller has multiple Root Ports, the msleep calls will run sequentially
> > for each port, linearly increasing the delay. Could we optimize this by
> > asserting all reset GPIOs, waiting the pre-delay once, de-asserting all GPIOs,
> > and waiting the post-delay once for the entire bus?
> > ```
> > 
> > Maybe you should do:
> > 
> > 	if (!list_empty(&bridge->ports) && !assert)
> > 		msleep(PCIE_T_PVPERL_MS);
> > 
> > 	list_for_each_entry(port, &bridge->ports, list) {
> > 		...
> > 		gpiod_direction_output(port->reset, 0);
> > 		...
> > 	}
> > 
> > 	if (!list_empty(&bridge->ports) && !assert)
> > 		msleep(PCIE_RESET_CONFIG_WAIT_MS);
> > 
> 
> Hi Mani, I think the code below looks clearer, is that ok for you?
> 
>     if (assert) {
>         list_for_each_entry(port, &bridge->ports, list)
>             gpiod_direction_output(port->reset, 1);
>     } else {
>         if (list_empty(&bridge->ports))
>             return;
> 

This check should be moved out of the if() condition. Other than this, the
change looks good.

>         msleep(PCIE_T_PVPERL_MS);
>         list_for_each_entry(port, &bridge->ports, list)
>             gpiod_direction_output(port->reset, 0);
>         msleep(PCIE_RESET_CONFIG_WAIT_MS);
>     }
>
> > And then this:
> > 
> > ```
> > Also, since this function is called from imx_pcie_resume_noirq, which
> > executes with hardware interrupts disabled, does the use of msleep here
> > trigger a 'sleeping while atomic' bug?
> > ```
> > 
> > This is a valid concern. You should use mdelay(). But I'd recommend switching
> > to IRQ enabled callback, resume() instead. There is no complelling reason to
> > use resume_noirq() in this driver and adding delays in noirq() callbacks is not
> > recommended as it may increase the overall system resume time.
> > 
> > I will submit a separate series to convert dw_pcie_resume_noirq() and its
> > callers to IRQ enabled callbacks since this dw_pcie_resume_noirq() could
> > potentially cause delay up to 1sec.
> 
> Yes, this is not a new bug introduced by this patch. I agree we should covert the
> convert dw_pcie_resume_noirq() and the caller to IRQ enabled callbacks to fix
> this in a separate patch series.
> For now, should I leave it as is, or switch to mdelay in this patch?
> 

Just use mdelay() in your patch for now.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
