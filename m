Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: 4.7 regression: ACPI: No IRQ available for PCI Interrupt Link
 [LNKD]. Try pci=noacpi or acpi=off
To: "Rafael J. Wysocki" <rafael@kernel.org>
References: <201609251512.05657.linux@rainbow-software.org>
 <201609300844.24325.linux@rainbow-software.org>
 <677698369b23f5a6bcf3a66fed78802f@codeaurora.org>
 <201609301756.25894.linux@rainbow-software.org>
 <94aee80e-f7c3-5732-ef1e-08e3ecb19e5e@codeaurora.org>
 <CAJZ5v0jr=KEfjo3HH6M2WhPCPCB9w1DYGB_VHhXDJXwjh76Pmg@mail.gmail.com>
Cc: Ondrej Zary <linux@rainbow-software.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>, wim@djo.tudelft.nl,
        ravikanth.nalla@hpe.com
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <5ee9b263-ed42-ee16-057e-2f4c1d2c1dc6@codeaurora.org>
Date: Fri, 30 Sep 2016 16:24:38 -0400
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0jr=KEfjo3HH6M2WhPCPCB9w1DYGB_VHhXDJXwjh76Pmg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 9/30/2016 3:39 PM, Rafael J. Wysocki wrote:
>> how do we feel about increasing the ISA IRQ range to 256 so that
>> > we are safe for all SCI interrupts?
> I'm not sure how this is related to the problem at hand.  Care to elaborate?
> 

Sure, let me explain. 

The code maintains a static array per IRQ number (acpi_irq_penalty) to assign 
penalties for each IRQ so that during the Link Object allocation, the code 
tries to choose an IRQ with less penalty that has not been used by another 
PCI/IRQ if possible.

In the kernels prior to my change, the type of the SCI
interrupt is given to the ACPI PCI Link driver via this function.

+void acpi_penalize_sci_irq(int irq, int trigger, int polarity)
+{
+	if (irq >= 0 && irq < ARRAY_SIZE(acpi_irq_penalty)) {
+		if (trigger != ACPI_MADT_TRIGGER_LEVEL ||
+		    polarity != ACPI_MADT_POLARITY_ACTIVE_LOW)
+			acpi_irq_penalty[irq] += PIRQ_PENALTY_ISA_ALWAYS;
+		else
+			acpi_irq_penalty[irq] += PIRQ_PENALTY_PCI_USING;
+	}
+}

This function says given the trigger and polarity, if it is ACTIVE_LOW and LEVEL
then increment the penalty by PCI_USING. It also does some ACPI parameter 
checking and assigns ISA_ALWAYS if the parameters are not compatible so that
this IRQ is never used for PCI. ISA_AKWAYS is the maximum penalty that can 
be assigned.

> And why exactly was that race condition not present before your changes?
The size of acpi_irq_penalty array used to be 256. This number puts an 
artificial limit on the IRQ numbers that can be assigned to PCI. ACPI spec does
not put any limits on the PCI numbers and extended IRQ resources can be used
for this purpose. 

During my patch, three things happened:
1. acpi_irq_penalty got renamed to acpi_isa_irq_penalty and the array size was 
reduced to 16 from 256.
2. Since we have no idea about the range of PCI interrupts that can be assigned
through ACPI, we tried to refactor the code so that PCI interrupts are calculated
by the time API is called by walking the PCI Link list here.

static int acpi_irq_pci_sharing_penalty(int irq)

We don't have to preallocate a fixed size array this way and can support any PCI
numbers that we want.

While refactoring the code, we said we could take the next step and get rid of the
acpi_penalize_sci_irq function and calculate the penalty dynamically similar to
acpi_irq_pci_sharing_penalty function. 

The new way to determine if SCI interrupt parameters are compatible is as follows:

	/*
	* Penalize IRQ used by ACPI SCI. If ACPI SCI pin attributes conflict
	* with PCI IRQ attributes, mark ACPI SCI as ISA_ALWAYS so it won't be
	* use for PCI IRQs.
	*/
	if (irq == acpi_gbl_FADT.sci_interrupt) {
		u32 type = irq_get_trigger_type(irq) & IRQ_TYPE_SENSE_MASK;

		if (type != IRQ_TYPE_LEVEL_LOW)
			penalty += PIRQ_PENALTY_ISA_ALWAYS;
		else
			penalty += PIRQ_PENALTY_PCI_USING;
	}
  
This relies on irq_get_trigger_type function to return the correct type. 

I now remember that Bjorn indicated the race condition possibility in this thread
here.

https://lkml.org/lkml/2016/3/8/640

> > > This looks racy, because we test irq_get_trigger_type() without any
> > > kind of locking, and later acpi_register_gsi() calls
> > > irq_create_fwspec_mapping(), which looks like it sets the new trigger
> > > type.  But I don't know how to fix that.
> > 
> > Right, if that pci link allocation code can be executed concurrent, then you
> > might end up with problem, but isn't that a problem even without
> > irq_get_trigger_type()?

> Yes.  It's not a new problem, I just noticed it since we're thinking
> more about the details of what's happening here.

and this is exactly what we have hit in this thread. The value
irq_get_trigger_type(irq) returns does not match what was given with
acpi_penalize_sci_irq and we end up penalizing the PCI IRQ for no reason.

Since the issue is specific to SCI interrupts and SCI interrupts cannot be 
greater than 256, my proposal is 
1. restore the code for the SCI penalty like in my last email 
2. increase the array size back to 256
3. use the acpi_irq_pci_sharing_penalty only if IRQ number is greater than 256
and we know that IRQ numbers are not bounded and can go all the way up to
65535.

I hope it makes sense now. I tend to skip details sometimes. Feel free to
send more questions.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
