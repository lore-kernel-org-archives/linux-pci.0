Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101DB2D0C72;
	Thu,  5 Feb 2026 05:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770268334; cv=none; b=Jz4Fe7QeSQlRCIY0EnT5eDvAzyILba2iBdaj5RcgCvIU80kR5uZUq8yiyLvDlCmE1KrZpY2anndnQeiVJhTFYlR3/FCmsgDl74vTiIQKz4p6nlG+Z1b/eEP2zJPyxUq/4l1pODJLyOTmZ2/e4kS+yj0XwsmVSFUNhLpNM6W6P98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770268334; c=relaxed/simple;
	bh=+t2FVxb6adlC40C/KN3UcUK2sF3exvhUGqedvKysN04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SLZcpqEwZnL2aSd7VAdSGSlShJ4oow/mY5il4cx7VY3TV6rXHBHlxkAmrop+L4asEzJuZbKmGBCvNEhNHXDum2++q5BDqLL6KnJqcL2lBOYAx4NYNCEuqPTNqgjJ2P528kAUgtTB66i67jghvMPsCUY6CbX0YDOj/w1zkqOsOCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lD+XHwB0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lD+XHwB0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4393BC4CEF7;
	Thu,  5 Feb 2026 05:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770268333;
	bh=+t2FVxb6adlC40C/KN3UcUK2sF3exvhUGqedvKysN04=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lD+XHwB07IKQtU1evDvpKo2wO02xGc39H3JoCnA0gUjPzNkgs6S7O3d7IdC87keI9
	 MuMJtMQ+ijsXXtHgKOd9JP8XjQndA8pG9amuacPup90CKzNByhM2EBBIUAmHYLMoEF
	 LB8H1b+gbcbcZvGrl0wr+udRwZmjsCmihx1afqeqMt42SlSoBRGvn7S+jWOxWALJPa
	 uJ+BJETFTiZDA1tftA0iCPdYOxgC70XuW4UGlM59Wn0CkQpxFV9BzDF3M9uKQxVKuc
	 +Agv2u2xfDmHMCMi6tS9ezjhbvpKip9Tbpwplc+bcuFgHmiB71IcIbBd0GyJtrn6+O
	 Cz58Y1v5+z1SQ==
Date: Thu, 5 Feb 2026 10:41:59 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Sherry Sun <sherry.sun@nxp.com>, hongxing.zhu@nxp.com, 
	l.stach@pengutronix.de, bhelgaas@google.com, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	s.hauer@pengutronix.de, festevam@gmail.com, imx@lists.linux.dev, kernel@pengutronix.de, 
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 02/10] PCI: imx6: Add support for parsing the reset
 property in new Root Port binding
Message-ID: <geygcp65goaajdy4lxwnux6qw6v2lbbhphk7yqnlsfrutpgszm@vnwqt5ifhmzo>
References: <20260203015614.2957479-1-sherry.sun@nxp.com>
 <20260203015614.2957479-3-sherry.sun@nxp.com>
 <nekxn5osukwkumqfh4qabj6okhtv4tdwrnthza4x54psrhauyf@p3lhia4mkhb4>
 <aYIztYs/07WBLsAq@lizhi-Precision-Tower-5810>
 <pz5zmte5dbb23ccwvc2xkl4grptr35bmcwd6ohlzo2arjopgkw@t3euzojtsoyf>
 <aYNk6C_W_oSFVqbH@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aYNk6C_W_oSFVqbH@lizhi-Precision-Tower-5810>

