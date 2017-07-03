Return-Path: <SRS0=2bA7=6G=sigmadesigns.com=marc_gonzalez@kernel.org>
Return-Path: <SRS0=2bA7=6G=sigmadesigns.com=marc_gonzalez@kernel.org>
Subject: Re: [PATCH v9 2/3] PCI: Add tango PCIe host bridge support
From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Marc Zyngier <marc.zyngier@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
	linux-pci <linux-pci@vger.kernel.org>, Linux ARM
	<linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>,
	Mason <slash.tmp@free.fr>, Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
	Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel
	<ard.biesheuvel@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <987fac41-80dc-f1d0-ec0b-91ae57b91bfd@sigmadesigns.com>
 <b32f9e1c-fdde-3064-f935-c817cf707534@sigmadesigns.com>
 <20170702231811.GJ18324@bhelgaas-glaptop.roam.corp.google.com>
 <79382219-c730-da78-3e5f-5abf3173d7ac@sigmadesigns.com>
Message-ID: <e57debab-3457-1d9c-a72e-ecdf7d4f742e@sigmadesigns.com>
Date: Mon, 3 Jul 2017 15:13:33 +0200
MIME-Version: 1.0
In-Reply-To: <79382219-c730-da78-3e5f-5abf3173d7ac@sigmadesigns.com>
Content-Type: text/plain; charset=WINDOWS-1252
List-ID: <linux-pci.vger.kernel.org>

On 03/07/2017 11:54, Marc Gonzalez wrote:

> Mark Rutland points out stop_machine. I will test this solution.

I must be misunderstanding some of the requirements for
calling stop_machine() because my kernel panics, after
many warnings.

I made the following changes, which call stop_machine() at
the end of smp8759_config_read() to do nothing on cpu 0.

Looking at drivers/char/hw_random/intel-rng.c, they don't
seem to do anything special in the callback...


