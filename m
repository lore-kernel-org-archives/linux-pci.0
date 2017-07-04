Return-Path: <SRS0=OVob=6H=infradead.org=peterz@kernel.org>
Return-Path: <SRS0=OVob=6H=infradead.org=peterz@kernel.org>
Date: Tue, 4 Jul 2017 09:09:58 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Marc Zyngier <marc.zyngier@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-pci <linux-pci@vger.kernel.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	LKML <linux-kernel@vger.kernel.org>, Mason <slash.tmp@free.fr>,
	Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v9 2/3] PCI: Add tango PCIe host bridge support
Message-ID: <20170704070958.oolhapyx7uy2fly4@hirez.programming.kicks-ass.net>
References: <987fac41-80dc-f1d0-ec0b-91ae57b91bfd@sigmadesigns.com>
 <b32f9e1c-fdde-3064-f935-c817cf707534@sigmadesigns.com>
 <20170702231811.GJ18324@bhelgaas-glaptop.roam.corp.google.com>
 <79382219-c730-da78-3e5f-5abf3173d7ac@sigmadesigns.com>
 <e57debab-3457-1d9c-a72e-ecdf7d4f742e@sigmadesigns.com>
 <baf9866b-04ba-698c-3012-a957ec0123d1@sigmadesigns.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <baf9866b-04ba-698c-3012-a957ec0123d1@sigmadesigns.com>
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 03, 2017 at 05:30:28PM +0200, Marc Gonzalez wrote:

> And at the end of smp8759_config_read:
> 
> 	printk("in_atomic_preempt_off = %d\n", in_atomic_preempt_off());

That's confused...

> 	stop_machine(do_nothing, NULL, NULL);
> 	panic("STOP HERE FOR NOW\n");
> 
> The kernel outputs:
> 
> [    1.022725] in_atomic_preempt_off = 0
> [    1.026568] BUG: scheduling while atomic: swapper/0/1/0x00000002
> [    1.032625] 5 locks held by swapper/0/1:
> [    1.036575]  #0:  (&dev->mutex){......}, at: [<c038c684>] __driver_attach+0x50/0xd0
> [    1.044319]  #1:  (&dev->mutex){......}, at: [<c038c694>] __driver_attach+0x60/0xd0
> [    1.052050]  #2:  (pci_lock){+.+...}, at: [<c03309d8>] pci_bus_read_config_dword+0x44/0x94

This is a raw_spinlock_t, that disables preemption

> [    1.060398]  #3:  (cpu_hotplug.dep_map){++++++}, at: [<c0119db0>] get_online_cpus+0x2c/0xa0
> [    1.068843]  #4:  (stop_cpus_mutex){+.+...}, at: [<c01a1184>] stop_cpus+0x20/0x48

> [    1.076404] Modules linked in:
> [    1.079483] Preemption disabled at:[    1.082820] [<  (null)>]   (null)
> [    1.086165] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.9.23-1-rc4 #13
> [    1.092723] Hardware name: Sigma Tango DT
> [    1.096765] [<c010f600>] (unwind_backtrace) from [<c010b568>] (show_stack+0x10/0x14)
> [    1.104558] [<c010b568>] (show_stack) from [<c0304830>] (dump_stack+0x98/0xc4)
> [    1.111823] [<c0304830>] (dump_stack) from [<c013eee0>] (__schedule_bug+0x94/0xec)
> [    1.119436] [<c013eee0>] (__schedule_bug) from [<c0516364>] (__schedule+0x4a4/0x5f0)
> [    1.127220] [<c0516364>] (__schedule) from [<c05164fc>] (schedule+0x4c/0xac)


And here you try and schedule with preemption disabled.

> [    1.134308] [<c05164fc>] (schedule) from [<c051b010>] (schedule_timeout+0x1f4/0x30c)
> [    1.142093] [<c051b010>] (schedule_timeout) from [<c051702c>] (wait_for_common+0x8c/0x13c)
> [    1.150401] [<c051702c>] (wait_for_common) from [<c05170ec>] (wait_for_completion+0x10/0x14)
> [    1.158886] [<c05170ec>] (wait_for_completion) from [<c01a0d74>] (__stop_cpus+0x50/0x64)
> [    1.167021] [<c01a0d74>] (__stop_cpus) from [<c01a1194>] (stop_cpus+0x30/0x48)
> [    1.174282] [<c01a1194>] (stop_cpus) from [<c01a1230>] (stop_machine+0x84/0x118)
> [    1.181719] [<c01a1230>] (stop_machine) from [<c034c070>] (smp8759_config_read+0x84/0x90)
> [    1.189942] [<c034c070>] (smp8759_config_read) from [<c0330a00>] (pci_bus_read_config_dword+0x6c/0x94)
> [    1.199301] [<c0330a00>] (pci_bus_read_config_dword) from [<c0332920>] (pci_bus_read_dev_vendor_id+0x24/0xe8)
> [    1.209270] [<c0332920>] (pci_bus_read_dev_vendor_id) from [<c033413c>] (pci_scan_single_device+0x40/0xb0)
> [    1.218977] [<c033413c>] (pci_scan_single_device) from [<c0334204>] (pci_scan_slot+0x58/0x100)
> [    1.227636] [<c0334204>] (pci_scan_slot) from [<c033511c>] (pci_scan_child_bus+0x20/0xf8)
> [    1.235858] [<c033511c>] (pci_scan_child_bus) from [<c03353ec>] (pci_scan_root_bus_msi+0xcc/0xd8)
> [    1.244779] [<c03353ec>] (pci_scan_root_bus_msi) from [<c0335410>] (pci_scan_root_bus+0x18/0x20)
> [    1.253612] [<c0335410>] (pci_scan_root_bus) from [<c034bc5c>] (pci_host_common_probe+0xc8/0x314)
> [    1.262533] [<c034bc5c>] (pci_host_common_probe) from [<c034c444>] (tango_pcie_probe+0x148/0x350)
> [    1.271455] [<c034c444>] (tango_pcie_probe) from [<c038dbc8>] (platform_drv_probe+0x34/0x6c)

> The panic call stack looks suspicious.
> 
> smp8759_config_read() never calls tango_check_pcie_link().
> 
> (I compile with -fno-optimize-sibling-calls to get more accurate
> call stacks.)
> 
> in_atomic_preempt_off is false before calling stop_machine()

Yes, but that's a pointless statement.

> I suppose I'm doing something wrong, but I'm not sure what yet.

Using stop_machine() is per definition doing it wrong ;-) But see above.
