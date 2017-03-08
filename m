Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:34362 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752998AbdCHSqv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 8 Mar 2017 13:46:51 -0500
Message-ID: <58C05114.5030202@arm.com>
Date: Wed, 08 Mar 2017 18:44:36 +0000
From: James Morse <james.morse@arm.com>
MIME-Version: 1.0
To: Rajat Jain <rajatja@google.com>, Rajat Jain <rajatxjain@gmail.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
        Keith Busch <keith.busch@intel.com>,
        Andreas Ziegler <andreas.ziegler@fau.de>,
        Jonathan Yong <jonathan.yong@intel.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        David Daney <david.daney@cavium.com>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Ram Amrani <Ram.Amrani@cavium.com>,
        Doug Ledford <dledford@redhat.com>,
        Wang Sheng-Hui <shhuiw@foxmail.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Brian Norris <briannorris@google.com>
Subject: Re: [PATCH 5/6] PCI/ASPM: Actually configure the L1 substate settings
 to the device
References: <1483425255-101923-1-git-send-email-rajatja@google.com> <1483425255-101923-6-git-send-email-rajatja@google.com>
In-Reply-To: <1483425255-101923-6-git-send-email-rajatja@google.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi!

On 03/01/17 06:34, Rajat Jain wrote:
> Add code to actually configure the L1 substate settigns on the
> upstream and downstream device, while taking care of the rules
> dictated by the PCIe spec.

While testing hibernate on an arm64 juno with v4.11-rc1, I get a NULL pointer
dereference from pcie_config_aspm_link():


> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index a70afdf..6735f38 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -597,11 +683,23 @@ static void pcie_config_aspm_dev(struct pci_dev *pdev, u32 val)
>  static void pcie_config_aspm_link(struct pcie_link_state *link, u32 state)
>  {
>  	u32 upstream = 0, dwstream = 0;
> -	struct pci_dev *child, *parent = link->pdev;
> +	struct pci_dev *child = link->downstream, *parent = link->pdev;


Here link->downstream is NULL,


>  	struct pci_bus *linkbus = parent->subordinate;
>  
> -	/* Nothing to do if the link is already in the requested state */
> +	/* Enable only the states that were not explicitly disabled */
>  	state &= (link->aspm_capable & ~link->aspm_disable);
> +
> +	/* Can't enable any substates if L1 is not enabled */
> +	if (!(state & ASPM_STATE_L1))
> +		state &= ~ASPM_STATE_L1SS;
> +
> +	/* Spec says both ports must be in D0 before enabling PCI PM substates*/
> +	if (parent->current_state != PCI_D0 || child->current_state != PCI_D0) {

Which causes a crash[0] here.


> +		state &= ~ASPM_STATE_L1_SS_PCIPM;
> +		state |= (link->aspm_enabled & ASPM_STATE_L1_SS_PCIPM);
> +	}
> +
> +	/* Nothing to do if the link is already in the requested state */
>  	if (link->aspm_enabled == state)
>  		return;
>  	/* Convert ASPM state to upstream/downstream ASPM register state */


(For trees based on v4.10-rc1 I need to cherry-pick b4b8664d291a to make arm64
build)

Testing either side of aeda9adebab8 gives this patch as the first to expose the
problem.


At boot I get the message:
> pci 0000:03:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it
with 'pcie_aspm=force'

for the pcie device being resumed here, should this code be called at all for
this device?

The 'pci' section of the boot log for v4.11-rc1 is below[1], and lspci[2].


Thanks,

James


[0] git checkout aeda9adebab8; git cherry-pick b4b8664d291a
[  170.379816] PM: noirq thaw of devices complete after 0.702 msecs
[  170.387234] PM: early thaw of devices complete after 1.390 msecs
[  170.421447] Unable to handle kernel NULL pointer dereference at virtual addre
ss 00000080
[  170.429497] pgd = ffff000008f10000
[  170.432878] [00000080] *pgd=00000009ffffe003
[  170.432882] , *pud=00000009ffffd003
[  170.437118] , *pmd=0000000000000000
[  170.440579]

[  170.445513] Internal error: Oops: 96000004 [#1] PREEMPT SMP
[  170.451027] Modules linked in:
[  170.454055] CPU: 4 PID: 2509 Comm: kworker/u12:9 Not tainted 4.10.0-rc1-00006
-g51e9dca242d2 #7202
[  170.462837] Hardware name: ARM Juno development board (r1) (DT)
[  170.468707] Workqueue: events_unbound async_run_entry_fn
[  170.473965] task: ffff8009764c2580 task.stack: ffff80097374c000
[  170.479831] PC is at pcie_config_aspm_link+0x4c/0x300
[  170.484833] LR is at pcie_config_aspm_path+0x40/0x88
[  170.489747] pc : [<ffff000008411ebc>] lr : [<ffff0000084121b0>] pstate: 40000
045
[  170.497066] sp : ffff80097374fb40
[  170.500343] x29: ffff80097374fb40 x28: ffff800976c0c2a8
[  170.505603] x27: ffff800976c0c078 x26: ffff800976c0c020
[  170.510863] x25: 0000000000000001 x24: ffff8009750f9120
[  170.516122] x23: ffff8009764bd100 x22: ffff000008045000
[  170.521381] x21: ffff800976c24000 x20: ffff000008ef3320
[  170.526640] x19: 0000000000000000 x18: 0000000000000000
[  170.531899] x17: 0000000000000000 x16: 0000000000000000
[  170.537158] x15: 0000000000000000 x14: 00000000000000dc
[  170.542417] x13: ffff000008e17628 x12: ffff800976fa8028
[  170.547676] x11: ffff80097641f000 x10: ffff000008e17608
[  170.552936] x9 : ffff800976fa8028 x8 : 0000000000000000
[  170.558194] x7 : 000000000000007b x6 : 0000000000000000
[  170.563453] x5 : 0000000000000fa0 x4 : ffff80097641fd60
[  170.568712] x3 : 0000000000000000 x2 : 0000000000000000
[  170.573971] x1 : 0000000000000000 x0 : ffff80097641fd00
[  170.579229]
[  170.580701] Process kworker/u12:9 (pid: 2509, stack limit = 0xffff80097374c00
0)
[  170.587936] Stack: (0xffff80097374fb40 to 0xffff800973750000)
[  170.888248] Call trace:
[  170.974579] [<ffff000008411ebc>] pcie_config_aspm_link+0x4c/0x300
[  170.980614] [<ffff0000084121b0>] pcie_config_aspm_path+0x40/0x88
[  170.986564] [<ffff0000084130f4>] pcie_aspm_pm_state_change+0x5c/0x80
[  170.992856] [<ffff0000083ff0a4>] pci_raw_set_power_state+0x15c/0x230
[  170.999148] [<ffff0000084018ec>] pci_set_power_state+0x64/0x150
[  171.005013] [<ffff00000859ae20>] ata_pci_device_do_resume+0x18/0x70
[  171.011220] [<ffff0000085baa3c>] sil24_pci_device_resume+0x24/0x78
[  171.017341] [<ffff000008404fd8>] pci_legacy_resume+0x38/0x58
[  171.022945] [<ffff000008405f00>] pci_pm_thaw+0xa0/0xd0
[  171.028034] [<ffff000008546ce4>] dpm_run_callback.isra.4+0x1c/0x70
[  171.034154] [<ffff0000085470a0>] device_resume+0x88/0x150
[  171.039500] [<ffff00000854718c>] async_resume+0x24/0x58
[  171.044674] [<ffff0000080de55c>] async_run_entry_fn+0x3c/0xf8
[  171.050365] [<ffff0000080d4de8>] process_one_work+0x1d0/0x390
[  171.056055] [<ffff0000080d4ff0>] worker_thread+0x48/0x480
[  171.061400] [<ffff0000080daec0>] kthread+0xf8/0x128
[  171.066230] [<ffff0000080836c0>] ret_from_fork+0x10/0x50
[  171.071490] Code: 12196e61 f27e027f 1a930033 35000063 (b9408101)
[  171.077566] ---[ end trace 93b51adc52c63085 ]---

[1] v4.11-rc1 pci boot messages
[    0.732114] OF: PCI: host bridge /pcie-controller@30000000 ranges:
[    0.732133] OF: PCI:    IO 0x5f800000..0x5fffffff -> 0x5f800000
[    0.732145] OF: PCI:   MEM 0x50000000..0x57ffffff -> 0x50000000
[    0.732152] OF: PCI:   MEM 0x4000000000..0x40ffffffff -> 0x4000000000
[    0.732204] pci-host-generic 40000000.pcie-controller: ECAM at [mem 0x4000000
0-0x4fffffff] for [bus 00-ff]
[    0.732401] pci-host-generic 40000000.pcie-controller: PCI host bridge to bus
 0000:00
[    0.732410] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.732421] pci_bus 0000:00: root bus resource [io  0x0000-0x7fffff] (bus add
ress [0x5f800000-0x5fffffff])
[    0.732428] pci_bus 0000:00: root bus resource [mem 0x50000000-0x57ffffff]
[    0.732435] pci_bus 0000:00: root bus resource [mem 0x4000000000-0x40ffffffff
 pref]
[    0.732462] pci 0000:00:00.0: [1556:1100] type 01 class 0x060400
[    0.732485] pci 0000:00:00.0: reg 0x10: [mem 0x57d00000-0x57d03fff 64bit pref]
[    0.732543] pci 0000:00:00.0: supports D1 D2
[    0.732832] pci 0000:00:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.733252] pci 0000:01:00.0: [111d:8090] type 01 class 0x060400
[    0.733423] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
[    0.744804] pci 0000:02:01.0: [111d:8090] type 01 class 0x060400
[    0.744993] pci 0000:02:01.0: PME# supported from D0 D3hot D3cold
[    0.745223] pci 0000:02:02.0: [111d:8090] type 01 class 0x060400
[    0.745414] pci 0000:02:02.0: PME# supported from D0 D3hot D3cold
[    0.745641] pci 0000:02:03.0: [111d:8090] type 01 class 0x060400
[    0.745828] pci 0000:02:03.0: PME# supported from D0 D3hot D3cold
[    0.746076] pci 0000:02:0c.0: [111d:8090] type 01 class 0x060400
[    0.746263] pci 0000:02:0c.0: PME# supported from D0 D3hot D3cold
[    0.746482] pci 0000:02:10.0: [111d:8090] type 01 class 0x060400
[    0.746646] pci 0000:02:10.0: PME# supported from D0 D3hot D3cold
[    0.746886] pci 0000:02:1f.0: [111d:8090] type 01 class 0x060400
[    0.747074] pci 0000:02:1f.0: PME# supported from D0 D3hot D3cold
[    0.747490] pci 0000:03:00.0: [1095:3132] type 00 class 0x018000
[    0.747531] pci 0000:03:00.0: reg 0x10: [mem 0x57f04000-0x57f0407f 64bit]
[    0.747559] pci 0000:03:00.0: reg 0x18: [mem 0x57f00000-0x57f03fff 64bit]
[    0.747577] pci 0000:03:00.0: reg 0x20: initial BAR value 0x00000000 invalid
[    0.747584] pci 0000:03:00.0: reg 0x20: [io  size 0x0080]
[    0.747614] pci 0000:03:00.0: reg 0x30: [mem 0xfff80000-0xffffffff pref]
[    0.747720] pci 0000:03:00.0: supports D1 D2
[    0.747886] pci 0000:03:00.0: disabling ASPM on pre-1.1 PCIe device.  You can
 enable it with 'pcie_aspm=force'
