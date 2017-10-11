Return-Path: <SRS0=I+uY=BK=free.fr=slash.tmp@kernel.org>
Return-Path: <SRS0=I+uY=BK=free.fr=slash.tmp@kernel.org>
Subject: Re: [bugzilla-daemon@bugzilla.kernel.org: [Bug 197159] New: Xhci host
 controller not responding starting kernel 4.13]
To: Bjorn Helgaas <helgaas@kernel.org>,
 Guoqing Zhang <guoqing.zhang@intel.com>
Cc: Niklas <niklas@vividvisions.se>, linux-pci <linux-pci@vger.kernel.org>,
 linux-usb <linux-usb@vger.kernel.org>,
 Mathias Nyman <mathias.nyman@intel.com>, Lukas Wunner <lukas@wunner.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Felipe Balbi <felipe.balbi@linux.intel.com>,
 Alan Stern <stern@rowland.harvard.edu>
References: <20171009170108.GK25517@bhelgaas-glaptop.roam.corp.google.com>
 <50d880c5-f76b-cb15-0faa-af9fa617ea9a@free.fr>
 <20171009233852.GO25517@bhelgaas-glaptop.roam.corp.google.com>
From: Mason <slash.tmp@free.fr>
Message-ID: <21c3c2cd-a0a5-7855-b15e-526b28567951@free.fr>
Date: Wed, 11 Oct 2017 12:34:28 +0200
MIME-Version: 1.0
In-Reply-To: <20171009233852.GO25517@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On 10/10/2017 01:38, Bjorn Helgaas wrote:
> On Mon, Oct 09, 2017 at 10:45:39PM +0200, Mason wrote:
>> On 09/10/2017 19:01, Bjorn Helgaas wrote:
>> ...
> 
>>> In that thread, Mason reported a regression that looks similar, but as
>>> far as I can tell, we never identified a root cause.
>>>
>>>   1) The problem Mason reported was on a Tango platform, which has a
>>>      known hardware issue that corrupts data when simultaneous config
>>>      and MMIO accesses occur.  You're seeing the problem on a
>>>      different platform, which is very helpful.
>>
>> As mentioned here:
>> https://www.mail-archive.com/linux-usb@vger.kernel.org/msg94020.html
>>
>> When I disable the AER driver, not a single config space access
>> occurs when a USB drive is unplugged. So I'm 99.99% sure that
>> the issue is NOT caused by tango's bad design. (I got the vibe
>> that nobody cared about tango's issue because it was assumed
>> that the design flaw was responsible for it.)
> 
> I agree; I don't think this is Tango's fault.
> 
> Can you test fe190ed0d602 and d9f11ba9f107 to determine whether
> d9f11ba9f107 is the culprit?  If it is the culprit, can you try reverting
> it on a current kernel to see if that fixes it?
> 
> If d9f11ba9f107 is not the culprit, can you bisect to discover exactly
> where it broke?

NOTE: tango PCIe support was not upstream in v4.11
Therefore, for all my tests, I cherry-pick the following patches
on top of the reference mentioned:

	Tweak tango4_defconfig
	Disable sibling calls optimization
	Proper init
	Set up static virt_to_phys mapping for llad
	Show BROKEN drivers
	8759 PCIe DT node
	PCI: Change pci_host_common_probe() visibility
	PCI: Improve __pci_read_base() robustness
	PCI: Include pci.h for struct pci_ops definition
	PCI: tango: Add MSI controller support
	PCI: tango: Add Sigma Designs Tango SMP8759 PCIe host bridge support


Below are the result of my tests.

*********
v4.11-rc5 : I CAN PLUG/UNPLUG SEVERAL TIMES
*********

