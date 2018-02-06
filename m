Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Message-ID: <1517889903.2312.151.camel@kernel.crashing.org>
Subject: Re: [PATCH 1/2] of_pci_irq: add a check to fallback to standard
 device tree parsing
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ryder Lee <ryder.lee@mediatek.com>
Date: Tue, 06 Feb 2018 15:05:03 +1100
In-Reply-To: <1517884738.16010.27.camel@mtkswgap22>
References: <31c765c53e85e41bfc001d110d69e46c9967f4e7.1516961656.git.ryder.lee@mediatek.com>
 <CAL_JsqLZqrxxpuEnoWEGkT2WCuyjqn0bM1DP8PdAwnQsso8kOA@mail.gmail.com>
 <1517563970.24622.9.camel@mtkswgap22>
 <1517866584.2312.140.camel@kernel.crashing.org>
 <1517884738.16010.27.camel@mtkswgap22>
Mime-Version: 1.0
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
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Bjorn Helgaas <bhelgaas@google.com>, Frank Rowand <frowand.list@gmail.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2018-02-06 at 10:38 +0800, Ryder Lee wrote:
> 
> I think the code should look at the bridge address <0x0800 ...> we list
> in bindings for resolving interrupts in this case, but it seems like it
> use the 'pdev->defvn << 8' which is not really we want and will lead to
> mismatch.
> 
> 		interrupt-map-mask = <0xf800 0 0 7>;
> 		interrupt-map = <0x0000 0 0 1 ...>,
> 				<0x0000 0 0 2 ...>,
> 				<0x0000 0 0 3 ...>,
> 				<0x0000 0 0 4 ...>,
> 
> 				 0x0800 0 0 1 ...>,
> 				 0x0800 0 0 2 ...>,
> 				 0x0800 0 0 3 ...>,
> 				 0x0800 0 0 4 ...>;
> 		...
> 		pcie@1,0 {
> 			reg = <0x0800 0 0 0 0>;
> 			...
> 		};
> 
> 
> Or, alternatively, we could add a interrupt-map property in both child
> and root node to solve this. The below example is my original version as
> I don't want to change that function either.

The code looks at devfn because it's meant to work for PCI including
when the devices dont have a device node in the DT.

What I'm trying to figure out is what is it that your parent and
children are representing here. Which is/are the root complex ?

What is the actual topology as visible on the PCIe bus (is lspci output
basically) and how does that map to your representation ?

> 		interrupt-map-mask = <0xf800 0 0 0>;
> 		interrupt-map = <0x0000 0 0 0 ...>,
> 				 0x0800 0 0 0 ...>;
> 		...
> 		pcie@1,0 {
> 			reg = <0x0800 0 0 0 0>;
> 			#interrupt-cells = <1>;
> 			interrupt-map-mask = <0 0 0 0>;
> 			interrupt-map = <0 0 0 0 ...>;
> 			...
> 		};
> 
> However, I can't find any other similar case in documentation.
> 
> Thanks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
