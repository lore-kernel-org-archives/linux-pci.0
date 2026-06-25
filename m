Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AF3357CEC;
	Thu, 25 Jun 2026 13:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782395896; cv=none; b=aTL87sraGAurnQ8Tu0Ou1/ewZSpxkDfVh8O37PyhBhYdPXeTfYz5pdDsEhSiYkvyOMvYwYQ+KPJ7OScdOAbFwD+6BSpdlB2U0OHi6wBvFiAt2PixDKgLmFLouI4vnSdzoQdNlCqAWjVo/wuobR/vJhe/VCD8TCOaMJYSr3RcGFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782395896; c=relaxed/simple;
	bh=RGff6wbAowP+PbMvxE3XECwfvAVmOKFM/zfNKT7rMnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E57K/GZo7C3Z7DtJuz+Kdij9dCCC6DeU3PmR0/iJFAtz73Vfh7d7TzEQQ8cmvx6cTzkAhKylwVm9Qzvwg98/UjiJgyazecsCfbQ7vUEkNncx1SfBNBpesuaCMlXhFy1FEwwzCwKa6x+xop7CGb7a7dap09fCOHNA23jmirWMjnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hxzCeslC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hxzCeslC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64D931F00A3A;
	Thu, 25 Jun 2026 13:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782395895;
	bh=KaLc+quV2pMprMYuRbpfQ+2ZIV/dZbs72AcURaa/OQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hxzCeslCh1paaQ8/HrAjwhqZTAelNUsRIjBPlx5RHMj5LtK3w3RfPFIdBadUna4DE
	 nq1McAB8FAmEl6SanbsC8zX00pnFnB6gdenCE1yK7Mls2mrfPpqdZOZlICMJhSlCHp
	 owurHl9hTH3dFmHUYBNfsXeZ/YfGAJiT09NVgU0XtajdCDy1VixADEppORjAVB+AyL
	 Srwy1bXrdRe68sJOuwDd4A+yc7YovE0g0Us/8eSiN14f8ViGgKT0ZL6emGWChcULD7
	 Dh/5U9EcTyLwdZL405n5v1knnQqGzFwMJGNORvcn0/wvDL+xcomdrFyxBqnGOlVI/m
	 +67YJTWsze+KQ==
Date: Thu, 25 Jun 2026 15:57:54 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Sherry Sun <sherry.sun@nxp.com>
Cc: "Frank Li (OSS)" <frank.li@oss.nxp.com>, 
	"Sherry Sun (OSS)" <sherry.sun@oss.nxp.com>, "robh@kernel.org" <robh@kernel.org>, 
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, 
	Frank Li <frank.li@nxp.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, 
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, 
	Amitkumar Karwar <amitkumar.karwar@nxp.com>, Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>, 
	"marcel@holtmann.org" <marcel@holtmann.org>, "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>, 
	Hongxing Zhu <hongxing.zhu@nxp.com>, "l.stach@pengutronix.de" <l.stach@pengutronix.de>, 
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>, 
	"bhelgaas@google.com" <bhelgaas@google.com>, "brgl@kernel.org" <brgl@kernel.org>, 
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH V2 1/8] PCI: imx6: Add skip_pwrctrl_off flag support
Message-ID: <ozh6q3xazym5dfwvp4re7zwaqcaqmms7pbrzwelzsfldxs6lju@bshacga5usqs>
References: <20260623030736.1421537-1-sherry.sun@oss.nxp.com>
 <20260623030736.1421537-2-sherry.sun@oss.nxp.com>
 <ajqZBM6IkbDLiVu2@SMW015318>
 <VI0PR04MB121147C305022511469FB603A92ED2@VI0PR04MB12114.eurprd04.prod.outlook.com>
 <ajwOvZUlOEQzmjsu@SMW015318>
 <VI0PR04MB12114BCBD405505888063284492EC2@VI0PR04MB12114.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <VI0PR04MB12114BCBD405505888063284492EC2@VI0PR04MB12114.eurprd04.prod.outlook.com>

On Thu, Jun 25, 2026 at 07:25:46AM +0000, Sherry Sun wrote:
> > Subject: Re: [PATCH V2 1/8] PCI: imx6: Add skip_pwrctrl_off flag support
> > 
> > On Wed, Jun 24, 2026 at 07:09:26AM +0000, Sherry Sun wrote:
> > > > Subject: Re: [PATCH V2 1/8] PCI: imx6: Add skip_pwrctrl_off flag
> > > > support
> > > >
> > > > On Tue, Jun 23, 2026 at 11:07:28AM +0800, Sherry Sun (OSS) wrote:
> > > > > From: Sherry Sun <sherry.sun@nxp.com>
> > > > >
> > > > > Use dw_pcie_rp::skip_pwrctrl_off to avoid powering off devices
> > > > > during suspend to preserve wakeup capability of the devices and
> > > > > also not to power on the devices in the init path.
> > > > > This allows controller power-off to be skipped when some devices(e.g.
> > > > > M.2 cards key E without auxiliary power) required to support PCIe
> > > > > L2 link state and wake-up mechanisms.
> > > > >
> > > > > Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> > > > > ---
> > > > >  drivers/pci/controller/dwc/pci-imx6.c | 36
> > > > > +++++++++++++++++----------
> > > > >  1 file changed, 23 insertions(+), 13 deletions(-)
> > > > >
> > > > > diff --git a/drivers/pci/controller/dwc/pci-imx6.c
> > > > > b/drivers/pci/controller/dwc/pci-imx6.c
> > > > > index 0fa716d1ed75..ff5a9565dbbf 100644
> > > > > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > > > > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > > > > @@ -1382,16 +1382,20 @@ static int imx_pcie_host_init(struct
> > > > > dw_pcie_rp
> > > > *pp)
> > > > >  		}
> > > > >  	}
> > > > >
> > > > > -	ret = pci_pwrctrl_create_devices(dev);
> > > > > -	if (ret) {
> > > > > -		dev_err(dev, "failed to create pwrctrl devices\n");
> > > > > -		goto err_reg_disable;
> > > > > +	if (!pci->suspended) {
> > > > > +		ret = pci_pwrctrl_create_devices(dev);
> > > >
> > > > Is possible move pci_pwrctrl_create_devices() of
> > > > pci_pwrctrl_create_devices
> > > >
> > > > and call it direct at probe() function, like other regulator_get function.
> > > >
> > >
> > > Hi Frank,
> > > That makes sense. However, if we move pci_pwrctrl_create_devices () to
> > > probe(), we may need to add the following goto err_pwrctrl_destroy
> > > path in imx_pcie_probe() to properly handle errors from
> > > pci_pwrctrl_power_on_devices(), is that acceptable?
> > 
> > Can you add a API devm_pci_pwrctrl_create_devices() ?
> > 
> 
> Hi Frank, we cannot unconditionally destroy the pwrctrl devices
> when probing fails by using devm API.
> Since we need to check the return value of
> pci_pwrctrl_power_on_devices() for example EPROBE_DEFER to decide
> whether to destroy the pwrctrl devices to avoid the deferred probe loop.
> 
> You can find more related discussion here.
> https://lore.kernel.org/all/tutxwjciedqoje5wxvtin4h637auni5zzpvb7rtfg4uticxoux@yfl6xg7oht7t/
> 

Yes. Ideally we should try to do a blocking wait in the pwrctrl core until all
the pwrctrl drivers are probed, instead of deferring probe. Hopefully, I'll get
to it soon.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
