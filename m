Return-Path: <bp@alien8.de>
Return-Path: <bp@alien8.de>
Date: Sat, 10 Sep 2016 13:27:44 +0200
From: Borislav Petkov <bp@alien8.de>
To: Rui Wang <rui.y.wang@intel.com>
Cc: bhelgaas@google.com, torvalds@linux-foundation.org,
	peterz@infradead.org, tglx@linutronix.de, helgaas@kernel.org,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	rjw@rjwysocki.net, tony.luck@intel.com, mingo@kernel.org,
	x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: 584c5c422f6c ("x86/ioapic: Support hot-removal of IOAPICs
 present during boot")
Message-ID: <20160910112744.4a6inn5bnjxsseak@pd.tnic>
References: <20160909220710.etdw5zzubb72xv53@pd.tnic>
 <1473466444-25519-1-git-send-email-rui.y.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1473466444-25519-1-git-send-email-rui.y.wang@intel.com>
List-ID: <linux-pci.vger.kernel.org>

On Sat, Sep 10, 2016 at 08:14:04AM +0800, Rui Wang wrote:
> Is it a Romley-EP ? What kind of SNB box is it? I'll try to find one
> to reproduce the problem.

You don't have to - I went and analyzed it for you but it is ACPI
crap and I can't be bothered to think of a solution. It looks like
a chicken-and-an-egg issue where you call acpi_ioapic_add() on the
root_bus and something's not initialized there in the chain of parent
and children nodes.

But I could very well be wrong so let me dump the details, I'll let
someone else make sense of it all. Provided I've not made a mistake
somewhere, which is not uncommon.

So the splat is:

[    4.396872] pci_bus 0000:3f: resource 5 [mem 0x00000000-0x3fffffffffff]
[    4.403493] BUG: unable to handle kernel NULL pointer dereference at 0000000000000018
[    4.411331] IP: [<ffffffff8143ef8d>] acpi_ns_walk_namespace+0x3d/0x18f
[    4.417878] PGD 0 
[    4.419900] Oops: 0000 [#1] PREEMPT SMP
[    4.423731] Modules linked in:
[    4.426791] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.8.0-rc5+ #13
[    4.433122] Hardware name: Dell Inc. Precision T3600/0PTTT9, BIOS A13 05/11/2014
[    4.440506] task: ffff88043be70000 task.stack: ffffc90000020000
[    4.446405] RIP: 0010:[<ffffffff8143ef8d>]  [<ffffffff8143ef8d>] acpi_ns_walk_namespace+0x3d/0x18f
[    4.455348] RSP: 0000:ffffc90000023d98  EFLAGS: 00010202
[    4.460641] RAX: ffffffff82dd6ae0 RBX: 0000000000000001 RCX: 0000000000000001
[    4.467752] RDX: 00000000ffffffff RSI: 0000000000000000 RDI: 0000000000000006
[    4.474854] RBP: ffffc90000023de8 R08: ffffffff8144bfaa R09: 0000000000000000
[    4.481962] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
[    4.489071] R13: ffffffff8144bfaa R14: 0000000000000000 R15: 0000000000000000
[    4.496187] FS:  0000000000000000(0000) GS:ffff88043de00000(0000) knlGS:0000000000000000
[    4.504242] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    4.509967] CR2: 0000000000000018 CR3: 0000000003e05000 CR4: 00000000000406f0
[    4.517078] Stack:
[    4.519079]  0000000000000018 ffffffff82dd6c58 ffffc90000023dc0 00000001ffffffff
[    4.526476]  0000000000000006 0000000000000000 0000000000001001 ffffffff8144bfaa
[    4.533876]  0000000000000000 0000000000000000 ffffc90000023e38 ffffffff8143f51d
[    4.541273] Call Trace:
[    4.543714]  [<ffffffff8144bfaa>] ? setup_res+0x94/0x94
[    4.548915]  [<ffffffff8143f51d>] acpi_walk_namespace+0x9b/0xcf
[    4.554838]  [<ffffffff81fc44c1>] ? ras_debugfs_init+0x1b/0x1b
[    4.560645]  [<ffffffff8144c376>] acpi_ioapic_add+0x33/0x4c
[    4.566221]  [<ffffffff81faf09a>] pci_assign_unassigned_resources+0x4e/0x56
[    4.573151]  [<ffffffff81fc44df>] pcibios_assign_resources+0x1e/0xb4
[    4.579476]  [<ffffffff81fc44c1>] ? ras_debugfs_init+0x1b/0x1b
[    4.585306]  [<ffffffff81000440>] do_one_initcall+0x50/0x190
[    4.590969]  [<ffffffff81f73091>] kernel_init_freeable+0x11e/0x1a6
[    4.597130]  [<ffffffff81854d60>] ? rest_init+0x140/0x140
[    4.602506]  [<ffffffff81854d6e>] kernel_init+0xe/0x110
[    4.607735]  [<ffffffff8185f11a>] ret_from_fork+0x2a/0x40
[    4.613110] Code: 41 54 41 89 cc 53 bb 01 00 00 00 48 83 ec 28 48 83 fe ff 89 7d d0 4c 0f 44 35 58 7b 99 01 89 55 c8 45 31 ff 41 83 e4 01 89 4d cc <4d> 8b 6e 18 4c 89 45 c0 4c 89 4d b8 c7 45 d4 00 00 00 00 4d 85 
[    4.632554] RIP  [<ffffffff8143ef8d>] acpi_ns_walk_namespace+0x3d/0x18f
[    4.639148]  RSP <ffffc90000023d98>
[    4.642619] CR2: 0000000000000018
[    4.645944] ---[ end trace 2fbd1c53d9becc2a ]---
[    4.650562] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009
[    4.650562] 
[    4.659694] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009

You can see from the call trace how it happens:

pci_assign_unassigned_resources-> acpi_ioapic_add -> ... which you added.

rIP is this:

ffffffff8143ef50 <acpi_ns_walk_namespace>:
ffffffff8143ef50:       e8 6b 16 42 00          callq  ffffffff818605c0 <__fentry__>
ffffffff8143ef55:       55                      push   %rbp
ffffffff8143ef56:       48 89 e5                mov    %rsp,%rbp
ffffffff8143ef59:       41 57                   push   %r15
ffffffff8143ef5b:       41 56                   push   %r14
ffffffff8143ef5d:       49 89 f6                mov    %rsi,%r14
ffffffff8143ef60:       41 55                   push   %r13
ffffffff8143ef62:       41 54                   push   %r12
ffffffff8143ef64:       41 89 cc                mov    %ecx,%r12d
ffffffff8143ef67:       53                      push   %rbx
ffffffff8143ef68:       bb 01 00 00 00          mov    $0x1,%ebx
ffffffff8143ef6d:       48 83 ec 28             sub    $0x28,%rsp
ffffffff8143ef71:       48 83 fe ff             cmp    $0xffffffffffffffff,%rsi
ffffffff8143ef75:       89 7d d0                mov    %edi,-0x30(%rbp)
ffffffff8143ef78:       4c 0f 44 35 58 7b 99    cmove  0x1997b58(%rip),%r14        # ffffffff82dd6ad8 <acpi_gbl_root_node>
ffffffff8143ef7f:       01 
ffffffff8143ef80:       89 55 c8                mov    %edx,-0x38(%rbp)
ffffffff8143ef83:       45 31 ff                xor    %r15d,%r15d
ffffffff8143ef86:       41 83 e4 01             and    $0x1,%r12d
ffffffff8143ef8a:       89 4d cc                mov    %ecx,-0x34(%rbp)
ffffffff8143ef8d:       4d 8b 6e 18             mov    0x18(%r14),%r13		<--- faulting insn.
ffffffff8143ef91:       4c 89 45 c0             mov    %r8,-0x40(%rbp)
ffffffff8143ef95:       4c 89 4d b8             mov    %r9,-0x48(%rbp)
ffffffff8143ef99:       c7 45 d4 00 00 00 00    movl   $0x0,-0x2c(%rbp)
ffffffff8143efa0:       4d 85 ed                test   %r13,%r13

In the annotated asm, this is:

        .globl  acpi_ns_walk_namespace
        .type   acpi_ns_walk_namespace, @function
acpi_ns_walk_namespace:
.LFB1454:
        .loc 1 191 0
        .cfi_startproc
.LVL5:
        call    __fentry__
        pushq   %rbp    #
        .cfi_def_cfa_offset 16
        .cfi_offset 6, -16
        movq    %rsp, %rbp      #,
        .cfi_def_cfa_register 6
        pushq   %r15    #
        pushq   %r14    #
        .cfi_offset 15, -24
        .cfi_offset 14, -32
        movq    %rsi, %r14      # start_node, start_node
        pushq   %r13    #
        pushq   %r12    #
        .cfi_offset 13, -40
        .cfi_offset 12, -48
        .loc 1 249 0
        movl    %ecx, %r12d     # flags, D.24037
        .loc 1 191 0
        pushq   %rbx    #
        .cfi_offset 3, -56
        .loc 1 213 0
        movl    $1, %ebx        #, level
.LVL6:
        .loc 1 191 0
        subq    $40, %rsp       #,
        .loc 1 205 0
        cmpq    $-1, %rsi       #, start_node
        .loc 1 191 0
        movl    %edi, -48(%rbp) # type, %sfp
        .loc 1 205 0
        cmove   acpi_gbl_root_node(%rip), %r14  # acpi_gbl_root_node,, start_node
.LVL7:
        .loc 1 191 0
        movl    %edx, -56(%rbp) # max_depth, %sfp
        .loc 1 198 0
        xorl    %r15d, %r15d    # node_previously_visited
.LVL8:
        .loc 1 249 0
        andl    $1, %r12d       #, D.24037
        .loc 1 191 0
        movl    %ecx, -52(%rbp) # flags, %sfp
.LBB14:
.LBB15:
        .loc 1 79 0
        movq    24(%r14), %r13  # MEM[(struct acpi_namespace_node *)start_node_1].child, start_node		<--- faulting insn

and the relevant piece of C code is:

        if (start_node == ACPI_ROOT_OBJECT) {
                start_node = acpi_gbl_root_node;
        }

        /* Null child means "get first node" */

        parent_node = start_node;
        child_node = acpi_ns_get_next_node(parent_node, NULL);

And parent_node, i.e., start_node is NULL here and
acpi_ns_get_next_node() tries to deref it to get the child:

	movq    24(%r14), %r13

HTH.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
