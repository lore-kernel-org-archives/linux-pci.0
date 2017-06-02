Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <20170602114956.GA20004@red-moon>
References: <20170426111809.19922-1-lorenzo.pieralisi@arm.com>
 <20170426111809.19922-9-lorenzo.pieralisi@arm.com>
 <CAK8P3a1ULYxkopxJ8-vZpFs_uPP2gu5TsRWjCKUOW+0QRombLw@mail.gmail.com>
 <20170602114956.GA20004@red-moon>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 2 Jun 2017 15:12:48 +0200
Message-ID: <CAK8P3a0DRFxz_yjCeFZJ8Zukuy8gi9hPbWEfp29TaF2TMjrnTQ@mail.gmail.com>
Subject: Re: [RFC/RFT PATCH 08/18] PCI: designware: Convert PCI scan API to
 pci_scan_root_bus_bridge()
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
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

On Fri, Jun 2, 2017 at 1:49 PM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> On Fri, Apr 28, 2017 at 03:13:04PM +0200, Arnd Bergmann wrote:
>> On Wed, Apr 26, 2017 at 1:17 PM, Lorenzo Pieralisi
>> <lorenzo.pieralisi@arm.com> wrote:
>> > The introduction of pci_scan_root_bus_bridge() provides a PCI core
>> > API to scan a PCI root bus backed by an already initialized
>> > struct pci_host_bridge object, which simplifies the bus scan
>> > interface and makes the PCI scan root bus interface easier to
>> > generalize as members are added to the struct pci_host_bridge().
>> >
>> > Convert PCI designware host code to pci_scan_root_bus_bridge() to
>> > improve the PCI root bus scanning interface.
>> >
>> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> > Cc: Jingoo Han <jingoohan1@gmail.com>
>> > Cc: Bjorn Helgaas <bhelgaas@google.com>
>> > Cc: Joao Pinto <Joao.Pinto@synopsys.com>
>> > ---
>> >  drivers/pci/dwc/pcie-designware-host.c | 36 +++++++++++++++++++++-------------
>> >  1 file changed, 22 insertions(+), 14 deletions(-)
>> >
>> > diff --git a/drivers/pci/dwc/pcie-designware-host.c b/drivers/pci/dwc/pcie-designware-host.c
>> > index 5ba3349..e43c21a 100644
>> > --- a/drivers/pci/dwc/pcie-designware-host.c
>> > +++ b/drivers/pci/dwc/pcie-designware-host.c
>> > @@ -294,16 +294,21 @@ int dw_pcie_host_init(struct pcie_port *pp)
>> >                 dev_err(dev, "missing *config* reg space\n");
>> >         }
>> >
>> > -       ret = of_pci_get_host_bridge_resources(np, 0, 0xff, &res, &pp->io_base);
>> > +       bridge = pci_alloc_host_bridge(0);
>> > +       if (!bridge)
>> > +               return  -ENOMEM;
>> > +
>>
>> I think here we warn to have the pci_alloc_host_bridge() called in the
>> individual
>> drivers, to have them allocate the dw_pcie structure as part of the host
>> bridge allocation, before calling hisi_add_pcie_port().
>
> I am almost done refactoring this series and this is the last review to
> address. What you suggest above makes sense but:
>
> 1) it means patching ALL dw_pcie_host_init() callers and allocate the
>    host bridge there, not sure it simplifies, certainly it complicates
>    the error handling path (given that the host bridge memory is
>    probably the only memory that is allocated with kzalloc instead of
>    devm interface so it needs unwinding)
>
> 2) I noticed that allocating the host bridge in the caller complicates
>    error handling, in particular code in the mainline (ie tegra and
>    ftpci100) using pci_alloc_host_bridge() needs already patching since it
>    may leak memory if PCI host bridge drivers probing fails.
>
> I can implement (1) and (2) but I wanted to ask first to understand if
> that's the direction we want to take.

Good question. Maybe we should add a devm_pci_alloc_host_bridge()
instead? Would that solve these problems without creating bigger ones?

        Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
