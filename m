Return-Path: <SRS0=OT3g=73=chromium.org=briannorris@kernel.org>
Return-Path: <SRS0=OT3g=73=chromium.org=briannorris@kernel.org>
Date: Thu, 24 Aug 2017 19:11:32 -0700
From: Brian Norris <briannorris@chromium.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jeffy Chen <jeffy.chen@rock-chips.com>, linux-kernel@vger.kernel.org,
	bhelgaas@google.com, shawn.lin@rock-chips.com,
	dianders@chromium.org, devicetree@vger.kernel.org,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 3/4] dt-bindings: PCI: rockchip: Add support for pcie
 wake irq
Message-ID: <20170825021132.GA104845@google.com>
References: <20170822031934.8675-1-jeffy.chen@rock-chips.com>
 <20170822031934.8675-4-jeffy.chen@rock-chips.com>
 <20170824165353.GL31858@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170824165353.GL31858@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 24, 2017 at 11:53:54AM -0500, Bjorn Helgaas wrote:
> On Tue, Aug 22, 2017 at 11:19:33AM +0800, Jeffy Chen wrote:
> > Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>

> > diff --git a/Documentation/devicetree/bindings/pci/rockchip-pcie.txt b/Documentation/devicetree/bindings/pci/rockchip-pcie.txt
> > index 5678be82530d..9f6504129e80 100644
> > --- a/Documentation/devicetree/bindings/pci/rockchip-pcie.txt
> > +++ b/Documentation/devicetree/bindings/pci/rockchip-pcie.txt
> > @@ -20,10 +20,13 @@ Required properties:
> >  - msi-map: Maps a Requester ID to an MSI controller and associated
> >  	msi-specifier data. See ./pci-msi.txt
> >  - interrupts: Three interrupt entries must be specified.
> > -- interrupt-names: Must include the following names
> > -	- "sys"
> > -	- "legacy"
> > -	- "client"
> > +- interrupt-names: Include the following names
> > +	Required:
> > +		- "sys"
> > +		- "legacy"
> > +		- "client"
> > +	Optional:
> > +		- "wake"
> 
> Why is there no other PCI binding that includes "wake" as an
> interrupt-name?  This feels like something that should be fairly
> common across host controllers.  I don't want a Rockport-specific

s/port/chip/ :)

> DT description if it could be made more general.

I'm not sure we can really answer that question ("why do no other PCI
bindings have this?"). But one guess would be that every other
controller uses only beacon wake.

It would be OK with me if we made a blanket statement that a controller
with a "wake" interrupt means PCI WAKE# (per the specification). It's
possible this could even be stuck into some generic PCI/DT code
eventually. (I don't think we have a really good place for this today.)

Brian

> >  - resets: Must contain seven entries for each entry in reset-names.
> >  	   See ../reset/reset.txt for details.
> >  - reset-names: Must include the following names
> > @@ -87,10 +90,11 @@ pcie0: pcie@f8000000 {
> >  	clock-names = "aclk", "aclk-perf",
> >  		      "hclk", "pm";
> >  	bus-range = <0x0 0x1>;
> > -	interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH 0>,
> > -		     <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH 0>,
> > -		     <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH 0>;
> > -	interrupt-names = "sys", "legacy", "client";
> > +	interrupts-extended = <&gic GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH 0>,
> > +			      <&gic GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH 0>,
> > +			      <&gic GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH 0>,
> > +			      <&gpio0 8 IRQ_TYPE_LEVEL_LOW>;
> > +	interrupt-names = "sys", "legacy", "client", "wake";
> >  	assigned-clocks = <&cru SCLK_PCIEPHY_REF>;
> >  	assigned-clock-parents = <&cru SCLK_PCIEPHY_REF100M>;
> >  	assigned-clock-rates = <100000000>;
> > -- 
> > 2.11.0
> > 
> > 
