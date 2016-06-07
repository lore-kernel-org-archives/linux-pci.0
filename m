Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 7 Jun 2016 17:46:34 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Po Liu <po.liu@nxp.com>
Subject: Re: [PATCH 2/2] aer: add support aer interrupt with none
 MSI/MSI-X/INTx mode
Message-ID: <20160607224634.GB2543@localhost>
References: <VI1PR0401MB1709E215DCE264B2C27B3DAB92580@VI1PR0401MB1709.eurprd04.prod.outlook.com>
 <20160602135546.GA8262@localhost> <575052B8.3090203@ti.com>
 <20160603040952.GA17904@localhost> <5751BEDF.3040300@ti.com>
 <20160604034852.GA15143@localhost>
 <DB5PR0401MB1702AF829693255DFC347448925C0@DB5PR0401MB1702.eurprd04.prod.outlook.com>
 <57558248.4010502@ti.com> <20160606181049.GA15171@localhost>
 <VI1PR0401MB17093077A7F0E3C52AC3392D925D0@VI1PR0401MB1709.eurprd04.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <VI1PR0401MB17093077A7F0E3C52AC3392D925D0@VI1PR0401MB1709.eurprd04.prod.outlook.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Roy Zang <roy.zang@nxp.com>, Arnd Bergmann <arnd@arndb.de>,
 devicetree@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Stuart Yoder <stuart.yoder@nxp.com>, Minghuan Lian <minghuan.lian@nxp.com>,
 Murali Karicheri <m-karicheri2@ti.com>, linux-arm-kernel@lists.infradead.org,
 Bjorn Helgaas <bhelgaas@google.com>, Yang-Leo Li <leoyang.li@nxp.com>,
 Shawn Guo <shawnguo@kernel.org>, Mingkai Hu <mingkai.hu@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 07, 2016 at 10:07:40AM +0000, Po Liu wrote:
