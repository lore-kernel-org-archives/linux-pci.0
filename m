Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:34724 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751212AbcJBLlH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 2 Oct 2016 07:41:07 -0400
MIME-Version: 1.0
In-Reply-To: <1475343976-20744-2-git-send-email-okaya@codeaurora.org>
References: <1475343976-20744-2-git-send-email-okaya@codeaurora.org>
From: Jonathan Liu <net147@gmail.com>
Date: Sun, 2 Oct 2016 22:40:36 +1100
Message-ID: <CANwerB0+yS709kZG9BkAQaqSixmyfz4As3fUs-dcZ3uun=S+5w@mail.gmail.com>
Subject: Re: [2/3] ACPI, PCI IRQ: add PCI_USING penalty for ISA interrupts
To: Sinan Kaya <okaya@codeaurora.org>
Cc: linux-acpi@vger.kernel.org, rjw@rjwysocki.net, bhelgaas@google.com,
        ravikanth.nalla@hpe.com, linux@rainbow-software.org,
        timur@codeaurora.org, cov@codeaurora.org, jcm@redhat.com,
        alex.williamson@redhat.com, linux-pci@vger.kernel.org,
        agross@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, wim@djo.tudelft.nl,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2 October 2016 at 04:46, Sinan Kaya <okaya@codeaurora.org> wrote:
> The change introduced in commit 103544d86976 ("ACPI,PCI,IRQ: reduce
> resource requirements") removed PCI_USING penalty from
> acpi_pci_link_allocate function as there is no longer a fixed size penalty
> array for both PCI and IRQ interrupts.
>
> We need to add the PCI_USING penalty for ISA interrupts too if the link is
> in use and matches our ISA IRQ number.
>
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  drivers/acpi/pci_link.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
> index f3792f4..06c2a11 100644
> --- a/drivers/acpi/pci_link.c
> +++ b/drivers/acpi/pci_link.c
> @@ -620,6 +620,10 @@ static int acpi_pci_link_allocate(struct acpi_pci_link *link)
>                             acpi_device_bid(link->device));
>                 return -ENODEV;
>         } else {
> +               if (link->irq.active < ACPI_MAX_IRQS)
> +                       acpi_irq_penalty[link->irq.active] +=
> +                               PIRQ_PENALTY_PCI_USING;
> +
>                 printk(KERN_WARNING PREFIX "%s [%s] enabled at IRQ %d\n",
>                        acpi_device_name(link->device),
>                        acpi_device_bid(link->device), link->irq.active);

This series fixes one or more network adapters in VirtualBox not
working with Linux 32-bit x86 guest if I have 4 network adapters
enabled. The following message no longer appears in the kernel log:
ACPI: No IRQ available for PCI Interrupt Link [LNKD]. Try pci=noacpi or acpi=off

Tested-by: Jonathan Liu <net147@gmail.com>
