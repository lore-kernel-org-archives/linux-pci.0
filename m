Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3AF359FB0;
	Tue, 17 Feb 2026 14:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771336832; cv=none; b=B3UZftSkJvBpy2Y7jO661aroevPAceaHAQ6KRGA8RmCzwhDVHKz9RP/2zUxA4w/gpjMDUf32sT/nm9toS/GNoWBhZycbcoNyZFJagZ0nouVoufi4ekzwtIeWlXbQy7SECdPRnl8a+KQVPlvo+g7qARqNIGJwJdl5KmcxIhH1yHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771336832; c=relaxed/simple;
	bh=yZ7EZjJ35vE1okONnm6nlL8GwNn4qtBojbitFN7sh+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FjFDFr8pRiZjttzxF5i0Wg2YrtpKzo+D2pBfg5MTFrJvgfuwb5ceMtlJVhZfMDZIxntUx4D+XIsxCaLDjH8cJHKkccJj/KbT3ZSKcRGeNe3ozHuzWURbVIlxKMUAUG2/VrUL6S381ysx5wZITFLFVeRn1D19M/mGrPCRQYisa1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jmH4cT3S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jmH4cT3S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BC8CC19423;
	Tue, 17 Feb 2026 14:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771336831;
	bh=yZ7EZjJ35vE1okONnm6nlL8GwNn4qtBojbitFN7sh+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jmH4cT3Sx9zCRZQH9kFVGIW5ensgdZJTn4zf48NZ0YIB5BBUVYe/yZsiM/TYW6vwC
	 HZm8v8gds4F9qE+hm3rVhCNougf376hLCEhkLbD1loeG8gWj+hsahepoTD8lB6MGD1
	 cigUXjIg3vvTFDAWpna9VMH2+QrdThxiCuV8wmRPZF+XyKxszSrJVtH3ueDgsyIcTu
	 gseHHGa6vH4aNL2TPSu/iyflRGBzXaabqwa15SbYUlgbezZLNONS9JEXFNYzuLpxTZ
	 ghIWeLYGiXKqgfRTTjKwTr0bdfxQIqmCcAd5wTOHC5HWJrTT7hUgnHGZZHlwbyRPi7
	 pnZxxaNiP6jBA==
Date: Tue, 17 Feb 2026 19:30:24 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Minghuan Lian <minghuan.Lian@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>, 
	Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
	Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH] PCI: layerscape: Allow to compile as module
Message-ID: <a3fn5vt73n6ggnr6euuba7gbmv7uhx4c6wdelxwtkcdzn2dn7e@btqsm5glgffr>
References: <20260112-v6-19-topic-layerscape-pcie-v1-1-1cd863fce50e@pengutronix.de>
 <20260216-mahogany-caterpillar-of-certainty-38b0bc-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260216-mahogany-caterpillar-of-certainty-38b0bc-mkl@pengutronix.de>

On Mon, Feb 16, 2026 at 10:49:42PM +0100, Marc Kleine-Budde wrote:
> Hello,
> 
> Bjorn can you take this patch?
> 

Will do once -rc1 is out.

- Mani

> On 12.01.2026 20:17:11, Steffen Trumtrar wrote:
> > From: Sascha Hauer <s.hauer@pengutronix.de>
> >
> > The layerscape pcie host controller could also be compiled as module.
> > Add the necessary infrastructure to allow building as module instead of
> > only as builtin driver.
> >
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> > ---
> >  drivers/pci/controller/dwc/Kconfig          |  2 +-
> >  drivers/pci/controller/dwc/pci-layerscape.c | 16 +++++++++++++++-
> >  2 files changed, 16 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> > index 519b59422b479..abfa4a6e62c25 100644
> > --- a/drivers/pci/controller/dwc/Kconfig
> > +++ b/drivers/pci/controller/dwc/Kconfig
> > @@ -121,7 +121,7 @@ config PCI_IMX6_EP
> >  	  DesignWare core functions to implement the driver.
> >
> >  config PCI_LAYERSCAPE
> > -	bool "Freescale Layerscape PCIe controller (host mode)"
> > +	tristate "Freescale Layerscape PCIe controller (host mode)"
> >  	depends on OF && (ARM || ARCH_LAYERSCAPE || COMPILE_TEST)
> >  	depends on PCI_MSI
> >  	select PCIE_DW_HOST
> > diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
> > index a44b5c256d6e2..14d6ac4fc53fd 100644
> > --- a/drivers/pci/controller/dwc/pci-layerscape.c
> > +++ b/drivers/pci/controller/dwc/pci-layerscape.c
> > @@ -13,6 +13,7 @@
> >  #include <linux/interrupt.h>
> >  #include <linux/init.h>
> >  #include <linux/iopoll.h>
> > +#include <linux/module.h>
> >  #include <linux/of_pci.h>
> >  #include <linux/of_platform.h>
> >  #include <linux/of_address.h>
> > @@ -403,8 +404,16 @@ static const struct dev_pm_ops ls_pcie_pm_ops = {
> >  	NOIRQ_SYSTEM_SLEEP_PM_OPS(ls_pcie_suspend_noirq, ls_pcie_resume_noirq)
> >  };
> >
> > +static void ls_pcie_remove(struct platform_device *pdev)
> > +{
> > +	struct ls_pcie *pcie = platform_get_drvdata(pdev);
> > +
> > +	dw_pcie_host_deinit(&pcie->pci->pp);
> > +}
> > +
> >  static struct platform_driver ls_pcie_driver = {
> >  	.probe = ls_pcie_probe,
> > +	.remove = ls_pcie_remove,
> >  	.driver = {
> >  		.name = "layerscape-pcie",
> >  		.of_match_table = ls_pcie_of_match,
> > @@ -412,4 +421,9 @@ static struct platform_driver ls_pcie_driver = {
> >  		.pm = &ls_pcie_pm_ops,
> >  	},
> >  };
> > -builtin_platform_driver(ls_pcie_driver);
> > +module_platform_driver(ls_pcie_driver);
> > +
> > +MODULE_AUTHOR("Minghuan Lian <Minghuan.Lian@freescale.com>");
> > +MODULE_DESCRIPTION("Layerscape PCIe host controller driver");
> > +MODULE_LICENSE("GPL");
> > +MODULE_DEVICE_TABLE(of, ls_pcie_of_match);
> >
> > ---
> > base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> > change-id: 20260112-v6-19-topic-layerscape-pcie-9d10b6542139
> >
> > Best regards,
> > --
> > Steffen Trumtrar <s.trumtrar@pengutronix.de>
> >
> >
> 
> --
> Pengutronix e.K.                 | Marc Kleine-Budde          |
> Embedded Linux                   | https://www.pengutronix.de |
> Vertretung Nürnberg              | Phone: +49-5121-206917-129 |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |



-- 
மணிவண்ணன் சதாசிவம்
