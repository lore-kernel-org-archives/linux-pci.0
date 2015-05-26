Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <5564D254.6050004@redhat.com>
Date: Tue, 26 May 2015 16:06:44 -0400
From: Don Dutile <ddutile@redhat.com>
MIME-Version: 1.0
To: Alex Williamson <alex.williamson@redhat.com>,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
CC: bhelgaas@google.com, rjw@rjwysocki.net,
	linux-kernel@vger.kernel.org, lenb@kernel.org
Subject: Re: [PATCH 2/2] ACPI / PCI: Account for ARI in _PRT lookups
References: <20150526174611.31963.91186.stgit@gimli.home> <20150526175408.31963.49046.stgit@gimli.home>
In-Reply-To: <20150526175408.31963.49046.stgit@gimli.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/26/2015 01:54 PM, Alex Williamson wrote:
> The PCIe specification, rev 3.0, section 2.2.8.1, contains the
> following implementation note:
>
>      Virtual Wire Mapping for INTx Interrupts From ARI Devices
>
>      The implied Device Number for an ARI Device is 0. When ARI-aware
>      software (including BIOS and operating system) enables ARI
>      Forwarding in the Downstream Port immediately above an ARI Device
>      in order to access its Extended Functions, software must
>      comprehend that the Downstream Port will use Device Number 0 for
>      the virtual wire mappings of INTx interrupts coming from all
>      Functions of the ARI Device. If non-ARI-aware software attempts
>      to determine the virtual wire mappings for Extended Functions, it
>      can come up with incorrect mappings by examining the traditional
>      Device Number field and finding it to be non-0.
>
> We account for this in pci_swizzle_interrupt_pin(), but it looks like
> we miss it here, looking for a _PRT entry with a slot matching the
> ARI device slot number.  This can cause errors like:
>
> pcieport 0000:80:03.0: can't derive routing for PCI INT B
> sfc 0000:82:01.1: PCI INT B: no GSI
>
> pci_dev.irq is then invalid, resulting in errors for drivers that
> attempt to enable INTx on the device.  Fix by using slot 0 for ARI
> enabled devices.
>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>   drivers/acpi/pci_irq.c |    4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
> index b1def41..65e83cd 100644
> --- a/drivers/acpi/pci_irq.c
> +++ b/drivers/acpi/pci_irq.c
> @@ -163,7 +163,7 @@ static int acpi_pci_irq_check_entry(acpi_handle handle, struct pci_dev *dev,
>   {
>   	int segment = pci_domain_nr(dev->bus);
>   	int bus = dev->bus->number;
> -	int device = PCI_SLOT(dev->devfn);
> +	int device = pci_ari_enabled(dev->bus) ? 0 : PCI_SLOT(dev->devfn);
>   	struct acpi_prt_entry *entry;
>
>   	if (((prt->address >> 16) & 0xffff) != device ||
> @@ -181,7 +181,7 @@ static int acpi_pci_irq_check_entry(acpi_handle handle, struct pci_dev *dev,
>   	 */
>   	entry->id.segment = segment;
>   	entry->id.bus = bus;
> -	entry->id.device = (prt->address >> 16) & 0xFFFF;
> +	entry->id.device = PCI_SLOT(dev->devfn);
I would expect that this should be = device, not PCI_SLOT(dev->devfn),
esp if used by ACPI core, since it'll be expecting a swizzle from device 0,
per above spec.

Additionally, if you look at the beginning of this function, this check is performed:
        if (((prt->address >> 16) & 0xffff) != device ||
             prt->pin + 1 != pin)
                 return -ENODEV;

So, that implies you leave this assignment as is,
or set it to device -- six of one, half-dozen another.


>   	entry->pin = prt->pin + 1;
>
>   	do_prt_fixups(entry, prt);
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