[    9.598044] usb 2-2: new SuperSpeed USB device number 2 using xhci_hcd
[    9.637244] usb-storage 2-2:1.0: USB Mass Storage device detected
[    9.643687] scsi host0: usb-storage 2-2:1.0
[   10.670685] scsi 0:0:0:0: Direct-Access     Kingston DataTraveler 3.0      PQ: 0 ANSI: 6
[   10.681244] sd 0:0:0:0: [sda] 15109516 512-byte logical blocks: (7.74 GB/7.20 GiB)
[   10.692182] sd 0:0:0:0: [sda] Write Protect is off
[   10.697566] sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[   10.710124]  sda: sda1
[   10.719317] sd 0:0:0:0: [sda] Attached SCSI removable disk
[   10.751942] random: fast init done
[   14.743212] xhci_hcd 0000:01:00.0: Cannot set link state.
[   14.748699] usb usb2-port2: cannot disable (err = -32)
[   14.754068] usb 2-2: USB disconnect, device number 2
[   21.198040] usb 2-2: new SuperSpeed USB device number 3 using xhci_hcd
[   21.237490] usb-storage 2-2:1.0: USB Mass Storage device detected
[   21.243920] scsi host0: usb-storage 2-2:1.0
[   22.270751] scsi 0:0:0:0: Direct-Access     Kingston DataTraveler 3.0      PQ: 0 ANSI: 6
[   22.281255] sd 0:0:0:0: [sda] 15109516 512-byte logical blocks: (7.74 GB/7.20 GiB)
[   22.292173] sd 0:0:0:0: [sda] Write Protect is off
[   22.297555] sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[   22.309951]  sda: sda1
[   22.314312] sd 0:0:0:0: [sda] Attached SCSI removable disk
[   26.586603] xhci_hcd 0000:01:00.0: Cannot set link state.
[   26.592391] usb usb2-port2: cannot disable (err = -32)
[   26.597605] usb 2-2: USB disconnect, device number 3
[   31.811351] usb 2-2: new SuperSpeed USB device number 4 using xhci_hcd
[   31.850819] usb-storage 2-2:1.0: USB Mass Storage device detected
[   31.857291] scsi host0: usb-storage 2-2:1.0
[   32.884087] scsi 0:0:0:0: Direct-Access     Kingston DataTraveler 3.0      PQ: 0 ANSI: 6
[   32.893255] sd 0:0:0:0: [sda] 15109516 512-byte logical blocks: (7.74 GB/7.20 GiB)
[   32.901928] sd 0:0:0:0: [sda] Write Protect is off
[   32.907476] sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[   32.919278]  sda: sda1
[   32.923519] sd 0:0:0:0: [sda] Attached SCSI removable disk
[   35.979867] xhci_hcd 0000:01:00.0: Cannot set link state.
[   35.985346] usb usb2-port2: cannot disable (err = -32)
[   35.990635] usb 2-2: USB disconnect, device number 4



************
26bba5c767de : KERNEL PANIC AT BOOT
************

