Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Message-ID: <1494470650.20742.36.camel@mtkswgap22>
Subject: Re: [PATCH v3 2/2] dt-bindings: pcie: Add documentation for
 Mediatek PCIe
From: Ryder Lee <ryder.lee@mediatek.com>
To: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 11 May 2017 10:44:10 +0800
In-Reply-To: <CAK8P3a1AUsUTNDnN+_9251sxC7R4vvkQRr37dvAke6ooCJ_oxg@mail.gmail.com>
References: <1494382020-26790-1-git-send-email-ryder.lee@mediatek.com>
 <1494382020-26790-3-git-send-email-ryder.lee@mediatek.com>
 <CAK8P3a193RxchvFAMWeZiP0sc0bd+VGg=_aVvipSgcbDpHXojg@mail.gmail.com>
 <1494408707.31307.32.camel@mtkswgap22>
 <CAK8P3a1AUsUTNDnN+_9251sxC7R4vvkQRr37dvAke6ooCJ_oxg@mail.gmail.com>
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
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Bjorn Helgaas <bhelgaas@google.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2017-05-10 at 12:01 +0200, Arnd Bergmann wrote:
> On Wed, May 10, 2017 at 11:31 AM, Ryder Lee <ryder.lee@mediatek.com> wrote:
> > On Wed, 2017-05-10 at 10:08 +0200, Arnd Bergmann wrote:
> >> On Wed, May 10, 2017 at 4:07 AM, Ryder Lee <ryder.lee@mediatek.com> wrote:
> >>
> >> > +- ranges:
> >> > +  - The first three entries are expected to translate the addresses for the root
> >> > +    port registers, which are referenced by the assigned-addresses property of
> >> > +    the root port nodes (see below).
> >>
> >> I don't understand this part. Why do you need a static translation for these?
> >> Shouldn't they just be listed in the 'reg' property of the parent node now that
> >> you have the clk/reset/phy properties in the parent as well?
> >
> > At first, I did like that. But I noticed that someone suggest it's
> > better to use 'assigned-addresses' to handle per-port registers, the
> > same path as tegra and marvell did, in other platform discussion thread.
> > So I just put shared register in root node. It could be rolled back if
> > you feel this is inappropriate.
> 
> The marvell case is not a good example for your case: their top-level
> device is made up by the OS to help with the shared resource allocation,
> while in your case the bus bridge actually exists in hardware.
> 
> I'm not too familiar with the Tegra case, and haven't looked at that here,
> but it could be an artifact of how for a while we used to list the config
> space access in the top-level "ranges" instead of the "reg" property.
> 
> I'd vote for moving it back, for consistency with the other port specific
> properties that are now in the root node. Once you do that, the port
> nodes can be removed completely, which is what I was aiming for with
> the comments on the previous version.
 
I'll move it back.

> >> > +Required properties:
> >> > +- device_type: Must be "pci"
> >> > +- assigned-addresses: Address and size of the port configuration registers
> >> > +- reg: Only the first four bytes are used to refer to the correct bus number
> >> > +  and device number.
> >> > +- #address-cells: Must be 3
> >> > +- #size-cells: Must be 2
> >> > +- #interrupt-cells: Must be 1
> >> > +- interrupt-map-mask and interrupt-map: Standard PCI IRQ mapping properties
> >> > +  Please refer to the standard PCI bus binding document for a more detailed
> >> > +  explanation.
> >>
> >> Child nodes do not normally have interrupt-map properties. Isn't this
> >> already covered by the interrupt-map in the parent?
> >>
> >
> > I have one Intel 4 port ethernet card(0000:00:01) and MTK WLAN card
> > (0000:00:02), probe message looks good to me.
> >
> > pci 0000:00:01.0: fixup irq: got 224
> > pci 0000:00:01.0: assigning IRQ 224
> > pci 0000:00:02.0: fixup irq: got 225
> > pci 0000:00:02.0: assigning IRQ 225
> >
> > pci 0000:01:00.0: fixup irq: got 224
> > pci 0000:01:00.0: assigning IRQ 224
> > pci 0000:01:00.1: fixup irq: got 224
> > pci 0000:01:00.1: assigning IRQ 224
> > pci 0000:01:00.2: fixup irq: got 224
> > pci 0000:01:00.2: assigning IRQ 224
> > pci 0000:01:00.3: fixup irq: got 224
> > pci 0000:01:00.3: assigning IRQ 224
> >
> > pci 0000:02:00.0: fixup irq: got 225
> > pci 0000:02:00.0: assigning IRQ 225
> >
> >
> > But child nodes without interrupt-map properties:
> > It seems incorrect.
> >
> > pci 0000:00:01.0: fixup irq: got 224
> > pci 0000:00:01.0: assigning IRQ 224
> > pci 0000:00:02.0: fixup irq: got 225
> > pci 0000:00:02.0: assigning IRQ 225
> >
> > pci 0000:01:00.0: fixup irq: got 223
> > pci 0000:01:00.0: assigning IRQ 223
> 
> Not entirely sure what happens here, but I guess the problem
> is that the 'reg' portion of the parent interrupt-map refers to
> the port devices, not the devices attached the devices behind
> them.

I agree with you. That's why I need additional interrupt-map properties
to resolve IRQ correctly for the devices behind root ports.

Not sure whether other platforms have similar case like me here.

> On a related note, I see that you still list
> 
> > +- interrupts: Three interrupt outputs of the controller. Must contain an
> > +  entry for each entry in the interrupt-names property.
> > +- interrupt-names: Must include the following names
> > +  - "pcie-int0"
> > +  - "pcie-int1"
> > +  - "pcie-int2"
> 
> This seems to be an artifact from the older version and should be
> removed as the driver correctly ignores the properties now.

Actually, everything works fine without these properties however when it
loads we see a few weird error message:

pcieport 0000:00:01.0: Signaling PME with IRQ 232
pcieport 0000:00:02.0: enabling device (0140 -> 0142)
pcieport 0000:00:02.0: enabling bus mastering
irq 232: nobody cared (try booting with the "irqpoll" option)
...
[<c03f6be4>] (pcie_pme_probe) from [<c03f47b8>] (pcie_port_probe_service
+0x44/0x6c)
(pcie_port_probe_service) from [<c0454cf8>] (driver_probe_device
+0x280/0x470)
...
(pcie_port_device_register) from [<c03f51a0>] (pcie_portdrv_probe
+0x3c/0xb4)
(pcie_portdrv_probe) from [<c03e7acc>] (pci_device_probe+0x98/0xfc)
(pci_device_probe) from [<c0454cf8>] (driver_probe_device+0x280/0x470)
handlers:
[<c03f68b0>] pcie_pme_irq
Disabling IRQ #233

I haven't dig it out yet, but just keep them here to solve that.



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
