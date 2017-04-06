Return-Path: <SRS0=Z9g4=3O=intel.com=ley.foon.tan@kernel.org>
Return-Path: <SRS0=Z9g4=3O=intel.com=ley.foon.tan@kernel.org>
Message-ID: <1491444359.50673.4.camel@intel.com>
Subject: Re: PCI enumeration without a BIOS
From: Ley Foon Tan <ley.foon.tan@intel.com>
To: Wesley Terpstra <wesley@sifive.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>,
	rfi@lists.rocketboards.org
Date: Thu, 06 Apr 2017 10:05:59 +0800
In-Reply-To: <CAMgXwTj2sKhn9XB+6aEgZyxjgnv3njLks26XG6B0nL3BEMiivw@mail.gmail.com>
References: 
	<CAMgXwTjX1j2dhi7n+APNef0di5oo+iK57Cq0S+3NdMtQzAc=Vw@mail.gmail.com>
	 <20170404205617.GG27692@bhelgaas-glaptop.roam.corp.google.com>
	 <CAMgXwTgacUcfzinQKuf8htwxFDJ_GvUN-R0zj7sNbqnpJF3QBA@mail.gmail.com>
	 <20170405183732.GB17066@bhelgaas-glaptop.roam.corp.google.com>
	 <1491441105.50673.2.camel@intel.com>
	 <CAMgXwTj2sKhn9XB+6aEgZyxjgnv3njLks26XG6B0nL3BEMiivw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2017-04-05 at 18:59 -0700, Wesley Terpstra wrote:
> On Wed, Apr 5, 2017 at 6:11 PM, Ley Foon Tan <ley.foon.tan@intel.com>
> wrote:
> >=20
> > We have fixed this in last year.
> Right, for host/pcie-altera.c
> However, the problem persists in host/pcie-xilinx.c and host/pcie-
> xilinx-nwl.c

It hasn't integrated to mainline yet.
https://lkml.org/lkml/2016/8/30/198

