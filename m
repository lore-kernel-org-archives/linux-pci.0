Return-Path: <rui.y.wang@intel.com>
Return-Path: <rui.y.wang@intel.com>
From: Rui Wang <rui.y.wang@intel.com>
To: bp@alien8.de
Cc: bhelgaas@google.com,
	torvalds@linux-foundation.org,
	peterz@infradead.org,
	tglx@linutronix.de,
	helgaas@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	rjw@rjwysocki.net,
	tony.luck@intel.com,
	mingo@kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	rui.y.wang@intel.com
Subject: Re: 584c5c422f6c ("x86/ioapic: Support hot-removal of IOAPICs present during boot")
Date: Sat, 10 Sep 2016 21:11:30 +0800
Message-Id: <1473513090-30218-1-git-send-email-rui.y.wang@intel.com>
In-Reply-To: <20160910112744.4a6inn5bnjxsseak@pd.tnic>
References: <20160910112744.4a6inn5bnjxsseak@pd.tnic>
List-ID: <linux-pci.vger.kernel.org>

On Sat, Sep 10, 2016 7:28 PM, Borislav Petkov wrote:
> 
> ffffffff8143ef50 <acpi_ns_walk_namespace>:
> ffffffff8143ef50:       e8 6b 16 42 00          callq  ffffffff818605c0 <__fentry__>
> ffffffff8143ef55:       55                      push   %rbp
> ffffffff8143ef56:       48 89 e5                mov    %rsp,%rbp
> ffffffff8143ef59:       41 57                   push   %r15
> ffffffff8143ef5b:       41 56                   push   %r14
> ffffffff8143ef5d:       49 89 f6                mov    %rsi,%r14
> ffffffff8143ef60:       41 55                   push   %r13
> ffffffff8143ef62:       41 54                   push   %r12
> ffffffff8143ef64:       41 89 cc                mov    %ecx,%r12d
> ffffffff8143ef67:       53                      push   %rbx
> ffffffff8143ef68:       bb 01 00 00 00          mov    $0x1,%ebx
> ffffffff8143ef6d:       48 83 ec 28             sub    $0x28,%rsp
> ffffffff8143ef71:       48 83 fe ff             cmp    $0xffffffffffffffff,%rsi
> ffffffff8143ef75:       89 7d d0                mov    %edi,-0x30(%rbp)
> ffffffff8143ef78:       4c 0f 44 35 58 7b 99    cmove  0x1997b58(%rip),%r14  # ffffffff82dd6ad8 <acpi_gbl_root_node>
> ffffffff8143ef7f:       01
> ffffffff8143ef80:       89 55 c8                mov    %edx,-0x38(%rbp)
> ffffffff8143ef83:       45 31 ff                xor    %r15d,%r15d
> ffffffff8143ef86:       41 83 e4 01             and    $0x1,%r12d
> ffffffff8143ef8a:       89 4d cc                mov    %ecx,-0x34(%rbp)
> ffffffff8143ef8d:       4d 8b 6e 18             mov    0x18(%r14),%r13    <--- > faulting insn.
> ffffffff8143ef91:       4c 89 45 c0             mov    %r8,-0x40(%rbp)
> ffffffff8143ef95:       4c 89 4d b8             mov    %r9,-0x48(%rbp)
> ffffffff8143ef99:       c7 45 d4 00 00 00 00    movl   $0x0,-0x2c(%rbp)
> ffffffff8143efa0:       4d 85 ed                test   %r13,%r13

Thanks for the analysis. Looks like acpi_gbl_root_node == 0. It is
initialized earlier than where we call acpi_ioapic_add().
start_kernel()
	->acpi_early_init()
		->acpi_initialize_subsystem()
			 ->acpi_ns_root_initialize()
				-> acpi_gbl_root_node = ...


But acpi_gbl_root_node can be 0 if acpi_disabled == 1.
Do you somehow have acpi turned off (!CONFIG_ACPI or booting with acpi=off)?

Thanks
Rui
