Return-Path: <SRS0=qbZn=NX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 183CDC43441
	for <linux-pci@archiver.kernel.org>; Mon, 12 Nov 2018 16:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6C7F224E0
	for <linux-pci@archiver.kernel.org>; Mon, 12 Nov 2018 16:01:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6C7F224E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729988AbeKMBzr (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 12 Nov 2018 20:55:47 -0500
Received: from foss.arm.com ([217.140.101.70]:38846 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727976AbeKMBzr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Nov 2018 20:55:47 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9932EA78;
        Mon, 12 Nov 2018 08:01:55 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CB9333F5CF;
        Mon, 12 Nov 2018 08:01:53 -0800 (PST)
Date:   Mon, 12 Nov 2018 16:01:48 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Trent Piepho <tpiepho@impinj.com>
Cc:     "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "faiz_abbas@ti.com" <faiz_abbas@ti.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "joao.pinto@synopsys.com" <joao.pinto@synopsys.com>
Subject: Re: [PATCH] PCI: dwc: Fix interrupt race in when handling MSI
Message-ID: <20181112160148.GA26379@e107981-ln.cambridge.arm.com>
References: <20181027000028.21343-1-tpiepho@impinj.com>
 <20181106145347.GB19060@e107981-ln.cambridge.arm.com>
 <db3462e2-422c-161a-1f58-135bc4eab7eb@arm.com>
 <725afc4a-ec19-e4e6-7091-f499bfb63652@synopsys.com>
 <1541615551.30311.286.camel@impinj.com>
 <60173610-25c2-5f11-a55f-bd431199dc0c@synopsys.com>
 <1541710298.30311.349.camel@impinj.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541710298.30311.349.camel@impinj.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 08, 2018 at 08:51:38PM +0000, Trent Piepho wrote:
> On Thu, 2018-11-08 at 11:46 +0000, Gustavo Pimentel wrote:
> > On 07/11/2018 18:32, Trent Piepho wrote:
> > > On Wed, 2018-11-07 at 12:57 +0000, Gustavo Pimentel wrote:
> > > > On 06/11/2018 16:00, Marc Zyngier wrote:
> > > > > On 06/11/18 14:53, Lorenzo Pieralisi wrote:
> > > > > > On Sat, Oct 27, 2018 at 12:00:57AM +0000, Trent Piepho wrote:
> > > > > > > 
> > > > > > > This gives the following race scenario:
> > > > > > > 
> > > > > > > 1.  An MSI is received by, and the status bit for the MSI is set in, the
> > > > > > > DWC PCI-e controller.
> > > > > > > 2.  dw_handle_msi_irq() calls a driver's registered interrupt handler
> > > > > > > for the MSI received.
> > > > > > > 3.  At some point, the interrupt handler must decide, correctly, that
> > > > > > > there is no more work to do and return.
> > > > > > > 4.  The hardware generates a new MSI.  As the MSI's status bit is still
> > > > > > > set, this new MSI is ignored.
> > > > > > > 6.  dw_handle_msi_irq() unsets the MSI status bit.
> > > > > > > 
> > > > > > > The MSI received at point 4 will never be acted upon.  It occurred after
> > > > > > > the driver had finished checking the hardware status for interrupt
> > > > > > > conditions to act on.  Since the MSI status was masked, it does not
> > > > > > > generated a new IRQ, neither when it was received nor when the MSI is
> > > > > > > unmasked.
> > > > > > > 
> > > > This status register indicates whether exists or not a MSI interrupt on that
> > > > controller [0..7] to be handle.
> > > 
> > > While the status for an MSI is set, no new interrupt will be triggered
> > 
> > Yes
> > 
> > > if another identical MSI is received, correct?
> > 
> > You cannot receive another identical MSI till you acknowledge the current one
> > (This is ensured by the PCI protocol, I guess).
> 
> I don't believe this is a requirement of PCI.  We designed our hardware
> to not send another MSI until our hardware's interrupt status register
> is read, but we didn't have to do that.
> 
> > > > In theory, we should clear the interrupt flag only after the interrupt has
> > > > actually handled (which can take some time to process on the worst case scenario).
> > > 
> > > But see above, there is a race if a new MSI arrives while still masked.
> > >  I can see no possible way to solve this in software that does not
> > > involve unmasking the MSI before calling the handler.  To leave the
> > > interrupt masked while calling the handler requires the hardware to
> > > queue an interrupt that arrives while masked.  We have no docs, but the
> > > designware controller doesn't appear to do this in practice.
> > 
> > See my reply to Marc about the interrupt masking. Like you said, probably the
> > solution pass through using interrupt mask/unmask register instead of interrupt
> > enable/disable register.
> > 
> > Can you do a quick test, since you can easily reproduce the issue? Can you
> > change register offset on both functions dw_pci_bottom_mask() and
> > dw_pci_bottom_unmask()?
> > 
> > Basically exchange the PCIE_MSI_INTR0_ENABLE register by PCIE_MSI_INTR0_MASK.
> 
> Of course MSI still need to be enabled to work at all, which happens
> once when the driver using the MSI registers a handler.  Masking can be
> done via mask register after that.

I want to understand from Synopsys maintainers what's the difference
between the ENABLE and MASK registers and *why* the MSI IRQ masking is
currently implemented through the PCIE_MSI_INTR0_ENABLE register instead
of PCIE_MSI_INTR0_MASK.

I am not happy to test and see what's the difference I want to know
what's the difference as-per specifications.

I need a definitive answer on this based on HW specifications before
merging any code.

> It is not so easy for me to test on the newest kernel, as imx7d does
> not work due to yet more bugs.  I have to port a set of patches to each
> new kernel.  A set that does not shrink due to holdups like this.
> 
> I understand the new flow would look like this (assume dw controller
> MSI interrupt output signal is connected to one of the ARM GIC
> interrupt lines, there could be different or more controllers above the
> dwc of course (but usually aren't)):
> 
> 1. MSI arrives, status bit is set in dwc, interrupt raised to GIC.
> 2. dwc handler runs
> 3. dwc handler sees status bit is set for a(n) MSI(s)
> 4. dwc handler sets mask for those MSIs
> 5. dwc handler clears status bit
> 6. dwc handler runs driver handler for the received MSI
> 7. ** an new MSI arrives, racing with 6 **
> 8. status bit becomes set again, but no interrupt is raised due to mask
> 9. dwc handler unmasks MSI, which raises the interrupt to GIC because
> of new MSI received in 7.
> 10. The original GIC interrupt is EOI'ed.
> 11. The interrupt for the dwc is re-raised by the GIC due to 9, and we
> go back to 2.
> 
> It is very important that 5 be done before 6.  Less so 4 before 5, but
> reversing the order there would allow re-raising even if the 2nd MSI
> arrived before the driver handler ran, which is not necessary.
> 
> I do not see a race in this design and it appears correct to me.  But,
> I also do not think there is any immediate improvement due to extra
> steps of masking and unmasking the MSI.
> 
> The reason is that the GIC interrupt above the dwc is non-reentrant. 
> It remains masked (aka active[1]) during this entire process (1 to 10).
>  This means every MSI is effectively already masked.  So masking the
> active MSI(s) a 2nd time gains nothing besides preventing some extra
> edges for a masked interrupt going to the ARM GIC.
> 
> In theory, if the GIC interrupt handler was reentrant, then on receipt
> of a new MSI we could re-enter the dwc handler on a different CPU and
> run the new MSI (a different MSI!) at the same time as the original MSI
> handler is still running.
> 
> There difference here is that by unmasking in the interrupt in the GIC
> before the dwc handler is finished, masking an individual MSI in the
> dwc is no longer a 2nd redundant masking.

There is not (and there must not be) anything in DWC HW that allows
us assume its "interrupt controller" is cascaded to a GIC. It may
correspond to what we are debugging but it is an assumption we must not
make and its driver has to work regardless of what its interrupt
controller is connected to, that's the basis of hierarchical IRQ chips
management, at least from my narrow and (most likely) incomplete
knowledge of the IRQ subsystem.

So, this means that both the masking AND your revert must be
merged in the mainline to make sure we are fixing MSI handling
for good, that's how I sum up your report.

Pending my request above, I am inclined to merge your revert but I would
appreciate testing (tags) from all DWC host bridge maintainers (I am
happy to delay it till -rc3 or -rc4 to that extent), do not take this as
a lack of trust in your testing, it is just that the last thing we want
is asking for reverting the revert given that it is going to stable
kernels and most of all we have to make sure this works for all DWC
derived host bridges.

I *also* expect the patch implementing the MSI masking and I think that
falls within Gustavo's remit.

Thanks,
Lorenzo
