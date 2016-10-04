Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Tue, 4 Oct 2016 16:23:46 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Sinan Kaya <okaya@codeaurora.org>
cc: linux-acpi@vger.kernel.org, rjw@rjwysocki.net, bhelgaas@google.com,
        ravikanth.nalla@hpe.com, linux@rainbow-software.org,
        timur@codeaurora.org, cov@codeaurora.org, jcm@redhat.com,
        alex.williamson@redhat.com, linux-pci@vger.kernel.org,
        agross@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, wim@djo.tudelft.nl,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] Revert "ACPI,PCI,IRQ: remove SCI penalize
 function"
In-Reply-To: <babdb433-2be5-2c04-cbdd-c2af443447cb@codeaurora.org>
Message-ID: <alpine.DEB.2.20.1610041621070.5049@nanos>
References: <1475343976-20744-1-git-send-email-okaya@codeaurora.org> <1475343976-20744-3-git-send-email-okaya@codeaurora.org> <alpine.DEB.2.20.1610040919110.5278@nanos> <babdb433-2be5-2c04-cbdd-c2af443447cb@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 4 Oct 2016, Sinan Kaya wrote:

> On 10/4/2016 3:23 AM, Thomas Gleixner wrote:
> > On Sat, 1 Oct 2016, Sinan Kaya wrote:
> > 
> >> This reverts commit 9e5ed6d1fb87 ("ACPI,PCI,IRQ: remove SCI penalize
> >> function"). SCI penalty API was replaced by the runtime penalty calculation
> >> based on the value of acpi_gbl_FADT.sci_interrupt.
> > 
> > This does more than only reverting said commit ....
> 
> The SCI function was removed in two steps (first refactor and then remove). 
> I was trying to do the revert at one step. I can divide into two if it makes
> it better

No one step is fine. But this wants to be documented in the changelog.

> >> acpi_gbl_FADT.sci_interrupt type does not get updated at the right time
> >> for some platforms and results in incorrect penalty assignment for PCI
> >> IRQs as irq_get_trigger_type returns the wrong type.
> > 
> > And the obvious question is: Why does irq_get_trigger_type() return the
> > wrong type?
> 
> Here is some history:
> 
> I now remember that Bjorn indicated the race condition possibility in this thread
> here.
> 
> https://lkml.org/lkml/2016/3/8/640

> My understanding is that register_gsi function delivers the IRQ found in
> the ACPI table to the interrupt controller driver.  Penalties are
> calculated before a link object is enabled to find out which interrupt
> has the least number of users. By the time penalties are calculated, the
> IRQ is not registered yet and it returns the wrong type.

Ok.

> > 
> > What's the root cause of this problem? Your changelog does not tell
> > anything.
> 
> If you are OK with the above description, I can add this to the commit message.

Yes please.
 
Thanks,

	tglx
