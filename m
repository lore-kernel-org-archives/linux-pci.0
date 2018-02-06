Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Message-ID: <1517895732.23319.21.camel@mtkswgap22>
Subject: Re: [PATCH 1/2] of_pci_irq: add a check to fallback to standard
 device tree parsing
From: Ryder Lee <ryder.lee@mediatek.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 6 Feb 2018 13:42:12 +0800
In-Reply-To: <1517892624.2312.167.camel@kernel.crashing.org>
References: <31c765c53e85e41bfc001d110d69e46c9967f4e7.1516961656.git.ryder.lee@mediatek.com>
 <CAL_JsqLZqrxxpuEnoWEGkT2WCuyjqn0bM1DP8PdAwnQsso8kOA@mail.gmail.com>
 <1517563970.24622.9.camel@mtkswgap22>
 <1517866584.2312.140.camel@kernel.crashing.org>
 <1517884738.16010.27.camel@mtkswgap22>
 <1517889903.2312.151.camel@kernel.crashing.org>
 <1517891471.20869.6.camel@mtkswgap22>
 <1517892624.2312.167.camel@kernel.crashing.org>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Bjorn Helgaas <bhelgaas@google.com>, Frank Rowand <frowand.list@gmail.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2018-02-06 at 15:50 +1100, Benjamin Herrenschmidt wrote:
> On Tue, 2018-02-06 at 12:31 +0800, Ryder Lee wrote:
> > On Tue, 2018-02-06 at 15:05 +1100, Benjamin Herrenschmidt wrote:
> > > On Tue, 2018-02-06 at 10:38 +0800, Ryder Lee wrote:
> > > > 
> > > > I think the code should look at the bridge address <0x0800 ...> we list
> > > > in bindings for resolving interrupts in this case, but it seems like it
> > > > use the 'pdev->defvn << 8' which is not really we want and will lead to
> > > > mismatch.
> > > > 
> > > > 		interrupt-map-mask = <0xf800 0 0 7>;
> > > > 		interrupt-map = <0x0000 0 0 1 ...>,
> > > > 				<0x0000 0 0 2 ...>,
> > > > 				<0x0000 0 0 3 ...>,
> > > > 				<0x0000 0 0 4 ...>,
> > > > 
> > > > 				 0x0800 0 0 1 ...>,
> > > > 				 0x0800 0 0 2 ...>,
> > > > 				 0x0800 0 0 3 ...>,
> > > > 				 0x0800 0 0 4 ...>;
> > > > 		...
> > > > 		pcie@1,0 {
> > > > 			reg = <0x0800 0 0 0 0>;
> > > > 			...
> > > > 		};
> > > > 
> > > > 
> > > > Or, alternatively, we could add a interrupt-map property in both child
> > > > and root node to solve this. The below example is my original version as
> > > > I don't want to change that function either.
> > > 
> > > The code looks at devfn because it's meant to work for PCI including
> > > when the devices dont have a device node in the DT.
> > > 
> > > What I'm trying to figure out is what is it that your parent and
> > > children are representing here. Which is/are the root complex ?
> > 
> > This is a single root complex with 2 root port (children in DT).
> > 
> > > What is the actual topology as visible on the PCIe bus (is lspci output
> > > basically) and how does that map to your representation ?
> > 
> > # lspci
> > 00:00.0 Class 0604: 14c3:0801 //1st slot - pcie@0,0
> > 00:01.0 Class 0604: 14c3:0801 //2nd slot - pcie@1,0
> > 
> > 01:00.0 Class 0280: 14c3:7603 //A device which is connected to 1st slot
> > 02:00.0 Class 0200: 8086:1521 //A 4 func device which is connected to
> > 2nd slot
> > 02:00.1 Class 0200: 8086:1521
> > 02:00.2 Class 0200: 8086:1521
> > 02:00.3 Class 0200: 8086:1521
> 
> Ok so that's a rather standard setup. The "devfn << 8" of your root
> ports should be the exact same thing as their first reg property entry,
> I'm not sure why you have a mismatch here.

I've added some log after 'for loop':

pr_err("busn=0x%x, devfn=0x%x, reg=0x%x\n", pdev->bus->number, pdev->devfn, of_pci_get_devfn(ppnode));

and got these:

[    5.651836] busn=0x0, devfn=0x0, reg=0x0
[    5.651936] pcieport 0000:00:00.0: assign IRQ: got 213
...
[    5.652398] busn=0x0, devfn=0x8, reg=0x0
[    5.652487] pcieport 0000:00:01.0: assign IRQ: got 214

...
[    5.653025] busn=0x2, devfn=0x0, reg=0x8
[    5.653058] igb 0000:02:00.0: assign IRQ: got 213

[    5.724582] busn=0x2, devfn=0x1, reg=0x8
[    5.724634] igb 0000:02:00.1: assign IRQ: got 213

> However, that map only represents the INTA..D lines going to the root
> ports, not how these get mapped to children of the root ports.
> 
> of_irq_parse_pci() will implement standard swizzling if you don't have
> nodes for your devices at all. If you do, however, the code assumes
> you have a correct and complete interrupt tree in the device-tree.
> 
> That means that you need in each "p2p bridge", including your root
> ports, an interrupt-map that will map the children INTA...D of that
> bridge to the parent INTA...D of that bridge.
> 
> Alternatively, you can make the maps in the root ports point directly
> to the parent PIC. If you chose to do that, then the interrupt-map in
> your root complex becomes only useful to represent the root ports own
> interrutps (hotplug, AER,...) and could be replaced by just having
> interrupt-parent & interrupts in those root port nodes.
> 

Thanks for explanation.

So I guess the better way to achieve my aim - one IRQ per slot that is
connected to all INTx and get propagated through the bridges (and for
those root ports own interrupts (PME ..)} is to add interrupt-map
properties in both parent and root port nodes.

Something like this: https://patchwork.kernel.org/patch/9970923/ ,right?

Ryder


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