> Hi Bjorn,
> 
> >  -----Original Message-----
> >  
> >  On Mon, Jun 06, 2016 at 10:01:44AM -0400, Murali Karicheri wrote:
> >  > On 06/06/2016 03:32 AM, Po Liu wrote:
> >  > > Hi Bjorn,
> >  > > I confirm we met same problem with KeyStone base on DesignWare
> >  design.
> >  > >
> >  > >
> >  > > Best regards,
> >  > > Liu Po
> >  > >
> >  > >>  -----Original Message-----
> >  > >>  From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> >  > >>  Sent: Saturday, June 04, 2016 11:49 AM
> >  > >>  To: Murali Karicheri
> >  > >>  Cc: Po Liu; linux-pci@vger.kernel.org; linux-arm-
> >  > >> kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> >  > >> devicetree@vger.kernel.org; Arnd Bergmann; Roy Zang; Marc Zyngier;
> >  > >> Stuart Yoder; Yang-Leo Li; Minghuan Lian; Bjorn Helgaas; Shawn Guo;
> >  > >> Mingkai Hu; Rob Herring
> >  > >>  Subject: Re: [PATCH 2/2] aer: add support aer interrupt with none
> >  > >> MSI/MSI-X/INTx mode
> >  > >>
> >  > >>  On Fri, Jun 03, 2016 at 01:31:11PM -0400, Murali Karicheri wrote:
> >  > >>  > Po,
> >  > >>  >
> >  > >>  > Sorry to hijack your discussion, but the problem seems to be
> >  > >> same for  > Keystone PCI controller which is also designware (old
> >  version) based.
> >  > >>  >
> >  > >>  > On 06/03/2016 12:09 AM, Bjorn Helgaas wrote:
> >  > >>  > > On Thu, Jun 02, 2016 at 11:37:28AM -0400, Murali Karicheri
> >  wrote:
> >  > >>  > >> On 06/02/2016 09:55 AM, Bjorn Helgaas wrote:
> >  > >>  > >>> On Thu, Jun 02, 2016 at 05:01:19AM +0000, Po Liu wrote:
> >  > >>  > >>>>>  -----Original Message-----  > >>>>>  From: Bjorn Helgaas
> >  > >> [mailto:helgaas@kernel.org]  > >>>>>  Sent: Thursday, June 02, 2016
> >  > >> 11:48 AM  > >>>>>  To: Po Liu  > >>>>>  Cc:
> >  > >> linux-pci@vger.kernel.org;  > >>>>>
> >  > >> linux-arm-kernel@lists.infradead.org;
> >  > >>  > >>>>>  linux-kernel@vger.kernel.org; devicetree@vger.kernel.org;
> >  > >> Arnd  > >>>>> Bergmann;  Roy Zang; Marc Zyngier; Stuart Yoder;
> >  > >> Yang-Leo Li;  > >>>>> Minghuan Lian; Bjorn  Helgaas; Shawn Guo;
> >  > >> Mingkai Hu; Rob  > >>>>> Herring  > >>>>>  Subject: Re: [PATCH 2/2]
> >  > >> aer: add support aer interrupt with  > >>>>> none  MSI/MSI-X/INTx
> >  > >> mode  > >>>>>  > >>>>>  [+cc Rob]  > >>>>>  > >>>>>  Hi Po,  >
> >  > >> >>>>>  > >>>>>  On Thu, May 26, 2016 at 02:00:06PM +0800, Po Liu
> >  > >> wrote:
> >  > >>  > >>>>>  > On some platforms, root port doesn't support
> >  > >> MSI/MSI-X/INTx  in RC mode.
> >  > >>  > >>>>>  > When chip support the aer interrupt with none
> >  > >> MSI/MSI-X/INTx  > >>>>> mode,  > maybe there is interrupt line for
> >  > >> aer pme etc. Search  > >>>>> the interrupt  > number in the fdt
> >  file.
> >  > >>  > >>>>>
> >  > >>  > >>>>>  My understanding is that AER interrupt signaling can be
> >  > >> done  > >>>>> via INTx,  MSI, or MSI-X (PCIe spec r3.0, sec
> >  6.2.4.1.2).
> >  > >>  > >>>>> Apparently your device  doesn't support MSI or MSI-X.  Are
> >  > >> you  > >>>>> saying it doesn't support INTx  either?  How is the
> >  > >> interrupt  you're requesting here different from INTx?
> >  > >>  > >>>>
> >  > >>  > >>>> Layerscape use none of MSI or MSI-X or INTx to indicate the
> >  > >> > >>>> devices or root error in RC mode. But use an independent SPI
> >  > >> > >>>> interrupt(arm interrupt controller) line.
> >  > >>  > >>>
> >  > >>  > >>> The Root Port is a PCI device and should follow the normal
> >  > >> PCI  > >>> rules for interrupts.  As far as I understand, that
> >  > >> means it  > >>> should use MSI, MSI-X, or INTx.  If your Root Port
> >  > >> doesn't use MSI  > >>> or MSI-X, it should use INTx, the
> >  > >> PCI_INTERRUPT_PIN register  > >>> should tell us which (INTA/
> >  > >> INTB/etc.), and  PCI_COMMAND_INTX_DISABLE should work to disable it.
> >  > >>  > >>> That's all from the PCI point of view, of course.
> >  > >>  > >>
> >  > >>  > >> I am faced with the same issue on Keystone PCI hardware and
> >  > >> it has  > >> been on my TODO list  for quite some time. Keystone
> >  > >> PCI hardware  > >> also doesn't use MSI or MSI-X or INTx for
> >  > >> reporting errors received  > >> at the root port, but use a
> >  > >> platform interrupt instead (not  > >> complaint to PCI standard as
> >  > >> per PCI base spec). So I would need  > >> similar change to have
> >  > >> the error interrupt passed to the aer  > >> driver. So there are
> >  > >> hardware out there like Keystone which  requires to support this
> >  through platform IRQ.
> >  > >>  > >
> >  > >>  > > This is not a new area of the spec, and it's hard for me to
> >  > >> believe  > > that these two new PCIe controllers are both broken
> >  > >> the same way  > > (although I guess both are DesignWare-based, so
> >  > >> maybe this is the  > > same underlying problem in both cases?).  I
> >  > >> think it's more likely  > > that we just haven't figured out the
> >  > >> right way to describe this in  the DT.
> >  > >>  >
> >  > >>  > Keystone is using an older version of the designware IP and it
> >  > >> > implements all of the interrupts in the application register
> >  > >> space  > unlike other newer version of the hardware. So I assume,
> >  > >> the version  > used on Layerscape is also an older version and the
> >  > >> both have same  > issue in terms of non standard platform interrupt
> >  > >> used for error  reporting.
> >  > >>  >
> >  > >>  > > I assume you have a Root Port with an AER capability, no MSI
> >  > >> > > capability, and no MSI-X capability, right?
> >  > >>  >
> >  > >>  > Has AER capability and both MSI and INTx (legacy) capability  >
> >  > >> > > What does its Interrupt  > > Pin register contain?  If it's
> >  > >> zero, it doesn't use INTx either, so  > > according to the spec it
> >  > >> should generate no interrupts.
> >  > >>  > >
> >  > >>  > At address offset 0x3C by default has a value of 1, but it is
> >  > >> writable  > by software. So default is INTx A.
> >  > >>
> >  > >>  0x3c is the Interrupt *Line*, which is read/write.  The Interrupt
> >  > >>  *Pin* is at 0x3d and should be read-only.
> >  > >>
> >  >
> >  > You are right. But default is 1 at this address.
> >  >
> >  > >>  Does your Keystone driver support MSI?  If so, since your Root
> >  > >> Port  supports MSI, I would think we would use that by default, and
> >  > >> the INTx  stuff wouldn't even matter.
> >  > >
> >  > > Layerscape is also shows "Both message signaled interrupts (MSI) and
> >  legacy INTx are supported."
> >  > > But both of them not work for AER interrupt when devices or root
> >  port report aer error.
> >  > > But another GIC interrupt line do.
> >  >
> >  > Same with Keystone. Even though both MSI and INTx are supported error
> >  > interrupt at root port is reported on a different interrupt line than
> >  > MSI/INTx. So for Power Management event interrupt is also different
> >  > line.
> >  
> >  I'm looking at the "Error Message Controls" diagram in the PCIe spec
> >  r3.0, sec 6.2.6.  Does this hardware fit into the platform-specific
> >  "System Error" case there?  Do the Root Control enable bits (in the PCIe
> >  Capability) control this interrupt?  If so, maybe this makes more sense
> >  than I thought.
> 
> It supposedly not the "System Error" case. But "the Error Interrupt" case.
> Which means " Root Error Command register " could control the interrupt
>  line we have now. (refer PCIe spec r3.0, sec 6.2.6)

