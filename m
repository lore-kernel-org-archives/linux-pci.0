Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:50259 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752086AbbKJJtI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 10 Nov 2015 04:49:08 -0500
Message-ID: <1447148944.3142.10.camel@pengutronix.de>
Subject: Re: [PATCH RFC] PCI: imx6: add dt prop for link gen, default to gen1
From: Lucas Stach <l.stach@pengutronix.de>
To: Tim Harvey <tharvey@gateworks.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Fabio Estevam <fabio.estevam@freescale.com>
Date: Tue, 10 Nov 2015 10:49:04 +0100
In-Reply-To: <CAJ+vNU1ME+LgHohZv1oy9MbZ-Y+U44ihVasjEnvw2AAcr40RHg@mail.gmail.com>
References: <1446735481-27326-1-git-send-email-tharvey@gateworks.com>
	 <1446802576.3126.5.camel@pengutronix.de>
	 <CAJ+vNU1ME+LgHohZv1oy9MbZ-Y+U44ihVasjEnvw2AAcr40RHg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Freitag, den 06.11.2015, 11:59 -0800 schrieb Tim Harvey:
> On Fri, Nov 6, 2015 at 1:36 AM, Lucas Stach <l.stach@pengutronix.de> wrote:
> > Am Donnerstag, den 05.11.2015, 06:58 -0800 schrieb Tim Harvey:
> >> Freescale has stated [1] that the LVDS clock source of the IMX6 does not pass
> >> the PCI Gen2 clock jitter test, therefore unless an external Gen2 compliant
> >> external clock source is present and supplied back to the IMX6 PCIe core
> >> via LVDS CLK1/CLK2 you can not claim Gen2 compliance.
> >>
> >> Add a dt property to specify gen1 vs gen2 and check this before allowing
> >> a Gen2 link.
> >>
> > I think I already said this in the last round: there is nothing vendor
> > specific in a max-link-speed property. I would really like to have this
> > as a common DW PCIe property right from the beginning, so that we don't
> > burden us with keeping backward compatibility with vendor specific
> > properties when this moves to common code eventually.
> 
> Hi Lucas,
> 
> I did discuss this patch with you off-list but I think I misunderstood
> your meaning then.
> 
> So you are asking me to simply rename the properly
> 'fsl,max-link-speed' to 'max-link-speed' and the rest of the patch is
> good with you?
> 
Yes, rename to max-link-speed. Move parsing of the property to
dw_pcie_host_init() (it is a common property, so must be in common code)
before the call to ops->host_init and store value into the pcie_port
structure with -1 meaning property in DT is missing.

imx6_pcie_establish_link can the treat values of -1 and 1 the same, only
allowing Gen2 if the value is 2.

Regards,
Lucas
-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

