Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH 1/4] acpi,pci,irq: reduce resource requirements
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1457484079-18202-1-git-send-email-okaya@codeaurora.org>
 <20160314185251.GA19703@localhost>
Cc: linux-acpi@vger.kernel.org, timur@codeaurora.org,
	cov@codeaurora.org, linux-pci@vger.kernel.org,
	ravikanth.nalla@hpe.com, lenb@kernel.org, harish.k@hpe.com,
	ashwin.reghunandanan@hpe.com, bhelgaas@google.com,
	rjw@rjwysocki.net, linux-kernel@vger.kernel.org
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <56E7211F.3070203@codeaurora.org>
Date: Mon, 14 Mar 2016 16:37:51 -0400
MIME-Version: 1.0
In-Reply-To: <20160314185251.GA19703@localhost>
Content-Type: text/plain; charset=windows-1252
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On 3/14/2016 2:52 PM, Bjorn Helgaas wrote:
>> bool acpi_isa_irq_available(int irq)
>> > @@ -840,13 +881,6 @@ bool acpi_isa_irq_available(int irq)
>> >   */
>> >  void acpi_penalize_sci_irq(int irq, int trigger, int polarity)
>> >  {
>> > -	if (irq >= 0 && irq < ARRAY_SIZE(acpi_irq_penalty)) {
>> > -		if (trigger != ACPI_MADT_TRIGGER_LEVEL ||
>> > -		    polarity != ACPI_MADT_POLARITY_ACTIVE_LOW)
>> > -			acpi_irq_penalty[irq] += PIRQ_PENALTY_ISA_ALWAYS;
>> > -		else
>> > -			acpi_irq_penalty[irq] += PIRQ_PENALTY_PCI_USING;
>> > -	}
> I think we lost the validation of trigger mode and polarity, didn't
> we?
> 

This function gets called to inform ACPI that this is the SCI interrupt
and, trigger and polarity are their attributes.

The return value is void and the caller is not interested in what ACPI thinks
about. 

This function adjusts the SCI penalty based on correct attributes passed
(ISA_ALWAYS vs. PCI_USING).

I agree that we lost this validation. 

I can keep sci_trigger/sci_polarity somewhere and keep that into the calculation
in get function.

Like this for instance,

	if (irq == acpi_gbl_FADT.sci_interrupt) {
+		if (sci_trigger != ACPI_MADT_TRIGGER_LEVEL ||
+		    sci_polarity != ACPI_MADT_POLARITY_ACTIVE_LOW)
+			penalty += PIRQ_PENALTY_ISA_ALWAYS;
+		else
			penalty += PIRQ_PENALTY_PCI_USING; 
	}

Then, we can't get rid of the function just we can reduce the contents.

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