diff --git a/drivers/pci/host/pcie-tango.c b/drivers/pci/host/pcie-tango.c
index aa1484f6520e..c252215e408a 100644
--- a/drivers/pci/host/pcie-tango.c
+++ b/drivers/pci/host/pcie-tango.c
@@ -233,6 +233,13 @@ static int tango_msi_probe(struct platform_device *pde=
v, struct tango_pcie *pcie
=20
 /*** HOST BRIDGE SUPPORT ***/
=20
+#include <linux/stop_machine.h>
+
+static int do_nothing(void *arg)
+{
+       return 0;
+}
+
 static int smp8759_config_read(struct pci_bus *bus,
                unsigned int devfn, int where, int size, u32 *val)
 {
@@ -259,6 +266,8 @@ static int smp8759_config_read(struct pci_bus *bus,
        ret =3D pci_generic_config_read(bus, devfn, where, size, val);
        writel_relaxed(0, pcie->mux);
=20
+       stop_machine(do_nothing, NULL, NULL);
+
        return ret;
 }
=20

My boot log:

[    0.718913] OF: PCI: host bridge /soc/pcie@2e000 ranges:
[    0.724269] OF: PCI:   No bus range found for /soc/pcie@2e000, using [bu=
s 00-ff]
[    0.731725] OF: PCI:   MEM 0x50400000..0x53ffffff -> 0x00400000
[    0.737702] pcie_tango 50000000.pcie: ECAM area [mem 0x50000000-0x503fff=
ff] can only accommodate [bus 00-03] (reduced from [bus 00-ff] desired)
[    0.750709] pcie_tango 50000000.pcie: ECAM at [mem 0x50000000-0x503fffff=
] for [bus 00-03]
[    0.759034] pcie_tango 50000000.pcie: PCI host bridge to bus 0000:00
[    0.765434] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.770957] pci_bus 0000:00: root bus resource [mem 0x50400000-0x53fffff=
f] (bus address [0x00400000-0x03ffffff])
[    0.781206] BUG: scheduling while atomic: swapper/0/1/0x00000002
[    0.787248] Modules linked in:
[    0.790324] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.9.23-1-rc4 #16
[    0.796881] Hardware name: Sigma Tango DT
[    0.800934] [<c010ec94>] (unwind_backtrace) from [<c010ace4>] (show_stac=
k+0x10/0x14)
[    0.808719] [<c010ace4>] (show_stack) from [<c02cc13c>] (dump_stack+0x84=
/0x98)
[    0.815980] [<c02cc13c>] (dump_stack) from [<c0137ee8>] (__schedule_bug+=
0x64/0x84)
[    0.823593] [<c0137ee8>] (__schedule_bug) from [<c04bb1d0>] (__schedule+=
0x364/0x454)
[    0.831376] [<c04bb1d0>] (__schedule) from [<c04bb310>] (schedule+0x50/0=
xb4)
[    0.838463] [<c04bb310>] (schedule) from [<c04be0dc>] (schedule_timeout+=
0x1c8/0x210)
[    0.846246] [<c04be0dc>] (schedule_timeout) from [<c04bbdd8>] (wait_for_=
common+0x8c/0x13c)
[    0.854554] [<c04bbdd8>] (wait_for_common) from [<c0185084>] (__stop_cpu=
s+0x50/0x64)
[    0.862336] [<c0185084>] (__stop_cpus) from [<c0185484>] (stop_cpus+0x2c=
/0x44)
[    0.869593] [<c0185484>] (stop_cpus) from [<c0185550>] (stop_machine+0xb=
4/0xf8)
[    0.876941] [<c0185550>] (stop_machine) from [<c0310e30>] (smp8759_confi=
g_read+0x68/0x74)
[    0.885164] [<c0310e30>] (smp8759_config_read) from [<c02f5dd8>] (pci_bu=
s_read_config_dword+0x6c/0x94)
[    0.894521] [<c02f5dd8>] (pci_bus_read_config_dword) from [<c02f7c84>] (=
pci_bus_read_dev_vendor_id+0x24/0xe8)
[    0.904488] [<c02f7c84>] (pci_bus_read_dev_vendor_id) from [<c02f9488>] =
(pci_scan_single_device+0x40/0xb0)
[    0.914193] [<c02f9488>] (pci_scan_single_device) from [<c02f9550>] (pci=
_scan_slot+0x58/0x100)
[    0.922849] [<c02f9550>] (pci_scan_slot) from [<c02fa468>] (pci_scan_chi=
ld_bus+0x20/0xf8)
[    0.931069] [<c02fa468>] (pci_scan_child_bus) from [<c02fa738>] (pci_sca=
n_root_bus_msi+0xcc/0xd8)
[    0.939987] [<c02fa738>] (pci_scan_root_bus_msi) from [<c02fa75c>] (pci_=
scan_root_bus+0x18/0x20)
[    0.948817] [<c02fa75c>] (pci_scan_root_bus) from [<c0310a48>] (pci_host=
_common_probe+0xc8/0x314)
[    0.957740] [<c0310a48>] (pci_host_common_probe) from [<c03508d8>] (plat=
form_drv_probe+0x34/0x6c)
[    0.966660] [<c03508d8>] (platform_drv_probe) from [<c034f388>] (really_=
probe+0x1c4/0x250)
[    0.974967] [<c034f388>] (really_probe) from [<c034f4d8>] (__driver_atta=
ch+0xc4/0xc8)
[    0.982836] [<c034f4d8>] (__driver_attach) from [<c034d8d0>] (bus_for_ea=
ch_dev+0x68/0x9c)
[    0.991055] [<c034d8d0>] (bus_for_each_dev) from [<c034e960>] (bus_add_d=
river+0x108/0x214)
[    0.999361] [<c034e960>] (bus_add_driver) from [<c034fa3c>] (driver_regi=
ster+0x78/0xf4)
[    1.007405] [<c034fa3c>] (driver_register) from [<c010175c>] (do_one_ini=
tcall+0x44/0x170)
[    1.015627] [<c010175c>] (do_one_initcall) from [<c0600dbc>] (kernel_ini=
t_freeable+0x154/0x1e0)
[    1.024370] [<c0600dbc>] (kernel_init_freeable) from [<c04ba49c>] (kerne=
l_init+0x8/0x10c)
[    1.032590] [<c04ba49c>] (kernel_init) from [<c0107678>] (ret_from_fork+=
0x14/0x3c)
[    1.040356] pci 0000:00:00.0: [1105:0024] type 01 class 0x048000
[    1.046827] pci 0000:00:00.0: supports D1 D2
[    1.051124] pci 0000:00:00.0: PME# supported from D0 D1 D2 D3hot
[    1.057376] ------------[ cut here ]------------
[    1.062033] WARNING: CPU: 0 PID: 1 at drivers/pci/search.c:193 pci_get_s=
lot+0xb0/0xb4
[    1.069906] Modules linked in:
[    1.072978] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W       4.9.=
23-1-rc4 #16
[    1.080756] Hardware name: Sigma Tango DT
[    1.084789] [<c010ec94>] (unwind_backtrace) from [<c010ace4>] (show_stac=
k+0x10/0x14)
[    1.092573] [<c010ace4>] (show_stack) from [<c02cc13c>] (dump_stack+0x84=
/0x98)
[    1.099835] [<c02cc13c>] (dump_stack) from [<c01183d0>] (__warn+0xe8/0x1=
00)
[    1.106832] [<c01183d0>] (__warn) from [<c0118498>] (warn_slowpath_null+=
0x20/0x28)
[    1.114440] [<c0118498>] (warn_slowpath_null) from [<c0300ca4>] (pci_get=
_slot+0xb0/0xb4)
[    1.122576] [<c0300ca4>] (pci_get_slot) from [<c02f945c>] (pci_scan_sing=
le_device+0x14/0xb0)
[    1.131058] [<c02f945c>] (pci_scan_single_device) from [<c02f9550>] (pci=
_scan_slot+0x58/0x100)
[    1.139714] [<c02f9550>] (pci_scan_slot) from [<c02fa468>] (pci_scan_chi=
ld_bus+0x20/0xf8)
[    1.147934] [<c02fa468>] (pci_scan_child_bus) from [<c02fa738>] (pci_sca=
n_root_bus_msi+0xcc/0xd8)
[    1.156852] [<c02fa738>] (pci_scan_root_bus_msi) from [<c02fa75c>] (pci_=
scan_root_bus+0x18/0x20)
[    1.165683] [<c02fa75c>] (pci_scan_root_bus) from [<c0310a48>] (pci_host=
_common_probe+0xc8/0x314)
[    1.174604] [<c0310a48>] (pci_host_common_probe) from [<c03508d8>] (plat=
form_drv_probe+0x34/0x6c)
[    1.183522] [<c03508d8>] (platform_drv_probe) from [<c034f388>] (really_=
probe+0x1c4/0x250)
[    1.191829] [<c034f388>] (really_probe) from [<c034f4d8>] (__driver_atta=
ch+0xc4/0xc8)
[    1.199698] [<c034f4d8>] (__driver_attach) from [<c034d8d0>] (bus_for_ea=
ch_dev+0x68/0x9c)
[    1.207916] [<c034d8d0>] (bus_for_each_dev) from [<c034e960>] (bus_add_d=
river+0x108/0x214)
[    1.216222] [<c034e960>] (bus_add_driver) from [<c034fa3c>] (driver_regi=
ster+0x78/0xf4)
[    1.224266] [<c034fa3c>] (driver_register) from [<c010175c>] (do_one_ini=
tcall+0x44/0x170)
[    1.232486] [<c010175c>] (do_one_initcall) from [<c0600dbc>] (kernel_ini=
t_freeable+0x154/0x1e0)
[    1.241232] [<c0600dbc>] (kernel_init_freeable) from [<c04ba49c>] (kerne=
l_init+0x8/0x10c)
[    1.249451] [<c04ba49c>] (kernel_init) from [<c0107678>] (ret_from_fork+=
0x14/0x3c)
[    1.257071] ---[ end trace 4ee1a301cee5ee66 ]---
[    1.261712] ------------[ cut here ]------------
[    1.266357] WARNING: CPU: 0 PID: 1 at drivers/pci/search.c:193 pci_get_s=
lot+0xb0/0xb4
[    1.274227] Modules linked in:
[    1.277298] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W       4.9.=
23-1-rc4 #16
[    1.285076] Hardware name: Sigma Tango DT
[    1.289104] [<c010ec94>] (unwind_backtrace) from [<c010ace4>] (show_stac=
k+0x10/0x14)
[    1.296886] [<c010ace4>] (show_stack) from [<c02cc13c>] (dump_stack+0x84=
/0x98)
[    1.304145] [<c02cc13c>] (dump_stack) from [<c01183d0>] (__warn+0xe8/0x1=
00)
[    1.311141] [<c01183d0>] (__warn) from [<c0118498>] (warn_slowpath_null+=
0x20/0x28)
[    1.318749] [<c0118498>] (warn_slowpath_null) from [<c0300ca4>] (pci_get=
_slot+0xb0/0xb4)
[    1.326882] [<c0300ca4>] (pci_get_slot) from [<c02f945c>] (pci_scan_sing=
le_device+0x14/0xb0)
[    1.335363] [<c02f945c>] (pci_scan_single_device) from [<c02f9550>] (pci=
_scan_slot+0x58/0x100)
[    1.344019] [<c02f9550>] (pci_scan_slot) from [<c02fa468>] (pci_scan_chi=
ld_bus+0x20/0xf8)
[    1.352239] [<c02fa468>] (pci_scan_child_bus) from [<c02fa738>] (pci_sca=
n_root_bus_msi+0xcc/0xd8)
[    1.361157] [<c02fa738>] (pci_scan_root_bus_msi) from [<c02fa75c>] (pci_=
scan_root_bus+0x18/0x20)
[    1.369988] [<c02fa75c>] (pci_scan_root_bus) from [<c0310a48>] (pci_host=
_common_probe+0xc8/0x314)
[    1.378907] [<c0310a48>] (pci_host_common_probe) from [<c03508d8>] (plat=
form_drv_probe+0x34/0x6c)
[    1.387825] [<c03508d8>] (platform_drv_probe) from [<c034f388>] (really_=
probe+0x1c4/0x250)
[    1.396131] [<c034f388>] (really_probe) from [<c034f4d8>] (__driver_atta=
ch+0xc4/0xc8)
[    1.404001] [<c034f4d8>] (__driver_attach) from [<c034d8d0>] (bus_for_ea=
ch_dev+0x68/0x9c)
[    1.412219] [<c034d8d0>] (bus_for_each_dev) from [<c034e960>] (bus_add_d=
river+0x108/0x214)
[    1.420525] [<c034e960>] (bus_add_driver) from [<c034fa3c>] (driver_regi=
ster+0x78/0xf4)
[    1.428569] [<c034fa3c>] (driver_register) from [<c010175c>] (do_one_ini=
tcall+0x44/0x170)
[    1.436788] [<c010175c>] (do_one_initcall) from [<c0600dbc>] (kernel_ini=
t_freeable+0x154/0x1e0)
[    1.445531] [<c0600dbc>] (kernel_init_freeable) from [<c04ba49c>] (kerne=
l_init+0x8/0x10c)
[    1.453750] [<c04ba49c>] (kernel_init) from [<c0107678>] (ret_from_fork+=
0x14/0x3c)
[    1.461362] ---[ end trace 4ee1a301cee5ee67 ]---
[    1.466002] ------------[ cut here ]------------
[    1.470645] WARNING: CPU: 0 PID: 1 at drivers/pci/search.c:193 pci_get_s=
lot+0xb0/0xb4
[    1.478515] Modules linked in:
[    1.481585] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W       4.9.=
23-1-rc4 #16
[    1.489363] Hardware name: Sigma Tango DT
[    1.493391] [<c010ec94>] (unwind_backtrace) from [<c010ace4>] (show_stac=
k+0x10/0x14)
[    1.501174] [<c010ace4>] (show_stack) from [<c02cc13c>] (dump_stack+0x84=
/0x98)
[    1.508432] [<c02cc13c>] (dump_stack) from [<c01183d0>] (__warn+0xe8/0x1=
00)
[    1.515428] [<c01183d0>] (__warn) from [<c0118498>] (warn_slowpath_null+=
0x20/0x28)
[    1.523036] [<c0118498>] (warn_slowpath_null) from [<c0300ca4>] (pci_get=
_slot+0xb0/0xb4)
[    1.531168] [<c0300ca4>] (pci_get_slot) from [<c02f945c>] (pci_scan_sing=
le_device+0x14/0xb0)
[    1.539650] [<c02f945c>] (pci_scan_single_device) from [<c02f9550>] (pci=
_scan_slot+0x58/0x100)
[    1.548306] [<c02f9550>] (pci_scan_slot) from [<c02fa468>] (pci_scan_chi=
ld_bus+0x20/0xf8)
[    1.556525] [<c02fa468>] (pci_scan_child_bus) from [<c02fa738>] (pci_sca=
n_root_bus_msi+0xcc/0xd8)
[    1.565443] [<c02fa738>] (pci_scan_root_bus_msi) from [<c02fa75c>] (pci_=
scan_root_bus+0x18/0x20)
[    1.574274] [<c02fa75c>] (pci_scan_root_bus) from [<c0310a48>] (pci_host=
_common_probe+0xc8/0x314)
[    1.583193] [<c0310a48>] (pci_host_common_probe) from [<c03508d8>] (plat=
form_drv_probe+0x34/0x6c)
[    1.592111] [<c03508d8>] (platform_drv_probe) from [<c034f388>] (really_=
probe+0x1c4/0x250)
[    1.600417] [<c034f388>] (really_probe) from [<c034f4d8>] (__driver_atta=
ch+0xc4/0xc8)
[    1.608286] [<c034f4d8>] (__driver_attach) from [<c034d8d0>] (bus_for_ea=
ch_dev+0x68/0x9c)
[    1.616505] [<c034d8d0>] (bus_for_each_dev) from [<c034e960>] (bus_add_d=
river+0x108/0x214)
[    1.624811] [<c034e960>] (bus_add_driver) from [<c034fa3c>] (driver_regi=
ster+0x78/0xf4)
[    1.632854] [<c034fa3c>] (driver_register) from [<c010175c>] (do_one_ini=
tcall+0x44/0x170)
[    1.641073] [<c010175c>] (do_one_initcall) from [<c0600dbc>] (kernel_ini=
t_freeable+0x154/0x1e0)
[    1.649817] [<c0600dbc>] (kernel_init_freeable) from [<c04ba49c>] (kerne=
l_init+0x8/0x10c)
[    1.658036] [<c04ba49c>] (kernel_init) from [<c0107678>] (ret_from_fork+=
0x14/0x3c)
[    1.665647] ---[ end trace 4ee1a301cee5ee68 ]---
[    1.670287] ------------[ cut here ]------------
[    1.674930] WARNING: CPU: 0 PID: 1 at drivers/pci/search.c:193 pci_get_s=
lot+0xb0/0xb4
[    1.682801] Modules linked in:
[    1.685872] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W       4.9.=
23-1-rc4 #16
[    1.693650] Hardware name: Sigma Tango DT
[    1.697678] [<c010ec94>] (unwind_backtrace) from [<c010ace4>] (show_stac=
k+0x10/0x14)
[    1.705460] [<c010ace4>] (show_stack) from [<c02cc13c>] (dump_stack+0x84=
/0x98)
[    1.712719] [<c02cc13c>] (dump_stack) from [<c01183d0>] (__warn+0xe8/0x1=
00)
[    1.719716] [<c01183d0>] (__warn) from [<c0118498>] (warn_slowpath_null+=
0x20/0x28)
[    1.727323] [<c0118498>] (warn_slowpath_null) from [<c0300ca4>] (pci_get=
_slot+0xb0/0xb4)
[    1.735457] [<c0300ca4>] (pci_get_slot) from [<c02f945c>] (pci_scan_sing=
le_device+0x14/0xb0)
[    1.743938] [<c02f945c>] (pci_scan_single_device) from [<c02f9550>] (pci=
_scan_slot+0x58/0x100)
[    1.752594] [<c02f9550>] (pci_scan_slot) from [<c02fa468>] (pci_scan_chi=
ld_bus+0x20/0xf8)
[    1.760814] [<c02fa468>] (pci_scan_child_bus) from [<c02fa738>] (pci_sca=
n_root_bus_msi+0xcc/0xd8)
[    1.769732] [<c02fa738>] (pci_scan_root_bus_msi) from [<c02fa75c>] (pci_=
scan_root_bus+0x18/0x20)
[    1.778563] [<c02fa75c>] (pci_scan_root_bus) from [<c0310a48>] (pci_host=
_common_probe+0xc8/0x314)
[    1.787481] [<c0310a48>] (pci_host_common_probe) from [<c03508d8>] (plat=
form_drv_probe+0x34/0x6c)
[    1.796400] [<c03508d8>] (platform_drv_probe) from [<c034f388>] (really_=
probe+0x1c4/0x250)
[    1.804706] [<c034f388>] (really_probe) from [<c034f4d8>] (__driver_atta=
ch+0xc4/0xc8)
[    1.812575] [<c034f4d8>] (__driver_attach) from [<c034d8d0>] (bus_for_ea=
ch_dev+0x68/0x9c)
[    1.820794] [<c034d8d0>] (bus_for_each_dev) from [<c034e960>] (bus_add_d=
river+0x108/0x214)
[    1.829100] [<c034e960>] (bus_add_driver) from [<c034fa3c>] (driver_regi=
ster+0x78/0xf4)
[    1.837144] [<c034fa3c>] (driver_register) from [<c010175c>] (do_one_ini=
tcall+0x44/0x170)
[    1.845362] [<c010175c>] (do_one_initcall) from [<c0600dbc>] (kernel_ini=
t_freeable+0x154/0x1e0)
[    1.854105] [<c0600dbc>] (kernel_init_freeable) from [<c04ba49c>] (kerne=
l_init+0x8/0x10c)
[    1.862325] [<c04ba49c>] (kernel_init) from [<c0107678>] (ret_from_fork+=
0x14/0x3c)
[    1.869937] ---[ end trace 4ee1a301cee5ee69 ]---
[    1.874576] ------------[ cut here ]------------
[    1.879220] WARNING: CPU: 0 PID: 1 at drivers/pci/search.c:193 pci_get_s=
lot+0xb0/0xb4
[    1.887090] Modules linked in:
[    1.890160] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W       4.9.=
23-1-rc4 #16
[    1.897938] Hardware name: Sigma Tango DT
[    1.901967] [<c010ec94>] (unwind_backtrace) from [<c010ace4>] (show_stac=
k+0x10/0x14)
[    1.909749] [<c010ace4>] (show_stack) from [<c02cc13c>] (dump_stack+0x84=
/0x98)
[    1.917007] [<c02cc13c>] (dump_stack) from [<c01183d0>] (__warn+0xe8/0x1=
00)
[    1.924003] [<c01183d0>] (__warn) from [<c0118498>] (warn_slowpath_null+=
0x20/0x28)
[    1.931611] [<c0118498>] (warn_slowpath_null) from [<c0300ca4>] (pci_get=
_slot+0xb0/0xb4)
[    1.939744] [<c0300ca4>] (pci_get_slot) from [<c02f945c>] (pci_scan_sing=
le_device+0x14/0xb0)
[    1.948225] [<c02f945c>] (pci_scan_single_device) from [<c02f9550>] (pci=
_scan_slot+0x58/0x100)
[    1.956881] [<c02f9550>] (pci_scan_slot) from [<c02fa468>] (pci_scan_chi=
ld_bus+0x20/0xf8)
[    1.965101] [<c02fa468>] (pci_scan_child_bus) from [<c02fa738>] (pci_sca=
n_root_bus_msi+0xcc/0xd8)
[    1.974019] [<c02fa738>] (pci_scan_root_bus_msi) from [<c02fa75c>] (pci_=
scan_root_bus+0x18/0x20)
[    1.982850] [<c02fa75c>] (pci_scan_root_bus) from [<c0310a48>] (pci_host=
_common_probe+0xc8/0x314)
[    1.991769] [<c0310a48>] (pci_host_common_probe) from [<c03508d8>] (plat=
form_drv_probe+0x34/0x6c)
[    2.000687] [<c03508d8>] (platform_drv_probe) from [<c034f388>] (really_=
probe+0x1c4/0x250)
[    2.008994] [<c034f388>] (really_probe) from [<c034f4d8>] (__driver_atta=
ch+0xc4/0xc8)
[    2.016863] [<c034f4d8>] (__driver_attach) from [<c034d8d0>] (bus_for_ea=
ch_dev+0x68/0x9c)
[    2.025082] [<c034d8d0>] (bus_for_each_dev) from [<c034e960>] (bus_add_d=
river+0x108/0x214)
[    2.033388] [<c034e960>] (bus_add_driver) from [<c034fa3c>] (driver_regi=
ster+0x78/0xf4)
[    2.041432] [<c034fa3c>] (driver_register) from [<c010175c>] (do_one_ini=
tcall+0x44/0x170)
0] [<c010175c>] (do_one_initcall) from [<c0600dbc>] (kernel_init_freeable+0=
x154/0x1e0)
[    2.058394] [<c0600dbc>] (kernel_init_freeable) from [<c04ba49c>] (kerne=
l_init+0x8/0x10c)
[    2.066613] [<c04ba49c>] (kernel_init) from [<c0107678>] (ret_from_fork+=
0x14/0x3c)
[    2.074225] ---[ end trace 4ee1a301cee5ee6a ]---
[    2.078865] ------------[ cut here ]------------
[    2.083509] WARNING: CPU: 0 PID: 1 at drivers/pci/search.c:193 pci_get_s=
lot+0xb0/0xb4
[    2.091380] Modules linked in:
[    2.094449] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W       4.9.=
23-1-rc4 #16
[    2.102228] Hardware name: Sigma Tango DT
[    2.106256] [<c010ec94>] (unwind_backtrace) from [<c010ace4>] (show_stac=
k+0x10/0x14)
[    2.114038] [<c010ace4>] (show_stack) from [<c02cc13c>] (dump_stack+0x84=
/0x98)
[    2.121296] [<c02cc13c>] (dump_stack) from [<c01183d0>] (__warn+0xe8/0x1=
00)
[    2.128292] [<c01183d0>] (__warn) from [<c0118498>] (warn_slowpath_null+=
0x20/0x28)
[    2.135900] [<c0118498>] (warn_slowpath_null) from [<c0300ca4>] (pci_get=
_slot+0xb0/0xb4)
[    2.144034] [<c0300ca4>] (pci_get_slot) from [<c02f945c>] (pci_scan_sing=
le_device+0x14/0xb0)
[    2.152515] [<c02f945c>] (pci_scan_single_device) from [<c02f9550>] (pci=
_scan_slot+0x58/0x100)
[    2.161171] [<c02f9550>] (pci_scan_slot) from [<c02fa468>] (pci_scan_chi=
ld_bus+0x20/0xf8)
[    2.169390] [<c02fa468>] (pci_scan_child_bus) from [<c02fa738>] (pci_sca=
n_root_bus_msi+0xcc/0xd8)
[    2.178308] [<c02fa738>] (pci_scan_root_bus_msi) from [<c02fa75c>] (pci_=
scan_root_bus+0x18/0x20)
[    2.187139] [<c02fa75c>] (pci_scan_root_bus) from [<c0310a48>] (pci_host=
_common_probe+0xc8/0x314)
[    2.196059] [<c0310a48>] (pci_host_common_probe) from [<c03508d8>] (plat=
form_drv_probe+0x34/0x6c)
[    2.204977] [<c03508d8>] (platform_drv_probe) from [<c034f388>] (really_=
probe+0x1c4/0x250)
[    2.213283] [<c034f388>] (really_probe) from [<c034f4d8>] (__driver_atta=
ch+0xc4/0xc8)
[    2.221152] [<c034f4d8>] (__driver_attach) from [<c034d8d0>] (bus_for_ea=
ch_dev+0x68/0x9c)
[    2.229371] [<c034d8d0>] (bus_for_each_dev) from [<c034e960>] (bus_add_d=
river+0x108/0x214)
[    2.237677] [<c034e960>] (bus_add_driver) from [<c034fa3c>] (driver_regi=
ster+0x78/0xf4)
[    2.245721] [<c034fa3c>] (driver_register) from [<c010175c>] (do_one_ini=
tcall+0x44/0x170)
[    2.253939] [<c010175c>] (do_one_initcall) from [<c0600dbc>] (kernel_ini=
t_freeable+0x154/0x1e0)
[    2.262682] [<c0600dbc>] (kernel_init_freeable) from [<c04ba49c>] (kerne=
l_init+0x8/0x10c)
[    2.270901] [<c04ba49c>] (kernel_init) from [<c0107678>] (ret_from_fork+=
0x14/0x3c)
[    2.278513] ---[ end trace 4ee1a301cee5ee6b ]---
[    2.283153] ------------[ cut here ]------------
[    2.287796] WARNING: CPU: 0 PID: 1 at drivers/pci/search.c:193 pci_get_s=
lot+0xb0/0xb4
[    2.295666] Modules linked in:
[    2.298731] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W       4.9.=
23-1-rc4 #16
[    2.306509] Hardware name: Sigma Tango DT
[    2.310537] [<c010ec94>] (unwind_backtrace) from [<c010ace4>] (show_stac=
k+0x10/0x14)
[    2.318319] [<c010ace4>] (show_stack) from [<c02cc13c>] (dump_stack+0x84=
/0x98)
[    2.325578] [<c02cc13c>] (dump_stack) from [<c01183d0>] (__warn+0xe8/0x1=
00)
[    2.332574] [<c01183d0>] (__warn) from [<c0118498>] (warn_slowpath_null+=
0x20/0x28)
[    2.340182] [<c0118498>] (warn_slowpath_null) from [<c0300ca4>] (pci_get=
_slot+0xb0/0xb4)
[    2.348315] [<c0300ca4>] (pci_get_slot) from [<c02f945c>] (pci_scan_sing=
le_device+0x14/0xb0)
[    2.356796] [<c02f945c>] (pci_scan_single_device) from [<c02f9550>] (pci=
_scan_slot+0x58/0x100)
[    2.365452] [<c02f9550>] (pci_scan_slot) from [<c02fa468>] (pci_scan_chi=
ld_bus+0x20/0xf8)
[    2.373671] [<c02fa468>] (pci_scan_child_bus) from [<c02fa738>] (pci_sca=
n_root_bus_msi+0xcc/0xd8)
[    2.382590] [<c02fa738>] (pci_scan_root_bus_msi) from [<c02fa75c>] (pci_=
scan_root_bus+0x18/0x20)
[    2.391420] [<c02fa75c>] (pci_scan_root_bus) from [<c0310a48>] (pci_host=
_common_probe+0xc8/0x314)
[    2.400339] [<c0310a48>] (pci_host_common_probe) from [<c03508d8>] (plat=
form_drv_probe+0x34/0x6c)
[    2.409257] [<c03508d8>] (platform_drv_probe) from [<c034f388>] (really_=
probe+0x1c4/0x250)
[    2.417563] [<c034f388>] (really_probe) from [<c034f4d8>] (__driver_atta=
ch+0xc4/0xc8)
[    2.425432] [<c034f4d8>] (__driver_attach) from [<c034d8d0>] (bus_for_ea=
ch_dev+0x68/0x9c)
[    2.433651] [<c034d8d0>] (bus_for_each_dev) from [<c034e960>] (bus_add_d=
river+0x108/0x214)
[    2.441957] [<c034e960>] (bus_add_driver) from [<c034fa3c>] (driver_regi=
ster+0x78/0xf4)
[    2.450001] [<c034fa3c>] (driver_register) from [<c010175c>] (do_one_ini=
tcall+0x44/0x170)
[    2.458220] [<c010175c>] (do_one_initcall) from [<c0600dbc>] (kernel_ini=
t_freeable+0x154/0x1e0)
[    2.466963] [<c0600dbc>] (kernel_init_freeable) from [<c04ba49c>] (kerne=
l_init+0x8/0x10c)
[    2.475183] [<c04ba49c>] (kernel_init) from [<c0107678>] (ret_from_fork+=
0x14/0x3c)
[    2.482794] ---[ end trace 4ee1a301cee5ee6c ]---
[    2.487435] ------------[ cut here ]------------
[    2.492080] WARNING: CPU: 0 PID: 1 at drivers/pci/search.c:193 pci_get_s=
lot+0xb0/0xb4
[    2.499951] Modules linked in:
[    2.503021] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W       4.9.=
23-1-rc4 #16
[    2.510800] Hardware name: Sigma Tango DT
[    2.514828] [<c010ec94>] (unwind_backtrace) from [<c010ace4>] (show_stac=
k+0x10/0x14)
[    2.522610] [<c010ace4>] (show_stack) from [<c02cc13c>] (dump_stack+0x84=
/0x98)
[    2.529869] [<c02cc13c>] (dump_stack) from [<c01183d0>] (__warn+0xe8/0x1=
00)
[    2.536865] [<c01183d0>] (__warn) from [<c0118498>] (warn_slowpath_null+=
0x20/0x28)
[    2.544473] [<c0118498>] (warn_slowpath_null) from [<c0300ca4>] (pci_get=
_slot+0xb0/0xb4)
[    2.552606] [<c0300ca4>] (pci_get_slot) from [<c02f945c>] (pci_scan_sing=
le_device+0x14/0xb0)
[    2.561087] [<c02f945c>] (pci_scan_single_device) from [<c02f9550>] (pci=
_scan_slot+0x58/0x100)
[    2.569743] [<c02f9550>] (pci_scan_slot) from [<c02fa468>] (pci_scan_chi=
ld_bus+0x20/0xf8)
[    2.577963] [<c02fa468>] (pci_scan_child_bus) from [<c02fa738>] (pci_sca=
n_root_bus_msi+0xcc/0xd8)
[    2.586881] [<c02fa738>] (pci_scan_root_bus_msi) from [<c02fa75c>] (pci_=
scan_root_bus+0x18/0x20)
[    2.595712] [<c02fa75c>] (pci_scan_root_bus) from [<c0310a48>] (pci_host=
_common_probe+0xc8/0x314)
[    2.604631] [<c0310a48>] (pci_host_common_probe) from [<c03508d8>] (plat=
form_drv_probe+0x34/0x6c)
[    2.613550] [<c03508d8>] (platform_drv_probe) from [<c034f388>] (really_=
probe+0x1c4/0x250)
[    2.621856] [<c034f388>] (really_probe) from [<c034f4d8>] (__driver_atta=
ch+0xc4/0xc8)
[    2.629725] [<c034f4d8>] (__driver_attach) from [<c034d8d0>] (bus_for_ea=
ch_dev+0x68/0x9c)
[    2.637944] [<c034d8d0>] (bus_for_each_dev) from [<c034e960>] (bus_add_d=
river+0x108/0x214)
[    2.646250] [<c034e960>] (bus_add_driver) from [<c034fa3c>] (driver_regi=
ster+0x78/0xf4)
[    2.654294] [<c034fa3c>] (driver_register) from [<c010175c>] (do_one_ini=
tcall+0x44/0x170)
[    2.662513] [<c010175c>] (do_one_initcall) from [<c0600dbc>] (kernel_ini=
t_freeable+0x154/0x1e0)
[    2.671256] [<c0600dbc>] (kernel_init_freeable) from [<c04ba49c>] (kerne=
l_init+0x8/0x10c)
[    2.679475] [<c04ba49c>] (kernel_init) from [<c0107678>] (ret_from_fork+=
0x14/0x3c)
[    2.687088] ---[ end trace 4ee1a301cee5ee6d ]---
[    2.691728] ------------[ cut here ]------------
[    2.696371] WARNING: CPU: 0 PID: 1 at drivers/pci/search.c:193 pci_get_s=
lot+0xb0/0xb4
[    2.704242] Modules linked in:
[    2.707312] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W       4.9.=
23-1-rc4 #16
[    2.715090] Hardware name: Sigma Tango DT
[    2.719119] [<c010ec94>] (unwind_backtrace) from [<c010ace4>] (show_stac=
k+0x10/0x14)
[    2.726901] [<c010ace4>] (show_stack) from [<c02cc13c>] (dump_stack+0x84=
/0x98)
[    2.734159] [<c02cc13c>] (dump_stack) from [<c01183d0>] (__warn+0xe8/0x1=
00)
[    2.741155] [<c01183d0>] (__warn) from [<c0118498>] (warn_slowpath_null+=
0x20/0x28)
[    2.748763] [<c0118498>] (warn_slowpath_null) from [<c0300ca4>] (pci_get=
_slot+0xb0/0xb4)
[    2.756896] [<c0300ca4>] (pci_get_slot) from [<c02f945c>] (pci_scan_sing=
le_device+0x14/0xb0)
[    2.765377] [<c02f945c>] (pci_scan_single_device) from [<c02f9550>] (pci=
_scan_slot+0x58/0x100)
[    2.774033] [<c02f9550>] (pci_scan_slot) from [<c02fa468>] (pci_scan_chi=
ld_bus+0x20/0xf8)
[    2.782252] [<c02fa468>] (pci_scan_child_bus) from [<c02fa738>] (pci_sca=
n_root_bus_msi+0xcc/0xd8)
[    2.791171] [<c02fa738>] (pci_scan_root_bus_msi) from [<c02fa75c>] (pci_=
scan_root_bus+0x18/0x20)
[    2.800002] [<c02fa75c>] (pci_scan_root_bus) from [<c0310a48>] (pci_host=
_common_probe+0xc8/0x314)
[    2.808921] [<c0310a48>] (pci_host_common_probe) from [<c03508d8>] (plat=
form_drv_probe+0x34/0x6c)
[    2.817838] [<c03508d8>] (platform_drv_probe) from [<c034f388>] (really_=
probe+0x1c4/0x250)
[    2.826145] [<c034f388>] (really_probe) from [<c034f4d8>] (__driver_atta=
ch+0xc4/0xc8)
[    2.834014] [<c034f4d8>] (__driver_attach) from [<c034d8d0>] (bus_for_ea=
ch_dev+0x68/0x9c)
[    2.842233] [<c034d8d0>] (bus_for_each_dev) from [<c034e960>] (bus_add_d=
river+0x108/0x214)
[    2.850539] [<c034e960>] (bus_add_driver) from [<c034fa3c>] (driver_regi=
ster+0x78/0xf4)
[    2.858583] [<c034fa3c>] (driver_register) from [<c010175c>] (do_one_ini=
tcall+0x44/0x170)
[    2.866801] [<c010175c>] (do_one_initcall) from [<c0600dbc>] (kernel_ini=
t_freeable+0x154/0x1e0)
[    2.875545] [<c0600dbc>] (kernel_init_freeable) from [<c04ba49c>] (kerne=
l_init+0x8/0x10c)
[    2.883764] [<c04ba49c>] (kernel_init) from [<c0107678>] (ret_from_fork+=
0x14/0x3c)
[    2.891375] ---[ end trace 4ee1a301cee5ee6e ]---
[    2.896015] ------------[ cut here ]------------
[    2.900658] WARNING: CPU: 0 PID: 1 at drivers/pci/search.c:193 pci_get_s=
lot+0xb0/0xb4
[    2.908528] Modules linked in:
[    2.911598] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W       4.9.=
23-1-rc4 #16
[    2.919376] Hardware name: Sigma Tango DT
[    2.923404] [<c010ec94>] (unwind_backtrace) from [<c010ace4>] (show_stac=
k+0x10/0x14)
[    2.931186] [<c010ace4>] (show_stack) from [<c02cc13c>] (dump_stack+0x84=
/0x98)
[    2.938444] [<c02cc13c>] (dump_stack) from [<c01183d0>] (__warn+0xe8/0x1=
00)
[    2.945441] [<c01183d0>] (__warn) from [<c0118498>] (warn_slowpath_null+=
0x20/0x28)
[    2.953049] [<c0118498>] (warn_slowpath_null) from [<c0300ca4>] (pci_get=
_slot+0xb0/0xb4)
[    2.961181] [<c0300ca4>] (pci_get_slot) from [<c02f945c>] (pci_scan_sing=
le_device+0x14/0xb0)
[    2.969663] [<c02f945c>] (pci_scan_single_device) from [<c02f9550>] (pci=
_scan_slot+0x58/0x100)
[    2.978319] [<c02f9550>] (pci_scan_slot) from [<c02fa468>] (pci_scan_chi=
ld_bus+0x20/0xf8)
[    2.986538] [<c02fa468>] (pci_scan_child_bus) from [<c02fa738>] (pci_sca=
n_root_bus_msi+0xcc/0xd8)
[    2.995456] [<c02fa738>] (pci_scan_root_bus_msi) from [<c02fa75c>] (pci_=
scan_root_bus+0x18/0x20)
[    3.004287] [<c02fa75c>] (pci_scan_root_bus) from [<c0310a48>] (pci_host=
_common_probe+0xc8/0x314)
[    3.013206] [<c0310a48>] (pci_host_common_probe) from [<c03508d8>] (plat=
form_drv_probe+0x34/0x6c)
[    3.022124] [<c03508d8>] (platform_drv_probe) from [<c034f388>] (really_=
probe+0x1c4/0x250)
[    3.030430] [<c034f388>] (really_probe) from [<c034f4d8>] (__driver_atta=
ch+0xc4/0xc8)
[    3.038300] [<c034f4d8>] (__driver_attach) from [<c034d8d0>] (bus_for_ea=
ch_dev+0x68/0x9c)
[    3.046518] [<c034d8d0>] (bus_for_each_dev) from [<c034e960>] (bus_add_d=
river+0x108/0x214)
[    3.054825] [<c034e960>] (bus_add_driver) from [<c034fa3c>] (driver_regi=
ster+0x78/0xf4)
[    3.062869] [<c034fa3c>] (driver_register) from [<c010175c>] (do_one_ini=
tcall+0x44/0x170)
[    3.071088] [<c010175c>] (do_one_initcall) from [<c0600dbc>] (kernel_ini=
t_freeable+0x154/0x1e0)
[    3.079832] [<c0600dbc>] (kernel_init_freeable) from [<c04ba49c>] (kerne=
l_init+0x8/0x10c)
[    3.088051] [<c04ba49c>] (kernel_init) from [<c0107678>] (ret_from_fork+=
0x14/0x3c)
[    3.095663] ---[ end trace 4ee1a301cee5ee6f ]---
[    3.100302] ------------[ cut here ]------------
[    3.104945] WARNING: CPU: 0 PID: 1 at drivers/pci/search.c:193 pci_get_s=
lot+0xb0/0xb4
[    3.112816] Modules linked in:
[    3.115885] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W       4.9.=
23-1-rc4 #16
[    3.123663] Hardware name: Sigma Tango DT
[    3.127691] [<c010ec94>] (unwind_backtrace) from [<c010ace4>] (show_stac=
k+0x10/0x14)
[    3.135474] [<c010ace4>] (show_stack) from [<c02cc13c>] (dump_stack+0x84=
/0x98)
[    3.142732] [<c02cc13c>] (dump_stack) from [<c01183d0>] (__warn+0xe8/0x1=
00)
[    3.149728] [<c01183d0>] (__warn) from [<c0118498>] (warn_slowpath_null+=
0x20/0x28)
[    3.157336] [<c0118498>] (warn_slowpath_null) from [<c0300ca4>] (pci_get=
_slot+0xb0/0xb4)
[    3.165469] [<c0300ca4>] (pci_get_slot) from [<c02f945c>] (pci_scan_sing=
le_device+0x14/0xb0)
[    3.173951] [<c02f945c>] (pci_scan_single_device) from [<c02f9550>] (pci=
_scan_slot+0x58/0x100)
[    3.182607] [<c02f9550>] (pci_scan_slot) from [<c02fa468>] (pci_scan_chi=
ld_bus+0x20/0xf8)
[    3.190826] [<c02fa468>] (pci_scan_child_bus) from [<c02fa738>] (pci_sca=
n_root_bus_msi+0xcc/0xd8)
[    3.199744] [<c02fa738>] (pci_scan_root_bus_msi) from [<c02fa75c>] (pci_=
scan_root_bus+0x18/0x20)
[    3.208575] [<c02fa75c>] (pci_scan_root_bus) from [<c0310a48>] (pci_host=
_common_probe+0xc8/0x314)
[    3.217494] [<c0310a48>] (pci_host_common_probe) from [<c03508d8>] (plat=
form_drv_probe+0x34/0x6c)
[    3.226413] [<c03508d8>] (platform_drv_probe) from [<c034f388>] (really_=
probe+0x1c4/0x250)
[    3.234719] [<c034f388>] (really_probe) from [<c034f4d8>] (__driver_atta=
ch+0xc4/0xc8)
[    3.242588] [<c034f4d8>] (__driver_attach) from [<c034d8d0>] (bus_for_ea=
ch_dev+0x68/0x9c)
[    3.250806] [<c034d8d0>] (bus_for_each_dev) from [<c034e960>] (bus_add_d=
river+0x108/0x214)
[    3.259112] [<c034e960>] (bus_add_driver) from [<c034fa3c>] (driver_regi=
ster+0x78/0xf4)
[    3.267156] [<c034fa3c>] (driver_register) from [<c010175c>] (do_one_ini=
tcall+0x44/0x170)
[    3.275374] [<c010175c>] (do_one_initcall) from [<c0600dbc>] (kernel_ini=
t_freeable+0x154/0x1e0)
[    3.284118] [<c0600dbc>] (kernel_init_freeable) from [<c04ba49c>] (kerne=
l_init+0x8/0x10c)
[    3.292337] [<c04ba49c>] (kernel_init) from [<c0107678>] (ret_from_fork+=
0x14/0x3c)
[    3.299948] ---[ end trace 4ee1a301cee5ee70 ]---
[    3.304588] ------------[ cut here ]------------
[    3.309231] WARNING: CPU: 0 PID: 1 at drivers/pci/search.c:193 pci_get_s=
lot+0xb0/0xb4
[    3.317102] Modules linked in:
[    3.320172] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W       4.9.=
23-1-rc4 #16
[    3.327950] Hardware name: Sigma Tango DT
[    3.331979] [<c010ec94>] (unwind_backtrace) from [<c010ace4>] (show_stac=
k+0x10/0x14)
[    3.339761] [<c010ace4>] (show_stack) from [<c02cc13c>] (dump_stack+0x84=
/0x98)
[    3.347019] [<c02cc13c>] (dump_stack) from [<c01183d0>] (__warn+0xe8/0x1=
00)
[    3.354016] [<c01183d0>] (__warn) from [<c0118498>] (warn_slowpath_null+=
0x20/0x28)
[    3.361624] [<c0118498>] (warn_slowpath_null) from [<c0300ca4>] (pci_get=
_slot+0xb0/0xb4)
[    3.369756] [<c0300ca4>] (pci_get_slot) from [<c02f945c>] (pci_scan_sing=
le_device+0x14/0xb0)
[    3.378237] [<c02f945c>] (pci_scan_single_device) from [<c02f9550>] (pci=
_scan_slot+0x58/0x100)
[    3.386894] [<c02f9550>] (pci_scan_slot) from [<c02fa468>] (pci_scan_chi=
ld_bus+0x20/0xf8)
[    3.395113] [<c02fa468>] (pci_scan_child_bus) from [<c02fa738>] (pci_sca=
n_root_bus_msi+0xcc/0xd8)
[    3.404031] [<c02fa738>] (pci_scan_root_bus_msi) from [<c02fa75c>] (pci_=
scan_root_bus+0x18/0x20)
[    3.412862] [<c02fa75c>] (pci_scan_root_bus) from [<c0310a48>] (pci_host=
_common_probe+0xc8/0x314)
[    3.421781] [<c0310a48>] (pci_host_common_probe) from [<c03508d8>] (plat=
form_drv_probe+0x34/0x6c)
[    3.430699] [<c03508d8>] (platform_drv_probe) from [<c034f388>] (really_=
probe+0x1c4/0x250)
[    3.439005] [<c034f388>] (really_probe) from [<c034f4d8>] (__driver_atta=
ch+0xc4/0xc8)
[    3.446874] [<c034f4d8>] (__driver_attach) from [<c034d8d0>] (bus_for_ea=
ch_dev+0x68/0x9c)
[    3.455093] [<c034d8d0>] (bus_for_each_dev) from [<c034e960>] (bus_add_d=
river+0x108/0x214)
[    3.463399] [<c034e960>] (bus_add_driver) from [<c034fa3c>] (driver_regi=
ster+0x78/0xf4)
[    3.471443] [<c034fa3c>] (driver_register) from [<c010175c>] (do_one_ini=
tcall+0x44/0x170)
[    3.479661] [<c010175c>] (do_one_initcall) from [<c0600dbc>] (kernel_ini=
t_freeable+0x154/0x1e0)
[    3.488405] [<c0600dbc>] (kernel_init_freeable) from [<c04ba49c>] (kerne=
l_init+0x8/0x10c)
[    3.496624] [<c04ba49c>] (kernel_init) from [<c0107678>] (ret_from_fork+=
0x14/0x3c)
[    3.504235] ---[ end trace 4ee1a301cee5ee71 ]---
[    3.508875] ------------[ cut here ]------------
[    3.513519] WARNING: CPU: 0 PID: 1 at drivers/pci/search.c:193 pci_get_s=
lot+0xb0/0xb4
[    3.521390] Modules linked in:
[    3.524459] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W       4.9.=
23-1-rc4 #16
[    3.532237] Hardware name: Sigma Tango DT
[    3.536265] [<c010ec94>] (unwind_backtrace) from [<c010ace4>] (show_stac=
k+0x10/0x14)
[    3.544048] [<c010ace4>] (show_stack) from [<c02cc13c>] (dump_stack+0x84=
/0x98)
[    3.551306] [<c02cc13c>] (dump_stack) from [<c01183d0>] (__warn+0xe8/0x1=
00)
[    3.558303] [<c01183d0>] (__warn) from [<c0118498>] (warn_slowpath_null+=
0x20/0x28)
[    3.565911] [<c0118498>] (warn_slowpath_null) from [<c0300ca4>] (pci_get=
_slot+0xb0/0xb4)
[    3.574044] [<c0300ca4>] (pci_get_slot) from [<c02f945c>] (pci_scan_sing=
le_device+0x14/0xb0)
[    3.582526] [<c02f945c>] (pci_scan_single_device) from [<c02f9550>] (pci=
_scan_slot+0x58/0x100)
[    3.591182] [<c02f9550>] (pci_scan_slot) from [<c02fa468>] (pci_scan_chi=
ld_bus+0x20/0xf8)
[    3.599401] [<c02fa468>] (pci_scan_child_bus) from [<c02fa738>] (pci_sca=
n_root_bus_msi+0xcc/0xd8)
[    3.608319] [<c02fa738>] (pci_scan_root_bus_msi) from [<c02fa75c>] (pci_=
scan_root_bus+0x18/0x20)
[    3.617150] [<c02fa75c>] (pci_scan_root_bus) from [<c0310a48>] (pci_host=
_common_probe+0xc8/0x314)
[    3.626069] [<c0310a48>] (pci_host_common_probe) from [<c03508d8>] (plat=
form_drv_probe+0x34/0x6c)
[    3.634987] [<c03508d8>] (platform_drv_probe) from [<c034f388>] (really_=
probe+0x1c4/0x250)
[    3.643293] [<c034f388>] (really_probe) from [<c034f4d8>] (__driver_atta=
ch+0xc4/0xc8)
[    3.651163] [<c034f4d8>] (__driver_attach) from [<c034d8d0>] (bus_for_ea=
ch_dev+0x68/0x9c)
[    3.659381] [<c034d8d0>] (bus_for_each_dev) from [<c034e960>] (bus_add_d=
river+0x108/0x214)
[    3.667688] [<c034e960>] (bus_add_driver) from [<c034fa3c>] (driver_regi=
ster+0x78/0xf4)
[    3.675732] [<c034fa3c>] (driver_register) from [<c010175c>] (do_one_ini=
tcall+0x44/0x170)
[    3.683950] [<c010175c>] (do_one_initcall) from [<c0600dbc>] (kernel_ini=
t_freeable+0x154/0x1e0)
[    3.692694] [<c0600dbc>] (kernel_init_freeable) from [<c04ba49c>] (kerne=
l_init+0x8/0x10c)
[    3.700913] [<c04ba49c>] (kernel_init) from [<c0107678>] (ret_from_fork+=
0x14/0x3c)
[    3.708525] ---[ end trace 4ee1a301cee5ee72 ]---
[    3.713165] ------------[ cut here ]------------
[    3.717808] WARNING: CPU: 0 PID: 1 at drivers/pci/search.c:193 pci_get_s=
lot+0xb0/0xb4
[    3.725679] Modules linked in:
[    3.728743] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W       4.9.=
23-1-rc4 #16
[    3.736521] Hardware name: Sigma Tango DT
[    3.740549] [<c010ec94>] (unwind_backtrace) from [<c010ace4>] (show_stac=
k+0x10/0x14)
[    3.748331] [<c010ace4>] (show_stack) from [<c02cc13c>] (dump_stack+0x84=
/0x98)
[    3.755590] [<c02cc13c>] (dump_stack) from [<c01183d0>] (__warn+0xe8/0x1=
00)
[    3.762586] [<c01183d0>] (__warn) from [<c0118498>] (warn_slowpath_null+=
0x20/0x28)
[    3.770193] [<c0118498>] (warn_slowpath_null) from [<c0300ca4>] (pci_get=
_slot+0xb0/0xb4)
[    3.778326] [<c0300ca4>] (pci_get_slot) from [<c02f945c>] (pci_scan_sing=
le_device+0x14/0xb0)
[    3.786808] [<c02f945c>] (pci_scan_single_device) from [<c02f9550>] (pci=
_scan_slot+0x58/0x100)
[    3.795464] [<c02f9550>] (pci_scan_slot) from [<c02fa468>] (pci_scan_chi=
ld_bus+0x20/0xf8)
[    3.803683] [<c02fa468>] (pci_scan_child_bus) from [<c02fa738>] (pci_sca=
n_root_bus_msi+0xcc/0xd8)
[    3.812601] [<c02fa738>] (pci_scan_root_bus_msi) from [<c02fa75c>] (pci_=
scan_root_bus+0x18/0x20)
[    3.821432] [<c02fa75c>] (pci_scan_root_bus) from [<c0310a48>] (pci_host=
_common_probe+0xc8/0x314)
[    3.830351] [<c0310a48>] (pci_host_common_probe) from [<c03508d8>] (plat=
form_drv_probe+0x34/0x6c)
[    3.839269] [<c03508d8>] (platform_drv_probe) from [<c034f388>] (really_=
probe+0x1c4/0x250)
[    3.847575] [<c034f388>] (really_probe) from [<c034f4d8>] (__driver_atta=
ch+0xc4/0xc8)
[    3.855445] [<c034f4d8>] (__driver_attach) from [<c034d8d0>] (bus_for_ea=
ch_dev+0x68/0x9c)
[    3.863664] [<c034d8d0>] (bus_for_each_dev) from [<c034e960>] (bus_add_d=
river+0x108/0x214)
[    3.871970] [<c034e960>] (bus_add_driver) from [<c034fa3c>] (driver_regi=
ster+0x78/0xf4)
[    3.880014] [<c034fa3c>] (driver_register) from [<c010175c>] (do_one_ini=
tcall+0x44/0x170)
[    3.888233] [<c010175c>] (do_one_initcall) from [<c0600dbc>] (kernel_ini=
t_freeable+0x154/0x1e0)
[    3.896976] [<c0600dbc>] (kernel_init_freeable) from [<c04ba49c>] (kerne=
l_init+0x8/0x10c)
[    3.905195] [<c04ba49c>] (kernel_init) from [<c0107678>] (ret_from_fork+=
0x14/0x3c)
[    3.912806] ---[ end trace 4ee1a301cee5ee73 ]---
[    3.917445] ------------[ cut here ]------------
[    3.922089] WARNING: CPU: 0 PID: 1 at drivers/pci/search.c:193 pci_get_s=
lot+0xb0/0xb4
[    3.929960] Modules linked in:
[    3.933029] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W       4.9.=
23-1-rc4 #16
[    3.940807] Hardware name: Sigma Tango DT
[    3.944836] [<c010ec94>] (unwind_backtrace) from [<c010ace4>] (show_stac=
k+0x10/0x14)
[    3.952618] [<c010ace4>] (show_stack) from [<c02cc13c>] (dump_stack+0x84=
/0x98)
[    3.959876] [<c02cc13c>] (dump_stack) from [<c01183d0>] (__warn+0xe8/0x1=
00)
[    3.966872] [<c01183d0>] (__warn) from [<c0118498>] (warn_slowpath_null+=
0x20/0x28)
[    3.974480] [<c0118498>] (warn_slowpath_null) from [<c0300ca4>] (pci_get=
_slot+0xb0/0xb4)
[    3.982613] [<c0300ca4>] (pci_get_slot) from [<c02f945c>] (pci_scan_sing=
le_device+0x14/0xb0)
[    3.991094] [<c02f945c>] (pci_scan_single_device) from [<c02f9550>] (pci=
_scan_slot+0x58/0x100)
[    3.999750] [<c02f9550>] (pci_scan_slot) from [<c02fa468>] (pci_scan_chi=
ld_bus+0x20/0xf8)
[    4.007970] [<c02fa468>] (pci_scan_child_bus) from [<c02fa738>] (pci_sca=
n_root_bus_msi+0xcc/0xd8)
[    4.016888] [<c02fa738>] (pci_scan_root_bus_msi) from [<c02fa75c>] (pci_=
scan_root_bus+0x18/0x20)
[    4.025719] [<c02fa75c>] (pci_scan_root_bus) from [<c0310a48>] (pci_host=
_common_probe+0xc8/0x314)
[    4.034638] [<c0310a48>] (pci_host_common_probe) from [<c03508d8>] (plat=
form_drv_probe+0x34/0x6c)
[    4.043556] [<c03508d8>] (platform_drv_probe) from [<c034f388>] (really_=
probe+0x1c4/0x250)
[    4.051863] [<c034f388>] (really_probe) from [<c034f4d8>] (__driver_atta=
ch+0xc4/0xc8)
[    4.059732] [<c034f4d8>] (__driver_attach) from [<c034d8d0>] (bus_for_ea=
ch_dev+0x68/0x9c)
[    4.067951] [<c034d8d0>] (bus_for_each_dev) from [<c034e960>] (bus_add_d=
river+0x108/0x214)
[    4.076257] [<c034e960>] (bus_add_driver) from [<c034fa3c>] (driver_regi=
ster+0x78/0xf4)
[    4.084300] [<c034fa3c>] (driver_register) from [<c010175c>] (do_one_ini=
tcall+0x44/0x170)
[    4.092519] [<c010175c>] (do_one_initcall) from [<c0600dbc>] (kernel_ini=
t_freeable+0x154/0x1e0)
[    4.101262] [<c0600dbc>] (kernel_init_freeable) from [<c04ba49c>] (kerne=
l_init+0x8/0x10c)
[    4.109481] [<c04ba49c>] (kernel_init) from [<c0107678>] (ret_from_fork+=
0x14/0x3c)
[    4.117092] ---[ end trace 4ee1a301cee5ee74 ]---
[    4.121732] ------------[ cut here ]------------
[    4.126376] WARNING: CPU: 0 PID: 1 at drivers/pci/search.c:193 pci_get_s=
lot+0xb0/0xb4
[    4.134246] Modules linked in:
[    4.137316] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W       4.9.=
23-1-rc4 #16
[    4.145094] Hardware name: Sigma Tango DT
[    4.149122] [<c010ec94>] (unwind_backtrace) from [<c010ace4>] (show_stac=
k+0x10/0x14)
[    4.156904] [<c010ace4>] (show_stack) from [<c02cc13c>] (dump_stack+0x84=
/0x98)
[    4.164163] [<c02cc13c>] (dump_stack) from [<c01183d0>] (__warn+0xe8/0x1=
00)
[    4.171159] [<c01183d0>] (__warn) from [<c0118498>] (warn_slowpath_null+=
0x20/0x28)
[    4.178766] [<c0118498>] (warn_slowpath_null) from [<c0300ca4>] (pci_get=
_slot+0xb0/0xb4)
[    4.186899] [<c0300ca4>] (pci_get_slot) from [<c02f945c>] (pci_scan_sing=
le_device+0x14/0xb0)
[    4.195381] [<c02f945c>] (pci_scan_single_device) from [<c02f9550>] (pci=
_scan_slot+0x58/0x100)
[    4.204036] [<c02f9550>] (pci_scan_slot) from [<c02fa468>] (pci_scan_chi=
ld_bus+0x20/0xf8)
[    4.212256] [<c02fa468>] (pci_scan_child_bus) from [<c02fa738>] (pci_sca=
n_root_bus_msi+0xcc/0xd8)
[    4.221174] [<c02fa738>] (pci_scan_root_bus_msi) from [<c02fa75c>] (pci_=
scan_root_bus+0x18/0x20)
[    4.230005] [<c02fa75c>] (pci_scan_root_bus) from [<c0310a48>] (pci_host=
_common_probe+0xc8/0x314)
[    4.238924] [<c0310a48>] (pci_host_common_probe) from [<c03508d8>] (plat=
form_drv_probe+0x34/0x6c)
[    4.247842] [<c03508d8>] (platform_drv_probe) from [<c034f388>] (really_=
probe+0x1c4/0x250)
[    4.256148] [<c034f388>] (really_probe) from [<c034f4d8>] (__driver_atta=
ch+0xc4/0xc8)
[    4.264017] [<c034f4d8>] (__driver_attach) from [<c034d8d0>] (bus_for_ea=
ch_dev+0x68/0x9c)
[    4.272236] [<c034d8d0>] (bus_for_each_dev) from [<c034e960>] (bus_add_d=
river+0x108/0x214)
[    4.280543] [<c034e960>] (bus_add_driver) from [<c034fa3c>] (driver_regi=
ster+0x78/0xf4)
[    4.288587] [<c034fa3c>] (driver_register) from [<c010175c>] (do_one_ini=
tcall+0x44/0x170)
[    4.296805] [<c010175c>] (do_one_initcall) from [<c0600dbc>] (kernel_ini=
t_freeable+0x154/0x1e0)
[    4.305549] [<c0600dbc>] (kernel_init_freeable) from [<c04ba49c>] (kerne=
l_init+0x8/0x10c)
[    4.313768] [<c04ba49c>] (kernel_init) from [<c0107678>] (ret_from_fork+=
0x14/0x3c)
[    4.321380] ---[ end trace 4ee1a301cee5ee75 ]---
[    4.326020] ------------[ cut here ]------------
[    4.330663] WARNING: CPU: 0 PID: 1 at drivers/pci/search.c:193 pci_get_s=
lot+0xb0/0xb4
[    4.338533] Modules linked in:
[    4.341603] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W       4.9.=
23-1-rc4 #16
[    4.349381] Hardware name: Sigma Tango DT
[    4.353409] [<c010ec94>] (unwind_backtrace) from [<c010ace4>] (show_stac=
k+0x10/0x14)
[    4.361191] [<c010ace4>] (show_stack) from [<c02cc13c>] (dump_stack+0x84=
/0x98)
[    4.368450] [<c02cc13c>] (dump_stack) from [<c01183d0>] (__warn+0xe8/0x1=
00)
[    4.375446] [<c01183d0>] (__warn) from [<c0118498>] (warn_slowpath_null+=
0x20/0x28)
[    4.383053] [<c0118498>] (warn_slowpath_null) from [<c0300ca4>] (pci_get=
_slot+0xb0/0xb4)
[    4.391186] [<c0300ca4>] (pci_get_slot) from [<c02f945c>] (pci_scan_sing=
le_device+0x14/0xb0)
[    4.399667] [<c02f945c>] (pci_scan_single_device) from [<c02f9550>] (pci=
_scan_slot+0x58/0x100)
[    4.408324] [<c02f9550>] (pci_scan_slot) from [<c02fa468>] (pci_scan_chi=
ld_bus+0x20/0xf8)
[    4.416543] [<c02fa468>] (pci_scan_child_bus) from [<c02fa738>] (pci_sca=
n_root_bus_msi+0xcc/0xd8)
[    4.425461] [<c02fa738>] (pci_scan_root_bus_msi) from [<c02fa75c>] (pci_=
scan_root_bus+0x18/0x20)
[    4.434292] [<c02fa75c>] (pci_scan_root_bus) from [<c0310a48>] (pci_host=
_common_probe+0xc8/0x314)
[    4.443211] [<c0310a48>] (pci_host_common_probe) from [<c03508d8>] (plat=
form_drv_probe+0x34/0x6c)
[    4.452129] [<c03508d8>] (platform_drv_probe) from [<c034f388>] (really_=
probe+0x1c4/0x250)
[    4.460435] [<c034f388>] (really_probe) from [<c034f4d8>] (__driver_atta=
ch+0xc4/0xc8)
[    4.468304] [<c034f4d8>] (__driver_attach) from [<c034d8d0>] (bus_for_ea=
ch_dev+0x68/0x9c)
[    4.476523] [<c034d8d0>] (bus_for_each_dev) from [<c034e960>] (bus_add_d=
river+0x108/0x214)
[    4.484830] [<c034e960>] (bus_add_driver) from [<c034fa3c>] (driver_regi=
ster+0x78/0xf4)
[    4.492874] [<c034fa3c>] (driver_register) from [<c010175c>] (do_one_ini=
tcall+0x44/0x170)
[    4.501092] [<c010175c>] (do_one_initcall) from [<c0600dbc>] (kernel_ini=
t_freeable+0x154/0x1e0)
[    4.509836] [<c0600dbc>] (kernel_init_freeable) from [<c04ba49c>] (kerne=
l_init+0x8/0x10c)
[    4.518055] [<c04ba49c>] (kernel_init) from [<c0107678>] (ret_from_fork+=
0x14/0x3c)
[    4.525665] ---[ end trace 4ee1a301cee5ee76 ]---
[    4.530305] ------------[ cut here ]------------
[    4.534948] WARNING: CPU: 0 PID: 1 at drivers/pci/search.c:193 pci_get_s=
lot+0xb0/0xb4
[    4.542819] Modules linked in:
[    4.545889] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W       4.9.=
23-1-rc4 #16
[    4.553667] Hardware name: Sigma Tango DT
[    4.557695] [<c010ec94>] (unwind_backtrace) from [<c010ace4>] (show_stac=
k+0x10/0x14)
[    4.565478] [<c010ace4>] (show_stack) from [<c02cc13c>] (dump_stack+0x84=
/0x98)
[    4.572736] [<c02cc13c>] (dump_stack) from [<c01183d0>] (__warn+0xe8/0x1=
00)
[    4.579732] [<c01183d0>] (__warn) from [<c0118498>] (warn_slowpath_null+=
0x20/0x28)
[    4.587340] [<c0118498>] (warn_slowpath_null) from [<c0300ca4>] (pci_get=
_slot+0xb0/0xb4)
[    4.595473] [<c0300ca4>] (pci_get_slot) from [<c02f945c>] (pci_scan_sing=
le_device+0x14/0xb0)
[    4.603954] [<c02f945c>] (pci_scan_single_device) from [<c02f9550>] (pci=
_scan_slot+0x58/0x100)
[    4.612610] [<c02f9550>] (pci_scan_slot) from [<c02fa468>] (pci_scan_chi=
ld_bus+0x20/0xf8)
[    4.620829] [<c02fa468>] (pci_scan_child_bus) from [<c02fa738>] (pci_sca=
n_root_bus_msi+0xcc/0xd8)
[    4.629748] [<c02fa738>] (pci_scan_root_bus_msi) from [<c02fa75c>] (pci_=
scan_root_bus+0x18/0x20)
[    4.638579] [<c02fa75c>] (pci_scan_root_bus) from [<c0310a48>] (pci_host=
_common_probe+0xc8/0x314)
[    4.647497] [<c0310a48>] (pci_host_common_probe) from [<c03508d8>] (plat=
form_drv_probe+0x34/0x6c)
[    4.656415] [<c03508d8>] (platform_drv_probe) from [<c034f388>] (really_=
probe+0x1c4/0x250)
[    4.664721] [<c034f388>] (really_probe) from [<c034f4d8>] (__driver_atta=
ch+0xc4/0xc8)
[    4.672591] [<c034f4d8>] (__driver_attach) from [<c034d8d0>] (bus_for_ea=
ch_dev+0x68/0x9c)
[    4.680809] [<c034d8d0>] (bus_for_each_dev) from [<c034e960>] (bus_add_d=
river+0x108/0x214)
[    4.689116] [<c034e960>] (bus_add_driver) from [<c034fa3c>] (driver_regi=
ster+0x78/0xf4)
[    4.697160] [<c034fa3c>] (driver_register) from [<c010175c>] (do_one_ini=
tcall+0x44/0x170)
[    4.705378] [<c010175c>] (do_one_initcall) from [<c0600dbc>] (kernel_ini=
t_freeable+0x154/0x1e0)
[    4.714122] [<c0600dbc>] (kernel_init_freeable) from [<c04ba49c>] (kerne=
l_init+0x8/0x10c)
[    4.722341] [<c04ba49c>] (kernel_init) from [<c0107678>] (ret_from_fork+=
0x14/0x3c)
[    4.729953] ---[ end trace 4ee1a301cee5ee77 ]---
[    4.734592] ------------[ cut here ]------------
[    4.739237] WARNING: CPU: 0 PID: 1 at drivers/pci/search.c:193 pci_get_s=
lot+0xb0/0xb4
[    4.747107] Modules linked in:
[    4.750178] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W       4.9.=
23-1-rc4 #16
[    4.757956] Hardware name: Sigma Tango DT
[    4.761984] [<c010ec94>] (unwind_backtrace) from [<c010ace4>] (show_stac=
k+0x10/0x14)
[    4.769767] [<c010ace4>] (show_stack) from [<c02cc13c>] (dump_stack+0x84=
/0x98)
[    4.777025] [<c02cc13c>] (dump_stack) from [<c01183d0>] (__warn+0xe8/0x1=
00)
[    4.784021] [<c01183d0>] (__warn) from [<c0118498>] (warn_slowpath_null+=
0x20/0x28)
[    4.791629] [<c0118498>] (warn_slowpath_null) from [<c0300ca4>] (pci_get=
_slot+0xb0/0xb4)
[    4.799761] [<c0300ca4>] (pci_get_slot) from [<c02f945c>] (pci_scan_sing=
le_device+0x14/0xb0)
[    4.808243] [<c02f945c>] (pci_scan_single_device) from [<c02f9550>] (pci=
_scan_slot+0x58/0x100)
[    4.816899] [<c02f9550>] (pci_scan_slot) from [<c02fa468>] (pci_scan_chi=
ld_bus+0x20/0xf8)
[    4.825118] [<c02fa468>] (pci_scan_child_bus) from [<c02fa738>] (pci_sca=
n_root_bus_msi+0xcc/0xd8)
[    4.834036] [<c02fa738>] (pci_scan_root_bus_msi) from [<c02fa75c>] (pci_=
scan_root_bus+0x18/0x20)
[    4.842867] [<c02fa75c>] (pci_scan_root_bus) from [<c0310a48>] (pci_host=
_common_probe+0xc8/0x314)
[    4.851787] [<c0310a48>] (pci_host_common_probe) from [<c03508d8>] (plat=
form_drv_probe+0x34/0x6c)
[    4.860705] [<c03508d8>] (platform_drv_probe) from [<c034f388>] (really_=
probe+0x1c4/0x250)
[    4.869011] [<c034f388>] (really_probe) from [<c034f4d8>] (__driver_atta=
ch+0xc4/0xc8)
[    4.876881] [<c034f4d8>] (__driver_attach) from [<c034d8d0>] (bus_for_ea=
ch_dev+0x68/0x9c)
[    4.885100] [<c034d8d0>] (bus_for_each_dev) from [<c034e960>] (bus_add_d=
river+0x108/0x214)
[    4.893406] [<c034e960>] (bus_add_driver) from [<c034fa3c>] (driver_regi=
ster+0x78/0xf4)
[    4.901450] [<c034fa3c>] (driver_register) from [<c010175c>] (do_one_ini=
tcall+0x44/0x170)
[    4.909668] [<c010175c>] (do_one_initcall) from [<c0600dbc>] (kernel_ini=
t_freeable+0x154/0x1e0)
[    4.918412] [<c0600dbc>] (kernel_init_freeable) from [<c04ba49c>] (kerne=
l_init+0x8/0x10c)
[    4.926632] [<c04ba49c>] (kernel_init) from [<c0107678>] (ret_from_fork+=
0x14/0x3c)
[    4.934243] ---[ end trace 4ee1a301cee5ee78 ]---
[    4.938883] ------------[ cut here ]------------
[    4.943526] WARNING: CPU: 0 PID: 1 at drivers/pci/search.c:193 pci_get_s=
lot+0xb0/0xb4
[    4.951396] Modules linked in:
[    4.954467] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W       4.9.=
23-1-rc4 #16
[    4.962245] Hardware name: Sigma Tango DT
[    4.966273] [<c010ec94>] (unwind_backtrace) from [<c010ace4>] (show_stac=
k+0x10/0x14)
[    4.974056] [<c010ace4>] (show_stack) from [<c02cc13c>] (dump_stack+0x84=
/0x98)
[    4.981314] [<c02cc13c>] (dump_stack) from [<c01183d0>] (__warn+0xe8/0x1=
00)
[    4.988310] [<c01183d0>] (__warn) from [<c0118498>] (warn_slowpath_null+=
0x20/0x28)
[    4.995918] [<c0118498>] (warn_slowpath_null) from [<c0300ca4>] (pci_get=
_slot+0xb0/0xb4)
[    5.004051] [<c0300ca4>] (pci_get_slot) from [<c02f945c>] (pci_scan_sing=
le_device+0x14/0xb0)
[    5.012533] [<c02f945c>] (pci_scan_single_device) from [<c02f9550>] (pci=
_scan_slot+0x58/0x100)
[    5.021189] [<c02f9550>] (pci_scan_slot) from [<c02fa468>] (pci_scan_chi=
ld_bus+0x20/0xf8)
[    5.029408] [<c02fa468>] (pci_scan_child_bus) from [<c02fa738>] (pci_sca=
n_root_bus_msi+0xcc/0xd8)
[    5.038326] [<c02fa738>] (pci_scan_root_bus_msi) from [<c02fa75c>] (pci_=
scan_root_bus+0x18/0x20)
[    5.047157] [<c02fa75c>] (pci_scan_root_bus) from [<c0310a48>] (pci_host=
_common_probe+0xc8/0x314)
[    5.056076] [<c0310a48>] (pci_host_common_probe) from [<c03508d8>] (plat=
form_drv_probe+0x34/0x6c)
[    5.064994] [<c03508d8>] (platform_drv_probe) from [<c034f388>] (really_=
probe+0x1c4/0x250)
[    5.073300] [<c034f388>] (really_probe) from [<c034f4d8>] (__driver_atta=
ch+0xc4/0xc8)
[    5.081170] [<c034f4d8>] (__driver_attach) from [<c034d8d0>] (bus_for_ea=
ch_dev+0x68/0x9c)
[    5.089388] [<c034d8d0>] (bus_for_each_dev) from [<c034e960>] (bus_add_d=
river+0x108/0x214)
[    5.097694] [<c034e960>] (bus_add_driver) from [<c034fa3c>] (driver_regi=
ster+0x78/0xf4)
[    5.105738] [<c034fa3c>] (driver_register) from [<c010175c>] (do_one_ini=
tcall+0x44/0x170)
[    5.113957] [<c010175c>] (do_one_initcall) from [<c0600dbc>] (kernel_ini=
t_freeable+0x154/0x1e0)
[    5.122700] [<c0600dbc>] (kernel_init_freeable) from [<c04ba49c>] (kerne=
l_init+0x8/0x10c)
[    5.130919] [<c04ba49c>] (kernel_init) from [<c0107678>] (ret_from_fork+=
0x14/0x3c)
[    5.138531] ---[ end trace 4ee1a301cee5ee79 ]---
[    5.143171] ------------[ cut here ]------------
[    5.147814] WARNING: CPU: 0 PID: 1 at drivers/pci/search.c:193 pci_get_s=
lot+0xb0/0xb4
[    5.155684] Modules linked in:
[    5.158749] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W       4.9.=
23-1-rc4 #16
[    5.166527] Hardware name: Sigma Tango DT
[    5.170555] [<c010ec94>] (unwind_backtrace) from [<c010ace4>] (show_stac=
k+0x10/0x14)
[    5.178338] [<c010ace4>] (show_stack) from [<c02cc13c>] (dump_stack+0x84=
/0x98)
[    5.185596] [<c02cc13c>] (dump_stack) from [<c01183d0>] (__warn+0xe8/0x1=
00)
[    5.192592] [<c01183d0>] (__warn) from [<c0118498>] (warn_slowpath_null+=
0x20/0x28)
[    5.200200] [<c0118498>] (warn_slowpath_null) from [<c0300ca4>] (pci_get=
_slot+0xb0/0xb4)
[    5.208333] [<c0300ca4>] (pci_get_slot) from [<c02f945c>] (pci_scan_sing=
le_device+0x14/0xb0)
[    5.216815] [<c02f945c>] (pci_scan_single_device) from [<c02f9550>] (pci=
_scan_slot+0x58/0x100)
[    5.225471] [<c02f9550>] (pci_scan_slot) from [<c02fa468>] (pci_scan_chi=
ld_bus+0x20/0xf8)
[    5.233690] [<c02fa468>] (pci_scan_child_bus) from [<c02fa738>] (pci_sca=
n_root_bus_msi+0xcc/0xd8)
[    5.242609] [<c02fa738>] (pci_scan_root_bus_msi) from [<c02fa75c>] (pci_=
scan_root_bus+0x18/0x20)
[    5.251440] [<c02fa75c>] (pci_scan_root_bus) from [<c0310a48>] (pci_host=
_common_probe+0xc8/0x314)
[    5.260358] [<c0310a48>] (pci_host_common_probe) from [<c03508d8>] (plat=
form_drv_probe+0x34/0x6c)
[    5.269276] [<c03508d8>] (platform_drv_probe) from [<c034f388>] (really_=
probe+0x1c4/0x250)
[    5.277582] [<c034f388>] (really_probe) from [<c034f4d8>] (__driver_atta=
ch+0xc4/0xc8)
[    5.285452] [<c034f4d8>] (__driver_attach) from [<c034d8d0>] (bus_for_ea=
ch_dev+0x68/0x9c)
[    5.293670] [<c034d8d0>] (bus_for_each_dev) from [<c034e960>] (bus_add_d=
river+0x108/0x214)
[    5.301976] [<c034e960>] (bus_add_driver) from [<c034fa3c>] (driver_regi=
ster+0x78/0xf4)
[    5.310020] [<c034fa3c>] (driver_register) from [<c010175c>] (do_one_ini=
tcall+0x44/0x170)
[    5.318238] [<c010175c>] (do_one_initcall) from [<c0600dbc>] (kernel_ini=
t_freeable+0x154/0x1e0)
[    5.326982] [<c0600dbc>] (kernel_init_freeable) from [<c04ba49c>] (kerne=
l_init+0x8/0x10c)
[    5.335201] [<c04ba49c>] (kernel_init) from [<c0107678>] (ret_from_fork+=
0x14/0x3c)
[    5.342813] ---[ end trace 4ee1a301cee5ee7a ]---
[    5.347452] ------------[ cut here ]------------
[    5.352095] WARNING: CPU: 0 PID: 1 at drivers/pci/search.c:193 pci_get_s=
lot+0xb0/0xb4
[    5.359965] Modules linked in:
[    5.363035] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W       4.9.=
23-1-rc4 #16
[    5.370813] Hardware name: Sigma Tango DT
[    5.374841] [<c010ec94>] (unwind_backtrace) from [<c010ace4>] (show_stac=
k+0x10/0x14)
[    5.382623] [<c010ace4>] (show_stack) from [<c02cc13c>] (dump_stack+0x84=
/0x98)
[    5.389881] [<c02cc13c>] (dump_stack) from [<c01183d0>] (__warn+0xe8/0x1=
00)
[    5.396878] [<c01183d0>] (__warn) from [<c0118498>] (warn_slowpath_null+=
0x20/0x28)
[    5.404485] [<c0118498>] (warn_slowpath_null) from [<c0300ca4>] (pci_get=
_slot+0xb0/0xb4)
[    5.412618] [<c0300ca4>] (pci_get_slot) from [<c02f945c>] (pci_scan_sing=
le_device+0x14/0xb0)
[    5.421099] [<c02f945c>] (pci_scan_single_device) from [<c02f9550>] (pci=
_scan_slot+0x58/0x100)
[    5.429755] [<c02f9550>] (pci_scan_slot) from [<c02fa468>] (pci_scan_chi=
ld_bus+0x20/0xf8)
[    5.437975] [<c02fa468>] (pci_scan_child_bus) from [<c02fa738>] (pci_sca=
n_root_bus_msi+0xcc/0xd8)
[    5.446893] [<c02fa738>] (pci_scan_root_bus_msi) from [<c02fa75c>] (pci_=
scan_root_bus+0x18/0x20)
[    5.455724] [<c02fa75c>] (pci_scan_root_bus) from [<c0310a48>] (pci_host=
_common_probe+0xc8/0x314)
[    5.464643] [<c0310a48>] (pci_host_common_probe) from [<c03508d8>] (plat=
form_drv_probe+0x34/0x6c)
[    5.473561] [<c03508d8>] (platform_drv_probe) from [<c034f388>] (really_=
probe+0x1c4/0x250)
[    5.481867] [<c034f388>] (really_probe) from [<c034f4d8>] (__driver_atta=
ch+0xc4/0xc8)
[    5.489737] [<c034f4d8>] (__driver_attach) from [<c034d8d0>] (bus_for_ea=
ch_dev+0x68/0x9c)
[    5.497955] [<c034d8d0>] (bus_for_each_dev) from [<c034e960>] (bus_add_d=
river+0x108/0x214)
[    5.506261] [<c034e960>] (bus_add_driver) from [<c034fa3c>] (driver_regi=
ster+0x78/0xf4)
[    5.514305] [<c034fa3c>] (driver_register) from [<c010175c>] (do_one_ini=
tcall+0x44/0x170)
[    5.522524] [<c010175c>] (do_one_initcall) from [<c0600dbc>] (kernel_ini=
t_freeable+0x154/0x1e0)
[    5.531267] [<c0600dbc>] (kernel_init_freeable) from [<c04ba49c>] (kerne=
l_init+0x8/0x10c)
[    5.539487] [<c04ba49c>] (kernel_init) from [<c0107678>] (ret_from_fork+=
0x14/0x3c)
[    5.547098] ---[ end trace 4ee1a301cee5ee7b ]---
[    5.551738] ------------[ cut here ]------------
[    5.556381] WARNING: CPU: 0 PID: 1 at drivers/pci/search.c:193 pci_get_s=
lot+0xb0/0xb4
[    5.564252] Modules linked in:
[    5.567321] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W       4.9.=
23-1-rc4 #16
[    5.575099] Hardware name: Sigma Tango DT
[    5.579127] [<c010ec94>] (unwind_backtrace) from [<c010ace4>] (show_stac=
k+0x10/0x14)
[    5.586909] [<c010ace4>] (show_stack) from [<c02cc13c>] (dump_stack+0x84=
/0x98)
[    5.594167] [<c02cc13c>] (dump_stack) from [<c01183d0>] (__warn+0xe8/0x1=
00)
[    5.601163] [<c01183d0>] (__warn) from [<c0118498>] (warn_slowpath_null+=
0x20/0x28)
[    5.608771] [<c0118498>] (warn_slowpath_null) from [<c0300ca4>] (pci_get=
_slot+0xb0/0xb4)
[    5.616904] [<c0300ca4>] (pci_get_slot) from [<c02f945c>] (pci_scan_sing=
le_device+0x14/0xb0)
[    5.625385] [<c02f945c>] (pci_scan_single_device) from [<c02f9550>] (pci=
_scan_slot+0x58/0x100)
[    5.634041] [<c02f9550>] (pci_scan_slot) from [<c02fa468>] (pci_scan_chi=
ld_bus+0x20/0xf8)
[    5.642261] [<c02fa468>] (pci_scan_child_bus) from [<c02fa738>] (pci_sca=
n_root_bus_msi+0xcc/0xd8)
[    5.651179] [<c02fa738>] (pci_scan_root_bus_msi) from [<c02fa75c>] (pci_=
scan_root_bus+0x18/0x20)
[    5.660010] [<c02fa75c>] (pci_scan_root_bus) from [<c0310a48>] (pci_host=
_common_probe+0xc8/0x314)
[    5.668929] [<c0310a48>] (pci_host_common_probe) from [<c03508d8>] (plat=
form_drv_probe+0x34/0x6c)
[    5.677847] [<c03508d8>] (platform_drv_probe) from [<c034f388>] (really_=
probe+0x1c4/0x250)
[    5.686153] [<c034f388>] (really_probe) from [<c034f4d8>] (__driver_atta=
ch+0xc4/0xc8)
[    5.694022] [<c034f4d8>] (__driver_attach) from [<c034d8d0>] (bus_for_ea=
ch_dev+0x68/0x9c)
[    5.702241] [<c034d8d0>] (bus_for_each_dev) from [<c034e960>] (bus_add_d=
river+0x108/0x214)
[    5.710547] [<c034e960>] (bus_add_driver) from [<c034fa3c>] (driver_regi=
ster+0x78/0xf4)
[    5.718591] [<c034fa3c>] (driver_register) from [<c010175c>] (do_one_ini=
tcall+0x44/0x170)
[    5.726809] [<c010175c>] (do_one_initcall) from [<c0600dbc>] (kernel_ini=
t_freeable+0x154/0x1e0)
[    5.735552] [<c0600dbc>] (kernel_init_freeable) from [<c04ba49c>] (kerne=
l_init+0x8/0x10c)
[    5.743771] [<c04ba49c>] (kernel_init) from [<c0107678>] (ret_from_fork+=
0x14/0x3c)
[    5.751383] ---[ end trace 4ee1a301cee5ee7c ]---
[    5.756022] ------------[ cut here ]------------
[    5.760665] WARNING: CPU: 0 PID: 1 at drivers/pci/search.c:193 pci_get_s=
lot+0xb0/0xb4
[    5.768536] Modules linked in:
[    5.771606] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W       4.9.=
23-1-rc4 #16
[    5.779384] Hardware name: Sigma Tango DT
[    5.783412] [<c010ec94>] (unwind_backtrace) from [<c010ace4>] (show_stac=
k+0x10/0x14)
[    5.791194] [<c010ace4>] (show_stack) from [<c02cc13c>] (dump_stack+0x84=
/0x98)
[    5.798452] [<c02cc13c>] (dump_stack) from [<c01183d0>] (__warn+0xe8/0x1=
00)
[    5.805448] [<c01183d0>] (__warn) from [<c0118498>] (warn_slowpath_null+=
0x20/0x28)
[    5.813056] [<c0118498>] (warn_slowpath_null) from [<c0300ca4>] (pci_get=
_slot+0xb0/0xb4)
[    5.821189] [<c0300ca4>] (pci_get_slot) from [<c02f945c>] (pci_scan_sing=
le_device+0x14/0xb0)
[    5.829671] [<c02f945c>] (pci_scan_single_device) from [<c02f9550>] (pci=
_scan_slot+0x58/0x100)
[    5.838327] [<c02f9550>] (pci_scan_slot) from [<c02fa468>] (pci_scan_chi=
ld_bus+0x20/0xf8)
[    5.846546] [<c02fa468>] (pci_scan_child_bus) from [<c02fa738>] (pci_sca=
n_root_bus_msi+0xcc/0xd8)
[    5.855465] [<c02fa738>] (pci_scan_root_bus_msi) from [<c02fa75c>] (pci_=
scan_root_bus+0x18/0x20)
[    5.864296] [<c02fa75c>] (pci_scan_root_bus) from [<c0310a48>] (pci_host=
_common_probe+0xc8/0x314)
[    5.873215] [<c0310a48>] (pci_host_common_probe) from [<c03508d8>] (plat=
form_drv_probe+0x34/0x6c)
[    5.882133] [<c03508d8>] (platform_drv_probe) from [<c034f388>] (really_=
probe+0x1c4/0x250)
[    5.890439] [<c034f388>] (really_probe) from [<c034f4d8>] (__driver_atta=
ch+0xc4/0xc8)
[    5.898308] [<c034f4d8>] (__driver_attach) from [<c034d8d0>] (bus_for_ea=
ch_dev+0x68/0x9c)
[    5.906527] [<c034d8d0>] (bus_for_each_dev) from [<c034e960>] (bus_add_d=
river+0x108/0x214)
[    5.914833] [<c034e960>] (bus_add_driver) from [<c034fa3c>] (driver_regi=
ster+0x78/0xf4)
[    5.922877] [<c034fa3c>] (driver_register) from [<c010175c>] (do_one_ini=
tcall+0x44/0x170)
[    5.931096] [<c010175c>] (do_one_initcall) from [<c0600dbc>] (kernel_ini=
t_freeable+0x154/0x1e0)
[    5.939840] [<c0600dbc>] (kernel_init_freeable) from [<c04ba49c>] (kerne=
l_init+0x8/0x10c)
[    5.948060] [<c04ba49c>] (kernel_init) from [<c0107678>] (ret_from_fork+=
0x14/0x3c)
[    5.955670] ---[ end trace 4ee1a301cee5ee7d ]---
[    5.960309] ------------[ cut here ]------------
[    5.964953] WARNING: CPU: 0 PID: 1 at drivers/pci/search.c:193 pci_get_s=
lot+0xb0/0xb4
[    5.972823] Modules linked in:
[    5.975893] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W       4.9.=
23-1-rc4 #16
[    5.983671] Hardware name: Sigma Tango DT
[    5.987699] [<c010ec94>] (unwind_backtrace) from [<c010ace4>] (show_stac=
k+0x10/0x14)
[    5.995481] [<c010ace4>] (show_stack) from [<c02cc13c>] (dump_stack+0x84=
/0x98)
[    6.002739] [<c02cc13c>] (dump_stack) from [<c01183d0>] (__warn+0xe8/0x1=
00)
[    6.009736] [<c01183d0>] (__warn) from [<c0118498>] (warn_slowpath_null+=
0x20/0x28)
[    6.017343] [<c0118498>] (warn_slowpath_null) from [<c0300ca4>] (pci_get=
_slot+0xb0/0xb4)
[    6.025476] [<c0300ca4>] (pci_get_slot) from [<c02f945c>] (pci_scan_sing=
le_device+0x14/0xb0)
[    6.033958] [<c02f945c>] (pci_scan_single_device) from [<c02f9550>] (pci=
_scan_slot+0x58/0x100)
[    6.042614] [<c02f9550>] (pci_scan_slot) from [<c02fa468>] (pci_scan_chi=
ld_bus+0x20/0xf8)
[    6.050833] [<c02fa468>] (pci_scan_child_bus) from [<c02fa738>] (pci_sca=
n_root_bus_msi+0xcc/0xd8)
[    6.059751] [<c02fa738>] (pci_scan_root_bus_msi) from [<c02fa75c>] (pci_=
scan_root_bus+0x18/0x20)
[    6.068582] [<c02fa75c>] (pci_scan_root_bus) from [<c0310a48>] (pci_host=
_common_probe+0xc8/0x314)
[    6.077500] [<c0310a48>] (pci_host_common_probe) from [<c03508d8>] (plat=
form_drv_probe+0x34/0x6c)
[    6.086418] [<c03508d8>] (platform_drv_probe) from [<c034f388>] (really_=
probe+0x1c4/0x250)
[    6.094724] [<c034f388>] (really_probe) from [<c034f4d8>] (__driver_atta=
ch+0xc4/0xc8)
[    6.102594] [<c034f4d8>] (__driver_attach) from [<c034d8d0>] (bus_for_ea=
ch_dev+0x68/0x9c)
[    6.110813] [<c034d8d0>] (bus_for_each_dev) from [<c034e960>] (bus_add_d=
river+0x108/0x214)
[    6.119119] [<c034e960>] (bus_add_driver) from [<c034fa3c>] (driver_regi=
ster+0x78/0xf4)
[    6.127163] [<c034fa3c>] (driver_register) from [<c010175c>] (do_one_ini=
tcall+0x44/0x170)
[    6.135381] [<c010175c>] (do_one_initcall) from [<c0600dbc>] (kernel_ini=
t_freeable+0x154/0x1e0)
[    6.144125] [<c0600dbc>] (kernel_init_freeable) from [<c04ba49c>] (kerne=
l_init+0x8/0x10c)
[    6.152344] [<c04ba49c>] (kernel_init) from [<c0107678>] (ret_from_fork+=
0x14/0x3c)
[    6.159956] ---[ end trace 4ee1a301cee5ee7e ]---
[    6.164595] ------------[ cut here ]------------
[    6.169239] WARNING: CPU: 0 PID: 1 at drivers/pci/search.c:193 pci_get_s=
lot+0xb0/0xb4
[    6.177109] Modules linked in:
[    6.180179] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W       4.9.=
23-1-rc4 #16
[    6.187957] Hardware name: Sigma Tango DT
[    6.191985] [<c010ec94>] (unwind_backtrace) from [<c010ace4>] (show_stac=
k+0x10/0x14)
[    6.199767] [<c010ace4>] (show_stack) from [<c02cc13c>] (dump_stack+0x84=
/0x98)
[    6.207025] [<c02cc13c>] (dump_stack) from [<c01183d0>] (__warn+0xe8/0x1=
00)
[    6.214021] [<c01183d0>] (__warn) from [<c0118498>] (warn_slowpath_null+=
0x20/0x28)
[    6.221629] [<c0118498>] (warn_slowpath_null) from [<c0300ca4>] (pci_get=
_slot+0xb0/0xb4)
[    6.229762] [<c0300ca4>] (pci_get_slot) from [<c02f945c>] (pci_scan_sing=
le_device+0x14/0xb0)
[    6.238243] [<c02f945c>] (pci_scan_single_device) from [<c02f9550>] (pci=
_scan_slot+0x58/0x100)
[    6.246899] [<c02f9550>] (pci_scan_slot) from [<c02fa468>] (pci_scan_chi=
ld_bus+0x20/0xf8)
[    6.255118] [<c02fa468>] (pci_scan_child_bus) from [<c02fa738>] (pci_sca=
n_root_bus_msi+0xcc/0xd8)
[    6.264036] [<c02fa738>] (pci_scan_root_bus_msi) from [<c02fa75c>] (pci_=
scan_root_bus+0x18/0x20)
[    6.272867] [<c02fa75c>] (pci_scan_root_bus) from [<c0310a48>] (pci_host=
_common_probe+0xc8/0x314)
[    6.281786] [<c0310a48>] (pci_host_common_probe) from [<c03508d8>] (plat=
form_drv_probe+0x34/0x6c)
[    6.290704] [<c03508d8>] (platform_drv_probe) from [<c034f388>] (really_=
probe+0x1c4/0x250)
[    6.299010] [<c034f388>] (really_probe) from [<c034f4d8>] (__driver_atta=
ch+0xc4/0xc8)
[    6.306879] [<c034f4d8>] (__driver_attach) from [<c034d8d0>] (bus_for_ea=
ch_dev+0x68/0x9c)
[    6.315097] [<c034d8d0>] (bus_for_each_dev) from [<c034e960>] (bus_add_d=
river+0x108/0x214)
[    6.323403] [<c034e960>] (bus_add_driver) from [<c034fa3c>] (driver_regi=
ster+0x78/0xf4)
[    6.331447] [<c034fa3c>] (driver_register) from [<c010175c>] (do_one_ini=
tcall+0x44/0x170)
[    6.339666] [<c010175c>] (do_one_initcall) from [<c0600dbc>] (kernel_ini=
t_freeable+0x154/0x1e0)
[    6.348410] [<c0600dbc>] (kernel_init_freeable) from [<c04ba49c>] (kerne=
l_init+0x8/0x10c)
[    6.356628] [<c04ba49c>] (kernel_init) from [<c0107678>] (ret_from_fork+=
0x14/0x3c)
[    6.364239] ---[ end trace 4ee1a301cee5ee7f ]---
[    6.368879] ------------[ cut here ]------------
[    6.373522] WARNING: CPU: 0 PID: 1 at drivers/pci/search.c:193 pci_get_s=
lot+0xb0/0xb4
[    6.381393] Modules linked in:
[    6.384462] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W       4.9.=
23-1-rc4 #16
[    6.392241] Hardware name: Sigma Tango DT
[    6.396269] [<c010ec94>] (unwind_backtrace) from [<c010ace4>] (show_stac=
k+0x10/0x14)
[    6.404051] [<c010ace4>] (show_stack) from [<c02cc13c>] (dump_stack+0x84=
/0x98)
[    6.411309] [<c02cc13c>] (dump_stack) from [<c01183d0>] (__warn+0xe8/0x1=
00)
[    6.418305] [<c01183d0>] (__warn) from [<c0118498>] (warn_slowpath_null+=
0x20/0x28)
[    6.425912] [<c0118498>] (warn_slowpath_null) from [<c0300ca4>] (pci_get=
_slot+0xb0/0xb4)
[    6.434045] [<c0300ca4>] (pci_get_slot) from [<c02f945c>] (pci_scan_sing=
le_device+0x14/0xb0)
[    6.442527] [<c02f945c>] (pci_scan_single_device) from [<c02f9550>] (pci=
_scan_slot+0x58/0x100)
[    6.451183] [<c02f9550>] (pci_scan_slot) from [<c02fa468>] (pci_scan_chi=
ld_bus+0x20/0xf8)
[    6.459402] [<c02fa468>] (pci_scan_child_bus) from [<c02fa738>] (pci_sca=
n_root_bus_msi+0xcc/0xd8)
[    6.468320] [<c02fa738>] (pci_scan_root_bus_msi) from [<c02fa75c>] (pci_=
scan_root_bus+0x18/0x20)
[    6.477151] [<c02fa75c>] (pci_scan_root_bus) from [<c0310a48>] (pci_host=
_common_probe+0xc8/0x314)
[    6.486071] [<c0310a48>] (pci_host_common_probe) from [<c03508d8>] (plat=
form_drv_probe+0x34/0x6c)
[    6.494989] [<c03508d8>] (platform_drv_probe) from [<c034f388>] (really_=
probe+0x1c4/0x250)
[    6.503295] [<c034f388>] (really_probe) from [<c034f4d8>] (__driver_atta=
ch+0xc4/0xc8)
[    6.511165] [<c034f4d8>] (__driver_attach) from [<c034d8d0>] (bus_for_ea=
ch_dev+0x68/0x9c)
[    6.519383] [<c034d8d0>] (bus_for_each_dev) from [<c034e960>] (bus_add_d=
river+0x108/0x214)
[    6.527689] [<c034e960>] (bus_add_driver) from [<c034fa3c>] (driver_regi=
ster+0x78/0xf4)
[    6.535733] [<c034fa3c>] (driver_register) from [<c010175c>] (do_one_ini=
tcall+0x44/0x170)
[    6.543952] [<c010175c>] (do_one_initcall) from [<c0600dbc>] (kernel_ini=
t_freeable+0x154/0x1e0)
[    6.552696] [<c0600dbc>] (kernel_init_freeable) from [<c04ba49c>] (kerne=
l_init+0x8/0x10c)
[    6.560915] [<c04ba49c>] (kernel_init) from [<c0107678>] (ret_from_fork+=
0x14/0x3c)
[    6.568526] ---[ end trace 4ee1a301cee5ee80 ]---
[    6.573166] ------------[ cut here ]------------
[    6.577809] WARNING: CPU: 0 PID: 1 at drivers/pci/search.c:193 pci_get_s=
lot+0xb0/0xb4
[    6.585680] Modules linked in:
[    6.588745] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W       4.9.=
23-1-rc4 #16
[    6.596523] Hardware name: Sigma Tango DT
[    6.600551] [<c010ec94>] (unwind_backtrace) from [<c010ace4>] (show_stac=
k+0x10/0x14)
[    6.608334] [<c010ace4>] (show_stack) from [<c02cc13c>] (dump_stack+0x84=
/0x98)
[    6.615592] [<c02cc13c>] (dump_stack) from [<c01183d0>] (__warn+0xe8/0x1=
00)
[    6.622588] [<c01183d0>] (__warn) from [<c0118498>] (warn_slowpath_null+=
0x20/0x28)
[    6.630196] [<c0118498>] (warn_slowpath_null) from [<c0300ca4>] (pci_get=
_slot+0xb0/0xb4)
[    6.638329] [<c0300ca4>] (pci_get_slot) from [<c02f945c>] (pci_scan_sing=
le_device+0x14/0xb0)
[    6.646811] [<c02f945c>] (pci_scan_single_device) from [<c02f9550>] (pci=
_scan_slot+0x58/0x100)
[    6.655467] [<c02f9550>] (pci_scan_slot) from [<c02fa468>] (pci_scan_chi=
ld_bus+0x20/0xf8)
[    6.663687] [<c02fa468>] (pci_scan_child_bus) from [<c02fa738>] (pci_sca=
n_root_bus_msi+0xcc/0xd8)
[    6.672605] [<c02fa738>] (pci_scan_root_bus_msi) from [<c02fa75c>] (pci_=
scan_root_bus+0x18/0x20)
[    6.681436] [<c02fa75c>] (pci_scan_root_bus) from [<c0310a48>] (pci_host=
_common_probe+0xc8/0x314)
[    6.690354] [<c0310a48>] (pci_host_common_probe) from [<c03508d8>] (plat=
form_drv_probe+0x34/0x6c)
[    6.699272] [<c03508d8>] (platform_drv_probe) from [<c034f388>] (really_=
probe+0x1c4/0x250)
[    6.707579] [<c034f388>] (really_probe) from [<c034f4d8>] (__driver_atta=
ch+0xc4/0xc8)
[    6.715448] [<c034f4d8>] (__driver_attach) from [<c034d8d0>] (bus_for_ea=
ch_dev+0x68/0x9c)
[    6.723667] [<c034d8d0>] (bus_for_each_dev) from [<c034e960>] (bus_add_d=
river+0x108/0x214)
[    6.731973] [<c034e960>] (bus_add_driver) from [<c034fa3c>] (driver_regi=
ster+0x78/0xf4)
[    6.740017] [<c034fa3c>] (driver_register) from [<c010175c>] (do_one_ini=
tcall+0x44/0x170)
[    6.748236] [<c010175c>] (do_one_initcall) from [<c0600dbc>] (kernel_ini=
t_freeable+0x154/0x1e0)
[    6.756979] [<c0600dbc>] (kernel_init_freeable) from [<c04ba49c>] (kerne=
l_init+0x8/0x10c)
[    6.765198] [<c04ba49c>] (kernel_init) from [<c0107678>] (ret_from_fork+=
0x14/0x3c)
[    6.772810] ---[ end trace 4ee1a301cee5ee81 ]---
[    6.777449] ------------[ cut here ]------------
[    6.782093] WARNING: CPU: 0 PID: 1 at drivers/pci/search.c:193 pci_get_s=
lot+0xb0/0xb4
[    6.789963] Modules linked in:
[    6.793033] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W       4.9.=
23-1-rc4 #16
[    6.800811] Hardware name: Sigma Tango DT
[    6.804839] [<c010ec94>] (unwind_backtrace) from [<c010ace4>] (show_stac=
k+0x10/0x14)
[    6.812622] [<c010ace4>] (show_stack) from [<c02cc13c>] (dump_stack+0x84=
/0x98)
[    6.819880] [<c02cc13c>] (dump_stack) from [<c01183d0>] (__warn+0xe8/0x1=
00)
[    6.826876] [<c01183d0>] (__warn) from [<c0118498>] (warn_slowpath_null+=
0x20/0x28)
[    6.834484] [<c0118498>] (warn_slowpath_null) from [<c0300ca4>] (pci_get=
_slot+0xb0/0xb4)
[    6.842617] [<c0300ca4>] (pci_get_slot) from [<c02f945c>] (pci_scan_sing=
le_device+0x14/0xb0)
[    6.851099] [<c02f945c>] (pci_scan_single_device) from [<c02f9550>] (pci=
_scan_slot+0x58/0x100)
[    6.859755] [<c02f9550>] (pci_scan_slot) from [<c02fa468>] (pci_scan_chi=
ld_bus+0x20/0xf8)
[    6.867974] [<c02fa468>] (pci_scan_child_bus) from [<c02fa738>] (pci_sca=
n_root_bus_msi+0xcc/0xd8)
[    6.876892] [<c02fa738>] (pci_scan_root_bus_msi) from [<c02fa75c>] (pci_=
scan_root_bus+0x18/0x20)
[    6.885723] [<c02fa75c>] (pci_scan_root_bus) from [<c0310a48>] (pci_host=
_common_probe+0xc8/0x314)
[    6.894642] [<c0310a48>] (pci_host_common_probe) from [<c03508d8>] (plat=
form_drv_probe+0x34/0x6c)
[    6.903560] [<c03508d8>] (platform_drv_probe) from [<c034f388>] (really_=
probe+0x1c4/0x250)
[    6.911866] [<c034f388>] (really_probe) from [<c034f4d8>] (__driver_atta=
ch+0xc4/0xc8)
[    6.919736] [<c034f4d8>] (__driver_attach) from [<c034d8d0>] (bus_for_ea=
ch_dev+0x68/0x9c)
[    6.927954] [<c034d8d0>] (bus_for_each_dev) from [<c034e960>] (bus_add_d=
river+0x108/0x214)
[    6.936260] [<c034e960>] (bus_add_driver) from [<c034fa3c>] (driver_regi=
ster+0x78/0xf4)
[    6.944304] [<c034fa3c>] (driver_register) from [<c010175c>] (do_one_ini=
tcall+0x44/0x170)
[    6.952522] [<c010175c>] (do_one_initcall) from [<c0600dbc>] (kernel_ini=
t_freeable+0x154/0x1e0)
[    6.961266] [<c0600dbc>] (kernel_init_freeable) from [<c04ba49c>] (kerne=
l_init+0x8/0x10c)
[    6.969485] [<c04ba49c>] (kernel_init) from [<c0107678>] (ret_from_fork+=
0x14/0x3c)
[    6.977096] ---[ end trace 4ee1a301cee5ee82 ]---
[    6.981735] ------------[ cut here ]------------
[    6.986378] WARNING: CPU: 0 PID: 1 at drivers/pci/search.c:193 pci_get_s=
lot+0xb0/0xb4
[    6.994249] Modules linked in:
[    6.997318] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W       4.9.=
23-1-rc4 #16
[    7.005097] Hardware name: Sigma Tango DT
[    7.009125] [<c010ec94>] (unwind_backtrace) from [<c010ace4>] (show_stac=
k+0x10/0x14)
[    7.016907] [<c010ace4>] (show_stack) from [<c02cc13c>] (dump_stack+0x84=
/0x98)
[    7.024165] [<c02cc13c>] (dump_stack) from [<c01183d0>] (__warn+0xe8/0x1=
00)
[    7.031161] [<c01183d0>] (__warn) from [<c0118498>] (warn_slowpath_null+=
0x20/0x28)
[    7.038769] [<c0118498>] (warn_slowpath_null) from [<c0300ca4>] (pci_get=
_slot+0xb0/0xb4)
[    7.046901] [<c0300ca4>] (pci_get_slot) from [<c02f945c>] (pci_scan_sing=
le_device+0x14/0xb0)
[    7.055383] [<c02f945c>] (pci_scan_single_device) from [<c02f9550>] (pci=
_scan_slot+0x58/0x100)
[    7.064039] [<c02f9550>] (pci_scan_slot) from [<c02fa468>] (pci_scan_chi=
ld_bus+0x20/0xf8)
[    7.072258] [<c02fa468>] (pci_scan_child_bus) from [<c02fa738>] (pci_sca=
n_root_bus_msi+0xcc/0xd8)
[    7.081177] [<c02fa738>] (pci_scan_root_bus_msi) from [<c02fa75c>] (pci_=
scan_root_bus+0x18/0x20)
[    7.090008] [<c02fa75c>] (pci_scan_root_bus) from [<c0310a48>] (pci_host=
_common_probe+0xc8/0x314)
[    7.098927] [<c0310a48>] (pci_host_common_probe) from [<c03508d8>] (plat=
form_drv_probe+0x34/0x6c)
[    7.107844] [<c03508d8>] (platform_drv_probe) from [<c034f388>] (really_=
probe+0x1c4/0x250)
[    7.116151] [<c034f388>] (really_probe) from [<c034f4d8>] (__driver_atta=
ch+0xc4/0xc8)
[    7.124020] [<c034f4d8>] (__driver_attach) from [<c034d8d0>] (bus_for_ea=
ch_dev+0x68/0x9c)
[    7.132238] [<c034d8d0>] (bus_for_each_dev) from [<c034e960>] (bus_add_d=
river+0x108/0x214)
[    7.140544] [<c034e960>] (bus_add_driver) from [<c034fa3c>] (driver_regi=
ster+0x78/0xf4)
[    7.148588] [<c034fa3c>] (driver_register) from [<c010175c>] (do_one_ini=
tcall+0x44/0x170)
[    7.156806] [<c010175c>] (do_one_initcall) from [<c0600dbc>] (kernel_ini=
t_freeable+0x154/0x1e0)
[    7.165550] [<c0600dbc>] (kernel_init_freeable) from [<c04ba49c>] (kerne=
l_init+0x8/0x10c)
[    7.173769] [<c04ba49c>] (kernel_init) from [<c0107678>] (ret_from_fork+=
0x14/0x3c)
[    7.181380] ---[ end trace 4ee1a301cee5ee83 ]---
[    7.186020] ------------[ cut here ]------------
[    7.190663] WARNING: CPU: 0 PID: 1 at drivers/pci/search.c:193 pci_get_s=
lot+0xb0/0xb4
[    7.198534] Modules linked in:
[    7.201603] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W       4.9.=
23-1-rc4 #16
[    7.209382] Hardware name: Sigma Tango DT
[    7.213410] [<c010ec94>] (unwind_backtrace) from [<c010ace4>] (show_stac=
k+0x10/0x14)
[    7.221192] [<c010ace4>] (show_stack) from [<c02cc13c>] (dump_stack+0x84=
/0x98)
[    7.228450] [<c02cc13c>] (dump_stack) from [<c01183d0>] (__warn+0xe8/0x1=
00)
[    7.235446] [<c01183d0>] (__warn) from [<c0118498>] (warn_slowpath_null+=
0x20/0x28)
[    7.243054] [<c0118498>] (warn_slowpath_null) from [<c0300ca4>] (pci_get=
_slot+0xb0/0xb4)
[    7.251187] [<c0300ca4>] (pci_get_slot) from [<c02f945c>] (pci_scan_sing=
le_device+0x14/0xb0)
[    7.259668] [<c02f945c>] (pci_scan_single_device) from [<c02f9550>] (pci=
_scan_slot+0x58/0x100)
[    7.268324] [<c02f9550>] (pci_scan_slot) from [<c02fa468>] (pci_scan_chi=
ld_bus+0x20/0xf8)
[    7.276544] [<c02fa468>] (pci_scan_child_bus) from [<c02fa738>] (pci_sca=
n_root_bus_msi+0xcc/0xd8)
[    7.285462] [<c02fa738>] (pci_scan_root_bus_msi) from [<c02fa75c>] (pci_=
scan_root_bus+0x18/0x20)
[    7.294293] [<c02fa75c>] (pci_scan_root_bus) from [<c0310a48>] (pci_host=
_common_probe+0xc8/0x314)
[    7.303211] [<c0310a48>] (pci_host_common_probe) from [<c03508d8>] (plat=
form_drv_probe+0x34/0x6c)
[    7.312129] [<c03508d8>] (platform_drv_probe) from [<c034f388>] (really_=
probe+0x1c4/0x250)
[    7.320435] [<c034f388>] (really_probe) from [<c034f4d8>] (__driver_atta=
ch+0xc4/0xc8)
[    7.328305] [<c034f4d8>] (__driver_attach) from [<c034d8d0>] (bus_for_ea=
ch_dev+0x68/0x9c)
[    7.336523] [<c034d8d0>] (bus_for_each_dev) from [<c034e960>] (bus_add_d=
river+0x108/0x214)
[    7.344829] [<c034e960>] (bus_add_driver) from [<c034fa3c>] (driver_regi=
ster+0x78/0xf4)
[    7.352873] [<c034fa3c>] (driver_register) from [<c010175c>] (do_one_ini=
tcall+0x44/0x170)
[    7.361091] [<c010175c>] (do_one_initcall) from [<c0600dbc>] (kernel_ini=
t_freeable+0x154/0x1e0)
[    7.369834] [<c0600dbc>] (kernel_init_freeable) from [<c04ba49c>] (kerne=
l_init+0x8/0x10c)
[    7.378054] [<c04ba49c>] (kernel_init) from [<c0107678>] (ret_from_fork+=
0x14/0x3c)
[    7.385664] ---[ end trace 4ee1a301cee5ee84 ]---
[    7.390361] PCI: bus0: Fast back to back transfers disabled
[    7.395983] pci 0000:00:00.0: bridge configuration invalid ([bus 00-00])=
, reconfiguring
[    7.404079] ------------[ cut here ]------------
[    7.408725] WARNING: CPU: 0 PID: 1 at drivers/pci/search.c:165 pci_find_=
next_bus+0x80/0x84
[    7.417033] Modules linked in:
[    7.420104] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W       4.9.=
23-1-rc4 #16
[    7.427882] Hardware name: Sigma Tango DT
[    7.431911] [<c010ec94>] (unwind_backtrace) from [<c010ace4>] (show_stac=
k+0x10/0x14)
[    7.439693] [<c010ace4>] (show_stack) from [<c02cc13c>] (dump_stack+0x84=
/0x98)
[    7.446952] [<c02cc13c>] (dump_stack) from [<c01183d0>] (__warn+0xe8/0x1=
00)
[    7.453949] [<c01183d0>] (__warn) from [<c0118498>] (warn_slowpath_null+=
0x20/0x28)
[    7.461556] [<c0118498>] (warn_slowpath_null) from [<c0300ba8>] (pci_fin=
d_next_bus+0x80/0x84)
[    7.470125] [<c0300ba8>] (pci_find_next_bus) from [<c0300bc4>] (pci_find=
_bus+0x18/0x48)
[    7.478171] [<c0300bc4>] (pci_find_bus) from [<c02fa164>] (pci_scan_brid=
ge+0x270/0x554)
[    7.486215] [<c02fa164>] (pci_scan_bridge) from [<c02fa4c4>] (pci_scan_c=
hild_bus+0x7c/0xf8)
[    7.494609] [<c02fa4c4>] (pci_scan_child_bus) from [<c02fa738>] (pci_sca=
n_root_bus_msi+0xcc/0xd8)
[    7.503528] [<c02fa738>] (pci_scan_root_bus_msi) from [<c02fa75c>] (pci_=
scan_root_bus+0x18/0x20)
[    7.512358] [<c02fa75c>] (pci_scan_root_bus) from [<c0310a48>] (pci_host=
_common_probe+0xc8/0x314)
[    7.521277] [<c0310a48>] (pci_host_common_probe) from [<c03508d8>] (plat=
form_drv_probe+0x34/0x6c)
[    7.530196] [<c03508d8>] (platform_drv_probe) from [<c034f388>] (really_=
probe+0x1c4/0x250)
[    7.538502] [<c034f388>] (really_probe) from [<c034f4d8>] (__driver_atta=
ch+0xc4/0xc8)
[    7.546372] [<c034f4d8>] (__driver_attach) from [<c034d8d0>] (bus_for_ea=
ch_dev+0x68/0x9c)
[    7.554590] [<c034d8d0>] (bus_for_each_dev) from [<c034e960>] (bus_add_d=
river+0x108/0x214)
[    7.562896] [<c034e960>] (bus_add_driver) from [<c034fa3c>] (driver_regi=
ster+0x78/0xf4)
[    7.570940] [<c034fa3c>] (driver_register) from [<c010175c>] (do_one_ini=
tcall+0x44/0x170)
[    7.579159] [<c010175c>] (do_one_initcall) from [<c0600dbc>] (kernel_ini=
t_freeable+0x154/0x1e0)
[    7.587902] [<c0600dbc>] (kernel_init_freeable) from [<c04ba49c>] (kerne=
l_init+0x8/0x10c)
[    7.596122] [<c04ba49c>] (kernel_init) from [<c0107678>] (ret_from_fork+=
0x14/0x3c)
[    7.603734] ---[ end trace 4ee1a301cee5ee85 ]---
[    7.608374] ------------[ cut here ]------------
[    7.613018] WARNING: CPU: 0 PID: 1 at drivers/pci/search.c:165 pci_find_=
next_bus+0x80/0x84
[    7.621325] Modules linked in:
[    7.624395] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W       4.9.=
23-1-rc4 #16
[    7.632173] Hardware name: Sigma Tango DT
[    7.636202] [<c010ec94>] (unwind_backtrace) from [<c010ace4>] (show_stac=
k+0x10/0x14)
[    7.643984] [<c010ace4>] (show_stack) from [<c02cc13c>] (dump_stack+0x84=
/0x98)
[    7.651242] [<c02cc13c>] (dump_stack) from [<c01183d0>] (__warn+0xe8/0x1=
00)
[    7.658238] [<c01183d0>] (__warn) from [<c0118498>] (warn_slowpath_null+=
0x20/0x28)
[    7.665846] [<c0118498>] (warn_slowpath_null) from [<c0300ba8>] (pci_fin=
d_next_bus+0x80/0x84)
[    7.674415] [<c0300ba8>] (pci_find_next_bus) from [<c0300bc4>] (pci_find=
_bus+0x18/0x48)
[    7.682460] [<c0300bc4>] (pci_find_bus) from [<c02fa164>] (pci_scan_brid=
ge+0x270/0x554)
[    7.690505] [<c02fa164>] (pci_scan_bridge) from [<c02fa4c4>] (pci_scan_c=
hild_bus+0x7c/0xf8)
[    7.698899] [<c02fa4c4>] (pci_scan_child_bus) from [<c02fa738>] (pci_sca=
n_root_bus_msi+0xcc/0xd8)
[    7.707817] [<c02fa738>] (pci_scan_root_bus_msi) from [<c02fa75c>] (pci_=
scan_root_bus+0x18/0x20)
[    7.716648] [<c02fa75c>] (pci_scan_root_bus) from [<c0310a48>] (pci_host=
_common_probe+0xc8/0x314)
[    7.725567] [<c0310a48>] (pci_host_common_probe) from [<c03508d8>] (plat=
form_drv_probe+0x34/0x6c)
[    7.734485] [<c03508d8>] (platform_drv_probe) from [<c034f388>] (really_=
probe+0x1c4/0x250)
[    7.742791] [<c034f388>] (really_probe) from [<c034f4d8>] (__driver_atta=
ch+0xc4/0xc8)
[    7.750661] [<c034f4d8>] (__driver_attach) from [<c034d8d0>] (bus_for_ea=
ch_dev+0x68/0x9c)
[    7.758879] [<c034d8d0>] (bus_for_each_dev) from [<c034e960>] (bus_add_d=
river+0x108/0x214)
[    7.767185] [<c034e960>] (bus_add_driver) from [<c034fa3c>] (driver_regi=
ster+0x78/0xf4)
[    7.775229] [<c034fa3c>] (driver_register) from [<c010175c>] (do_one_ini=
tcall+0x44/0x170)
[    7.783448] [<c010175c>] (do_one_initcall) from [<c0600dbc>] (kernel_ini=
t_freeable+0x154/0x1e0)
[    7.792192] [<c0600dbc>] (kernel_init_freeable) from [<c04ba49c>] (kerne=
l_init+0x8/0x10c)
[    7.800411] [<c04ba49c>] (kernel_init) from [<c0107678>] (ret_from_fork+=
0x14/0x3c)
[    7.808022] ---[ end trace 4ee1a301cee5ee86 ]---
[    7.812900] ------------[ cut here ]------------
[    7.817553] WARNING: CPU: 0 PID: 1 at drivers/pci/search.c:193 pci_get_s=
lot+0xb0/0xb4
[    7.825425] Modules linked in:
[    7.828496] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W       4.9.=
23-1-rc4 #16
[    7.836275] Hardware name: Sigma Tango DT
[    7.840305] [<c010ec94>] (unwind_backtrace) from [<c010ace4>] (show_stac=
k+0x10/0x14)
[    7.848088] [<c010ace4>] (show_stack) from [<c02cc13c>] (dump_stack+0x84=
/0x98)
[    7.855348] [<c02cc13c>] (dump_stack) from [<c01183d0>] (__warn+0xe8/0x1=
00)
[    7.862345] [<c01183d0>] (__warn) from [<c0118498>] (warn_slowpath_null+=
0x20/0x28)
[    7.869953] [<c0118498>] (warn_slowpath_null) from [<c0300ca4>] (pci_get=
_slot+0xb0/0xb4)
[    7.878087] [<c0300ca4>] (pci_get_slot) from [<c02f945c>] (pci_scan_sing=
le_device+0x14/0xb0)
[    7.886569] [<c02f945c>] (pci_scan_single_device) from [<c02f9550>] (pci=
_scan_slot+0x58/0x100)
[    7.895225] [<c02f9550>] (pci_scan_slot) from [<c02fa468>] (pci_scan_chi=
ld_bus+0x20/0xf8)
[    7.903444] [<c02fa468>] (pci_scan_child_bus) from [<c02fa1b8>] (pci_sca=
n_bridge+0x2c4/0x554)
[    7.912013] [<c02fa1b8>] (pci_scan_bridge) from [<c02fa4c4>] (pci_scan_c=
hild_bus+0x7c/0xf8)
[    7.920407] [<c02fa4c4>] (pci_scan_child_bus) from [<c02fa738>] (pci_sca=
n_root_bus_msi+0xcc/0xd8)
[    7.929325] [<c02fa738>] (pci_scan_root_bus_msi) from [<c02fa75c>] (pci_=
scan_root_bus+0x18/0x20)
[    7.938156] [<c02fa75c>] (pci_scan_root_bus) from [<c0310a48>] (pci_host=
_common_probe+0xc8/0x314)
[    7.947076] [<c0310a48>] (pci_host_common_probe) from [<c03508d8>] (plat=
form_drv_probe+0x34/0x6c)
[    7.955995] [<c03508d8>] (platform_drv_probe) from [<c034f388>] (really_=
probe+0x1c4/0x250)
[    7.964301] [<c034f388>] (really_probe) from [<c034f4d8>] (__driver_atta=
ch+0xc4/0xc8)
[    7.972170] [<c034f4d8>] (__driver_attach) from [<c034d8d0>] (bus_for_ea=
ch_dev+0x68/0x9c)
[    7.980389] [<c034d8d0>] (bus_for_each_dev) from [<c034e960>] (bus_add_d=
river+0x108/0x214)
[    7.988695] [<c034e960>] (bus_add_driver) from [<c034fa3c>] (driver_regi=
ster+0x78/0xf4)
[    7.996739] [<c034fa3c>] (driver_register) from [<c010175c>] (do_one_ini=
tcall+0x44/0x170)
[    8.004958] [<c010175c>] (do_one_initcall) from [<c0600dbc>] (kernel_ini=
t_freeable+0x154/0x1e0)
[    8.013703] [<c0600dbc>] (kernel_init_freeable) from [<c04ba49c>] (kerne=
l_init+0x8/0x10c)
[    8.021923] [<c04ba49c>] (kernel_init) from [<c0107678>] (ret_from_fork+=
0x14/0x3c)
[    8.029537] ---[ end trace 4ee1a301cee5ee87 ]---
[    8.034324] pci 0000:01:00.0: [1912:0014] type 00 class 0x0c0330
[    8.040492] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00001fff 64bit=
]
[    8.047960] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
[    8.054409] BUG: scheduling while atomic: swapper/0/1/0x00000000
[    8.060547] Modules linked in:
[    8.063626] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W       4.9.=
23-1-rc4 #16
[    8.071406] Hardware name: Sigma Tango DT
[    8.075440] [<c010ec94>] (unwind_backtrace) from [<c010ace4>] (show_stac=
k+0x10/0x14)
[    8.083224] [<c010ace4>] (show_stack) from [<c02cc13c>] (dump_stack+0x84=
/0x98)
[    8.090483] [<c02cc13c>] (dump_stack) from [<c0137ee8>] (__schedule_bug+=
0x64/0x84)
[    8.098094] [<c0137ee8>] (__schedule_bug) from [<c04bb1d0>] (__schedule+=
0x364/0x454)
[    8.105877] [<c04bb1d0>] (__schedule) from [<c04bb310>] (schedule+0x50/0=
xb4)
[    8.112962] [<c04bb310>] (schedule) from [<c04be048>] (schedule_timeout+=
0x134/0x210)
[    8.120750] [<c04be048>] (schedule_timeout) from [<c0168c74>] (msleep+0x=
2c/0x38)
[    8.128191] [<c0168c74>] (msleep) from [<c030bb04>] (pcie_aspm_init_link=
_state+0x440/0x76c)
[    8.136589] [<c030bb04>] (pcie_aspm_init_link_state) from [<c02f95f0>] (=
pci_scan_slot+0xf8/0x100)
[    8.145509] [<c02f95f0>] (pci_scan_slot) from [<c02fa468>] (pci_scan_chi=
ld_bus+0x20/0xf8)
[    8.153728] [<c02fa468>] (pci_scan_child_bus) from [<c02fa1b8>] (pci_sca=
n_bridge+0x2c4/0x554)
[    8.162296] [<c02fa1b8>] (pci_scan_bridge) from [<c02fa4c4>] (pci_scan_c=
hild_bus+0x7c/0xf8)
[    8.170690] [<c02fa4c4>] (pci_scan_child_bus) from [<c02fa738>] (pci_sca=
n_root_bus_msi+0xcc/0xd8)
[    8.179608] [<c02fa738>] (pci_scan_root_bus_msi) from [<c02fa75c>] (pci_=
scan_root_bus+0x18/0x20)
[    8.188439] [<c02fa75c>] (pci_scan_root_bus) from [<c0310a48>] (pci_host=
_common_probe+0xc8/0x314)
[    8.197361] [<c0310a48>] (pci_host_common_probe) from [<c03508d8>] (plat=
form_drv_probe+0x34/0x6c)
[    8.206280] [<c03508d8>] (platform_drv_probe) from [<c034f388>] (really_=
probe+0x1c4/0x250)
[    8.214586] [<c034f388>] (really_probe) from [<c034f4d8>] (__driver_atta=
ch+0xc4/0xc8)
[    8.222456] [<c034f4d8>] (__driver_attach) from [<c034d8d0>] (bus_for_ea=
ch_dev+0x68/0x9c)
[    8.230674] [<c034d8d0>] (bus_for_each_dev) from [<c034e960>] (bus_add_d=
river+0x108/0x214)
[    8.238981] [<c034e960>] (bus_add_driver) from [<c034fa3c>] (driver_regi=
ster+0x78/0xf4)
[    8.247025] [<c034fa3c>] (driver_register) from [<c010175c>] (do_one_ini=
tcall+0x44/0x170)
[    8.255245] [<c010175c>] (do_one_initcall) from [<c0600dbc>] (kernel_ini=
t_freeable+0x154/0x1e0)
[    8.263989] [<c0600dbc>] (kernel_init_freeable) from [<c04ba49c>] (kerne=
l_init+0x8/0x10c)
[    8.272209] [<c04ba49c>] (kernel_init) from [<c0107678>] (ret_from_fork+=
0x14/0x3c)
[    8.279860] BUG: scheduling while atomic: swapper/0/1/0x00000002
[    8.285905] Modules linked in:
[    8.288979] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W       4.9.=
23-1-rc4 #16
[    8.296758] Hardware name: Sigma Tango DT
[    8.300788] [<c010ec94>] (unwind_backtrace) from [<c010ace4>] (show_stac=
k+0x10/0x14)
[    8.308570] [<c010ace4>] (show_stack) from [<c02cc13c>] (dump_stack+0x84=
/0x98)
[    8.315828] [<c02cc13c>] (dump_stack) from [<c0137ee8>] (__schedule_bug+=
0x64/0x84)
[    8.323436] [<c0137ee8>] (__schedule_bug) from [<c04bb1d0>] (__schedule+=
0x364/0x454)
[    8.331218] [<c04bb1d0>] (__schedule) from [<c04bb310>] (schedule+0x50/0=
xb4)
[    8.338302] [<c04bb310>] (schedule) from [<c04be0dc>] (schedule_timeout+=
0x1c8/0x210)
[    8.346085] [<c04be0dc>] (schedule_timeout) from [<c04bbdd8>] (wait_for_=
common+0x8c/0x13c)
[    8.354392] [<c04bbdd8>] (wait_for_common) from [<c0185084>] (__stop_cpu=
s+0x50/0x64)
[    8.362174] [<c0185084>] (__stop_cpus) from [<c0185484>] (stop_cpus+0x2c=
/0x44)
[    8.369431] [<c0185484>] (stop_cpus) from [<c0185550>] (stop_machine+0xb=
4/0xf8)
[    8.376776] [<c0185550>] (stop_machine) from [<c0310e30>] (smp8759_confi=
g_read+0x68/0x74)
[    8.384997] [<c0310e30>] (smp8759_config_read) from [<c02f5d44>] (pci_bu=
s_read_config_word+0x6c/0x94)
[    8.394265] [<c02f5d44>] (pci_bus_read_config_word) from [<c02f7220>] (p=
cie_capability_read_word+0x4c/0x88)
[    8.404059] [<c02f7220>] (pcie_capability_read_word) from [<c030bb14>] (=
pcie_aspm_init_link_state+0x450/0x76c)
[    8.414114] [<c030bb14>] (pcie_aspm_init_link_state) from [<c02f95f0>] (=
pci_scan_slot+0xf8/0x100)
[    8.423032] [<c02f95f0>] (pci_scan_slot) from [<c02fa468>] (pci_scan_chi=
ld_bus+0x20/0xf8)
[    8.431251] [<c02fa468>] (pci_scan_child_bus) from [<c02fa1b8>] (pci_sca=
n_bridge+0x2c4/0x554)
[    8.439820] [<c02fa1b8>] (pci_scan_bridge) from [<c02fa4c4>] (pci_scan_c=
hild_bus+0x7c/0xf8)
[    8.448214] [<c02fa4c4>] (pci_scan_child_bus) from [<c02fa738>] (pci_sca=
n_root_bus_msi+0xcc/0xd8)
[    8.457132] [<c02fa738>] (pci_scan_root_bus_msi) from [<c02fa75c>] (pci_=
scan_root_bus+0x18/0x20)
[    8.465963] [<c02fa75c>] (pci_scan_root_bus) from [<c0310a48>] (pci_host=
_common_probe+0xc8/0x314)
[    8.474882] [<c0310a48>] (pci_host_common_probe) from [<c03508d8>] (plat=
form_drv_probe+0x34/0x6c)
[    8.483800] [<c03508d8>] (platform_drv_probe) from [<c034f388>] (really_=
probe+0x1c4/0x250)
[    8.492106] [<c034f388>] (really_probe) from [<c034f4d8>] (__driver_atta=
ch+0xc4/0xc8)
[    8.499976] [<c034f4d8>] (__driver_attach) from [<c034d8d0>] (bus_for_ea=
ch_dev+0x68/0x9c)
[    8.508194] [<c034d8d0>] (bus_for_each_dev) from [<c034e960>] (bus_add_d=
river+0x108/0x214)
[    8.516500] [<c034e960>] (bus_add_driver) from [<c034fa3c>] (driver_regi=
ster+0x78/0xf4)
[    8.524544] [<c034fa3c>] (driver_register) from [<c010175c>] (do_one_ini=
tcall+0x44/0x170)
[    8.532762] [<c010175c>] (do_one_initcall) from [<c0600dbc>] (kernel_ini=
t_freeable+0x154/0x1e0)
[    8.541506] [<c0600dbc>] (kernel_init_freeable) from [<c04ba49c>] (kerne=
l_init+0x8/0x10c)
[    8.549725] [<c04ba49c>] (kernel_init) from [<c0107678>] (ret_from_fork+=
0x14/0x3c)
[    8.557464] PCI: bus1: Fast back to back transfers disabled
[    8.563077] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
[    8.569730] ------------[ cut here ]------------
[    8.574376] WARNING: CPU: 0 PID: 1 at drivers/pci/search.c:271 pci_get_d=
ev_by_id+0x84/0x8c
[    8.582684] Modules linked in:
[    8.585754] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W       4.9.=
23-1-rc4 #16
[    8.593532] Hardware name: Sigma Tango DT
[    8.597561] [<c010ec94>] (unwind_backtrace) from [<c010ace4>] (show_stac=
k+0x10/0x14)
[    8.605344] [<c010ace4>] (show_stack) from [<c02cc13c>] (dump_stack+0x84=
/0x98)
[    8.612605] [<c02cc13c>] (dump_stack) from [<c01183d0>] (__warn+0xe8/0x1=
00)
[    8.619603] [<c01183d0>] (__warn) from [<c0118498>] (warn_slowpath_null+=
0x20/0x28)
[    8.627211] [<c0118498>] (warn_slowpath_null) from [<c0300d2c>] (pci_get=
_dev_by_id+0x84/0x8c)
[    8.635780] [<c0300d2c>] (pci_get_dev_by_id) from [<c0300da0>] (pci_get_=
device+0x34/0x3c)
[    8.644000] [<c0300da0>] (pci_get_device) from [<c03100c0>] (pci_fixup_i=
rqs+0x60/0xac)
[    8.651957] [<c03100c0>] (pci_fixup_irqs) from [<c0310a64>] (pci_host_co=
mmon_probe+0xe4/0x314)
[    8.660614] [<c0310a64>] (pci_host_common_probe) from [<c03508d8>] (plat=
form_drv_probe+0x34/0x6c)
[    8.669532] [<c03508d8>] (platform_drv_probe) from [<c034f388>] (really_=
probe+0x1c4/0x250)
[    8.677839] [<c034f388>] (really_probe) from [<c034f4d8>] (__driver_atta=
ch+0xc4/0xc8)
[    8.685708] [<c034f4d8>] (__driver_attach) from [<c034d8d0>] (bus_for_ea=
ch_dev+0x68/0x9c)
[    8.693926] [<c034d8d0>] (bus_for_each_dev) from [<c034e960>] (bus_add_d=
river+0x108/0x214)
[    8.702233] [<c034e960>] (bus_add_driver) from [<c034fa3c>] (driver_regi=
ster+0x78/0xf4)
[    8.710277] [<c034fa3c>] (driver_register) from [<c010175c>] (do_one_ini=
tcall+0x44/0x170)
[    8.718497] [<c010175c>] (do_one_initcall) from [<c0600dbc>] (kernel_ini=
t_freeable+0x154/0x1e0)
[    8.727241] [<c0600dbc>] (kernel_init_freeable) from [<c04ba49c>] (kerne=
l_init+0x8/0x10c)
[    8.735460] [<c04ba49c>] (kernel_init) from [<c0107678>] (ret_from_fork+=
0x14/0x3c)
[    8.743073] ---[ end trace 4ee1a301cee5ee88 ]---
[    8.747729] ------------[ cut here ]------------
[    8.752375] WARNING: CPU: 0 PID: 1 at drivers/pci/search.c:271 pci_get_d=
ev_by_id+0x84/0x8c
[    8.760683] Modules linked in:
[    8.763754] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W       4.9.=
23-1-rc4 #16
[    8.771532] Hardware name: Sigma Tango DT
[    8.775560] [<c010ec94>] (unwind_backtrace) from [<c010ace4>] (show_stac=
k+0x10/0x14)
[    8.783343] [<c010ace4>] (show_stack) from [<c02cc13c>] (dump_stack+0x84=
/0x98)
[    8.790601] [<c02cc13c>] (dump_stack) from [<c01183d0>] (__warn+0xe8/0x1=
00)
[    8.797598] [<c01183d0>] (__warn) from [<c0118498>] (warn_slowpath_null+=
0x20/0x28)
[    8.805206] [<c0118498>] (warn_slowpath_null) from [<c0300d2c>] (pci_get=
_dev_by_id+0x84/0x8c)
[    8.813774] [<c0300d2c>] (pci_get_dev_by_id) from [<c0300da0>] (pci_get_=
device+0x34/0x3c)
[    8.821993] [<c0300da0>] (pci_get_device) from [<c03100c0>] (pci_fixup_i=
rqs+0x60/0xac)
[    8.829950] [<c03100c0>] (pci_fixup_irqs) from [<c0310a64>] (pci_host_co=
mmon_probe+0xe4/0x314)
[    8.838606] [<c0310a64>] (pci_host_common_probe) from [<c03508d8>] (plat=
form_drv_probe+0x34/0x6c)
[    8.847525] [<c03508d8>] (platform_drv_probe) from [<c034f388>] (really_=
probe+0x1c4/0x250)
[    8.855831] [<c034f388>] (really_probe) from [<c034f4d8>] (__driver_atta=
ch+0xc4/0xc8)
[    8.863700] [<c034f4d8>] (__driver_attach) from [<c034d8d0>] (bus_for_ea=
ch_dev+0x68/0x9c)
[    8.871918] [<c034d8d0>] (bus_for_each_dev) from [<c034e960>] (bus_add_d=
river+0x108/0x214)
[    8.880224] [<c034e960>] (bus_add_driver) from [<c034fa3c>] (driver_regi=
ster+0x78/0xf4)
[    8.888269] [<c034fa3c>] (driver_register) from [<c010175c>] (do_one_ini=
tcall+0x44/0x170)
[    8.896488] [<c010175c>] (do_one_initcall) from [<c0600dbc>] (kernel_ini=
t_freeable+0x154/0x1e0)
[    8.905231] [<c0600dbc>] (kernel_init_freeable) from [<c04ba49c>] (kerne=
l_init+0x8/0x10c)
[    8.913451] [<c04ba49c>] (kernel_init) from [<c0107678>] (ret_from_fork+=
0x14/0x3c)
[    8.921063] ---[ end trace 4ee1a301cee5ee89 ]---
[    8.925752] ------------[ cut here ]------------
[    8.930399] WARNING: CPU: 0 PID: 1 at drivers/pci/search.c:271 pci_get_d=
ev_by_id+0x84/0x8c
[    8.938707] Modules linked in:
[    8.941778] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W       4.9.=
23-1-rc4 #16
[    8.949556] Hardware name: Sigma Tango DT
[    8.953585] [<c010ec94>] (unwind_backtrace) from [<c010ace4>] (show_stac=
k+0x10/0x14)
[    8.961368] [<c010ace4>] (show_stack) from [<c02cc13c>] (dump_stack+0x84=
/0x98)
[    8.968626] [<c02cc13c>] (dump_stack) from [<c01183d0>] (__warn+0xe8/0x1=
00)
[    8.975622] [<c01183d0>] (__warn) from [<c0118498>] (warn_slowpath_null+=
0x20/0x28)
[    8.983230] [<c0118498>] (warn_slowpath_null) from [<c0300d2c>] (pci_get=
_dev_by_id+0x84/0x8c)
[    8.991799] [<c0300d2c>] (pci_get_dev_by_id) from [<c0300da0>] (pci_get_=
device+0x34/0x3c)
[    9.000018] [<c0300da0>] (pci_get_device) from [<c03100c0>] (pci_fixup_i=
rqs+0x60/0xac)
[    9.007974] [<c03100c0>] (pci_fixup_irqs) from [<c0310a64>] (pci_host_co=
mmon_probe+0xe4/0x314)
[    9.016631] [<c0310a64>] (pci_host_common_probe) from [<c03508d8>] (plat=
form_drv_probe+0x34/0x6c)
[    9.025550] [<c03508d8>] (platform_drv_probe) from [<c034f388>] (really_=
probe+0x1c4/0x250)
[    9.033856] [<c034f388>] (really_probe) from [<c034f4d8>] (__driver_atta=
ch+0xc4/0xc8)
[    9.041725] [<c034f4d8>] (__driver_attach) from [<c034d8d0>] (bus_for_ea=
ch_dev+0x68/0x9c)
[    9.049944] [<c034d8d0>] (bus_for_each_dev) from [<c034e960>] (bus_add_d=
river+0x108/0x214)
[    9.058250] [<c034e960>] (bus_add_driver) from [<c034fa3c>] (driver_regi=
ster+0x78/0xf4)
[    9.066294] [<c034fa3c>] (driver_register) from [<c010175c>] (do_one_ini=
tcall+0x44/0x170)
[    9.074513] [<c010175c>] (do_one_initcall) from [<c0600dbc>] (kernel_ini=
t_freeable+0x154/0x1e0)
[    9.083257] [<c0600dbc>] (kernel_init_freeable) from [<c04ba49c>] (kerne=
l_init+0x8/0x10c)
[    9.091476] [<c04ba49c>] (kernel_init) from [<c0107678>] (ret_from_fork+=
0x14/0x3c)
[    9.099088] ---[ end trace 4ee1a301cee5ee8a ]---
[    9.103790] pci 0000:00:00.0: BAR 8: assigned [mem 0x50400000-0x504fffff=
]
[    9.110623] pci 0000:01:00.0: BAR 0: assigned [mem 0x50400000-0x50401fff=
 64bit]
