Return-Path: <SRS0=jrP7=5F=free.fr=slash.tmp@kernel.org>
Return-Path: <SRS0=jrP7=5F=free.fr=slash.tmp@kernel.org>
Subject: Re: [PATCH v4 1/2] PCI: Add tango MSI controller support
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>, Robin Murphy <robin.murphy@arm.com>,
 Marc Gonzalez <marc_gonzalez@sigmadesigns.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>, David Laight <david.laight@aculab.com>,
 linux-pci <linux-pci@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <d054300a-5891-0a25-8726-2be6b1beff6c@sigmadesigns.com>
 <1f6b50c7-4887-838e-8c7d-c014d82b6d8e@sigmadesigns.com>
 <8e56647d-3b2d-9bfc-b59e-79a2efaa7826@sigmadesigns.com>
 <20170523170319.GB24431@bhelgaas-glaptop.roam.corp.google.com>
 <b6541fd2-200f-35be-208e-931bb0b5ba49@free.fr>
 <ef36137c-f0d1-23b9-8b91-a6ed87239578@arm.com>
 <aec89b9a-8377-ff39-547c-9e6eaf254fab@free.fr>
 <f1a57255-be75-e8c4-6b8d-0254f4365d61@arm.com>
 <c78b1e79-59e5-0097-989e-1f1e8cd93fc4@arm.com>
 <b10a211d-1f4a-1cc1-7139-9b48a90dd1c6@free.fr>
 <20170531173414.GB4496@bhelgaas-glaptop.roam.corp.google.com>
From: Mason <slash.tmp@free.fr>
Message-ID: <4885137f-7c1c-5742-4f66-f48c32ce7abb@free.fr>
Date: Wed, 31 May 2017 20:49:04 +0200
MIME-Version: 1.0
In-Reply-To: <20170531173414.GB4496@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-pci.vger.kernel.org>

On 31/05/2017 19:34, Bjorn Helgaas wrote:
> On Wed, May 31, 2017 at 04:18:44PM +0200, Mason wrote:
>
>> For the record, below is the patch I had in mind:
>>
>> diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
>> index 8a3e872798f3..edfc95575a37 100644
>> --- a/kernel/irq/msi.c
>> +++ b/kernel/irq/msi.c
>> @@ -91,9 +91,11 @@ int msi_domain_set_affinity(struct irq_data *irq_data,
>>  {
>>         struct irq_data *parent = irq_data->parent_data;
>>         struct msi_msg msg;
>> -       int ret;
>> +       int ret = -EINVAL;
>> +
>> +       if (parent->chip->irq_set_affinity)
>> +               ret = parent->chip->irq_set_affinity(parent, mask, force);
>>  
>> -       ret = parent->chip->irq_set_affinity(parent, mask, force);
>>         if (ret >= 0 && ret != IRQ_SET_MASK_OK_DONE) {
>>                 BUG_ON(irq_chip_compose_msi_msg(irq_data, &msg));
>>                 irq_chip_write_msi_msg(irq_data, &msg);
>>
>>
>>
>> Then, it would be safe to remove "do-nothing" .irq_set_affinity
>> callbacks in drivers/pci/host
> 
> I assume it's obvious that nobody else is going to take this and run
> with it, so nothing will happen with this unless you finish it up by
> doing the cleanup (removing the "do-nothing" callbacks) and adding a
> changelog and signed-off-by.

Smirk.

> This would be more an IRQ patch than a PCI patch, but if I were
> reviewing it, I would look for assurance that *all* the no-op
> .irq_set_affinity callbacks were cleaned up, not just those in
> drivers/pci/host.

Are you saying the patch is *wrong* if not all "do-nothing"
callbacks are cleaned up?

Regards.
