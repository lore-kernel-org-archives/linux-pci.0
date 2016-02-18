Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1455801582-21595-1-git-send-email-okaya@codeaurora.org>
References: <1455801582-21595-1-git-send-email-okaya@codeaurora.org>
Date: Thu, 18 Feb 2016 17:39:03 +0100
Message-ID: <CAJZ5v0hOrY3iP8QQMQxkNtY7vQcrShQuPBxyNBqY6DYaxhf1bA@mail.gmail.com>
Subject: Re: [PATCH V2] acpi, pci, irq: account for early penalty assignment
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Timur Tabi <timur@codeaurora.org>,
	Christopher Covington <cov@codeaurora.org>,
	Linux PCI <linux-pci@vger.kernel.org>, ravikanth.nalla@hpe.com,
	Len Brown <lenb@kernel.org>, harish.k@hpe.com,
	ashwin.reghunandanan@hpe.com,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 18, 2016 at 2:19 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
> A crash has been observed when assigning penalty on x86 systems.
>
> It looks like this problem happens on x86 platforms with IOAPIC and an SCI
> interrupt override in the ACPI table with interrupt number greater than
> 16. (22 in this example)
>
> The bug has been introduced by "ACPI, PCI, irq: remove interrupt count
> restriction" commit. The code was using kmalloc to resize the interrupt
> list. In this use case, the set penalty call is coming from early phase
> and the heap is not initialized yet.
>
> BUG: unable to handle kernel NULL pointer dereference at 0000000000000018
> IP: [<ffffffff811e8b9d>] kmem_cache_alloc_trace+0xad/0x1c0
> PGD 0
> Oops: 0000 [#1] SMP
> Modules linked in:
> CPU: 0 PID: 0 Comm: swapper Not tainted 4.5.0-rc2Feb-3_RK #1
> Hardware name: HP Superdome2 16s, BIOS Bundle: 007.006.000 SFW: 033.162.000
> 10/30/2015
> [<ffffffff813bc190>] acpi_irq_set_penalty+0x60/0x8e
> [<ffffffff813bc1df>] acpi_irq_add_penalty+0x21/0x26
> [<ffffffff813bc76d>] acpi_penalize_sci_irq+0x25/0x28
> [<ffffffff81b8260d>] acpi_sci_ioapic_setup+0x68/0x78
> [<ffffffff81b830fc>] acpi_boot_init+0x2cc/0x533
> [<ffffffff810677c8>] ? set_pte_vaddr_pud+0x48/0x50
> [<ffffffff81b828cf>] ? acpi_parse_x2apic+0x77/0x77
> [<ffffffff81b82858>] ? dmi_ignore_irq0_timer_override+0x30/0x30
> [<ffffffff81b77c1e>] setup_arch+0xc24/0xce9
> [<ffffffff81b6e120>] ? early_idt_handler_array+0x120/0x120
> [<ffffffff81b6ed94>] start_kernel+0xfc/0x506
> [<ffffffff81b6e120>] ? early_idt_handler_array+0x120/0x120
> [<ffffffff81b6e120>] ? early_idt_handler_array+0x120/0x120
> [<ffffffff81b6e5ee>] x86_64_start_reservations+0x2a/0x2c
> [<ffffffff81b6e73c>] x86_64_start_kernel+0x14c/0x16f
>
> Besides from the use case above, there is one more situation where
> set_penalty is being called from the init context like. There is support
> for setting the penalty through kernel command line.
>
> Adding support to be called from early context for limited number of
> interrupts.
>
> Reported-by: Nalla, Ravikanth <ravikanth.nalla@hpe.com>
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  drivers/acpi/pci_link.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
> index fa28635..14fe3ca 100644
> --- a/drivers/acpi/pci_link.c
> +++ b/drivers/acpi/pci_link.c
> @@ -47,6 +47,7 @@ ACPI_MODULE_NAME("pci_link");
>  #define ACPI_PCI_LINK_FILE_INFO                "info"
>  #define ACPI_PCI_LINK_FILE_STATUS      "state"
>  #define ACPI_PCI_LINK_MAX_POSSIBLE     16
> +#define ACPI_PCI_LINK_MAX_EARLY_IRQINFO 1024

Why do we need so many of them?

>
>  static int acpi_pci_link_add(struct acpi_device *device,
>                              const struct acpi_device_id *not_used);
> @@ -473,6 +474,8 @@ struct irq_penalty_info {
>  };
>
>  static LIST_HEAD(acpi_irq_penalty_list);
> +static struct irq_penalty_info early_irq_infos[ACPI_PCI_LINK_MAX_EARLY_IRQINFO];
> +static int early_irq_info_counter;
>
>  static int acpi_irq_get_penalty(int irq)
>  {
> @@ -507,10 +510,17 @@ static int acpi_irq_set_penalty(int irq, int new_penalty)
>                 }
>         }
>
> -       /* nope, let's allocate a slot for this IRQ */
> -       irq_info = kzalloc(sizeof(*irq_info), GFP_KERNEL);
> -       if (!irq_info)
> -               return -ENOMEM;
> +       if (!acpi_gbl_permanent_mmap) {
> +               if (early_irq_info_counter < ARRAY_SIZE(early_irq_infos))
> +                       irq_info = &early_irq_infos[early_irq_info_counter++];
> +               else
> +                       return -ENOMEM;
> +       } else {
> +               /* nope, let's allocate a slot for this IRQ */
> +               irq_info = kzalloc(sizeof(*irq_info), GFP_KERNEL);
> +               if (!irq_info)
> +                       return -ENOMEM;
> +       }
>
>         irq_info->irq = irq;
>         irq_info->penalty = new_penalty;
> @@ -968,3 +978,4 @@ void __init acpi_pci_link_init(void)
>         register_syscore_ops(&irqrouter_syscore_ops);
>         acpi_scan_add_handler(&pci_link_handler);
>  }
> +
> --

Bjorn, what do you think about this one?

Thanks,
Rafael