[    9.118015] pci 0000:00:00.0: PCI bridge to [bus 01]
[    9.123010] pci 0000:00:00.0:   bridge window [mem 0x50400000-0x504fffff=
]
[    9.129908] pcieport 0000:00:00.0: enabling device (0140 -> 0142)
[    9.136488] aer 0000:00:00.0:pcie002: service driver aer loaded
[    9.142878] pci 0000:01:00.0: enabling device (0140 -> 0142)
[    9.148630] ------------[ cut here ]------------
[    9.153266] kernel BUG at mm/vmalloc.c:1361!
[    9.157551] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
[    9.163407] Modules linked in:
[    9.166472] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W       4.9.=
23-1-rc4 #16
[    9.174250] Hardware name: Sigma Tango DT
[    9.178273] task: df4229c0 task.stack: df43a000
[    9.182827] PC is at __get_vm_area_node+0x148/0x14c
[    9.187724] LR is at 0xffffffff
[    9.190875] pc : [<c01bacb0>]    lr : [<ffffffff>]    psr: 20070013
[    9.190875] sp : df43bd20  ip : 001fff00  fp : df56cc10
[    9.202411] r10: 00000000  r9 : 00000000  r8 : 024000c0
[    9.207656] r7 : 00050400  r6 : 50400000  r5 : 00000000  r4 : ffffffff
[    9.214211] r3 : e0800000  r2 : 00000001  r1 : 00000001  r0 : 00002000
[    9.220769] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment=
 none
