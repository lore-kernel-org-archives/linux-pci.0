Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D92F2FE075;
	Tue, 17 Mar 2026 21:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773781602; cv=none; b=jHmyU0qypWT/0PusTVXneC6mJURT+lWGv4BSz/jqHkcWxwDO9mbsoebuGKp2FdPV4OfyOYDNaMWM7JnFxa4Txq3oX8oBbGs0DCdlI/3Ct+s0UQI5x3Z82S4LfvRYrdOkwNtzyeC8nSyxxnRUEGDnD37pNY4TEQ1ktawMADT0ELY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773781602; c=relaxed/simple;
	bh=1qaRt5zgwxlzfFPVenYUPKrPDk5HPS4Vgi6zbP/ZFWs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=QEpn9KjOVLfth6GwMa1nuB5s04tHHWLCKBZlFPD2Ov8+t3IiKpn85AVzccwz4Kc4llz9VTPiv53rNIFfWZWNk2HqWSNU+spfVTR23090EUakxNBdf+rblensfLvWLIOiUZjMKzaM4k8rzap6eyqFbjx6J7JBJ4DG6vfBC0S7l2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DiHcHOI7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DiHcHOI7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9701C4CEF7;
	Tue, 17 Mar 2026 21:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773781601;
	bh=1qaRt5zgwxlzfFPVenYUPKrPDk5HPS4Vgi6zbP/ZFWs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=DiHcHOI7VeM09mWai4UgEMC61e8YQKLJJe/Eub+Zt7clNXfMpdswx2HJq41SFDunw
	 tp9d1bMowoRqFB2pGGhWaXrg0gYPIuylimEO/Y4KM6D/QacDl30RRhJEB5GiwcabN9
	 Ssiw7nIo+0Nv5GW7xOqjM1l97LY53kwzg0jjOTG1v/ogYXq2SqWJGxJBKJw167UeMX
	 HznMsvXXYfE/88muwfee8iKIV//EnkoW7JrK5t4zyH0gmAQbtegAfkonmgEJXVJ0o7
	 8rilVnd0zoxFX7VUES0J49ZqXen8rhyDO+FqOKwCMk13zualcvkuGkmf0wWSm6xxpc
	 9KjhmkqNDIATQ==
Date: Tue, 17 Mar 2026 16:06:40 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: vidyas@nvidia.com, bhelgaas@google.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: clarification: PCI device not getting enumerated
Message-ID: <20260317210640.GA84423@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <abkqm_LCd9zAM8cW@rkannoth-OptiPlex-7090>

On Tue, Mar 17, 2026 at 03:49:07PM +0530, Ratheesh Kannoth wrote:
> Hi,
> 
> Below commit breaks PCI enumeration of a marvell PCI endpoint (177d:a0e2).
> I am not familiar with PCI code, could you please help in debugging/fixing this ?
> 
> Before the commit, the kernel set PCI_REASSIGN_ALL_BUS. So pcibios_assign_all_busses() was true,
> and in pci_scan_bridge_extend() the kernel took the “reassign” path and used EA
> (and pci_ea_fixed_busnrs()) to assign bus numbers.
> 
> commit 7246a4520b4bf1494d7d030166a11b5226f6d508
> Author: Vidya Sagar <vidyas@nvidia.com>
> Date:   Wed May 8 23:11:38 2024 +0530
> 
>     PCI: Use preserve_config in place of pci_flags
> 
>     Use preserve_config in place of checking for PCI_PROBE_ONLY flag to enable
>     support for "linux,pci-probe-only" on a per host bridge basis.
> 
>     This also obviates the use of adding PCI_REASSIGN_ALL_BUS flag if
>     !PCI_PROBE_ONLY, as pci_assign_unassigned_root_bus_resources() takes care
>     of reassigning the resources that are not already claimed.

This commit appeared in v6.11.  Apparently on v6.6, 0002:1b:00.0 is
detected, and in the v6.12 dmesg below, we don't enumerate it.

It looks like 7246a4520b4b can still be reverted cleanly from
v7.0-rc1.  Can you collect the complete dmesg logs from v7.0-rc1
(where I assume we won't see 0002:1b:00.0) and from v7.0-rc1 with
7246a4520b4b reverted (where I assume we *will* see it) and output of
"sudo lspci -vv"?  Use the same kernel config and DT for both, of
course.

I don't understand some of the v6.12 dmesg log:

  3.187193] pci-host-generic 878000000000.pci: Memory resource size exceeds max for 32 bits
  3.313087] pci 0000:00:01.0: PCI bridge to [bus 01] (subtractive decode)
  3.319878] pci 0000:00:01.0:   bridge window [mem 0x00000000-0x000fffff]
  3.723673] pci 0000:01:00.0: [177d:a075] type 00 class 0x088000 PCIe Endpoint
  3.730924] pci 0000:01:00.0: BAR 0 [mem 0x87e0fc000000-0x87e0fc03ffff 64bit]: from Enhanced Allocation, properties 0x0
  3.741710] pci 0000:01:00.0: BAR 4 [mem 0x87e0fcf00000-0x87e0fcffffff 64bit]: from Enhanced Allocation, properties 0x0

  3.448655] pci 0000:00:0c.0: PCI bridge to [bus 02] (subtractive decode)
  3.455454] pci 0000:00:0c.0:   bridge window [mem 0x00000000-0x000fffff]
  4.425308] pci 0000:02:00.0: [177d:a075] type 00 class 0x088000 PCIe Endpoint
  4.432561] pci 0000:02:00.0: BAR 0 [mem 0x87e0f9000000-0x87e0f903ffff 64bit]: from Enhanced Allocation, properties 0x0

  5.744082] pci-host-generic 878020000000.pci: Memory resource size exceeds max for 32 bits
  5.799532] pci 0002:00:00.0: PCI bridge to [bus fa] (subtractive decode)
  5.806322] pci 0002:00:00.0:   bridge window [mem 0x00000000-0x000fffff]
  5.820632] pci 0002:00:01.0: PCI bridge to [bus fb] (subtractive decode)
  5.827423] pci 0002:00:01.0:   bridge window [mem 0x00000000-0x000fffff]

- The "Memory resource size exceeds max for 32 bits" warnings are
  interesting.  Is this a DT error?

- There should only be one subtractive decode bridge per segment, but
  there are many here.

- Most of the bridge windows look uninitialized ([mem
  0x00000000-0x000fffff]), and we don't seem to reassign them, so BARs
  of the downstream devices shouldn't be reachable.

- Interesting to see so much "Enhanced Allocation"; that's very
  unusual.

- I guess your DT must have "linux,pci-probe-only"; seems like that
  might be something we should mention in dmesg for debugging
  purposes.

