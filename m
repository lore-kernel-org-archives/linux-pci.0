Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Po Liu <po.liu@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Murali Karicheri <m-karicheri2@ti.com>
Subject: RE: [PATCH 2/2] aer: add support aer interrupt with none
 MSI/MSI-X/INTx mode
Date: Mon, 6 Jun 2016 07:32:52 +0000
Message-ID: <DB5PR0401MB1702AF829693255DFC347448925C0@DB5PR0401MB1702.eurprd04.prod.outlook.com>
References: <1464242406-20203-1-git-send-email-po.liu@nxp.com>
 <20160602034828.GA10240@localhost>
 <VI1PR0401MB1709E215DCE264B2C27B3DAB92580@VI1PR0401MB1709.eurprd04.prod.outlook.com>
 <20160602135546.GA8262@localhost> <575052B8.3090203@ti.com>
 <20160603040952.GA17904@localhost> <5751BEDF.3040300@ti.com>
 <20160604034852.GA15143@localhost>
In-Reply-To: <20160604034852.GA15143@localhost>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Roy Zang <roy.zang@nxp.com>, Arnd Bergmann <arnd@arndb.de>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Marc Zyngier <marc.zyngier@arm.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Stuart Yoder <stuart.yoder@nxp.com>, Minghuan Lian <minghuan.lian@nxp.com>,
 Mingkai Hu <mingkai.hu@nxp.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Yang-Leo Li <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,
I confirm we met same problem with KeyStone base on DesignWare design.


Best regards,
Liu Po

