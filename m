Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from 8bytes.org ([85.214.48.195]:35005 "EHLO mail.8bytes.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757714Ab3FTNdQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 20 Jun 2013 09:33:16 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.8bytes.org (Postfix) with SMTP id 4B8D512B0EE
	for <linux-pci@vger.kernel.org>; Thu, 20 Jun 2013 15:33:15 +0200 (CEST)
Date: Thu, 20 Jun 2013 15:33:14 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Masked MSIs expectations
Message-ID: <20130620133314.GR2575@8bytes.org>
References: <1368086982.25488.165.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1368086982.25488.165.camel@pasglop>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

(In case this topic is still relevant)

On Thu, May 09, 2013 at 06:09:42PM +1000, Benjamin Herrenschmidt wrote:
> Do we provide drivers any guarantee to what happen if an MSI is shot
> while masked with disable_irq() or while not yet request_irq()'ed ?
> 
> Do we guarantee delivery (latched while masked), non-delivery, or
> undefined ?

I am not aware of any guarantees the kernel gives in this situation. I
think it would just drop the IRQ and print a "nobody cared" message.

> I'm bringing up a piece of HW where if it happened, it won't be
> automatically sent to the CPU and can block further MSIs unless I
> explicitly either ditch it or force a resend when unmasking (at the PCI
> Express controller PIC level).
> 
> I'm tempted to just ditch anything that happened while masked, it would
> make everything easier on my side, but maybe drivers have different
> expectations (and of course an LSI would still shoot, that's not an
> issue, only MSIs are in question here).
> 
> I have cases of devices continuing to shoot one or two MSIs after kexec
> and before the new kernel takes over, causing a "loss" of any subsequent
> one unless I deal with that case one way or another.

I would also just ditch such IRQs that happen in that kexec case and
make sure that they will work again when the kexec-kernel device driver
wants to initialize them.


	Joerg


