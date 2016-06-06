Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38979 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750933AbcFFSKy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 6 Jun 2016 14:10:54 -0400
Date: Mon, 6 Jun 2016 13:10:49 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Murali Karicheri <m-karicheri2@ti.com>
Cc: Po Liu <po.liu@nxp.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Roy Zang <roy.zang@nxp.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Stuart Yoder <stuart.yoder@nxp.com>,
	Yang-Leo Li <leoyang.li@nxp.com>,
	Minghuan Lian <minghuan.lian@nxp.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Mingkai Hu <mingkai.hu@nxp.com>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 2/2] aer: add support aer interrupt with none
 MSI/MSI-X/INTx mode
Message-ID: <20160606181049.GA15171@localhost>
References: <1464242406-20203-1-git-send-email-po.liu@nxp.com>
 <20160602034828.GA10240@localhost>
 <VI1PR0401MB1709E215DCE264B2C27B3DAB92580@VI1PR0401MB1709.eurprd04.prod.outlook.com>
 <20160602135546.GA8262@localhost>
 <575052B8.3090203@ti.com>
 <20160603040952.GA17904@localhost>
 <5751BEDF.3040300@ti.com>
 <20160604034852.GA15143@localhost>
 <DB5PR0401MB1702AF829693255DFC347448925C0@DB5PR0401MB1702.eurprd04.prod.outlook.com>
 <57558248.4010502@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <57558248.4010502@ti.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 06, 2016 at 10:01:44AM -0400, Murali Karicheri wrote:
