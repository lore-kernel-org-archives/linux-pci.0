Return-Path: <SRS0=q0Pu=5Z=intel.com=ley.foon.tan@kernel.org>
Return-Path: <SRS0=q0Pu=5Z=intel.com=ley.foon.tan@kernel.org>
Message-ID: <1497924151.42572.10.camel@intel.com>
Subject: Re: [PATCH v5 1/4] PCI: xilinx: Create legacy IRQ domain with size 5
From: Ley Foon Tan <ley.foon.tan@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Paul Burton <paul.burton@imgtec.com>, linux-pci@vger.kernel.org, Bharat
 Kumar Gogada <bharatku@xilinx.com>, Ravikiran Gummaluri
 <rgummal@xilinx.com>, Bjorn Helgaas <bhelgaas@google.com>, Michal Simek
 <michal.simek@xilinx.com>,  linux-mips@linux-mips.org, Thomas Gleixner
 <tglx@linutronix.de>, Ley Foon Tan <lftan@altera.com>, Marc Zyngier
 <marc.zyngier@arm.com>
Date: Tue, 20 Jun 2017 10:02:31 +0800
In-Reply-To: <1497923734.42572.8.camel@intel.com>
References: <20170617195741.12757-1-paul.burton@imgtec.com>
	 <20170617195741.12757-2-paul.burton@imgtec.com>
	 <20170619234708.GG554@bhelgaas-glaptop.roam.corp.google.com>
	 <1497919094.42572.3.camel@intel.com>
	 <20170620014903.GI554@bhelgaas-glaptop.roam.corp.google.com>
	 <1497923734.42572.8.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2017-06-20 at 09:55 +0800, Ley Foon Tan wrote:
