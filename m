Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 1 Mar 2017 15:57:26 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mason <slash.tmp@free.fr>
Subject: Re: Using the generic host PCIe driver
Message-ID: <20170301215726.GA32286@bhelgaas-glaptop.roam.corp.google.com>
References: <8d4e5d8a-7683-0180-324c-0ffd1a9a641a@free.fr>
 <20170227164430.GB11162@bhelgaas-glaptop.roam.corp.google.com>
 <8643c952-e915-bcd1-390e-9d4001789872@free.fr>
 <20170227183534.GA12481@bhelgaas-glaptop.roam.corp.google.com>
 <347d4200-e089-60df-5f60-58d16efc7c4e@free.fr>
 <20170301161801.GB13171@bhelgaas-glaptop.roam.corp.google.com>
 <98ee3041-6a94-91af-b4bf-208aa02624ed@free.fr>
MIME-Version: 1.0
In-Reply-To: <98ee3041-6a94-91af-b4bf-208aa02624ed@free.fr>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Rob Herring <robh@kernel.org>,
 Phuong Nguyen <phuong_nguyen@sigmadesigns.com>,
 David Daney <david.daney@cavium.com>, Marc Zyngier <marc.zyngier@arm.com>,
 linux-pci <linux-pci@vger.kernel.org>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 Will Deacon <will.deacon@arm.com>, Thierry Reding <treding@nvidia.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 01, 2017 at 07:05:26PM +0100, Mason wrote:
> On 01/03/2017 17:18, Bjorn Helgaas wrote:
> 
> > On Wed, Mar 01, 2017 at 04:18:51PM +0100, Mason wrote:
> >
> >> [    0.657711] pci 0000:00:00.0: BAR 0: no space for [mem size 0x01000000 64bit]
> >> [    0.657731] pci 0000:00:00.0: BAR 0: failed to assign [mem size 0x01000000 64bit]
> >> [    0.657755] pci 0000:00:00.0: BAR 8: assigned [mem 0xa0000000-0xa00fffff]
> >> [    0.657776] pci 0000:01:00.0: BAR 0: assigned [mem 0xa0000000-0xa0001fff 64bit]
> >>
> >> These 4 statements sound fishy.
> > 
> > 00:00.0 is a PCI-to-PCI bridge.  "BAR 8" is its memory window (as shown
> > below).  01:00.0 is below the bridge and is using part of the window.  That
> > part is normal.
> > 
> > 00:00.0 also has a BAR of its own.  That's perfectly legal but slightly
> > unusual.  The device will still work fine as a generic PCI-to-PCI bridge
> > even though we didn't assign the BAR.
> > 
> > The BAR would contain device-specific stuff: maybe performance monitoring
> > or management interfaces.  Those things won't work because we didn't assign
> > space.  But even if we did assign space, they would require a special
> > driver to make them work, since they're device-specific and the PCI core
> > knows nothing about them.
> > 
> > Bottom line is that you can ignore the 00:00.0 BAR 0 assignment
> > failure.  It has nothing to do with getting other devices below the
> > bridge to work.
> 
> Another thing I don't understand... According to this reference:
> http://elinux.org/Device_Tree_Usage#PCI_Address_Translation
> 
> The "ranges" prop starts with:
> 
>     phys.hi  cell: npt000ss bbbbbbbb dddddfff rrrrrrrr
>     phys.mid cell: hhhhhhhh hhhhhhhh hhhhhhhh hhhhhhhh
>     phys.low cell: llllllll llllllll llllllll llllllll
> 
> So I thought it might be possible to specify bbbbbbbb = 0x01
> to mean "I want to assign memory only to bus 1, don't assign
> any memory to bus 0". Am I mistaken?

I don't really understand the "bbbbbbbb" field in that range.  The
bridge has a "bus-ranges" property that defines the PCI bus numbers
below the bridge.  As I understand it, the first number in bus-ranges
is the root bus (the bus immediately below the host bridge).  Is
"bbbbbbbb" supposed to be identical to the that root bus number?  If
so, it seems redundant, so why does the "bbbbbbbb" field even exist?

If "bbbbbbbb" can be different from the root bus number, I don't know
what it means.  The host bridge translates CPU physical addresses to
PCI bus address on the root bus (the PCI bus immediately below the
bridge).  Once on the PCI side, the correspondence of memory addresses
to bus numbers is controlled completely by PCI-to-PCI bridges,
independent of what DT contains.

