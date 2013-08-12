Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <14983102.aCV009CSMA@vostro.rjw.lan>
References: <1375965314-24232-1-git-send-email-heikki.krogerus@linux.intel.com>
 <1375965314-24232-2-git-send-email-heikki.krogerus@linux.intel.com> <14983102.aCV009CSMA@vostro.rjw.lan>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 12 Aug 2013 15:14:03 -0600
Message-ID: <CAErSpo6N65EOy6ieZSKN8eO09GoCFe05YOMRNMhx8RLHbqN=yw@mail.gmail.com>
Subject: Re: [PATCH 1/2] ACPI / PCI: don't allow PCI devices without irq to be enabled
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Prarit Bhargava <prarit@redhat.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 8, 2013 at 7:57 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Thursday, August 08, 2013 03:35:13 PM Heikki Krogerus wrote:
>> If there is no ACPI entry for the irq, returning error from
>> acpi_pci_enable_irq() if the irq is 0.
>>
>> Prarit Bhargava reported an issue where he noticed that his
>> Dell PowerEdge 840 has buggy BIOS that does not supply ACPI
>> entries for irq with some devices. That lead into kernel
>> generating a warning "genirq: Flags mismatch irq 0...". This
>> will fix that issue.
>>
>> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>> Tested-by: Prarit Bhargava <prarit@redhat.com>
>
> Hi Bjorn,
>
> Any objections to this?

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

>> ---
>>  drivers/acpi/pci_irq.c | 10 +++++++++-
>>  1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
>> index 41c5e1b..902ed1c 100644
>> --- a/drivers/acpi/pci_irq.c
>> +++ b/drivers/acpi/pci_irq.c
>> @@ -419,8 +419,16 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
>>        */
>>       if (gsi < 0) {
>>               u32 dev_gsi;
>> +
>> +             /* Not accepting 0 as valid PCI IRQ. */
>> +             if (!dev->irq) {
>> +                     dev_err(&dev->dev, "PCI INT %c: no IRQ\n",
>> +                             pin_name(pin));
>> +                     return -ENOENT;
>> +             }
>> +
>>               /* Interrupt Line values above 0xF are forbidden */
>> -             if (dev->irq > 0 && (dev->irq <= 0xF) &&
>> +             if ((dev->irq <= 0xF) &&
>>                   (acpi_isa_irq_to_gsi(dev->irq, &dev_gsi) == 0)) {
>>                       dev_warn(&dev->dev, "PCI INT %c: no GSI - using ISA IRQ %d\n",
>>                                pin_name(pin), dev->irq);
>>
> --
> I speak only for myself.
> Rafael J. Wysocki, Intel Open Source Technology Center.
