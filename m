Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753251AbdK0SDe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Nov 2017 13:03:34 -0500
Date: Mon, 27 Nov 2017 12:03:32 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/2] powerpc/pci: convert to use for_each_pci_bridge()
 helper
Message-ID: <20171127180332.GA11228@bhelgaas-glaptop.roam.corp.google.com>
References: <20171110175230.82522-1-andriy.shevchenko@linux.intel.com>
 <20171122201259.GA21158@bhelgaas-glaptop.roam.corp.google.com>
 <87zi7d17ql.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87zi7d17ql.fsf@concordia.ellerman.id.au>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Nov 23, 2017 at 11:48:18PM +1100, Michael Ellerman wrote:
> Bjorn Helgaas <helgaas@kernel.org> writes:
> 
> > On Fri, Nov 10, 2017 at 07:52:29PM +0200, Andy Shevchenko wrote:
> >> ...which makes code slightly cleaner.
> >> 
> >> Requires: d43f59ce6c50 ("PCI: Add for_each_pci_bridge() helper")
> >
> > Requires: 24a0c654d7d6 ("PCI: Add for_each_pci_bridge() helper")
> >
> > (My fault, I rebased that commit before sending it to Linus.)
> >
> >> Acked-by: Michael Ellerman <mpe@ellerman.id.au>
> >
> > These don't depend on anything in the PCI core, so they could go
> > either via my tree or the powerpc tree.  Since you acked this,
> > Michael, I corrected the SHA1 above and put these both on my pci/misc
> > branch.
> 
> Thanks. That's aiming for 4.16 I assume?

Right.
