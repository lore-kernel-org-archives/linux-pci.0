Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34062 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754246AbcCAPCW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 1 Mar 2016 10:02:22 -0500
Date: Tue, 1 Mar 2016 09:02:11 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Tim Harvey <tharvey@gateworks.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Lucas Stach <l.stach@pengutronix.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Fabio Estevam <fabio.estevam@freescale.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2] PCI: imx6: add dt prop for link gen, default to gen1
Message-ID: <20160301150211.GA12752@localhost>
References: <1446735481-27326-1-git-send-email-tharvey@gateworks.com>
 <1447942365-11662-1-git-send-email-tharvey@gateworks.com>
 <20151125231435.GI8869@localhost>
 <CAJ+vNU0ar_d=2n4Yz3QX4qidSkH6PBLyfB8-w-ErLOYzwqj7rw@mail.gmail.com>
 <20160224200357.GB31108@localhost>
 <CAL_Jsq+O1vr6sVZeJ10GXLpEuhb5-kJVYrQe2EY7XB814FuF0Q@mail.gmail.com>
 <CAJ+vNU3gG=vdL__hpUa7D1OUMZcmPKqU1_hw5nGoJ3zxp6HO0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJ+vNU3gG=vdL__hpUa7D1OUMZcmPKqU1_hw5nGoJ3zxp6HO0A@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 29, 2016 at 06:41:29AM -0800, Tim Harvey wrote:
> On Wed, Feb 24, 2016 at 12:35 PM, Rob Herring <robh+dt@kernel.org> wrote:
> > On Wed, Feb 24, 2016 at 2:03 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> >> [+cc Rob, devicetree list]
> >>
> >> On Wed, Dec 02, 2015 at 08:35:06AM -0800, Tim Harvey wrote:
> >>> On Wed, Nov 25, 2015 at 3:14 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> >>> > On Thu, Nov 19, 2015 at 06:12:45AM -0800, Tim Harvey wrote:
> >>> >> Freescale has stated [1] that the LVDS clock source of the IMX6 does not pass
> >>> >> the PCI Gen2 clock jitter test, therefore unless an external Gen2 compliant
> >>> >> external clock source is present and supplied back to the IMX6 PCIe core
> >>> >> via LVDS CLK1/CLK2 you can not claim Gen2 compliance.
> >>> >>
> >>> >> Add a dt property to specify gen1 vs gen2 and check this before allowing
> >>> >> a Gen2 link.
> >>> >>
> >>> >> We default to Gen1 if the property is not present because at this time there
> >>> >> are no IMX6 boards in mainline that 'input' a clock on LVDS CLK1/CLK2.
> >>> >>
> >>> >> In order to be Gen2 compliant on IMX6 you need to:
> >>> >>  - have a Gen2 compliant external clock generator and route that clock back
> >>> >>    to either LVDS CLK1 or LVDS CLK2 as an input.
> >>> >>    (see IMX6SX-SabreSD reference design)
> >>> >>  - specify this clock in the pcie node in the dt
> >>> >>    (ie IMX6QDL_CLK_LVDS1_IN or IMX6QDL_CLK_LVDS2_IN instead of
> >>> >>     IMX6QDL_CLK_LVDS1_GATE which configures it as a CLK output)
> >>> >>
> >>> >> [1] https://community.freescale.com/message/453209
> >>> >>
> >>> >> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> >>> >> ---
> >>> >> v2:
> >>> >>  - moved dt property to designware core
> >>> >>
> >>> >>  .../devicetree/bindings/pci/designware-pcie.txt          |  1 +
> >>> >>  drivers/pci/host/pci-imx6.c                              | 16 ++++++++++------
> >>> >>  drivers/pci/host/pcie-designware.c                       |  4 ++++
> >>> >>  drivers/pci/host/pcie-designware.h                       |  1 +
> >>> >>  4 files changed, 16 insertions(+), 6 deletions(-)
> >>> >>
> >>> >> diff --git a/Documentation/devicetree/bindings/pci/designware-pcie.txt b/Documentation/devicetree/bindings/pci/designware-pcie.txt
> >>> >> index 9f4faa8..a9a94b9 100644
> >>> >> --- a/Documentation/devicetree/bindings/pci/designware-pcie.txt
> >>> >> +++ b/Documentation/devicetree/bindings/pci/designware-pcie.txt
> >>> >> @@ -26,3 +26,4 @@ Optional properties:
> >>> >>  - bus-range: PCI bus numbers covered (it is recommended for new devicetrees to
> >>> >>    specify this property, to keep backwards compatibility a range of 0x00-0xff
> >>> >>    is assumed if not present)
> >>> >> +- max-link-speed: Specify PCI gen for link capability (ie 2 for gen2)
> >>> >
> >>> > Is there some sort of DT or OF spec that lists "max-link-speed" as a
> >>> > generic property?  I see Lucas' desire to have this be common across
> >>> > DesignWare PCIe cores.  Should it be moved up a level even from there,
> >>> > i.e., to bindings/pci/pci.txt?
> >>>
> >>> I don't know what the general consensus is here. As your the PCI
> >>> maintainer I would leave that up to you. Are there other platforms
> >>> that need to link at a lesser capability than the host controller is
> >>> capable of? I am only aware of the IMX6 and SPEAr13XX [1]
> >>
> >> This is really a devicetree question, not a PCI one, so I added Rob
> >> and the devicetree list in case they have any comments on this.
> >
> > Seems generally useful to me. You could want to limit the speed for a
> > variety of reasons. There's no standard property that I'm aware of.
> >
> > Shouldn't this be a property of the phy though?
> >
> >>> > It might be worth mentioning in pci/fsl,imx6q-pcie.txt that we limit
> >>> > the link to gen1 unless max-link-speed is present and has the value
> >>> > "2".
> >>
> >> This default seems backwards.  It seems like we'd want to configure
> >> the link to go as fast as possible unless we have a quirk, e.g.,
> >> "max-link-speed", that imposes a device-specific link.  In other
> >> words, why don't we penalize the broken board instead of penalizing
> >> all the working ones?
> >
> > I agree. It could be argued that this way doesn't require a DT update
> > to fix broken boards. However, this problem should really be found
> > before production and DT updates are normal for enabling new features
> > (such as compliant PCIe).
> >
> > Rob
> 
> Rob,
> 
> In this case I feel that every IMX6 based board with PCIe likely has
> this issue because the original reference schematics from Freescale
> did not mention that the LVDS clock source from the IMX6 did not meet
> PCIe gen2 requirements so everyone blindly followed the reference
> design. Only later did they seem to come out with this information and
> if you did use an external clock you would have to setup the IMX6 pcie
> clocks differently in the device-tree (configuring the IMX6 to use a
> clock input instead of output), which I see no current boards doing.
> 
> There are several SoC's that use the designware core that likely are
> not in this same boat, so it would be unfair to penalize them by
> defaulting a gen1 speed tied to the mac. So yes, perhaps a property of
> the imx6 pcie phy and defaulting it to gen1 because no current
> device-tree's set the phy's clock as an external input makes the most
> sense?

I'm not an IMX6 expert, but this sounds good to me, so I'll look for a
new rev that does this.

Bjorn
