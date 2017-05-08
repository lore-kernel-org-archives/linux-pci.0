Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Mon, 8 May 2017 22:33:25 +0200
From: Peter Senna Tschudin <peter.senna@collabora.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: Regression: 442ec4c04d1: PCI: dwc: all: Split struct pcie_port
 into host-only and core structures
Message-ID: <20170508203325.GB9791@collabora.com>
References: <20170508150224.GA7458@collabora.com>
 <1494261248.2322.21.camel@pengutronix.de>
 <20170508175536.GA3305@red-moon>
MIME-Version: 1.0
In-Reply-To: <20170508175536.GA3305@red-moon>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Jesper Nilsson <jesper.nilsson@axis.com>, Joao Pinto <Joao.Pinto@synopsys.com>,
 Richard Zhu <hongxing.zhu@nxp.com>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 Jingoo Han <jingoohan1@gmail.com>, Pratyush Anand <pratyush.anand@gmail.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Kishon Vijay Abraham I <kishon@ti.com>,
 Stanimir Varbanov <svarbanov@mm-sol.com>,
 Minghuan Lian <minghuan.Lian@freescale.com>,
 Zhou Wang <wangzhou1@hisilicon.com>, Murali Karicheri <m-karicheri2@ti.com>,
 Niklas Cassel <niklas.cassel@axis.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Mingkai Hu <mingkai.hu@freescale.com>, Roy Zang <tie-fei.zang@freescale.com>,
 linux-arm-kernel@lists.infradead.org, Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 08, 2017 at 06:55:36PM +0100, Lorenzo Pieralisi wrote:
> On Mon, May 08, 2017 at 06:34:08PM +0200, Lucas Stach wrote:
> > Am Montag, den 08.05.2017, 17:02 +0200 schrieb Peter Senna Tschudin:
> > > Hello Kishon,
> > > 
> > > Our iMX6 hardware (imx6q-b850v3.dts) is not booting with latest
> > > linux-next and I could bisect until:
> > > 
> > > commit 442ec4c04d1235f8c664a74004dae54a7a574d18
> > > Author: Kishon Vijay Abraham I <kishon@ti.com>
> > > Date:   Wed Feb 15 18:48:14 2017 +0530
> > > 
> > >     PCI: dwc: all: Split struct pcie_port into host-only and core structures
> > > 
> > > Which seem to be causing our issues. Our device (imx6q-b850v3.dts) boots
> > > fine with 4.10, and also boots if we disable pcie with:
> > 
> > Are you sure about this bisect? It seems more likely that the secondary
> > bus scanning goes wrong. It seems Lorenzo Pieralisi's cfg space
> > non-posting patches landed in next, so the root cause of this might just
> > be the driver hooking the wrong fault code now.
> > 
> > Async and synchronous aborts are different fault codes on ARM. Can you
> > see of removing the "16 +" in hook_fault_code() in
> > drivers/pci/dwc/pci-imx6.c fixes this issue?
> 
> You can also s/pci_remap_cfgspace/ioremap in pcie-designware-host.c
> to see if my patches are the issue, it is quite a mechanical change.

No change. Exactly same issue, but I noticed that
devm_pci_remap_cfgspace() is called twice for the same device, can this
be a problem?

...
[    0.505069] OF: PCI: host bridge /soc/pcie@1ffc000 ranges:
[    0.510586] OF: PCI:    IO 0x01f80000..0x01f8ffff -> 0x00000000
[    0.516474] OF: PCI:   MEM 0x01000000..0x01efffff -> 0x01000000
[    0.522420] imx6q-pcie 1ffc000.pcie: devm_pci_remap_cfgspace()
[    0.528656] imx6q-pcie 1ffc000.pcie: devm_pci_remap_cfgspace()
...

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
