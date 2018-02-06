Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Message-ID: <1517884738.16010.27.camel@mtkswgap22>
Subject: Re: [PATCH 1/2] of_pci_irq: add a check to fallback to standard
 device tree parsing
From: Ryder Lee <ryder.lee@mediatek.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 6 Feb 2018 10:38:58 +0800
In-Reply-To: <1517866584.2312.140.camel@kernel.crashing.org>
References: <31c765c53e85e41bfc001d110d69e46c9967f4e7.1516961656.git.ryder.lee@mediatek.com>
 <CAL_JsqLZqrxxpuEnoWEGkT2WCuyjqn0bM1DP8PdAwnQsso8kOA@mail.gmail.com>
 <1517563970.24622.9.camel@mtkswgap22>
 <1517866584.2312.140.camel@kernel.crashing.org>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "open list:OPEN FIRMWARE AND FLATTENED
 DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-pci@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org, Bjorn
 Helgaas <bhelgaas@google.com>, Frank Rowand <frowand.list@gmail.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2018-02-06 at 08:36 +1100, Benjamin Herrenschmidt wrote:
> On Fri, 2018-02-02 at 17:32 +0800, Ryder Lee wrote:
> > On Wed, 2018-01-31 at 10:02 -0600, Rob Herring wrote:
> > > On Wed, Jan 31, 2018 at 1:41 AM, Ryder Lee <ryder.lee@mediatek.com> wrote:
> > > > A root complex usually consist of a host bridge and multiple P2P bridges,
> > > > and someone may express that in the form of a root node with many subnodes
> > > > and list all four interrupts for each slot (child node) in the root node
> > > > like this:
> > > > 
> > > >          pcie-controller {
> > > >                  ...
> > > >                  interrupt-map-mask = <0xf800 0 0 7>;
> > > >                  interrupt-map = <0x0000 0 0 {INTx} &{interrupt parent} ...>
> > > >                                   0x0800 0 0 {INTx} &{interrupt parent} ...>;
> > > > 
> > > >                  pcie@0,0 {
> > > >                          reg = <0x0000 0 0 0 0>;
> > > >                          ...
> > > >                  };
> > > > 
> > > >                  pcie@1,0 {
> > > >                          reg = <0x0800 0 0 0 0>;
> > > >                          ...
> > > >                  };
> > > >          };
> > > > 
> > > > As shown above, we'd like to propagate IRQs from a root port to the devices
> > > > in the hierarchy below it in this way.  However, it seems that the current
> > > > parser couldn't handle such cases and will get something unexpected below:
> > > > 
> > > >          pcieport 0000:00:01.0: assign IRQ: got 213
> > > >          igb 0000:01:00.0: assign IRQ: got 212
> > > > 
> > > > There is a device which is connected to 2nd slot, but the port doesn't share
> > > > the same IRQ with its downstream devices.  The problem here is that, if the
> > > > loop found a P2P bridge, it wouldn't check whether the reg property exists
> > > > in ppnode or not but just pass the subordinate devfn to of_irq_parse_raw(),
> > > > thus the subsequent flow couldn't correctly resolve them.
> 
> I don't really understand the problem explanation here. Something
> doesn't look right as you shouldn't have to change that function, but I
> just don't get what you a
> 
> Cheers,
> Ben.
> 

I think the code should look at the bridge address <0x0800 ...> we list
in bindings for resolving interrupts in this case, but it seems like it
use the 'pdev->defvn << 8' which is not really we want and will lead to
mismatch.

		interrupt-map-mask = <0xf800 0 0 7>;
		interrupt-map = <0x0000 0 0 1 ...>,
				<0x0000 0 0 2 ...>,
				<0x0000 0 0 3 ...>,
				<0x0000 0 0 4 ...>,

				 0x0800 0 0 1 ...>,
				 0x0800 0 0 2 ...>,
				 0x0800 0 0 3 ...>,
				 0x0800 0 0 4 ...>;
		...
		pcie@1,0 {
			reg = <0x0800 0 0 0 0>;
			...
		};


Or, alternatively, we could add a interrupt-map property in both child
and root node to solve this. The below example is my original version as
I don't want to change that function either.

		interrupt-map-mask = <0xf800 0 0 0>;
		interrupt-map = <0x0000 0 0 0 ...>,
				 0x0800 0 0 0 ...>;
		...
		pcie@1,0 {
			reg = <0x0800 0 0 0 0>;
			#interrupt-cells = <1>;
			interrupt-map-mask = <0 0 0 0>;
			interrupt-map = <0 0 0 0 ...>;
			...
		};

However, I can't find any other similar case in documentation.

Thanks.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
