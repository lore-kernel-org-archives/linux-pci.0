Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:54354 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752883Ab3HLVPf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 12 Aug 2013 17:15:35 -0400
Received: by mail-ie0-f173.google.com with SMTP id k5so9106957iea.18
        for <linux-pci@vger.kernel.org>; Mon, 12 Aug 2013 14:15:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <2190379.Yl0SdRsOJp@vostro.rjw.lan>
References: <1375965314-24232-1-git-send-email-heikki.krogerus@linux.intel.com>
 <1375965314-24232-3-git-send-email-heikki.krogerus@linux.intel.com> <2190379.Yl0SdRsOJp@vostro.rjw.lan>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 12 Aug 2013 15:15:15 -0600
Message-ID: <CAErSpo5ow1=mtCDKp=3F72hVzLSo_am=puO5N3w0x1JRsztsFQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] ACPI / PCI: remove an extra check from acpi_pci_irq_enable()
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Prarit Bhargava <prarit@redhat.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 8, 2013 at 7:58 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Thursday, August 08, 2013 03:35:14 PM Heikki Krogerus wrote:
>> acpi_isa_irq_to_gsi() will check if the irq is within
>> accepted rage so there is no need to check it separately.
>>
>> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>
> Hi Bjorn,
>
> Does this look OK to you?

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

>> ---
>>  drivers/acpi/pci_irq.c | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
>> index 902ed1c..e71e7fa 100644
>> --- a/drivers/acpi/pci_irq.c
>> +++ b/drivers/acpi/pci_irq.c
>> @@ -427,9 +427,7 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
>>                       return -ENOENT;
>>               }
>>
>> -             /* Interrupt Line values above 0xF are forbidden */
>> -             if ((dev->irq <= 0xF) &&
>> -                 (acpi_isa_irq_to_gsi(dev->irq, &dev_gsi) == 0)) {
>> +             if (acpi_isa_irq_to_gsi(dev->irq, &dev_gsi) == 0) {
>>                       dev_warn(&dev->dev, "PCI INT %c: no GSI - using ISA IRQ %d\n",
>>                                pin_name(pin), dev->irq);
>>                       acpi_register_gsi(&dev->dev, dev_gsi,
>>
> --
> I speak only for myself.
> Rafael J. Wysocki, Intel Open Source Technology Center.