>=20
> >=20
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
> > comm
> > it/drivers/pci/host/pcie-
> > altera.c?id=3D99496bd2971fc378226ad4413e5b72c4545714bd
> >=20
> > >=20
> > >=20
> > > >=20
> > > >=20
> > > > Without it I see:
> > > >=20
> > > > [=C2=A0=C2=A0=C2=A0=C2=A06.230000] ------------[ cut here ]--------=
----
> > > > [=C2=A0=C2=A0=C2=A0=C2=A06.230000] WARNING: CPU: 0 PID: 1 at
> > > > /scratch/terpstra/freedom-u-
> > > > sdk/linux/kernel/irq/irqdomain.c:365
> > > > irq_domain_associate+0x190/0x200
> > > > [=C2=A0=C2=A0=C2=A0=C2=A06.240000] error: hwirq 0x4 is too large fo=
r dummy
> > > > [=C2=A0=C2=A0=C2=A0=C2=A06.250000] CPU: 0 PID: 1 Comm: swapper Not =
tainted
> > > > 4.11.0-rc1-661305-g4f97179 #12
> > > > [=C2=A0=C2=A0=C2=A0=C2=A06.250000] Call Trace:
> > > > [=C2=A0=C2=A0=C2=A0=C2=A06.260000] [<ffffffff80288660>] walk_stackf=
rame+0x0/0x104
> > > > [=C2=A0=C2=A0=C2=A0=C2=A06.260000] [<ffffffff80288800>] show_stack+=
0x38/0x50
> > > > [=C2=A0=C2=A0=C2=A0=C2=A06.270000] [<ffffffff803c6e30>] dump_stack+=
0x2c/0x40
> > > > [=C2=A0=C2=A0=C2=A0=C2=A06.270000] [<ffffffff8028c600>] __warn+0x11=
8/0x130
> > > > [=C2=A0=C2=A0=C2=A0=C2=A06.280000] [<ffffffff8028c658>] warn_slowpa=
th_fmt+0x40/0x54
> > > > [=C2=A0=C2=A0=C2=A0=C2=A06.280000] [<ffffffff802c02a8>]
> > > > irq_domain_associate+0x18c/0x200
> > > > [=C2=A0=C2=A0=C2=A0=C2=A06.290000] [<ffffffff802c0a3c>]
> > > > irq_create_mapping+0x90/0xe4
> > > > [=C2=A0=C2=A0=C2=A0=C2=A06.300000] [<ffffffff802c0be4>]
> > > > irq_create_fwspec_mapping+0x154/0x288
> > > > [=C2=A0=C2=A0=C2=A0=C2=A06.300000] [<ffffffff802c0d7c>]
> > > > irq_create_of_mapping+0x64/0x84
> > > > [=C2=A0=C2=A0=C2=A0=C2=A06.310000] [<ffffffff804f9cb8>]
> > > > of_irq_parse_and_map_pci+0x38/0x50
> > > > [=C2=A0=C2=A0=C2=A0=C2=A06.310000] [<ffffffff80407e00>] pci_fixup_i=
rqs+0x6c/0x114
> > > > [=C2=A0=C2=A0=C2=A0=C2=A06.320000] [<ffffffff80408e64>]
> > > > xilinx_pcie_probe+0x308/0x3f0
> > > > [=C2=A0=C2=A0=C2=A0=C2=A06.330000] [<ffffffff8042cba4>]
> > > > platform_drv_probe+0x3c/0x88
> > > > [=C2=A0=C2=A0=C2=A0=C2=A06.330000] [<ffffffff8042aec0>] really_prob=
e+0xbc/0x260
> > > > [=C2=A0=C2=A0=C2=A0=C2=A06.340000] [<ffffffff8042b138>] __driver_at=
tach+0xd4/0xdc
> > > > [=C2=A0=C2=A0=C2=A0=C2=A06.340000] [<ffffffff80429200>] bus_for_eac=
h_dev+0x68/0xb8
> > > > [=C2=A0=C2=A0=C2=A0=C2=A06.350000] [<ffffffff8042b640>] driver_atta=
ch+0x24/0x38
> > > > [=C2=A0=C2=A0=C2=A0=C2=A06.350000] [<ffffffff80429db8>] bus_add_dri=
ver+0x1b4/0x22c
> > > > [=C2=A0=C2=A0=C2=A0=C2=A06.360000] [<ffffffff8042bdc0>] driver_regi=
ster+0x68/0x12c
> > > > [=C2=A0=C2=A0=C2=A0=C2=A06.360000] [<ffffffff8042da78>]
> > > > __platform_driver_register+0x48/0x5c
> > > > [=C2=A0=C2=A0=C2=A0=C2=A06.370000] [<ffffffff8000db38>]
> > > > xilinx_pcie_driver_init+0x20/0x34
> > > > [=C2=A0=C2=A0=C2=A0=C2=A06.380000] [<ffffffff80000d48>] do_one_init=
call+0x98/0x140
> > > > [=C2=A0=C2=A0=C2=A0=C2=A06.380000] [<ffffffff80000f38>]
> > > > kernel_init_freeable+0x148/0x218
> > > > [=C2=A0=C2=A0=C2=A0=C2=A06.390000] [<ffffffff805ad19c>] kernel_init=
+0x18/0x114
> > > > [=C2=A0=C2=A0=C2=A0=C2=A06.390000] [<ffffffff80286cac>] ret_from_sy=
scall+0xc/0x10
> > > > [=C2=A0=C2=A0=C2=A0=C2=A06.400000] ---[ end trace 8023adf5befc91e0 =
]---
> > > >=20
> > > > ... that said, I am not confident my patch is the right fix. So
> > > > consider this a bug report + work-around only. :)
> > > >=20
> > > > >=20
> > > > >=20
> > > > > Yeah, everything seems mostly working.=C2=A0=C2=A0The "invalid BA=
R"
> > > > > things
> > > > > *could* be an issue -- those registers are not what the PCI
> > > > > spec
> > > > > says
> > > > > they should be.
> > > > The devices in question are:
> > > > 04:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
> > > > RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev
> > > > 06)
> > > > 06:00.0 SATA controller: Marvell Technology Group Ltd. 88SE9230
> > > > PCIe
> > > > SATA 6Gb/s Controller (rev 11)
> > > >=20
> > > > I am going to plug them in to an Intel machine with 4.11 and
> > > > see if
> > > > I
> > > > get the same warnings.
> > Regards
> > Ley Foon
