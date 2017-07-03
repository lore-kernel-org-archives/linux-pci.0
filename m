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
	<ard.biesheuvel@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>
References: <987fac41-80dc-f1d0-ec0b-91ae57b91bfd@sigmadesigns.com>
 <b32f9e1c-fdde-3064-f935-c817cf707534@sigmadesigns.com>
 <20170702231811.GJ18324@bhelgaas-glaptop.roam.corp.google.com>
 <79382219-c730-da78-3e5f-5abf3173d7ac@sigmadesigns.com>
 <e57debab-3457-1d9c-a72e-ecdf7d4f742e@sigmadesigns.com>
Message-ID: <baf9866b-04ba-698c-3012-a957ec0123d1@sigmadesigns.com>
Date: Mon, 3 Jul 2017 17:30:28 +0200
MIME-Version: 1.0
In-Reply-To: <e57debab-3457-1d9c-a72e-ecdf7d4f742e@sigmadesigns.com>
Content-Type: text/plain; charset=WINDOWS-1252
List-ID: <linux-pci.vger.kernel.org>

On 03/07/2017 15:13, Marc Gonzalez wrote:

> On 03/07/2017 11:54, Marc Gonzalez wrote:
>=20
>> Mark Rutland points out stop_machine. I will test this solution.
>
> I must be misunderstanding some of the requirements for
> calling stop_machine() because my kernel panics, after
> many warnings.

Enabling several kernel debugging features:

+CONFIG_DEBUG_KERNEL=3Dy
+CONFIG_DEBUG_RT_MUTEXES=3Dy
+CONFIG_DEBUG_WW_MUTEX_SLOWPATH=3Dy
+CONFIG_PROVE_LOCKING=3Dy

And at the end of smp8759_config_read:

=09printk("in_atomic_preempt_off =3D %d\n", in_atomic_preempt_off());
=09stop_machine(do_nothing, NULL, NULL);
=09panic("STOP HERE FOR NOW\n");

The kernel outputs:

