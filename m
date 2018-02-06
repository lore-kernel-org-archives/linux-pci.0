Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Message-ID: <1517956309.2312.172.camel@kernel.crashing.org>
Subject: Re: [PATCH 1/2] of_pci_irq: add a check to fallback to standard
 device tree parsing
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ryder Lee <ryder.lee@mediatek.com>
Date: Wed, 07 Feb 2018 09:31:49 +1100
In-Reply-To: <1517895732.23319.21.camel@mtkswgap22>
References: <31c765c53e85e41bfc001d110d69e46c9967f4e7.1516961656.git.ryder.lee@mediatek.com>
 <CAL_JsqLZqrxxpuEnoWEGkT2WCuyjqn0bM1DP8PdAwnQsso8kOA@mail.gmail.com>
 <1517563970.24622.9.camel@mtkswgap22>
 <1517866584.2312.140.camel@kernel.crashing.org>
 <1517884738.16010.27.camel@mtkswgap22>
 <1517889903.2312.151.camel@kernel.crashing.org>
 <1517891471.20869.6.camel@mtkswgap22>
 <1517892624.2312.167.camel@kernel.crashing.org>
 <1517895732.23319.21.camel@mtkswgap22>
Mime-Version: 1.0
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
 "moderated list:ARM/FREESCALE IMX /
 MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2018-02-06 at 13:42 +0800, Ryder Lee wrote:
> Thanks for explanation.
> 
> So I guess the better way to achieve my aim - one IRQ per slot that is
> connected to all INTx and get propagated through the bridges (and for
> those root ports own interrupts (PME ..)} is to add interrupt-map
> properties in both parent and root port nodes.
> 
> Something like this: https://patchwork.kernel.org/patch/9970923// ,right?

Yup.

Cheers,
Ben.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
