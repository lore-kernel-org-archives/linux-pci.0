Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Message-ID: <1494408707.31307.32.camel@mtkswgap22>
Subject: Re: [PATCH v3 2/2] dt-bindings: pcie: Add documentation for
 Mediatek PCIe
From: Ryder Lee <ryder.lee@mediatek.com>
To: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 10 May 2017 17:31:47 +0800
In-Reply-To: <CAK8P3a193RxchvFAMWeZiP0sc0bd+VGg=_aVvipSgcbDpHXojg@mail.gmail.com>
References: <1494382020-26790-1-git-send-email-ryder.lee@mediatek.com>
 <1494382020-26790-3-git-send-email-ryder.lee@mediatek.com>
 <CAK8P3a193RxchvFAMWeZiP0sc0bd+VGg=_aVvipSgcbDpHXojg@mail.gmail.com>
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

On Wed, 2017-05-10 at 10:08 +0200, Arnd Bergmann wrote:
> On Wed, May 10, 2017 at 4:07 AM, Ryder Lee <ryder.lee@mediatek.com> wrote:
> 
> > +- ranges:
> > +  - The first three entries are expected to translate the addresses for the root
> > +    port registers, which are referenced by the assigned-addresses property of
> > +    the root port nodes (see below).
> 
> I don't understand this part. Why do you need a static translation for these?
> Shouldn't they just be listed in the 'reg' property of the parent node now that
> you have the clk/reset/phy properties in the parent as well?

At first, I did like that. But I noticed that someone suggest it's
better to use 'assigned-addresses' to handle per-port registers, the
same path as tegra and marvell did, in other platform discussion thread.
So I just put shared register in root node. It could be rolled back if
you feel this is inappropriate.

> > +Required properties:
> > +- device_type: Must be "pci"
> > +- assigned-addresses: Address and size of the port configuration registers
> > +- reg: Only the first four bytes are used to refer to the correct bus number
> > +  and device number.
> > +- #address-cells: Must be 3
> > +- #size-cells: Must be 2
> > +- #interrupt-cells: Must be 1
> > +- interrupt-map-mask and interrupt-map: Standard PCI IRQ mapping properties
> > +  Please refer to the standard PCI bus binding document for a more detailed
> > +  explanation.
> 
> Child nodes do not normally have interrupt-map properties. Isn't this
> already covered by the interrupt-map in the parent?
> 

I have one Intel 4 port ethernet card(0000:00:01) and MTK WLAN card
(0000:00:02), probe message looks good to me.

pci 0000:00:01.0: fixup irq: got 224
pci 0000:00:01.0: assigning IRQ 224
pci 0000:00:02.0: fixup irq: got 225
pci 0000:00:02.0: assigning IRQ 225

pci 0000:01:00.0: fixup irq: got 224
pci 0000:01:00.0: assigning IRQ 224
pci 0000:01:00.1: fixup irq: got 224
pci 0000:01:00.1: assigning IRQ 224
pci 0000:01:00.2: fixup irq: got 224
pci 0000:01:00.2: assigning IRQ 224
pci 0000:01:00.3: fixup irq: got 224
pci 0000:01:00.3: assigning IRQ 224

pci 0000:02:00.0: fixup irq: got 225
pci 0000:02:00.0: assigning IRQ 225


But child nodes without interrupt-map properties:
It seems incorrect.

pci 0000:00:01.0: fixup irq: got 224
pci 0000:00:01.0: assigning IRQ 224
pci 0000:00:02.0: fixup irq: got 225
pci 0000:00:02.0: assigning IRQ 225

pci 0000:01:00.0: fixup irq: got 223
pci 0000:01:00.0: assigning IRQ 223
pci 0000:01:00.1: fixup irq: got 223
pci 0000:01:00.1: assigning IRQ 223
pci 0000:01:00.2: fixup irq: got 223
pci 0000:01:00.2: assigning IRQ 223
pci 0000:01:00.3: fixup irq: got 223
pci 0000:01:00.3: assigning IRQ 223

pci 0000:02:00.0: fixup irq: got 223
pci 0000:02:00.0: assigning IRQ 223



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
