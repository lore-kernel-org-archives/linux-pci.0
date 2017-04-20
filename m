Return-Path: <SRS0=TMva=34=arm.com=marc.zyngier@kernel.org>
Return-Path: <SRS0=TMva=34=arm.com=marc.zyngier@kernel.org>
Subject: Re: [RFC PATCH v0.2] PCI: Add support for tango PCIe host bridge
To: Mason <slash.tmp@free.fr>, Thomas Gleixner <tglx@linutronix.de>
References: <91db1f47-3024-9712-309a-fb4b21e42028@free.fr>
 <e5c0bace-fcbe-de3f-b76f-0fb672562e84@arm.com>
 <310db9dd-7db6-2106-2e53-f0083b2d3758@free.fr>
 <012f7fcb-eaeb-70dd-a1a9-06c213789d30@arm.com>
 <0502e180-5517-12d6-e3a1-bcea0da7e201@free.fr>
 <4edd799a-650c-0189-cd5c-e9fc18c5f8bc@arm.com>
 <30f662a6-5dab-515b-e35a-a312f3c7b509@free.fr>
 <5f81730d-fbe3-1f4c-de34-09bbfb893ee1@arm.com>
 <2b5eef4c-32f2-54f1-ca2f-f9426e68fb2c@free.fr>
 <67014006-a380-9e3b-c9af-a421052cb8e0@arm.com>
 <b59b81ea-bc1b-bff5-4a78-8a69538b0de3@free.fr>
 <bc5bf8ad-69ef-4f14-f450-e162ddb5af7c@arm.com>
 <241b130e-1fb7-ecd4-034e-eb02065ada66@free.fr>
 <37cd6172-b04e-fcad-18fc-4fbb26cc611b@arm.com>
 <87d48d57-5f9f-1b35-99da-ab39de2d3d48@free.fr>
 <2003d851-e17e-1a43-3889-ec6e79e635e3@free.fr>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>, David Laight <david.laight@aculab.com>,
 linux-pci <linux-pci@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 LKML <linux-kernel@vger.kernel.org>
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <b61614bd-10e4-25eb-95bc-fd8939d4449f@arm.com>
Date: Thu, 20 Apr 2017 10:43:11 +0100
MIME-Version: 1.0
In-Reply-To: <2003d851-e17e-1a43-3889-ec6e79e635e3@free.fr>
Content-Type: text/plain; charset=iso-8859-15
List-ID: <linux-pci.vger.kernel.org>

On 20/04/17 09:20, Mason wrote:
> On 19/04/2017 13:19, Mason wrote:
> 
>> My biggest problem is that tango_unmask() is never called.
> 
> FTR, the missing incantation was:
> Explicitly calling tango_{mask/unmask/ack} from the corresponding msi_{mask/unmask/ack}

Using irq_chip_mask_parent and co, you mean?

> Marc, I have one nagging doubt, wrt splitting MSI line selection
> and MSI enable.
> 
> tango_irq_domain_alloc : finds an available MSI 'j' to allocate
> tango_irq_domain_free : release MSI 'j'
> tango_unmask : enable MSI 'j'
> tango_mask : disable MSI 'j'
> 
> Is the following scenario guaranteed to never happen?
> 
> tango_irq_domain_alloc // alloc 0
> tango_irq_domain_free  // free 0
> tango_irq_domain_alloc // alloc 0
> tango_unmask // enable 0
> tango_unmask // enable 0 = NOP
> tango_mask   // disable 0
> 
> In this theoretical scenario, we would be left with a non-functional
> MSI 0.

I'm not sure I get the example above, and what the various alloc/free
calls have to do with anything. If you have unbalanced
enable/disable_irq, you loose. Don't do that.

	M.
-- 
Jazz is not dead. It just smells funny...