[    1.156024] xhci_hcd 0000:01:00.0: xHCI Host Controller
[    1.161332] xhci_hcd 0000:01:00.0: new USB bus registered, assigned bus number 1
[    1.174358] xhci_hcd 0000:01:00.0: hcc params 0x014051cf hci version 0x100 quirks 0x00000010
[    1.183767] hub 1-0:1.0: USB hub found
[    1.187589] hub 1-0:1.0: 4 ports detected
[    1.191883] Unable to handle kernel paging request at virtual address 82600004
[    1.199154] pgd = c0004000
[    1.201868] [82600004] *pgd=00000000
[    1.205470] Internal error: Oops: 5 [#1] PREEMPT SMP ARM
[    1.210805] Modules linked in:
[    1.213876] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G         C      4.11.0-rc5 #2
[    1.221394] Hardware name: Sigma Tango DT
[    1.225419] task: df4239c0 task.stack: df430000
[    1.229981] PC is at _raw_spin_unlock_irqrestore+0x2c/0x54
[    1.235493] LR is at 0x8200d6c0
[    1.238645] pc : [<c04ab9d8>]    lr : [<8200d6c0>]    psr: 60000110
[    1.238645] sp : 82600000  ip : 00000000  fp : 00000000
[    1.250181] r10: 00000000  r9 : 80000113  r8 : df4e0178
[    1.255428] r7 : 00000000  r6 : 00000006  r5 : 000002a0  r4 : e0852460
[    1.261985] r3 : 82600000  r2 : 00000730  r1 : 00000000  r0 : df4e0178
[    1.268542] Flags: nZCv  IRQs on  FIQs on  Mode USER_32  ISA ARM  Segment kernel
[    1.275973] Control: 10c5387d  Table: 8000404a  DAC: 00000055
[    1.281743] Process swapper/0 (pid: 1, stack limit = 0xdf430210)
[    1.287796] ---[ end trace 486a64f104b67d0c ]---
[    1.292443] note: swapper/0[1] exited with preempt_count 1
[    1.297966] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
[    1.297966] 
[    1.307149] CPU1: stopping
[    1.309867] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G      D  C      4.11.0-rc5 #2
[    1.317384] Hardware name: Sigma Tango DT
[    1.321439] [<c010f1d0>] (unwind_backtrace) from [<c010ae0c>] (show_stack+0x10/0x14)
[    1.329233] [<c010ae0c>] (show_stack) from [<c02d874c>] (dump_stack+0x84/0x98)
[    1.336495] [<c02d874c>] (dump_stack) from [<c010dfcc>] (handle_IPI+0x168/0x17c)
[    1.343930] [<c010dfcc>] (handle_IPI) from [<c0101490>] (gic_handle_irq+0x88/0x8c)
[    1.351539] [<c0101490>] (gic_handle_irq) from [<c010b90c>] (__irq_svc+0x6c/0xa8)
[    1.359057] Exception stack(0xdf44df68 to 0xdf44dfb0)
[    1.364131] df60:                   00000000 000014fc dfbe733c c0114dc0 df44c000 c0d03c70
[    1.372351] df80: c0d03c24 c0d0d1d2 8000406a 413fc090 00000000 00000000 00000000 df44dfb8
[    1.380569] dfa0: c01081c8 c01081cc 600e0013 ffffffff
[    1.385646] [<c010b90c>] (__irq_svc) from [<c01081cc>] (arch_cpu_idle+0x38/0x3c)
[    1.393084] [<c01081cc>] (arch_cpu_idle) from [<c04ab5c4>] (default_idle_call+0x20/0x2c)
[    1.401223] [<c04ab5c4>] (default_idle_call) from [<c01519ac>] (do_idle+0xbc/0x134)
[    1.408920] [<c01519ac>] (do_idle) from [<c0151cbc>] (cpu_startup_entry+0x18/0x1c)
[    1.416529] [<c0151cbc>] (cpu_startup_entry) from [<c010dc2c>] (secondary_start_kernel+0x160/0x16c)
[    1.425623] [<c010dc2c>] (secondary_start_kernel) from [<8010152c>] (0x8010152c)
[    1.433059] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b



************
4eebed9a6447 : I CAN PLUG/UNPLUG SEVERAL TIMES
************

[    6.538060] usb 2-2: new SuperSpeed USB device number 2 using xhci_hcd
[    6.578314] usb-storage 2-2:1.0: USB Mass Storage device detected
[    6.584789] scsi host0: usb-storage 2-2:1.0
[    7.604073] scsi 0:0:0:0: Direct-Access     Kingston DataTraveler 3.0      PQ: 0 ANSI: 6
[    7.615508] sd 0:0:0:0: [sda] 15109516 512-byte logical blocks: (7.74 GB/7.20 GiB)
[    7.624156] sd 0:0:0:0: [sda] Write Protect is off
[    7.629486] sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[    7.641705]  sda: sda1
[    7.649242] sd 0:0:0:0: [sda] Attached SCSI removable disk
[    7.687092] random: fast init done
[   11.429927] xhci_hcd 0000:01:00.0: Cannot set link state.
[   11.435405] usb usb2-port2: cannot disable (err = -32)
[   11.440606] usb 2-2: USB disconnect, device number 2
[   17.798050] usb 2-2: new SuperSpeed USB device number 3 using xhci_hcd
[   17.838228] usb-storage 2-2:1.0: USB Mass Storage device detected
[   17.844658] scsi host0: usb-storage 2-2:1.0
[   18.857425] scsi 0:0:0:0: Direct-Access     Kingston DataTraveler 3.0      PQ: 0 ANSI: 6
[   18.867689] sd 0:0:0:0: [sda] 15109516 512-byte logical blocks: (7.74 GB/7.20 GiB)
[   18.877440] sd 0:0:0:0: [sda] Write Protect is off
[   18.882777] sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[   18.894884]  sda: sda1
[   18.898988] sd 0:0:0:0: [sda] Attached SCSI removable disk
[   21.609918] xhci_hcd 0000:01:00.0: Cannot set link state.
[   21.615554] usb usb2-port2: cannot disable (err = -32)
[   21.620812] usb 2-2: USB disconnect, device number 3
[   21.642488] udevd[957]: inotify_add_watch(6, /dev/sda, 10) failed: No such file or directory



************
d1001ab41064 : I CAN PLUG/UNPLUG SEVERAL TIMES
************


************
a6ff6cbf1fab : KERNEL PANIC AT BOOT
************

[    1.156209] xhci_hcd 0000:01:00.0: xHCI Host Controller
[    1.161517] xhci_hcd 0000:01:00.0: new USB bus registered, assigned bus number 1
[    1.174570] xhci_hcd 0000:01:00.0: hcc params 0x014051cf hci version 0x100 quirks 0x00000010
[    1.183971] hub 1-0:1.0: USB hub found
[    1.187794] hub 1-0:1.0: 4 ports detected
[    1.192087] Unable to handle kernel paging request at virtual address 82600004
[    1.199357] pgd = c0004000
[    1.202072] [82600004] *pgd=00000000
[    1.205674] Internal error: Oops: 5 [#1] PREEMPT SMP ARM
[    1.211009] Modules linked in:
[    1.214078] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G         C      4.11.0-rc5 #2
[    1.221596] Hardware name: Sigma Tango DT
[    1.225619] task: df4239c0 task.stack: df430000
[    1.230182] PC is at _raw_spin_unlock_irqrestore+0x2c/0x54
[    1.235693] LR is at 0x8200d6c0
[    1.238845] pc : [<c04ab968>]    lr : [<8200d6c0>]    psr: 60000110
[    1.238845] sp : 82600000  ip : 00000000  fp : 00000000
[    1.250382] r10: 00000000  r9 : 80000113  r8 : df5d3178
[    1.255629] r7 : 00000000  r6 : 00000006  r5 : 000002a0  r4 : e0852460
[    1.262186] r3 : 82600000  r2 : 00000730  r1 : 00000000  r0 : df5d3178
[    1.268744] Flags: nZCv  IRQs on  FIQs on  Mode USER_32  ISA ARM  Segment kernel
[    1.276174] Control: 10c5387d  Table: 8000404a  DAC: 00000055
[    1.281945] Process swapper/0 (pid: 1, stack limit = 0xdf430210)
[    1.288000] ---[ end trace 1b343aa374b4931b ]---
[    1.292647] note: swapper/0[1] exited with preempt_count 1
[    1.298170] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
[    1.298170] 
[    1.307353] CPU1: stopping
[    1.310071] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G      D  C      4.11.0-rc5 #2
[    1.317589] Hardware name: Sigma Tango DT
[    1.321643] [<c010f1d0>] (unwind_backtrace) from [<c010ae0c>] (show_stack+0x10/0x14)
[    1.329437] [<c010ae0c>] (show_stack) from [<c02d874c>] (dump_stack+0x84/0x98)
[    1.336700] [<c02d874c>] (dump_stack) from [<c010dfcc>] (handle_IPI+0x168/0x17c)
[    1.344134] [<c010dfcc>] (handle_IPI) from [<c0101490>] (gic_handle_irq+0x88/0x8c)
[    1.351744] [<c0101490>] (gic_handle_irq) from [<c010b90c>] (__irq_svc+0x6c/0xa8)
[    1.359263] Exception stack(0xdf44df68 to 0xdf44dfb0)
[    1.364338] df60:                   00000000 00001484 dfbe733c c0114dc0 df44c000 c0d03c70
[    1.372557] df80: c0d03c24 c0d0d1d2 8000406a 413fc090 00000000 00000000 00000000 df44dfb8
[    1.380775] dfa0: c01081c8 c01081cc 600e0013 ffffffff
[    1.385852] [<c010b90c>] (__irq_svc) from [<c01081cc>] (arch_cpu_idle+0x38/0x3c)
[    1.393290] [<c01081cc>] (arch_cpu_idle) from [<c04ab554>] (default_idle_call+0x20/0x2c)
[    1.401427] [<c04ab554>] (default_idle_call) from [<c01519ac>] (do_idle+0xbc/0x134)
[    1.409125] [<c01519ac>] (do_idle) from [<c0151cbc>] (cpu_startup_entry+0x18/0x1c)
[    1.416733] [<c0151cbc>] (cpu_startup_entry) from [<c010dc2c>] (secondary_start_kernel+0x160/0x16c)
[    1.425826] [<c010dc2c>] (secondary_start_kernel) from [<8010152c>] (0x8010152c)
[    1.433261] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b


d1001ab41064 = GOOD
a6ff6cbf1fab = BAD
Adding Guoqing Zhang to recipient list


************
b7f769ae1b12 : KERNEL PANIC AT BOOT
************

[    1.159928] xhci_hcd 0000:01:00.0: xHCI Host Controller
[    1.165220] xhci_hcd 0000:01:00.0: new USB bus registered, assigned bus number 1
[    1.178260] xhci_hcd 0000:01:00.0: hcc params 0x014051cf hci version 0x100 quirks 0x00000010
[    1.187646] hub 1-0:1.0: USB hub found
[    1.191466] hub 1-0:1.0: 4 ports detected
[    1.195758] Unable to handle kernel paging request at virtual address bec20004
[    1.203028] pgd = c0004000
[    1.205742] [bec20004] *pgd=00000000
[    1.209345] Internal error: Oops: 5 [#1] PREEMPT SMP ARM
[    1.214680] Modules linked in:
[    1.217750] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G         C      4.11.0-rc5 #2
[    1.225268] Hardware name: Sigma Tango DT
[    1.229292] task: df4239c0 task.stack: df430000
[    1.233855] PC is at _raw_spin_unlock_irqrestore+0x2c/0x54
[    1.239365] LR is at 0xb6e62f31
[    1.242518] pc : [<c04abce0>]    lr : [<b6e62f31>]    psr: 60000110
[    1.242518] sp : bec20d1c  ip : df4bc000  fp : 00000000
[    1.254054] r10: 80000113  r9 : 00000001  r8 : df4bc178
[    1.259301] r7 : 00000001  r6 : 000002a0  r5 : e0852460  r4 : df4bc178
[    1.265858] r3 : bec20000  r2 : 00000730  r1 : 00000000  r0 : df4bc178
[    1.272416] Flags: nZCv  IRQs on  FIQs on  Mode USER_32  ISA ARM  Segment kernel
[    1.279847] Control: 10c5387d  Table: 9f6fc04a  DAC: 00000055
[    1.285617] Process swapper/0 (pid: 1, stack limit = 0xdf430210)
[    1.291673] ---[ end trace e88adba0be4326ac ]---
[    1.296321] note: swapper/0[1] exited with preempt_count 1
[    1.301843] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
[    1.301843] 
[    1.311026] CPU0: stopping
[    1.313744] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G      D  C      4.11.0-rc5 #2
[    1.321261] Hardware name: Sigma Tango DT
[    1.325315] [<c010f1d0>] (unwind_backtrace) from [<c010ae0c>] (show_stack+0x10/0x14)
[    1.333109] [<c010ae0c>] (show_stack) from [<c02d874c>] (dump_stack+0x84/0x98)
[    1.340371] [<c02d874c>] (dump_stack) from [<c010dfcc>] (handle_IPI+0x168/0x17c)
[    1.347805] [<c010dfcc>] (handle_IPI) from [<c0101490>] (gic_handle_irq+0x88/0x8c)
[    1.355415] [<c0101490>] (gic_handle_irq) from [<c010b90c>] (__irq_svc+0x6c/0xa8)
[    1.362933] Exception stack(0xc0d01f38 to 0xc0d01f80)
[    1.368007] 1f20:                                                       00000000 000017ae
[    1.376227] 1f40: dfbd733c c0114dc0 c0d00000 c0d03c70 c0d03c24 c0d0d1d2 c0d24700 c0627a28
[    1.384445] 1f60: dfffce80 00000000 00000000 c0d01f88 c01081c8 c01081cc 600e0013 ffffffff
[    1.392667] [<c010b90c>] (__irq_svc) from [<c01081cc>] (arch_cpu_idle+0x38/0x3c)
[    1.400105] [<c01081cc>] (arch_cpu_idle) from [<c04ab8cc>] (default_idle_call+0x20/0x2c)
[    1.408243] [<c04ab8cc>] (default_idle_call) from [<c01519ac>] (do_idle+0xbc/0x134)
[    1.415940] [<c01519ac>] (do_idle) from [<c0151cbc>] (cpu_startup_entry+0x18/0x1c)
[    1.423549] [<c0151cbc>] (cpu_startup_entry) from [<c04a6e64>] (rest_init+0x84/0x88)
[    1.431335] [<c04a6e64>] (rest_init) from [<c0600c70>] (start_kernel+0x37c/0x388)
[    1.438857] [<c0600c70>] (start_kernel) from [<8000807c>] (0x8000807c)
[    1.445418] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b



************
fe190ed0d602 : KERNEL PANIC AT BOOT
************

[    1.159262] xhci_hcd 0000:01:00.0: xHCI Host Controller
[    1.164570] xhci_hcd 0000:01:00.0: new USB bus registered, assigned bus number 1
[    1.177590] xhci_hcd 0000:01:00.0: hcc params 0x014051cf hci version 0x100 quirks 0x00000010
[    1.186995] hub 1-0:1.0: USB hub found
[    1.190824] hub 1-0:1.0: 4 ports detected
[    1.195111] Unable to handle kernel paging request at virtual address 82600004
[    1.202383] pgd = c0004000
[    1.205097] [82600004] *pgd=00000000
[    1.208696] Internal error: Oops: 5 [#1] PREEMPT SMP ARM
[    1.214030] Modules linked in:
[    1.217100] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G         C      4.11.0-rc5 #2
[    1.224618] Hardware name: Sigma Tango DT
[    1.228643] task: df4239c0 task.stack: df430000
[    1.233205] PC is at _raw_spin_unlock_irqrestore+0x2c/0x54
[    1.238715] LR is at 0x8200d6c0
[    1.241867] pc : [<c04abce0>]    lr : [<8200d6c0>]    psr: 60000010
[    1.241867] sp : 82600000  ip : df5ca000  fp : 00000000
[    1.253404] r10: 80000013  r9 : 00000001  r8 : df5ca178
[    1.258651] r7 : 00000001  r6 : 000002a0  r5 : e0852460  r4 : df5ca178
[    1.265208] r3 : 82600000  r2 : 00000730  r1 : 00000000  r0 : df5ca178
[    1.271766] Flags: nZCv  IRQs on  FIQs on  Mode USER_32  ISA ARM  Segment kernel
[    1.279197] Control: 10c5387d  Table: 8000404a  DAC: 00000055
[    1.284967] Process swapper/0 (pid: 1, stack limit = 0xdf430210)
[    1.291025] ---[ end trace 45e34bfad7c69c2a ]---
[    1.295671] note: swapper/0[1] exited with preempt_count 1
[    1.301196] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
[    1.301196] 
[    1.310379] CPU1: stopping
[    1.313097] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G      D  C      4.11.0-rc5 #2
[    1.320615] Hardware name: Sigma Tango DT
[    1.324668] [<c010f1d0>] (unwind_backtrace) from [<c010ae0c>] (show_stack+0x10/0x14)
[    1.332462] [<c010ae0c>] (show_stack) from [<c02d874c>] (dump_stack+0x84/0x98)
[    1.339724] [<c02d874c>] (dump_stack) from [<c010dfcc>] (handle_IPI+0x168/0x17c)
[    1.347159] [<c010dfcc>] (handle_IPI) from [<c0101490>] (gic_handle_irq+0x88/0x8c)
[    1.354769] [<c0101490>] (gic_handle_irq) from [<c010b90c>] (__irq_svc+0x6c/0xa8)
[    1.362288] Exception stack(0xdf44df68 to 0xdf44dfb0)
[    1.367362] df60:                   00000000 0000143c dfbe733c c0114dc0 df44c000 c0d03c70
[    1.375581] df80: c0d03c24 c0d0d1d2 8000406a 413fc090 00000000 00000000 00000001 df44dfb8
[    1.383798] dfa0: c01081c8 c01081cc 600e0013 ffffffff
[    1.388876] [<c010b90c>] (__irq_svc) from [<c01081cc>] (arch_cpu_idle+0x38/0x3c)
[    1.396314] [<c01081cc>] (arch_cpu_idle) from [<c04ab8cc>] (default_idle_call+0x20/0x2c)
[    1.404453] [<c04ab8cc>] (default_idle_call) from [<c01519ac>] (do_idle+0xbc/0x134)
[    1.412150] [<c01519ac>] (do_idle) from [<c0151cbc>] (cpu_startup_entry+0x18/0x1c)
[    1.419759] [<c0151cbc>] (cpu_startup_entry) from [<c010dc2c>] (secondary_start_kernel+0x160/0x16c)
[    1.428852] [<c010dc2c>] (secondary_start_kernel) from [<8010152c>] (0x8010152c)
[    1.436287] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b



***********************************
v4.12-rc1 + git revert d9f11ba9f107 : I CAN PLUG/UNPLUG SEVERAL TIMES
***********************************


What next? What conclusion follows from the above?

Regards.
