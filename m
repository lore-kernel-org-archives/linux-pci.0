Return-Path: <SRS0=Y20I=45=free.fr=slash.tmp@kernel.org>
Return-Path: <SRS0=Y20I=45=free.fr=slash.tmp@kernel.org>
Subject: Re: [PATCH v4 1/2] PCI: Add tango MSI controller support
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>,
 Marc Zyngier <marc.zyngier@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Jiang Liu <jiang.liu@linux.intel.com>, Robin Murphy <robin.murphy@arm.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>, David Laight <david.laight@aculab.com>,
 linux-pci <linux-pci@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 Phuong Nguyen <phuong_nguyen@sigmadesigns.com>,
 LKML <linux-kernel@vger.kernel.org>
References: <d054300a-5891-0a25-8726-2be6b1beff6c@sigmadesigns.com>
 <1f6b50c7-4887-838e-8c7d-c014d82b6d8e@sigmadesigns.com>
 <8e56647d-3b2d-9bfc-b59e-79a2efaa7826@sigmadesigns.com>
 <20170523170319.GB24431@bhelgaas-glaptop.roam.corp.google.com>
From: Mason <slash.tmp@free.fr>
Message-ID: <b6541fd2-200f-35be-208e-931bb0b5ba49@free.fr>
Date: Tue, 23 May 2017 19:54:37 +0200
MIME-Version: 1.0
In-Reply-To: <20170523170319.GB24431@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-pci.vger.kernel.org>

On 23/05/2017 19:03, Bjorn Helgaas wrote:
> On Wed, May 17, 2017 at 04:56:08PM +0200, Marc Gonzalez wrote:
>> On 20/04/2017 16:28, Marc Gonzalez wrote:
>>
>>> +static int tango_set_affinity(struct irq_data *data,
>>> +		const struct cpumask *mask, bool force)
>>> +{
>>> +	return -EINVAL;
>>> +}
>>> +
>>> +static struct irq_chip tango_chip = {
>>> +	.irq_ack		= tango_ack,
>>> +	.irq_mask		= tango_mask,
>>> +	.irq_unmask		= tango_unmask,
>>> +	.irq_set_affinity	= tango_set_affinity,
>>> +	.irq_compose_msi_msg	= tango_compose_msi_msg,
>>> +};
>>
>> Hmmm... I'm wondering why .irq_set_affinity is required.
>>
>> static int setup_affinity(struct irq_desc *desc, struct cpumask *mask)
>> first calls __irq_can_set_affinity() to check whether
>> desc->irq_data.chip->irq_set_affinity) exists.
>>
>> then calls irq_do_set_affinity(&desc->irq_data, mask, false);
>> which calls chip->irq_set_affinity(data, mask, force);
>> = msi_domain_set_affinity()
>> which calls parent->chip->irq_set_affinity() unconditionally.
>>
>> Would it make sense to test that the callback is implemented
>> before calling it?
>>
>>
>> [    0.723895] Unable to handle kernel NULL pointer dereference at virtual address 00000000
> 
> I'm not sure what you're asking.
> 
> Is this a bug report for the v4 tango driver?

No.

> Or are you asking whether msi_domain_set_affinity() should be changed
> to check whether parent->chip->irq_set_affinity is implemented?

Yes. The way things are implemented now, drivers are forced
to define an irq_set_affinity callback, even if it just returns
an error, otherwise, the kernel crashes, because of the
unconditional function pointer deref. 

> msi_domain_set_affinity() has called parent->chip->irq_set_affinity()
> without checking since it was added in 2014 by f3cf8bb0d6c3 ("genirq: Add
> generic msi irq domain support"), so if there's a problem here, it's most
> likely in the tango code.

The issue is having to define an "empty" function.
(Unnecessary code bloat and maintenance.)

I'll send a patch illustrating exactly what I intended.

Regards.
