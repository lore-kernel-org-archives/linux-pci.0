Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH V2] acpi, pci, irq: account for early penalty assignment
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1455801582-21595-1-git-send-email-okaya@codeaurora.org>
 <20160229192420.GC3653@localhost> <56D4A53A.1070708@codeaurora.org>
 <20160229223453.GA12162@localhost> <56D5E43E.7050406@codeaurora.org>
 <20160301194340.GA19783@localhost> <56D7317F.7090500@codeaurora.org>
Cc: linux-acpi@vger.kernel.org, timur@codeaurora.org,
	cov@codeaurora.org, linux-pci@vger.kernel.org,
	ravikanth.nalla@hpe.com, lenb@kernel.org, harish.k@hpe.com,
	ashwin.reghunandanan@hpe.com, bhelgaas@google.com,
	rjw@rjwysocki.net, linux-kernel@vger.kernel.org
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <56D7ABFB.3070302@codeaurora.org>
Date: Wed, 2 Mar 2016 22:14:03 -0500
MIME-Version: 1.0
In-Reply-To: <56D7317F.7090500@codeaurora.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 3/2/2016 1:31 PM, Sinan Kaya wrote:
> I don't think there's a restriction on what the SCI IRQ can be.  But
>> there is only one SCI IRQ, so all we have to do is keep track of what
>> it is, which only requires one word.

Taking a step back here and also some inspiration from your code, why don't we
fix the actual problem instead of redesigning the whole thing?

The code failed because we didn't account for the non-ISA SCI IRQs. Below code
does this.


diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index fa28635..99d0716 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -87,6 +87,7 @@ struct acpi_pci_link {
 
 static LIST_HEAD(acpi_link_list);
 static DEFINE_MUTEX(acpi_link_lock);
+static int sci_irq, sci_irq_penalty;
 
 /* --------------------------------------------------------------------------
                             PCI Link Device Management
@@ -481,6 +482,9 @@ static int acpi_irq_get_penalty(int irq)
 	if (irq < ACPI_MAX_ISA_IRQ)
 		return acpi_irq_isa_penalty[irq];
 
+	if (irq == sci_irq)
+		return sci_penalty;
+
 	list_for_each_entry(irq_info, &acpi_irq_penalty_list, node) {
 		if (irq_info->irq == irq)
 			return irq_info->penalty;
@@ -507,6 +511,11 @@ static int acpi_irq_set_penalty(int irq, int new_penalty)
 		}
 	}
 
+	if (irq == sci_irq) {
+		sci_penalty = penalty;
+		return 0;
+	}
+
 	/* nope, let's allocate a slot for this IRQ */
 	irq_info = kzalloc(sizeof(*irq_info), GFP_KERNEL);
 	if (!irq_info)
@@ -900,6 +909,7 @@ void acpi_penalize_sci_irq(int irq, int trigger, int polarity)
 	if (irq < 0)
 		return;
 
+	sci_irq = irq;
 	if (trigger != ACPI_MADT_TRIGGER_LEVEL ||
 	    polarity != ACPI_MADT_POLARITY_ACTIVE_LOW)
 		penalty = PIRQ_PENALTY_ISA_ALWAYS; 



-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
