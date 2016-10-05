Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Wed, 5 Oct 2016 15:38:52 +0200 (CEST)
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
Subject: Re: [PATCH V2 3/3] Revert "ACPI,PCI,IRQ: remove SCI penalize
 function"
In-Reply-To: <1475615720-31047-4-git-send-email-okaya@codeaurora.org>
Message-ID: <alpine.DEB.2.20.1610051538310.8953@nanos>
References: <1475615720-31047-1-git-send-email-okaya@codeaurora.org> <1475615720-31047-4-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 4 Oct 2016, Sinan Kaya wrote:

> The SCI function was removed in two steps (first refactor and then remove).
> This patch does the revert in one step.
> 
> The commit 103544d86976 ("ACPI,PCI,IRQ: reduce resource requirements")
> refactored the original code so that SCI penalty is calculated dynamically
> by the time get_penalty function is called. This patch does a partial
> revert for the SCI functionality only.
> 
> The commit 9e5ed6d1fb87 ("ACPI,PCI,IRQ: remove SCI penalize function") is
> for the removal of the function. SCI penalty API was replaced by the
> runtime penalty calculation based on the value of
> acpi_gbl_FADT.sci_interrupt.
> 
> The IRQ type does not get updated at the right time for some platforms and
> results in incorrect penalty assignment for PCI IRQs as
> irq_get_trigger_type returns the wrong type.
> 
> The register_gsi function delivers the IRQ found in the ACPI table to
> the interrupt controller driver.  Penalties are calculated before a
> link object is enabled to find out which interrupt has the least number
> of users. By the time penalties are calculated, the IRQ is not registered
> yet and the API returns the wrong type.
> 
> Tested-by: Jonathan Liu <net147@gmail.com>
> Tested-by: Ondrej Zary <linux@rainbow-software.org>
> Link: https://lkml.org/lkml/2016/10/4/283
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>

Acked-by: Thomas Gleixner <tglx@linutronix.de>
