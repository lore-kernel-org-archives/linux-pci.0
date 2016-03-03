Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH V2] acpi, pci, irq: account for early penalty assignment
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1455801582-21595-1-git-send-email-okaya@codeaurora.org>
 <20160229192420.GC3653@localhost> <56D4A53A.1070708@codeaurora.org>
 <20160229223453.GA12162@localhost> <56D5E43E.7050406@codeaurora.org>
 <20160301194340.GA19783@localhost> <56D7317F.7090500@codeaurora.org>
 <56D7ABFB.3070302@codeaurora.org>
Cc: linux-acpi@vger.kernel.org, timur@codeaurora.org,
	cov@codeaurora.org, linux-pci@vger.kernel.org,
	ravikanth.nalla@hpe.com, lenb@kernel.org, harish.k@hpe.com,
	ashwin.reghunandanan@hpe.com, bhelgaas@google.com,
	rjw@rjwysocki.net, linux-kernel@vger.kernel.org
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <56D84EA9.3080900@codeaurora.org>
Date: Thu, 3 Mar 2016 09:48:09 -0500
MIME-Version: 1.0
In-Reply-To: <56D7ABFB.3070302@codeaurora.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Taking another stab at it.

On 3/2/2016 10:14 PM, Sinan Kaya wrote:
> Taking a step back here and also some inspiration from your code, why don't we
> fix the actual problem instead of redesigning the whole thing?

I read your email multiple times. I think you want to move the x86 specific pieces
(ISA interrupts and its command line arguments) out of the drivers\acpi\pci_link.c.
Is this right?

- the legacy ISA IRQs, i.e., the contents of acpi_irq_isa_penalty[]
- acpi_irq_isa= from command line

 int pcibios_irq_penalty(int irq)
  {
    if (irq >= ACPI_MAX_ISA_IRQ)
      return 0;

    return acpi_irq_isa_penalty[irq] + acpi_irq_cmd_line_penalty[irq];
  }


-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
