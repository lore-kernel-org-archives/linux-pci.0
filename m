Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bes.se.axis.com ([195.60.68.10]:41673 "EHLO bes.se.axis.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751566AbcEGLpg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sat, 7 May 2016 07:45:36 -0400
Date: Sat, 7 May 2016 13:45:31 +0200
From: Jesper Nilsson <jesper.nilsson@axis.com>
To: Rob Herring <robh@kernel.org>
Cc: Niklas Cassel <niklass@axis.com>, jespern@axis.com,
	pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	linux-arm-kernel@axis.com, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: pci: add DT binding for Axis ARTPEC-6
 PCIe controller
Message-ID: <20160507114531.GI24250@axis.com>
References: <1462362857-27481-1-git-send-email-niklass@axis.com>
 <20160505220331.GA9225@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160505220331.GA9225@rob-hp-laptop>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 05, 2016 at 05:03:31PM -0500, Rob Herring wrote:
> On Wed, May 04, 2016 at 01:54:17PM +0200, Niklas Cassel wrote:
> > From: Niklas Cassel <niklas.cassel@axis.com>
> > 
> > This commit adds the Device Tree binding documentation that allows to
> > describe the PCIe controller found in the Axis ARTPEC-6 SoC.
> > 
> > Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
> > ---
> >  .../devicetree/bindings/pci/axis,artpec6-pcie.txt  | 45 ++++++++++++++++++++++
> >  1 file changed, 45 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt b/Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt
> > new file mode 100644
> > index 0000000..fdac2a2
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt
> > @@ -0,0 +1,45 @@
> > +* Axis ARTPEC-6 PCIe interface
> > +
> > +This PCIe host controller is based on the Synopsis Designware PCIe IP
> > +and thus inherits all the common properties defined in designware-pcie.txt.
> > +
> > +Required properties:
> > +- compatible: "axis,artpec6-pcie", "snps,dw-pcie"
> > +- reg: base addresses and lengths of the pcie controller (DBI),
> > +	the phy controller, and configuration address space.
> > +- reg-names: Must include the following entries:
> > +	- "dbi"
> > +	- "phy"
> > +	- "config"
> > +- interrupts: A list of interrupt outputs of the controller. Must contain an
> > +  entry for each entry in the interrupt-names property.
> > +- interrupt-names: Must include the following entries:
> > +	- "msi": The interrupt that is asserted when an MSI is received
> > +- syscon: Should contain a link to the syscon device node.
> 
> What is the syscon for? Perhaps a name that reflects the purpose.

It's the SoC System Controller, and holds some chip-specific registers
for the Synopsys IP control, clocks and some termination variables spring
to mind. It was named sysctrl earlier, although that's not very much more
descriptive.

> Rob

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
