Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Sat, 22 Oct 2016 18:59:18 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: linux-acpi@vger.kernel.org, rjw@rjwysocki.net, bhelgaas@google.com,
        ravikanth.nalla@hpe.com, linux@rainbow-software.org,
        timur@codeaurora.org, cov@codeaurora.org, jcm@redhat.com,
        alex.williamson@redhat.com, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-pci@vger.kernel.org,
        agross@codeaurora.org, Robert Moore <robert.moore@intel.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Lv Zheng <lv.zheng@intel.com>, linux-arm-msm@vger.kernel.org,
        wim@djo.tudelft.nl, devel@acpica.org,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, Len Brown <lenb@kernel.org>
Subject: Re: [PATCH V4 3/3] Revert "ACPI, PCI, IRQ: separate ISA penalty
 calculation"
Message-ID: <20161022235918.GJ9007@localhost>
References: <1476915664-27231-1-git-send-email-okaya@codeaurora.org>
 <1476915664-27231-4-git-send-email-okaya@codeaurora.org>
 <20161021023109.GD31044@localhost>
 <8dcd59ac-815b-da71-a3f2-ba533c4182c9@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8dcd59ac-815b-da71-a3f2-ba533c4182c9@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 20, 2016 at 07:58:57PM -0700, Sinan Kaya wrote:
> On 10/20/2016 7:31 PM, Bjorn Helgaas wrote:
> ...
> > And I don't think it fixes a user-visible problem, so it doesn't need
> > to be applied immediately.  I'm not sure this is worth doing by
> > itself; maybe it should wait until we can do more cleanup and think
> > about all these issues together?
> 
> It does fix the PCI_USING penalty assignment. 
> 
>                 if (link->irq.active && link->irq.active == irq)
>                          penalty += PIRQ_PENALTY_PCI_USING;
> 
> 
> If we drop this patch, then we need
> [PATCH V3 1/3] ACPI, PCI IRQ: add PCI_USING penalty for ISA interrupts
> 
> http://www.gossamer-threads.com/lists/linux/kernel/2547605
> 
> as somebody needs to increment the penalty with PCI_USING when IRQ is assigned
> for a given ISA IRQ.
> 
> We might as well take [PATCH V4 1/3], [PATCH V4 2/3] and [PATCH V3 1/3]
> for this regression.

It sounds like either V3 1/3 or V4 3/3 will fix the regression.  The
V3 1/3 patch is much smaller and essentially makes this piece look
like it did in v4.6.

The V4 3/3 patch removes acpi_irq_penalty_init() and compensates by
using acpi_irq_pci_sharing_penalty() for ISA IRQs again.  But
acpi_irq_penalty_init() added PIRQ_PENALTY_PCI_POSSIBLE for _CRS, and
only if there was no _PRS, while acpi_irq_pci_sharing_penalty() always
adds PIRQ_PENALTY_PCI_USING for _CRS, regardless of whether _PRS
exists.

Since V4 3/3 is so much bigger and makes this quite subtle change in
how _CRS is handled, I like V3 1/3 better.

Are we all set to go now?  I think I've acked the patches you
mentioned.

Bjorn
