Return-Path: <okaya@codeaurora.org>
Return-Path: <okaya@codeaurora.org>
Subject: Re: [PATCH V2 1/3] Revert "ACPI,PCI,IRQ: reduce static IRQ array size
 to 16"
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1475615720-31047-1-git-send-email-okaya@codeaurora.org>
 <1475615720-31047-2-git-send-email-okaya@codeaurora.org>
 <20161012221357.GB15116@localhost>
 <09f93442-89c8-7b2c-467d-d29b857739ff@codeaurora.org>
 <20161013181535.GB21529@localhost>
Cc: linux-acpi@vger.kernel.org, rjw@rjwysocki.net, bhelgaas@google.com,
 ravikanth.nalla@hpe.com, linux@rainbow-software.org, timur@codeaurora.org,
 cov@codeaurora.org, jcm@redhat.com, alex.williamson@redhat.com,
 linux-pci@vger.kernel.org, agross@codeaurora.org,
 linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 wim@djo.tudelft.nl, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <498097a5-f75c-d2dd-f134-148b3fb8e1ed@codeaurora.org>
Date: Thu, 13 Oct 2016 15:36:11 -0400
MIME-Version: 1.0
In-Reply-To: <20161013181535.GB21529@localhost>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

On 10/13/2016 2:15 PM, Bjorn Helgaas wrote:
> It seems like the problem is that we removed acpi_penalize_sci_irq(),
> which told us the polarity and trigger mode.  We tried to get that
> information via irq_get_trigger_type(), but that didn't work in this
> case because we use the acpi_irq_get_penalty() path before the SCI is
> registered.
> 
> It makes sense to me to add acpi_penalize_sci_irq() back in, which is
> what patch [3/3] does.
> 
> I don't understand how *this* patch, which basically just increases
> the penalty array size from 16 to 256, helps fix the problem.  It
> seems like this patch should only matter if the SCI were some IRQ
> between 16 and 255.


I see your point. The original code supported 256 interrupts. 

The machine where we had the problem had an SCI interrupt of 11. So,
this patch does not necessarily fix anything for this machine alone.
However, to be safe; I wanted to go back to the old behavior to fix
the SCI issue for all existing platforms.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
