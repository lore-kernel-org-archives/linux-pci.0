Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:52718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751683AbdCNTrY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Mar 2017 15:47:24 -0400
Date: Tue, 14 Mar 2017 14:47:20 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andi Kleen <ak@linux.intel.com>, Andi Kleen <andi@firstfloor.org>,
        bhelgaas@google.com, x86@kernel.org, linux-pci@vger.kernel.org,
        eranian@google.com, Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] x86, pci: Add interface to force mmconfig
Message-ID: <20170314194720.GD26264@bhelgaas-glaptop.roam.corp.google.com>
References: <20170302232104.10136-1-andi@firstfloor.org>
 <20170302232104.10136-3-andi@firstfloor.org>
 <alpine.DEB.2.20.1703141407090.3619@nanos>
 <20170314154155.GG32070@tassilo.jf.intel.com>
 <alpine.DEB.2.20.1703141713010.3619@nanos>
 <20170314170255.GH32070@tassilo.jf.intel.com>
 <alpine.DEB.2.20.1703141849170.3619@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.20.1703141849170.3619@nanos>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 14, 2017 at 06:56:26PM +0100, Thomas Gleixner wrote:
> On Tue, 14 Mar 2017, Andi Kleen wrote:
> > The other option is to simply make it unconditional. That would
> > be even simpler, but it is a bit more risky. Hmm, I suppose may
> > be worth trying to find out what Windows uses. If they get away
> > with MMCONFIG everywhere we should be too.
> 
> From the PCIe spec:
> 
>  The PCI 3.0 compatible Configuration Space can be accessed using either
>  the mechanism defined in the PCI Local Bus Specification or the PCI
>  Express Enhanced Configuration Access Mechanism (ECAM) described later in
>  this section. Accesses made using either access mechanism are
>  equivalent. The PCI Express Extended Configuration Space can only be
>  accessed by using the ECAM.
> 
> The 1.0 spec has a similar wording (s/3.0/2.3).
> 
> Definitely the best way to go.

I agree that it should be fairly safe to do ECAM/MMCONFIG without
locking.  Can we handle the decision part by adding a "lockless" bit
to struct pci_ops?  Old ops don't mention that bit, so it will be
initialized to zero and we'll do locking as today.  ECAM/MMCONFIG ops
can set it and we can skip the locking.

Bjorn