[    9.227936] Control: 10c5387d  Table: 9f70004a  DAC: 00000051
[    9.233706] Process swapper/0 (pid: 1, stack limit =3D 0xdf43a210)
[    9.239738] Stack: (0xdf43bd20 to 0xdf43c000)
[    9.244113] bd20: 00000005 00000002 c0310dc8 ffffffff 00000000 50400000 =
00050400 c05ada44
[    9.252332] bd40: 00000000 c01bae34 ff800000 ffffffff 024000c0 c039f260 =
00002000 c0111b1c
[    9.260550] bd60: df601000 000c0300 00002000 0000ffff c0e2ee20 df56cc00 =
00000000 c0111c88
[    9.268768] bd80: c039f260 01420300 c05b4580 c039f260 c0e61324 00000001 =
00000000 c0e0fe20
[    9.276985] bda0: 00000000 c05b4570 df601000 c05b4580 0000ffff c0e2ee20 =
df56cc00 00000000
[    9.285203] bdc0: df56cc10 c0309260 df601468 df60149c df601000 df625c14 =
df625c00 df43be30
[    9.293421] bde0: 00000000 c02f797c df601000 df625c14 df625c00 c02f7a30 =
df559014 df601400
[    9.301639] be00: df559000 c02f7a64 df55900c df55900c df559000 c0310a80 =
df43be30 00000000
[    9.309856] be20: c0e10078 df59b1c0 df56cc00 c058e744 df43be30 df43be30 =
50000000 503fffff
[    9.318074] be40: dfbf7524 00000200 00000000 00000000 00000000 00000000 =
df6df1c0 df56cc10
[    9.326292] be60: c0e0ff88 df56cc44 c0e0ff88 00000000 00000007 00000000 =
dfffee80 c03508d8
[    9.334510] be80: c0e61324 df56cc10 df56cc44 c034f388 df56cc10 c0e0ff88 =
df56cc44 00000000
[    9.342728] bea0: 00000076 c034f4d8 00000000 c0e0ff88 c034f414 c034d8d0 =
df40565c df5423b4
[    9.350946] bec0: c0e0ff88 df4a1480 c0e17728 c034e960 c058e81c ffffe000 =
c0633b8c c0e0ff88
[    9.359164] bee0: ffffe000 c0633b8c c0628834 c034fa3c c0616a64 ffffe000 =
c0633b8c c010175c
[    9.367381] bf00: c0e0a3c8 00000000 00000000 c021c834 c05a5c00 df48df80 =
00000000 c0e09240
[    9.375599] bf20: c05e1a98 c050f824 00000076 c01329f8 c059efa4 c05e1160 =
00000000 00000006
[    9.383817] bf40: 00000006 c0574760 c0e09228 c0e2ee00 c0e2ee00 c0e2ee00 =
c0633b8c c0628834
[    9.392035] bf60: 00000076 00000007 c062883c c0600dbc 00000006 00000006 =
00000000 c06005ac
[    9.400253] bf80: b89dae88 00000000 c04ba494 00000000 00000000 00000000 =
00000000 00000000
[    9.408470] bfa0: 00000000 c04ba49c 00000000 c0107678 00000000 00000000 =
00000000 00000000
[    9.416687] bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 =
00000000 00000000
[    9.424904] bfe0: 00000000 00000000 00000000 00000000 00000013 00000000 =
aa7350b3 5db57fca
[    9.433127] [<c01bacb0>] (__get_vm_area_node) from [<c01bae34>] (get_vm_=
area_caller+0x48/0x50)
[    9.441788] [<c01bae34>] (get_vm_area_caller) from [<c0111b1c>] (__arm_i=
oremap_pfn_caller+0x94/0x1b4)
[    9.451057] [<c0111b1c>] (__arm_ioremap_pfn_caller) from [<c0111c88>] (_=
_arm_ioremap_caller+0x4c/0x54)
[    9.460419] [<c0111c88>] (__arm_ioremap_caller) from [<c039f260>] (quirk=
_usb_early_handoff+0x2f0/0x790)
[    9.469866] [<c039f260>] (quirk_usb_early_handoff) from [<c0309260>] (pc=
i_do_fixups+0x94/0xc8)
[    9.478526] [<c0309260>] (pci_do_fixups) from [<c02f797c>] (pci_bus_add_=
device+0x18/0x90)
[    9.486745] [<c02f797c>] (pci_bus_add_device) from [<c02f7a30>] (pci_bus=
_add_devices+0x3c/0x80)
[    9.495489] [<c02f7a30>] (pci_bus_add_devices) from [<c02f7a64>] (pci_bu=
s_add_devices+0x70/0x80)
[    9.504320] [<c02f7a64>] (pci_bus_add_devices) from [<c0310a80>] (pci_ho=
st_common_probe+0x100/0x314)
[    9.513502] [<c0310a80>] (pci_host_common_probe) from [<c03508d8>] (plat=
form_drv_probe+0x34/0x6c)
[    9.522420] [<c03508d8>] (platform_drv_probe) from [<c034f388>] (really_=
probe+0x1c4/0x250)
[    9.530727] [<c034f388>] (really_probe) from [<c034f4d8>] (__driver_atta=
ch+0xc4/0xc8)
[    9.538596] [<c034f4d8>] (__driver_attach) from [<c034d8d0>] (bus_for_ea=
ch_dev+0x68/0x9c)
[    9.546815] [<c034d8d0>] (bus_for_each_dev) from [<c034e960>] (bus_add_d=
river+0x108/0x214)
[    9.555121] [<c034e960>] (bus_add_driver) from [<c034fa3c>] (driver_regi=
ster+0x78/0xf4)
[    9.563165] [<c034fa3c>] (driver_register) from [<c010175c>] (do_one_ini=
tcall+0x44/0x170)
[    9.571386] [<c010175c>] (do_one_initcall) from [<c0600dbc>] (kernel_ini=
t_freeable+0x154/0x1e0)
[    9.580131] [<c0600dbc>] (kernel_init_freeable) from [<c04ba49c>] (kerne=
l_init+0x8/0x10c)
[    9.588352] [<c04ba49c>] (kernel_init) from [<c0107678>] (ret_from_fork+=
0x14/0x3c)
[    9.595959] Code: eb001776 e3a00000 e28dd00c e8bd83f0 (e7f001f2)=20
[    9.602080] ---[ end trace 4ee1a301cee5ee8b ]---
[    9.606716] Kernel panic - not syncing: Fatal exception in interrupt
[    9.613101] CPU1: stopping
[    9.615818] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G      D W       4.9.=
23-1-rc4 #16
[    9.623597] Hardware name: Sigma Tango DT
[    9.627630] [<c010ec94>] (unwind_backtrace) from [<c010ace4>] (show_stac=
k+0x10/0x14)
[    9.635414] [<c010ace4>] (show_stack) from [<c02cc13c>] (dump_stack+0x84=
/0x98)
[    9.642672] [<c02cc13c>] (dump_stack) from [<c010dad4>] (handle_IPI+0x16=
8/0x17c)
[    9.650105] [<c010dad4>] (handle_IPI) from [<c0101480>] (gic_handle_irq+=
0x88/0x8c)
[    9.657712] [<c0101480>] (gic_handle_irq) from [<c010b7cc>] (__irq_svc+0=
x6c/0xa8)
[    9.665229] Exception stack(0xdf45bf98 to 0xdf45bfe0)
[    9.670300] bf80:                                                       =
00000000 00004c80
[    9.678518] bfa0: dfbe6270 c0114400 df45a000 c0e02fe4 00000002 c0e03034 =
c0e0b80c 413fc090
[    9.686736] bfc0: 00000000 00000000 60000013 df45bfe8 c01080c0 c01080c4 =
60000013 ffffffff
[    9.694956] [<c010b7cc>] (__irq_svc) from [<c01080c4>] (arch_cpu_idle+0x=
38/0x3c)
[    9.702393] [<c01080c4>] (arch_cpu_idle) from [<c0151174>] (cpu_startup_=
entry+0xcc/0x144)
[    9.710612] [<c0151174>] (cpu_startup_entry) from [<8010152c>] (0x801015=
2c)
[    9.717607] ---[ end Kernel panic - not syncing: Fatal exception in inte=
rrupt