>  -----Original Message-----
>  From: Bjorn Helgaas [mailto:helgaas@kernel.org]
>  Sent: Saturday, June 04, 2016 11:49 AM
>  To: Murali Karicheri
>  Cc: Po Liu; linux-pci@vger.kernel.org; linux-arm-
>  kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
>  devicetree@vger.kernel.org; Arnd Bergmann; Roy Zang; Marc Zyngier;
>  Stuart Yoder; Yang-Leo Li; Minghuan Lian; Bjorn Helgaas; Shawn Guo;
>  Mingkai Hu; Rob Herring
>  Subject: Re: [PATCH 2/2] aer: add support aer interrupt with none
>  MSI/MSI-X/INTx mode
>  
>  On Fri, Jun 03, 2016 at 01:31:11PM -0400, Murali Karicheri wrote:
>  > Po,
>  >
>  > Sorry to hijack your discussion, but the problem seems to be same for
>  > Keystone PCI controller which is also designware (old version) based.
>  >
>  > On 06/03/2016 12:09 AM, Bjorn Helgaas wrote:
>  > > On Thu, Jun 02, 2016 at 11:37:28AM -0400, Murali Karicheri wrote:
>  > >> On 06/02/2016 09:55 AM, Bjorn Helgaas wrote:
>  > >>> On Thu, Jun 02, 2016 at 05:01:19AM +0000, Po Liu wrote:
>  > >>>>>  -----Original Message-----
>  > >>>>>  From: Bjorn Helgaas [mailto:helgaas@kernel.org]
>  > >>>>>  Sent: Thursday, June 02, 2016 11:48 AM
>  > >>>>>  To: Po Liu
>  > >>>>>  Cc: linux-pci@vger.kernel.org;
>  > >>>>> linux-arm-kernel@lists.infradead.org;
>  > >>>>>  linux-kernel@vger.kernel.org; devicetree@vger.kernel.org; Arnd
>  > >>>>> Bergmann;  Roy Zang; Marc Zyngier; Stuart Yoder; Yang-Leo Li;
>  > >>>>> Minghuan Lian; Bjorn  Helgaas; Shawn Guo; Mingkai Hu; Rob
>  > >>>>> Herring
>  > >>>>>  Subject: Re: [PATCH 2/2] aer: add support aer interrupt with
>  > >>>>> none  MSI/MSI-X/INTx mode
>  > >>>>>
>  > >>>>>  [+cc Rob]
>  > >>>>>
>  > >>>>>  Hi Po,
>  > >>>>>
>  > >>>>>  On Thu, May 26, 2016 at 02:00:06PM +0800, Po Liu wrote:
>  > >>>>>  > On some platforms, root port doesn't support MSI/MSI-X/INTx
>  in RC mode.
>  > >>>>>  > When chip support the aer interrupt with none MSI/MSI-X/INTx
>  > >>>>> mode,  > maybe there is interrupt line for aer pme etc. Search
>  > >>>>> the interrupt  > number in the fdt file.
>  > >>>>>
>  > >>>>>  My understanding is that AER interrupt signaling can be done
>  > >>>>> via INTx,  MSI, or MSI-X (PCIe spec r3.0, sec 6.2.4.1.2).
>  > >>>>> Apparently your device  doesn't support MSI or MSI-X.  Are you
>  > >>>>> saying it doesn't support INTx  either?  How is the interrupt
>  you're requesting here different from INTx?
>  > >>>>
>  > >>>> Layerscape use none of MSI or MSI-X or INTx to indicate the
>  > >>>> devices or root error in RC mode. But use an independent SPI
>  > >>>> interrupt(arm interrupt controller) line.
>  > >>>
>  > >>> The Root Port is a PCI device and should follow the normal PCI
>  > >>> rules for interrupts.  As far as I understand, that means it
>  > >>> should use MSI, MSI-X, or INTx.  If your Root Port doesn't use MSI
>  > >>> or MSI-X, it should use INTx, the PCI_INTERRUPT_PIN register
>  > >>> should tell us which (INTA/ INTB/etc.), and
>  PCI_COMMAND_INTX_DISABLE should work to disable it.
>  > >>> That's all from the PCI point of view, of course.
>  > >>
>  > >> I am faced with the same issue on Keystone PCI hardware and it has
>  > >> been on my TODO list  for quite some time. Keystone PCI hardware
>  > >> also doesn't use MSI or MSI-X or INTx for reporting errors received
>  > >> at the root port, but use a platform interrupt instead (not
>  > >> complaint to PCI standard as per PCI base spec). So I would need
>  > >> similar change to have the error interrupt passed to the aer
>  > >> driver. So there are hardware out there like Keystone which
>  requires to support this through platform IRQ.
>  > >
>  > > This is not a new area of the spec, and it's hard for me to believe
>  > > that these two new PCIe controllers are both broken the same way
>  > > (although I guess both are DesignWare-based, so maybe this is the
>  > > same underlying problem in both cases?).  I think it's more likely
>  > > that we just haven't figured out the right way to describe this in
>  the DT.
>  >
>  > Keystone is using an older version of the designware IP and it
>  > implements all of the interrupts in the application register space
>  > unlike other newer version of the hardware. So I assume, the version
>  > used on Layerscape is also an older version and the both have same
>  > issue in terms of non standard platform interrupt used for error
>  reporting.
>  >
>  > > I assume you have a Root Port with an AER capability, no MSI
>  > > capability, and no MSI-X capability, right?
>  >
>  > Has AER capability and both MSI and INTx (legacy) capability
>  >
>  > > What does its Interrupt
>  > > Pin register contain?  If it's zero, it doesn't use INTx either, so
>  > > according to the spec it should generate no interrupts.
>  > >
>  > At address offset 0x3C by default has a value of 1, but it is writable
>  > by software. So default is INTx A.
>  
>  0x3c is the Interrupt *Line*, which is read/write.  The Interrupt
>  *Pin* is at 0x3d and should be read-only.
>  
>  Does your Keystone driver support MSI?  If so, since your Root Port
>  supports MSI, I would think we would use that by default, and the INTx
>  stuff wouldn't even matter.

Layerscape is also shows "Both message signaled interrupts (MSI) and legacy INTx are supported."
But both of them not work for AER interrupt when devices or root port report aer error.
But another GIC interrupt line do.

