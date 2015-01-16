Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45944 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751312AbbAPKpM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 16 Jan 2015 05:45:12 -0500
Message-ID: <1421405098.4015.4.camel@pengutronix.de>
Subject: Re: [PATCH v2 0/4] Add support for kosagi novena
From: Lucas Stach <l.stach@pengutronix.de>
To: Sean Cross <xobs@kosagi.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Shawn Guo <shawn.guo@freescale.com>,
	devicetree@vger.kernel.org, Richard Zhu <r65037@freescale.com>,
	Grant Likely <grant.likely@linaro.org>,
	linux-pci@vger.kernel.org, bunnie@kosagi.com
Date: Fri, 16 Jan 2015 11:44:58 +0100
In-Reply-To: <54B8EA1C.7070700@kosagi.com>
References: <1419237127-21763-1-git-send-email-xobs@kosagi.com>
	 <20150116004615.GF29776@google.com> <54B8EA1C.7070700@kosagi.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Freitag, den 16.01.2015, 18:38 +0800 schrieb Sean Cross:
> On 16/01/2015 08:46, Bjorn Helgaas wrote:
> > On Mon, Dec 22, 2014 at 04:32:03PM +0800, Sean Cross wrote:
> >> The Kosagi Novena mainboard contains an i.MX6, along with a PCI Express slot.
> >> This patchset adds regulator support to the PCI Express slot, and adds
> >> device tree support for the Novena mainboard.
> >>
> >> Changes since v1:
> >>     - Add 'kosagi' to vendor prefixes
> >>     - Add LCD panel to simple-panel
> >>     - Renamed power-supply to bus-supply
> >>     - Replaced devm_regulator_get() with devm_regulator_get_optional()
> >>     - Moved regulator_enable to imx6_add_pcie_port()
> >>     - Removed fpga@1 from spi definition in dts -- will use overlays instead
> >>
> >> Sean Cross (4):
> >>   drm/panel: simple: Add Innolux N133HSE panel support
> >>   devicetree: bindings: Add vendor prefix for Kosagi
> >>   PCI: imx6: Add power-supply support
> > I guess we're waiting on a response to Arnd's question about making this
> > more generic, so I'm dropping these from my queue pending that.
> >
> > Then we need a strategy for merging it since it crosses PCI/ARM/GPU.
> > Please propose a strategy; it looks like the PCI part doesn't technically
> > depend on the preceeding patches, but it's fine with me if you want to keep
> > it all together.
> >
> The PCI part was there because without it, the system hard-locks during
> boot without it.
> 
> However, I'm not sure that the power-supply is the correct approach,
> because I can still see lockups even with the switch in place. I still
> haven't found out the root cause of that problem.
> 
> One workaround is to simply enable that GPIO in the bootloader and leave
> it on permanently.  Doing this mimics behavior on other platforms where
> PCIe is permanently powered up, and since the patches are decoupled the
> PCI patch can be applied at a later time.
> 
> I'd prefer to drop the PCI patch for now.  Would you like me to submit a
> v3 with simply the drm/panel and devicetree patches?
> 
Please keep the PCIe supply regulator in your DT, but just mark it
always-on.
I looked into moving the bus-supply into the common designware driver,
but that needs some more work. I'll send out a series for this in the
next days. We can then always hook up the regulator properly after this
is done.

Please wait a bit until sending V3, I want to have another look at the
V2 novena DT.

Regards,
Lucas

