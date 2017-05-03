Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 3 May 2017 11:16:42 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC/RFT PATCH 08/18] PCI: designware: Convert PCI scan API to
 pci_scan_root_bus_bridge()
Message-ID: <20170503101642.GA10800@red-moon>
References: <20170426111809.19922-1-lorenzo.pieralisi@arm.com>
 <20170426111809.19922-9-lorenzo.pieralisi@arm.com>
 <CAK8P3a1ULYxkopxJ8-vZpFs_uPP2gu5TsRWjCKUOW+0QRombLw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1ULYxkopxJ8-vZpFs_uPP2gu5TsRWjCKUOW+0QRombLw@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Wenrui Li <wenrui.li@rock-chips.com>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 linux-pci <linux-pci@vger.kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>,
 Will Deacon <will.deacon@arm.com>, Michal Simek <michal.simek@xilinx.com>,
 Thierry Reding <thierry.reding@gmail.com>, Tanmay Inamdar <tinamdar@apm.com>,
 Matthew Minter <matt@masarand.com>, Rob Herring <robh@kernel.org>,
 Joao Pinto <Joao.Pinto@synopsys.com>,
 Pratyush Anand <pratyush.anand@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Murali Karicheri <m-karicheri2@ti.com>,
 Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
 Simon Horman <horms@verge.net.au>, Bjorn Helgaas <bhelgaas@google.com>,
 Mingkai Hu <mingkai.hu@freescale.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Jingoo Han <jingoohan1@gmail.com>, Stanimir Varbanov <svarbanov@mm-sol.com>,
 Minghuan Lian <minghuan.Lian@freescale.com>,
 Zhou Wang <wangzhou1@hisilicon.com>, Roy Zang <tie-fei.zang@freescale.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 28, 2017 at 03:13:04PM +0200, Arnd Bergmann wrote:
> On Wed, Apr 26, 2017 at 1:17 PM, Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
> > The introduction of pci_scan_root_bus_bridge() provides a PCI core
> > API to scan a PCI root bus backed by an already initialized
> > struct pci_host_bridge object, which simplifies the bus scan
> > interface and makes the PCI scan root bus interface easier to
> > generalize as members are added to the struct pci_host_bridge().
> >
> > Convert PCI designware host code to pci_scan_root_bus_bridge() to
> > improve the PCI root bus scanning interface.
> >
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Jingoo Han <jingoohan1@gmail.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Joao Pinto <Joao.Pinto@synopsys.com>
> > ---
> >  drivers/pci/dwc/pcie-designware-host.c | 36 +++++++++++++++++++++-------------
> >  1 file changed, 22 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/pci/dwc/pcie-designware-host.c b/drivers/pci/dwc/pcie-designware-host.c
> > index 5ba3349..e43c21a 100644
> > --- a/drivers/pci/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/dwc/pcie-designware-host.c
> > @@ -294,16 +294,21 @@ int dw_pcie_host_init(struct pcie_port *pp)
> >                 dev_err(dev, "missing *config* reg space\n");
> >         }
> >
> > -       ret = of_pci_get_host_bridge_resources(np, 0, 0xff, &res, &pp->io_base);
> > +       bridge = pci_alloc_host_bridge(0);
> > +       if (!bridge)
> > +               return  -ENOMEM;
> > +
> 
> I think here we warn to have the pci_alloc_host_bridge() called in the

s/warn/want, correct ?

> individual drivers, to have them allocate the dw_pcie structure as
> part of the host bridge allocation, before calling
> hisi_add_pcie_port().

I see what you mean I will see how I can do it with this series or
another one, it won't certainly make this DW stuff any shinier, it
is really really hard to read.

Thanks,
Lorenzo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
