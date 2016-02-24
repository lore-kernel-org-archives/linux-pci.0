Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <56C28633.60003@codeaurora.org>
References: <1455554508-18174-1-git-send-email-okaya@codeaurora.org>
	<CAJZ5v0iszEN+ep8yGNX35RP04_ZwnF1K_w+VW5tFR9Jz2_ZJqw@mail.gmail.com>
	<56C28633.60003@codeaurora.org>
Date: Wed, 24 Feb 2016 14:04:48 +0100
Message-ID: <CAJZ5v0j7CwbBw+i1Fc6OCkHO5AZvdLo8yeDhk4asyCFB68ghKg@mail.gmail.com>
Subject: Re: [PATCH] acpi, pci, irq: account for early penalty assignment
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Timur Tabi <timur@codeaurora.org>,
	Christopher Covington <cov@codeaurora.org>,
	Linux PCI <linux-pci@vger.kernel.org>, ravikanth.nalla@hpe.com,
	Len Brown <lenb@kernel.org>, harish.k@hpe.com,
	ashwin.reghunandanan@hpe.com, Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Tue, Feb 16, 2016 at 3:15 AM, Sinan Kaya <okaya@codeaurora.org> wrote:
> On 2/15/2016 7:26 PM, Rafael J. Wysocki wrote:
>> On Mon, Feb 15, 2016 at 5:41 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
>>> A crash has been observed when assigning penalty on x86 systems.
>>>
>>> It looks like this problem happens on x86 platforms with IOAPIC and an SCI
>>> interrupt override in the ACPI table with interrupt number greater than
>>> 16. (22 in this example)
>>>
>>> The bug has been introduced by "ACPI, PCI, irq: remove interrupt count
>>> restriction" commit. The code was using kmalloc to resize the interrupt
>>> list. In this use case, the set penalty call is coming from early phase
>>> and the heap is not initialized yet.
>>>
>>> BUG: unable to handle kernel NULL pointer dereference at 0000000000000018
>>> IP: [<ffffffff811e8b9d>] kmem_cache_alloc_trace+0xad/0x1c0
>>> PGD 0
>>> Oops: 0000 [#1] SMP
>>> Modules linked in:
>>> CPU: 0 PID: 0 Comm: swapper Not tainted 4.5.0-rc2Feb-3_RK #1
>>> Hardware name: HP Superdome2 16s, BIOS Bundle: 007.006.000 SFW: 033.162.000
>>> 10/30/2015
>>> [<ffffffff813bc190>] acpi_irq_set_penalty+0x60/0x8e
>>> [<ffffffff813bc1df>] acpi_irq_add_penalty+0x21/0x26
>>> [<ffffffff813bc76d>] acpi_penalize_sci_irq+0x25/0x28
>>> [<ffffffff81b8260d>] acpi_sci_ioapic_setup+0x68/0x78
>>> [<ffffffff81b830fc>] acpi_boot_init+0x2cc/0x533
>>> [<ffffffff810677c8>] ? set_pte_vaddr_pud+0x48/0x50
>>> [<ffffffff81b828cf>] ? acpi_parse_x2apic+0x77/0x77
>>> [<ffffffff81b82858>] ? dmi_ignore_irq0_timer_override+0x30/0x30
>>> [<ffffffff81b77c1e>] setup_arch+0xc24/0xce9
>>> [<ffffffff81b6e120>] ? early_idt_handler_array+0x120/0x120
>>> [<ffffffff81b6ed94>] start_kernel+0xfc/0x506
>>> [<ffffffff81b6e120>] ? early_idt_handler_array+0x120/0x120
>>> [<ffffffff81b6e120>] ? early_idt_handler_array+0x120/0x120
>>> [<ffffffff81b6e5ee>] x86_64_start_reservations+0x2a/0x2c
>>> [<ffffffff81b6e73c>] x86_64_start_kernel+0x14c/0x16f
>>>
>>> Besides from the use case above, there is one more situation where
>>> set_penalty is being called from the init context like. There is support
>>> for setting the penalty through kernel command line.
>>>
>>> Adding support to be called from early context for limited number of
>>> interrupts.
>>>
>>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>>
>> This looks somewhat hackish to me to be honest.
> I know.

So after an e-mail exchange with Bjorn I've decided to revert the
problematic commit for 4.5, so please submit it again with the fix
folded in (or a better way to address the issue if you have one).

Thanks,
Rafael
