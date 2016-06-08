Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:38356 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423407AbcFHJf1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jun 2016 05:35:27 -0400
Received: by mail-wm0-f52.google.com with SMTP id m124so8211177wme.1
        for <linux-pci@vger.kernel.org>; Wed, 08 Jun 2016 02:35:26 -0700 (PDT)
Message-ID: <1465378523.1870.26.camel@googlemail.com>
Subject: Re: [PATCH] PCI: imx6: Add support for MX6SX LDO PCIE domain
 regulator
From: Christoph Fritz <chf.fritz@googlemail.com>
Reply-To: chf.fritz@googlemail.com
To: Fabio Estevam <festevam@gmail.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Richard Zhu <hongxing.zhu@nxp.com>
Cc: bhelgaas@google.com, shawnguo@kernel.org,
	linux-pci@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>
Date: Wed, 08 Jun 2016 11:35:23 +0200
In-Reply-To: <1465344472-15703-1-git-send-email-festevam@gmail.com>
References: <1465344472-15703-1-git-send-email-festevam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Fabio

On Tue, 2016-06-07 at 21:07 -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> MX6SX has an internal LDO regulator for the PCIE domain, which needs
> to be turned on for PCIE functionality.
> 
> Add support for it.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
>  .../devicetree/bindings/pci/fsl,imx6q-pcie.txt     |  2 ++
>  drivers/pci/host/pci-imx6.c                        | 29 +++++++++++++++++++++-

There was a discussion doing the handling of the regulator inside the PM
backend:

> On Mon, 2016-02-15 at 07:24 +0000, Richard Zhu wrote:
> > As Lucas discussed with me before,  the GPC regulator operations should[n't] be touched in
> > Imx pcie driver at all.  These bits operations should be encapsulate into the PM system,
> >  for example, the regulator driver.

On Thu, 2016-02-18 at 12:59 +0100, Christoph Fritz wrote:
> Ok, for an initial version, I'll just leave the regulator in my
> devicetree enabled. For further enhancements I suppose
> arch/arm/mach-imx/gpc.c needs to get touched?
> 
@Richard and @Lucas: Any further hints on this?

Thanks
 -- Christoph

