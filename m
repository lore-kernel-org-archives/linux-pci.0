Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:36070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752456AbcLLQCD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Dec 2016 11:02:03 -0500
Date: Mon, 12 Dec 2016 10:01:55 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>, x86@kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] x86/platform/intel-mid: Constify mid_pci_platform_pm
Message-ID: <20161212160155.GA29792@bhelgaas-glaptop.roam.corp.google.com>
References: <ba07572b4c4fad1f60593454693a58137f518896.1480859081.git.lukas@wunner.de>
 <20161207225315.GI22129@bhelgaas-glaptop.roam.corp.google.com>
 <20161212072733.GA23597@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20161212072733.GA23597@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Dec 12, 2016 at 08:27:33AM +0100, Ingo Molnar wrote:
> 
> * Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
> > On Sun, Dec 04, 2016 at 03:35:55PM +0100, Lukas Wunner wrote:
> > > This struct never needs to be modified.  The size of pci-mid.o ELF
> > > sections changes thusly:
> > > 
> > > -.data          56
> > > +.data           0
> > > -.rodata        32
> > > +.rodata        88
> > > 
> > > Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > > Signed-off-by: Lukas Wunner <lukas@wunner.de>
> > 
> > Ingo, do you want this, since you've taken the previous updates?
> > 
> > It's trivial but doesn't apply cleanly to my tree, which makes me think
> > it might be based on other changes I don't have.
> 
> It applies to upstream v4.9 cleanly, so I guess it's due to other changes you have 
> in your tree?
> 
> Could you take it? Me having dabbled in drivers/pci/ is more of an outlier.

Applied to pci/pm for v4.10.

It didn't apply cleanly to v4.9-rc1, which is what my v4.10 branches
are based on.  It applies cleanly on e8a6123e9ead
("x86/platform/intel-mid: Retrofit pci_platform_pm_ops ->get_state
hook"), which was not in v4.9-rc1 but was merged via
x86-urgent-for-linus (8528d662489a).

I can't remember why we decided to put pci-mid.c in drivers/pci.  The
obviously reason is that it uses pci_platform_pm_ops, which isn't
visible outside drivers/pci, but pci-mid.c is clearly platform-
specific, and even the name "pci_platform_pm_ops" sounds like
something that should be implemented in the arch directories, so maybe
pci_platform_pm_ops should be moved to include/linux/pci.h.

I have strange sense of déjà vu writing this, so sorry if I'm
repeating something.

Bjorn