> On 06/06/2016 03:32 AM, Po Liu wrote:
> > Hi Bjorn,
> > I confirm we met same problem with KeyStone base on DesignWare design.
> > 
> > 
> > Best regards,
> > Liu Po
> > 
> >>  -----Original Message-----
> >>  From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> >>  Sent: Saturday, June 04, 2016 11:49 AM
> >>  To: Murali Karicheri
> >>  Cc: Po Liu; linux-pci@vger.kernel.org; linux-arm-
> >>  kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> >>  devicetree@vger.kernel.org; Arnd Bergmann; Roy Zang; Marc Zyngier;
> >>  Stuart Yoder; Yang-Leo Li; Minghuan Lian; Bjorn Helgaas; Shawn Guo;
> >>  Mingkai Hu; Rob Herring
> >>  Subject: Re: [PATCH 2/2] aer: add support aer interrupt with none
> >>  MSI/MSI-X/INTx mode
> >>  
> >>  On Fri, Jun 03, 2016 at 01:31:11PM -0400, Murali Karicheri wrote:
> >>  > Po,
> >>  >
> >>  > Sorry to hijack your discussion, but the problem seems to be same for
> >>  > Keystone PCI controller which is also designware (old version) based.
> >>  >
> >>  > On 06/03/2016 12:09 AM, Bjorn Helgaas wrote:
> >>  > > On Thu, Jun 02, 2016 at 11:37:28AM -0400, Murali Karicheri wrote:
> >>  > >> On 06/02/2016 09:55 AM, Bjorn Helgaas wrote:
> >>  > >>> On Thu, Jun 02, 2016 at 05:01:19AM +0000, Po Liu wrote:
> >>  > >>>>>  -----Original Message-----
> >>  > >>>>>  From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> >>  > >>>>>  Sent: Thursday, June 02, 2016 11:48 AM
> >>  > >>>>>  To: Po Liu
> >>  > >>>>>  Cc: linux-pci@vger.kernel.org;
> >>  > >>>>> linux-arm-kernel@lists.infradead.org;
> >>  > >>>>>  linux-kernel@vger.kernel.org; devicetree@vger.kernel.org; Arnd
> >>  > >>>>> Bergmann;  Roy Zang; Marc Zyngier; Stuart Yoder; Yang-Leo Li;
> >>  > >>>>> Minghuan Lian; Bjorn  Helgaas; Shawn Guo; Mingkai Hu; Rob
> >>  > >>>>> Herring
> >>  > >>>>>  Subject: Re: [PATCH 2/2] aer: add support aer interrupt with
> >>  > >>>>> none  MSI/MSI-X/INTx mode
> >>  > >>>>>
> >>  > >>>>>  [+cc Rob]
> >>  > >>>>>
> >>  > >>>>>  Hi Po,
> >>  > >>>>>
> >>  > >>>>>  On Thu, May 26, 2016 at 02:00:06PM +0800, Po Liu wrote:
> >>  > >>>>>  > On some platforms, root port doesn't support MSI/MSI-X/INTx
> >>  in RC mode.
> >>  > >>>>>  > When chip support the aer interrupt with none MSI/MSI-X/INTx
> >>  > >>>>> mode,  > maybe there is interrupt line for aer pme etc. Search
> >>  > >>>>> the interrupt  > number in the fdt file.
> >>  > >>>>>
> >>  > >>>>>  My understanding is that AER interrupt signaling can be done
> >>  > >>>>> via INTx,  MSI, or MSI-X (PCIe spec r3.0, sec 6.2.4.1.2).
> >>  > >>>>> Apparently your device  doesn't support MSI or MSI-X.  Are you
> >>  > >>>>> saying it doesn't support INTx  either?  How is the interrupt
> >>  you're requesting here different from INTx?
> >>  > >>>>
> >>  > >>>> Layerscape use none of MSI or MSI-X or INTx to indicate the
> >>  > >>>> devices or root error in RC mode. But use an independent SPI
> >>  > >>>> interrupt(arm interrupt controller) line.
> >>  > >>>
> >>  > >>> The Root Port is a PCI device and should follow the normal PCI
> >>  > >>> rules for interrupts.  As far as I understand, that means it
> >>  > >>> should use MSI, MSI-X, or INTx.  If your Root Port doesn't use MSI
> >>  > >>> or MSI-X, it should use INTx, the PCI_INTERRUPT_PIN register
> >>  > >>> should tell us which (INTA/ INTB/etc.), and
> >>  PCI_COMMAND_INTX_DISABLE should work to disable it.
> >>  > >>> That's all from the PCI point of view, of course.
> >>  > >>
> >>  > >> I am faced with the same issue on Keystone PCI hardware and it has
> >>  > >> been on my TODO list  for quite some time. Keystone PCI hardware
> >>  > >> also doesn't use MSI or MSI-X or INTx for reporting errors received
> >>  > >> at the root port, but use a platform interrupt instead (not
> >>  > >> complaint to PCI standard as per PCI base spec). So I would need
> >>  > >> similar change to have the error interrupt passed to the aer
> >>  > >> driver. So there are hardware out there like Keystone which
> >>  requires to support this through platform IRQ.
> >>  > >
> >>  > > This is not a new area of the spec, and it's hard for me to believe
> >>  > > that these two new PCIe controllers are both broken the same way
> >>  > > (although I guess both are DesignWare-based, so maybe this is the
> >>  > > same underlying problem in both cases?).  I think it's more likely
> >>  > > that we just haven't figured out the right way to describe this in
> >>  the DT.
> >>  >
> >>  > Keystone is using an older version of the designware IP and it
> >>  > implements all of the interrupts in the application register space
> >>  > unlike other newer version of the hardware. So I assume, the version
> >>  > used on Layerscape is also an older version and the both have same
> >>  > issue in terms of non standard platform interrupt used for error
> >>  reporting.
> >>  >
> >>  > > I assume you have a Root Port with an AER capability, no MSI
> >>  > > capability, and no MSI-X capability, right?
> >>  >
> >>  > Has AER capability and both MSI and INTx (legacy) capability
> >>  >
> >>  > > What does its Interrupt
> >>  > > Pin register contain?  If it's zero, it doesn't use INTx either, so
> >>  > > according to the spec it should generate no interrupts.
> >>  > >
> >>  > At address offset 0x3C by default has a value of 1, but it is writable
> >>  > by software. So default is INTx A.
> >>  
> >>  0x3c is the Interrupt *Line*, which is read/write.  The Interrupt
> >>  *Pin* is at 0x3d and should be read-only.
> >>  
> 
> You are right. But default is 1 at this address.
> 
> >>  Does your Keystone driver support MSI?  If so, since your Root Port
> >>  supports MSI, I would think we would use that by default, and the INTx
> >>  stuff wouldn't even matter.
> > 
> > Layerscape is also shows "Both message signaled interrupts (MSI) and legacy INTx are supported."
> > But both of them not work for AER interrupt when devices or root port report aer error.
> > But another GIC interrupt line do.
> 
> Same with Keystone. Even though both MSI and INTx are supported
> error interrupt at root port is reported on a different interrupt
> line than MSI/INTx. So for Power Management event interrupt is also
> different line.

I'm looking at the "Error Message Controls" diagram in the PCIe spec
r3.0, sec 6.2.6.  Does this hardware fit into the platform-specific
"System Error" case there?  Do the Root Control enable bits (in the
PCIe Capability) control this interrupt?  If so, maybe this makes more
sense than I thought.

We have to assume both notification paths work (the normal
INTx/MSI/MSI-X AER interrupts as well as the platform-specific System
Errors), so if we add support for System Errors, it should be
structured so we prefer INTx/MSI/MSI-X, and only fall back to System
Errors if they don't work.  AER would have to know which path it's
using so aer_enable_rootport() can disable the other one (currently it
always disables System Errors).

Then you'd have to add quirks to mark MSI/MSI-X/INTx as being broken
on your devices to force the fallback to System Errors.

How much would this screw up other PCIe services (PME, hotplug, VC,
etc)?  Does MSI work for them?

Bjorn
