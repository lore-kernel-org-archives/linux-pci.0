Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750797AbdCOCzy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Mar 2017 22:55:54 -0400
Date: Tue, 14 Mar 2017 21:55:49 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Andi Kleen <ak@linux.intel.com>, bhelgaas@google.com,
        x86@kernel.org, linux-pci@vger.kernel.org, eranian@google.com,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] x86, pci: Add interface to force mmconfig
Message-ID: <20170315025549.GA13191@bhelgaas-glaptop.roam.corp.google.com>
References: <20170302232104.10136-1-andi@firstfloor.org>
 <20170302232104.10136-3-andi@firstfloor.org>
 <alpine.DEB.2.20.1703141407090.3619@nanos>
 <20170314154155.GG32070@tassilo.jf.intel.com>
 <alpine.DEB.2.20.1703141713010.3619@nanos>
 <20170314170255.GH32070@tassilo.jf.intel.com>
 <alpine.DEB.2.20.1703141849170.3619@nanos>
 <20170314194720.GD26264@bhelgaas-glaptop.roam.corp.google.com>
 <20170315022414.GC14380@two.firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170315022414.GC14380@two.firstfloor.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 14, 2017 at 07:24:14PM -0700, Andi Kleen wrote:
> > I agree that it should be fairly safe to do ECAM/MMCONFIG without
> > locking.  Can we handle the decision part by adding a "lockless" bit
> > to struct pci_ops?  Old ops don't mention that bit, so it will be
> > initialized to zero and we'll do locking as today.  ECAM/MMCONFIG ops
> > can set it and we can skip the locking.
> 
> That's what my other patch already did. 

Yes, your 1/4 patch does add the "ll_allowed" bit in struct pci_ops.

What I was wondering, but didn't explain very well, was whether
instead of setting that bit at run-time in pci_mmcfg_arch_init(), we
could set it statically in the pci_ops definition, e.g.,

  static struct pci_ops ecam_ops = {
    .lockless = 1,
    .read = ecam_read,
    .write = ecam_write,
  };

I think it would be easier to read if the lockless-ness were declared
right next to the accessors that need it (or don't need it).

But it is a little confusing with all the different paths, at least on
x86, so maybe it wouldn't be quite that simple.

Bjorn
