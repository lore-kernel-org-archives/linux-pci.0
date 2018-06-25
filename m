Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:57098 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755414AbeFYNNb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 25 Jun 2018 09:13:31 -0400
Subject: Re: [PATCH] PCI: shpchp: Fix probing logic inversion
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180621164715.28160-1-marc.zyngier@arm.com>
 <20180625125204.GH2558@lahna.fi.intel.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <8d37f32e-d62d-0e81-d478-8a7a8d7b15c0@arm.com>
Date: Mon, 25 Jun 2018 14:13:26 +0100
MIME-Version: 1.0
In-Reply-To: <20180625125204.GH2558@lahna.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 25/06/18 13:52, Mika Westerberg wrote:
> On Thu, Jun 21, 2018 at 05:47:15PM +0100, Marc Zyngier wrote:
>> Until recently, shpc_probe() would bail out pretty early in the
>> absence of the SHPC capability. A logic change in the way the
>> driver now checks that capability makes it go and probe the
>> firmware anyway, with ugly consequences if the system is not
>> ACPI based (my arm64 ThunderX is DT driven, and explodes in
>> a spectacular way after getting a NULL root bridge from the
>> non-existent ACPI tables...).
> 
> Could you share log from the failure? I would like to understand a bit
> better where it crashes and why.

Here you go:

[   12.330017] pcieport 0008:1f:00.0: enabling device (0506 -> 0507)
[   12.336315] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000058
[   12.345104] Mem abort info:
[   12.347895]   ESR = 0x96000004
[   12.350945]   Exception class = DABT (current EL), IL = 32 bits
[   12.356860]   SET = 0, FnV = 0
[   12.359910]   EA = 0, S1PTW = 0
[   12.363046] Data abort info:
[   12.365922]   ISV = 0, ISS = 0x00000004
[   12.369748]   CM = 0, WnR = 0
[   12.372712] [0000000000000058] user address but active_mm is swapper
[   12.379063] Internal error: Oops: 96000004 [#1] PREEMPT SMP
[   12.384625] Modules linked in:
[   12.387676] CPU: 0 PID: 5 Comm: kworker/0:0 Not tainted 4.18.0-rc1-00006-ga2c5c6a64fb6 #10
[   12.395929] Hardware name: FOXCONN R2-1221R-A4/C2U4N_MB, BIOS G31FB18A 03/31/2017
[   12.403408] Workqueue: events work_for_cpu_fn
[   12.407758] pstate: 60000005 (nZCv daif -PAN -UAO)
[   12.412544] pc : acpi_get_hp_hw_control_from_firmware+0xa0/0x2b0
[   12.418541] lr : acpi_get_hp_hw_control_from_firmware+0xa0/0x2b0
[   12.424537] sp : ffff00000a613c60
[   12.427841] x29: ffff00000a613c60 x28: 0000000000000000 
[   12.433147] x27: ffff800fbeb8d0b0 x26: ffff00000982a068 
[   12.438453] x25: 0000000000000000 x24: ffff000009feb898 
[   12.443759] x23: 0000000000000000 x22: ffff000009808000 
[   12.449064] x21: ffff0000098dee98 x20: ffff810fa60d9000 
[   12.454370] x19: 0000000000000000 x18: ffffffffffffffff 
[   12.459675] x17: 0000000000000e00 x16: 0000000000000020 
[   12.464981] x15: ffff000009808648 x14: ffff000089a31b8f 
[   12.470286] x13: 0000000000000000 x12: 0000000000000040 
[   12.475591] x11: 000000000000004c x10: 0000000000000a20 
[   12.480897] x9 : ffff00000a613d30 x8 : 0000000000000000 
[   12.486202] x7 : ffff000009808648 x6 : 0000000000000057 
[   12.491508] x5 : 0000000000000010 x4 : 000000000000001f 
[   12.496813] x3 : 0000000000000000 x2 : 0d68a3f9b2251000 
[   12.502118] x1 : 0000000000000000 x0 : 0000000000000000 
[   12.507425] Process kworker/0:0 (pid: 5, stack limit = 0x(____ptrval____))
[   12.514289] Call trace:
[   12.516727]  acpi_get_hp_hw_control_from_firmware+0xa0/0x2b0
[   12.522377]  shpc_probe+0x48/0x3b0
[   12.525772]  local_pci_probe+0x44/0xb0
[   12.529511]  work_for_cpu_fn+0x20/0x30
[   12.533252]  process_one_work+0x208/0x480
[   12.537251]  worker_thread+0x254/0x448
[   12.540992]  kthread+0x104/0x130
[   12.544212]  ret_from_fork+0x10/0x1c
[   12.547779] Code: f100427f 54000040 f85f8260 94009f63 (b9405800) 
[   12.553866] ---[ end trace 8ee5b8cc95cd4f02 ]---

>> Take this opportunity to move the call to shpchp_is_native()
>> back into shpc_probe(), making it clear that a non-ACPI system
>> is not expected to use this driver.
> 
> It is fine to use SHPC in non-ACPI systems. However, in ACPI systems we
> should negotiate whether it is the OS or the firmware who handles it.
Fair enough. In which case we should at the very least make sure
we can handle acpi_pci_find_root() returning NULL (which is what
generates the crash in my case).

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
