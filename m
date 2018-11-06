Return-Path: <SRS0=wh2u=NR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDFF1C32789
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 14:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B4A620869
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 14:53:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B4A620869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388904AbeKGAT1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 6 Nov 2018 19:19:27 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34996 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388813AbeKGAT0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Nov 2018 19:19:26 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0380E80D;
        Tue,  6 Nov 2018 06:53:52 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 385283F5C0;
        Tue,  6 Nov 2018 06:53:50 -0800 (PST)
Date:   Tue, 6 Nov 2018 14:53:47 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Trent Piepho <tpiepho@impinj.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Vignesh R <vigneshr@ti.com>, Faiz Abbas <faiz_abbas@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Joao Pinto <jpinto@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>, marc.zyngier@arm.com
Subject: Re: [PATCH] PCI: dwc: Fix interrupt race in when handling MSI
Message-ID: <20181106145347.GB19060@e107981-ln.cambridge.arm.com>
References: <20181027000028.21343-1-tpiepho@impinj.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181027000028.21343-1-tpiepho@impinj.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[CC Marc]

On Sat, Oct 27, 2018 at 12:00:57AM +0000, Trent Piepho wrote:
> This reverts commit 8c934095fa2f ("PCI: dwc: Clear MSI interrupt status
> after it is handled, not before").
> 
> This is a very real race that we observed quickly after switching from
> 4.13 to 4.16.  Using a custom PCI-e endpoint and driver, I was able to
> track it to the precise race and verify the fixed behavior, as will be
> described below.
> 
> This bug was originally fixed in 2013, in commit ca1658921b63 ("PCI:
> designware: Fix missing MSI IRQs") The discussion of that commit,
> archived in patchwork [1], is informative and worth reading.
> 
> The bug was re-added in the '8c934 commit this is reverting, which
> appeared in the 4.14 kernel.
> 
> Unfortunately, Synopsys appears to consider the operation of this PCI-e
> controller secret.  They provide no publicly available docs for it nor
> allow the references manuals of SoCs using the controller to publish any
> documentation of it.
> 
> So I can not say certain this code is correctly using the controller's
> features.  However, extensive testing gives me high confidence in the
> accuracy of what is described below.
> 
> If an MSI is received by the PCI-e controller while the status register
> bit for that MSI is set, the PCI-e controller will NOT generate another
> interrupt.  In addition, it will NOT queue or otherwise mark the
> interrupt as "pending", which means it will NOT generate an interrupt
> when the status bit is unmasked.
> 
> This gives the following race scenario:
> 
> 1.  An MSI is received by, and the status bit for the MSI is set in, the
> DWC PCI-e controller.
> 2.  dw_handle_msi_irq() calls a driver's registered interrupt handler
> for the MSI received.
> 3.  At some point, the interrupt handler must decide, correctly, that
> there is no more work to do and return.
> 4.  The hardware generates a new MSI.  As the MSI's status bit is still
> set, this new MSI is ignored.
> 6.  dw_handle_msi_irq() unsets the MSI status bit.
> 
> The MSI received at point 4 will never be acted upon.  It occurred after
> the driver had finished checking the hardware status for interrupt
> conditions to act on.  Since the MSI status was masked, it does not
> generated a new IRQ, neither when it was received nor when the MSI is
> unmasked.
> 
> It seems clear there is an unsolvable race here.
> 
> After this patch, the sequence becomes as follows:
> 
> 1.  An MSI is received and the status bit for the MSI is set in the
> DWC PCI-e controller.
> 2.  dw_handle_msi_irq() clears this MSI status bit.
> 3.  dw_handle_msi_irq() calls a driver's registered interrupt handler
> for the MSI received.
> 3.  At some point, the interrupt handler must decide, correctly, that
> there is no more work to do and return.
> 4.  The hardware generates a new MSI.  This sets the MSI status bit and
> triggers another interrupt in the interrupt controller(s) above the DWC
> PCI-e controller.  As the the dwc-pcie handler is not re-entrant, it is
> not run again at this time.
> 6.  dw_handle_msi_irq() finishes.  The MSI status bit remains set.
> 7.  The IRQ is re-raised and dw_handle_msi_irq() runs again.
> 8.  dw_handle_msi_irq() invokes the MSI's registered interrupt handler
> again as the status bit was still set.

Not sure why (5) is not used in your lists, I assume because you want
to highlight the race condition with the jump from 4 to 6 (or maybe
you do not like number 5 :), just curious).

> The observant will notice that point 4 present the opportunity for the
> SoC's interrupt controller to lose the interrupt in the same manner as
> the bug in this driver.  The driver for that interrupt controller will
> be written to properly deal with this.  In some cases the hardware
> supports an EOI concept, where the 2nd IRQ is masked and internally
> queued in the hardware, to be re-raised at EOI in step 7.  In other
> cases the IRQ will be unmasked and re-raised at step 4, but the kernel
> will see the handler is INPROGRESS and not re-invoke it, and instead set
> a PENDING flag, which causes the handler to re-run at step 7.
> 
> [1] https://patchwork.kernel.org/patch/3333681/
> 
> Fixes: 8c934095fa2f ("PCI: dwc: Clear MSI interrupt status after it is handled, not before")

I have two questions:

- Commit 8c934095fa2f has been in the kernel for a year and no
  regression was reported. It was assumed to fix a problem so before
  reverting it I want to make sure we are not breaking anything else.
- Your reasoning seems correct but I would pick Marc's brain on this
  because I want to understand if what this patch does is what IRQ core
  expects it to do, especially in relation to the IRQ chaining you
  are mentioning.

Lorenzo

> Cc: stable@vger.kernel.org
> Cc: Vignesh R <vigneshr@ti.com>
> Cc: Faiz Abbas <faiz_abbas@ti.com>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> Cc: Joao Pinto <jpinto@synopsys.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Trent Piepho <tpiepho@impinj.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 29a05759a294..9a3960c95ad3 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -98,10 +98,10 @@ irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
>  			irq = irq_find_mapping(pp->irq_domain,
>  					       (i * MAX_MSI_IRQS_PER_CTRL) +
>  					       pos);
> -			generic_handle_irq(irq);
>  			dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_STATUS +
>  						(i * MSI_REG_CTRL_BLOCK_SIZE),
>  					    4, 1 << pos);
> +			generic_handle_irq(irq);
>  			pos++;
>  		}
>  	}
> -- 
> 2.14.4
> 
