Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:34640 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161215AbcFMKlm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jun 2016 06:41:42 -0400
Message-ID: <1465814497.2313.7.camel@pengutronix.de>
Subject: Re: [PATCH] PCI: imx6: Add support for MX6SX LDO PCIE domain
 regulator
From: Lucas Stach <l.stach@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>
Cc: Christoph Fritz <chf.fritz@googlemail.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <shawnguo@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Fabio Estevam <fabio.estevam@nxp.com>
Date: Mon, 13 Jun 2016 12:41:37 +0200
In-Reply-To: <CAOMZO5Bix1Bgrsbn2K_1sh7ee=dxRccU1zk2fJei-WU4vvpCgg@mail.gmail.com>
References: <1465344472-15703-1-git-send-email-festevam@gmail.com>
	 <1465378523.1870.26.camel@googlemail.com>
	 <CAOMZO5Bix1Bgrsbn2K_1sh7ee=dxRccU1zk2fJei-WU4vvpCgg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Fabio,

Am Sonntag, den 12.06.2016, 10:51 -0300 schrieb Fabio Estevam:
> Hi Christoph,
> 
> On Wed, Jun 8, 2016 at 6:35 AM, Christoph Fritz
> <chf.fritz@googlemail.com> wrote:
> 
> > There was a discussion doing the handling of the regulator inside the PM
> > backend:
> 
> Thanks for pointing me to this discussion.
> 
> >
> >> On Mon, 2016-02-15 at 07:24 +0000, Richard Zhu wrote:
> >> > As Lucas discussed with me before,  the GPC regulator operations should[n't] be touched in
> >> > Imx pcie driver at all.  These bits operations should be encapsulate into the PM system,
> >> >  for example, the regulator driver.
> >
> > On Thu, 2016-02-18 at 12:59 +0100, Christoph Fritz wrote:
> >> Ok, for an initial version, I'll just leave the regulator in my
> >> devicetree enabled. For further enhancements I suppose
> >> arch/arm/mach-imx/gpc.c needs to get touched?
> >>
> > @Richard and @Lucas: Any further hints on this?
> 
> Yes, would appreciate some hints or examples as to how to properly
> handle the PCI LDO regulator on mx6sx.
> 
It should be handled the same way as the PU domain regulator on mx6q.
This means the regulator is a supply of the PCIe PHY power domain and
should be en-/disabled through the GPC driver.

I already posted a series to rework the GPC driver to allow adding new
power domains easily, but it was rejected by Shawn on formal grounds, as
it's mostly a single big patch to do the rework. I don't have time to
split this up further at the moment, as this is really non-trivial, but
maybe Shawn is willing to take it if someone does a proper review of the
patch.

With this series applied it should be easy to add the required power
domains and regulator handling for mx6sx.

Regards,
Lucas

