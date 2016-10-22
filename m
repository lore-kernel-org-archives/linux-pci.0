Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:48960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935509AbcJVO5j (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 22 Oct 2016 10:57:39 -0400
Date: Sat, 22 Oct 2016 09:57:33 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: linux-acpi@vger.kernel.org, rjw@rjwysocki.net, bhelgaas@google.com,
        ravikanth.nalla@hpe.com, linux@rainbow-software.org,
        timur@codeaurora.org, cov@codeaurora.org, jcm@redhat.com,
        alex.williamson@redhat.com, Len Brown <len.brown@intel.com>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
        agross@codeaurora.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        linux-arm-msm@vger.kernel.org, wim@djo.tudelft.nl,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V4 2/3] Revert "ACPI,PCI,IRQ: remove SCI penalize
 function"
Message-ID: <20161022145733.GI9007@localhost>
References: <1476915664-27231-1-git-send-email-okaya@codeaurora.org>
 <1476915664-27231-3-git-send-email-okaya@codeaurora.org>
 <20161021015814.GC31044@localhost>
 <20161021144535.GB877@localhost>
 <2a824792-486a-6251-4931-c5cc6fd67978@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2a824792-486a-6251-4931-c5cc6fd67978@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 21, 2016 at 09:13:06AM -0700, Sinan Kaya wrote:
> On 10/21/2016 7:45 AM, Bjorn Helgaas wrote:
> > [1] http://marc.info/?l=linux-acpi&m=145580159209240&w=2)
> > 
> >> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > Wait a minute, I still have a question here: what about other ACPI
> > arches (ia64, arm64)?  Don't they need to call acpi_penalize_sci_irq()
> > somewhere?
> > 
> 
> ACPI ARM64 architecture implements reduced ACPI profile which doesn't
> have GED object. Instead, ARM64 architecture uses onchip peripherals
> for similar functionality. If there is a need to signal interrupts,
> this is done by ACPI Notify in ASL or if absolutely needed using
> ACPI Generic Event Device (GED).

OK.  I guess ia64 never did call acpi_penalize_sci_irq(), so while it
could be added someday to unify things, we don't need to add it now.
Same for arm64.

So I'd like it if you updated the changelog, but I'm OK with the
patch:

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