[    1.022725] in_atomic_preempt_off =3D 0
[    1.026568] BUG: scheduling while atomic: swapper/0/1/0x00000002
[    1.032625] 5 locks held by swapper/0/1:
[    1.036575]  #0:  (&dev->mutex){......}, at: [<c038c684>] __driver_attac=
h+0x50/0xd0
[    1.044319]  #1:  (&dev->mutex){......}, at: [<c038c694>] __driver_attac=
h+0x60/0xd0
[    1.052050]  #2:  (pci_lock){+.+...}, at: [<c03309d8>] pci_bus_read_conf=
ig_dword+0x44/0x94
[    1.060398]  #3:  (cpu_hotplug.dep_map){++++++}, at: [<c0119db0>] get_on=
line_cpus+0x2c/0xa0
[    1.068843]  #4:  (stop_cpus_mutex){+.+...}, at: [<c01a1184>] stop_cpus+=
0x20/0x48
[    1.076404] Modules linked in:
[    1.079483] Preemption disabled at:[    1.082820] [<  (null)>]   (null)
[    1.086165] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.9.23-1-rc4 #13
[    1.092723] Hardware name: Sigma Tango DT
[    1.096765] [<c010f600>] (unwind_backtrace) from [<c010b568>] (show_stac=
k+0x10/0x14)
[    1.104558] [<c010b568>] (show_stack) from [<c0304830>] (dump_stack+0x98=
/0xc4)
[    1.111823] [<c0304830>] (dump_stack) from [<c013eee0>] (__schedule_bug+=
0x94/0xec)
[    1.119436] [<c013eee0>] (__schedule_bug) from [<c0516364>] (__schedule+=
0x4a4/0x5f0)
[    1.127220] [<c0516364>] (__schedule) from [<c05164fc>] (schedule+0x4c/0=
xac)
[    1.134308] [<c05164fc>] (schedule) from [<c051b010>] (schedule_timeout+=
0x1f4/0x30c)
[    1.142093] [<c051b010>] (schedule_timeout) from [<c051702c>] (wait_for_=
common+0x8c/0x13c)
[    1.150401] [<c051702c>] (wait_for_common) from [<c05170ec>] (wait_for_c=
ompletion+0x10/0x14)
[    1.158886] [<c05170ec>] (wait_for_completion) from [<c01a0d74>] (__stop=
_cpus+0x50/0x64)
[    1.167021] [<c01a0d74>] (__stop_cpus) from [<c01a1194>] (stop_cpus+0x30=
/0x48)
[    1.174282] [<c01a1194>] (stop_cpus) from [<c01a1230>] (stop_machine+0x8=
4/0x118)
[    1.181719] [<c01a1230>] (stop_machine) from [<c034c070>] (smp8759_confi=
g_read+0x84/0x90)
[    1.189942] [<c034c070>] (smp8759_config_read) from [<c0330a00>] (pci_bu=
s_read_config_dword+0x6c/0x94)
[    1.199301] [<c0330a00>] (pci_bus_read_config_dword) from [<c0332920>] (=
pci_bus_read_dev_vendor_id+0x24/0xe8)
[    1.209270] [<c0332920>] (pci_bus_read_dev_vendor_id) from [<c033413c>] =
(pci_scan_single_device+0x40/0xb0)
[    1.218977] [<c033413c>] (pci_scan_single_device) from [<c0334204>] (pci=
_scan_slot+0x58/0x100)
[    1.227636] [<c0334204>] (pci_scan_slot) from [<c033511c>] (pci_scan_chi=
ld_bus+0x20/0xf8)
[    1.235858] [<c033511c>] (pci_scan_child_bus) from [<c03353ec>] (pci_sca=
n_root_bus_msi+0xcc/0xd8)
[    1.244779] [<c03353ec>] (pci_scan_root_bus_msi) from [<c0335410>] (pci_=
scan_root_bus+0x18/0x20)
[    1.253612] [<c0335410>] (pci_scan_root_bus) from [<c034bc5c>] (pci_host=
_common_probe+0xc8/0x314)
[    1.262533] [<c034bc5c>] (pci_host_common_probe) from [<c034c444>] (tang=
o_pcie_probe+0x148/0x350)
[    1.271455] [<c034c444>] (tango_pcie_probe) from [<c038dbc8>] (platform_=
drv_probe+0x34/0x6c)
[    1.279939] [<c038dbc8>] (platform_drv_probe) from [<c038c5a8>] (really_=
probe+0x1c4/0x250)
[    1.288248] [<c038c5a8>] (really_probe) from [<c038c700>] (__driver_atta=
ch+0xcc/0xd0)
[    1.296121] [<c038c700>] (__driver_attach) from [<c038aa50>] (bus_for_ea=
ch_dev+0x68/0x9c)
[    1.304342] [<c038aa50>] (bus_for_each_dev) from [<c038bfac>] (driver_at=
tach+0x1c/0x20)
[    1.312389] [<c038bfac>] (driver_attach) from [<c038bb5c>] (bus_add_driv=
er+0x108/0x214)
[    1.320436] [<c038bb5c>] (bus_add_driver) from [<c038ccb0>] (driver_regi=
ster+0x78/0xf4)
[    1.328483] [<c038ccb0>] (driver_register) from [<c038db8c>] (__platform=
_driver_register+0x40/0x48)
[    1.337583] [<c038db8c>] (__platform_driver_register) from [<c0816fc4>] =
(tango_pcie_driver_init+0x14/0x18)
[    1.347291] [<c0816fc4>] (tango_pcie_driver_init) from [<c01017dc>] (do_=
one_initcall+0x44/0x174)
[    1.356128] [<c01017dc>] (do_one_initcall) from [<c0800dcc>] (kernel_ini=
t_freeable+0x154/0x1e0)
[    1.364875] [<c0800dcc>] (kernel_init_freeable) from [<c0515544>] (kerne=
l_init+0x8/0x10c)
[    1.373097] [<c0515544>] (kernel_init) from [<c01077d0>] (ret_from_fork+=
0x14/0x24)
[    1.380799] Kernel panic - not syncing: STOP HERE FOR NOW
[    1.380799]=20
[    1.387714] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W       4.9.=
23-1-rc4 #13
[    1.395495] Hardware name: Sigma Tango DT
[    1.399529] [<c010f600>] (unwind_backtrace) from [<c010b568>] (show_stac=
k+0x10/0x14)
[    1.407317] [<c010b568>] (show_stack) from [<c0304830>] (dump_stack+0x98=
/0xc4)
[    1.414582] [<c0304830>] (dump_stack) from [<c01a3bac>] (panic+0xe0/0x25=
8)
[    1.421494] [<c01a3bac>] (panic) from [<c034c07c>] (tango_check_pcie_lin=
k+0x0/0x48)
[    1.429192] [<c034c07c>] (tango_check_pcie_link) from [<c034bfec>] (smp8=
759_config_read+0x0/0x90)
[    1.438114] [<c034bfec>] (smp8759_config_read) from [<00241105>] (0x2411=
05)
[    1.445191] CPU1: stopping
[    1.447910] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W       4.9.=
23-1-rc4 #13
[    1.455690] Hardware name: Sigma Tango DT
[    1.459724] [<c010f600>] (unwind_backtrace) from [<c010b568>] (show_stac=
k+0x10/0x14)
[    1.467512] [<c010b568>] (show_stack) from [<c0304830>] (dump_stack+0x98=
/0xc4)
[    1.474774] [<c0304830>] (dump_stack) from [<c010e410>] (handle_IPI+0x19=
c/0x1b0)
[    1.482210] [<c010e410>] (handle_IPI) from [<c010151c>] (gic_handle_irq+=
0x88/0x8c)
[    1.489819] [<c010151c>] (gic_handle_irq) from [<c010c0b0>] (__irq_svc+0=
x70/0xb0)
[    1.497339] Exception stack(0xdf46ff80 to 0xdf46ffc8)
[    1.502415] ff80: 00000001 00000001 00000000 df468180 df46e000 c1004be4 =
c1004c48 00000002
[    1.510636] ffa0: c100f990 413fc090 00000000 00000000 00000000 df46ffd0 =
c0165ee0 c0108240
[    1.518853] ffc0: 20000113 ffffffff
[    1.522358] [<c010c0b0>] (__irq_svc) from [<c0108240>] (arch_cpu_idle+0x=
24/0x3c)
[    1.529795] [<c0108240>] (arch_cpu_idle) from [<c051b540>] (default_idle=
_call+0x20/0x30)
[    1.537934] [<c051b540>] (default_idle_call) from [<c015d6cc>] (cpu_star=
tup_entry+0xd0/0x150)
[    1.546504] [<c015d6cc>] (cpu_startup_entry) from [<c010e048>] (secondar=
y_start_kernel+0x158/0x164)
[    1.555599] [<c010e048>] (secondary_start_kernel) from [<801015ac>] (0x8=
01015ac)
[    1.563063] ---[ end Kernel panic - not syncing: STOP HERE FOR NOW


The panic call stack looks suspicious.

smp8759_config_read() never calls tango_check_pcie_link().

(I compile with -fno-optimize-sibling-calls to get more accurate
call stacks.)

in_atomic_preempt_off is false before calling stop_machine()

I suppose I'm doing something wrong, but I'm not sure what yet.

Regards.