The way to control what bus addresses are available on bus 1 is to:

  1) Use DT to define the addresses available on bus 0 (the root bus) and
  2) Program the memory windows of 00:00.0 (the PCI-to-PCI bridge
     between bus 0 and bus 1

In other words, it's impossible to assign memory only on bus 1.  The
memory on bus 1 is a subset of what's available on bus 0.

> The kernel panics when I use
> 
> 	ranges = <0x02010000 0x0 0x90000000  0x90000000  0x0 0x00100000>;
> 
> [    1.118503] pci 0000:00:00.0: BAR 0: no space for [mem size 0x01000000 64bit]
> [    1.125774] pci 0000:00:00.0: BAR 0: failed to assign [mem size 0x01000000 64bit]
> [    1.133393] pci 0000:00:00.0: BAR 8: assigned [mem 0x90000000-0x900fffff]
> [    1.140315] pci 0000:01:00.0: BAR 0: assigned [mem 0x90000000-0x90001fff 64bit]
> [    1.147771] pci 0000:00:00.0: PCI bridge to [bus 01]
> [    1.152857] pci 0000:00:00.0:   bridge window [mem 0x90000000-0x900fffff]
> [    1.159830] pcieport 0000:00:00.0: enabling device (0140 -> 0142)
> [    1.166062] pcieport 0000:00:00.0: enabling bus mastering
> [    1.171730] pci 0000:01:00.0: calling quirk_usb_early_handoff+0x0/0x790
> [    1.178486] pci 0000:01:00.0: enabling device (0140 -> 0142)
> [    1.184298] Unable to handle kernel paging request at virtual address d08671c4
> [    1.191652] pgd = c0004000
> [    1.194465] [d08671c4] *pgd=8f804811, *pte=00000000, *ppte=00000000
> [    1.200881] Internal error: Oops: 7 [#1] PREEMPT SMP ARM
> [    1.206302] Modules linked in:
> [    1.209458] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.9.7-1-rc2 #125
> [    1.216101] Hardware name: Sigma Tango DT
> [    1.220213] task: cf82c9c0 task.stack: cf838000
> [    1.224851] PC is at quirk_usb_early_handoff+0x3e8/0x790
> [    1.230277] LR is at ioremap_page_range+0xf8/0x1a8
> [    1.235175] pc : [<c039fe8c>]    lr : [<c02d0a10>]    psr: 000e0013
> [    1.235175] sp : cf839d78  ip : 00000000  fp : cf839e38
> [    1.246886] r10: c10248a0  r9 : 00000000  r8 : d08671c4
> [    1.252220] r7 : d084e000  r6 : 00002000  r5 : 000c0300  r4 : cfb4e800
> [    1.258864] r3 : 000191c4  r2 : 00000000  r1 : 90001e13  r0 : d084e000
> [    1.265509] Flags: nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> [    1.272764] Control: 10c5387d  Table: 8fa2c04a  DAC: 00000051
> [    1.278622] Process swapper/0 (pid: 1, stack limit = 0xcf838210)
> [    1.284742] Stack: (0xcf839d78 to 0xcf83a000)
> [    1.289204] 9d60:                                                       c058f578 c058b180
> [    1.297510] 9d80: cfb46300 cf839d98 c0350218 c05adccc cfb4e800 c05adcdc cf838000 00000000
> [    1.305816] 9da0: 00000000 c10248a0 cf839e38 c030bfa4 cf9cd480 c034e69c cf867270 00000000
> [    1.314122] 9dc0: cfb4e800 cfa3e414 cfa3e400 cf839e30 cf9cd480 00000000 cf906010 c02fa484
> [    1.322428] 9de0: cfb4e800 cfa3e414 cfa3e400 c02fa538 cfb4ec00 cfa3e814 cfa3e800 c02fa56c
> [    1.330734] 9e00: cfa3e80c cfa3e80c cfa3e800 c031387c cf839e30 cf9ee9b0 c05178c8 c10101d8
> [    1.339040] 9e20: cfa15cc0 00000000 cf906000 c058cd2c cf839e30 cf839e30 50000000 5fffffff
> [    1.347345] 9e40: cfdf7764 00000200 00000000 00000000 00000000 00000000 c1057de8 cf906010
> [    1.355651] 9e60: c1010208 cf906044 c1010208 00000000 00000007 00000000 cfffcec0 c0351624
> [    1.363957] 9e80: c1056fb0 cf906010 cf906044 c03500c0 cf906010 c1010208 cf906044 c10177d0
> [    1.372262] 9ea0: 00000073 c0350214 00000000 c1010208 c0350150 c034e5e8 cf80545c cf8a60b4
> [    1.380568] 9ec0: c1010208 cf9b8d80 00000000 c034f72c c058cd84 c0616a94 c0633cb0 c1010208
> [    1.388874] 9ee0: c0616a94 c0633cb0 c0628834 c0350770 ffffe000 c0616a94 c0633cb0 c0101834
> [    1.397179] 9f00: c104a354 c100a5c8 00000000 c0220830 00000000 cf87cf00 00000000 c1009370
> [    1.405485] 9f20: cfffceee c050fa08 00000073 c0132aec c059a1c4 c05da4a4 00000000 00000006
> [    1.413790] 9f40: 00000006 c05723fc c1009358 c1024880 c1024880 c1024880 c0633cb0 c0628834
> [    1.422096] 9f60: 00000073 00000007 c062883c c0600db4 00000006 00000006 00000000 c06005ac
> [    1.430401] 9f80: a4b68a61 00000000 c049fafc 00000000 00000000 00000000 00000000 00000000
> [    1.438706] 9fa0: 00000000 c049fb04 00000000 c01077b8 00000000 00000000 00000000 00000000
> [    1.447011] 9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [    1.455316] 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000 c47be6fa ff2306fe
> [    1.463640] [<c039fe8c>] (quirk_usb_early_handoff) from [<c030bfa4>] (pci_do_fixups+0xc8/0x158)
> [    1.472480] [<c030bfa4>] (pci_do_fixups) from [<c02fa484>] (pci_bus_add_device+0x18/0x90)
> [    1.480790] [<c02fa484>] (pci_bus_add_device) from [<c02fa538>] (pci_bus_add_devices+0x3c/0x80)
> [    1.489622] [<c02fa538>] (pci_bus_add_devices) from [<c02fa56c>] (pci_bus_add_devices+0x70/0x80)
> [    1.498544] [<c02fa56c>] (pci_bus_add_devices) from [<c031387c>] (pci_host_common_probe+0xfc/0x324)
> [    1.507732] [<c031387c>] (pci_host_common_probe) from [<c0351624>] (platform_drv_probe+0x34/0x7c)
> [    1.516742] [<c0351624>] (platform_drv_probe) from [<c03500c0>] (really_probe+0x1c4/0x254)
> [    1.525137] [<c03500c0>] (really_probe) from [<c0350214>] (__driver_attach+0xc4/0xc8)
> [    1.533095] [<c0350214>] (__driver_attach) from [<c034e5e8>] (bus_for_each_dev+0x68/0x9c)
> [    1.541402] [<c034e5e8>] (bus_for_each_dev) from [<c034f72c>] (bus_add_driver+0x1a0/0x218)
> [    1.549797] [<c034f72c>] (bus_add_driver) from [<c0350770>] (driver_register+0x78/0xf8)
> [    1.557931] [<c0350770>] (driver_register) from [<c0101834>] (do_one_initcall+0x44/0x174)
> [    1.566247] [<c0101834>] (do_one_initcall) from [<c0600db4>] (kernel_init_freeable+0x154/0x1e4)
> [    1.575082] [<c0600db4>] (kernel_init_freeable) from [<c049fb04>] (kernel_init+0x8/0x10c)
> [    1.583393] [<c049fb04>] (kernel_init) from [<c01077b8>] (ret_from_fork+0x14/0x3c)
> [    1.591090] Code: e3500000 e0833100 0affffcb e0878003 (e5982000) 
> [    1.597333] ---[ end trace bbc44517edfb9c6a ]---
> [    1.602076] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> [    1.602076] 
> [    1.611435] CPU1: stopping
> [    1.614241] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G      D         4.9.7-1-rc2 #125
> [    1.622107] Hardware name: Sigma Tango DT
> [    1.626233] [<c010ed94>] (unwind_backtrace) from [<c010ae24>] (show_stack+0x10/0x14)
> [    1.634106] [<c010ae24>] (show_stack) from [<c02cecc0>] (dump_stack+0x78/0x8c)
> [    1.641454] [<c02cecc0>] (dump_stack) from [<c010dc10>] (handle_IPI+0x198/0x1ac)
> [    1.648975] [<c010dc10>] (handle_IPI) from [<c01014a4>] (gic_handle_irq+0x88/0x8c)
> [    1.656670] [<c01014a4>] (gic_handle_irq) from [<c010b90c>] (__irq_svc+0x6c/0xa8)
> [    1.664274] Exception stack(0xcf859f98 to 0xcf859fe0)
> [    1.669433] 9f80:                                                       00000001 00000000
> [    1.677739] 9fa0: 0000168e c0114620 cf858000 c1002fe4 c1003048 00000002 c100ba2e 413fc090
> [    1.686045] 9fc0: 00000000 00000000 00000001 cf859fe8 c0108220 c0108224 60000013 ffffffff
> [    1.694352] [<c010b90c>] (__irq_svc) from [<c0108224>] (arch_cpu_idle+0x38/0x3c)
> [    1.701878] [<c0108224>] (arch_cpu_idle) from [<c0151f4c>] (cpu_startup_entry+0xcc/0x144)
> [    1.710187] [<c0151f4c>] (cpu_startup_entry) from [<8010154c>] (0x8010154c)
> [    1.717272] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> 
> Am I doing something stupid? (Very likely)
> 
> Regards.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