>  
>  > > But if Interrupt Pin is non-zero, that means the Root Port should be
>  > > able to generate virtual INTx interrupts.  Presumably the Root
>  > > Complex connects those interrupts to something; maybe to your
>  > > platform interrupt?
>  >
>  > Probably that is what is happening. Both Power management and Error
>  > interrupts are raised on platform interrupt lines.
>  >
>  > 12 Error Interrupts
>  >
>  > [0] System error (OR of fatal, nonfatal, correctable errors) (RC mode
>  > only) [1] PCIe fatal error (RC mode only) [2] PCIe non-fatal error (RC
>  > mode only) [3] PCIe correctable error (RC mode only) [4] AXI Error due
>  > to fatal condition in AXI bridge (EP/RC modes) [5] PCIe advanced error
>  > (RC mode only)
>  >
>  > 13 Power management and reset event interrupts
>  >
>  > [0] Power management turn-off message interrupt (EP mode only) [1]
>  > Power management ack message interrupt (RC mode only) [2] Power
>  > management event interrupt (RC mode only) [3] Link request reset
>  > interrupt (hot reset or link down) (RC mode only)
>  >
>  > > PCI doesn't say anything about an interrupt after it leaves the Root
>  > > Complex, so the fact that it's connected to a "platform interrupt"
>  > > or "SPI interrupt" or "IOAPIC interrupt" doesn't make it non-
>  compliant.
>  > > Shouldn't we be able to use the interrupt-map and related DT
>  > > properties to express the fact that Root Port virtual INTx is routed
>  > > to platform interrupt Y, even without any special-case code in
>  > > portdrv?
>  >
>  > My understanding is if RC also raise interrupt on INTx, then below map
>  > make sense, where either EP or RC can raise interrupt and the line
>  > will be muxed for interrupt from EP or RC port.
>  
>  I'm sorry, I didn't quite catch your meaning here, so let me try to
>  clarify some terminology.  Maybe we'll eventually blunder into a common
>  understanding :)
>  
>  INTx is a PCI concept and only means something in the PCI hierarchy.
>  The RC would *receive* virtual INTx interrupts from the PCI hierarchy
>  and turn them into some platform-specific interrupt (not INTx) on the
>  upstream side.
>  
>  So strictly speaking, the RC might raise platform-specific interrupts
>  when it receives INTx interrupts, but it would not raise any INTx
>  interrupts itself.
>  
>  > Here is the DT entry in PCIE keystone for Legacy interrupt mapping to
>  > host interrupt.
>  >                         #interrupt-cells = <1>;
>  >                         interrupt-map-mask = <0 0 0 7>;
>  >                         interrupt-map = <0 0 0 1 &pcie_intc0 0>, /*
>  INT A */
>  >                                         <0 0 0 2 &pcie_intc0 1>, /*
>  INT B */
>  >                                         <0 0 0 3 &pcie_intc0 2>, /*
>  INT C */
>  >                                         <0 0 0 4 &pcie_intc0 3>; /*
>  > INT D */
>  
>  If I understand correctly, this is the mapping from the PCI world (INTA,
>  INTB, etc.) to the platform-specific world (pcie_intc0 0, etc.)
>  
>  If a Root Port raises a virtual INTA, the RC should turn it into the
>  corresponding platform interrupt, i.e., GIC_SPI 48 from the description
>  below.
>  
>  > And  then
>  >
>  >                         pcie_intc0: legacy-interrupt-controller {
>  >                                 interrupt-controller;
>  >                                 #interrupt-cells = <1>;
>  >                                 interrupt-parent = <&gic>;
>  >                                 interrupts = <GIC_SPI 48
>  IRQ_TYPE_EDGE_RISING>,
>  >                                         <GIC_SPI 49
>  IRQ_TYPE_EDGE_RISING>,
>  >                                         <GIC_SPI 50
>  IRQ_TYPE_EDGE_RISING>,
>  >                                         <GIC_SPI 51
>  IRQ_TYPE_EDGE_RISING>;
>  >                         };
>  >
>  > So if RC interrupt for Power management and Error interrupt is a
>  > separate line, how can software describe that using the above
>  interrupt map?
>  
>  I don't know anything about interrupts the RC might generate on its own
>  behalf.  A lot of the RC behavior is not specified by the PCIe spec
>  because the RC is on the border between the upstream platform-specific
>  stuff and the downstream PCIe stuff.  Is there something in the PCIe
>  spec about the power management and error interrupts you're talking
>  about?  Of maybe you can point me to a section of the Keystone spec that
>  talks about interrupts generated by the RC?

Below is one of the PCIE controller interrupts list: 

142 PEX1 INTA 
143 PEX1 INTB 
144 PEX1 INTC 
145 PEX1 INTD 
146-147 Reserved
148 PEX1 MSI 
149 PEX1 PME 
150 PEX1 CFG err interrupt

Only the "150 PEX1 CFG err interrupt" routing to the aer interrupt. 


>  
>  In any event, the AER interrupts we're looking for in portdrv are from
>  the Root Port, not from the RC.  For INTx, my understanding is that the
>  RC *transforms* virtual INTx messages from the Root Port in the PCIe
>  domain into GIC transactions in the platform domain.
>  
>  Bjorn
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