[    0.747910] pci_bus 0000:03: busn_res: [bus 03-ff] end is updated to 03
[    0.748044] pci_bus 0000:04: busn_res: [bus 04-ff] end is updated to 04
[    0.748180] pci_bus 0000:05: busn_res: [bus 05-ff] end is updated to 05
[    0.748311] pci_bus 0000:06: busn_res: [bus 06-ff] end is updated to 06
[    0.748441] pci_bus 0000:07: busn_res: [bus 07-ff] end is updated to 07
[    0.748614] pci 0000:08:00.0: [11ab:4380] type 00 class 0x020000
[    0.748651] pci 0000:08:00.0: reg 0x10: [mem 0x57e00000-0x57e03fff 64bit]
[    0.748668] pci 0000:08:00.0: reg 0x18: initial BAR value 0x00000000 invalid
[    0.748675] pci 0000:08:00.0: reg 0x18: [io  size 0x0100]
[    0.748814] pci 0000:08:00.0: supports D1 D2
[    0.748821] pci 0000:08:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.749085] pci_bus 0000:08: busn_res: [bus 08-ff] end is updated to 08
[    0.749099] pci_bus 0000:02: busn_res: [bus 02-ff] end is updated to 08
[    0.749112] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 08
[    0.749249] pci 0000:00:00.0: BAR 14: assigned [mem 0x50000000-0x501fffff]
[    0.749260] pci 0000:00:00.0: BAR 0: assigned [mem 0x4000000000-0x4000003fff
64bit pref]
[    0.749272] pci 0000:00:00.0: BAR 13: assigned [io  0x1000-0x2fff]
[    0.749283] pci 0000:01:00.0: BAR 14: assigned [mem 0x50000000-0x501fffff]
[    0.749290] pci 0000:01:00.0: BAR 13: assigned [io  0x1000-0x2fff]
[    0.749303] pci 0000:02:01.0: BAR 14: assigned [mem 0x50000000-0x500fffff]
[    0.749311] pci 0000:02:1f.0: BAR 14: assigned [mem 0x50100000-0x501fffff]
[    0.749318] pci 0000:02:01.0: BAR 13: assigned [io  0x1000-0x1fff]
[    0.749325] pci 0000:02:1f.0: BAR 13: assigned [io  0x2000-0x2fff]
[    0.749337] pci 0000:03:00.0: BAR 6: assigned [mem 0x50000000-0x5007ffff pref]
[    0.749347] pci 0000:03:00.0: BAR 2: assigned [mem 0x50080000-0x50083fff 64bit]
[    0.749372] pci 0000:03:00.0: BAR 0: assigned [mem 0x50084000-0x5008407f 64bit]
[    0.749394] pci 0000:03:00.0: BAR 4: assigned [io  0x1000-0x107f]
[    0.749407] pci 0000:02:01.0: PCI bridge to [bus 03]
[    0.749416] pci 0000:02:01.0:   bridge window [io  0x1000-0x1fff]
[    0.749429] pci 0000:02:01.0:   bridge window [mem 0x50000000-0x500fffff]
[    0.749451] pci 0000:02:02.0: PCI bridge to [bus 04]
[    0.749479] pci 0000:02:03.0: PCI bridge to [bus 05]
[    0.749507] pci 0000:02:0c.0: PCI bridge to [bus 06]
[    0.749535] pci 0000:02:10.0: PCI bridge to [bus 07]
[    0.749569] pci 0000:08:00.0: BAR 0: assigned [mem 0x50100000-0x50103fff 64bit]
[    0.749590] pci 0000:08:00.0: BAR 2: assigned [io  0x2000-0x20ff]
[    0.749600] pci 0000:02:1f.0: PCI bridge to [bus 08]
[    0.749608] pci 0000:02:1f.0:   bridge window [io  0x2000-0x2fff]
[    0.749622] pci 0000:02:1f.0:   bridge window [mem 0x50100000-0x501fffff]
[    0.749643] pci 0000:01:00.0: PCI bridge to [bus 02-08]
[    0.749651] pci 0000:01:00.0:   bridge window [io  0x1000-0x2fff]
[    0.749664] pci 0000:01:00.0:   bridge window [mem 0x50000000-0x501fffff]
[    0.749685] pci 0000:00:00.0: PCI bridge to [bus 01-08]
[    0.749691] pci 0000:00:00.0:   bridge window [io  0x1000-0x2fff]
[    0.749699] pci 0000:00:00.0:   bridge window [mem 0x50000000-0x501fffff]
[    0.750009] pcieport 0000:00:00.0: Signaling PME with IRQ 39
[    0.750155] pcieport 0000:00:00.0: AER enabled with IRQ 39

[2] lspci
root@juno-r1:~# lspci
00:00.0 PCI bridge: PLDA PCI Express Core Reference Design (rev 01)
01:00.0 PCI bridge: Integrated Device Technology, Inc. [IDT] Device 8090 (rev 02
)
02:01.0 PCI bridge: Integrated Device Technology, Inc. [IDT] Device 8090 (rev 02
)
02:02.0 PCI bridge: Integrated Device Technology, Inc. [IDT] Device 8090 (rev 02
)
02:03.0 PCI bridge: Integrated Device Technology, Inc. [IDT] Device 8090 (rev 02
)
02:0c.0 PCI bridge: Integrated Device Technology, Inc. [IDT] Device 8090 (rev 02
)
02:10.0 PCI bridge: Integrated Device Technology, Inc. [IDT] Device 8090 (rev 02
)
02:1f.0 PCI bridge: Integrated Device Technology, Inc. [IDT] Device 8090 (rev 02
)
03:00.0 Mass storage controller: Silicon Image, Inc. SiI 3132 Serial ATA Raid II
 Controller (rev 01)
08:00.0 Ethernet controller: Marvell Technology Group Ltd. 88E8057 PCI-E Gigabit
 Ethernet Controller
