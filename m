Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Message-ID: <1494739656.22906.32.camel@mtkswgap22>
Subject: Re: [PATCH v3 2/2] dt-bindings: pcie: Add documentation for
 Mediatek PCIe
From: Ryder Lee <ryder.lee@mediatek.com>
To: Arnd Bergmann <arnd@arndb.de>
Date: Sun, 14 May 2017 13:27:36 +0800
In-Reply-To: <1494504718.19420.10.camel@mtkswgap22>
References: <1494382020-26790-1-git-send-email-ryder.lee@mediatek.com>
 <1494382020-26790-3-git-send-email-ryder.lee@mediatek.com>
 <CAK8P3a193RxchvFAMWeZiP0sc0bd+VGg=_aVvipSgcbDpHXojg@mail.gmail.com>
 <1494408707.31307.32.camel@mtkswgap22>
 <CAK8P3a1AUsUTNDnN+_9251sxC7R4vvkQRr37dvAke6ooCJ_oxg@mail.gmail.com>
 <1494470650.20742.36.camel@mtkswgap22>
 <CAK8P3a1FVyoFufnbQFjGovoQpkxMj3kaAgjb5Q+v-DQnYKeA-g@mail.gmail.com>
 <1494493719.9564.26.camel@mtkswgap22>
 <1494504718.19420.10.camel@mtkswgap22>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, Red Hung <red.hung@mediatek.com>,
 linux-pci <linux-pci@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 "moderated list:ARM/Mediatek SoC..." <linux-mediatek@lists.infradead.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>


Hi Arnd,

Sorry to bother you again.

On Thu, 2017-05-11 at 20:11 +0800, Ryder Lee wrote:
> > interrupt-map-mask = <0xff800 0 0 0>;
> > interrupt-map = <0x0000 0 0 0 &gic GIC_SPI 193 IRQ_TYPE_NONE>,
> > 		 <0x0800 0 0 0 &gic GIC_SPI 194 IRQ_TYPE_NONE>,
> > 		 <0x1000 0 0 0 &gic GIC_SPI 195 IRQ_TYPE_NONE>,
> > 
> > 		 /* workaround here*/
> > 		 <0x10000 0 0 0 &gic GIC_SPI 193 IRQ_TYPE_NONE>,
> > 		 <0x20000 0 0 0 &gic GIC_SPI 194 IRQ_TYPE_NONE>,
> > 	     <0x30000 0 0 0 &gic GIC_SPI 195 IRQ_TYPE_NONE>;
> > 
> > It works well. But how could we handle the situation if root port0
> > status = "disabled" ? I think we cannot assign child bus number
> > dynamically from binding.
> 
> That is to say, we route it statically if port0 (or port1) is
> unavailable. The PCI child bus enumeration should look something like
> this:
> 
>  pci 0000:00:01.0: fixup irq: got 224
>  pci 0000:00:01.0: assigning IRQ 224
>  pci 0000:00:02.0: fixup irq: got 225
>  pci 0000:00:02.0: assigning IRQ 225
>  
>  Go wrong here! IRQ 223/224 should be assigned to the devices behind
> port0 and port1.
>  pci 0000:01:00.0: fixup irq: got 223
>  pci 0000:01:00.0: assigning IRQ 223
>  pci 0000:02:00.0: fixup irq: got 224
>  pci 0000:02:00.0: assigning IRQ 224

What I thought was wrong. I have misunderstood something in previous
discussion. Actually it could work for the situation that I mentioned
before. However, I'm not sure whether this is a proper representation
you want to see.

> > > >> On a related note, I see that you still list
> > > >>
> > > >> > +- interrupts: Three interrupt outputs of the controller. Must contain an
> > > >> > +  entry for each entry in the interrupt-names property.
> > > >> > +- interrupt-names: Must include the following names
> > > >> > +  - "pcie-int0"
> > > >> > +  - "pcie-int1"
> > > >> > +  - "pcie-int2"
> > > >>
> > > >> This seems to be an artifact from the older version and should be
> > > >> removed as the driver correctly ignores the properties now.
> > > >
> > > > Actually, everything works fine without these properties however when it
> > > > loads we see a few weird error message:
> > > >
> > > > pcieport 0000:00:01.0: Signaling PME with IRQ 232
> > > > pcieport 0000:00:02.0: enabling device (0140 -> 0142)
> > > > pcieport 0000:00:02.0: enabling bus mastering
> > > > irq 232: nobody cared (try booting with the "irqpoll" option)
> > > > ...
> > > > [<c03f6be4>] (pcie_pme_probe) from [<c03f47b8>] (pcie_port_probe_service
> > > > +0x44/0x6c)
> > > > (pcie_port_probe_service) from [<c0454cf8>] (driver_probe_device
> > > > +0x280/0x470)
> > > > ...
> > > > (pcie_port_device_register) from [<c03f51a0>] (pcie_portdrv_probe
> > > > +0x3c/0xb4)
> > > > (pcie_portdrv_probe) from [<c03e7acc>] (pci_device_probe+0x98/0xfc)
> > > > (pci_device_probe) from [<c0454cf8>] (driver_probe_device+0x280/0x470)
> > > > handlers:
> > > > [<c03f68b0>] pcie_pme_irq
> > > > Disabling IRQ #233
> > > >
> > > > I haven't dig it out yet, but just keep them here to solve that.
> > > 
> > > Something is going very wrong if adding the properties helps. I can't
> > > think of what that is, but we have to find out before the binding can
> > > be merged.
> > 
> > Not really understand PME service. But I will find the reason here.
> 
> I have do some test here. PME needs port IRQs, which interrupt type was
> set correctly(IRQ_TYPE_LEVEL_LOW). But we cannot set it from
> interrupt-map, according to gic_set_type() /* SPIs have restrictions on
> the supported types */ .
> 
> So we need to add additional interrupt properties.

I could use iPerf to test my WLAN card normally. But just ignore this
exception message. I would definitely appreciate if someone could give
me some hint on how to properly solve it. 

Thanks a lot.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
