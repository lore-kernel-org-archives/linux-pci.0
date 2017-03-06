Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: Panic in quirk_usb_early_handoff
To: Mason <slash.tmp@free.fr>, linux-usb <linux-usb@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <4b2a7606-de27-c8ad-1530-958dd5d12233@free.fr>
 <45e38a07-e8da-80e4-36bb-31e471f02004@free.fr>
 <3c5bd8f5-468f-d25e-08a9-8944ee419096@free.fr>
 <38b8c9be-724b-0cfc-a941-76f2c62e1c58@arm.com>
 <491b40db-dc07-2a8e-9bc4-07b86f990600@free.fr>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <377ce76b-5397-5a02-6bae-7d961b7e9242@arm.com>
Date: Mon, 6 Mar 2017 14:30:10 +0000
MIME-Version: 1.0
In-Reply-To: <491b40db-dc07-2a8e-9bc4-07b86f990600@free.fr>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 Alan Stern <stern@rowland.harvard.edu>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

[+linux-pci, just in case]

On 06/03/17 12:42, Mason wrote:
> On 03/03/2017 20:02, Robin Murphy wrote:
> 
>> On 03/03/17 17:15, Mason wrote:
>>
>>>>> [    1.264893] Unable to handle kernel paging request at virtual address d08664f4
>>
>> Note that that's a reasonable approximation of a vmalloc address...
>>
>>>>> [    1.272248] pgd = c0004000
>>>>> [    1.275060] [d08664f4] *pgd=8f804811, *pte=00000000, *ppte=00000000
>>>>> [    1.281476] Internal error: Oops: 7 [#1] PREEMPT SMP ARM
>>>>> [    1.286897] Modules linked in:
>>>>> [    1.290053] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.9.7-1-rc2 #151
>>>>> [    1.296696] Hardware name: Sigma Tango DT
>>>>> [    1.300808] task: cf82c9c0 task.stack: cf838000
>>>>> [    1.305446] PC is at quirk_usb_early_handoff+0x3e8/0x790
>>>>> [    1.310873] LR is at ioremap_page_range+0xf8/0x1a8
>>>>> [    1.315771] pc : [<c039fe8c>]    lr : [<c02d0a10>]    psr: 000e0013
>>>>> [    1.315771] sp : cf839d78  ip : 00000000  fp : cf839e38
>>>>> [    1.327482] r10: c10248a0  r9 : 00000000  r8 : d08664f4
>>>>> [    1.332816] r7 : d084e000  r6 : 00002000  r5 : 000c0300  r4 : cfb5f800
>>>>> [    1.339460] r3 : 000184f4  r2 : 00000000  r1 : 91001e13  r0 : d084e000
>>
>> ...and that specifically it's r0 + r3...
>>
>>>> [    1.258926] Unable to handle kernel paging request at virtual address d0863f70
>>>> [    1.266284] pgd = c0004000
>>>> [    1.269097] [d0863f70] *pgd=8f804811, *pte=00000000, *ppte=00000000
>>>> [    1.275512] Internal error: Oops: 7 [#1] PREEMPT SMP ARM
>>>> [    1.280933] Modules linked in:
>>>> [    1.284089] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.9.7-1-rc2 #157
>>>> [    1.290732] Hardware name: Sigma Tango DT
>>>> [    1.294843] task: cf82c9c0 task.stack: cf838000
>>>> [    1.299482] PC is at quirk_usb_early_handoff+0x3e8/0x790
>>>> [    1.304907] LR is at ioremap_page_range+0xf8/0x1a8
>>>> [    1.309806] pc : [<c039fe44>]    lr : [<c02d0a10>]    psr: 000e0013
>>>> [    1.309806] sp : cf839d78  ip : 00000000  fp : cf839e38
>>>> [    1.321517] r10: c10248a0  r9 : 00000000  r8 : d0863f70
>>>> [    1.326851] r7 : d084e000  r6 : 00002000  r5 : 000c0300  r4 : cfb52800
>>>> [    1.333495] r3 : 00015f70  r2 : 00000000  r1 : 91001e13  r0 : d084e000
>>
>> ...and again...
>>
>>> [    1.261813] Unable to handle kernel paging request at virtual address d08611e4
>>> [    1.269167] pgd = c0004000
>>> [    1.271979] [d08611e4] *pgd=8f804811, *pte=00000000, *ppte=00000000
>>> [    1.278394] Internal error: Oops: 7 [#1] PREEMPT SMP ARM
>>> [    1.283815] Modules linked in:
>>> [    1.286970] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.9.7-1-rc2 #157
>>> [    1.293614] Hardware name: Sigma Tango DT
>>> [    1.297726] task: cf82c9c0 task.stack: cf838000
>>> [    1.302364] PC is at quirk_usb_early_handoff+0x3e8/0x790
>>> [    1.307790] LR is at ioremap_page_range+0xf8/0x1a8
>>> [    1.312688] pc : [<c039fe44>]    lr : [<c02d0a10>]    psr: 000e0013
>>> [    1.312688] sp : cf839d78  ip : 00000000  fp : cf839e38
>>> [    1.324399] r10: c10248a0  r9 : 00000000  r8 : d08611e4
>>> [    1.329733] r7 : d084e000  r6 : 00002000  r5 : 000c0300  r4 : cfb4e800
>>> [    1.336377] r3 : 000131e4  r2 : 00000000  r1 : 91001e13  r0 : d084e000
>>
>> ...and again. And always at the same PC, too. Looking at
>> quirk_usb_early_handoff(), it mostly seems to go off poking bridge
>> resources, so I'd hazard a guess that it's down to your host driver,
>> with something uninitialised (or already freed) being used as an offset
>> into some ioremapped resource (which given the consistency of r0 is
>> probably allocated pretty early on).
>>
>> "addr2line -i -e vmlinux c039fe44", and work backwards from there ;)
>> In particular I'd follow the provenance of r3.
> 
> Starting from a fresh panic:
> 
> [    1.236243] pcieport 0000:00:00.0: enabling device (0140 -> 0142)
> [    1.242474] pcieport 0000:00:00.0: enabling bus mastering
> [    1.248147] pci 0000:01:00.0: calling quirk_usb_early_handoff+0x0/0x790
> [    1.254904] pci 0000:01:00.0: enabling device (0140 -> 0142)
> [    1.260719] Unable to handle kernel paging request at virtual address d08509f8
> [    1.268073] pgd = c0004000
> [    1.270874] [d08509f8] *pgd=8f804811, *pte=00000000, *ppte=00000000
> [    1.277282] Internal error: Oops: 7 [#1] PREEMPT SMP ARM
> [    1.282702] Modules linked in:
> [    1.285858] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.9.7-1-rc2 #2
> [    1.292327] Hardware name: Sigma Tango DT
> [    1.296438] task: cf82c9c0 task.stack: cf838000
> [    1.301076] PC is at quirk_usb_early_handoff+0x3e8/0x790
> [    1.306501] LR is at ioremap_page_range+0xf8/0x1a8
> [    1.311400] pc : [<c039fe44>]    lr : [<c02d0a10>]    psr: 000e0013
> [    1.311400] sp : cf839d78  ip : 00000000  fp : cf839e38
> [    1.323110] r10: c10248a0  r9 : 00000000  r8 : d08509f8
> [    1.328444] r7 : d084e000  r6 : 00002000  r5 : 000c0300  r4 : cfb5f800
> [    1.335087] r3 : 000029f8  r2 : 00000000  r1 : 91001e13  r0 : d084e000
> [    1.341732] Flags: nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> [    1.348987] Control: 10c5387d  Table: 8faa004a  DAC: 00000051
> [    1.354844] Process swapper/0 (pid: 1, stack limit = 0xcf838210)
> [    1.360963] Stack: (0xcf839d78 to 0xcf83a000)
> [    1.365424] 9d60:                                                       c058f56c c058b174
> [    1.373730] 9d80: cfb55240 cf839d98 c03501cc c05adcc4 cfb5f800 c05adcd4 cf838000 00000000
> [    1.382036] 9da0: 00000000 c10248a0 cf839e38 c030bf58 cf889200 c034e650 cf867270 00000000
> [    1.390342] 9dc0: cfb5f800 cf999414 cf999400 cf839e30 cf889200 00000000 cf906010 c02fa484
> [    1.398648] 9de0: cfb5f800 cf999414 cf999400 c02fa538 cfb5fc00 cf999814 cf999800 c02fa56c
> [    1.406953] 9e00: cf99980c cf99980c cf999800 c0313830 cf839e30 cf9929b0 c05178b0 c10101d8
> [    1.415259] 9e20: cf881780 00000000 cf906000 c058cd20 cf839e30 cf839e30 50000000 5fffffff
> [    1.423564] 9e40: cfdf7764 00000200 00000000 00000000 00000000 00000000 c1057de8 cf906010
> [    1.431869] 9e60: c1010208 cf906044 c1010208 00000000 00000007 00000000 cfffcec0 c03515d8
> [    1.440175] 9e80: c1056fb0 cf906010 cf906044 c0350074 cf906010 c1010208 cf906044 c10177d0
> [    1.448481] 9ea0: 00000073 c03501c8 00000000 c1010208 c0350104 c034e59c cf80545c cf8a60b4
> [    1.456787] 9ec0: c1010208 cf9a5f00 00000000 c034f6e0 c058cd78 c0616a64 c0633cb0 c1010208
> [    1.465093] 9ee0: c0616a64 c0633cb0 c0628834 c0350724 ffffe000 c0616a64 c0633cb0 c0101834
> [    1.473399] 9f00: 00000069 cf839f20 c013291c c02d4f10 20000000 ffffffff 00000051 00000000
> [    1.481704] 9f20: cfffceee c050fa08 00000073 c0132aec c059a1b8 c05da49c 00000000 00000006
> [    1.490010] 9f40: 00000006 c05723fc c1009358 c1024880 c1024880 c1024880 c0633cb0 c0628834
> [    1.498315] 9f60: 00000073 00000007 c062883c c0600db4 00000006 00000006 00000000 c06005ac
> [    1.506620] 9f80: 58fe5add 00000000 c049fab4 00000000 00000000 00000000 00000000 00000000
> [    1.514925] 9fa0: 00000000 c049fabc 00000000 c01077b8 00000000 00000000 00000000 00000000
> [    1.523230] 9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [    1.531536] 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000 88719a14 4a5337f3
> [    1.539858] [<c039fe44>] (quirk_usb_early_handoff) from [<c030bf58>] (pci_do_fixups+0xc8/0x158)
> [    1.548699] [<c030bf58>] (pci_do_fixups) from [<c02fa484>] (pci_bus_add_device+0x18/0x90)
> [    1.557008] [<c02fa484>] (pci_bus_add_device) from [<c02fa538>] (pci_bus_add_devices+0x3c/0x80)
> [    1.565839] [<c02fa538>] (pci_bus_add_devices) from [<c02fa56c>] (pci_bus_add_devices+0x70/0x80)
> [    1.574761] [<c02fa56c>] (pci_bus_add_devices) from [<c0313830>] (pci_host_common_probe+0xfc/0x324)
> [    1.583948] [<c0313830>] (pci_host_common_probe) from [<c03515d8>] (platform_drv_probe+0x34/0x7c)
> [    1.592957] [<c03515d8>] (platform_drv_probe) from [<c0350074>] (really_probe+0x1c4/0x254)
> [    1.601353] [<c0350074>] (really_probe) from [<c03501c8>] (__driver_attach+0xc4/0xc8)
> [    1.609311] [<c03501c8>] (__driver_attach) from [<c034e59c>] (bus_for_each_dev+0x68/0x9c)
> [    1.617618] [<c034e59c>] (bus_for_each_dev) from [<c034f6e0>] (bus_add_driver+0x1a0/0x218)
> [    1.626013] [<c034f6e0>] (bus_add_driver) from [<c0350724>] (driver_register+0x78/0xf8)
> [    1.634147] [<c0350724>] (driver_register) from [<c0101834>] (do_one_initcall+0x44/0x174)
> [    1.642463] [<c0101834>] (do_one_initcall) from [<c0600db4>] (kernel_init_freeable+0x154/0x1e4)
> [    1.651296] [<c0600db4>] (kernel_init_freeable) from [<c049fabc>] (kernel_init+0x8/0x10c)
> [    1.659607] [<c049fabc>] (kernel_init) from [<c01077b8>] (ret_from_fork+0x14/0x3c)
> [    1.667302] Code: e3500000 e0833100 0affffcb e0878003 (e5982000) 
> [    1.673545] ---[ end trace c146f95bb6e22b24 ]---
> [    1.678294] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> [    1.678294] 
> [    1.687652] CPU1: stopping
> [    1.690457] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G      D         4.9.7-1-rc2 #2
> [    1.698148] Hardware name: Sigma Tango DT
> [    1.702276] [<c010ed94>] (unwind_backtrace) from [<c010ae24>] (show_stack+0x10/0x14)
> [    1.710148] [<c010ae24>] (show_stack) from [<c02cecc0>] (dump_stack+0x78/0x8c)
> [    1.717495] [<c02cecc0>] (dump_stack) from [<c010dc10>] (handle_IPI+0x198/0x1ac)
> [    1.725016] [<c010dc10>] (handle_IPI) from [<c01014a4>] (gic_handle_irq+0x88/0x8c)
> [    1.732710] [<c01014a4>] (gic_handle_irq) from [<c010b90c>] (__irq_svc+0x6c/0xa8)
> [    1.740314] Exception stack(0xcf859f98 to 0xcf859fe0)
> [    1.745474] 9f80:                                                       00000001 00000000
> [    1.753779] 9fa0: 0000196e c0114620 cf858000 c1002fe4 c1003048 00000002 c100ba2e 413fc090
> [    1.762085] 9fc0: 00000000 00000000 00000001 cf859fe8 c0108220 c0108224 60000013 ffffffff
> [    1.770392] [<c010b90c>] (__irq_svc) from [<c0108224>] (arch_cpu_idle+0x38/0x3c)
> [    1.777918] [<c0108224>] (arch_cpu_idle) from [<c0151f4c>] (cpu_startup_entry+0xcc/0x144)
> [    1.786227] [<c0151f4c>] (cpu_startup_entry) from [<8010154c>] (0x8010154c)
> [    1.793311] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> 
> 
> $ arm-linux-gnueabihf-addr2line -i -e vmlinux c039fe44
> arch/arm/include/asm/io.h:119
> 
> In other words, readl()
> Not as helpful as expected...

I guess your toolchain isn't generating whatever debug info that -i uses
to show where it was actually inlined, shame.

> AFAICT, quirk_usb_handoff_xhci() is inlined at c039fd18
> 
> and c039fd48 is likely
> 	base = ioremap_nocache(pci_resource_start(pdev, 0), len);
> http://lxr.free-electrons.com/source/drivers/usb/host/pci-quirks.c?v=4.9#L978
> 
> Panic seems to occur in
> ext_cap_offset = xhci_find_next_ext_cap(base, 0, XHCI_EXT_CAPS_LEGACY);
> 
> c039fd54:	e5973010 	ldr	r3, [r7, #16]
> c039fd58:	f57ff04f 	dsb	sy
> c039fd5c:	e3730001 	cmn	r3, #1
> c039fd60:	0a000002 	beq	c039fd70 <quirk_usb_early_handoff+0x314>
> 
> 		val = readl(base + XHCI_HCC_PARAMS_OFFSET);
> 		if (val == ~0)
> 			return 0;
> 
> At this point, r7 is base.
> 
> c039fd64:	e1a03823 	lsr	r3, r3, #16
> c039fd68:	e1b03103 	lsls	r3, r3, #2
> c039fd6c:	1a000033 	bne	c039fe40 <quirk_usb_early_handoff+0x3e4>
> 
> 		offset = XHCI_HCC_EXT_CAPS(val) << 2;
> 		if (!offset)
> 			return 0;
> 
> At this point, r3 is XHCI_HCC_EXT_CAPS(val) << 2
> 
> 	do {
> 		val = readl(base + offset);
> 		if (val == ~0)
> 			return 0;
> 
> c039fe40:	e0878003 	add	r8, r7, r3
> c039fe44:	e5982000 	ldr	r2, [r8]
> 
> r8 = r7 + r3 = base + offset;
> 
> So the kernel panics in xhci_find_next_ext_cap()
> ( drivers/usb/host/xhci-ext-caps.h:122 )
> http://lxr.free-electrons.com/source/drivers/usb/host/xhci-ext-caps.h?v=4.9#L122
> 
> Any idea how this can happen?
> 
> 	base = ioremap_nocache(pci_resource_start(pdev, 0), len);
> 
> Could I be passing garbage to ioremap_nocache?

For reference, from your original log:

[    1.118433] pci 0000:00:00.0: scanning [bus 00-00] behind bridge, pass 1
[    1.125385] pci_bus 0000:01: scanning bus
[    1.129557] pci 0000:01:00.0: [1912:0014] type 00 class 0x0c0330
[    1.135727] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00001fff 64bit]
[    1.142730] pci 0000:01:00.0: calling pci_fixup_ide_bases+0x0/0x40

Put together, if I'm skimming unfamiliar XHCI code and docs correctly,
this would imply that a supposed read of the HCC Parameters register
claimed that the extended capabilities register was at offset 0x29f8
into a 0x2000-long BAR. That does suggest that whatever's being accessed
through that ioremap() isn't actually the contents of BAR 0 at all (said
field should apparently read as 0x140 representing an offset of 0x500).
You're not still trying have your PCI host controller place its
MEM-space window over the top of system RAM, are you? Otherwise, I'd be
inclined to double check that your config space accesses and resource
assignment are producing sane values.

I think that's about as far as I can go, 'cause by this point I know a
lot less than it might sound like I do ;)

Robin.

> 
> Regards.
> 
> 
> 
> Full disassembly below, for my own reference.
> 
> c039fa5c <quirk_usb_early_handoff>:
> c039fa5c:	e1d022b0 	ldrh	r2, [r0, #32]
> c039fa60:	e301384e 	movw	r3, #6222	; 0x184e
> c039fa64:	e1520003 	cmp	r2, r3
> c039fa68:	012fff1e 	bxeq	lr
> c039fa6c:	e92d4ff0 	push	{r4, r5, r6, r7, r8, r9, sl, fp, lr}
> c039fa70:	e3a03c03 	mov	r3, #768	; 0x300
> c039fa74:	e5905028 	ldr	r5, [r0, #40]	; 0x28
> c039fa78:	e340300c 	movt	r3, #12
> c039fa7c:	e24dd014 	sub	sp, sp, #20
> c039fa80:	e1a04000 	mov	r4, r0
> c039fa84:	e3c55030 	bic	r5, r5, #48	; 0x30
> c039fa88:	e1550003 	cmp	r5, r3
> c039fa8c:	0a000001 	beq	c039fa98 <quirk_usb_early_handoff+0x3c>
> c039fa90:	e28dd014 	add	sp, sp, #20
> c039fa94:	e8bd8ff0 	pop	{r4, r5, r6, r7, r8, r9, sl, fp, pc}
> c039fa98:	ebfd890d 	bl	c0301ed4 <pci_enable_device>
> c039fa9c:	e3500000 	cmp	r0, #0
> c039faa0:	ba000097 	blt	c039fd04 <quirk_usb_early_handoff+0x2a8>
> c039faa4:	e5943028 	ldr	r3, [r4, #40]	; 0x28
> c039faa8:	e1530005 	cmp	r3, r5
> c039faac:	0a00000f 	beq	c039faf0 <quirk_usb_early_handoff+0x94>
> c039fab0:	e3a02e31 	mov	r2, #784	; 0x310
> c039fab4:	e340200c 	movt	r2, #12
> c039fab8:	e1530002 	cmp	r3, r2
> c039fabc:	0a00001e 	beq	c039fb3c <quirk_usb_early_handoff+0xe0>
> c039fac0:	e3a02e32 	mov	r2, #800	; 0x320
> c039fac4:	e340200c 	movt	r2, #12
> c039fac8:	e1530002 	cmp	r3, r2
> c039facc:	0a000054 	beq	c039fc24 <quirk_usb_early_handoff+0x1c8>
> c039fad0:	e3a02e33 	mov	r2, #816	; 0x330
> c039fad4:	e340200c 	movt	r2, #12
> c039fad8:	e1530002 	cmp	r3, r2
> c039fadc:	0a00008d 	beq	c039fd18 <quirk_usb_early_handoff+0x2bc>
> c039fae0:	e1a00004 	mov	r0, r4
> c039fae4:	ebfd846d 	bl	c0300ca0 <pci_disable_device>
> c039fae8:	e28dd014 	add	sp, sp, #20
> c039faec:	e8bd8ff0 	pop	{r4, r5, r6, r7, r8, r9, sl, fp, pc}
> c039faf0:	e28d300c 	add	r3, sp, #12
> c039faf4:	e3a02004 	mov	r2, #4
> c039faf8:	e594101c 	ldr	r1, [r4, #28]
> c039fafc:	e5940008 	ldr	r0, [r4, #8]
> c039fb00:	ebfd631b 	bl	c02f8774 <pci_bus_read_config_word>
> c039fb04:	e3500000 	cmp	r0, #0
> c039fb08:	1afffff4 	bne	c039fae0 <quirk_usb_early_handoff+0x84>
> c039fb0c:	e1dd30bc 	ldrh	r3, [sp, #12]
> c039fb10:	e3130001 	tst	r3, #1
> c039fb14:	0afffff1 	beq	c039fae0 <quirk_usb_early_handoff+0x84>
> c039fb18:	e1a03004 	mov	r3, r4
> c039fb1c:	e5932178 	ldr	r2, [r3, #376]	; 0x178
> c039fb20:	e2833020 	add	r3, r3, #32
> c039fb24:	e3120c01 	tst	r2, #256	; 0x100
> c039fb28:	1a00012b 	bne	c039ffdc <quirk_usb_early_handoff+0x580>
> c039fb2c:	e2800001 	add	r0, r0, #1
> c039fb30:	e3500006 	cmp	r0, #6
> c039fb34:	1afffff8 	bne	c039fb1c <quirk_usb_early_handoff+0xc0>
> c039fb38:	eaffffe8 	b	c039fae0 <quirk_usb_early_handoff+0x84>
> c039fb3c:	e594316c 	ldr	r3, [r4, #364]	; 0x16c
> c039fb40:	e3530000 	cmp	r3, #0
> c039fb44:	0affffe5 	beq	c039fae0 <quirk_usb_early_handoff+0x84>
> c039fb48:	e1a00004 	mov	r0, r4
> c039fb4c:	ebffff8f 	bl	c039f990 <mmio_resource_enabled.part.0>
> c039fb50:	e3500000 	cmp	r0, #0
> c039fb54:	0affffe1 	beq	c039fae0 <quirk_usb_early_handoff+0x84>
> c039fb58:	e3a01000 	mov	r1, #0
> c039fb5c:	e1a00004 	mov	r0, r4
> c039fb60:	ebfd7875 	bl	c02fdd3c <pci_ioremap_bar>
> c039fb64:	e2508000 	subs	r8, r0, #0
> c039fb68:	0affffdc 	beq	c039fae0 <quirk_usb_early_handoff+0x84>
> c039fb6c:	e5949020 	ldr	r9, [r4, #32]
> c039fb70:	e2887004 	add	r7, r8, #4
> c039fb74:	e598a004 	ldr	sl, [r8, #4]
> c039fb78:	f57ff04f 	dsb	sy
> c039fb7c:	e31a0c01 	tst	sl, #256	; 0x100
> c039fb80:	02886008 	addeq	r6, r8, #8
> c039fb84:	1a000128 	bne	c03a002c <quirk_usb_early_handoff+0x5d0>
> c039fb88:	f57ff04e 	dsb	st
> c039fb8c:	ebf5c6a8 	bl	c0111634 <arm_heavy_mb>
> c039fb90:	e3e03000 	mvn	r3, #0
> c039fb94:	e5883014 	str	r3, [r8, #20]
> c039fb98:	e31a00c0 	tst	sl, #192	; 0xc0
> c039fb9c:	1a000119 	bne	c03a0008 <quirk_usb_early_handoff+0x5ac>
> c039fba0:	e30130b9 	movw	r3, #4281	; 0x10b9
> c039fba4:	e3453237 	movt	r3, #21047	; 0x5237
> c039fba8:	e1590003 	cmp	r9, r3
> c039fbac:	03a0a000 	moveq	sl, #0
> c039fbb0:	0a000001 	beq	c039fbbc <quirk_usb_early_handoff+0x160>
> c039fbb4:	e598a034 	ldr	sl, [r8, #52]	; 0x34
> c039fbb8:	f57ff04f 	dsb	sy
> c039fbbc:	f57ff04e 	dsb	st
> c039fbc0:	ebf5c69b 	bl	c0111634 <arm_heavy_mb>
> c039fbc4:	e3a03001 	mov	r3, #1
> c039fbc8:	e5863000 	str	r3, [r6]
> c039fbcc:	e307b4dc 	movw	fp, #29916	; 0x74dc
> c039fbd0:	e30d7495 	movw	r7, #54421	; 0xd495
> c039fbd4:	e34cb05a 	movt	fp, #49242	; 0xc05a
> c039fbd8:	e3407009 	movt	r7, #9
> c039fbdc:	e3a0501e 	mov	r5, #30
> c039fbe0:	ea000003 	b	c039fbf4 <quirk_usb_early_handoff+0x198>
> c039fbe4:	e59b3004 	ldr	r3, [fp, #4]
> c039fbe8:	e12fff33 	blx	r3
> c039fbec:	e2555001 	subs	r5, r5, #1
> c039fbf0:	0a000004 	beq	c039fc08 <quirk_usb_early_handoff+0x1ac>
> c039fbf4:	e5963000 	ldr	r3, [r6]
> c039fbf8:	f57ff04f 	dsb	sy
> c039fbfc:	e3130001 	tst	r3, #1
> c039fc00:	e1a00007 	mov	r0, r7
> c039fc04:	1afffff6 	bne	c039fbe4 <quirk_usb_early_handoff+0x188>
> c039fc08:	e30130b9 	movw	r3, #4281	; 0x10b9
> c039fc0c:	e3453237 	movt	r3, #21047	; 0x5237
> c039fc10:	e1590003 	cmp	r9, r3
> c039fc14:	1a0000f7 	bne	c039fff8 <quirk_usb_early_handoff+0x59c>
> c039fc18:	e1a00008 	mov	r0, r8
> c039fc1c:	ebf5c806 	bl	c0111c3c <iounmap>
> c039fc20:	eaffffae 	b	c039fae0 <quirk_usb_early_handoff+0x84>
> c039fc24:	e594316c 	ldr	r3, [r4, #364]	; 0x16c
> c039fc28:	e3530000 	cmp	r3, #0
> c039fc2c:	0affffab 	beq	c039fae0 <quirk_usb_early_handoff+0x84>
> c039fc30:	e1a00004 	mov	r0, r4
> c039fc34:	ebffff55 	bl	c039f990 <mmio_resource_enabled.part.0>
> c039fc38:	e3500000 	cmp	r0, #0
> c039fc3c:	0affffa7 	beq	c039fae0 <quirk_usb_early_handoff+0x84>
> c039fc40:	e3a01000 	mov	r1, #0
> c039fc44:	e1a00004 	mov	r0, r4
> c039fc48:	ebfd783b 	bl	c02fdd3c <pci_ioremap_bar>
> c039fc4c:	e250b000 	subs	fp, r0, #0
> c039fc50:	0affffa2 	beq	c039fae0 <quirk_usb_early_handoff+0x84>
> c039fc54:	e5db8000 	ldrb	r8, [fp]
> c039fc58:	e6ef8078 	uxtb	r8, r8
> c039fc5c:	f57ff04f 	dsb	sy
> c039fc60:	e08b8008 	add	r8, fp, r8
> c039fc64:	e59b6008 	ldr	r6, [fp, #8]
> c039fc68:	f57ff04f 	dsb	sy
> c039fc6c:	e7e76456 	ubfx	r6, r6, #8, #8
> c039fc70:	e3560000 	cmp	r6, #0
> c039fc74:	0a0000c8 	beq	c039ff9c <quirk_usb_early_handoff+0x540>
> c039fc78:	e3073bf4 	movw	r3, #31732	; 0x7bf4
> c039fc7c:	e3079b80 	movw	r9, #31616	; 0x7b80
> c039fc80:	e34c3059 	movt	r3, #49241	; 0xc059
> c039fc84:	e34c9059 	movt	r9, #49241	; 0xc059
> c039fc88:	e58d3004 	str	r3, [sp, #4]
> c039fc8c:	e3a0703f 	mov	r7, #63	; 0x3f
> c039fc90:	e284a068 	add	sl, r4, #104	; 0x68
> c039fc94:	ea00000d 	b	c039fcd0 <quirk_usb_early_handoff+0x274>
> c039fc98:	e3520001 	cmp	r2, #1
> c039fc9c:	1a000014 	bne	c039fcf4 <quirk_usb_early_handoff+0x298>
> c039fca0:	e2113801 	ands	r3, r1, #65536	; 0x10000
> c039fca4:	e58d100c 	str	r1, [sp, #12]
> c039fca8:	1a00008c 	bne	c039fee0 <quirk_usb_early_handoff+0x484>
> c039fcac:	e2862004 	add	r2, r6, #4
> c039fcb0:	e594101c 	ldr	r1, [r4, #28]
> c039fcb4:	e5940008 	ldr	r0, [r4, #8]
> c039fcb8:	ebfd674f 	bl	c02f99fc <pci_bus_write_config_dword>
> c039fcbc:	e5dd6009 	ldrb	r6, [sp, #9]
> c039fcc0:	e3560000 	cmp	r6, #0
> c039fcc4:	0a0000b4 	beq	c039ff9c <quirk_usb_early_handoff+0x540>
> c039fcc8:	e2577001 	subs	r7, r7, #1
> c039fccc:	0a0000ac 	beq	c039ff84 <quirk_usb_early_handoff+0x528>
> c039fcd0:	e1a02006 	mov	r2, r6
> c039fcd4:	e594101c 	ldr	r1, [r4, #28]
> c039fcd8:	e28d3008 	add	r3, sp, #8
> c039fcdc:	e5940008 	ldr	r0, [r4, #8]
> c039fce0:	ebfd62c7 	bl	c02f8804 <pci_bus_read_config_dword>
> c039fce4:	e59d1008 	ldr	r1, [sp, #8]
> c039fce8:	e21120ff 	ands	r2, r1, #255	; 0xff
> c039fcec:	1affffe9 	bne	c039fc98 <quirk_usb_early_handoff+0x23c>
> c039fcf0:	e58d2008 	str	r2, [sp, #8]
> c039fcf4:	e1a01009 	mov	r1, r9
> c039fcf8:	e1a0000a 	mov	r0, sl
> c039fcfc:	ebfeb48b 	bl	c034cf30 <dev_warn>
> c039fd00:	eaffffed 	b	c039fcbc <quirk_usb_early_handoff+0x260>
> c039fd04:	e3071b50 	movw	r1, #31568	; 0x7b50
> c039fd08:	e2840068 	add	r0, r4, #104	; 0x68
> c039fd0c:	e34c1059 	movt	r1, #49241	; 0xc059
> c039fd10:	ebfeb486 	bl	c034cf30 <dev_warn>
> c039fd14:	eaffff5d 	b	c039fa90 <quirk_usb_early_handoff+0x34>
> c039fd18:	e594316c 	ldr	r3, [r4, #364]	; 0x16c
> c039fd1c:	e3530000 	cmp	r3, #0
> c039fd20:	0affff6e 	beq	c039fae0 <quirk_usb_early_handoff+0x84>
> c039fd24:	e5946170 	ldr	r6, [r4, #368]	; 0x170
> c039fd28:	e1a00004 	mov	r0, r4
> c039fd2c:	e2866001 	add	r6, r6, #1
> c039fd30:	e0466003 	sub	r6, r6, r3
> c039fd34:	ebffff15 	bl	c039f990 <mmio_resource_enabled.part.0>
> c039fd38:	e3500000 	cmp	r0, #0
> c039fd3c:	0affff67 	beq	c039fae0 <quirk_usb_early_handoff+0x84>
> c039fd40:	e1a01006 	mov	r1, r6
> c039fd44:	e594016c 	ldr	r0, [r4, #364]	; 0x16c
> c039fd48:	ebf5c865 	bl	c0111ee4 <ioremap>
> c039fd4c:	e2507000 	subs	r7, r0, #0
> c039fd50:	0affff62 	beq	c039fae0 <quirk_usb_early_handoff+0x84>
> c039fd54:	e5973010 	ldr	r3, [r7, #16]
> c039fd58:	f57ff04f 	dsb	sy
> c039fd5c:	e3730001 	cmn	r3, #1
> c039fd60:	0a000002 	beq	c039fd70 <quirk_usb_early_handoff+0x314>
> c039fd64:	e1a03823 	lsr	r3, r3, #16
> c039fd68:	e1b03103 	lsls	r3, r3, #2
> c039fd6c:	1a000033 	bne	c039fe40 <quirk_usb_early_handoff+0x3e4>
> c039fd70:	e1d422b0 	ldrh	r2, [r4, #32]
> c039fd74:	e3083086 	movw	r3, #32902	; 0x8086
> c039fd78:	e1520003 	cmp	r2, r3
> c039fd7c:	0a0000f4 	beq	c03a0154 <quirk_usb_early_handoff+0x6f8>
> c039fd80:	e5978000 	ldr	r8, [r7]
> c039fd84:	f57ff04f 	dsb	sy
> c039fd88:	e6ef8078 	uxtb	r8, r8
> c039fd8c:	e307a4dc 	movw	sl, #29916	; 0x74dc
> c039fd90:	e3049dd2 	movw	r9, #19922	; 0x4dd2
> c039fd94:	e0878008 	add	r8, r7, r8
> c039fd98:	e34ca05a 	movt	sl, #49242	; 0xc05a
> c039fd9c:	e2886004 	add	r6, r8, #4
> c039fda0:	e3409062 	movt	r9, #98	; 0x62
> c039fda4:	e3a05f7d 	mov	r5, #500	; 0x1f4
> c039fda8:	ea000003 	b	c039fdbc <quirk_usb_early_handoff+0x360>
> c039fdac:	e59a3004 	ldr	r3, [sl, #4]
> c039fdb0:	e12fff33 	blx	r3
> c039fdb4:	e2555001 	subs	r5, r5, #1
> c039fdb8:	0a0000d1 	beq	c03a0104 <quirk_usb_early_handoff+0x6a8>
> c039fdbc:	e5963000 	ldr	r3, [r6]
> c039fdc0:	f57ff04f 	dsb	sy
> c039fdc4:	e3130b02 	tst	r3, #2048	; 0x800
> c039fdc8:	e1a00009 	mov	r0, r9
> c039fdcc:	1afffff6 	bne	c039fdac <quirk_usb_early_handoff+0x350>
> c039fdd0:	e5985000 	ldr	r5, [r8]
> c039fdd4:	f57ff04f 	dsb	sy
> c039fdd8:	e3c55b01 	bic	r5, r5, #1024	; 0x400
> c039fddc:	e3c5500d 	bic	r5, r5, #13
> c039fde0:	f57ff04e 	dsb	st
> c039fde4:	ebf5c612 	bl	c0111634 <arm_heavy_mb>
> c039fde8:	e5885000 	str	r5, [r8]
> c039fdec:	e307a4dc 	movw	sl, #29916	; 0x74dc
> c039fdf0:	e30c9cc1 	movw	r9, #52417	; 0xccc1
> c039fdf4:	e34ca05a 	movt	sl, #49242	; 0xc05a
> c039fdf8:	e34094cc 	movt	r9, #1228	; 0x4cc
> c039fdfc:	e3a05080 	mov	r5, #128	; 0x80
> c039fe00:	ea000003 	b	c039fe14 <quirk_usb_early_handoff+0x3b8>
> c039fe04:	e59a3004 	ldr	r3, [sl, #4]
> c039fe08:	e12fff33 	blx	r3
> c039fe0c:	e2555001 	subs	r5, r5, #1
> c039fe10:	0a0000c2 	beq	c03a0120 <quirk_usb_early_handoff+0x6c4>
> c039fe14:	e5963000 	ldr	r3, [r6]
> c039fe18:	f57ff04f 	dsb	sy
> c039fe1c:	e3130001 	tst	r3, #1
> c039fe20:	e1a00009 	mov	r0, r9
> c039fe24:	0afffff6 	beq	c039fe04 <quirk_usb_early_handoff+0x3a8>
> c039fe28:	e1a00007 	mov	r0, r7
> c039fe2c:	ebf5c782 	bl	c0111c3c <iounmap>
> c039fe30:	eaffff2a 	b	c039fae0 <quirk_usb_early_handoff+0x84>
> c039fe34:	e3500000 	cmp	r0, #0
> c039fe38:	e0833100 	add	r3, r3, r0, lsl #2
> c039fe3c:	0affffcb 	beq	c039fd70 <quirk_usb_early_handoff+0x314>
> c039fe40:	e0878003 	add	r8, r7, r3
> c039fe44:	e5982000 	ldr	r2, [r8]
> c039fe48:	f57ff04f 	dsb	sy
> c039fe4c:	e3720001 	cmn	r2, #1
> c039fe50:	e6ef1072 	uxtb	r1, r2
> c039fe54:	e7e70452 	ubfx	r0, r2, #8, #8
> c039fe58:	0affffc4 	beq	c039fd70 <quirk_usb_early_handoff+0x314>
> c039fe5c:	e2411001 	sub	r1, r1, #1
> c039fe60:	e3530000 	cmp	r3, #0
> c039fe64:	e16f1f11 	clz	r1, r1
> c039fe68:	e1a012a1 	lsr	r1, r1, #5
> c039fe6c:	03a01000 	moveq	r1, #0
> c039fe70:	e3510000 	cmp	r1, #0
> c039fe74:	0affffee 	beq	c039fe34 <quirk_usb_early_handoff+0x3d8>
> c039fe78:	e2835004 	add	r5, r3, #4
> c039fe7c:	e1550006 	cmp	r5, r6
> c039fe80:	8a0000ae 	bhi	c03a0140 <quirk_usb_early_handoff+0x6e4>
> c039fe84:	e598a000 	ldr	sl, [r8]
> c039fe88:	f57ff04f 	dsb	sy
> c039fe8c:	e5942020 	ldr	r2, [r4, #32]
> c039fe90:	e301104c 	movw	r1, #4172	; 0x104c
> c039fe94:	e3013912 	movw	r3, #6418	; 0x1912
> c039fe98:	e3481241 	movt	r1, #33345	; 0x8241
> c039fe9c:	e3403014 	movt	r3, #20
> c039fea0:	e1520003 	cmp	r2, r3
> c039fea4:	11520001 	cmpne	r2, r1
> c039fea8:	0a0000ac 	beq	c03a0160 <quirk_usb_early_handoff+0x704>
> c039feac:	e31a0801 	tst	sl, #65536	; 0x10000
> c039feb0:	1a0000b1 	bne	c03a017c <quirk_usb_early_handoff+0x720>
> c039feb4:	e0875005 	add	r5, r7, r5
> c039feb8:	e5956000 	ldr	r6, [r5]
> c039febc:	f57ff04f 	dsb	sy
> c039fec0:	e3012fee 	movw	r2, #8174	; 0x1fee
> c039fec4:	e340200e 	movt	r2, #14
> c039fec8:	e0022006 	and	r2, r2, r6
> c039fecc:	e382620e 	orr	r6, r2, #-536870912	; 0xe0000000
> c039fed0:	f57ff04e 	dsb	st
> c039fed4:	ebf5c5d6 	bl	c0111634 <arm_heavy_mb>
> c039fed8:	e5856000 	str	r6, [r5]
> c039fedc:	eaffffa3 	b	c039fd70 <quirk_usb_early_handoff+0x314>
> c039fee0:	e1a03002 	mov	r3, r2
> c039fee4:	e594101c 	ldr	r1, [r4, #28]
> c039fee8:	e2862003 	add	r2, r6, #3
> c039feec:	e5940008 	ldr	r0, [r4, #8]
> c039fef0:	ebfd6267 	bl	c02f8894 <pci_bus_write_config_byte>
> c039fef4:	e59d300c 	ldr	r3, [sp, #12]
> c039fef8:	e2133801 	ands	r3, r3, #65536	; 0x10000
> c039fefc:	0affff6a 	beq	c039fcac <quirk_usb_early_handoff+0x250>
> c039ff00:	e3a05064 	mov	r5, #100	; 0x64
> c039ff04:	ea000001 	b	c039ff10 <quirk_usb_early_handoff+0x4b4>
> c039ff08:	e2555001 	subs	r5, r5, #1
> c039ff0c:	0a000013 	beq	c039ff60 <quirk_usb_early_handoff+0x504>
> c039ff10:	e3a0000a 	mov	r0, #10
> c039ff14:	ebf734be 	bl	c016d214 <msleep>
> c039ff18:	e1a02006 	mov	r2, r6
> c039ff1c:	e28d300c 	add	r3, sp, #12
> c039ff20:	e594101c 	ldr	r1, [r4, #28]
> c039ff24:	e5940008 	ldr	r0, [r4, #8]
> c039ff28:	ebfd6235 	bl	c02f8804 <pci_bus_read_config_dword>
> c039ff2c:	e59d200c 	ldr	r2, [sp, #12]
> c039ff30:	e3120801 	tst	r2, #65536	; 0x10000
> c039ff34:	1afffff3 	bne	c039ff08 <quirk_usb_early_handoff+0x4ac>
> c039ff38:	e2862004 	add	r2, r6, #4
> c039ff3c:	e3a03000 	mov	r3, #0
> c039ff40:	e594101c 	ldr	r1, [r4, #28]
> c039ff44:	e5940008 	ldr	r0, [r4, #8]
> c039ff48:	ebfd66ab 	bl	c02f99fc <pci_bus_write_config_dword>
> c039ff4c:	f57ff04e 	dsb	st
> c039ff50:	ebf5c5b7 	bl	c0111634 <arm_heavy_mb>
> c039ff54:	e3a03000 	mov	r3, #0
> c039ff58:	e5883040 	str	r3, [r8, #64]	; 0x40
> c039ff5c:	eaffff56 	b	c039fcbc <quirk_usb_early_handoff+0x260>
> c039ff60:	e1a0000a 	mov	r0, sl
> c039ff64:	e59d1004 	ldr	r1, [sp, #4]
> c039ff68:	ebfeb3f0 	bl	c034cf30 <dev_warn>
> c039ff6c:	e1a03005 	mov	r3, r5
> c039ff70:	e2862002 	add	r2, r6, #2
> c039ff74:	e594101c 	ldr	r1, [r4, #28]
> c039ff78:	e5940008 	ldr	r0, [r4, #8]
> c039ff7c:	ebfd6244 	bl	c02f8894 <pci_bus_write_config_byte>
> c039ff80:	eaffffec 	b	c039ff38 <quirk_usb_early_handoff+0x4dc>
> c039ff84:	e3072c20 	movw	r2, #31776	; 0x7c20
> c039ff88:	e3080b30 	movw	r0, #35632	; 0x8b30
> c039ff8c:	e34c2059 	movt	r2, #49241	; 0xc059
> c039ff90:	e34c0057 	movt	r0, #49239	; 0xc057
> c039ff94:	e2841068 	add	r1, r4, #104	; 0x68
> c039ff98:	ebfeb37a 	bl	c034cd88 <dev_printk>
> c039ff9c:	e2886004 	add	r6, r8, #4
> c039ffa0:	e5983004 	ldr	r3, [r8, #4]
> c039ffa4:	f57ff04f 	dsb	sy
> c039ffa8:	e3130a01 	tst	r3, #4096	; 0x1000
> c039ffac:	0a000037 	beq	c03a0090 <quirk_usb_early_handoff+0x634>
> c039ffb0:	f57ff04e 	dsb	st
> c039ffb4:	ebf5c59e 	bl	c0111634 <arm_heavy_mb>
> c039ffb8:	e3a03000 	mov	r3, #0
> c039ffbc:	e5883008 	str	r3, [r8, #8]
> c039ffc0:	f57ff04e 	dsb	st
> c039ffc4:	ebf5c59a 	bl	c0111634 <arm_heavy_mb>
> c039ffc8:	e3a0303f 	mov	r3, #63	; 0x3f
> c039ffcc:	e5883004 	str	r3, [r8, #4]
> c039ffd0:	e1a0000b 	mov	r0, fp
> c039ffd4:	ebf5c718 	bl	c0111c3c <iounmap>
> c039ffd8:	eafffec0 	b	c039fae0 <quirk_usb_early_handoff+0x84>
> c039ffdc:	e0840280 	add	r0, r4, r0, lsl #5
> c039ffe0:	e590116c 	ldr	r1, [r0, #364]	; 0x16c
> c039ffe4:	e3510000 	cmp	r1, #0
> c039ffe8:	0afffebc 	beq	c039fae0 <quirk_usb_early_handoff+0x84>
> c039ffec:	e1a00004 	mov	r0, r4
> c039fff0:	ebfffe40 	bl	c039f8f8 <uhci_check_and_reset_hc>
> c039fff4:	eafffeb9 	b	c039fae0 <quirk_usb_early_handoff+0x84>
> c039fff8:	f57ff04e 	dsb	st
> c039fffc:	ebf5c58c 	bl	c0111634 <arm_heavy_mb>
> c03a0000:	e588a034 	str	sl, [r8, #52]	; 0x34
> c03a0004:	eaffff03 	b	c039fc18 <quirk_usb_early_handoff+0x1bc>
> c03a0008:	f57ff04e 	dsb	st
> c03a000c:	ebf5c588 	bl	c0111634 <arm_heavy_mb>
> c03a0010:	e20aac02 	and	sl, sl, #512	; 0x200
> c03a0014:	e588a004 	str	sl, [r8, #4]
> c03a0018:	e5983004 	ldr	r3, [r8, #4]
> c03a001c:	f57ff04f 	dsb	sy
> c03a0020:	e3a00032 	mov	r0, #50	; 0x32
> c03a0024:	ebf7347a 	bl	c016d214 <msleep>
> c03a0028:	eafffedc 	b	c039fba0 <quirk_usb_early_handoff+0x144>
> c03a002c:	f57ff04e 	dsb	st
> c03a0030:	ebf5c57f 	bl	c0111634 <arm_heavy_mb>
> c03a0034:	e3a03101 	mov	r3, #1073741824	; 0x40000000
> c03a0038:	e5883010 	str	r3, [r8, #16]
> c03a003c:	f57ff04e 	dsb	st
> c03a0040:	ebf5c57b 	bl	c0111634 <arm_heavy_mb>
> c03a0044:	e2886008 	add	r6, r8, #8
> c03a0048:	e3a03008 	mov	r3, #8
> c03a004c:	e5883008 	str	r3, [r8, #8]
> c03a0050:	e3a05032 	mov	r5, #50	; 0x32
> c03a0054:	e5973000 	ldr	r3, [r7]
> c03a0058:	f57ff04f 	dsb	sy
> c03a005c:	e3130c01 	tst	r3, #256	; 0x100
> c03a0060:	e3a0000a 	mov	r0, #10
> c03a0064:	0afffec7 	beq	c039fb88 <quirk_usb_early_handoff+0x12c>
> c03a0068:	ebf73469 	bl	c016d214 <msleep>
> c03a006c:	e2555001 	subs	r5, r5, #1
> c03a0070:	1afffff7 	bne	c03a0054 <quirk_usb_early_handoff+0x5f8>
> c03a0074:	e5982004 	ldr	r2, [r8, #4]
> c03a0078:	f57ff04f 	dsb	sy
> c03a007c:	e3071bc8 	movw	r1, #31688	; 0x7bc8
> c03a0080:	e2840068 	add	r0, r4, #104	; 0x68
> c03a0084:	e34c1059 	movt	r1, #49241	; 0xc059
> c03a0088:	ebfeb3a8 	bl	c034cf30 <dev_warn>
> c03a008c:	eafffebd 	b	c039fb88 <quirk_usb_early_handoff+0x12c>
> c03a0090:	e5985000 	ldr	r5, [r8]
> c03a0094:	f57ff04f 	dsb	sy
> c03a0098:	e3c55001 	bic	r5, r5, #1
> c03a009c:	f57ff04e 	dsb	st
> c03a00a0:	ebf5c563 	bl	c0111634 <arm_heavy_mb>
> c03a00a4:	e5885000 	str	r5, [r8]
> c03a00a8:	e30774dc 	movw	r7, #29916	; 0x74dc
> c03a00ac:	e3009a34 	movw	r9, #2612	; 0xa34
> c03a00b0:	e34c705a 	movt	r7, #49242	; 0xc05a
> c03a00b4:	e34093d7 	movt	r9, #983	; 0x3d7
> c03a00b8:	e3a05e7d 	mov	r5, #2000	; 0x7d0
> c03a00bc:	e3a0a03f 	mov	sl, #63	; 0x3f
> c03a00c0:	f57ff04e 	dsb	st
> c03a00c4:	ebf5c55a 	bl	c0111634 <arm_heavy_mb>
> c03a00c8:	e586a000 	str	sl, [r6]
> c03a00cc:	e5973004 	ldr	r3, [r7, #4]
> c03a00d0:	e1a00009 	mov	r0, r9
> c03a00d4:	e12fff33 	blx	r3
> c03a00d8:	e2455064 	sub	r5, r5, #100	; 0x64
> c03a00dc:	e5963000 	ldr	r3, [r6]
> c03a00e0:	f57ff04f 	dsb	sy
> c03a00e4:	e3730001 	cmn	r3, #1
> c03a00e8:	e2232a01 	eor	r2, r3, #4096	; 0x1000
> c03a00ec:	0affffaf 	beq	c039ffb0 <quirk_usb_early_handoff+0x554>
> c03a00f0:	e2953000 	adds	r3, r5, #0
> c03a00f4:	13a03001 	movne	r3, #1
> c03a00f8:	e0133622 	ands	r3, r3, r2, lsr #12
> c03a00fc:	1affffef 	bne	c03a00c0 <quirk_usb_early_handoff+0x664>
> c03a0100:	eaffffaa 	b	c039ffb0 <quirk_usb_early_handoff+0x554>
> c03a0104:	e5982004 	ldr	r2, [r8, #4]
> c03a0108:	f57ff04f 	dsb	sy
> c03a010c:	e3071c64 	movw	r1, #31844	; 0x7c64
> c03a0110:	e2840068 	add	r0, r4, #104	; 0x68
> c03a0114:	e34c1059 	movt	r1, #49241	; 0xc059
> c03a0118:	ebfeb384 	bl	c034cf30 <dev_warn>
> c03a011c:	eaffff2b 	b	c039fdd0 <quirk_usb_early_handoff+0x374>
> c03a0120:	e5983004 	ldr	r3, [r8, #4]
> c03a0124:	f57ff04f 	dsb	sy
> c03a0128:	e3071c9c 	movw	r1, #31900	; 0x7c9c
> c03a012c:	e2840068 	add	r0, r4, #104	; 0x68
> c03a0130:	e34c1059 	movt	r1, #49241	; 0xc059
> c03a0134:	e3a02dfa 	mov	r2, #16000	; 0x3e80
> c03a0138:	ebfeb37c 	bl	c034cf30 <dev_warn>
> c03a013c:	eaffff39 	b	c039fe28 <quirk_usb_early_handoff+0x3cc>
> c03a0140:	e3071ba4 	movw	r1, #31652	; 0x7ba4
> c03a0144:	e2840068 	add	r0, r4, #104	; 0x68
> c03a0148:	e34c1059 	movt	r1, #49241	; 0xc059
> c03a014c:	ebfeb377 	bl	c034cf30 <dev_warn>
> c03a0150:	eaffff34 	b	c039fe28 <quirk_usb_early_handoff+0x3cc>
> c03a0154:	e1a00004 	mov	r0, r4
> c03a0158:	ebfffe1c 	bl	c039f9d0 <usb_enable_intel_xhci_ports>
> c03a015c:	eaffff07 	b	c039fd80 <quirk_usb_early_handoff+0x324>
> c03a0160:	e3caa401 	bic	sl, sl, #16777216	; 0x1000000
> c03a0164:	e3caa801 	bic	sl, sl, #65536	; 0x10000
> c03a0168:	e38aa401 	orr	sl, sl, #16777216	; 0x1000000
> c03a016c:	f57ff04e 	dsb	st
> c03a0170:	ebf5c52f 	bl	c0111634 <arm_heavy_mb>
> c03a0174:	e588a000 	str	sl, [r8]
> c03a0178:	eaffff4b 	b	c039feac <quirk_usb_early_handoff+0x450>
> c03a017c:	f57ff04e 	dsb	st
> c03a0180:	ebf5c52b 	bl	c0111634 <arm_heavy_mb>
> c03a0184:	e38a3401 	orr	r3, sl, #16777216	; 0x1000000
> c03a0188:	e5883000 	str	r3, [r8]
> c03a018c:	e307b4dc 	movw	fp, #29916	; 0x74dc
> c03a0190:	e3049dd2 	movw	r9, #19922	; 0x4dd2
> c03a0194:	e34cb05a 	movt	fp, #49242	; 0xc05a
> c03a0198:	e3409062 	movt	r9, #98	; 0x62
> c03a019c:	e3a06f7d 	mov	r6, #500	; 0x1f4
> c03a01a0:	e5983000 	ldr	r3, [r8]
> c03a01a4:	f57ff04f 	dsb	sy
> c03a01a8:	e3130801 	tst	r3, #65536	; 0x10000
> c03a01ac:	e1a00009 	mov	r0, r9
> c03a01b0:	0affff3f 	beq	c039feb4 <quirk_usb_early_handoff+0x458>
> c03a01b4:	e59b3004 	ldr	r3, [fp, #4]
> c03a01b8:	e12fff33 	blx	r3
> c03a01bc:	e2566001 	subs	r6, r6, #1
> c03a01c0:	1afffff6 	bne	c03a01a0 <quirk_usb_early_handoff+0x744>
> c03a01c4:	e3071c38 	movw	r1, #31800	; 0x7c38
> c03a01c8:	e1a0200a 	mov	r2, sl
> c03a01cc:	e34c1059 	movt	r1, #49241	; 0xc059
> c03a01d0:	e2840068 	add	r0, r4, #104	; 0x68
> c03a01d4:	ebfeb355 	bl	c034cf30 <dev_warn>
> c03a01d8:	f57ff04e 	dsb	st
> c03a01dc:	ebf5c514 	bl	c0111634 <arm_heavy_mb>
> c03a01e0:	e3caa801 	bic	sl, sl, #65536	; 0x10000
> c03a01e4:	e588a000 	str	sl, [r8]
> c03a01e8:	eaffff31 	b	c039feb4 <quirk_usb_early_handoff+0x458>
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