> --
> device on 6.6x kernel (before the commit) is enumerated.
> 
> lspci -s 0002:1b:00.0 -vv
> 0002:1b:00.0 Ethernet controller: Cavium, Inc. Device a0e2 (rev 54)
>         Subsystem: Cavium, Inc. Device b900
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 0
>         Region 2: [virtual] Memory at 85a200000000 (32-bit, non-prefetchable) [size=32M]
>         Region 4: [virtual] Memory at 9fd200000 (32-bit, non-prefetchable) [size=512K]
>         Capabilities: [40] Express (v2) Endpoint, MSI 00
>                 DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
>                         ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
>                 DevCtl: Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
>                         RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop- FLReset-
>                         MaxPayload 128 bytes, MaxReadReq 128 bytes
>                 DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
>                 LnkCap: Port #0, Speed unknown, Width x0, ASPM not supported, Exit Latency L0s <64ns, L1 <1us
>                         ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
>                 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk-
>                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>                 LnkSta: Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
>                 DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, OBFF Not Supported
>                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
>                 LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
>                          Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
>                          Compliance De-emphasis: -6dB
>                 LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
>                          EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
>         Capabilities: [80] MSI-X: Enable- Count=256 Masked-
>                 Vector table: BAR=2 offset=00080000
>                 PBA: BAR=2 offset=000f0000
>         Capabilities: [98] #14 [0004]
>         Capabilities: [100 v1] Vendor Specific Information: ID=00a0 Rev=2 Len=040 <?>
>         Capabilities: [140 v1] Advanced Error Reporting
>                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>                 UESvrt: DLP+ SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP+ ECRC- UnsupReq- ACSViol-
>                 CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
>                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
>                 AERCap: First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
>         Capabilities: [170 v1] Alternative Routing-ID Interpretation (ARI)
>                 ARICap: MFVC- ACS-, Next Function: 0
>                 ARICtl: MFVC- ACS-, Function Group: 0
>         Capabilities: [180 v1] Single Root I/O Virtualization (SR-IOV)
>                 IOVCap: Migration-, Interrupt Message Number: 000
>                 IOVCtl: Enable- Migration- Interrupt- MSE+ ARIHierarchy+
>                 IOVSta: Migration-
>                 Initial VFs: 0, Total VFs: 0, Number of VFs: 0, Function Dependency Link: 00
>                 VF offset: 1, stride: 1, Device ID: a000
>                 Supported Page Size: 00000553, System Page Size: 00000100
>                 VF Migration: offset: 00000000, BIR: 0
> 
> ---
> dmesg on 6.12x.  i checked on mainline kernel as well, and this issue persist.
> 
> Starting kernel ...
> 
>     0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd490]
>     0.000000] Linux version 6.12.51-g23c6ce8eaa46 (rkannoth@rkannoth-OptiPlex-7090) (aarch64-marvell-linux-gnu-gcc (Marvell Inc. Version: Marvell GCC12 build 12006.0) 12.2.0, GNU ld (Marvell Inc. Version: Marvell GCC12 build 12006.0) 2.38.50) #25 SMP PREEMPT Fri Mar 13 10:24:19 IST 2026
>     0.000000] Machine model: Marvell CN106XX board
>     0.000000] earlycon: pl11 at MMIO 0x000087e028000000 (options '')
>     0.000000] printk: legacy bootconsole [pl11] enabled
>     0.000000] efi: UEFI not found.
>     0.000000] OF: reserved mem: 0x0000000020060000..0x000000002007c0ff (112 KiB) nomap non-reusable pci-console-nexus
>     0.000000] OF: reserved mem: 0x00000009fbf00000..0x00000009fbffffff (1024 KiB) nomap non-reusable ghes-hest@00000009fbf00000
>     0.000000] OF: reserved mem: 0x00000009f7b00000..0x00000009fbefffff (69632 KiB) nomap non-reusable pem0-rsvd-mem@00000009f7b00000
>     0.000000] OF: reserved mem: 0x00000009f7afe000..0x00000009f7afffff (8 KiB) nomap non-reusable ghes-bert@00000009f7afe000
>     0.000000] NODE_DATA(0) allocated [mem 0x9f5557400-0x9f555963f]
>     0.000000] Zone ranges:
>     0.000000]   DMA      [mem 0x0000000004000000-0x00000000ffffffff]
>     0.000000]   DMA32    empty
>     0.000000]   Normal   [mem 0x0000000100000000-0x00000009f7aeffff]
>     0.000000] Movable zone start for each node
>     0.000000] Early memory node ranges
>     0.000000]   node   0: [mem 0x0000000004000000-0x000000002005ffff]
>     0.000000]   node   0: [mem 0x0000000020060000-0x000000002006ffff]
>     0.000000]   node   0: [mem 0x0000000020080000-0x00000009f7aeffff]
>     0.000000] Initmem setup node 0 [mem 0x0000000004000000-0x00000009f7aeffff]
>     0.000000] On node 0, zone DMA: 1024 pages in unavailable ranges
>     0.000000] On node 0, zone DMA: 1 pages in unavailable ranges
>     0.000000] On node 0, zone Normal: 2129 pages in unavailable ranges
>     0.000000] kasan: KernelAddressSanitizer initialized (generic)
>     0.000000] psci: probing for conduit method from DT.
>     0.000000] psci: PSCIv1.1 detected in firmware.
>     0.000000] psci: Using standard PSCI v0.2 function IDs
>     0.000000] psci: Trusted OS resident on physical CPU 0x0
>     0.000000] psci: SMC Calling Convention v1.2
>     0.000000] percpu: Embedded 10 pages/cpu s613208 r8192 d33960 u655360
>     0.000000] Detected PIPT I-cache on CPU0
>     0.000000] CPU features: detected: Address authentication (architected QARMA5 algorithm)
>     0.000000] CPU features: detected: GIC system register CPU interface
>     0.000000] CPU features: detected: Virtualization Host Extensions
>     0.000000] CPU features: detected: Spectre-v4
>     0.000000] CPU features: detected: Spectre-BHB
>     0.000000] CPU features: detected: ARM erratum 2067961 or 2054223
>     0.000000] CPU features: detected: SSBS not fully self-synchronizing
>     0.000000] alternatives: applying boot alternatives
>     0.000000] Kernel command line: console=ttyAMA0,115200n8 earlycon=pl011,0x87e028000000 maxcpus=4 rootwait rw root=/dev/mmcblk0p2
>     0.000000] random: crng init done
>     0.000000] printk: log_buf_len individual max cpu contribution: 8192 bytes
>     0.000000] printk: log_buf_len total cpu_extra contributions: 188416 bytes
>     0.000000] printk: log_buf_len min size: 65536 bytes
>     0.000000] printk: log_buf_len: 262144 bytes
>     0.000000] printk: early log buf free: 62120(94%)
>     0.000000] Dentry cache hash table entries: 8388608 (order: 10, 67108864 bytes, linear)
>     0.000000] Inode-cache hash table entries: 4194304 (order: 9, 33554432 bytes, linear)
>     0.000000] Fallback order for Node 0: 0
>     0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 652206
>     0.000000] Policy zone: Normal
>     0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
>     0.000000] stackdepot: allocating hash table via alloc_large_system_hash
>     0.000000] stackdepot hash table entries: 1048576 (order: 8, 16777216 bytes, linear)
>     0.000000] software IO TLB: area num 32.
>     0.000000] software IO TLB: mapped [mem 0x00000000fbff0000-0x00000000ffff0000] (64MB)
>     0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=24, Nodes=1
>     0.000000] rcu: Preemptible hierarchical RCU implementation.
>     0.000000] rcu: RCU event tracing is enabled.
>     0.000000] rcu: RCU restricting CPUs from NR_CPUS=96 to nr_cpu_ids=24.
>     0.000000] Trampoline variant of Tasks RCU enabled.
>     0.000000] Tracing variant of Tasks RCU enabled.
>     0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
>     0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=24
>     0.000000] RCU Tasks: Setting shift to 5 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=24.
>     0.000000] RCU Tasks Trace: Setting shift to 5 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=24.
>     0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
>     0.000000] GICv3: GIC: Using split EOI/Deactivate mode
>     0.000000] GIC: enabling workaround for GICv3: ARM64 erratum 2941627
>     0.000000] GICv3: 512 SPIs implemented
>     0.000000] GICv3: 0 Extended SPIs implemented
>     0.000000] Root IRQ handler: gic_handle_irq
>     0.000000] GICv3: GICv3 features: 48 PPIs, DirectLPI
>     0.000000] GICv3: GICv4 features: DirectLPI RVPEID Valid+Dirty
>     0.000000] GICv3: GICD_CTRL.DS=0, SCR_EL3.FIQ=1
>     0.000000] GICv3: CPU0: found redistributor 0 region 0:0x0000801000300000
>     0.000000] ITS [mem 0x801000040000-0x80100007ffff]
>     0.000000] ITS@0x0000801000040000: Single VMOVP capable
>     0.000000] ITS@0x0000801000040000: Using GICv4.1 mode 00000000 00000001
>     0.000000] ITS@0x0000801000040000: allocated 8192 Devices @1004f0000 (indirect, esz 8, psz 64K, shr 1)
>     0.000000] ITS@0x0000801000040000: allocated 32768 Interrupt Collections @100500000 (flat, esz 2, psz 64K, shr 1)
>     0.000000] ITS@0x0000801000040000: allocated 8192 Virtual CPUs @100510000 (flat, esz 8, psz 64K, shr 1)
>     0.000000] GICv3: using LPI property table @0x0000000100520000
>     0.000000] ITS: Using DirectLPI for VPE invalidation
>     0.000000] ITS: Enabling GICv4 support
>     0.000000] GICv3: CPU0: using allocated LPI pending table @0x0000000100530000
>     0.000000] rcu: srcu_init: Setting srcu_struct sizes based on contention.
>     0.000000] arch_timer: cp15 timer(s) running at 1000.00MHz (phys).
>     0.000000] clocksource: arch_sys_counter: mask: 0x1fffffffffffffff max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
>     0.000000] sched_clock: 61 bits at 1000MHz, resolution 1ns, wraps every 4398046511103ns
>     0.008875] kfence: initialized - using 33554432 bytes for 255 objects at 0x(____ptrval____)-0x(____ptrval____)
>     0.019417] Console: colour dummy device 80x25
>     0.024041] Calibrating delay loop (skipped), value calculated using timer frequency.. 2000.00 BogoMIPS (lpj=4000000)
>     0.034937] pid_max: default: 32768 minimum: 301
>     0.039750] LSM: initializing lsm=capability
>     0.044235] Mount-cache hash table entries: 131072 (order: 4, 1048576 bytes, linear)
>     0.052210] Mountpoint-cache hash table entries: 131072 (order: 4, 1048576 bytes, linear)
>     0.064764] rcu: Hierarchical SRCU implementation.
>     0.069682] rcu: Max phase no-delay instances is 1000.
>     0.075145] Timer migration: 2 hierarchy levels; 8 children per group; 2 crossnode level
>     0.084479] EFI services will not be available.
>     0.089594] smp: Bringing up secondary CPUs ...
>     0.094568] Detected PIPT I-cache on CPU1
>     0.094874] GICv3: CPU1: found redistributor 10000 region 0:0x0000801000400000
>     0.094885] GICv3: CPU1: using allocated LPI pending table @0x0000000100540000
>     0.094906] CPU1: Booted secondary processor 0x0000010000 [0x410fd490]
>     0.095326] Detected PIPT I-cache on CPU2
>     0.095620] GICv3: CPU2: found redistributor 20000 region 0:0x00008010002c0000
>     0.095632] GICv3: CPU2: using allocated LPI pending table @0x0000000100550000
>     0.095655] CPU2: Booted secondary processor 0x0000020000 [0x410fd490]
>     0.096082] Detected PIPT I-cache on CPU3
>     0.096370] GICv3: CPU3: found redistributor 30000 region 0:0x00008010003c0000
>     0.096382] GICv3: CPU3: using allocated LPI pending table @0x0000000100560000
>     0.096405] CPU3: Booted secondary processor 0x0000030000 [0x410fd490]
>     0.096521] smp: Brought up 1 node, 4 CPUs
>     0.177587] SMP: Total of 4 processors activated.
>     0.182407] CPU: All CPU(s) started at EL2
>     0.186615] CPU features: detected: Branch Target Identification
>     0.192776] CPU features: detected: 32-bit EL0 Support
>     0.198053] CPU features: detected: ARMv8.4 Translation Table Level
>     0.204481] CPU features: detected: Instruction cache invalidation not required for I/D coherence
>     0.213588] CPU features: detected: Data cache clean to the PoU not required for I/D coherence
>     0.222436] CPU features: detected: Common not Private translations
>     0.228868] CPU features: detected: CRC32 instructions
>     0.234138] CPU features: detected: Data cache clean to Point of Deep Persistence
>     0.241818] CPU features: detected: Data cache clean to Point of Persistence
>     0.249046] CPU features: detected: Data independent timing control (DIT)
>     0.256011] CPU features: detected: E0PD
>     0.260030] CPU features: detected: Enhanced Virtualization Traps
>     0.266281] CPU features: detected: Generic authentication (architected QARMA5 algorithm)
>     0.274668] CPU features: detected: RCpc load-acquire (LDAPR)
>     0.280555] CPU features: detected: LSE atomic instructions
>     0.286274] CPU features: detected: Privileged Access Never
>     0.291995] CPU features: detected: RAS Extension Support
>     0.297532] CPU features: detected: Random Number Generator
>     0.303247] CPU features: detected: Speculation barrier (SB)
>     0.309051] CPU features: detected: Stage-2 Force Write-Back
>     0.314848] CPU features: detected: TLB range maintenance instructions
>     0.321540] CPU features: detected: Memory Partitioning And Monitoring
>     0.328234] CPU features: detected: Memory Partitioning And Monitoring Virtualisation
>     0.336264] CPU features: detected: Speculative Store Bypassing Safe (SSBS)
>     0.343407] CPU features: detected: Scalable Vector Extension
>     0.349321] alternatives: applying system-wide alternatives
>     0.357590] CPU features: detected: Activity Monitors Unit (AMU) on CPU0-3
>     0.364652] CPU features: detected: Hardware dirty bit management on CPU0-3
>     0.371798] SVE: maximum available vector length 16 bytes per vector
>     0.378315] SVE: default vector length 16 bytes per vector
>     0.384242] Memory: 36127616K/41741184K available (35584K kernel code, 13538K rwdata, 15616K rodata, 19456K init, 1470K bss, 5593728K reserved, 0K cma-reserved)
>     0.399541] devtmpfs: initialized
>     0.427209] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
>     0.437213] futex hash table entries: 8192 (order: 3, 524288 bytes, linear)
>     0.444611] 695 pages in range for non-PLT usage
>     0.444615] 31415 pages in range for PLT usage
>     0.449413] pinctrl core: initialized pinctrl subsystem
>     0.459792] DMI not present or invalid.
>     0.465840] NET: Registered PF_NETLINK/PF_ROUTE protocol family
>     0.472615] DMA: preallocated 8192 KiB GFP_KERNEL pool for atomic allocations
>     0.480206] DMA: preallocated 8192 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
>     0.488505] DMA: preallocated 8192 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
>     0.496757] audit: initializing netlink subsys (disabled)
>     0.502397] audit: type=2000 audit(0.308:1): state=initialized audit_enabled=0 res=1
>     0.502858] thermal_sys: Registered thermal governor 'step_wise'
>     0.510398] cpuidle: using governor ladder
>     0.520782] cpuidle: using governor menu
>     0.524906] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
>     0.531925] ASID allocator initialised with 65536 entries
>     0.537629] Serial: AMBA PL011 UART driver
>     0.542914] sdei: SDEIv1.0 (0x0) detected in firmware.
>     0.552475] /soc@0/ete0: Fixed dependency cycle(s) with /soc@0/etf0@87a004010000
>     0.560099] /soc@0/etf0@87a004010000: Fixed dependency cycle(s) with /soc@0/st_funnel
>     0.568134] /soc@0/etf0@87a004010000: Fixed dependency cycle(s) with /soc@0/ete0
>     0.575755] /soc@0/ete1: Fixed dependency cycle(s) with /soc@0/etf1@87a004110000
>     0.583367] /soc@0/etf1@87a004110000: Fixed dependency cycle(s) with /soc@0/st_funnel
>     0.591408] /soc@0/etf1@87a004110000: Fixed dependency cycle(s) with /soc@0/ete1
>     0.599023] /soc@0/ete2: Fixed dependency cycle(s) with /soc@0/etf2@87a004210000
>     0.606641] /soc@0/etf2@87a004210000: Fixed dependency cycle(s) with /soc@0/st_funnel
>     0.614676] /soc@0/etf2@87a004210000: Fixed dependency cycle(s) with /soc@0/ete2
>     0.622292] /soc@0/ete3: Fixed dependency cycle(s) with /soc@0/etf3@87a004310000
>     0.629914] /soc@0/etf3@87a004310000: Fixed dependency cycle(s) with /soc@0/st_funnel
>     0.637957] /soc@0/etf3@87a004310000: Fixed dependency cycle(s) with /soc@0/ete3
>     0.645574] /soc@0/ete4: Fixed dependency cycle(s) with /soc@0/etf4@87a004410000
>     0.653184] /soc@0/etf4@87a004410000: Fixed dependency cycle(s) with /soc@0/st_funnel
>     0.661224] /soc@0/etf4@87a004410000: Fixed dependency cycle(s) with /soc@0/ete4
>     0.668843] /soc@0/ete5: Fixed dependency cycle(s) with /soc@0/etf5@87a004510000
>     0.676455] /soc@0/etf5@87a004510000: Fixed dependency cycle(s) with /soc@0/st_funnel
>     0.684492] /soc@0/etf5@87a004510000: Fixed dependency cycle(s) with /soc@0/ete5
>     0.692117] /soc@0/ete6: Fixed dependency cycle(s) with /soc@0/etf6@87a004610000
>     0.699730] /soc@0/etf6@87a004610000: Fixed dependency cycle(s) with /soc@0/st_funnel
>     0.707762] /soc@0/etf6@87a004610000: Fixed dependency cycle(s) with /soc@0/ete6
>     0.715373] /soc@0/ete7: Fixed dependency cycle(s) with /soc@0/etf7@87a004710000
>     0.722991] /soc@0/etf7@87a004710000: Fixed dependency cycle(s) with /soc@0/st_funnel
>     0.731024] /soc@0/etf7@87a004710000: Fixed dependency cycle(s) with /soc@0/ete7
>     0.738640] /soc@0/ete8: Fixed dependency cycle(s) with /soc@0/etf8@87a004810000
>     0.746254] /soc@0/etf8@87a004810000: Fixed dependency cycle(s) with /soc@0/st_funnel
>     0.754290] /soc@0/etf8@87a004810000: Fixed dependency cycle(s) with /soc@0/ete8
>     0.761906] /soc@0/ete9: Fixed dependency cycle(s) with /soc@0/etf9@87a004910000
>     0.769525] /soc@0/etf9@87a004910000: Fixed dependency cycle(s) with /soc@0/st_funnel
>     0.777566] /soc@0/etf9@87a004910000: Fixed dependency cycle(s) with /soc@0/ete9
>     0.785184] /soc@0/ete10: Fixed dependency cycle(s) with /soc@0/etf10@87a004a10000
>     0.792975] /soc@0/etf10@87a004a10000: Fixed dependency cycle(s) with /soc@0/st_funnel
>     0.801103] /soc@0/etf10@87a004a10000: Fixed dependency cycle(s) with /soc@0/ete10
>     0.808896] /soc@0/ete11: Fixed dependency cycle(s) with /soc@0/etf11@87a004b10000
>     0.816687] /soc@0/etf11@87a004b10000: Fixed dependency cycle(s) with /soc@0/st_funnel
>     0.824813] /soc@0/etf11@87a004b10000: Fixed dependency cycle(s) with /soc@0/ete11
>     0.832604] /soc@0/ete12: Fixed dependency cycle(s) with /soc@0/etf12@87a004c10000
>     0.840394] /soc@0/etf12@87a004c10000: Fixed dependency cycle(s) with /soc@0/st_funnel
>     0.848522] /soc@0/etf12@87a004c10000: Fixed dependency cycle(s) with /soc@0/ete12
>     0.856313] /soc@0/ete13: Fixed dependency cycle(s) with /soc@0/etf13@87a004d10000
>     0.864104] /soc@0/etf13@87a004d10000: Fixed dependency cycle(s) with /soc@0/st_funnel
>     0.872234] /soc@0/etf13@87a004d10000: Fixed dependency cycle(s) with /soc@0/ete13
>     0.880029] /soc@0/ete14: Fixed dependency cycle(s) with /soc@0/etf14@87a004e10000
>     0.887816] /soc@0/etf14@87a004e10000: Fixed dependency cycle(s) with /soc@0/st_funnel
>     0.895947] /soc@0/etf14@87a004e10000: Fixed dependency cycle(s) with /soc@0/ete14
>     0.903742] /soc@0/ete15: Fixed dependency cycle(s) with /soc@0/etf15@87a004f10000
>     0.911533] /soc@0/etf15@87a004f10000: Fixed dependency cycle(s) with /soc@0/st_funnel
>     0.919660] /soc@0/etf15@87a004f10000: Fixed dependency cycle(s) with /soc@0/ete15
>     0.927455] /soc@0/ete16: Fixed dependency cycle(s) with /soc@0/etf16@87a005010000
>     0.935242] /soc@0/etf16@87a005010000: Fixed dependency cycle(s) with /soc@0/st_funnel
>     0.943373] /soc@0/etf16@87a005010000: Fixed dependency cycle(s) with /soc@0/ete16
>     0.951165] /soc@0/ete17: Fixed dependency cycle(s) with /soc@0/etf17@87a005110000
>     0.958954] /soc@0/etf17@87a005110000: Fixed dependency cycle(s) with /soc@0/st_funnel
>     0.967078] /soc@0/etf17@87a005110000: Fixed dependency cycle(s) with /soc@0/ete17
>     0.974870] /soc@0/ete18: Fixed dependency cycle(s) with /soc@0/etf18@87a005210000
>     0.982658] /soc@0/etf18@87a005210000: Fixed dependency cycle(s) with /soc@0/st_funnel
>     0.990784] /soc@0/etf18@87a005210000: Fixed dependency cycle(s) with /soc@0/ete18
>     0.998582] /soc@0/ete19: Fixed dependency cycle(s) with /soc@0/etf19@87a005310000
>     1.006369] /soc@0/etf19@87a005310000: Fixed dependency cycle(s) with /soc@0/st_funnel
>     1.014497] /soc@0/etf19@87a005310000: Fixed dependency cycle(s) with /soc@0/ete19
>     1.022286] /soc@0/ete20: Fixed dependency cycle(s) with /soc@0/etf20@87a005410000
>     1.030076] /soc@0/etf20@87a005410000: Fixed dependency cycle(s) with /soc@0/st_funnel
>     1.038205] /soc@0/etf20@87a005410000: Fixed dependency cycle(s) with /soc@0/ete20
>     1.045998] /soc@0/ete21: Fixed dependency cycle(s) with /soc@0/etf21@87a005510000
>     1.053786] /soc@0/etf21@87a005510000: Fixed dependency cycle(s) with /soc@0/st_funnel
>     1.061908] /soc@0/etf21@87a005510000: Fixed dependency cycle(s) with /soc@0/ete21
>     1.069703] /soc@0/ete22: Fixed dependency cycle(s) with /soc@0/etf22@87a005610000
>     1.077498] /soc@0/etf22@87a005610000: Fixed dependency cycle(s) with /soc@0/st_funnel
>     1.085619] /soc@0/etf22@87a005610000: Fixed dependency cycle(s) with /soc@0/ete22
>     1.093409] /soc@0/ete23: Fixed dependency cycle(s) with /soc@0/etf23@87a005710000
>     1.101206] /soc@0/etf23@87a005710000: Fixed dependency cycle(s) with /soc@0/st_funnel
>     1.109330] /soc@0/etf23@87a005710000: Fixed dependency cycle(s) with /soc@0/ete23
>     1.117101] /soc@0/st_funnel: Fixed dependency cycle(s) with /soc@0/etf23@87a005710000
>     1.125233] /soc@0/st_funnel: Fixed dependency cycle(s) with /soc@0/etf22@87a005610000
>     1.133361] /soc@0/st_funnel: Fixed dependency cycle(s) with /soc@0/etf21@87a005510000
>     1.141489] /soc@0/st_funnel: Fixed dependency cycle(s) with /soc@0/etf20@87a005410000
>     1.149612] /soc@0/st_funnel: Fixed dependency cycle(s) with /soc@0/etf19@87a005310000
>     1.157737] /soc@0/st_funnel: Fixed dependency cycle(s) with /soc@0/etf18@87a005210000
>     1.165859] /soc@0/st_funnel: Fixed dependency cycle(s) with /soc@0/etf17@87a005110000
>     1.173981] /soc@0/st_funnel: Fixed dependency cycle(s) with /soc@0/etf16@87a005010000
>     1.182113] /soc@0/st_funnel: Fixed dependency cycle(s) with /soc@0/etf15@87a004f10000
>     1.190239] /soc@0/st_funnel: Fixed dependency cycle(s) with /soc@0/etf14@87a004e10000
>     1.198366] /soc@0/st_funnel: Fixed dependency cycle(s) with /soc@0/etf13@87a004d10000
>     1.206496] /soc@0/st_funnel: Fixed dependency cycle(s) with /soc@0/etf12@87a004c10000
>     1.214624] /soc@0/st_funnel: Fixed dependency cycle(s) with /soc@0/etf11@87a004b10000
>     1.222750] /soc@0/st_funnel: Fixed dependency cycle(s) with /soc@0/etf10@87a004a10000
>     1.230869] /soc@0/st_funnel: Fixed dependency cycle(s) with /soc@0/etf9@87a004910000
>     1.238906] /soc@0/st_funnel: Fixed dependency cycle(s) with /soc@0/etf8@87a004810000
>     1.246938] /soc@0/st_funnel: Fixed dependency cycle(s) with /soc@0/etf7@87a004710000
>     1.254970] /soc@0/st_funnel: Fixed dependency cycle(s) with /soc@0/etf6@87a004610000
>     1.263011] /soc@0/st_funnel: Fixed dependency cycle(s) with /soc@0/etf5@87a004510000
>     1.271049] /soc@0/st_funnel: Fixed dependency cycle(s) with /soc@0/etf4@87a004410000
>     1.279083] /soc@0/st_funnel: Fixed dependency cycle(s) with /soc@0/etf3@87a004310000
>     1.287124] /soc@0/st_funnel: Fixed dependency cycle(s) with /soc@0/etf2@87a004210000
>     1.295159] /soc@0/st_funnel: Fixed dependency cycle(s) with /soc@0/etf1@87a004110000
>     1.303192] /soc@0/st_funnel: Fixed dependency cycle(s) with /soc@0/etf0@87a004010000
>     1.311227] /soc@0/st_funnel: Fixed dependency cycle(s) with /soc@0/sh_etf@87a100050000
>     1.319458] /soc@0/sh_etf@87a100050000: Fixed dependency cycle(s) with /soc@0/sh_etr@87a100060000
>     1.328586] /soc@0/sh_etf@87a100050000: Fixed dependency cycle(s) with /soc@0/st_funnel
>     1.336823] /soc@0/sh_etr@87a100060000: Fixed dependency cycle(s) with /soc@0/sh_etf@87a100050000
>     1.346684] 87e028000000.serial: ttyAMA0 at MMIO 0x87e028000000 (irq = 14, base_baud = 0) is a PL011 rev3
>     1.356527] printk: legacy console [ttyAMA0] enabled
>     1.356527] printk: legacy console [ttyAMA0] enabled
>     1.366591] printk: legacy bootconsole [pl11] disabled
>     1.366591] printk: legacy bootconsole [pl11] disabled
>     1.382146] 87e029000000.serial: ttyAMA1 at MMIO 0x87e029000000 (irq = 15, base_baud = 0) is a PL011 rev3
>     1.392478] 87e02a000000.serial: ttyAMA2 at MMIO 0x87e02a000000 (irq = 16, base_baud = 0) is a PL011 rev3
>     1.402748] 87e02b000000.serial: ttyAMA3 at MMIO 0x87e02b000000 (irq = 17, base_baud = 0) is a PL011 rev3
>     1.413058] 87e02c000000.serial: ttyAMA4 at MMIO 0x87e02c000000 (irq = 18, base_baud = 0) is a PL011 rev3
>     1.423341] 87e02d000000.serial: ttyAMA5 at MMIO 0x87e02d000000 (irq = 19, base_baud = 0) is a PL011 rev3
>     1.433635] 87e02e000000.serial: ttyAMA6 at MMIO 0x87e02e000000 (irq = 20, base_baud = 0) is a PL011 rev3
>     1.443934] 87e02f000000.serial: ttyAMA7 at MMIO 0x87e02f000000 (irq = 21, base_baud = 0) is a PL011 rev3
>     1.454489] /soc@0/ete0: Fixed dependency cycle(s) with /soc@0/etf0@87a004010000
>     1.462041] /soc@0/ete0: Fixed dependency cycle(s) with /soc@0/etf0@87a004010000
>     1.469532] /soc@0/etf0@87a004010000: Fixed dependency cycle(s) with /soc@0/st_funnel
>     1.477365] /soc@0/etf0@87a004010000: Fixed dependency cycle(s) with /soc@0/ete0
>     1.485100] /soc@0/ete1: Fixed dependency cycle(s) with /soc@0/etf1@87a004110000
>     1.492616] /soc@0/ete1: Fixed dependency cycle(s) with /soc@0/etf1@87a004110000
>     1.500100] /soc@0/etf1@87a004110000: Fixed dependency cycle(s) with /soc@0/st_funnel
>     1.507931] /soc@0/etf1@87a004110000: Fixed dependency cycle(s) with /soc@0/ete1
>     1.515630] /soc@0/ete2: Fixed dependency cycle(s) with /soc@0/etf2@87a004210000
>     1.523140] /soc@0/ete2: Fixed dependency cycle(s) with /soc@0/etf2@87a004210000
>     1.530625] /soc@0/etf2@87a004210000: Fixed dependency cycle(s) with /soc@0/st_funnel
>     1.538456] /soc@0/etf2@87a004210000: Fixed dependency cycle(s) with /soc@0/ete2
>     1.546161] /soc@0/ete3: Fixed dependency cycle(s) with /soc@0/etf3@87a004310000
>     1.553671] /soc@0/ete3: Fixed dependency cycle(s) with /soc@0/etf3@87a004310000
>     1.561145] /soc@0/etf3@87a004310000: Fixed dependency cycle(s) with /soc@0/st_funnel
>     1.568987] /soc@0/etf3@87a004310000: Fixed dependency cycle(s) with /soc@0/ete3
>     1.576706] /soc@0/ete4: Fixed dependency cycle(s) with /soc@0/etf4@87a004410000
>     1.584319] /soc@0/ete5: Fixed dependency cycle(s) with /soc@0/etf5@87a004510000
>     1.591902] /soc@0/ete6: Fixed dependency cycle(s) with /soc@0/etf6@87a004610000
>     1.599474] /soc@0/ete7: Fixed dependency cycle(s) with /soc@0/etf7@87a004710000
>     1.607044] /soc@0/ete8: Fixed dependency cycle(s) with /soc@0/etf8@87a004810000
>     1.614633] /soc@0/ete9: Fixed dependency cycle(s) with /soc@0/etf9@87a004910000
>     1.622205] /soc@0/ete10: Fixed dependency cycle(s) with /soc@0/etf10@87a004a10000
>     1.629975] /soc@0/ete11: Fixed dependency cycle(s) with /soc@0/etf11@87a004b10000
>     1.637722] /soc@0/ete12: Fixed dependency cycle(s) with /soc@0/etf12@87a004c10000
>     1.645477] /soc@0/ete13: Fixed dependency cycle(s) with /soc@0/etf13@87a004d10000
>     1.653221] /soc@0/ete14: Fixed dependency cycle(s) with /soc@0/etf14@87a004e10000
>     1.660965] /soc@0/ete15: Fixed dependency cycle(s) with /soc@0/etf15@87a004f10000
>     1.668706] /soc@0/ete16: Fixed dependency cycle(s) with /soc@0/etf16@87a005010000
>     1.676451] /soc@0/ete17: Fixed dependency cycle(s) with /soc@0/etf17@87a005110000
>     1.684246] /soc@0/ete18: Fixed dependency cycle(s) with /soc@0/etf18@87a005210000
>     1.692020] /soc@0/ete19: Fixed dependency cycle(s) with /soc@0/etf19@87a005310000
>     1.699762] /soc@0/ete20: Fixed dependency cycle(s) with /soc@0/etf20@87a005410000
>     1.707507] /soc@0/ete21: Fixed dependency cycle(s) with /soc@0/etf21@87a005510000
>     1.715264] /soc@0/ete22: Fixed dependency cycle(s) with /soc@0/etf22@87a005610000
>     1.723007] /soc@0/ete23: Fixed dependency cycle(s) with /soc@0/etf23@87a005710000
>     1.730773] /soc@0/etf3@87a004310000: Fixed dependency cycle(s) with /soc@0/st_funnel
>     1.738686] /soc@0/etf2@87a004210000: Fixed dependency cycle(s) with /soc@0/st_funnel
>     1.746588] /soc@0/etf1@87a004110000: Fixed dependency cycle(s) with /soc@0/st_funnel
>     1.754489] /soc@0/etf0@87a004010000: Fixed dependency cycle(s) with /soc@0/st_funnel
>     1.762371] /soc@0/st_funnel: Fixed dependency cycle(s) with /soc@0/etf23@87a005710000
>     1.770290] /soc@0/st_funnel: Fixed dependency cycle(s) with /soc@0/etf22@87a005610000
>     1.778208] /soc@0/st_funnel: Fixed dependency cycle(s) with /soc@0/etf21@87a005510000
>     1.786126] /soc@0/st_funnel: Fixed dependency cycle(s) with /soc@0/etf20@87a005410000
>     1.794045] /soc@0/st_funnel: Fixed dependency cycle(s) with /soc@0/etf19@87a005310000
>     1.801966] /soc@0/st_funnel: Fixed dependency cycle(s) with /soc@0/etf18@87a005210000
>     1.809884] /soc@0/st_funnel: Fixed dependency cycle(s) with /soc@0/etf17@87a005110000
>     1.817807] /soc@0/st_funnel: Fixed dependency cycle(s) with /soc@0/etf16@87a005010000
>     1.825726] /soc@0/st_funnel: Fixed dependency cycle(s) with /soc@0/etf15@87a004f10000
>     1.833645] /soc@0/st_funnel: Fixed dependency cycle(s) with /soc@0/etf14@87a004e10000
>     1.841566] /soc@0/st_funnel: Fixed dependency cycle(s) with /soc@0/etf13@87a004d10000
>     1.849484] /soc@0/st_funnel: Fixed dependency cycle(s) with /soc@0/etf12@87a004c10000
>     1.857404] /soc@0/st_funnel: Fixed dependency cycle(s) with /soc@0/etf11@87a004b10000
>     1.865325] /soc@0/st_funnel: Fixed dependency cycle(s) with /soc@0/etf10@87a004a10000
>     1.873245] /soc@0/st_funnel: Fixed dependency cycle(s) with /soc@0/etf9@87a004910000
>     1.881099] /soc@0/st_funnel: Fixed dependency cycle(s) with /soc@0/etf8@87a004810000
>     1.888931] /soc@0/st_funnel: Fixed dependency cycle(s) with /soc@0/etf7@87a004710000
>     1.896775] /soc@0/st_funnel: Fixed dependency cycle(s) with /soc@0/etf6@87a004610000
>     1.904618] /soc@0/st_funnel: Fixed dependency cycle(s) with /soc@0/etf5@87a004510000
>     1.912459] /soc@0/st_funnel: Fixed dependency cycle(s) with /soc@0/etf4@87a004410000
>     1.920291] /soc@0/st_funnel: Fixed dependency cycle(s) with /soc@0/etf3@87a004310000
>     1.928216] /soc@0/st_funnel: Fixed dependency cycle(s) with /soc@0/etf2@87a004210000
>     1.936112] /soc@0/st_funnel: Fixed dependency cycle(s) with /soc@0/etf1@87a004110000
>     1.944008] /soc@0/st_funnel: Fixed dependency cycle(s) with /soc@0/etf0@87a004010000
>     1.951890] /soc@0/st_funnel: Fixed dependency cycle(s) with /soc@0/sh_etf@87a100050000
>     1.960022] /soc@0/st_funnel: Fixed dependency cycle(s) with /soc@0/sh_etf@87a100050000
>     1.968079] /soc@0/sh_etf@87a100050000: Fixed dependency cycle(s) with /soc@0/sh_etr@87a100060000
>     1.976972] /soc@0/sh_etf@87a100050000: Fixed dependency cycle(s) with /soc@0/st_funnel
>     1.985116] /soc@0/sh_etf@87a100050000: Fixed dependency cycle(s) with /soc@0/sh_etr@87a100060000
>     1.994059] /soc@0/sh_etr@87a100060000: Fixed dependency cycle(s) with /soc@0/sh_etf@87a100050000
>     2.004375] HugeTLB: registered 16.0 GiB page size, pre-allocated 0 pages
>     2.011174] HugeTLB: 0 KiB vmemmap can be freed for a 16.0 GiB page
>     2.017440] HugeTLB: registered 512 MiB page size, pre-allocated 0 pages
>     2.024138] HugeTLB: 0 KiB vmemmap can be freed for a 512 MiB page
>     2.030318] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
>     2.037104] HugeTLB: 0 KiB vmemmap can be freed for a 2.00 MiB page
>     2.109636] raid6: neonx8   gen()  1722 MB/s
>     2.181635] raid6: neonx4   gen()  1734 MB/s
>     2.253676] raid6: neonx2   gen()  1576 MB/s
>     2.325788] raid6: neonx1   gen()  1453 MB/s
>     2.397842] raid6: int64x8  gen()  1248 MB/s
>     2.469751] raid6: int64x4  gen()  1242 MB/s
>     2.542042] raid6: int64x2  gen()  1142 MB/s
>     2.613932] raid6: int64x1  gen()   914 MB/s
>     2.618200] raid6: using algorithm neonx4 gen() 1734 MB/s
>     2.689840] raid6: .... xor() 1230 MB/s, rmw enabled
>     2.694803] raid6: using neon recovery algorithm
>     2.699910] ACPI: Interpreter disabled.
>     2.704035] iommu: Default domain type: Translated
>     2.708826] iommu: DMA domain TLB invalidation policy: strict mode
>     2.715399] SCSI subsystem initialized
>     2.719508] usbcore: registered new interface driver usbfs
>     2.725055] usbcore: registered new interface driver hub
>     2.730417] usbcore: registered new device driver usb
>     2.735801] pps_core: LinuxPPS API ver. 1 registered
>     2.740766] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
>     2.749909] PTP clock support registered
>     2.754048] EDAC MC: Ver: 3.0.0
>     2.757424] scmi_core: SCMI protocol bus registered
>     2.771599] vgaarb: loaded
>     2.774535] clocksource: Switched to clocksource arch_sys_counter
>     2.782187] VFS: Disk quotas dquot_6.6.0
>     2.786169] VFS: Dquot-cache hash table entries: 8192 (order 0, 65536 bytes)
>     2.793626] pnp: PnP ACPI: disabled
>     2.802045] NET: Registered PF_INET protocol family
>     2.807044] IP idents hash table entries: 262144 (order: 5, 2097152 bytes, linear)
>     2.817629] MPAM enabled with 64 PARTIDs and 1 PMGs
>     2.822200] tcp_listen_portaddr_hash hash table entries: 32768 (order: 3, 524288 bytes, linear)
>     2.831481] Table-perturb hash table entries: 65536 (order: 2, 262144 bytes, linear)
>     2.839252] TCP established hash table entries: 524288 (order: 6, 4194304 bytes, linear)
>     2.849337] TCP bind hash table entries: 65536 (order: 5, 2097152 bytes, linear)
>     2.857699] TCP: Hash tables configured (established 524288 bind 65536)
>     2.864430] UDP hash table entries: 32768 (order: 4, 1048576 bytes, linear)
>     2.872124] UDP-Lite hash table entries: 32768 (order: 4, 1048576 bytes, linear)
>     2.880437] NET: Registered PF_UNIX/PF_LOCAL protocol family
>     2.886496] RPC: Registered named UNIX socket transport module.
>     2.892423] RPC: Registered udp transport module.
>     2.897127] RPC: Registered tcp transport module.
>     2.901829] RPC: Registered tcp-with-tls transport module.
>     2.907312] RPC: Registered tcp NFSv4.1 backchannel transport module.
>     2.914949] PCI: CLS 0 bytes, default 64
>     2.920980] Initialise system trusted keyrings
>     2.925542] workingset: timestamp_bits=42 max_order=20 bucket_order=0
>     2.932390] squashfs: version 4.0 (2009/01/31) Phillip Lougher
>     2.938478] NFS: Registering the id_resolver key type
>     2.943543] Key type id_resolver registered
>     2.947726] Key type id_legacy registered
>     2.951748] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
>     2.958457] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver Registering...
>     2.965924] jffs2: version 2.2. (NAND)  2001-2006 Red Hat, Inc.
>     2.972185] SGI XFS with security attributes, no debug enabled
>     2.978421] 9p: Installing v9fs 9p2000 file system support
>     3.022327] NET: Registered PF_ALG protocol family
>     3.027135] xor: measuring software checksum speed
>     3.034343]    8regs           :  1356 MB/sec
>     3.041123]    32regs          :  1356 MB/sec
>     3.046733]    arm64_neon      :  2622 MB/sec
>     3.051087] xor: using function: arm64_neon (2622 MB/sec)
>     3.056495] async_tx: api initialized (async)
>     3.060851] Key type asymmetric registered
>     3.064948] Asymmetric key parser 'x509' registered
>     3.069913] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 246)
>     3.077392] io scheduler mq-deadline registered
>     3.081930] io scheduler kyber registered
>     3.085959] io scheduler bfq registered
>     3.093388] pci-host-generic 878000000000.pci: host bridge /soc@0/pci@878000000000 ranges:
>     3.101689] pci-host-generic 878000000000.pci:      MEM 0x802000000000..0x80f0008fffff -> 0x802000000000
>     3.111192] pci-host-generic 878000000000.pci:      MEM 0x828000000000..0x8281001fffff -> 0x828000000000
>     3.120689] pci-host-generic 878000000000.pci:      MEM 0x82c000000000..0x82c0001fffff -> 0x82c000000000
>     3.130184] pci-host-generic 878000000000.pci:      MEM 0x86d000000000..0x86d0000fffff -> 0x86d000000000
>     3.139682] pci-host-generic 878000000000.pci:      MEM 0x86e000000000..0x86e22fffffff -> 0x86e000000000
>     3.149181] pci-host-generic 878000000000.pci:      MEM 0x87e002000000..0x87e027ffffff -> 0x87e002000000
>     3.158702] pci-host-generic 878000000000.pci:      MEM 0x87e03c000000..0x87e0525fffff -> 0x87e03c000000
>     3.168197] pci-host-generic 878000000000.pci:      MEM 0x87e087000000..0x87e0fcffffff -> 0x87e087000000
>     3.177689] pci-host-generic 878000000000.pci:      MEM 0x87e100000000..0x87e10bffffff -> 0x87e100000000
>     3.187193] pci-host-generic 878000000000.pci: Memory resource size exceeds max for 32 bits
>     3.195549] pci-host-generic 878000000000.pci: Memory resource size exceeds max for 32 bits
>     3.203911] pci-host-generic 878000000000.pci: Memory resource size exceeds max for 32 bits
>     3.214945] pci-host-generic 878000000000.pci: ECAM at [mem 0x878000000000-0x87800fffffff] for [bus 00-ff]
>     3.224819] pci-host-generic 878000000000.pci: PCI host bridge to bus 0000:00
>     3.231963] pci_bus 0000:00: root bus resource [bus 00-ff]
>     3.237452] pci_bus 0000:00: root bus resource [mem 0x802000000000-0x80f0008fffff]
>     3.245026] pci_bus 0000:00: root bus resource [mem 0x828000000000-0x8281001fffff]
>     3.252604] pci_bus 0000:00: root bus resource [mem 0x82c000000000-0x82c0001fffff]
>     3.260204] pci_bus 0000:00: root bus resource [mem 0x86d000000000-0x86d0000fffff]
>     3.267774] pci_bus 0000:00: root bus resource [mem 0x86e000000000-0x86e22fffffff]
>     3.275345] pci_bus 0000:00: root bus resource [mem 0x87e002000000-0x87e027ffffff]
>     3.282916] pci_bus 0000:00: root bus resource [mem 0x87e03c000000-0x87e0525fffff]
>     3.290487] pci_bus 0000:00: root bus resource [mem 0x87e087000000-0x87e0fcffffff]
>     3.298058] pci_bus 0000:00: root bus resource [mem 0x87e100000000-0x87e10bffffff]
>     3.305767] pci 0000:00:01.0: [177d:a002] type 01 class 0x060401 PCIe Root Port
>     3.313087] pci 0000:00:01.0: PCI bridge to [bus 01] (subtractive decode)
>     3.319878] pci 0000:00:01.0:   bridge window [mem 0x00000000-0x000fffff]
>     3.327100] pci 0000:00:03.0: [177d:a062] type 00 class 0x088000 PCIe Root Complex Integrated Endpoint
>     3.336440] pci 0000:00:03.0: BAR 0 [mem 0x830000000000-0x8300001fffff 64bit]: from Enhanced Allocation, properties 0x0
>     3.347529] pci 0000:00:05.0: [177d:a017] type 00 class 0x088000 PCIe Root Complex Integrated Endpoint
>     3.356869] pci 0000:00:05.0: BAR 0 [mem 0x802000000000-0x8020000fffff 64bit]: from Enhanced Allocation, properties 0x0
>     3.367657] pci 0000:00:05.0: BAR 4 [mem 0x80200f000000-0x80200f0fffff 64bit]: from Enhanced Allocation, properties 0x0
>     3.378879] pci 0000:00:08.0: [177d:a09e] type 00 class 0x088000 PCIe Root Complex Integrated Endpoint
>     3.388220] pci 0000:00:08.0: BAR 0 [mem 0x807000000000-0x80700000ffff 64bit]: from Enhanced Allocation, properties 0x0
>     3.399006] pci 0000:00:08.0: BAR 4 [mem 0x807000f00000-0x807000ffffff 64bit]: from Enhanced Allocation, properties 0x0
>     3.410106] pci 0000:00:0a.0: [177d:a09d] type 00 class 0x088000 PCIe Root Complex Integrated Endpoint
>     3.419439] pci 0000:00:0a.0: BAR 0 [mem 0x87a400000000-0x87a47fffffff 64bit]: from Enhanced Allocation, properties 0x0
>     3.430233] pci 0000:00:0a.0: BAR 4 [mem 0x87a480000000-0x87a4ffffffff 64bit]: from Enhanced Allocation, properties 0x0
>     3.441334] pci 0000:00:0c.0: [177d:a002] type 01 class 0x060401 PCIe Root Port
>     3.448655] pci 0000:00:0c.0: PCI bridge to [bus 02] (subtractive decode)
>     3.455454] pci 0000:00:0c.0:   bridge window [mem 0x00000000-0x000fffff]
>     3.462456] pci 0000:00:0d.0: [177d:a002] type 01 class 0x060401 PCIe Root Port
>     3.469772] pci 0000:00:0d.0: PCI bridge to [bus 03] (subtractive decode)
>     3.476562] pci 0000:00:0d.0:   bridge window [mem 0x00000000-0x000fffff]
>     3.483532] pci 0000:00:0e.0: [177d:a002] type 01 class 0x060401 PCIe Root Port
>     3.490850] pci 0000:00:0e.0: PCI bridge to [bus 04] (subtractive decode)
>     3.497640] pci 0000:00:0e.0:   bridge window [mem 0x00000000-0x000fffff]
>     3.504614] pci 0000:00:0f.0: [177d:a002] type 01 class 0x060401 PCIe Root Port
>     3.511930] pci 0000:00:0f.0: PCI bridge to [bus 05] (subtractive decode)
>     3.518719] pci 0000:00:0f.0:   bridge window [mem 0x00000000-0x000fffff]
>     3.525683] pci 0000:00:10.0: [177d:a092] type 00 class 0x088000 PCIe Root Complex Integrated Endpoint
>     3.535011] pci 0000:00:10.0: BAR 0 [mem 0x828000000000-0x82803fffffff 64bit]: from Enhanced Allocation, properties 0x0
>     3.545797] pci 0000:00:10.0: BAR 4 [mem 0x828100000000-0x8281000fffff 64bit]: from Enhanced Allocation, properties 0x0
>     3.556775] pci 0000:00:11.0: [177d:a00a] type 00 class 0x088000 PCIe Root Complex Integrated Endpoint
>     3.566110] pci 0000:00:11.0: BAR 0 [mem 0x803000000000-0x80300000ffff 64bit]: from Enhanced Allocation, properties 0x0
>     3.576895] pci 0000:00:11.0: BAR 4 [mem 0x803000f00000-0x803000ffffff 64bit]: from Enhanced Allocation, properties 0x0
>     3.588103] pci 0000:00:14.0: [177d:a002] type 01 class 0x060401 PCIe Root Port
>     3.595425] pci 0000:00:14.0: PCI bridge to [bus 06] (subtractive decode)
>     3.602217] pci 0000:00:14.0:   bridge window [mem 0x00000000-0x000fffff]
>     3.609704] pci 0000:00:1a.0: [177d:a068] type 00 class 0x088000 PCIe Root Complex Integrated Endpoint
>     3.619041] pci 0000:00:1a.0: BAR 0 [mem 0x86d000000000-0x86d0000fffff 64bit]: from Enhanced Allocation, properties 0x0
>     3.630135] pci 0000:00:1c.0: [177d:a067] type 00 class 0x088000 PCIe Root Complex Integrated Endpoint
>     3.639473] pci 0000:00:1c.0: BAR 0 [mem 0x82c000000000-0x82c0000fffff 64bit]: from Enhanced Allocation, properties 0x0
>     3.650262] pci 0000:00:1c.0: BAR 4 [mem 0x82c000100000-0x82c0001fffff 64bit]: from Enhanced Allocation, properties 0x0
>     3.661304] pci 0000:00:1d.0: [177d:a067] type 00 class 0x088000 PCIe Root Complex Integrated Endpoint
>     3.670647] pci 0000:00:1d.0: BAR 0 [mem 0x82d000000000-0x82d0000fffff 64bit]: from Enhanced Allocation, properties 0x0
>     3.681434] pci 0000:00:1d.0: BAR 4 [mem 0x82d000100000-0x82d0001fffff 64bit]: from Enhanced Allocation, properties 0x0
>     3.692392] pci 0000:00:1e.0: [177d:a067] type 00 class 0x088000 PCIe Root Complex Integrated Endpoint
>     3.701721] pci 0000:00:1e.0: BAR 0 [mem 0x82e000000000-0x82e0000fffff 64bit]: from Enhanced Allocation, properties 0x0
>     3.712515] pci 0000:00:1e.0: BAR 4 [mem 0x82e000100000-0x82e0001fffff 64bit]: from Enhanced Allocation, properties 0x0
>     3.723673] pci 0000:01:00.0: [177d:a075] type 00 class 0x088000 PCIe Endpoint
>     3.730924] pci 0000:01:00.0: BAR 0 [mem 0x87e0fc000000-0x87e0fc03ffff 64bit]: from Enhanced Allocation, properties 0x0
>     3.741710] pci 0000:01:00.0: BAR 4 [mem 0x87e0fcf00000-0x87e0fcffffff 64bit]: from Enhanced Allocation, properties 0x0
>     3.752714] pci 0000:01:01.3: [177d:a02b] type 00 class 0x0c8000 PCIe Endpoint
>     3.759959] pci 0000:01:01.3: BAR 0 [mem 0x87e005000000-0x87e0050fffff 64bit]: from Enhanced Allocation, properties 0x0
>     3.770947] pci 0000:01:01.7: [177d:a035] type 00 class 0x088000 PCIe Endpoint
>     3.778205] pci 0000:01:01.7: BAR 0 [mem 0x87e001000000-0x87e0010fffff 64bit]: from Enhanced Allocation, properties 0x0
>     3.788991] pci 0000:01:01.7: BAR 2 [mem 0x800000000000-0x8000ffffffff 64bit]: from Enhanced Allocation, properties 0x0
>     3.799777] pci 0000:01:01.7: BAR 4 [mem 0x87e001f00000-0x87e001ffffff 64bit]: from Enhanced Allocation, properties 0x0
>     3.810782] pci 0000:01:0a.0: [177d:a094] type 00 class 0x088000 PCIe Endpoint
>     3.818031] pci 0000:01:0a.0: BAR 0 [mem 0x87e120000000-0x87e1200fffff 64bit]: from Enhanced Allocation, properties 0x0
>     3.828817] pci 0000:01:0a.0: BAR 4 [mem 0x87e120f00000-0x87e120ffffff 64bit]: from Enhanced Allocation, properties 0x0
>     3.839813] pci 0000:01:0a.1: [177d:a094] type 00 class 0x088000 PCIe Endpoint
>     3.847061] pci 0000:01:0a.1: BAR 0 [mem 0x87e121000000-0x87e1210fffff 64bit]: from Enhanced Allocation, properties 0x0
>     3.857846] pci 0000:01:0a.1: BAR 4 [mem 0x87e121f00000-0x87e121ffffff 64bit]: from Enhanced Allocation, properties 0x0
>     3.868819] pci 0000:01:0a.2: [177d:a094] type 00 class 0x088000 PCIe Endpoint
>     3.876067] pci 0000:01:0a.2: BAR 0 [mem 0x87e122000000-0x87e1220fffff 64bit]: from Enhanced Allocation, properties 0x0
>     3.886861] pci 0000:01:0a.2: BAR 4 [mem 0x87e122f00000-0x87e122ffffff 64bit]: from Enhanced Allocation, properties 0x0
>     3.897860] pci 0000:01:0c.0: [177d:a073] type 00 class 0x088000 PCIe Endpoint
>     3.905104] pci 0000:01:0c.0: BAR 0 [mem 0x87e010000000-0x87e0100fffff 64bit]: from Enhanced Allocation, properties 0x0
>     3.915890] pci 0000:01:0c.0: BAR 2 [mem 0x87e1bf000000-0x87e1bfffffff 64bit]: from Enhanced Allocation, properties 0x0
>     3.926675] pci 0000:01:0c.0: BAR 4 [mem 0x87e010100000-0x87e0101fffff 64bit]: from Enhanced Allocation, properties 0x0
>     3.937646] pci 0000:01:0f.0: [177d:a061] type 00 class 0x088000 PCIe Endpoint
>     3.944894] pci 0000:01:0f.0: BAR 0 [mem 0x87e018000000-0x87e01800ffff 64bit]: from Enhanced Allocation, properties 0x0
>     3.955864] pci 0000:01:10.0: [177d:a060] type 00 class 0x028000 PCIe Endpoint
>     3.963116] pci 0000:01:10.0: BAR 0 [mem 0x87e0e0000000-0x87e0e07fffff 64bit]: from Enhanced Allocation, properties 0x0
>     3.973904] pci 0000:01:10.0: BAR 4 [mem 0x87e0e0800000-0x87e0e0ffffff 64bit]: from Enhanced Allocation, properties 0x0
>     3.984871] pci 0000:01:10.1: [177d:a060] type 00 class 0x028000 PCIe Endpoint
>     3.992121] pci 0000:01:10.1: BAR 0 [mem 0x87e0e1000000-0x87e0e17fffff 64bit]: from Enhanced Allocation, properties 0x0
>     4.002909] pci 0000:01:10.1: BAR 4 [mem 0x87e0e1800000-0x87e0e1ffffff 64bit]: from Enhanced Allocation, properties 0x0
>     4.013903] pci 0000:01:14.0: [177d:a097] type 00 class 0x088000 PCIe Endpoint
>     4.021151] pci 0000:01:14.0: BAR 0 [mem 0x87e140000000-0x87e1400fffff 64bit]: from Enhanced Allocation, properties 0x0
>     4.032138] pci 0000:01:14.1: [177d:a097] type 00 class 0x088000 PCIe Endpoint
>     4.039382] pci 0000:01:14.1: BAR 0 [mem 0x87e141000000-0x87e1410fffff 64bit]: from Enhanced Allocation, properties 0x0
>     4.050343] pci 0000:01:14.2: [177d:a097] type 00 class 0x088000 PCIe Endpoint
>     4.057587] pci 0000:01:14.2: BAR 0 [mem 0x87e142000000-0x87e1420fffff 64bit]: from Enhanced Allocation, properties 0x0
>     4.068556] pci 0000:01:14.3: [177d:a097] type 00 class 0x088000 PCIe Endpoint
>     4.075802] pci 0000:01:14.3: BAR 0 [mem 0x87e143000000-0x87e1430fffff 64bit]: from Enhanced Allocation, properties 0x0
>     4.086774] pci 0000:01:14.4: [177d:a097] type 00 class 0x088000 PCIe Endpoint
>     4.094023] pci 0000:01:14.4: BAR 0 [mem 0x87e144000000-0x87e1440fffff 64bit]: from Enhanced Allocation, properties 0x0
>     4.105031] pci 0000:01:18.0: [177d:a012] type 00 class 0x0c8000 PCIe Endpoint
>     4.112279] pci 0000:01:18.0: BAR 0 [mem 0x87e100000000-0x87e10000ffff 64bit]: from Enhanced Allocation, properties 0x0
>     4.123065] pci 0000:01:18.0: BAR 4 [mem 0x87e100f00000-0x87e100ffffff 64bit]: from Enhanced Allocation, properties 0x0
>     4.134125] pci 0000:01:18.1: [177d:a012] type 00 class 0x0c8000 PCIe Endpoint
>     4.141370] pci 0000:01:18.1: BAR 0 [mem 0x87e101000000-0x87e10100ffff 64bit]: from Enhanced Allocation, properties 0x0
>     4.152157] pci 0000:01:18.1: BAR 4 [mem 0x87e101f00000-0x87e101ffffff 64bit]: from Enhanced Allocation, properties 0x0
>     4.163215] pci 0000:01:18.2: [177d:a012] type 00 class 0x0c8000 PCIe Endpoint
>     4.170464] pci 0000:01:18.2: BAR 0 [mem 0x87e102000000-0x87e10200ffff 64bit]: from Enhanced Allocation, properties 0x0
>     4.181251] pci 0000:01:18.2: BAR 4 [mem 0x87e102f00000-0x87e102ffffff 64bit]: from Enhanced Allocation, properties 0x0
>     4.192315] pci 0000:01:18.4: [177d:a012] type 00 class 0x0c8000 PCIe Endpoint
>     4.199560] pci 0000:01:18.4: BAR 0 [mem 0x87e104000000-0x87e10400ffff 64bit]: from Enhanced Allocation, properties 0x0
>     4.210353] pci 0000:01:18.4: BAR 4 [mem 0x87e104f00000-0x87e104ffffff 64bit]: from Enhanced Allocation, properties 0x0
>     4.221452] pci 0000:01:18.5: [177d:a012] type 00 class 0x0c8000 PCIe Endpoint
>     4.228700] pci 0000:01:18.5: BAR 0 [mem 0x87e105000000-0x87e10500ffff 64bit]: from Enhanced Allocation, properties 0x0
>     4.239485] pci 0000:01:18.5: BAR 4 [mem 0x87e105f00000-0x87e105ffffff 64bit]: from Enhanced Allocation, properties 0x0
>     4.250538] pci 0000:01:18.6: [177d:a012] type 00 class 0x0c8000 PCIe Endpoint
>     4.257781] pci 0000:01:18.6: BAR 0 [mem 0x87e106000000-0x87e10600ffff 64bit]: from Enhanced Allocation, properties 0x0
>     4.268568] pci 0000:01:18.6: BAR 4 [mem 0x87e106f00000-0x87e106ffffff 64bit]: from Enhanced Allocation, properties 0x0
>     4.279615] pci 0000:01:18.7: [177d:a012] type 00 class 0x0c8000 PCIe Endpoint
>     4.286863] pci 0000:01:18.7: BAR 0 [mem 0x87e107000000-0x87e10700ffff 64bit]: from Enhanced Allocation, properties 0x0
>     4.297649] pci 0000:01:18.7: BAR 4 [mem 0x87e107f00000-0x87e107ffffff 64bit]: from Enhanced Allocation, properties 0x0
>     4.308699] pci 0000:01:19.0: [177d:a012] type 00 class 0x0c8000 PCIe Endpoint
>     4.315950] pci 0000:01:19.0: BAR 0 [mem 0x87e108000000-0x87e10800ffff 64bit]: from Enhanced Allocation, properties 0x0
>     4.326736] pci 0000:01:19.0: BAR 4 [mem 0x87e108f00000-0x87e108ffffff 64bit]: from Enhanced Allocation, properties 0x0
>     4.337828] pci 0000:01:19.1: [177d:a012] type 00 class 0x0c8000 PCIe Endpoint
>     4.345077] pci 0000:01:19.1: BAR 0 [mem 0x87e109000000-0x87e10900ffff 64bit]: from Enhanced Allocation, properties 0x0
>     4.355863] pci 0000:01:19.1: BAR 4 [mem 0x87e109f00000-0x87e109ffffff 64bit]: from Enhanced Allocation, properties 0x0
>     4.366927] pci 0000:01:19.2: [177d:a012] type 00 class 0x0c8000 PCIe Endpoint
>     4.374174] pci 0000:01:19.2: BAR 0 [mem 0x87e10a000000-0x87e10a00ffff 64bit]: from Enhanced Allocation, properties 0x0
>     4.384961] pci 0000:01:19.2: BAR 4 [mem 0x87e10af00000-0x87e10affffff 64bit]: from Enhanced Allocation, properties 0x0
>     4.396011] pci 0000:01:19.3: [177d:a012] type 00 class 0x0c8000 PCIe Endpoint
>     4.403255] pci 0000:01:19.3: BAR 0 [mem 0x87e10b000000-0x87e10b00ffff 64bit]: from Enhanced Allocation, properties 0x0
>     4.414043] pci 0000:01:19.3: BAR 4 [mem 0x87e10bf00000-0x87e10bffffff 64bit]: from Enhanced Allocation, properties 0x0
>     4.425308] pci 0000:02:00.0: [177d:a075] type 00 class 0x088000 PCIe Endpoint
>     4.432561] pci 0000:02:00.0: BAR 0 [mem 0x87e0f9000000-0x87e0f903ffff 64bit]: from Enhanced Allocation, properties 0x0
>     4.443618] pci 0000:03:00.0: [177d:a075] type 00 class 0x088000 PCIe Endpoint
>     4.450869] pci 0000:03:00.0: BAR 0 [mem 0x87e0fa000000-0x87e0fa03ffff 64bit]: from Enhanced Allocation, properties 0x0
>     4.461905] pci 0000:04:00.0: [177d:a075] type 00 class 0x088000 PCIe Endpoint
>     4.469157] pci 0000:04:00.0: BAR 0 [mem 0x87e0fb000000-0x87e0fb03ffff 64bit]: from Enhanced Allocation, properties 0x0
>     4.480225] pci 0000:05:00.0: [177d:a098] type 00 class 0x120000 PCIe Endpoint
>     4.487474] pci 0000:05:00.0: BAR 0 [mem 0x87e00f000000-0x87e00f0fffff 64bit]: from Enhanced Allocation, properties 0x0
>     4.498260] pci 0000:05:00.0: VF BAR 2 [mem 0x80f000800000-0x80f0008fffff 64bit]: from Enhanced Allocation, properties 0x4
>     4.509324] pci 0000:05:00.0: VF BAR 0 [mem 0x80f000800000-0x80f0008fffff 64bit]: contains BAR 0 for 1 VFs
>     4.519247] pci 0000:06:00.0: [177d:a080] type 00 class 0x088000 PCIe Endpoint
>     4.526497] pci 0000:06:00.0: BAR 0 [mem 0x86e000000000-0x86e0ffffffff 64bit]: from Enhanced Allocation, properties 0x0
>     4.537295] pci 0000:06:00.0: BAR 4 [mem 0x86e100000000-0x86e1000fffff 64bit]: from Enhanced Allocation, properties 0x0
>     4.548086] pci 0000:06:00.0: VF BAR 2 [mem 0x86e200000000-0x86e2000fffff 64bit]: from Enhanced Allocation, properties 0x4
>     4.559132] pci 0000:06:00.0: bridge window [mem 0x86e210000000-0x86e2100fffff 64bit]: from Enhanced Allocation, properties 0x4
>     5.602589] pci 0000:06:00.0: VF BAR 0 [mem 0x86e200000000-0x86e201ffffff 64bit]: contains BAR 0 for 32 VFs
>     5.612342] pci 0000:06:00.0: VF BAR 4 [mem 0x86e210000000-0x86e211ffffff 64bit]: contains BAR 4 for 32 VFs
>     5.622388] pci 0000:00:01.0: PCI bridge to [bus 01]
>     5.627362] pci 0000:00:0c.0: PCI bridge to [bus 02]
>     5.632328] pci 0000:00:0d.0: PCI bridge to [bus 03]
>     5.637293] pci 0000:00:0e.0: PCI bridge to [bus 04]
>     5.642261] pci 0000:00:0f.0: PCI bridge to [bus 05]
>     5.647230] pci 0000:00:14.0: PCI bridge to [bus 06]
>     5.652200] pci_bus 0000:00: resource 4 [mem 0x802000000000-0x80f0008fffff]
>     5.659166] pci_bus 0000:00: resource 5 [mem 0x828000000000-0x8281001fffff]
>     5.666128] pci_bus 0000:00: resource 6 [mem 0x82c000000000-0x82c0001fffff]
>     5.673091] pci_bus 0000:00: resource 7 [mem 0x86d000000000-0x86d0000fffff]
>     5.680053] pci_bus 0000:00: resource 8 [mem 0x86e000000000-0x86e22fffffff]
>     5.687017] pci_bus 0000:00: resource 9 [mem 0x87e002000000-0x87e027ffffff]
>     5.693979] pci_bus 0000:00: resource 10 [mem 0x87e03c000000-0x87e0525fffff]
>     5.701027] pci_bus 0000:00: resource 11 [mem 0x87e087000000-0x87e0fcffffff]
>     5.708076] pci_bus 0000:00: resource 12 [mem 0x87e100000000-0x87e10bffffff]
>     5.717314] pci-host-generic 878020000000.pci: host bridge /soc@0/pci@878020000000 ranges:
>     5.725606] pci-host-generic 878020000000.pci:      MEM 0x840000000000..0x85f4ffffffff -> 0x840000000000
>     5.735110] pci-host-generic 878020000000.pci:      MEM 0x09fc000000..0x09ff03ffff -> 0x09fc000000
>     5.744082] pci-host-generic 878020000000.pci: Memory resource size exceeds max for 32 bits
>     5.755096] pci-host-generic 878020000000.pci: ECAM at [mem 0x878020000000-0x87802fffffff] for [bus 00-ff]
>     5.764916] pci-host-generic 878020000000.pci: PCI host bridge to bus 0002:00
>     5.772058] pci_bus 0002:00: root bus resource [bus 00-ff]
>     5.777544] pci_bus 0002:00: root bus resource [mem 0x840000000000-0x85f4ffffffff]
>     5.785121] pci_bus 0002:00: root bus resource [mem 0x9fc000000-0x9ff03ffff]
>     5.792213] pci 0002:00:00.0: [177d:a002] type 01 class 0x060401 PCIe Root Port
>     5.799532] pci 0002:00:00.0: PCI bridge to [bus fa] (subtractive decode)
>     5.806322] pci 0002:00:00.0:   bridge window [mem 0x00000000-0x000fffff]
>     5.813315] pci 0002:00:01.0: [177d:a002] type 01 class 0x060401 PCIe Root Port
>     5.820632] pci 0002:00:01.0: PCI bridge to [bus fb] (subtractive decode)
>     5.827423] pci 0002:00:01.0:   bridge window [mem 0x00000000-0x000fffff]
>     5.834400] pci 0002:00:02.0: [177d:a002] type 01 class 0x060401 PCIe Root Port
>     5.841721] pci 0002:00:02.0: PCI bridge to [bus fc] (subtractive decode)
>     5.848510] pci 0002:00:02.0:   bridge window [mem 0x00000000-0x000fffff]
>     5.855483] pci 0002:00:03.0: [177d:a002] type 01 class 0x060401 PCIe Root Port
>     5.862804] pci 0002:00:03.0: PCI bridge to [bus fd] (subtractive decode)
>     5.869595] pci 0002:00:03.0:   bridge window [mem 0x00000000-0x000fffff]
>     5.876557] pci 0002:00:04.0: [177d:a002] type 01 class 0x060401 PCIe Root Port
>     5.883872] pci 0002:00:04.0: PCI bridge to [bus fe] (subtractive decode)
>     5.890670] pci 0002:00:04.0:   bridge window [mem 0x00000000-0x000fffff]
>     5.897661] pci 0002:00:05.0: [177d:a002] type 01 class 0x060401 PCIe Root Port
>     5.904976] pci 0002:00:05.0: PCI bridge to [bus ff] (subtractive decode)
>     5.911765] pci 0002:00:05.0:   bridge window [mem 0x00000000-0x000fffff]
>     5.918730] pci 0002:00:06.0: [177d:a002] type 01 class 0x060401 PCIe Root Port
>     5.926047] pci 0002:00:06.0: PCI bridge to [bus 00] (subtractive decode)
>     5.932836] pci 0002:00:06.0:   bridge window [mem 0x00000000-0x000fffff]
>     5.939814] pci 0002:00:07.0: [177d:a002] type 01 class 0x060401 PCIe Root Port
>     5.947131] pci 0002:00:07.0: PCI bridge to [bus 01] (subtractive decode)
>     5.953922] pci 0002:00:07.0:   bridge window [mem 0x00000000-0x000fffff]
>     5.960898] pci 0002:00:08.0: [177d:a002] type 01 class 0x060401 PCIe Root Port
>     5.968214] pci 0002:00:08.0: PCI bridge to [bus 02] (subtractive decode)
>     5.975004] pci 0002:00:08.0:   bridge window [mem 0x00000000-0x000fffff]
>     5.981969] pci 0002:00:09.0: [177d:a002] type 01 class 0x060401 PCIe Root Port
>     5.989290] pci 0002:00:09.0: PCI bridge to [bus 03] (subtractive decode)
>     5.996085] pci 0002:00:09.0:   bridge window [mem 0x00000000-0x000fffff]
>     6.003074] pci 0002:00:0a.0: [177d:a002] type 01 class 0x060401 PCIe Root Port
>     6.010390] pci 0002:00:0a.0: PCI bridge to [bus 04] (subtractive decode)
>     6.017179] pci 0002:00:0a.0:   bridge window [mem 0x00000000-0x000fffff]
>     6.024147] pci 0002:00:0b.0: [177d:a002] type 01 class 0x060401 PCIe Root Port
>     6.031463] pci 0002:00:0b.0: PCI bridge to [bus 05] (subtractive decode)
>     6.038251] pci 0002:00:0b.0:   bridge window [mem 0x00000000-0x000fffff]
>     6.045213] pci 0002:00:0c.0: [177d:a002] type 01 class 0x060401 PCIe Root Port
>     6.052531] pci 0002:00:0c.0: PCI bridge to [bus 06] (subtractive decode)
>     6.059320] pci 0002:00:0c.0:   bridge window [mem 0x00000000-0x000fffff]
>     6.066280] pci 0002:00:0d.0: [177d:a002] type 01 class 0x060401 PCIe Root Port
>     6.073595] pci 0002:00:0d.0: PCI bridge to [bus 07] (subtractive decode)
>     6.080386] pci 0002:00:0d.0:   bridge window [mem 0x00000000-0x000fffff]
>     6.087350] pci 0002:00:0e.0: [177d:a002] type 01 class 0x060401 PCIe Root Port
>     6.094664] pci 0002:00:0e.0: PCI bridge to [bus 08] (subtractive decode)
>     6.101459] pci 0002:00:0e.0:   bridge window [mem 0x00000000-0x000fffff]
>     6.108472] pci 0002:00:0f.0: [177d:a002] type 01 class 0x060401 PCIe Root Port
>     6.115799] pci 0002:00:0f.0: PCI bridge to [bus 09] (subtractive decode)
>     6.122589] pci 0002:00:0f.0:   bridge window [mem 0x00000000-0x000fffff]
>     6.129556] pci 0002:00:10.0: [177d:a002] type 01 class 0x060401 PCIe Root Port
>     6.136873] pci 0002:00:10.0: PCI bridge to [bus 0a] (subtractive decode)
>     6.143663] pci 0002:00:10.0:   bridge window [mem 0x00000000-0x000fffff]
>     6.150641] pci 0002:00:11.0: [177d:a002] type 01 class 0x060401 PCIe Root Port
>     6.157958] pci 0002:00:11.0: PCI bridge to [bus 0b] (subtractive decode)
>     6.164749] pci 0002:00:11.0:   bridge window [mem 0x00000000-0x000fffff]
>     6.171712] pci 0002:00:12.0: [177d:a002] type 01 class 0x060401 PCIe Root Port
>     6.179027] pci 0002:00:12.0: PCI bridge to [bus 0c] (subtractive decode)
>     6.185816] pci 0002:00:12.0:   bridge window [mem 0x00000000-0x000fffff]
>     6.192792] pci 0002:00:13.0: [177d:a002] type 01 class 0x060401 PCIe Root Port
>     6.200110] pci 0002:00:13.0: PCI bridge to [bus 0d] (subtractive decode)
>     6.206903] pci 0002:00:13.0:   bridge window [mem 0x00000000-0x000fffff]
>     6.213897] pci 0002:00:14.0: [177d:a002] type 01 class 0x060401 PCIe Root Port
>     6.221216] pci 0002:00:14.0: PCI bridge to [bus 0e] (subtractive decode)
>     6.228008] pci 0002:00:14.0:   bridge window [mem 0x00000000-0x000fffff]
>     6.234976] pci 0002:00:15.0: [177d:a002] type 01 class 0x060401 PCIe Root Port
>     6.242296] pci 0002:00:15.0: PCI bridge to [bus 0f] (subtractive decode)
>     6.249086] pci 0002:00:15.0:   bridge window [mem 0x00000000-0x000fffff]
>     6.256059] pci 0002:00:16.0: [177d:a002] type 01 class 0x060401 PCIe Root Port
>     6.263377] pci 0002:00:16.0: PCI bridge to [bus 10] (subtractive decode)
>     6.270166] pci 0002:00:16.0:   bridge window [mem 0x00000000-0x000fffff]
>     6.277145] pci 0002:00:17.0: [177d:a002] type 01 class 0x060401 PCIe Root Port
>     6.284460] pci 0002:00:17.0: PCI bridge to [bus 11] (subtractive decode)
>     6.291249] pci 0002:00:17.0:   bridge window [mem 0x00000000-0x000fffff]
>     6.298216] pci 0002:00:18.0: [177d:a002] type 01 class 0x060401 PCIe Root Port
>     6.305532] pci 0002:00:18.0: PCI bridge to [bus 12] (subtractive decode)
>     6.312325] pci 0002:00:18.0:   bridge window [mem 0x00000000-0x000fffff]
>     6.319319] pci 0002:00:19.0: [177d:a002] type 01 class 0x060401 PCIe Root Port
>     6.326636] pci 0002:00:19.0: PCI bridge to [bus 13] (subtractive decode)
>     6.333427] pci 0002:00:19.0:   bridge window [mem 0x00000000-0x000fffff]
>     6.340397] pci 0002:00:1a.0: [177d:a002] type 01 class 0x060401 PCIe Root Port
>     6.347711] pci 0002:00:1a.0: PCI bridge to [bus 14] (subtractive decode)
>     6.354500] pci 0002:00:1a.0:   bridge window [mem 0x00000000-0x000fffff]
>     6.361461] pci 0002:00:1b.0: [177d:a002] type 01 class 0x060401 PCIe Root Port
>     6.368784] pci 0002:00:1b.0: PCI bridge to [bus 15] (subtractive decode)
>     6.375575] pci 0002:00:1b.0:   bridge window [mem 0x00000000-0x000fffff]
>     6.382545] pci 0002:00:1c.0: [177d:a002] type 01 class 0x060401 PCIe Root Port
>     6.389863] pci 0002:00:1c.0: PCI bridge to [bus 16] (subtractive decode)
>     6.396652] pci 0002:00:1c.0:   bridge window [mem 0x00000000-0x000fffff]
>     6.403610] pci 0002:00:1d.0: [177d:a002] type 01 class 0x060401 PCIe Root Port
>     6.410926] pci 0002:00:1d.0: PCI bridge to [bus 17] (subtractive decode)
>     6.417718] pci 0002:00:1d.0:   bridge window [mem 0x00000000-0x000fffff]
>     6.424712] pci 0002:00:1e.0: [177d:a002] type 01 class 0x060401 PCIe Root Port
>     6.432028] pci 0002:00:1e.0: PCI bridge to [bus 18] (subtractive decode)
>     6.438817] pci 0002:00:1e.0:   bridge window [mem 0x00000000-0x000fffff]
>     6.445796] pci 0002:00:1f.0: [177d:a002] type 01 class 0x060401 PCIe Root Port
>     6.453111] pci 0002:00:1f.0: PCI bridge to [bus 19] (subtractive decode)
>     6.459901] pci 0002:00:1f.0:   bridge window [mem 0x00000000-0x000fffff]
>     6.467888] pci 0002:00:06.0: bridge configuration invalid ([bus 00-00]), reconfiguring
>     6.475992] pci 0002:01:00.0: [177d:a065] type 00 class 0x020000 PCIe Endpoint
>     6.483240] pci 0002:01:00.0: BAR 0 [mem 0x840000000000-0x8401ffffffff 64bit]: from Enhanced Allocation, properties 0x0
>     6.494034] pci 0002:01:00.0: BAR 2 [mem 0x840200000000-0x840201ffffff 64bit]: from Enhanced Allocation, properties 0x0
>     6.504821] pci 0002:01:00.0: BAR 4 [mem 0x9fc000000-0x9fc0fffff 64bit]: from Enhanced Allocation, properties 0x0
>     6.515087] pci 0002:01:00.0: VF BAR 4 [mem 0x840202000000-0x840203ffffff 64bit]: from Enhanced Allocation, properties 0x4
>     6.526141] pci 0002:01:00.0: bridge window [mem 0x9fc100000-0x9fc13ffff 64bit]: from Enhanced Allocation, properties 0x4
>     6.537157] pci 0002:01:00.0: VF BAR 2 [mem 0x840202000000-0x840213ffffff 64bit]: contains BAR 2 for 9 VFs
>     6.546812] pci 0002:01:00.0: VF BAR 4 [mem 0x9fc100000-0x9fc33ffff 64bit]: contains BAR 4 for 9 VFs
>     6.556237] pci 0002:02:00.0: [177d:a063] type 00 class 0x020000 PCIe Endpoint
>     6.563488] pci 0002:02:00.0: BAR 2 [mem 0x841200000000-0x841201ffffff 64bit]: from Enhanced Allocation, properties 0x0
>     6.574273] pci 0002:02:00.0: BAR 4 [mem 0x9fc340000-0x9fc3bffff 64bit]: from Enhanced Allocation, properties 0x0
>     6.584539] pci 0002:02:00.0: VF BAR 4 [mem 0x841202000000-0x841203ffffff 64bit]: from Enhanced Allocation, properties 0x4
>     6.595585] pci 0002:02:00.0: bridge window [mem 0x9fc3c0000-0x9fc3fffff 64bit]: from Enhanced Allocation, properties 0x4
>     6.606569] pci 0002:02:00.0: VF BAR 2 [mem 0x841202000000-0x841207ffffff 64bit]: contains BAR 2 for 3 VFs
>     6.616231] pci 0002:02:00.0: VF BAR 4 [mem 0x9fc3c0000-0x9fc47ffff 64bit]: contains BAR 4 for 3 VFs
>     6.625644] pci 0002:03:00.0: [177d:a063] type 00 class 0x020000 PCIe Endpoint
>     6.632901] pci 0002:03:00.0: BAR 2 [mem 0x842200000000-0x842201ffffff 64bit]: from Enhanced Allocation, properties 0x0
>     6.643687] pci 0002:03:00.0: BAR 4 [mem 0x9fc480000-0x9fc4fffff 64bit]: from Enhanced Allocation, properties 0x0
>     6.653950] pci 0002:03:00.0: VF BAR 4 [mem 0x842202000000-0x842203ffffff 64bit]: from Enhanced Allocation, properties 0x4
>     6.664996] pci 0002:03:00.0: bridge window [mem 0x9fc500000-0x9fc53ffff 64bit]: from Enhanced Allocation, properties 0x4
>     6.676007] pci 0002:03:00.0: VF BAR 2 [mem 0x842202000000-0x842207ffffff 64bit]: contains BAR 2 for 3 VFs
>     6.685662] pci 0002:03:00.0: VF BAR 4 [mem 0x9fc500000-0x9fc5bffff 64bit]: contains BAR 4 for 3 VFs
>     6.695087] pci 0002:04:00.0: [177d:a063] type 00 class 0x020000 PCIe Endpoint
>     6.702336] pci 0002:04:00.0: BAR 2 [mem 0x843200000000-0x843201ffffff 64bit]: from Enhanced Allocation, properties 0x0
>     6.713121] pci 0002:04:00.0: BAR 4 [mem 0x9fc5c0000-0x9fc63ffff 64bit]: from Enhanced Allocation, properties 0x0
>     6.723389] pci 0002:04:00.0: VF BAR 4 [mem 0x843202000000-0x843203ffffff 64bit]: from Enhanced Allocation, properties 0x4
>     6.734436] pci 0002:04:00.0: bridge window [mem 0x9fc640000-0x9fc67ffff 64bit]: from Enhanced Allocation, properties 0x4
>     6.745457] pci 0002:04:00.0: VF BAR 2 [mem 0x843202000000-0x843207ffffff 64bit]: contains BAR 2 for 3 VFs
>     6.755112] pci 0002:04:00.0: VF BAR 4 [mem 0x9fc640000-0x9fc6fffff 64bit]: contains BAR 4 for 3 VFs
>     6.764522] pci 0002:05:00.0: [177d:a0f9] type 00 class 0x088000 PCIe Endpoint
>     6.771772] pci 0002:05:00.0: BAR 2 [mem 0x844200000000-0x844201ffffff 64bit]: from Enhanced Allocation, properties 0x0
>     6.782560] pci 0002:05:00.0: BAR 4 [mem 0x9fc700000-0x9fc77ffff 64bit]: from Enhanced Allocation, properties 0x0
>     6.792823] pci 0002:05:00.0: VF BAR 4 [mem 0x844202000000-0x844203ffffff 64bit]: from Enhanced Allocation, properties 0x4
>     6.804130] pci 0002:06:00.0: [177d:a0f9] type 00 class 0x088000 PCIe Endpoint
>     6.811379] pci 0002:06:00.0: BAR 2 [mem 0x845200000000-0x845201ffffff 64bit]: from Enhanced Allocation, properties 0x0
>     6.822166] pci 0002:06:00.0: BAR 4 [mem 0x9fc780000-0x9fc7fffff 64bit]: from Enhanced Allocation, properties 0x0
>     6.832431] pci 0002:06:00.0: VF BAR 4 [mem 0x845202000000-0x845203ffffff 64bit]: from Enhanced Allocation, properties 0x4
>     6.843749] pci 0002:07:00.0: [177d:a0f9] type 00 class 0x088000 PCIe Endpoint
>     6.850999] pci 0002:07:00.0: BAR 2 [mem 0x846200000000-0x846201ffffff 64bit]: from Enhanced Allocation, properties 0x0
>     6.861786] pci 0002:07:00.0: BAR 4 [mem 0x9fc800000-0x9fc87ffff 64bit]: from Enhanced Allocation, properties 0x0
>     6.872053] pci 0002:07:00.0: VF BAR 4 [mem 0x846202000000-0x846203ffffff 64bit]: from Enhanced Allocation, properties 0x4
>     6.883390] pci 0002:08:00.0: [177d:a0f9] type 00 class 0x088000 PCIe Endpoint
>     6.890641] pci 0002:08:00.0: BAR 2 [mem 0x847200000000-0x847201ffffff 64bit]: from Enhanced Allocation, properties 0x0
>     6.901430] pci 0002:08:00.0: BAR 4 [mem 0x9fc880000-0x9fc8fffff 64bit]: from Enhanced Allocation, properties 0x0
>     6.911698] pci 0002:08:00.0: VF BAR 4 [mem 0x847202000000-0x847203ffffff 64bit]: from Enhanced Allocation, properties 0x4
>     6.923022] pci 0002:09:00.0: [177d:a0f9] type 00 class 0x088000 PCIe Endpoint
>     6.930271] pci 0002:09:00.0: BAR 2 [mem 0x848200000000-0x848201ffffff 64bit]: from Enhanced Allocation, properties 0x0
>     6.941056] pci 0002:09:00.0: BAR 4 [mem 0x9fc900000-0x9fc97ffff 64bit]: from Enhanced Allocation, properties 0x0
>     6.951320] pci 0002:09:00.0: VF BAR 4 [mem 0x848202000000-0x848203ffffff 64bit]: from Enhanced Allocation, properties 0x4
>     6.962669] pci 0002:0a:00.0: [177d:a0f9] type 00 class 0x088000 PCIe Endpoint
>     6.969921] pci 0002:0a:00.0: BAR 2 [mem 0x849200000000-0x849201ffffff 64bit]: from Enhanced Allocation, properties 0x0
>     6.980706] pci 0002:0a:00.0: BAR 4 [mem 0x9fc980000-0x9fc9fffff 64bit]: from Enhanced Allocation, properties 0x0
>     6.990971] pci 0002:0a:00.0: VF BAR 4 [mem 0x849202000000-0x849203ffffff 64bit]: from Enhanced Allocation, properties 0x4
>     7.002282] pci 0002:0b:00.0: [177d:a0f9] type 00 class 0x088000 PCIe Endpoint
>     7.009531] pci 0002:0b:00.0: BAR 2 [mem 0x84a200000000-0x84a201ffffff 64bit]: from Enhanced Allocation, properties 0x0
>     7.020321] pci 0002:0b:00.0: BAR 4 [mem 0x9fca00000-0x9fca7ffff 64bit]: from Enhanced Allocation, properties 0x0
>     7.030584] pci 0002:0b:00.0: VF BAR 4 [mem 0x84a202000000-0x84a203ffffff 64bit]: from Enhanced Allocation, properties 0x4
>     7.041893] pci 0002:0c:00.0: [177d:a0f9] type 00 class 0x088000 PCIe Endpoint
>     7.049145] pci 0002:0c:00.0: BAR 2 [mem 0x84b200000000-0x84b201ffffff 64bit]: from Enhanced Allocation, properties 0x0
>     7.059930] pci 0002:0c:00.0: BAR 4 [mem 0x9fca80000-0x9fcafffff 64bit]: from Enhanced Allocation, properties 0x0
>     7.070198] pci 0002:0c:00.0: VF BAR 4 [mem 0x84b202000000-0x84b203ffffff 64bit]: from Enhanced Allocation, properties 0x4
>     7.081540] pci 0002:0d:00.0: [177d:a0f9] type 00 class 0x088000 PCIe Endpoint
>     7.088786] pci 0002:0d:00.0: BAR 2 [mem 0x84c200000000-0x84c201ffffff 64bit]: from Enhanced Allocation, properties 0x0
>     7.099573] pci 0002:0d:00.0: BAR 4 [mem 0x9fcb00000-0x9fcb7ffff 64bit]: from Enhanced Allocation, properties 0x0
>     7.109838] pci 0002:0d:00.0: VF BAR 4 [mem 0x84c202000000-0x84c203ffffff 64bit]: from Enhanced Allocation, properties 0x4
>     7.121158] pci 0002:0e:00.0: [177d:a0f0] type 00 class 0x088000 PCIe Endpoint
>     7.128410] pci 0002:0e:00.0: BAR 2 [mem 0x84d200000000-0x84d201ffffff 64bit]: from Enhanced Allocation, properties 0x0
>     7.139200] pci 0002:0e:00.0: BAR 4 [mem 0x9fcb80000-0x9fcbfffff 64bit]: from Enhanced Allocation, properties 0x0
>     7.149467] pci 0002:0e:00.0: VF BAR 4 [mem 0x84d202000000-0x84d203ffffff 64bit]: from Enhanced Allocation, properties 0x4
>     7.160780] pci 0002:0f:00.0: [177d:a0f0] type 00 class 0x088000 PCIe Endpoint
>     7.168025] pci 0002:0f:00.0: BAR 2 [mem 0x84e200000000-0x84e201ffffff 64bit]: from Enhanced Allocation, properties 0x0
>     7.178814] pci 0002:0f:00.0: BAR 4 [mem 0x9fcc00000-0x9fcc7ffff 64bit]: from Enhanced Allocation, properties 0x0
>     7.189081] pci 0002:0f:00.0: VF BAR 4 [mem 0x84e202000000-0x84e203ffffff 64bit]: from Enhanced Allocation, properties 0x4
>     7.200417] pci 0002:10:00.0: [177d:a0f0] type 00 class 0x088000 PCIe Endpoint
>     7.207668] pci 0002:10:00.0: BAR 2 [mem 0x84f200000000-0x84f201ffffff 64bit]: from Enhanced Allocation, properties 0x0
>     7.218455] pci 0002:10:00.0: BAR 4 [mem 0x9fcc80000-0x9fccfffff 64bit]: from Enhanced Allocation, properties 0x0
>     7.228721] pci 0002:10:00.0: VF BAR 4 [mem 0x84f202000000-0x84f203ffffff 64bit]: from Enhanced Allocation, properties 0x4
>     7.240040] pci 0002:11:00.0: [177d:a0f0] type 00 class 0x088000 PCIe Endpoint
>     7.247288] pci 0002:11:00.0: BAR 2 [mem 0x850200000000-0x850201ffffff 64bit]: from Enhanced Allocation, properties 0x0
>     7.258078] pci 0002:11:00.0: BAR 4 [mem 0x9fcd00000-0x9fcd7ffff 64bit]: from Enhanced Allocation, properties 0x0
>     7.268342] pci 0002:11:00.0: VF BAR 4 [mem 0x850202000000-0x850203ffffff 64bit]: from Enhanced Allocation, properties 0x4
>     7.279649] pci 0002:12:00.0: [177d:a0f0] type 00 class 0x088000 PCIe Endpoint
>     7.286897] pci 0002:12:00.0: BAR 2 [mem 0x851200000000-0x851201ffffff 64bit]: from Enhanced Allocation, properties 0x0
>     7.297685] pci 0002:12:00.0: BAR 4 [mem 0x9fcd80000-0x9fcdfffff 64bit]: from Enhanced Allocation, properties 0x0
>     7.307951] pci 0002:12:00.0: VF BAR 4 [mem 0x851202000000-0x851203ffffff 64bit]: from Enhanced Allocation, properties 0x4
>     7.319294] pci 0002:13:00.0: [177d:a0f0] type 00 class 0x088000 PCIe Endpoint
>     7.326543] pci 0002:13:00.0: BAR 2 [mem 0x852200000000-0x852201ffffff 64bit]: from Enhanced Allocation, properties 0x0
>     7.337328] pci 0002:13:00.0: BAR 4 [mem 0x9fce00000-0x9fce7ffff 64bit]: from Enhanced Allocation, properties 0x0
>     7.347594] pci 0002:13:00.0: VF BAR 4 [mem 0x852202000000-0x852203ffffff 64bit]: from Enhanced Allocation, properties 0x4
>     7.358913] pci 0002:14:00.0: [177d:a0f0] type 00 class 0x088000 PCIe Endpoint
>     7.366165] pci 0002:14:00.0: BAR 2 [mem 0x853200000000-0x853201ffffff 64bit]: from Enhanced Allocation, properties 0x0
>     7.376951] pci 0002:14:00.0: BAR 4 [mem 0x9fce80000-0x9fcefffff 64bit]: from Enhanced Allocation, properties 0x0
>     7.387219] pci 0002:14:00.0: VF BAR 4 [mem 0x853202000000-0x853203ffffff 64bit]: from Enhanced Allocation, properties 0x4
>     7.398570] pci 0002:15:00.0: [177d:a0f0] type 00 class 0x088000 PCIe Endpoint
>     7.405820] pci 0002:15:00.0: BAR 2 [mem 0x854200000000-0x854201ffffff 64bit]: from Enhanced Allocation, properties 0x0
>     7.416607] pci 0002:15:00.0: BAR 4 [mem 0x9fcf00000-0x9fcf7ffff 64bit]: from Enhanced Allocation, properties 0x0
>     7.426871] pci 0002:15:00.0: VF BAR 4 [mem 0x854202000000-0x854203ffffff 64bit]: from Enhanced Allocation, properties 0x4
>     7.438184] pci 0002:16:00.0: [177d:a0f0] type 00 class 0x088000 PCIe Endpoint
>     7.445429] pci 0002:16:00.0: BAR 2 [mem 0x855200000000-0x855201ffffff 64bit]: from Enhanced Allocation, properties 0x0
>     7.456216] pci 0002:16:00.0: BAR 4 [mem 0x9fcf80000-0x9fcffffff 64bit]: from Enhanced Allocation, properties 0x0
>     7.466480] pci 0002:16:00.0: VF BAR 4 [mem 0x855202000000-0x855203ffffff 64bit]: from Enhanced Allocation, properties 0x4
>     7.477790] pci 0002:17:00.0: [177d:a0fb] type 00 class 0x088000 PCIe Endpoint
>     7.485039] pci 0002:17:00.0: BAR 2 [mem 0x856200000000-0x856201ffffff 64bit]: from Enhanced Allocation, properties 0x0
>     7.495826] pci 0002:17:00.0: BAR 4 [mem 0x9fd000000-0x9fd07ffff 64bit]: from Enhanced Allocation, properties 0x0
>     7.506096] pci 0002:17:00.0: VF BAR 4 [mem 0x856202000000-0x856203ffffff 64bit]: from Enhanced Allocation, properties 0x4
>     7.517432] pci 0002:18:00.0: [177d:a0fb] type 00 class 0x088000 PCIe Endpoint
>     7.524683] pci 0002:18:00.0: BAR 2 [mem 0x857200000000-0x857201ffffff 64bit]: from Enhanced Allocation, properties 0x0
>     7.535470] pci 0002:18:00.0: BAR 4 [mem 0x9fd080000-0x9fd0fffff 64bit]: from Enhanced Allocation, properties 0x0
>     7.545736] pci 0002:18:00.0: VF BAR 4 [mem 0x857202000000-0x857203ffffff 64bit]: from Enhanced Allocation, properties 0x4
>     7.557062] pci 0002:19:00.0: [177d:a0fb] type 00 class 0x088000 PCIe Endpoint
>     7.564314] pci 0002:19:00.0: BAR 2 [mem 0x858200000000-0x858201ffffff 64bit]: from Enhanced Allocation, properties 0x0
>     7.575100] pci 0002:19:00.0: BAR 4 [mem 0x9fd100000-0x9fd17ffff 64bit]: from Enhanced Allocation, properties 0x0
>     7.585364] pci 0002:19:00.0: VF BAR 4 [mem 0x858202000000-0x858203ffffff 64bit]: from Enhanced Allocation, properties 0x4
>     7.596613] pci_bus 0002:07: busn_res: [bus 07] end is updated to 07
>     7.603026] pci 0002:00:00.0: PCI bridge to [bus fa]
>     7.607998] pci 0002:00:01.0: PCI bridge to [bus fb]
>     7.612964] pci 0002:00:02.0: PCI bridge to [bus fc]
>     7.617929] pci 0002:00:03.0: PCI bridge to [bus fd]
>     7.622893] pci 0002:00:04.0: PCI bridge to [bus fe]
>     7.627859] pci 0002:00:05.0: PCI bridge to [bus ff]
>     7.632826] pci 0002:00:07.0: PCI bridge to [bus 01]
>     7.637793] pci 0002:00:08.0: PCI bridge to [bus 02]
>     7.642763] pci 0002:00:09.0: PCI bridge to [bus 03]
>     7.647729] pci 0002:00:0a.0: PCI bridge to [bus 04]
>     7.652698] pci 0002:00:0b.0: PCI bridge to [bus 05]
>     7.657664] pci 0002:00:0c.0: PCI bridge to [bus 06]
>     7.662631] pci 0002:00:0d.0: PCI bridge to [bus 07]
>     7.667599] pci 0002:00:0e.0: PCI bridge to [bus 08]
>     7.672566] pci 0002:00:0f.0: PCI bridge to [bus 09]
>     7.677534] pci 0002:00:10.0: PCI bridge to [bus 0a]
>     7.682500] pci 0002:00:11.0: PCI bridge to [bus 0b]
>     7.687467] pci 0002:00:12.0: PCI bridge to [bus 0c]
>     7.692433] pci 0002:00:13.0: PCI bridge to [bus 0d]
>     7.697399] pci 0002:00:14.0: PCI bridge to [bus 0e]
>     7.702365] pci 0002:00:15.0: PCI bridge to [bus 0f]
>     7.707331] pci 0002:00:16.0: PCI bridge to [bus 10]
>     7.712301] pci 0002:00:17.0: PCI bridge to [bus 11]
>     7.717269] pci 0002:00:18.0: PCI bridge to [bus 12]
>     7.722238] pci 0002:00:19.0: PCI bridge to [bus 13]
>     7.727204] pci 0002:00:1a.0: PCI bridge to [bus 14]
>     7.732173] pci 0002:00:1b.0: PCI bridge to [bus 15]
>     7.737140] pci 0002:00:1c.0: PCI bridge to [bus 16]
>     7.742107] pci 0002:00:1d.0: PCI bridge to [bus 17]
>     7.747074] pci 0002:00:1e.0: PCI bridge to [bus 18]
>     7.752040] pci 0002:00:1f.0: PCI bridge to [bus 19]
>     7.757004] pci_bus 0002:00: resource 4 [mem 0x840000000000-0x85f4ffffffff]
>     7.763966] pci_bus 0002:00: resource 5 [mem 0x9fc000000-0x9ff03ffff]
>     7.771411] pci-host-generic 878010000000.pci: host bridge /soc@0/pci@878010000000 ranges:
>     7.779698] pci-host-generic 878010000000.pci:      MEM 0x868000000000..0x869fffffffff -> 0x868000000000
>     7.789196] pci-host-generic 878010000000.pci:      MEM 0x87e0fe9c0000..0x87e0fe9cffff -> 0x87e0fe9c0000
>     7.798690] pci-host-generic 878010000000.pci:      MEM 0x8e0000000000..0x8e003fffffff -> 0x8e0000000000
>     7.808185] pci-host-generic 878010000000.pci:      MEM 0x8e1000000000..0x8e103fffffff -> 0x8e1000000000
>     7.817682] pci-host-generic 878010000000.pci:      MEM 0x8e2000000000..0x8e203fffffff -> 0x8e2000000000
>     7.827204] pci-host-generic 878010000000.pci:      MEM 0x8e3000000000..0x8e303fffffff -> 0x8e3000000000
>     7.836700] pci-host-generic 878010000000.pci:      MEM 0x8e4000000000..0x8e403fffffff -> 0x8e4000000000
>     7.846194] pci-host-generic 878010000000.pci:      MEM 0x8e5000000000..0x8e503fffffff -> 0x8e5000000000
>     7.855687] pci-host-generic 878010000000.pci:      MEM 0x8e0f00000000..0x8e0f000fffff -> 0x8e0f00000000
>     7.865183] pci-host-generic 878010000000.pci:      MEM 0x8e1f00000000..0x8e1f000fffff -> 0x8e1f00000000
>     7.874678] pci-host-generic 878010000000.pci:      MEM 0x8e2f00000000..0x8e2f000fffff -> 0x8e2f00000000
>     7.884174] pci-host-generic 878010000000.pci:      MEM 0x8e3f00000000..0x8e3f000fffff -> 0x8e3f00000000
>     7.893676] pci-host-generic 878010000000.pci:      MEM 0x8e4f00000000..0x8e4f000fffff -> 0x8e4f00000000
>     7.903178] pci-host-generic 878010000000.pci:      MEM 0x8e5f00000000..0x8e5f000fffff -> 0x8e5f00000000
>     7.912696] pci-host-generic 878010000000.pci: Memory resource size exceeds max for 32 bits
>     7.923710] pci-host-generic 878010000000.pci: ECAM at [mem 0x878010000000-0x87801fffffff] for [bus 00-ff]
>     7.933508] pci-host-generic 878010000000.pci: PCI host bridge to bus 0001:00
>     7.940652] pci_bus 0001:00: root bus resource [bus 00-ff]
>     7.946138] pci_bus 0001:00: root bus resource [mem 0x868000000000-0x869fffffffff]
>     7.953709] pci_bus 0001:00: root bus resource [mem 0x87e0fe9c0000-0x87e0fe9cffff]
>     7.961282] pci_bus 0001:00: root bus resource [mem 0x8e0000000000-0x8e003fffffff]
>     7.968852] pci_bus 0001:00: root bus resource [mem 0x8e1000000000-0x8e103fffffff]
>     7.976422] pci_bus 0001:00: root bus resource [mem 0x8e2000000000-0x8e203fffffff]
>     7.983998] pci_bus 0001:00: root bus resource [mem 0x8e3000000000-0x8e303fffffff]
>     7.991570] pci_bus 0001:00: root bus resource [mem 0x8e4000000000-0x8e403fffffff]
>     7.999141] pci_bus 0001:00: root bus resource [mem 0x8e5000000000-0x8e503fffffff]
>     8.006717] pci_bus 0001:00: root bus resource [mem 0x8e0f00000000-0x8e0f000fffff]
>     8.014288] pci_bus 0001:00: root bus resource [mem 0x8e1f00000000-0x8e1f000fffff]
>     8.021866] pci_bus 0001:00: root bus resource [mem 0x8e2f00000000-0x8e2f000fffff]
>     8.029444] pci_bus 0001:00: root bus resource [mem 0x8e3f00000000-0x8e3f000fffff]
>     8.037044] pci_bus 0001:00: root bus resource [mem 0x8e4f00000000-0x8e4f000fffff]
>     8.044617] pci_bus 0001:00: root bus resource [mem 0x8e5f00000000-0x8e5f000fffff]
>     8.053415] pci 0001:00:0c.0: [177d:a01b] type 00 class 0x0c0330 PCIe Root Complex Integrated Endpoint
>     8.062758] pci 0001:00:0c.0: BAR 0 [mem 0x868000000000-0x8680001fffff 64bit]: from Enhanced Allocation, properties 0x0
>     8.073545] pci 0001:00:0c.0: BAR 4 [mem 0x868000200000-0x8680002fffff 64bit]: from Enhanced Allocation, properties 0x0
>     8.084523] pci 0001:00:0d.0: [177d:a01b] type 00 class 0x0c0330 PCIe Root Complex Integrated Endpoint
>     8.093861] pci 0001:00:0d.0: BAR 0 [mem 0x869000000000-0x8690001fffff 64bit]: from Enhanced Allocation, properties 0x0
>     8.104648] pci 0001:00:0d.0: BAR 4 [mem 0x869000200000-0x8690002fffff 64bit]: from Enhanced Allocation, properties 0x0
>     8.115816] pci 0001:00:10.0: [177d:a06c] type 00 class 0x088000 PCIe Root Complex Integrated Endpoint
>     8.125154] pci 0001:00:10.0: BAR 0 [mem 0x8e0000000000-0x8e003fffffff 64bit]: from Enhanced Allocation, properties 0x0
>     8.135949] pci 0001:00:10.0: BAR 4 [mem 0x8e0f00000000-0x8e0f000fffff 64bit]: from Enhanced Allocation, properties 0x0
>     8.148450] pci_bus 0001:00: resource 4 [mem 0x868000000000-0x869fffffffff]
>     8.155425] pci_bus 0001:00: resource 5 [mem 0x87e0fe9c0000-0x87e0fe9cffff]
>     8.162389] pci_bus 0001:00: resource 6 [mem 0x8e0000000000-0x8e003fffffff]
>     8.169356] pci_bus 0001:00: resource 7 [mem 0x8e1000000000-0x8e103fffffff]
>     8.176318] pci_bus 0001:00: resource 8 [mem 0x8e2000000000-0x8e203fffffff]
>     8.183280] pci_bus 0001:00: resource 9 [mem 0x8e3000000000-0x8e303fffffff]
>     8.190242] pci_bus 0001:00: resource 10 [mem 0x8e4000000000-0x8e403fffffff]
>     8.197293] pci_bus 0001:00: resource 11 [mem 0x8e5000000000-0x8e503fffffff]
>     8.204343] pci_bus 0001:00: resource 12 [mem 0x8e0f00000000-0x8e0f000fffff]
>     8.211393] pci_bus 0001:00: resource 13 [mem 0x8e1f00000000-0x8e1f000fffff]
>     8.218442] pci_bus 0001:00: resource 14 [mem 0x8e2f00000000-0x8e2f000fffff]
>     8.225491] pci_bus 0001:00: resource 15 [mem 0x8e3f00000000-0x8e3f000fffff]
>     8.232539] pci_bus 0001:00: resource 16 [mem 0x8e4f00000000-0x8e4f000fffff]
>     8.239594] pci_bus 0001:00: resource 17 [mem 0x8e5f00000000-0x8e5f000fffff]
>     8.249461] octeontx2-sdp
>     8.252320] octeontx2-dpi: Marvell OcteonTX2 DPI-DMA Driver
>     8.258051] pci-console-nexus 20060000.pci-console-nexus: Registering child console driver...
>     8.266902] pci-console 20060100.pci-console: Initialized console 0, address 0x20060100, size: 0x4000
>     8.276342] pci-console 20064100.pci-console: Ignoring excluded console 1
>     8.283322] pci-console 20068100.pci-console: Ignoring excluded console 2
>     8.290295] pci-console 2006c100.pci-console: Ignoring excluded console 3
>     8.297267] pci-console 20070100.pci-console: Ignoring excluded console 4
>     8.304230] pci-console 20074100.pci-console: Ignoring excluded console 5
>     8.311214] pci-console 20078100.pci-console: Ignoring excluded console 6
>     8.318289] octtx_info: Added /proc/octtx_info
>     8.321257] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
>     8.335231] arm-smmu-v3 830000000000.smmu: ias 52-bit, oas 52-bit (features 0x001cd78d)
>     8.343546] arm-smmu-v3 830000000000.smmu: allocated 524288 entries for cmdq
>     8.351179] arm-smmu-v3 830000000000.smmu: allocated 524288 entries for evtq
>     8.365882] brd: module loaded
>     8.376659] loop: module loaded
>     8.399794] megaraid cmm: 2.20.2.7 (Release Date: Sun Jul 16 00:01:03 EST 2006)
>     8.407232] megaraid: 2.20.5.1 (Release Date: Thu Nov 16 15:32:35 EST 2006)
>     8.414278] megasas: 07.727.03.00-rc1
>     8.418059] mpt3sas version 48.100.00.00 loaded
>     8.425040] mtd device must be supplied (device name is empty)
>     8.431294] cadence-xspi-cn10xx 804000000000.spi: Adding to iommu group 0
>     8.438541] cadence-xspi-cn10xx 804000000000.spi: FW does not support memory lock
>     8.456169] cadence-xspi-cn10xx 804000000000.spi: PHY configuration
>     8.462442] cadence-xspi-cn10xx 804000000000.spi:    * xspi_dll_phy_ctrl: 01000707
>     8.470019] cadence-xspi-cn10xx 804000000000.spi:    * phy_dq_timing: 00000101
>     8.477249] cadence-xspi-cn10xx 804000000000.spi:    * phy_dqs_timing: 00700404
>     8.484560] cadence-xspi-cn10xx 804000000000.spi:    * phy_gate_loopback_ctrl: 00200030
>     8.492566] cadence-xspi-cn10xx 804000000000.spi:    * phy_dll_slave_ctrl: 0000ff01
>     8.502844] cadence-xspi-cn10xx 804000000000.spi: Successfully registered SPI host
>     8.510513] cadence-xspi-cn10xx 805000000000.spi: Adding to iommu group 1
>     8.517724] cadence-xspi-cn10xx 805000000000.spi: FW does not support memory lock
>     8.535322] cadence-xspi-cn10xx 805000000000.spi: PHY configuration
>     8.541592] cadence-xspi-cn10xx 805000000000.spi:    * xspi_dll_phy_ctrl: 01000707
>     8.549167] cadence-xspi-cn10xx 805000000000.spi:    * phy_dq_timing: 00000101
>     8.556396] cadence-xspi-cn10xx 805000000000.spi:    * phy_dqs_timing: 00700404
>     8.563709] cadence-xspi-cn10xx 805000000000.spi:    * phy_gate_loopback_ctrl: 00200030
>     8.571714] cadence-xspi-cn10xx 805000000000.spi:    * phy_dll_slave_ctrl: 0000ff01
>     8.582378] cadence-xspi-cn10xx 805000000000.spi: Successfully registered SPI host
>     8.590798] MACsec IEEE 802.1AE
>     8.597576] mdio_thunder 0000:01:01.3: Adding to iommu group 2
>     8.604317] mdio_thunder 0000:01:01.3: Added bus at 87e005003800
>     8.610746] mdio_thunder 0000:01:01.3: Added bus at 87e005003880
>     8.616758] mdio_thunder 0000:01:01.3: Couldn't translate address for "mdio0_uio"
>     8.624652] tun: Universal TUN/TAP device driver, 1.6
>     8.630526] thunder_xcv, ver 1.0
>     8.633829] thunder_bgx, ver 1.0
>     8.637126] nicpf, ver 1.0
>     8.639908] nicvf, ver 1.0
>     8.642936] e100: Intel(R) PRO/100 Network Driver
>     8.647645] e100: Copyright(c) 1999-2006 Intel Corporation
>     8.653230] e1000: Intel(R) PRO/1000 Network Driver
>     8.658109] e1000: Copyright (c) 1999-2006 Intel Corporation.
>     8.663976] e1000e: Intel(R) PRO/1000 Network Driver
>     8.668942] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
>     8.675008] igb: Intel(R) Gigabit Ethernet Network Driver
>     8.680408] igb: Copyright (c) 2007-2014 Intel Corporation.
>     8.686082] igbvf: Intel(R) Gigabit Virtual Function Network Driver
>     8.692351] igbvf: Copyright (c) 2009 - 2012 Intel Corporation.
>     8.698334] ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver
>     8.704429] ixgbe: Copyright (c) 1999-2016 Intel Corporation.
>     8.710350] ixgbevf: Intel(R) 10 Gigabit PCI Express Virtual Function Network Driver
>     8.718103] ixgbevf: Copyright (c) 2009 - 2018 Intel Corporation.
>     8.724334] i40e: Intel(R) Ethernet Connection XL710 Network Driver
>     8.730607] i40e: Copyright (c) 2013 - 2019 Intel Corporation.
>     8.736557] iavf: Intel(R) Ethernet Adaptive Virtual Function Network Driver
>     8.743612] Copyright (c) 2013 - 2018 Intel Corporation.
>     8.748990] Intel(R) Ethernet Switch Host Interface Driver
>     8.754475] Copyright(c) 2013 - 2019 Intel Corporation.
>     8.760121] sky2: driver version 1.30
>     8.763889] rvu_af: Marvell OcteonTX2 RVU Admin Function Driver
>     8.769956] Marvell-CGX-RPM 0000:01:10.0: Adding to iommu group 3
>     9.821769] Marvell-CGX-RPM 0000:01:10.1: Adding to iommu group 4
>    10.821884] Marvell PTP Driver 0000:00:08.0: Adding to iommu group 5
>    10.828988] rvu_af 0002:01:00.0: Adding to iommu group 6
>    11.322805] rvu_af 0002:01:00.0: Using default mkex profile
>    11.438588] pci 0002:01:00.1: [177d:a0f7] type 00 class 0x020000 PCIe Endpoint
>    11.446136] pci 0002:01:00.2: [177d:a0f7] type 00 class 0x020000 PCIe Endpoint
>    11.453605] pci 0002:01:00.3: [177d:a0f7] type 00 class 0x020000 PCIe Endpoint
>    11.461123] pci 0002:01:00.4: [177d:a0f7] type 00 class 0x020000 PCIe Endpoint
>    11.468581] pci 0002:01:00.5: [177d:a0f7] type 00 class 0x020000 PCIe Endpoint
>    11.476070] pci 0002:01:00.6: [177d:a0f7] type 00 class 0x020000 PCIe Endpoint
>    11.483523] pci 0002:01:00.7: [177d:a0f7] type 00 class 0x020000 PCIe Endpoint
>    11.490973] pci 0002:01:01.0: [177d:a0f7] type 00 class 0x020000 PCIe Endpoint
>    11.498416] pci 0002:01:01.1: [177d:a0f7] type 00 class 0x020000 PCIe Endpoint
>    11.506244] rvu_nicpf: Marvell RVU NIC Physical Function Driver
>    11.512349] rvu_nicpf 0002:02:00.0: Adding to iommu group 7
>    11.546556] rvu_nicpf 0002:03:00.0: Adding to iommu group 8
>    11.580659] rvu_nicpf 0002:04:00.0: Adding to iommu group 9
>    11.614621] rvu_nicvf: Marvell RVU NIC Virtual Function Driver
>    11.620620] rvu_nicvf 0002:01:00.1: Adding to iommu group 10
>    11.626673] rvu_nicvf 0002:01:00.1: enabling device (0000 -> 0002)
>    11.671999] rvu_nicvf 0002:01:00.2: Adding to iommu group 11
>    11.678043] rvu_nicvf 0002:01:00.2: enabling device (0000 -> 0002)
>    11.724999] rvu_nicvf 0002:01:00.3: Adding to iommu group 12
>    11.731031] rvu_nicvf 0002:01:00.3: enabling device (0000 -> 0002)
>    11.777495] rvu_nicvf 0002:01:00.4: Adding to iommu group 13
>    11.783555] rvu_nicvf 0002:01:00.4: enabling device (0000 -> 0002)
>    12.031568] rvu_nicvf 0002:01:00.5: Adding to iommu group 14
>    12.037598] rvu_nicvf 0002:01:00.5: enabling device (0000 -> 0002)
>    12.085009] rvu_nicvf 0002:01:00.6: Adding to iommu group 15
>    12.091035] rvu_nicvf 0002:01:00.6: enabling device (0000 -> 0002)
>    12.140672] rvu_nicvf 0002:01:00.7: Adding to iommu group 16
>    12.146704] rvu_nicvf 0002:01:00.7: enabling device (0000 -> 0002)
>    12.192367] rvu_nicvf 0002:01:01.0: Adding to iommu group 17
>    12.198391] rvu_nicvf 0002:01:01.0: enabling device (0000 -> 0002)
>    12.246526] rvu_nicvf 0002:01:01.1: Adding to iommu group 18
>    12.252575] rvu_nicvf 0002:01:01.1: enabling device (0000 -> 0002)
>    12.300038] octeontx2-bphy-netdev: Marvell OcteonTX2 BPHY Ethernet Driver
>    12.306977] cnf20k_cpri: cnf20K_cpri_driver
>    12.311246] rvu_bphy_nicpf: Marvell BPHY RVU PF Ethernet Driver
>    12.318297] PPP generic driver version 2.4.2
>    12.322714] PPP BSD Compression module registered
>    12.327422] PPP Deflate Compression module registered
>    12.332521] PPP MPPE Compression module registered
>    12.337313] NET: Registered PF_PPPOX protocol family
>    12.342291] pegasus: Pegasus/Pegasus II USB Ethernet driver
>    12.347913] usbcore: registered new interface driver pegasus
>    12.353615] usbcore: registered new interface driver rtl8150
>    12.359290] usbcore: registered new device driver r8152-cfgselector
>    12.365597] usbcore: registered new interface driver r8152
>    12.371121] usbcore: registered new interface driver asix
>    12.376560] usbcore: registered new interface driver ax88179_178a
>    12.382705] usbcore: registered new interface driver dm9601
>    12.388320] usbcore: registered new interface driver CoreChips
>    12.394193] usbcore: registered new interface driver smsc75xx
>    12.399978] usbcore: registered new interface driver smsc95xx
>    12.405765] usbcore: registered new interface driver net1080
>    12.411463] usbcore: registered new interface driver plusb
>    12.416996] usbcore: registered new interface driver MOSCHIP usb-ethernet driver
>    12.424611] VFIO - User Level meta-driver version: 0.3
>    12.431869] xhci_hcd 0001:00:0c.0: Adding to iommu group 19
>    12.437915] xhci_hcd 0001:00:0c.0: xHCI Host Controller
>    12.443170] xhci_hcd 0001:00:0c.0: new USB bus registered, assigned bus number 1
>    12.450791] xhci_hcd 0001:00:0c.0: hcc params 0x0110ffcd hci version 0x110 quirks 0x0000000000000010
>    12.460327] xhci_hcd 0001:00:0c.0: xHCI Host Controller
>    12.465571] xhci_hcd 0001:00:0c.0: new USB bus registered, assigned bus number 2
>    12.472982] xhci_hcd 0001:00:0c.0: Host supports USB 3.1 Enhanced SuperSpeed
>    12.480578] hub 1-0:1.0: USB hub found
>    12.484365] hub 1-0:1.0: 1 port detected
>    12.488650] usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
>    12.497236] hub 2-0:1.0: USB hub found
>    12.501021] hub 2-0:1.0: 1 port detected
>    12.505397] xhci_hcd 0001:00:0d.0: Adding to iommu group 20
>    12.511391] xhci_hcd 0001:00:0d.0: xHCI Host Controller
>    12.516636] xhci_hcd 0001:00:0d.0: new USB bus registered, assigned bus number 3
>    12.622309] xhci_hcd 0001:00:0d.0: hcc params 0x0110ffc5 hci version 0x110 quirks 0x0000000000000010
>    12.631827] xhci_hcd 0001:00:0d.0: xHCI Host Controller
>    12.637079] xhci_hcd 0001:00:0d.0: new USB bus registered, assigned bus number 4
>    12.644520] xhci_hcd 0001:00:0d.0: Host supports USB 3.1 Enhanced SuperSpeed
>    12.652051] hub 3-0:1.0: USB hub found
>    12.655838] hub 3-0:1.0: 1 port detected
>    12.660077] usb usb4: We don't know the algorithms for LPM for this host, disabling LPM.
>    12.668619] hub 4-0:1.0: USB hub found
>    12.672399] hub 4-0:1.0: 1 port detected
>    12.676966] usbcore: registered new interface driver usb-storage
>    12.684607] mousedev: PS/2 mouse device common for all mice
>    12.690776] i2c_dev: i2c /dev entries driver
>    12.695913] i2c-thunderx 0000:01:18.0: Adding to iommu group 21
>    12.702696] i2c-thunderx 0000:01:18.0: Probed. Set system clock to 100000000
>    12.709759] i2c-thunderx 0000:01:18.0: SMBUS alert not active on this bus
>    12.716714] i2c-thunderx 0000:01:18.1: Adding to iommu group 21
>    12.724029] rtc-ds1307 1-0068: SET TIME!
>    12.730053] rtc-ds1307 1-0068: registered as rtc0
>    12.735707] rtc-ds1307 1-0068: setting system clock to 2000-01-01T00:05:19 UTC (946685119)
>    12.744011] i2c-thunderx 0000:01:18.1: Probed. Set system clock to 100000000
>    12.751074] i2c-thunderx 0000:01:18.1: SMBUS alert not active on this bus
>    12.758020] i2c-thunderx 0000:01:18.2: Adding to iommu group 21
>    12.764368] i2c-thunderx 0000:01:18.2: Probed. Set system clock to 100000000
>    12.771441] i2c-thunderx 0000:01:18.2: SMBUS alert not active on this bus
>    12.778373] i2c-thunderx 0000:01:18.4: Adding to iommu group 21
>    12.784774] i2c-thunderx 0000:01:18.4: Probed. Set system clock to 100000000
>    12.791857] i2c-thunderx 0000:01:18.4: SMBUS alert not active on this bus
>    12.798790] i2c-thunderx 0000:01:18.5: Adding to iommu group 21
>    12.805111] i2c-thunderx 0000:01:18.5: Probed. Set system clock to 100000000
>    12.812177] i2c-thunderx 0000:01:18.5: SMBUS alert not active on this bus
>    12.819156] i2c-thunderx 0000:01:18.6: Adding to iommu group 21
>    12.825505] i2c-thunderx 0000:01:18.6: Probed. Set system clock to 100000000
>    12.832583] i2c-thunderx 0000:01:18.6: SMBUS alert not active on this bus
>    12.839508] i2c-thunderx 0000:01:18.7: Adding to iommu group 21
>    12.845829] i2c-thunderx 0000:01:18.7: Probed. Set system clock to 100000000
>    12.852903] i2c-thunderx 0000:01:18.7: SMBUS alert not active on this bus
>    12.860024] i2c-thunderx 0000:01:19.0: Adding to iommu group 22
>    12.866735] i2c-thunderx 0000:01:19.0: Probed. Set system clock to 100000000
>    12.873803] i2c-thunderx 0000:01:19.0: SMBUS alert not active on this bus
>    12.880754] i2c-thunderx 0000:01:19.1: Adding to iommu group 22
>    12.887085] i2c-thunderx 0000:01:19.1: Probed. Set system clock to 100000000
>    12.894151] i2c-thunderx 0000:01:19.1: SMBUS alert not active on this bus
>    12.901086] i2c-thunderx 0000:01:19.2: Adding to iommu group 22
>    12.907467] i2c-thunderx 0000:01:19.2: Probed. Set system clock to 100000000
>    12.914550] i2c-thunderx 0000:01:19.2: SMBUS alert not active on this bus
>    12.921489] i2c-thunderx 0000:01:19.3: Adding to iommu group 22
>    12.927844] i2c-thunderx 0000:01:19.3: Probed. Set system clock to 100000000
>    12.934913] i2c-thunderx 0000:01:19.3: SMBUS alert not active on this bus
>    12.942219] sbsa-gwdt 8020000a0000.watch-dog: Using Clock data from device node.
>    12.949823] sbsa-gwdt 8020000a0000.watch-dog: Initialized with 10s timeout @ 1000000000 Hz, action=0.
>    12.959462] gti-wdt 802000040000.watchdog: Watchdog enabled (timeout=17 sec)
>    12.966958] device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) initialised: dm-devel@lists.linux.dev
>    12.976158] sdhci: Secure Digital Host Controller Interface driver
>    12.982350] sdhci: Copyright(c) Pierre Ossman
>    12.986860] Synopsys Designware Multimedia Card Interface Driver
>    12.993322] sdhci-pltfm: SDHCI platform and OF driver helper
>    12.999132] sdhci-cdns 824000000000.sdhci: Adding to iommu group 23
>    12.999885] SMCCC: SOC_ID: ID = jep106:0369:00b9 Revision = 0x00000008
>    13.008599] sdhci_cdns_sd6_get_delay_params: Get Tuning params: Start[16], Step[6], Iterations[40].
>    13.012653] fw memtest: Power on self test configuration for memory is not set!
>    13.020995] sdhci_cdns_sd6_get_delay_params: Selected Tuning params: Start[16], Step[6], Iterations[40].
>    13.038758] usbcore: registered new interface driver usbhid
>    13.044342] usbhid: USB HID core driver
>    13.046540] mmc0: SDHCI controller on 824000000000.sdhci [824000000000.sdhci] using ADMA 64-bit
>    13.048481] mvl-mhu 0000:00:1c.0: Adding to iommu group 24
>    13.063241] mvl-mhu 0000:00:1d.0: Adding to iommu group 25
>    13.069234] mvl-mhu 0000:00:1e.0: Adding to iommu group 26
>    13.075994] hw perfevents: enabled with armv8_pmuv3 PMU driver, 7 (0,8000003f) counters available
>    13.085999] arm-smmu-v3-pmcg 830000100000.smmupmcg0: Registered PMU @ 0x0000830000100000 using 4 counters with Global(Counter0) filter settings
>    13.099195] arm-smmu-v3-pmcg 830000120000.smmupmcg1: Registered PMU @ 0x0000830000120000 using 4 counters with Global(Counter0) filter settings
>    13.112349] arm-smmu-v3-pmcg 830000140000.smmupmcg2: Registered PMU @ 0x0000830000140000 using 4 counters with Global(Counter0) filter settings
>    13.125513] arm-smmu-v3-pmcg 830000160000.smmupmcg3: Registered PMU @ 0x0000830000160000 using 4 counters with Global(Counter0) filter settings
>    13.138590] arm_spe_pmu spe-pmu: probed SPEv1.1 for CPUs 0-23 [max_record_sz 64, align 64, features 0x17]
>    13.144417] mmc0: new HS400 Enhanced strobe MMC card at address 0001
>    13.155086] mmcblk0: mmc0:0001 032G01 29.1 GiB
>    13.155718] DDR PMU Driver for ddrc@87e1c0000000
>    13.164759] DDR PMU Driver for ddrc@87e1c1000000
>    13.169958] DDR PMU Driver for ddrc@87e1c2000000
>    13.175114] DDR PMU Driver for ddrc@87e1c3000000
>    13.180301] DDR PMU Driver for ddrc@87e1c4000000
>    13.185459] DDR PMU Driver for ddrc@87e1c5000000
>    13.190477]  cs_system_cfg: CoreSight Configuration manager initialised
>    13.195412]  mmcblk0: p2
>    13.200030] mmcblk0boot0: mmc0:0001 032G01 8.00 MiB
>    13.200101] coresight-tmc 87a100060000.sh_etr: Adding to iommu group 27
>    13.206637] mmcblk0boot1: mmc0:0001 032G01 8.00 MiB
>    13.212057] coresight-tmc 87a100060000.sh_etr: Detected dma mask 52bits
>    13.217977] mmcblk0rpmb: mmc0:0001 032G01 4.00 MiB, chardev (237:0)
>    13.229763] CSCFG registered ete0
>    13.229769] coresight ete0: CPU0: ete v1.0 initialized
>    13.238849] CSCFG registered ete1
>    13.238855] coresight ete1: CPU1: ete v1.0 initialized
>    13.247769] CSCFG registered ete2
>    13.247773] coresight ete2: CPU2: ete v1.0 initialized
>    13.256831] CSCFG registered ete3
>    13.256836] coresight ete3: CPU3: ete v1.0 initialized
>    13.268407] coresight cti_cpu0: CTI initialized
>    13.273379] coresight cti_sys0: CTI initialized
>    13.278311] coresight cti_cpu1: CTI initialized
>    13.283199] coresight cti_sys1: CTI initialized
>    13.288173] coresight cti_cpu2: CTI initialized
>    13.293053] coresight cti_sys2: CTI initialized
>    13.297979] coresight cti_cpu3: CTI initialized
>    13.303191] coresight cti_sys3: CTI initialized
>    13.308063] coresight cti_sys4: CTI initialized
>    13.312945] coresight cti_sys5: CTI initialized
>    13.317833] coresight cti_sys6: CTI initialized
>    13.322707] coresight cti_sys7: CTI initialized
>    13.327573] coresight cti_sys8: CTI initialized
>    13.332471] coresight cti_sys9: CTI initialized
>    13.337362] coresight cti_sys10: CTI initialized
>    13.342336] coresight cti_sys11: CTI initialized
>    13.347297] coresight cti_sys12: CTI initialized
>    13.352265] coresight cti_sys13: CTI initialized
>    13.357262] coresight cti_sys14: CTI initialized
>    13.362253] coresight cti_sys15: CTI initialized
>    13.367244] coresight cti_sys16: CTI initialized
>    13.372201] coresight cti_sys17: CTI initialized
>    13.377248] coresight cti_sys18: CTI initialized
>    13.382254] coresight cti_sys19: CTI initialized
>    13.387233] coresight cti_sys20: CTI initialized
>    13.392199] coresight cti_sys21: CTI initialized
>    13.397187] coresight cti_sys22: CTI initialized
>    13.402156] coresight cti_sys23: CTI initialized
>    13.407171] coresight cti_sys24: CTI initialized
>    13.411864] optee: probing for conduit method.
>    13.416317] optee: api uid mismatch
>    13.419814] optee firmware:optee: probe with driver optee failed with error -22
>    13.427261] GACT probability NOT on
>    13.430762] Mirror/redirect action on
>    13.434461] u32 classifier
>    13.437171]     input device check on
>    13.440830]     Actions configured
>    13.446228] gre: GRE over IPv4 demultiplexor driver
>    13.451187] Initializing XFRM netlink socket
>    13.455523] NET: Registered PF_INET6 protocol family
>    13.463127] Segment Routing with IPv6
>    13.466844] In-situ OAM (IOAM) with IPv6
>    13.470852] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
>    13.477836] ip6_gre: GRE over IPv6 tunneling driver
>    13.483324] NET: Registered PF_PACKET protocol family
>    13.488417] NET: Registered PF_KEY protocol family
>    13.493247] Bridge firewalling registered
>    13.497298] 8021q: 802.1Q VLAN Support v1.8
>    13.501545] sctp: Hash tables configured (bind 4096/4096)
>    13.507067] 9pnet: Installing 9P2000 support
>    13.511382] Key type dns_resolver registered
>    13.515652] mpls_gso: MPLS GSO support
>    13.537829] registered taskstats version 1
>    13.543326] Loading compiled-in X.509 certificates
>    13.569329] Demotion targets for Node 0: null
>    13.575805] Btrfs loaded, zoned=no, fsverity=no
>    13.581409] bed-bert:BERT: 0x9f7afe800/0x1800
>    13.585789] bed-bert:BERT block VA=0xffff80008e53e800
>    13.590983] [Firmware Bug]: Truncated status block (length: 2779096505).
>    13.597986] pcieport 0000:00:01.0: Adding to iommu group 28
>    13.604182] pcieport 0000:00:0c.0: Adding to iommu group 29
>    13.610309] pcieport 0000:00:0d.0: Adding to iommu group 30
>    13.616428] pcieport 0000:00:0e.0: Adding to iommu group 31
>    13.622547] pcieport 0000:00:0f.0: Adding to iommu group 32
>    13.628659] gpio_thunderx 0000:00:11.0: Adding to iommu group 33
>    13.639521] gpio_thunderx 0000:00:11.0: ThunderX GPIO: 76 lines with base 512.
>    13.646917] pcieport 0000:00:14.0: Adding to iommu group 34
>    13.653036] pcieport 0002:00:00.0: Adding to iommu group 35
>    13.659140] pcieport 0002:00:01.0: Adding to iommu group 36
>    13.665234] pcieport 0002:00:02.0: Adding to iommu group 37
>    13.671338] pcieport 0002:00:03.0: Adding to iommu group 38
>    13.677445] pcieport 0002:00:04.0: Adding to iommu group 39
>    13.683543] pcieport 0002:00:05.0: Adding to iommu group 40
>    13.689633] pcieport 0002:00:06.0: Adding to iommu group 41
>    13.695780] pcieport 0002:00:07.0: Adding to iommu group 42
>    13.701881] pcieport 0002:00:08.0: Adding to iommu group 43
>    13.707976] pcieport 0002:00:09.0: Adding to iommu group 44
>    13.714067] pcieport 0002:00:0a.0: Adding to iommu group 45
>    13.720155] pcieport 0002:00:0b.0: Adding to iommu group 46
>    13.726281] pcieport 0002:00:0c.0: Adding to iommu group 47
>    13.732381] pcieport 0002:00:0d.0: Adding to iommu group 48
>    13.738469] pcieport 0002:00:0e.0: Adding to iommu group 49
>    13.744562] pcieport 0002:00:0f.0: Adding to iommu group 50
>    13.750680] pcieport 0002:00:10.0: Adding to iommu group 51
>    13.756757] pcieport 0002:00:11.0: Adding to iommu group 52
>    13.762867] pcieport 0002:00:12.0: Adding to iommu group 53
>    13.768947] pcieport 0002:00:13.0: Adding to iommu group 54
>    13.775047] pcieport 0002:00:14.0: Adding to iommu group 55
>    13.781155] pcieport 0002:00:15.0: Adding to iommu group 56
>    13.787260] pcieport 0002:00:16.0: Adding to iommu group 57
>    13.793350] pcieport 0002:00:17.0: Adding to iommu group 58
>    13.799490] pcieport 0002:00:18.0: Adding to iommu group 59
>    13.805604] pcieport 0002:00:19.0: Adding to iommu group 60
>    13.811708] pcieport 0002:00:1a.0: Adding to iommu group 61
>    13.817801] pcieport 0002:00:1b.0: Adding to iommu group 62
>    13.823887] pcieport 0002:00:1c.0: Adding to iommu group 63
>    13.829992] pcieport 0002:00:1d.0: Adding to iommu group 64
>    13.836084] pcieport 0002:00:1e.0: Adding to iommu group 65
>    13.842165] pcieport 0002:00:1f.0: Adding to iommu group 66
>    13.848268] octeontx2-dpi 0000:06:00.0: Adding to iommu group 67
>    13.902589] cn10k_rng 0000:05:00.0: Adding to iommu group 68
>    13.911174] arm-scmi arm-scmi.0.auto: Using scmi_mailbox_transport
>    13.917370] arm-scmi arm-scmi.0.auto: SCMI max-rx-timeout: 500ms
>    13.923798] arm-scmi arm-scmi.0.auto: SCMI Notifications - Core Enabled.
>    13.930688] arm-scmi arm-scmi.0.auto: SCMI Protocol v1.0 'Marvell:Marvell' Firmware version 0x1
>    13.950633] EDAC octeontx: old firmware detected will use ghes record old format
>    13.958035] EDAC octeontx: rec version:0
>    13.962633] EDAC MC0: Giving out device to module dss_edac controller dss: DEV dss (INTERRUPT)
>    13.971568] EDAC DEVICE1: Giving out device to module tad_edac controller tad: DEV tad (INTERRUPT)
>    13.981305] EDAC DEVICE2: Giving out device to module cpu_edac controller core: DEV core (INTERRUPT)
>    13.991275] EDAC DEVICE3: Giving out device to module gic_edac controller gic: DEV gic (INTERRUPT)
>    14.000473] ea_edac ea_edac: Unable find ghes
>    14.005094] EDAC DEVICE4: Giving out device to module mdc_edac controller mdc: DEV mdc (INTERRUPT)
>    14.014346] cfg80211: Loading compiled-in X.509 certificates for regulatory database
>    14.022934] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
>    14.029037] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c7248db18c600'
>    14.036337] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
>    14.038616] clk: Disabling unused clocks
>    14.044962] cfg80211: failed to load regulatory.db
>    14.049194] PM: genpd: Disabling unused power domains
>    14.058856] md: Waiting for all devices to be available before autodetect
>    14.065646] md: If you don't use raid, use raid=noautodetect
>    14.071304] md: Autodetecting RAID arrays.
>    14.075400] md: autorun ...
>    14.078187] md: ... autorun DONE.
>    14.216444] EXT4-fs (mmcblk0p2): recovery complete
>    14.221756] EXT4-fs (mmcblk0p2): mounted filesystem 2fc4cbdd-33a6-42d1-97a5-377bf2579bb7 r/w with ordered data mode. Quota mode: none.
>    14.233945] VFS: Mounted root (ext4 filesystem) on device 179:2.
>    14.240653] devtmpfs: mounted
>    14.244733] Freeing unused kernel memory: 19456K
>    14.249444] Run /sbin/init as init process
>    14.334654] EXT4-fs (mmcblk0p2): re-mounted 2fc4cbdd-33a6-42d1-97a5-377bf2579bb7.
> Starting rsyslogd: OK
> Running sysctl: OK
> Starting watchdog...
> Initializing random number generator: OK
> Saving random seed: OK
> Mounting cgroupfs hierarchy: OK
> Starting system message bus: done
> Starting rpcbind: OK
> Starting iptables: OK
> Starting network: OK
> Starting dhcpcd...
> dhcpcd-9.4.1 starting
> forked to background, child pid 263
> Starting mrouted: OK
> Starting ntpd: OK
> Starting dropbear sshd: OK
> Starting gpsd: OK
> Starting sshd: OK
> Starting stunnel: [ ] Initializing inetd mode configuration
> .] stunnel 5.71 on aarch64-buildroot-linux-gnu platform
> .] Compiled/running with OpenSSL 1.1.1h  22 Sep 2020
> .] Threading:FORK Sockets:POLL,IPv6 TLS:ENGINE,OCSP,PSK,SNI
>  ] errno: (*__errno_location ())
>  ] Initializing inetd mode configuration
> .] Reading configuration from file /etc/stunnel/stunnel.conf
> .] UTF-8 byte order mark detected
> .] FIPS mode disabled
>  ] Compression disabled
>  ] No PRNG seeding was required
>  ] Initializing service [gmail-pop3]
>  ] getaddrinfo: EAI_AGAIN received: retrying
>  ] getaddrinfo: EAI_AGAIN received: retrying
>  ] getaddrinfo: EAI_AGAIN received: retrying
> !] Error resolving "pop.gmail.com": Temporary failure in name resolution (EAI_AGAIN)
>  ] Cannot resolve connect target - delaying DNS lookup
>  ] Initializing context [gmail-pop3]
>  ] stunnel default security level set: 2
>  ] Ciphers: HIGH:!aNULL:!SSLv2:!DH:!kDHEPSK
>  ] TLSv1.3 ciphersuites: TLS_AES_256_GCM_SHA384:TLS_AES_128_GCM_SHA256:TLS_CHACHA20_POLY1305_SHA256
>  ] TLS options: 0x2100004 (+0x0, -0x0)
>  ] Session resumption enabled
>  ] No certificate or private key specified
> !] error queue: crypto/x509/by_file.c:199: error:0B084002:x509 certificate routines:X509_load_cert_crl_file:system lib
> !] error queue: crypto/bio/bss_file.c:76: error:2006D080:BIO routines:BIO_new_file:no such file
> !] SSL_CTX_load_verify_locations: crypto/bio/bss_file.c:69: error:02001002:system library:fopen:No such file or directory
> !] No trusted certificates found
> !] Service [gmail-pop3]: Failed to initialize TLS context
> !] Configuration failed
>  ] Deallocating temporary section defaults
>  ] Cleaning up context [stunnel]
>  ] Deallocating section [gmail-pop3]
>  ] Cleaning up context [gmail-pop3]
> FAIL
> Starting telnetd: OK
> Starting dockerd: OK
> Starting NFS statd: OK
> Starting NFS services: OK
> Starting NFS daemon: OK
> Starting NFS mountd: OK
> Starting DHCP server: FAIL
> Starting HPA's tftpd: done
> Starting tpm2-abrmd: device driver not loaded, skipping.
> Error: No legal partition found, exit script
> Starting collectd: OK
> Starting thttpd: OK
> 
> Welcome to Buildroot Marvell
> marvell login:
