Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:40226 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751407AbcCCPK5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 3 Mar 2016 10:10:57 -0500
Date: Thu, 3 Mar 2016 09:10:48 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: linux-acpi@vger.kernel.org, timur@codeaurora.org,
	cov@codeaurora.org, linux-pci@vger.kernel.org,
	ravikanth.nalla@hpe.com, lenb@kernel.org, harish.k@hpe.com,
	ashwin.reghunandanan@hpe.com, bhelgaas@google.com,
	rjw@rjwysocki.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] acpi, pci, irq: account for early penalty assignment
Message-ID: <20160303151048.GA3290@localhost>
References: <1455801582-21595-1-git-send-email-okaya@codeaurora.org>
 <20160229192420.GC3653@localhost>
 <56D4A53A.1070708@codeaurora.org>
 <20160229223453.GA12162@localhost>
 <56D5E43E.7050406@codeaurora.org>
 <20160301194340.GA19783@localhost>
 <56D7317F.7090500@codeaurora.org>
 <56D7ABFB.3070302@codeaurora.org>
 <56D84EA9.3080900@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56D84EA9.3080900@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 03, 2016 at 09:48:09AM -0500, Sinan Kaya wrote:
> Taking another stab at it.
> 
> On 3/2/2016 10:14 PM, Sinan Kaya wrote:
> > Taking a step back here and also some inspiration from your code, why don't we
> > fix the actual problem instead of redesigning the whole thing?
> 
> I read your email multiple times. I think you want to move the x86 specific pieces
> (ISA interrupts and its command line arguments) out of the drivers\acpi\pci_link.c.
> Is this right?

That was my idea, but your minimal patch from last night looks awfully
attractive, and maybe it's not worth moving it to arch/x86.  I do think we
could simplify the code significantly by getting rid of the kzalloc and
acpi_irq_penalty_list from acpi_irq_set_penalty().  How about pushing on
that a little bit first, and see what it looks like then?

> - the legacy ISA IRQs, i.e., the contents of acpi_irq_isa_penalty[]
> - acpi_irq_isa= from command line
> 
>  int pcibios_irq_penalty(int irq)
>   {
>     if (irq >= ACPI_MAX_ISA_IRQ)
>       return 0;
> 
>     return acpi_irq_isa_penalty[irq] + acpi_irq_cmd_line_penalty[irq];
>   }
> 
> 
> -- 
> Sinan Kaya
> Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