On Wed, Feb 04, 2026 at 10:25:28AM -0500, Frank Li wrote:
> On Wed, Feb 04, 2026 at 05:58:33PM +0530, Manivannan Sadhasivam wrote:
> > On Tue, Feb 03, 2026 at 12:43:17PM -0500, Frank Li wrote:
> > > On Tue, Feb 03, 2026 at 06:38:18PM +0530, Manivannan Sadhasivam wrote:
> > > > On Tue, Feb 03, 2026 at 09:56:06AM +0800, Sherry Sun wrote:
> > > > > DT binding allows specifying 'reset' property in both host bridge and
> > > > > Root Port nodes, but specifying in the host bridge node is marked as
> > > > > deprecated. So add support for parsing the new binding that uses
> > > > > 'reset-gpios' property for PERST#.
> > > > >
> > > > > The initial idea is to add the PCIe M.2 KeyE connector support and PCI
> > > > > power control framework to the pcie-imx6 driver. Since the new
> > > > > M.2/pwrctrl model is implemented based on Root Ports and requires the
> > > > > pwrctrl driver to bind to a Root Port device, we need to introduce a
> > > > > Root Port child node on i.MX boards that provide an M.2 connector.
> > > > >
> > > > > To follow a more standardized DT structure, it also makes sense to move
> > > > > the reset-gpios and wake-gpios properties into the Root Port node. These
> > > > > signals logically belong to the Root Port rather than the host bridge,
> > > > > and placing them there aligns with the new M.2/pwrctrl model.
> > > > >
> > > > > To maintain DT backwards compatibility, fallback to the legacy method of
> > > > > parsing the host bridge node if the reset property is not present in the
> > > > > Root Port node.
> > > > >
> > > > > Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> > > > > ---
> > > > >  drivers/pci/controller/dwc/pci-imx6.c | 123 +++++++++++++++++++++++---
> > > > >  1 file changed, 109 insertions(+), 14 deletions(-)
> > > > >
> > > > > diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> > > > > index a5b8d0b71677..e3ba68976bee 100644
> > > > > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > > > > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > > > > @@ -148,10 +148,15 @@ struct imx_lut_data {
> > > > >  	u32 data2;
> > > > >  };
> > > > >
> > > > > +struct imx_pcie_port {
> > > > > +	struct list_head	list;
> > > > > +	struct gpio_desc	*reset;
> > > > > +};
> > > > > +
> > > >
> > > > I'd love to abstract the Root Port properties in a generic struct so that we can
> > > > introduce generic APIs to parse the ports. But I'm not asking you to implement
> > > > it :)
> > > >
> > >
> > > good idea, where is good place to put it?
> > >
> >
> > drivers/pci/controller/pci-host-common.c
> >
> > > > >
> > > > > @@ -1688,12 +1771,24 @@ static int imx_pcie_probe(struct platform_device *pdev)
> > > > >  			return PTR_ERR(imx_pcie->phy_base);
> > > > >  	}
> > > > >
> > > > > -	/* Fetch GPIOs */
> > > > > -	imx_pcie->reset_gpiod = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> > > > > -	if (IS_ERR(imx_pcie->reset_gpiod))
> > > > > -		return dev_err_probe(dev, PTR_ERR(imx_pcie->reset_gpiod),
> > > > > -				     "unable to get reset gpio\n");
> > > > > -	gpiod_set_consumer_name(imx_pcie->reset_gpiod, "PCIe reset");
> > > > > +	ret = imx_pcie_parse_ports(imx_pcie);
> > > > > +	if (ret) {
> > > > > +		if (ret != -ENOENT)
> > > > > +			return dev_err_probe(dev, ret, "Failed to parse Root Port: %d\n", ret);
> > > > > +
> > > > > +		/*
> > > > > +		 * In the case of properties not populated in Root Port node,
> > > > > +		 * fallback to the legacy method of parsing the Host Bridge
> > > > > +		 * node. This is to maintain DT backwards compatibility.
> > > > > +		 */
> > > > > +		ret = imx_pcie_parse_legacy_binding(imx_pcie);
> > > > > +		if (ret)
> > > > > +			return dev_err_probe(dev, ret, "Unable to get reset gpio: %d\n", ret);
> > > > > +	}
> > > > > +
> > > > > +	ret = devm_add_action_or_reset(dev, imx_pcie_delete_ports, imx_pcie);
> > > > > +	if (ret)
> > > > > +		return ret;
> > > >
> > > > I'd prefer to do it in err labels.
> > >
> > > we just removed err label and module remove.
> > >
> >
> > This driver is always built-in. So the only way 'struct dev' will get freed is
> > when probe fails. The usual pattern within the host controller drivers is to use
> > err label to do the cleanup not devm_add_action_or_reset() (there are some
> > exceptions though).
> >
> > It just helps us to keep uniformity across the drivers.
> 
> Thanks, but err label is quite easy to make mistake. More and more function
> support devm_*. I think if well design common API at pci-host-common.c,
> goto can be avoid.
> 

I don't think there is a need for a common API for cleanup. Moreover,
devm_add_action_or_reset() will only be executed when the 'struct device' gets
freed, which only happens during system shutdown. Until then, the cleanup
handler won't be invoked.

It is probably OK to free the resources like kzalloced memory with
devm_add_action_or_reset(), but for any other cases like performing resets or
other actions that unwind the prior probe path, explicit err labels should be
used.

Though in this driver, only ports are freed in the handler, someone may abuse it
in the future to perform other cleanups as well. This is why I always perfer
using explicit err labels.

Hope this clarifies!

- Mani

-- 
மணிவண்ணன் சதாசிவம்