> On Mon, 2017-06-19 at 20:49 -0500, Bjorn Helgaas wrote:
> >=20
> > [+cc Marc]
> >=20
> > On Tue, Jun 20, 2017 at 08:38:14AM +0800, Ley Foon Tan wrote:
> > >=20
> > >=20
> > > On Mon, 2017-06-19 at 18:47 -0500, Bjorn Helgaas wrote:
> > > >=20
> > > >=20
> > > > [+cc Thomas, Ley Foon]
> > > >=20
> > > > On Sat, Jun 17, 2017 at 12:57:38PM -0700, Paul Burton wrote:
> > > > >=20
> > > > >=20
> > > > >=20
> > > > > The driver expects to use hardware IRQ numbers 1 through 4
> > > > > for
> > > > > INTX
> > > > > interrupts, but only creates an IRQ domain of size 4 (ie. IRQ
> > > > > numbers 0
> > > > > through 3). This results in a warning from
> > > > > irq_domain_associate
> > > > > when it
> > > > > is called with hwirq=3D4:
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0WARNING: CPU: 0 PID: 1 at kernel/ir=
q/irqdomain.c:365
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0irq_domain_=
associate+0x170/0x220
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0error: hwirq 0x4 is too large for d=
ummy
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Modules linked in:
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0CPU: 0 PID: 1 Comm: swapper/0 Taint=
ed: G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0W
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A04.12.0-rc5-=
00126-g19e1b3a10aad-dirty #427
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Stack : 0000000000000000 0000000000=
000004
> > > > > 0000000000000006
> > > > > ffffffff8092c78a
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A00000000000000061 ffffffff8018bf60
> > > > > 0000000000000000
> > > > > 0000000000000000
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0ffffffff8088c287 ffffffff80811d18
> > > > > a8000000ffc60000
> > > > > ffffffff80926678
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A00000000000000001 0000000000000000
> > > > > ffffffff80887880
> > > > > ffffffff80960000
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0ffffffff80920000 ffffffff801e6744
> > > > > ffffffff80887880
> > > > > a8000000ffc4f8f8
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0000000000000089c ffffffff8018d260
> > > > > 0000000000010000
> > > > > ffffffff80811d18
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A00000000000000000 0000000000000001
> > > > > 0000000000000000
> > > > > 0000000000000000
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A00000000000000000 a8000000ffc4f840
> > > > > 0000000000000000
> > > > > ffffffff8042cf34
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A00000000000000000 0000000000000000
> > > > > 0000000000000000
> > > > > 0000000000040c00
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A00000000000000000 ffffffff8010d1c8
> > > > > 0000000000000000
> > > > > ffffffff8042cf34
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0...
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Call Trace:
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[<ffffffff8010d1c8>] show_stack+0x8=
0/0xa0
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[<ffffffff8042cf34>] dump_stack+0xd=
4/0x110
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[<ffffffff8013ea98>] __warn+0xf0/0x=
108
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[<ffffffff8013eb14>] warn_slowpath_=
fmt+0x3c/0x48
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[<ffffffff80196528>] irq_domain_ass=
ociate+0x170/0x220
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[<ffffffff80196bf0>] irq_create_map=
ping+0x88/0x118
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[<ffffffff801976a8>]
> > > > > irq_create_fwspec_mapping+0xb8/0x320
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[<ffffffff80197970>] irq_create_of_=
mapping+0x60/0x70
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[<ffffffff805d1318>] of_irq_parse_a=
nd_map_pci+0x20/0x38
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[<ffffffff8049c210>] pci_fixup_irqs=
+0x60/0xe0
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[<ffffffff8049cd64>] xilinx_pcie_pr=
obe+0x28c/0x478
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[<ffffffff804e8ca8>] platform_drv_p=
robe+0x50/0xd0
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[<ffffffff804e73a4>] driver_probe_d=
evice+0x2c4/0x3a0
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[<ffffffff804e7544>] __driver_attac=
h+0xc4/0xd0
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[<ffffffff804e5254>] bus_for_each_d=
ev+0x64/0xa8
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[<ffffffff804e5e40>] bus_add_driver=
+0x1f0/0x268
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[<ffffffff804e8000>] driver_registe=
r+0x68/0x118
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[<ffffffff801001a4>] do_one_initcal=
l+0x4c/0x178
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[<ffffffff808d3ca8>] kernel_init_fr=
eeable+0x204/0x2b0
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[<ffffffff80730b68>] kernel_init+0x=
10/0xf8
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[<ffffffff80106218>] ret_from_kerne=
l_thread+0x14/0x1c
> > > > >=20
> > > > > This patch avoids that warning by creating the legacy IRQ
> > > > > domain
> > > > > with
> > > > > size 5 rather than 4, allowing it to cover the hwirq=3D4/INTD
> > > > > case.
> > > > >=20
> > > > > Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> > > > > Cc: Bharat Kumar Gogada <bharatku@xilinx.com>
> > > > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > > > Cc: Michal Simek <michal.simek@xilinx.com>
> > > > > Cc: Ravikiran Gummaluri <rgummal@xilinx.com>
> > > > > Cc: linux-pci@vger.kernel.org
> > > > >=20
> > > > > ---
> > > > >=20
> > > > > Changes in v5:
> > > > > - New patch; replacing "PCI: xilinx: Fix INTX irq dispatch".
> > > > >=20
> > > > > Changes in v4: None
> > > > > Changes in v3: None
> > > > > Changes in v2: None
> > > > >=20
> > > > > =C2=A0drivers/pci/host/pcie-xilinx.c | 2 +-
> > > > > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> > > > >=20
> > > > > diff --git a/drivers/pci/host/pcie-xilinx.c
> > > > > b/drivers/pci/host/pcie-xilinx.c
> > > > > index 2fe2df51f9f8..94c71fb91648 100644
> > > > > --- a/drivers/pci/host/pcie-xilinx.c
> > > > > +++ b/drivers/pci/host/pcie-xilinx.c
> > > > > @@ -524,7 +524,7 @@ static int
> > > > > xilinx_pcie_init_irq_domain(struct
> > > > > xilinx_pcie_port *port)
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return -ENODEV;
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > > > >=20
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0port->leg_domain =3D
> > > > > irq_domain_add_linear(pcie_intc_node,
> > > > > 4,
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0port->leg_domain =3D
> > > > > irq_domain_add_linear(pcie_intc_node,
> > > > > 1 +
> > > > > 4,
> > > > I don't understand this.=C2=A0=C2=A0Several drivers call
> > > > irq_domain_add_linear() with
> > > > a size of 4:
> > > >=20
> > > > =C2=A0 dra7xx_pcie_init_irq_domain
> > > > =C2=A0 ks_dw_pcie_host_init
> > > > =C2=A0 advk_pcie_init_irq_domain
> > > > =C2=A0 faraday_pci_setup_cascaded_irq
> > > > =C2=A0 rockchip_pcie_init_irq_domain
> > > > =C2=A0 nwl_pcie_init_irq_domain
> > > >=20
> > > > Only one other in drivers/pci uses a size of 5:
> > > >=20
> > > > =C2=A0 altera_pcie_init_irq_domain
> > > >=20
> > > > Why can't we use a size of 4 for all of them?=C2=A0=C2=A0We only ha=
ve
> > > > INTA-
> > > > INTD.=C2=A0=C2=A0Are
> > > > altera and xilinx missing something to apply an offset from the
> > > > 0-3
> > > > space
> > > > to the 1-4 space?
> > > We have the same discussion before in 2016: https://lkml.org/lkml
> > > /2
> > > 016/
> > > 8/30/198
> > Thanks for digging that out.=C2=A0=C2=A0I knew we'd discussed this befo=
re,
> > but
> > I
> > couldn't find it in the archives.=C2=A0=C2=A0I don't think anybody was =
really
> > satisfied with the outcome, but we accepted it to make forward
> > progress.
> >=20
> > >=20
> > >=20
> > > This is because legacy interrupt is start with index 1 instead of
> > > 0.
> > I'm not buying this.=C2=A0=C2=A0Your argument was that "the hwirq for l=
egacy
> > interrupts will start at 0x1 to 0x4 (INTA to INTD) and these values
> > are as per PCIe specification for legacy interrupts.=C2=A0=C2=A0So thes=
e
> > cannot
> > be numbered from 0."
> >=20
> > But all the other drivers I mentioned get along with the 0-3 range
> > somehow.=C2=A0=C2=A0If there's something different about altera and xil=
inx
> > that
> > means they can't use the same solution the others do, I'd like to
> > know
> > what it is.
> I'm not sure those drivers with index 0-3 range tested with 4 legacy
> interrupts or not. It will not has error until someone requesting 4
> legacy interrupts. We see this error when we enabling multi-function
> endpoint (4 functions). I believe this is not altera or xilinx
> specific.
>=20

It is broken in=C2=A0dra7xx too.
https://lkml.org/lkml/2016/9/14/241

Regards
Ley Foon
