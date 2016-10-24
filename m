Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1477283492-26657-4-git-send-email-okaya@codeaurora.org>
References: <1477283492-26657-1-git-send-email-okaya@codeaurora.org> <1477283492-26657-4-git-send-email-okaya@codeaurora.org>
From: Jonathan Liu <net147@gmail.com>
Date: Mon, 24 Oct 2016 15:46:45 +1100
Message-ID: <CANwerB2KywvUKAv84kvoyAV2YkqtOL9LbFOqSTLgZ=dCk-Z5xA@mail.gmail.com>
Subject: Re: [PATCH V5 3/3] ACPI: pci_link: Include PIRQ_PENALTY_PCI_USING for
 ISA IRQs
To: Sinan Kaya <okaya@codeaurora.org>
Cc: linux-acpi@vger.kernel.org, rjw@rjwysocki.net,
        Bjorn Helgaas <bhelgaas@google.com>, ravikanth.nalla@hpe.com,
        linux@rainbow-software.org, timur@codeaurora.org,
        cov@codeaurora.org, jcm@redhat.com, alex.williamson@redhat.com,
        linux-pci@vger.kernel.org, Andy Gross <agross@codeaurora.org>,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, wim@djo.tudelft.nl,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 24 October 2016 at 15:31, Sinan Kaya <okaya@codeaurora.org> wrote:
> Commit 103544d86976 ("ACPI,PCI,IRQ: reduce resource requirements")
> replaced the addition of PIRQ_PENALTY_PCI_USING in acpi_pci_link_allocate()
> with an addition in acpi_irq_pci_sharing_penalty(), but f7eca374f000
> ("ACPI,PCI,IRQ: separate ISA penalty calculation") removed the use
> of acpi_irq_pci_sharing_penalty() for ISA IRQs.
>
> Therefore, PIRQ_PENALTY_PCI_USING is missing from ISA IRQs used by
> interrupt links.  Include that penalty by adding it in the
> acpi_pci_link_allocate() path.
>
> Fixes: f7eca374f000 ("ACPI,PCI,IRQ: separate ISA penalty calculation")
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/acpi/pci_link.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
> index 74bf96e..bc3d914 100644
> --- a/drivers/acpi/pci_link.c
> +++ b/drivers/acpi/pci_link.c
> @@ -608,6 +608,10 @@ static int acpi_pci_link_allocate(struct acpi_pci_link *link)
>                             acpi_device_bid(link->device));
>                 return -ENODEV;
>         } else {
> +               if (link->irq.active < ACPI_MAX_ISA_IRQS)
> +                       acpi_isa_irq_penalty[link->irq.active] +=
> +                               PIRQ_PENALTY_PCI_USING;
> +
>                 printk(KERN_WARNING PREFIX "%s [%s] enabled at IRQ %d\n",
>                        acpi_device_name(link->device),
>                        acpi_device_bid(link->device), link->irq.active);
> --
> 1.9.1
>

This series fixes one or more network adapters not working in Linux
32-bit x86 guest running inside VirtualBox if I have 4 network
adapters enabled.
The following message no longer appears in the kernel log:
ACPI: No IRQ available for PCI Interrupt Link [LNKD]. Try pci=noacpi or acpi=off

Tested-by: Jonathan Liu <net147@gmail.com>
