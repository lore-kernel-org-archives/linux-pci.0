Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: 4.7 regression: ACPI: No IRQ available for PCI Interrupt Link
 [LNKD]. Try pci=noacpi or acpi=off
To: Ondrej Zary <linux@rainbow-software.org>
References: <201609251512.05657.linux@rainbow-software.org>
 <201609291110.50176.linux@rainbow-software.org>
 <131b4220b509ed95dfbb35a441ccbc2c@codeaurora.org>
 <201609291549.07784.linux@rainbow-software.org>
 <e90fb01a-77e3-a094-9631-0b703972c750@codeaurora.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        wim@djo.tudelft.nl, ravikanth.nalla@hpe.com
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <5f6956d8-c752-41ea-8ec3-9e49f128eba4@codeaurora.org>
Date: Thu, 29 Sep 2016 10:35:13 -0400
MIME-Version: 1.0
In-Reply-To: <e90fb01a-77e3-a094-9631-0b703972c750@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 9/29/2016 10:28 AM, Sinan Kaya wrote:
> +		if (irq < ACPI_MAX_ISA_IRQS)

BTW, can you change this line to

	if (link->irq.active < ACPI_MAX_ISA_IRQS)

after applying.

> +			acpi_isa_irq_penalty[link->irq.active] +=
> +				PIRQ_PENALTY_PCI_USING;

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