Did you actually try this out and verify that the PCIe Root Control
enable bits have no effect and the AER Root Error Command bits do
control it?  The names are very similar, so there's lots of room for
misunderstanding here :)

If the AER Root Error Command does control this interrupt, I think the
PCI_COMMAND_INTX_DISABLE bit in the PCI Command register should also
control it (per sec 6.2.4.1.2).

> May this kind of hardware design route broken the spec? 

If the Reporting Enable bits in the Root Port's AER Root Error Command
register control the interrupt, but the interrupt is not delivered via
the Root Port's INTx or MSI/MSI-X, I think the design is not following
the spec.

All the information needed by the AER driver should be communicated
via the config space mechanisms described in the spec (AER capability,
MSI/MSI-X capabilities, Interrupt Pin, etc.)  That way the driver
works without change on future spec-compliant hardware.

> PME also like the AER. Hotplug is not supported. Others not known.
> Po Liu

Per sec 6.1.6, I think PME *should* be signaled by the Root Port's
INTx or MSI/MSI-X.

In particular, it says "Note that all other interrupt sources within
the same Function will assert the same virtual INTx wire when
requesting service."  To me, that means that if we're using INTx, it
will be the same INTx for AER, PME, hotplug, etc., and it should be
the one indicated by the Interrupt Pin register.

But I think on your Root Port:

  - There is an MSI capability, but MSI doesn't actually work at all
  - Interrupt Pin contains 1, indicating INTA, which is routed to IRQ X
  - AER interrupts are routed to some different IRQ Y
  - PME interrupts are routed to a third IRQ Z

So how should we work around this?  I think you should be able to get
partway there with a quirk that sets:

  dev->no_msi = 1;
  dev->irq = Y;

for this device.  That should make AER work, but of course PME would
not work.

Is there a way to set up your interrupt controller so these three
interrupts (X, Y, Z above) all map to the same Linux IRQ?  If you can
do that, you could set up INTA, the AER interrupt, and the PME
interrupt to all be on the same IRQ and everything should work.

Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
